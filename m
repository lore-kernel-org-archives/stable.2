Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4333E3E0730
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390706; cv=fail; b=YiBObjT8ENIlfcareI1hfBgT8jkE0vByJLNpaYePfNx1Dp8vAz9+ND9FskdzwEiyMCyjMnlQww1sCch6ttqaJiOpDDmYVTEQg3qT1IEtoEfh6A/RHIIH2U/NhrcbaPE6DtcAX9tC7AfOIWr3gQCOl7cDDtyuGPG5pG+27T7gUn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390706; c=relaxed/simple;
	bh=0VYFI2fxeEfgmrdV9huKqkvcv4fpVxVl7AXbxLbTeVo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CPvKzOgj69l889fKG246Gr5J7vMY4fUom5NzdzhN8So/ZeijLfyYfUCOA4wE3NsUM8EkfVMnMWniNaxdqXTS2YXFUT+kZgvQG0u64DoRQ4aLTYS7X4AhZtdCKLkJr6A72R5UpEV33E16ryUSQkueVcT4CWF99HlEiIDyqJRgE8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zmy41dhC; arc=fail smtp.client-ip=40.93.194.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zmy41dhC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaNQD351FmtRXFYV1QW5rRH7rRj8/VcMPV6TimrtwTXK6uqrUqWaBaSrp0ua/1fwFaI/i1L8x8PUsjOVJmhA8vpqv5QxPlAlu2/u7kG7nXJxeT8PHWBQQZuFihDbnjiViX1gxfjHQha/B3kYQLYFbOhnmAUwwm4TGFt0MT1X5/zC9Yv3PVAUtxfZDuLtSrXAjhnbFV7GzWuT8ITmqet9kihJWUNA8AD7XNUf8DXDCCBr97sjxhY9oySMELupJd5ACbZawHkl9cNj9vvWfwm2/uOBzYs0n20ySXlWrU82e5hzHWTlhQz1wvRblfMtDzcdRHIUazCakHodTvfvSj78yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiEqPtKdbap7tUnHg33JZy0dz6LGTnv3jsvyzyIy+Gk=;
 b=VEfbGuu8MYm2UVop+tpIMuRcbBfeVX//4H+LFWjxQmHbjDxxaV1R3+SODR9XOPCkSanGo0BNKM2qVcsOFs/D1pR2+JJ9I8j+SrHFew0WvSIACpmY9E9CjZ40yg0kcm2aVrsK6wM5H5AI3/dSEzYknqRm1+ydy5xAxCDIFpaFd6wKpgNFn7mVEvY2gdwFey4ppdFF5WanZSR4AAlVqZ8VrZimJdLKBSx6jmHbNFTvMozT9Sky9D2X8kmTUAt6AMlGAEDedlmgmrmQQFF3wBvx5ptyLluCsr895YLwWOGgZd0gB883oM3gFD8aF4kPwnyJMAQg9cKKQVz2Rr6n2e7vNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiEqPtKdbap7tUnHg33JZy0dz6LGTnv3jsvyzyIy+Gk=;
 b=Zmy41dhCDw5kaP1D9G0R96n9BXViDlyBWExvsMcF/1WrqXcKFYfXu1X23JRvY8T9wXNtv1p5Pd6Jjz9uLHj7s+/GodPoF1I6911GL8AEeXmrvMkmFRI0vMj95rQ1JNRSdGtBwFFSUU+3JWQxfVw38licKJoy5WC6aogZh3lvugYfgaDiMfaM27qM+Bh3Nrwhb0i2d6FSlOuR52so2I0qyyNlRNN16epwsUa4173flb3Ei5RNozrxIQkFRulZp15AHhwGgVduiNoTCVXQG0Xh3jObuSRa+If3NmGP65dMqH1+xqdXadbT9Qh+kHZDu7cv8cGQDtzGXt2f6af8+2uN+g==
Received: from BN1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:408:e2::32)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Thu, 25 Jun
 2026 12:31:39 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com (2603:10b6:408:e2::4)
 by BN1PR13CA0027.outlook.office365.com (2603:10b6:408:e2::32) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 12:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 12:31:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 05:31:17 -0700
Received: from fedora.mtl.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 05:31:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Petr Machata <petrm@nvidia.com>, <stable@vger.kernel.org>, Sasha Levin
	<sashal@kernel.org>, Wojtek Wasko <wwasko@nvidia.com>, Mahesh Bandewar
	<maheshb@google.com>, Shuah Khan <shuah@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Yong Wang <yongwang@nvidia.com>
Subject: [PATCH 6.6.y] Revert "ptp: add testptp mask test"
Date: Thu, 25 Jun 2026 14:30:39 +0200
Message-ID: <3651ff8e1f7ef3a6e8f40592a1759e494d7b3a6d.1782385355.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3368c3-7d80-4761-d8de-08ded2b5b47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|3023799007|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zXb9oUJCsR/2a6Uf8S4hzvEjRN9u9M6jIFwou520PG/NfmIp5dCRVD+PGYO7pHU9UHvPAVKSXY3Q+yJS3g0sPHT4EyAHxEDSy4oLwmek8OCjgTR9TuIc+kG+qy+Bjdu5e0y3lG3Ppy3dOTglpK5DuFTt3RIMx9lnohzvzSYOFieCYadLIeq7GpxbP/7zxPfoIrscxWv6/y+iH7bw+JTA0+D3FWMLFBBFirAyJxMURKNq/z1qFRupt3/KwS583pEvsEF71mZY1D93tTA6ZMPcYYSV+DzJxQq6k4g62JYP5DsAaqbjssHvqr2LK7kv8PZR3zWUThvRsfbUJo5rJDi2w7+JxDw64TjdINioHyZmnN508MvPHzynwviv1pVvg+4SVDsnr9KLQmjbmCnK/Sc06VGzulAFezOnWiu2kmOlNwqjQWf6maAs/v5EOaeConULk1zyKLEPX7tZcuWL0lmeHl/9+Vt0KFdS6cH5UD6hGGh5gsqr8ocDAgM3SAg5gbTRggdEGZq4IjI8lF2VyIGNocOGkCbOJePAQ9etRwU/10IdW2DueVkq66dCFIQc9QfG2ON+WlSvEARy+oOC/5pmOsUF/TuQ37iw2aMN8cgupDygzHVuPDyf8NwDFzYAfK0IIMAqaqMeKuI6xdTpWWbRF0cq+AMw5UN9sRZs6iJU9vwhyFe4Wr6IcLl5ToA1VOfJ2MFEZ+/xbayRSzGzMCt7wg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(3023799007)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2fS2KKnviNK0Oi+kYhBhl/DmOxGiWX4rXl5i0nYtLpexEB+ortYOJaEBMJjflu4DBzUdXSYlFQ+jtK/y/7LvldCRY9PwyEswDgI+as8AE+flnZTL05urMBHbSF8gSenpJrSJJiz0flgnH8Yu0hh6BzjfHYx/E2LZUko/GRJAb2t3zHdx3zAp0vGygHh9k55CVOCe2KxnsnNDYfekh28NNw+UPJ+WQwSdx1q1rcsRyXAB7OVPe1ewgzWtuO6JeeNT9Zm1okE+pmUETRysIn0wXtZAVHs2NvxNVSGce1+9gLLsw4JfcNb6qPolhXwWsR7L6Ps9eLSiQxRF6NNSS6mblZ0vTjpWgx1oHqv9+yJqMz1jgSToTun6cjNVQ3WbPvE10HgbK9rI1WrsLqHP/En4n7kPtem92gSpy2WUclIadfc2bQZ5lq3KXjwDj6tftt4+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:31:39.0230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3368c3-7d80-4761-d8de-08ded2b5b47a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

This reverts commit 59ac47a0275fcd5a7637c3d5da20b0905563c7f5, which is
commit 26285e689c6cd2cf3849568c83b2ebe53f467143 upstream.

The reverted commit extends the selftest to test timestamp event queue mask
manipulation in testptp. It exercises masks PTP_MASK_CLEAR_ALL and
PTP_MASK_EN_SINGLE, introduced in commit c5a445b1e934 ("ptp: support event
queue reader channel masks"), which is not on this stable branch. The test
case thus cannot be built against this tree's own UAPI headers.

The reverted commit was introduced to resolve a missing dependency of
commit 8d9f22c570ba ("testptp: Add option to open PHC in readonly mode"),
which is 76868642e427 upstream. The only conflict between the two is the
getopt string, and there is otherwise no direct dependency between the two.

This patch therefore reverts the cited commit, with hand-resolving the
getopt string to include 'r' (as introduced by c6dc458227a3), but not
'F' (introduced by c1c50689799d).

Reported-by: Yong Wang <yongwang@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    This issue exists also on 5.15 and 6.1. I'm sending
    individual reverts for these branches.
    
    Reproducer:
     # make headers_install INSTALL_HDR_PATH=$(pwd)/I
     # cd tools/testing/selftests/ptp/
     # gcc -isystem ../../../../I/include/ -D_GNU_SOURCE= testptp.c -lrt -o testptp

 tools/testing/selftests/ptp/testptp.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index e0aed424fe42..8f05212f8232 100644
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
@@ -618,18 +613,6 @@ int main(int argc, char *argv[])
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

