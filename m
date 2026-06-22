Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5A2DC32E
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129265; cv=fail; b=Km2A6mOrU5HQU6ru4PAjdgn/zOqX1yjQhgxcVe0Vk6gMDlRIR9WAOpdNJY2d6TLnoyBrjM3JLVqwyjcoon7+H27UllmOl27NSQSGch/LaJvp3rqN2YWkGRxjLtpLEgEKbYxNheA1AGf1F3V17vinV6AYk5LNuyuDjzISWD0rS7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129265; c=relaxed/simple;
	bh=OUaMT8gqVj8MMA7PR5E63e/okfc/0zEPHVxwjJewmF0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ARUgMwdtUkO5wPRuPcO4u1kZEcLkgk67pwhaJgoX5dc7Lm1oYR9FFf8TRoEHjx8KLbnaMWV0GeZk11t0CySoJwh3uSFReD43Knnvh7FDP9tDHsjrdqz46OgZcmQOrRj9DN4BH7/EItkuLPoGvxooWgDib7KNMbM32odTYD9agHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FZltaeoT; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZltaeoT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxkreA+mFM2rj6YZLnN1tZPt5aYG0zr4QxYdctpQ/EQS18iPwuu3biW1HbYim5Mv1MKseKg4C16AtjuZk4IWsZrnCborYIl4eLFaTo7zdgktvJrUuSkiLoM2kH4Qk+jw5xJ7CqK+XeB8GvHmmkDCXr+p9HmdTqdHvuXrANvMDTHPJJK318rIBz3kCoQK23GiWG/MHt54uzERAqZGjnvdwG9Zse16WUHqJ4miX1qWZvJh9dSNc/Z6fGbsAMdJWU2WOdwA8TUmO3mS2a0XxPkWAikMPodqBuUwPKA5gafiBQj0zCl27lPbb8e2wslb7P43cWrWhF1AfD2Id/HXl/lwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZOjhi5mtl06sRjyzYssJZ9i4h0SK3g0hV9FbpocKkE=;
 b=nlFoSh73zkux0z2cYW8EchTedVu6Mi5NF/eanbENDTfPceTQryzi9bXP8uMnPFzeMQ0rORahAKaWSkYysK7rfR5SiH8INDin4bWEtphd82DAsvmrF8JrlYFoqKo2ci6m8+oAGTBep6tixNWpn2o78pWGR/BWL7IMmwF6Kt6o54jH2Fwi6hcnqFU6FSsJkeJbfx9NvIIMRhGn4mg5XbJkBMeRNY8UIRt4euWdrI9XYKBG1dhAr0GgzJzLqMjXZMadtx9OBEGLaCiu86GAJw4ytXx1ozqoWGWS2YCjLy4SkE5sx6q5fuZjBq9GA7jG7bc3EO2gv5V9L8/2/C9souXgKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZOjhi5mtl06sRjyzYssJZ9i4h0SK3g0hV9FbpocKkE=;
 b=FZltaeoTCHrffhaFSdg03ZN5OWYXE7a6ZkQIKW9vrFmoIdpvZQUIpZEFgUIBHm0HHYAR0rANaORtOoaEzJ5tKjjOzIo0DEB/NiAZ5pMzfO7uQUiNulSHlOjRrHDlKdCF8qjfvmB2dSWN05RthxPNhbrRLKx2m8Oxvdjx3PaWwNiYwnIsmsF3WczQEItF0sswwGW4pMX/D2bInzShdOgN9klebQxnW2aKyBW/7YEnb8pBFLYBDiwOgtr2oRhtfibe48sacpAzfym9R8YdaFpxFfG/whJ+FQSjJGmld+IRQnSOPqt6YNsABK3Re+6sS0Wn46GyWP9bipJ0/HDeJxeFmA==
Received: from SN7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::18)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:54:19 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::1f) by SN7P222CA0004.outlook.office365.com
 (2603:10b6:806:124::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 11:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 11:54:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 04:54:10 -0700
Received: from fedora.docsis.vodafone.cz (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Jun 2026 04:54:06 -0700
From: Petr Machata <petrm@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Petr Machata <petrm@nvidia.com>, <stable@vger.kernel.org>, Sasha Levin
	<sashal@kernel.org>, Wojtek Wasko <wwasko@nvidia.com>, Mahesh Bandewar
	<maheshb@google.com>, Shuah Khan <shuah@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>
Subject: [PATCH 6.12.y] Reapply "selftest/ptp: update ptp selftest to exercise the gettimex options"
Date: Mon, 22 Jun 2026 13:53:25 +0200
Message-ID: <cb079700e35515f5b7119d0c14933acaf01ada27.1782122983.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ad873c-5d3c-45ea-a3c6-08ded054fdfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DHRVvZGIFWQv/wtgxRzJFGrLFLTNN69elk+M6+fkoNCFXpafXbPW5rbOWaxw0Nom04TSaVmEf456MwPq8f/q1Qt63KEiUkveTpZd28XsxdrPgX2HQkBzWx/v26SBm193jeuy/Cnd/8PORAPearFUOFbnanqwL07wmy+jms0flyXpCwp3ygYkRPgztn86ETgcVywD4A9kd/chXdeBFDLhQY9h2YeaP3p38XLAHpLtRZyvogWOqUkr6O7JfS+IpbAn5/iCyzx5K6Ct6iCfjENzjPZR1SMZ0oWHujo33Y+CYSl7ycpGvyb3X69G36UWd5YEBGOdXMHuMGnNJLejl+Qu1KmH5zznDRARvRHRCpmIPy7fLtRxrkyo4M7octKRrK3EikVpJP9OHG4baPOkLNnbrxHgXlnsUR1BfP6IlwQtrhkFr15yawlc+efNJxfQPZ+t2tM7hOLtYhBw3zxZay3aEh0dpc11HSROLNn6ozEleBTCjD5OCRg4jdWyHN5hooMXIQEpUkJBw5ZHC4bnL7qIQ3Q/gBEUdbZjE5Xq8CH0bnbvjaMe671aSdtXrgcWOKT0BXtUt62F6/HvEprntus3R5s/Cr3kAF2XlCdFwCoE9MtOaCpS7SRwm6jc582ielgJE4VQ7eOeDbho8nVUL+sgPbVwiS1eJDjKe99vpT0rtPA2CZoQOn1TzyDmH/uy2ZGeC9V0SQaIcyCdFL14vu+4tQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EUKAxLmfeufjXPefjtxhf6sN2M//NVANWi7tw47oIwIvG8iV4BRgw1OmXlPIc5qSlUZAMZALs06tRhYTFOUmIZtc8C0oxMnwKWcwcEg8BgYKiFl2a58k9+wW4JcoklDT34941qmQiUZEIhZqDB0yigOCD+17EQIiyKyCFdlyYcJg1+njmv9rY5elCKjdV3ale7VrcmChTmTW0xMWtElrpl/IbvhuatQ41io/cNWEuDWOMv6cSDrHKF+9uGbBLAxQtWdXtMgfWrlV5yBNxFXD5CqWu6JTorxyU1IdworLXWIkgEAfZbVI6NV9jJRAXMU7NDspVMI8jhu43DR0Umwi7xqZtf7pvT50zu9UmSKkUIXKi6wDAo0+m4g14AJs4y1JXprujmbc6qEvbkETMShcolK/4c3lWaNTU3SancwguFcBuAyCaih+0J7/seuw7Nfx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:54:18.9099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ad873c-5d3c-45ea-a3c6-08ded054fdfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501

This reverts commit 6b2176a5c99b33f3c4acc04faadaa9c75da7b163, which in turn
reverts commit fa361565a7275cc43c6ca1abec9ec4fcc9ec51f1, which is commit
3d07b691ee707c00afaf365440975e81bb96cd9b upstream.

The reason for the original revert was that struct ptp_sys_offset_extended
does not contain the field clock_id in 6.12.y. However the claim was false:
6.12.y does in fact contain the field. Reapply therefore the original
patch.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/ptp/testptp.c | 62 ++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index e0aed424fe42..edc08a4433fd 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -147,6 +147,7 @@ static void usage(char *progname)
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
+		" -y val     pre/post tstamp timebase to use {realtime|monotonic|monotonic-raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
@@ -191,6 +192,7 @@ int main(int argc, char *argv[])
 	int readonly = 0;
 	int settime = 0;
 	int channel = -1;
+	clockid_t ext_clockid = CLOCK_REALTIME;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -200,7 +202,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -283,6 +285,21 @@ int main(int argc, char *argv[])
 		case 'X':
 			getcross = 1;
 			break;
+		case 'y':
+			if (!strcasecmp(optarg, "realtime"))
+				ext_clockid = CLOCK_REALTIME;
+			else if (!strcasecmp(optarg, "monotonic"))
+				ext_clockid = CLOCK_MONOTONIC;
+			else if (!strcasecmp(optarg, "monotonic-raw"))
+				ext_clockid = CLOCK_MONOTONIC_RAW;
+			else {
+				fprintf(stderr,
+					"type needs to be realtime, monotonic or monotonic-raw; was given %s\n",
+					optarg);
+				return -1;
+			}
+			break;
+
 		case 'z':
 			flagtest = 1;
 			break;
@@ -575,6 +592,7 @@ int main(int argc, char *argv[])
 		}
 
 		soe->n_samples = getextended;
+		soe->clockid = ext_clockid;
 
 		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED, soe)) {
 			perror("PTP_SYS_OFFSET_EXTENDED");
@@ -583,12 +601,46 @@ int main(int argc, char *argv[])
 			       getextended);
 
 			for (i = 0; i < getextended; i++) {
-				printf("sample #%2d: system time before: %lld.%09u\n",
-				       i, soe->ts[i][0].sec, soe->ts[i][0].nsec);
+				switch (ext_clockid) {
+				case CLOCK_REALTIME:
+					printf("sample #%2d: real time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				case CLOCK_MONOTONIC:
+					printf("sample #%2d: monotonic time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				case CLOCK_MONOTONIC_RAW:
+					printf("sample #%2d: monotonic-raw time before: %lld.%09u\n",
+					       i, soe->ts[i][0].sec,
+					       soe->ts[i][0].nsec);
+					break;
+				default:
+					break;
+				}
 				printf("            phc time: %lld.%09u\n",
 				       soe->ts[i][1].sec, soe->ts[i][1].nsec);
-				printf("            system time after: %lld.%09u\n",
-				       soe->ts[i][2].sec, soe->ts[i][2].nsec);
+				switch (ext_clockid) {
+				case CLOCK_REALTIME:
+					printf("            real time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				case CLOCK_MONOTONIC:
+					printf("            monotonic time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				case CLOCK_MONOTONIC_RAW:
+					printf("            monotonic-raw time after: %lld.%09u\n",
+					       soe->ts[i][2].sec,
+					       soe->ts[i][2].nsec);
+					break;
+				default:
+					break;
+				}
 			}
 		}
 
-- 
2.54.0

