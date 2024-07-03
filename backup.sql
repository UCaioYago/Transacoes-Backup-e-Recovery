-- MySQL dump 10.13  Distrib 8.4.0, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idClient` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(15) DEFAULT NULL,
  `Minit` varchar(3) DEFAULT NULL,
  `Lname` varchar(20) DEFAULT NULL,
  `CPF` char(11) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE KEY `unique_cpf_client` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Antony','M','Fernando','12345678987','rua armando de lavella 10, caxias - PI'),(2,'Diego','O','Vilela','98765432101','rua farias 852, Centro - ES'),(3,'Roberto','F','Antonio','45678913158','avenida alemao da silva 4856, Centro - BA');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoquelocal`
--

DROP TABLE IF EXISTS `estoquelocal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoquelocal` (
  `idLproduto` int NOT NULL,
  `idLestoque` int NOT NULL,
  `local` varchar(255) NOT NULL,
  PRIMARY KEY (`idLproduto`,`idLestoque`),
  KEY `fk_estoque_local_estoque` (`idLestoque`),
  CONSTRAINT `fk_estoque_local_estoque` FOREIGN KEY (`idLestoque`) REFERENCES `produtoestoque` (`idProdEstoque`),
  CONSTRAINT `fk_estoque_local_produto` FOREIGN KEY (`idLproduto`) REFERENCES `produto` (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoquelocal`
--

LOCK TABLES `estoquelocal` WRITE;
/*!40000 ALTER TABLE `estoquelocal` DISABLE KEYS */;
/*!40000 ALTER TABLE `estoquelocal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedor` (
  `idFornecedor` int NOT NULL AUTO_INCREMENT,
  `NomeSocial` varchar(255) NOT NULL,
  `CNPJ` char(15) NOT NULL,
  `Contato` char(11) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE KEY `unique_fornecedor` (`CNPJ`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
INSERT INTO `fornecedor` VALUES (1,'Almeida e filhos','123456789123456','21985474'),(2,'Eletrônicos Silva','854519649143457','21985484'),(3,'Eletrônicos Valma','934567893934695','21975474');
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `idPedido` int NOT NULL AUTO_INCREMENT,
  `idPedidoClient` int DEFAULT NULL,
  `PedidoStatus` enum('Cancelado','Confirmado','Em Processamento') DEFAULT 'Em Processamento',
  `PedidoDescription` varchar(255) DEFAULT NULL,
  `ShippingCost` float DEFAULT '10',
  PRIMARY KEY (`idPedido`),
  KEY `fk_pedidos_client` (`idPedidoClient`),
  CONSTRAINT `fk_pedidos_client` FOREIGN KEY (`idPedidoClient`) REFERENCES `cliente` (`idClient`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,'Em Processamento','compra via aplicativo',NULL),(2,2,'Em Processamento','compra via aplicativo',40),(3,3,'Confirmado',NULL,NULL);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `idProduto` int NOT NULL AUTO_INCREMENT,
  `Pname` varchar(15) NOT NULL,
  `Classification_kids` tinyint(1) DEFAULT '0',
  `Category` enum('Eletronico','Roupa','Brinquedos','Esportes','Comidas','Automotivos') NOT NULL,
  `Feedback` float DEFAULT '0',
  `Size` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (10,'Fone de ouvido',0,'Eletronico',4,NULL),(11,'Boneco Mario',1,'Brinquedos',3,NULL),(12,'Body Carters',1,'Roupa',5,NULL);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtoestoque`
--

DROP TABLE IF EXISTS `produtoestoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtoestoque` (
  `idProdEstoque` int NOT NULL AUTO_INCREMENT,
  `LocalEstoque` varchar(255) DEFAULT NULL,
  `Quantidade` int DEFAULT '0',
  PRIMARY KEY (`idProdEstoque`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtoestoque`
--

LOCK TABLES `produtoestoque` WRITE;
/*!40000 ALTER TABLE `produtoestoque` DISABLE KEYS */;
INSERT INTO `produtoestoque` VALUES (1,'Bahia',7000),(2,'Minas Gerais',200),(3,'São Paulo',80);
/*!40000 ALTER TABLE `produtoestoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtofornecedor`
--

DROP TABLE IF EXISTS `produtofornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtofornecedor` (
  `idPfFornecedor` int NOT NULL,
  `idPfProduto` int NOT NULL,
  `Quantidade` int NOT NULL,
  PRIMARY KEY (`idPfFornecedor`,`idPfProduto`),
  KEY `fk_produto_fornecedor_produto` (`idPfProduto`),
  CONSTRAINT `fk_produto_fornecedor_fornecedor` FOREIGN KEY (`idPfFornecedor`) REFERENCES `fornecedor` (`idFornecedor`),
  CONSTRAINT `fk_produto_fornecedor_produto` FOREIGN KEY (`idPfProduto`) REFERENCES `produto` (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtofornecedor`
--

LOCK TABLES `produtofornecedor` WRITE;
/*!40000 ALTER TABLE `produtofornecedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `produtofornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtopedido`
--

DROP TABLE IF EXISTS `produtopedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtopedido` (
  `idPPproduto` int NOT NULL,
  `idPPpedido` int NOT NULL,
  `PpQuantidade` int DEFAULT '1',
  `ppStatus` enum('Disponivel','Sem Estoque') DEFAULT 'Disponivel',
  PRIMARY KEY (`idPPproduto`,`idPPpedido`),
  KEY `fk_produtoPedido_produto` (`idPPpedido`),
  CONSTRAINT `fk_produtoPedido_produto` FOREIGN KEY (`idPPpedido`) REFERENCES `pedidos` (`idPedido`),
  CONSTRAINT `fk_produtoPedido_vendedor` FOREIGN KEY (`idPPproduto`) REFERENCES `produto` (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtopedido`
--

LOCK TABLES `produtopedido` WRITE;
/*!40000 ALTER TABLE `produtopedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `produtopedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtovendedor`
--

DROP TABLE IF EXISTS `produtovendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtovendedor` (
  `idPvendedor` int NOT NULL,
  `idPproduto` int NOT NULL,
  `ProdQuantidade` int DEFAULT '1',
  PRIMARY KEY (`idPvendedor`,`idPproduto`),
  KEY `fk_produto_produto` (`idPproduto`),
  CONSTRAINT `fk_produto_produto` FOREIGN KEY (`idPproduto`) REFERENCES `produto` (`idProduto`),
  CONSTRAINT `fk_produto_vendedor` FOREIGN KEY (`idPvendedor`) REFERENCES `vendedor` (`idVendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtovendedor`
--

LOCK TABLES `produtovendedor` WRITE;
/*!40000 ALTER TABLE `produtovendedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `produtovendedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `idVendedor` int NOT NULL AUTO_INCREMENT,
  `NomeSocial` varchar(255) NOT NULL,
  `CNPJ` char(15) DEFAULT NULL,
  `CPF` char(9) DEFAULT NULL,
  `Local` varchar(255) DEFAULT NULL,
  `Contato` char(11) NOT NULL,
  PRIMARY KEY (`idVendedor`),
  UNIQUE KEY `unique_CNPJ_vendedor` (`CNPJ`),
  UNIQUE KEY `unique_CPF_vendedor` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES (1,'TudoTech','123456789456321',NULL,'Rio de Janeiro','219946287'),(2,'Varejo da Nana',NULL,'123456783','Rio de Janeiro','219567895'),(3,'Discovery de Kids','456789123654485',NULL,'São Paulo','1198657484');
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-03 14:38:03
