Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D293DFC99
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390753; cv=fail; b=SmHbU4KQtMuYBEzGPbpfChC+EQV04BJKGVjtAC9CCqi4N11jTRB5Bh9j75n2tj5NR42p6DRrBrtCLqGRnT4QSro+ac5PT0UCS2pgkUXfe/QcK2Dz/SD+HYmTS3EAM6J3q624WQZm6iib/4r8U5iN1T+ZR/LLJJNTZH13cWeSARA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390753; c=relaxed/simple;
	bh=yMRgIFLdbSmU0bRmP5cKmKfF9zWYVVgYADDddpQutPU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=paoIx+fTqYO2KlW7qNvfv/6txp+P7VVUvVQWA1TPoM2F7r0ff98P3nLahRmAewYFRh8bpvgM+jzn1k+QVRAoU3Erv4fLBb7G2N9uE9CQrvACtWrXd3rJT7BjpBtpjkmXMSyBixPl1fjqBZjGEi/OA6vXYRnrVGEw2xDmyGpJmxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nsKiZnT5; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nsKiZnT5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCo3xQPHeRfiAbJkWbW5cH8BwbkZwb3exKKvvHrFUjRQyj0NHKjzXDgwoRskVxkzpOAj+0xXXDfb3+oMmx+YjaBWrrpsGdgHR9yaI+DDER7i+g09aqZo7qG1VZKMWys3DQRA6cMM7PuktIUivwt2ul/6xGJd+7wZKPyeESXGsrJLe0jbrgehvAFqwwxWoDGIgd6prErcx3IN7cFeKmHdjQUiH8HCtJ/aAOLLLGH/MFx4FxHBkYsCzm02/V6pFZYAIdcCQBFrgn5X3apCbVu3Gg0RlhWXINu80RCFUbnQc7rnz80ffAQzmw2PoaZk0fjXRrxrxU6FTjbKaKjSQx3xdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTc3szy+u3xs+4dsc1/BgQ+/ZtuNIaF+OwhLWk7NPK0=;
 b=k9cWreoYknas78Xry1X3qX0Ym96o7685J1nkMsmBe4OEsdjs3sVXShdjLV96tSFxUY7gGLmYvXuRfz11fBj3gs16rguJ1SbMWIvcOrI5W2ULVEErJFRtoJsAFl2YQLjZ3ooJprWE7sBKmvTFi0MojRoIy9KNV0+cXaQAqUM/62uQTKhiZI7rbI2o6D7KsPFwhHUeTviuACHulZ74QxpTHywWB7Oz71sdU/CZQQOF9FzB+v3he0I/koR+M+dEvTvFzmV6r2u9RDcAgpUBJfzz3Br20dKF49dxaAyj21U8AV3wjvK8kSN//R4D5n/j/PVOHZEIqHcM48Yr0xbJp1gLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTc3szy+u3xs+4dsc1/BgQ+/ZtuNIaF+OwhLWk7NPK0=;
 b=nsKiZnT5dW1eCY6Rm6ZmfJPjqxtj4ftTZrXu1amj6XeajhT2WUG+SLIjgpT81umhwDr4jOMdtlE2E3VF1n4AqXmoy7vAYebWGNLZiKPLGJXPT7+WnbZPEg8yEEbLmPFJ22VsK7WHBuAfgzNT8gPn2vJ668DUOADLtpoYxVkYa3Jr/3I3MQovdMsBy3xZ0jVT7vMwVm0kb9xf/h7gnGe3KreJSex8zbzzjlmHnasu4wRZUZM02RmFujQ+dbJl8iCrBWPMyvhl5cZ332ux8q2Xyw2aoW4Gq97SKgqIRxDiqQLgY5bh/cwHg5/6VfkCiqxVDN738D8GowdIdLezezngAg==
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 12:32:26 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::7c) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 12:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 12:32:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 05:32:14 -0700
Received: from fedora.mtl.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 05:32:09 -0700
From: Petr Machata <petrm@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Petr Machata <petrm@nvidia.com>, <stable@vger.kernel.org>, Sasha Levin
	<sashal@kernel.org>, Wojtek Wasko <wwasko@nvidia.com>, Mahesh Bandewar
	<maheshb@google.com>, Shuah Khan <shuah@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Yong Wang <yongwang@nvidia.com>
Subject: [PATCH 5.15.y 1/2] Revert "selftest/ptp: update ptp selftest to exercise the gettimex options"
Date: Thu, 25 Jun 2026 14:31:51 +0200
Message-ID: <99e19551955b903936bedb1516bd2502c40f9505.1782385817.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: a5609793-b049-440b-15fb-08ded2b5d094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	PcT9IuJ0ixLSle+6suIRhPcXjIPRBsJ8o+aXcQaR2x6UzJh90g1FteDKICukElWhK2kbE2a3mpjloXXYUkPsmY40GSXzQ7qfPPRCJakAb6HtJ3d2qxLcWGlwwdBUwmw3XytPgjMXNX0yiyNEsfrZwS41SBKzCfQR1KjWhuYJ7X3gZStPuQTUscP541QfO3fkJj6jgt247bxXTmYGSBS3r4p/Q6kvqSasKh7lOKIEYe0MKwfp6cexEkpJuHwI2c/Jl8kFlvwtFrV8QlpDK2hYm995b69cutc5H4T5oHawg0c2w9WmAw6jS5dOMIBzmvx1coQ67TK+KCP501jaZrJkkIYqefV9LzVTgedcMdePrnj0kHnUCr+RSktjpa4C7ORqZ/Axuhu9AAUS4V1CFr+XjHBuiEu/pirEmlWMUWxmDMbNlnuL5mC0Lud63M8BBXb4+JyU/JuFqdALhuFKJwncHU50u192L7SzTDjHWbh2yC330eHs3/+72DKfWmEn79QdsLXFeSMKwYcNWn9LZ0whqNfVst/v5ocxQJBofjZsfSAJXi/DmfIIO9JszmtM8iK3G9IYvhWeFOS4Tgu/MWymJOCrGO0WNzO4woMC+86ltlRkaFfdfaxaEWdnjUvYLLRYBrcWkX+RUjae+x5Tql7V0F6vO4lpVaQ5+afxnGWxqRIS9rBnro/J3zt5p2dKFLioSLqmnQGMI7UD30zPox+Lwg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(6133799003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BX6oRxCm6QjnW8oPuiE170FVKqKGdRlbth2V0Lt3cWdyCaqqmaU0FqkRZQdohYo7hHc9SgiBLxXw29TVJBF4M2i17rREa9xrLgxKhTTFQhb0uuuLHpeziVhBsa5Vqqwa1KH/XNdKumBR7shCrVVjU2FuVf9+ifqZ21chsYwVP7/wvqflRshG0M7K8MHhip+2VKyMXIOMAQWV78QSRLQfA+2Fb1c3xj97nihxYMqfgurGIS7R7SerD9qEkNRj8/MvquMFciOz4kGMWckg9lua06JENTVXao6R3QbcO1gOFT0iMfye9frK9cg03ascDxyEi0kE4zp2TV+hQ/jCzBPptHUdZCUoNlkz0WAucml9D0bxAK5xvug+nxTcclpSW9TFYiMdmAk/jjgPgWCzywvBlZ1KgNEs14bEWsxOC8cpZftWDfu0PDroMYL81lk9Np2C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:32:26.3223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5609793-b049-440b-15fb-08ded2b5d094
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684

This reverts commit 6b32d042aa8255e964ebed860e24adccb204fcbc, which is
commit 3d07b691ee707c00afaf365440975e81bb96cd9b upstream.

The cited commit allows testptp to set a configurable clock_id. That is
done via a PTP_SYS_OFFSET_EXTENDED ioctl call, whose argument is struct
ptp_sys_offset_extended, where the clock_id is set. However, this Linux
version does not support the ptp_sys_offset_extended.clockid field, and
the test case cannot be built against this tree's own UAPI headers.

The reverted commit was introduced to resolve a missing dependency of
commit bef3a83a9a67 ("testptp: Add option to open PHC in readonly mode"),
which is 76868642e427 upstream. My suspicion is that the only conflict
between the two is the getopt string, and there is otherwise no direct
dependency between the two.

This patch therefore reverts the cited commit, with hand-resolving the
getopt string to include 'r' (as introduced by c6dc458227a3), but not
'y' (introduced by 06954f715deb).

Reported-by: Yong Wang <yongwang@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/ptp/testptp.c | 62 +++------------------------
 1 file changed, 5 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 89b4f43a7ba4..d78d52f028ab 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -147,7 +147,6 @@ static void usage(char *progname)
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
-		" -y val     pre/post tstamp timebase to use {realtime|monotonic|monotonic-raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
@@ -192,7 +191,6 @@ int main(int argc, char *argv[])
 	int readonly = 0;
 	int settime = 0;
 	int channel = -1;
-	clockid_t ext_clockid = CLOCK_REALTIME;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -202,7 +200,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xz"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -285,21 +283,6 @@ int main(int argc, char *argv[])
 		case 'X':
 			getcross = 1;
 			break;
-		case 'y':
-			if (!strcasecmp(optarg, "realtime"))
-				ext_clockid = CLOCK_REALTIME;
-			else if (!strcasecmp(optarg, "monotonic"))
-				ext_clockid = CLOCK_MONOTONIC;
-			else if (!strcasecmp(optarg, "monotonic-raw"))
-				ext_clockid = CLOCK_MONOTONIC_RAW;
-			else {
-				fprintf(stderr,
-					"type needs to be realtime, monotonic or monotonic-raw; was given %s\n",
-					optarg);
-				return -1;
-			}
-			break;
-
 		case 'z':
 			flagtest = 1;
 			break;
@@ -590,7 +573,6 @@ int main(int argc, char *argv[])
 		}
 
 		soe->n_samples = getextended;
-		soe->clockid = ext_clockid;
 
 		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED, soe)) {
 			perror("PTP_SYS_OFFSET_EXTENDED");
@@ -599,46 +581,12 @@ int main(int argc, char *argv[])
 			       getextended);
 
 			for (i = 0; i < getextended; i++) {
-				switch (ext_clockid) {
-				case CLOCK_REALTIME:
-					printf("sample #%2d: real time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				case CLOCK_MONOTONIC:
-					printf("sample #%2d: monotonic time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				case CLOCK_MONOTONIC_RAW:
-					printf("sample #%2d: monotonic-raw time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				default:
-					break;
-				}
+				printf("sample #%2d: system time before: %lld.%09u\n",
+				       i, soe->ts[i][0].sec, soe->ts[i][0].nsec);
 				printf("            phc time: %lld.%09u\n",
 				       soe->ts[i][1].sec, soe->ts[i][1].nsec);
-				switch (ext_clockid) {
-				case CLOCK_REALTIME:
-					printf("            real time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				case CLOCK_MONOTONIC:
-					printf("            monotonic time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				case CLOCK_MONOTONIC_RAW:
-					printf("            monotonic-raw time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				default:
-					break;
-				}
+				printf("            system time after: %lld.%09u\n",
+				       soe->ts[i][2].sec, soe->ts[i][2].nsec);
 			}
 		}
 
-- 
2.54.0

