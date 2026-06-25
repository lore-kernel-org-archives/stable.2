Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812763E0730
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390732; cv=fail; b=WH4XJPWITSe73o8dv3CF8NNjEnzLGGVqgJB2xyeYnNUxxPVwid3393fHDPc2Bb4YGAaf7u+twqn+4VtxWaIVsqWj244SJ+n6UoPWBFZh+fJbnTZK5fTDO2lEwGdeacZQoeZ/hH+nJU2Q7NZKANcnFJV0FAEh4x7tb2fyFOCsagQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390732; c=relaxed/simple;
	bh=bep0vPAUl9VCmNn96mgBXBI0Jb3+wOYXaYzOGOC5jxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=titYIHKi6qF3mjCOmjLT7Mpm3iFkcEWiQeuEg/8dePT/8TfqqgDIdeeNZktuG6B+IvUc9oSmJzddyZXYIBSdlLTcpQgGJAqyoV3vYnSv12MXfg4qFsPMvPVZPbRW+mupgfrGSZQ62LRElB6N2GIUOGgIeuJkdXJjJ8O7UdNFoc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aMMvqSsV; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aMMvqSsV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+Pub7H5Iq2iuNuzltlH2hPV63Ilxf0OFVcaPbHszAd+7gJAiBhfyBmTIGyf2TJc+h+9Zb/O9XsYSWlUmNOKynccsYOD2DXdpMXTvAdO5c/t+eGBNZw8U3l92qJag5IJAeh6aD4Iu5Zynb0iZqm7KhRcE5vf3bXIyrtgAlcosXKadVqmA4hnyBGNqwVsBqS2zfVRSlVn/lnChdPB6zRtpphNx04qlllfGT55hzvJRP8q5c6HRQ8RC/4QRwCJ7yDMldAV0XbN426JFCWvuk9KdWZj6L4A0EZtQ97cjMK9EHsXAkWSBBsfQjXPEj4e9z4TmlU7JyNGy9Wg08oMLhorVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vO3HVk1s5QGE671mmWhi1uXvzSy95O2ydBqEjcpSuI=;
 b=gDW76X3F2K5jVAHHDjoQnMCnS9EnZXeF9Ht469QN8+R5wPRZ1jfeKVusNrZGb44NLdQDIVKstYSJtIzSeQNv7bdB1yl5QcxIolG1IT1iKQy2el5832aIge22ePYPYbfG9lK+qyoJKdqKzGJkWZC8xqXz6HYvvatX8GS6pnMJnH/aS/MtvcCFQEjNOFKpb2TIqxPYy8XxdQmi2BIfsXHP/Uh0BpxXVLy5bRBcn8pbgEMURXPk7yUAZf65K6nXiIiW/khxlsTLcT67vi/FLNhnwmAmhaCiruZODAiuo2UzV7P2B3dr02RY0oMXQnu314Z22XYS392EHrdy+BD84Pkgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vO3HVk1s5QGE671mmWhi1uXvzSy95O2ydBqEjcpSuI=;
 b=aMMvqSsVYG0UhN1aK1kzdj6RuLiNDBSROsAS+YOWs14yz+PBST75vdHba1jo6AthElKQohexNxdBXGD5BViM4hjvULepgD21biNUIoJFSKA1CGr8bpRqYT/pz9LbtQQJO5zmsZFwmEWEjnbmgP2B8+pOf1QpbuFtsCrTGXC53HBOY9l5VhtDs5ghspiywELKM5xN5rDOJKkv5QedSAzLkqIEupmBUb4irsDgTZ5K1YvYbzh7TgAM1UkVSB3knOgmpqXubSLDPQTUDIOM1x7YZPgaDRZpcQP2QipkXGJiaSeyuVtqpK0kJcG9LSmHSM3GtqvvM5OgnhGSusoEYJLZcA==
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 25 Jun
 2026 12:32:04 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::4d) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.7 via Frontend Transport; Thu, 25
 Jun 2026 12:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 12:32:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 05:31:40 -0700
Received: from fedora.mtl.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 05:31:36 -0700
From: Petr Machata <petrm@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Petr Machata <petrm@nvidia.com>, <stable@vger.kernel.org>, Sasha Levin
	<sashal@kernel.org>, Wojtek Wasko <wwasko@nvidia.com>, Mahesh Bandewar
	<maheshb@google.com>, Shuah Khan <shuah@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Yong Wang <yongwang@nvidia.com>
Subject: [PATCH 6.1.y] Revert "ptp: add testptp mask test"
Date: Thu, 25 Jun 2026 14:31:21 +0200
Message-ID: <07d9593140f9b608272e5f2ae312d94f9d9a743f.1782381059.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 931013e3-58d4-4f6c-451f-08ded2b5c1bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|3023799007|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	0bAO1yPvUn7zgTg34GZiZLU2t6TD1hxckgfBOMSenNFjlLotexO9ZTKGSu/H57fagLEKMqmDWxxCma3IMCkZ8ribfvltcryBdwlsAptzN+xqVKa/KvLzG9j9zz3mQhZMxU1MSN3tIw1fjMvgDsux15ZgKIxLNHcGP2cjCJUQVqaKj5WJe5q62dNSHNu90rBHWt/QBvjWdPIrBECEUSytVZl3Xud4aYKoo+m5R+ZMlE7qvutaj3s73kiNTvwr0hs+vO5BjPUiIxHGT7TPA4vfqa3LLMU4bG3d5PHB2qrWFllyOSmjC+e3cYd/Wy6u31InSgdQ9EJCG/DNI3w9ALtIkdGPNsZ7k/6erbbr4NdL+lsoQdy4f9g5xBemPVL3FfrufkiKkDvXA1hwX3Kq4I4C/paZo7zgbPQZGdY804IY99x/rRWYlqKdjejGJ5AAMxBuw4mw4ShWMb/HC+NjAS7VE2cxiZI76+WQ0kW4egdG0WNvhMoGph0vgFBIqu/yN/i+4JXa9YzyDCo8CTBnJs2pjcvQAC+kW04j0pF12bhtQ9RBS0dIviEU+4FfJcxv2ohLQKbkzxhzj2wrL1fiaA4sQd8izWTXeZwn1f9JrD6r7fHqFnCL9ICfHSCai88o5588mNBwffsh5pQYmq21v1Woc3qbSvZfN6cPdutWmOJR0lJgzVxLQuThlz8YA25tgG6DTyFJ5V65HjrKzbwpteHSYQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(3023799007)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oABzaSsrMtrOsBvDNvyxjGtNFfnTzAF+XOA59NiDDXRqHZ5mxz9+jUL54jTYHow5ZjaEwHWv6O6+XcEJfPHay4A5Ih72OW+kWDpAHEXfA6E1hWOgrh1wP1sSb737BeLZ41Ps26fka46qFwG1wiOAO94X+iHdnFjF1MXlVSIWdcU/9DC/w9wh5noZ2cuxOqjZjmJuyIZMSYgzErsvT+Ovs6N8AECbaJY1OhVeIFhCqYcyeOa8eDYu/E8XQAonq2ckPfBKGmOxN3KuKcqzeQzpNjv0NcJHSlFg336Y0l42W45QWl/133/m4RVENTm1/9+FWjLI2X3pYAHH0Q/va7Y/I96RvQtjgXaSxQ3UOxDVLzxPS6skiGy1xfjoOhxu0BVjUH0mFFozR1LJu14oXbY2SlzvOo8MOki+OAPv7uxQJ4zCBcGePp1lM7Ocu0MyKooA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:32:01.2633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931013e3-58d4-4f6c-451f-08ded2b5c1bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663

This reverts commit c1c50689799d0343598ab6ccb7209819bcef248d, which is
commit 26285e689c6cd2cf3849568c83b2ebe53f467143 upstream.

The reverted commit extends the selftest to test timestamp event queue mask
manipulation in testptp. It exercises masks PTP_MASK_CLEAR_ALL and
PTP_MASK_EN_SINGLE, introduced in commit c5a445b1e934 ("ptp: support event
queue reader channel masks"), which is not on this stable branch. The test
case thus cannot be built against this tree's own UAPI headers.

The reverted commit was introduced to resolve a missing dependency of
commit c6dc458227a3 ("testptp: Add option to open PHC in readonly mode"),
which is 76868642e427 upstream. The only conflict between the two is the
getopt string, and there is otherwise no direct dependency between the two.

This patch therefore reverts the cited commit, with hand-resolving the
getopt string to include 'r' (as introduced by c6dc458227a3), but not
'F' (introduced by c1c50689799d).

Reported-by: Yong Wang <yongwang@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    This issue exists also on 5.15 and 6.6. I'm sending
    individual reverts for these branches.
    
    Reproducer:
     # make headers_install INSTALL_HDR_PATH=$(pwd)/I
     # cd tools/testing/selftests/ptp/
     # gcc -isystem ../../../../I/include/ -D_GNU_SOURCE= testptp.c -lrt -o testptp

 tools/testing/selftests/ptp/testptp.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 7030bae8e5e0..14b975594c88 100644
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

