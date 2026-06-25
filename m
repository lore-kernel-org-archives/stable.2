Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342973E120B
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390764; cv=fail; b=Q+SCcHYk6M+XNGo4agQ7wDP9qYIJDLR8Iy4ADRBRsRo6Mr0sRwTuOGsp/M5kDC5YQDAwHdfTPRWPfaihqX3+uSia+mrnT65H7slIcmtnKCoi03vjWAPb7b0HRno78gxMIw+iIkp2Iflc6D1kDuokeAigX85deBLVKTDuDVpiVbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390764; c=relaxed/simple;
	bh=j+aJ6U7KR/YDLz+Qu5qoqvhwlJe+Y6Jm4s1xKC8d+SA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikQkiVBTCmWRIMYPxuRCEFYdeIyA+N04q5iXN3puquDNWD+0Op6vC9AL50ZS/4B1EDjjO/dl+3ReyXnvobWnyonmdqx8O7Oxga6fKC+LOgPKWvDqBB0K6zaebr6k1YlzO8uQF5qB8N4dpridIBEaab6CLy5ZZ2BJJV7owqL2ejc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XL6imn6w; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XL6imn6w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HchEuRYLofYX38PVzsJdDMScRMm+Wogq7iRHG9M8g2NMaZG9+IEReKcUqqulPd4EdkU0wrRA2p7QCyaYp+OCwVm4OGOHcOw1npmZcWWjmdq3uBEg3CJu5pi4CtbLzK0sSzuh6bw9uQGX1qu6DhP26WapE1c1b3JZO2wNt08pJdZ/dJmqCQGMbS/iHg+cUejKlfUPSIWvSEOb36RDcRwoRhdefuO2qDo1CM3X81HpbaqpNTUBANSZezyry/KTDdnBnhUWd+2cEQpdEQ4YP50E4+2n5m6zMq0b4XmizcFWAOuPOoDIWpz31yVHa0p7ROMHjmM2IDwonBJPIdEjU/1INg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkbEsQkoN/kl9u143cIymWHfzk4LychwWshYzK1mOtI=;
 b=mK5bp7C9bQLUdGFqKRJlB5s8k4NMFBe8iAyeyQL6ZaJKblNtELOXK6/g61OHglMhFf5MOSvkMEGKL8PxGAL3uJoDVxTFTHuy2KiTi92Q4v//7Wa2M40OnYQLtv47x45s3ybd7oWHkbOkecuI3AOSElYLwfUvCFc30jxE7gAdQjZoppzL6FivxAUWUgvL0jOK5KSFmh3wVXnH44yfaX14tqIi7fE/scrQAsYgLAyqhlTbgHV67VmHA/PJKRIo/59rrQ2xzGZQjxRRI9bD2HlEyweI3sTj/20sT6XVnOPbmCgEKMuXtMKpiV0EfXI7Pwe+Ylz5YQlv014ZIqK7EKse6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkbEsQkoN/kl9u143cIymWHfzk4LychwWshYzK1mOtI=;
 b=XL6imn6wddbqSonW3tNN4srl/4cnxDBONHqdNC2Gqodswv/+u4nIv2bqi7+TdLlIQbsgV77Q4YJckFJuavhE6ZxWgY88T9Zo5U0iGEV07LoU9srLh6ORY4E8U2TTnC9ymwdQ62ivBdOGpAZZVzUywK0rgurKrISxCG1N6aLg2LR0LR00tDB0C90AvtjPhqWl7ZlOmgmfUywB5TtEvPWpa/yio7I/sovZHr895W1P+aY6lusJWF9frk3MtgPLhA/awRGzT88Qwyi0NOLz01514Y5fSYeyDSdsDSs9L+PoKw3KhBLYolsNS+rirEGdNlzMhVq9zTHp975+gHnVCskt8g==
Received: from SJ0PR03CA0126.namprd03.prod.outlook.com (2603:10b6:a03:33c::11)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 12:32:34 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::20) by SJ0PR03CA0126.outlook.office365.com
 (2603:10b6:a03:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Thu,
 25 Jun 2026 12:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 12:32:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 05:32:19 -0700
Received: from fedora.mtl.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 05:32:14 -0700
From: Petr Machata <petrm@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Petr Machata <petrm@nvidia.com>, <stable@vger.kernel.org>, Sasha Levin
	<sashal@kernel.org>, Wojtek Wasko <wwasko@nvidia.com>, Mahesh Bandewar
	<maheshb@google.com>, Shuah Khan <shuah@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Yong Wang <yongwang@nvidia.com>
Subject: [PATCH 5.15.y 2/2] Revert "ptp: add testptp mask test"
Date: Thu, 25 Jun 2026 14:31:52 +0200
Message-ID: <16a11dee5304bf528593441b3959ed1729e3eadf.1782385817.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <99e19551955b903936bedb1516bd2502c40f9505.1782385817.git.petrm@nvidia.com>
References: <99e19551955b903936bedb1516bd2502c40f9505.1782385817.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbe622f-1c2d-43e8-ad5d-08ded2b5d549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|18002099003|22082099003|3023799007|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Jr+7CGFva2IG6xRq/AbLPBYmfCZP456iC2uyyPN1+/H2ik7rqMrrFxnngiyD4HF6Vwn08xitsYxV5sHgkMPUAyWlA+t3CGgKtsKmtx4K3ONdjn3W5jyf/LhSdsSpxj7ATyWk3kYAy8dzrigpAlxh4Oox44aFMDiU8FKui7+HDu3crSOH30OCI+nMXryH4WcIUn/LY32aM1xl6+lHWbyAsBPMkN+XPVTbCvgUiGpglBEYWwlwhwzSZAJA8qajvPFw6O9jM4O8nvRRi9BUvQniLPDF4ZEqs+EWgERIG28rqmgLBlQRB6RECbL5Ik33BIZKapjK1Lok+PNPxA52m65YGd/RJAmhQrAXrcIflxl8DCDVEX398s9B0QhTLcwscrw9bd8ghfH8VDcdyEqxYrN+pw0rQsLnlmXac3vYLckkpvZ38ZzUnD1CnPEE0jVFNAN4QmJZq4B6k1tUWH8sRTy+ZqoLYaj7wHlMZSgcmRP/rnHu3+7m8n2apGv/R8ldy66uenVAWyeXKxYduO39vEq2j4LSSOwiFI0lg9a8ULtXqONJyZkMEkqH2at0WOrB/fwzPle74eYBspolB7RPYw+UAbooFUHlqiSnIUoLxZ2QNYG1zo1IulKXtSsyBG7QBmPo9+t66oaZlLKmFoYCD2d7H5CZEip/v+W/M6GuqT/sdwe2EJsDfTUYW3yAwF1dWULSP5k+2iGcMQBcfyr3xFcx2g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gIRtLcWZHMOlwFpEJqlE8wVl1wdaDf9D9SH2msV9wJ6QFvoQxxzmpaUbq6CHJYjRb0FQ0LItgmg4OZzb1Mh3iTsgeJhrTi2YMxcrNm1xy2yAAekmrm2/Iej9Luwa0PEAjnlDng6+xar5G+QZZptHltUULDAQPAqtf+3/gxp9BVAjkyKjM+iWes29LhLHhBxjEwM1sTQg/oBVmDQG3EVcVnTXwImr1+vkeO8Y7BwJQZFMcVKNeo89FCR/OGtGvykbH/lqHuygRN4aQKfr1Hc/jYdpsOHumMCqAqRJbv8FkGZM5+1ckBRMHZN4f8J3a7St+fMr+2q7cVYS+t+btUTja1W+yHhRBhbzyCBNAeFrTiP7dRvlu+TFmcWG4n+lqokuUGpW1uppvpYdcg+6J9xjJmpvl2FAn4ke409aK++EhPDAb2a0d7wZB58w/Xcy9MpI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:32:34.2165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbe622f-1c2d-43e8-ad5d-08ded2b5d549
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319

This reverts commit 8510559c0fa1e228b18fcf77cfbcf5b970793a8a, which is
commit 26285e689c6cd2cf3849568c83b2ebe53f467143 upstream.

The reverted commit extends the selftest to test timestamp event queue mask
manipulation in testptp. It exercises masks PTP_MASK_CLEAR_ALL and
PTP_MASK_EN_SINGLE, introduced in commit c5a445b1e934 ("ptp: support event
queue reader channel masks"), which is not on this stable branch. The test
case thus cannot be built against this tree's own UAPI headers.

The reverted commit was introduced to resolve a missing dependency of
commit bef3a83a9a67 ("testptp: Add option to open PHC in readonly mode"),
which is 76868642e427 upstream. The only conflict between the two is the
getopt string, and there is otherwise no direct dependency between the two.

This patch therefore reverts the cited commit, with hand-resolving the
getopt string to include 'r' (as introduced by c6dc458227a3), but not
'F' (introduced by c1c50689799d).

Reported-by: Yong Wang <yongwang@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    This issue exists also on 6.1 and 6.6. I'm sending
    individual reverts for these branches.
    
    Reproducer:
     # make headers_install INSTALL_HDR_PATH=$(pwd)/I
     # cd tools/testing/selftests/ptp/
     # gcc -isystem ../../../../I/include/ -D_GNU_SOURCE= testptp.c -lrt -o testptp

 tools/testing/selftests/ptp/testptp.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index d78d52f028ab..84e86898f4b4 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -121,7 +121,6 @@ static void usage(char *progname)
 		" -d name    device to open\n"
 		" -e val     read 'val' external time stamp events\n"
 		" -f val     adjust the ptp clock frequency by 'val' ppb\n"
-		" -F chan    Enable single channel mask and keep device open for debugfs verification.\n"
 		" -g         get the ptp clock time\n"
 		" -h         prints this message\n"
 		" -i val     index for event/trigger\n"
@@ -190,7 +189,6 @@ int main(int argc, char *argv[])
 	int seconds = 0;
 	int readonly = 0;
 	int settime = 0;
-	int channel = -1;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -200,7 +198,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xz"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -214,9 +212,6 @@ int main(int argc, char *argv[])
 		case 'f':
 			adjfreq = atoi(optarg);
 			break;
-		case 'F':
-			channel = atoi(optarg);
-			break;
 		case 'g':
 			gettime = 1;
 			break;
@@ -616,18 +611,6 @@ int main(int argc, char *argv[])
 		free(xts);
 	}
 
-	if (channel >= 0) {
-		if (ioctl(fd, PTP_MASK_CLEAR_ALL)) {
-			perror("PTP_MASK_CLEAR_ALL");
-		} else if (ioctl(fd, PTP_MASK_EN_SINGLE, (unsigned int *)&channel)) {
-			perror("PTP_MASK_EN_SINGLE");
-		} else {
-			printf("Channel %d exclusively enabled. Check on debugfs.\n", channel);
-			printf("Press any key to continue\n.");
-			getchar();
-		}
-	}
-
 	close(fd);
 	return 0;
 }
-- 
2.54.0

