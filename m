Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011028.outbound.protection.outlook.com [52.103.39.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE127478;
	Mon,  7 Sep 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745285; cv=fail; b=FjANXj+XE92rYCWPmSXg12SvSeWPD9u429MVF5PoWYxdtzXgornC/Vu1cd19QbEwokKCG4VOSKQc+uDpktU+5/z+oxZi0thph89bsygQAJMyMJ3yHUljkaUUm9wxaUASnL4KO1fjHuyx2dk8vqCdJizlREEDAnKW8THymUkpKVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745285; c=relaxed/simple;
	bh=Fv7+d/xbtkr3UQ+cCQ9KL3DSd8Ff0NyggS4WcIgiUCU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZiuOpEebMq7ME36S0kcITmVeOPeRzmDFjCcAhu7dLFw9ezFgN3ZdP/i/xGTgQoBL/hiO9+IzqlfkU2BWdcyKptfSCGr/KLO6BpYlnzHZ80UizxZR/dInC6zRRRJm3SO8l/TWeDwr6dktionUv/zTO7fO/D2ZUZ1O/nDfegR9B28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=ZIYca1zt; arc=fail smtp.client-ip=52.103.39.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="ZIYca1zt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqFU+KnRfY6BeTYOOeyeEYW7M0p4NB7zDKOWcacDUzUvHjeYD6E5njegLXsK48QXAuNVsmzulE+1vV2STaHiPJpe66q9W24wnlhm+2RBI9vupkxrgoUSkjG9zEiQtobwrA6yXEYQjDCZslm9MXKPAKN4BY9Jwj82vcFRkb8YWIWQxlA91AjYs47S/5UuV4+0Em9H2AQoNwclMXZNbn0EFinr3HEivesPPBFA89SXOjYFSdGpnTmi2OMAG57iUmFPQB8asEtf++1zFVtY4vwbcqn22yj6I322DkapGTiiRx2aar6uAL+NzNJZxe8+oLsKOh6gA18B3L+iJ0n4yUAXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nqraMbD31xBE4OwMk7iLrrykNceE68oyWOUu6OAJA4=;
 b=J268EPjxcj2NsSbPS4+pOnds2k+3mQfNk4J0ZpTelkfhxNXexcI9qn7lPfYXaVazNRwNVZBDQScNtfl0TYaVX0qmgG3Xu7vWowVy775SiLhr/8Jc9LmKeYKkr7xWnG2KeAKKHWuP8QnspIVqv2nbHg9lXHG5tyFwHiHlUbH7dbf6tQLCoa+7F0FJFtAFPvcBtpRjszl1o6juzdLI2lPwS5ds3Lb4L6JmXFzVHEicVdjnXkW/sg5gfU/nLdd3ut5m7C12kL15O4l0JLjph+kanItnkm030Wqb8mbUuumXarGlx8nXMTsXp/ju19CQ2jFTahNqRZdgLja02D+LOdpmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nqraMbD31xBE4OwMk7iLrrykNceE68oyWOUu6OAJA4=;
 b=ZIYca1zt9ivZ8iFrWueEApZTo24Vqx/of5FwwSmRZdBTQ4ZEOOfd4qNhvDkONcnzOkG4pBJYJ9PLGOBtLwwX0mWcKiujwnkNYBQ1ctekTEnguOUSOKZ3S/TM7OVqxpcPUTCFPHQkUQ/8i55DILl8x6hwar1g5QXpmAbxtY0wCLKP84WbMgSH2P94voNsDEyqWSYR+85g1j8UfgX+5M32Mn6vhQTVJT+ChXH3CYBDlk/95FpsLUYYcTlCZLEp6UFCZuUSltvGIbk6Evxu2oIHT5KQQyWXEI0hRCIo3fbdmAtIe2Bv2t0apN8Dnk4nJc2Yg6Ph2z8ZLZhnYW2lXOA4ag==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0727.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:286::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:41:21 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 01:41:21 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Bob Copeland <me@bobcopeland.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH] omfs: fix use-after-free and inverted logic in omfs_dir_is_empty()
Date: Mon,  7 Sep 2026 01:41:17 +0000
Message-ID:
 <AS8P251MB0001E6603ECDB905AF8F845FC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0312.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::11) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907014117.486563-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0727:EE_
X-MS-Office365-Filtering-Correlation-Id: ab57f1e2-23af-4953-a1da-08df0c811e58
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|37011999003|25031999004|5072599009|25010399006|4140399003|19110799012|8060799015|15080799012|24021099003|55001999006|5062599005|23021999003|440099028|3412199025|26104999009|40105399003|52005399003|12091999003|11031999003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YiV/YqoWNVeA9l15v8ncseyXQyq24od7rijZqlpb7hexKzQwzNNSrh9T8X8g?=
 =?us-ascii?Q?AHE/tBpCJzygEZ6Kn04pqiHjuXX6uL9jogN4VcJ+7Uqypcp1fnVvD+qyybsZ?=
 =?us-ascii?Q?1gTG2givJd2ZLokXQ2oDBak/xsDTJlsib8lg+5vl0VbB89AFkHC1w2YT6iuH?=
 =?us-ascii?Q?qmyUz7BvUejHNJz/mHjEOkqjL8RR2FlAB633Uj4XF+LjNWeCZF7qor9HUQSv?=
 =?us-ascii?Q?lmNHBAvQqoKEzVhcc8v3iDSReMgCK5/HsU1cBvgwYukZj4LLGtewNi6K/VI3?=
 =?us-ascii?Q?+g0L/h2Zb4CA7Ph5NgNxWhirNu2vPrtjVZyrX5UurnM18+CMkRcTmpsvPRDn?=
 =?us-ascii?Q?4OhXBkTRHHph3PB/aKqyoSAN/+soIk3cLHTSoQcbZ/4K0t2HMKF2NRy4/rpP?=
 =?us-ascii?Q?rXlI5tuWh9Dl6zDS7Eg6QmA14whpQheYTQgMhp1b+dbGimKkNj5TnP9NzzfT?=
 =?us-ascii?Q?uXg6V3beHzYyyOjmcgZd2imXfmX34mF2+251VUfbVpCtq8hpxyvnjDW+Y+O+?=
 =?us-ascii?Q?I9uf0WKUTJyBZyG/5asS3guK0c1MucTMru0ORIKjtXO6c2rjvz0FKpZvpPMV?=
 =?us-ascii?Q?QQYYs4F47i3fXoZlMnQdMe4/0QNlyyy/nprtSHfd0NfCxYTlyE3csCpBfswS?=
 =?us-ascii?Q?zjOlrCLmY98SXyjrl61UfFmBwEVZoqmjuHEDIGTt/AFJzB/nTKUQjLJwH5/9?=
 =?us-ascii?Q?y5o4EPjV3g8Xhjq2iloqVCfGmFojPu4NKqawtmXX8gSC1R6QSTzxGugE8ock?=
 =?us-ascii?Q?/u9IMlxxOrzddkGNjNzR6w+pv5Vi5LbbA/RqGulGn+jp+x7pJ2lhuajq7h51?=
 =?us-ascii?Q?JDjIKSNAhOm8J/P6dOU8m828rO8GoQRLruwhElGooVQOXn6lQCbcpx1oekkH?=
 =?us-ascii?Q?YPBTwgIfiaplVtE2F4Nf9E8chUWJFpHHgaZ7YHLm6qGjD7oV/2pXuNBMq/tc?=
 =?us-ascii?Q?HIzPZh5bpK6gr/sIhdQ/Y+zScpYn74WKJhVBA4IdxLgvbmOxcTJV9Vz7WMRy?=
 =?us-ascii?Q?IYIYFgdWO22I+2TstnkfK0LDgnPDX6/MlcwELiMC6uMoTZMVm77oUzHSkyAE?=
 =?us-ascii?Q?W1xO9CvbrY7HTR9oOZjlSrpFvwqdhLCXyW3nXuaJIpkSSU9zKcT+o7iFE9fE?=
 =?us-ascii?Q?HRdxss0X+En1XUQjS6T0cfQT1yjvilY3WIbLQYUGFACRXpFJ2t7pysk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?94VryaBjQJJ1qnqEYgyyRb8I5Dn8WpI8i+yi1UfARoRmzOM4Asy91iWqKjb8?=
 =?us-ascii?Q?EKiCKcpYJrowRX/9zZIFc18gDgTQLGe4jmrJH0HjikjkCNjJW9BXCTVvrHYM?=
 =?us-ascii?Q?d/VRCsLKHIUpkDrbFZUKAMXkREokJuv2yer4tXaAj5fNrqBPA8F37Gw7n2xn?=
 =?us-ascii?Q?fUys/8pXMXv1Ahxva7t1laQrnDnx1XVH3kjoNSNQytuyxJz3esHEbvtB7Ure?=
 =?us-ascii?Q?nXDzXNONIyohU++eh2TXa66kyYbRQfTcnUuiRdezMZxShGAPa1Zk5ZXxPS68?=
 =?us-ascii?Q?HPsy/pOXmN49nW1Jb159b0h3A6O7kwGIJfz0qxlWRZvlHMbB9h13MoNk5bmU?=
 =?us-ascii?Q?mEdkm+5xZE3OLlKL6N8f3QPQI4zwNi/ckh6HapHm3/KAMCCYopJUNALuiQkx?=
 =?us-ascii?Q?hUBbIfs0NFtnhWYbTcP3bIqU96jZ5walMw2x+Qryu18z6BjKrlbBHXIYqOIy?=
 =?us-ascii?Q?sEZmNSqJiS6LoYWAST1RVhadw/PB1an1af6xqQu7KltBWyX15cYGrd2rT2W+?=
 =?us-ascii?Q?lVjvEEwciCtSLLJt5YytJgfYIR0hUscm2/5MpL3Ve9loCF6zo8wMA1rkSgfH?=
 =?us-ascii?Q?l9bOmKD1nWqT8f6VYMxaqv7pz0Gap/o6fBsOhhhztQvpxsoTQJbhJSBaVz9q?=
 =?us-ascii?Q?m8ff74i6qrGJ7fueOfAYUn+CZkTl6A+lI/Vdh2m6uhX+WhgXk/wcPEjG9fwh?=
 =?us-ascii?Q?eH8TW431AITmbJKOmcCUPDXUo6o4D9V7I/65rqQf06MFCJbwGbu0IuNnQzod?=
 =?us-ascii?Q?p9ktPe+t2D1g8wqygLUkFJoGzhzcg/2upgnQ/1lYZKmat5lOIdP77OCM9f8Z?=
 =?us-ascii?Q?LnUnuZrKZwOE+81dZYMEhg0RO08eg2qrc8BJ89OlUcFDNjr9bOaZm3TdJ26B?=
 =?us-ascii?Q?jGkIB5yh+VGsPqsMGBCSeE5es2umesHmGr3+O1zgYFnyP3vK3FMcmtBOCrg1?=
 =?us-ascii?Q?n4+g4x6Sx76q4H3L28S8Zg04RCl8oeZiYYNUFIi4Zwf7+N+INFUwiqAvXrR3?=
 =?us-ascii?Q?ti26IhiJjaYsqeswQlOphC77NdGicEEIdhFc2RnWSbdLIjLXykag6h9fNXB6?=
 =?us-ascii?Q?Z45uH9wZToT67BCt/UPmVTLK3+1pktNf9FUPsxAmO7i0pVtFtOJJMyUO960c?=
 =?us-ascii?Q?Kj7lIi2sNt6ujuQL4IJl4FmMIukirbAynl7otvO+yfLAnWXXwn+/BD1KayYM?=
 =?us-ascii?Q?73POegbsK9edMDLo50F2UtaDs2b4LHMzkbLuaecDZx0Bm8Pr/7ORAl6jhXmM?=
 =?us-ascii?Q?qRM7Kcvs+jESiDhIbZxrX3GO73KhLkJVaLfMjin2ebZQJm76vLOnZnzU6jva?=
 =?us-ascii?Q?HcjyCD7hKStfb2IQGnfjakafBQuSo6StHQlfCphSj85OPEwRXv9WXx5ZkjH+?=
 =?us-ascii?Q?Zxr8hfcErF9D/fCJcm5u93u6NRvUQ7Td2uBMXIDLu0kP616SP7PbVwWMf4/a?=
 =?us-ascii?Q?I75fYSdBBrm7hWf9wVelhwsnGnHF0uiP?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ab57f1e2-23af-4953-a1da-08df0c811e58
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:41:21.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0727

omfs_dir_is_empty() has three bugs:

1. Use-after-free: the function reads *ptr after brelse(bh) has released
   the buffer_head reference, accessing potentially freed memory.

2. Out-of-bounds read: when all directory hash buckets are empty (~0),
   the loop completes without breaking and ptr advances past the end of
   the bucket array. The subsequent *ptr dereference reads beyond the
   block buffer.

3. Inverted return value: the function returns (*ptr != ~0), which
   evaluates to 1 (true) when the directory has entries and 0 (false)
   when empty. Since the caller checks !omfs_dir_is_empty(), the
   inverted result means rmdir succeeds on non-empty directories and
   fails on empty ones.

Fix all three issues by saving the emptiness result in a local variable
before releasing the buffer, and inverting the sense so that the
function correctly returns 1 when the directory is empty and 0 when it
is not.

Fixes: a3ab7155ea21 ("omfs: add directory routines")
Cc: Bob Copeland <me@bobcopeland.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 fs/omfs/dir.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 692297cf84e7..55b0a3ae8e59 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -219,6 +219,7 @@ static int omfs_dir_is_empty(struct inode *inode)
 	struct buffer_head *bh;
 	u64 *ptr;
 	int i;
+	int empty = 1;
 
 	bh = omfs_bread(inode->i_sb, inode->i_ino);
 
@@ -227,12 +228,15 @@ static int omfs_dir_is_empty(struct inode *inode)
 
 	ptr = (u64 *) &bh->b_data[OMFS_DIR_START];
 
-	for (i = 0; i < nbuckets; i++, ptr++)
-		if (*ptr != ~0)
+	for (i = 0; i < nbuckets; i++, ptr++) {
+		if (*ptr != ~0) {
+			empty = 0;
 			break;
+		}
+	}
 
 	brelse(bh);
-	return *ptr != ~0;
+	return empty;
 }
 
 static int omfs_remove(struct inode *dir, struct dentry *dentry)
-- 
2.43.0

