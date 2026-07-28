Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023121.outbound.protection.outlook.com [52.101.127.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A936DA03
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219821; cv=fail; b=CP1O6VhMpSl1jVKMwJUAUT+sSoGNYuPkFZyao8+oyJJbtDB/IXuFeQLMBq4ltrDLMxXuzGXCJ/RyPzTr6JFzrMCaR4iWUINv7/JZNKfwuCxC2rdNehSW9FtKoYFnQV4/WnzA7t+W3059JWFntnFcuwVJ92neQ/KufJbNR3BdTMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219821; c=relaxed/simple;
	bh=Z7vi32SeUM/Fh2UQihm5qBVwkiknohF42PX3TRFwwNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bP5NKqqEDZ9L5hCZ8R+bPkcbCV+lVzYvyhxMPvl4ww0eeSEKDsIVprZVYYTmm61SNjTSTh7Z38TWEV4Ibwl0ccF+S17GcIXH40hLmbEk7XMUy4KKJX4puHVZs3adXpAIpRqlEb9YgLgorISU4zbyHJOs9K23bsI7EfDfiZBRTWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nova.gal; spf=pass smtp.mailfrom=nova.gal; arc=fail smtp.client-ip=52.101.127.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nova.gal
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nova.gal
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Os4Coa1Jv9D3GewXw3hfyvvxuvUxWFWJrR8Mc8mcn7qxIXZstdOCbEKjSemQ508gInHuEfQj8BEcN165seFc6yubWvpdKVy8ycp4Lrupp2cz0UhY0hsjAJzm5CCVYG3CBH3UwlcTUar/cAQB+o/drrp43c/bog8toS9gFXlKtbOBevl9aWYR8Mta8slOpwjXWXD+lj0cKF949rwtq9RZEp6X8WuhxgeSaHi5BVQt6r8tL/FRjfiPAehKAbSOvCjm7HXBOY1vemwNrJ67CkHC60KtBBhLsK6e2FZQB/AWPvBvz2aJnKDBAV9Yn3jPYOxB+DIXVW7Vr9sZy2OPFPrkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vDxRhEbpgA2xMzUYAstbrkLsPVHBg4mPegEk6SEEJ8=;
 b=Zo2z8EY+UVRkQiQi7fH0oqTdNX7xMkqTepgGFAMnaGXHsLJ9eGw8qTD3/EfRURAZ9T2XDCxo8YpHrhi5DAFmQyAO7AIKRu9ZJaBS1V+M7YxIC3Hc9/AlXVq+lQ4/KrgoeHh9iuNCwdNKFLEs/U+IZxvEZkq4jRs994FwWI/BuBMlOLdLd4eNELfSCDcyH6itFIqVFui/4STt0QoYbz0H9+oyI06pJHrEkk0h82DxqyeIdvYIyTiEaAqGg+bTyaLLqm/g7NzhUxcBVqsqN6DaeHls9pgYT/PE3jsSjT9OJaZqExcYY81zEPd1lR6uzoH2fA5xwbxjvSblyIqIgORh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nova.gal; dmarc=pass action=none header.from=nova.gal;
 dkim=pass header.d=nova.gal; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nova.gal;
Received: from SE3PR03MB9967.apcprd03.prod.outlook.com (2603:1096:101:336::7)
 by KUYPR03MB10554.apcprd03.prod.outlook.com (2603:1096:d10:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 06:23:35 +0000
Received: from SE3PR03MB9967.apcprd03.prod.outlook.com
 ([fe80::98a1:50ec:e93e:e0ee]) by SE3PR03MB9967.apcprd03.prod.outlook.com
 ([fe80::98a1:50ec:e93e:e0ee%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 06:23:35 +0000
From: Miao Zhao <muel@nova.gal>
To: muel@nova.gal
Cc: stable@vger.kernel.org
Subject: [PATCH xfs] xfs: validate remote attr value length in the leaf verifier
Date: Tue, 28 Jul 2026 06:23:25 +0000
Message-ID: <20260728062325.1290283-1-muel@nova.gal>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::15) To SE3PR03MB9967.apcprd03.prod.outlook.com
 (2603:1096:101:336::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR03MB9967:EE_|KUYPR03MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c91beb-b6d3-4839-56dc-08deec70c14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|34036016|41320700013|23010399003|366016|1800799024|6133799003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	eoIDAnm5hLljAc0YUTHzIxbd6JLW5UWBUnV6IjkNyP8HHn5EJamANg1BCxly4Z8OOtYK4xJWGwWBKs37jv8vRB/1b/dsiQiNMze8k2XHR7T7CxutJ/RrVb1XCl9urOshPMe/igBmPpuLJFYRqwtIHG8UHGKLBrc9KAm48PlB219BJv7929ogJV2m8jhfttjAc/oU6d05tNqh6mpzeMTbrrsbqZA5zAIsyBGknbfTHhjvk98ajwxKgFgN5CbUvweiSg6gsGCTjvkn4h4S9ifDPCm+gfXRttMAcd60TCQxvymWRzQCwHu+rD5thDYqfUX5LWqGJFP12khqB4293rNrCJSSTYiLgGuOCBmnWTU882gW+Ajh1XR223uFnhU4Mncfu/wQqrqjH5/jqVydbUgsKbUoEUVj2evmUdRszivOm+rXmfCvwcoRguRF+JYJJmg4jOEAxpKJmnjNltp3wXuUhVeejevfL4tnjj3gpZUNzbCTYXRWyQ9Lm3m9aOTtVyeVIINAYgyxeY0B6Co2WaA1z4pyAy82HeyeV2gidRDfKTJoytSNzwzDjI20+Ns2QaIFkFtBz1B3r7D8zLi5e0x919AnR6J5WLzEcF1eGGQP+yGOy02OJC9GPLpqtkUSjzL2wUZGIe/jlz/cY238sgmg/t6uM1oYIsMa4jKRImlPGxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR03MB9967.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(34036016)(41320700013)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o63XnFbmtRCUFrUsM1fGBpAcC+qKM3Nyxk2n4sHsVccMv6AS1fxv1BTrYQWF?=
 =?us-ascii?Q?0xCk20XsRlmNksyC6w5CN5zxeky8wzo9FpEtwTnZqL4h8iN3dS0LpdUyORIu?=
 =?us-ascii?Q?+jr5rsjvxNtjjN5wo2lRnT4TZCnZiz5FYsGGOBc/ZJZT363V2r2bmo+AyrGr?=
 =?us-ascii?Q?70rty4wg8BTvsgSI295DxqoI70yOatTb/vw+81hmBMgDUucEAw8Xh3yBlpGx?=
 =?us-ascii?Q?xxKIA9qQKprjCuW/O4OUn/ODe1fp+nARXiOrkFmdKZipFkc+6+5edLN9kkVe?=
 =?us-ascii?Q?MViCd9V6mIOli3ZZQBZYarPsLkhyawrmI/kG5WvE4Y7LWTTWSoJjtdGBmGJL?=
 =?us-ascii?Q?zazZ6b1zOvSoDQqAALIOl3M9JJU8bwS21B33imlHNco4wc+8rn99G/7xRRrZ?=
 =?us-ascii?Q?jFFTwdLDuE//3zPNr/jSYw4pp8kl9lXOa525X552Mfom32A76YtH1vMXtcIm?=
 =?us-ascii?Q?eRAFdFj9/yrl8pu+23+GV0IJ+3FP2S5fmaJseXQCZkiM7DYnCTbDMB8wF0dA?=
 =?us-ascii?Q?wDS4OYpioeFHa9xU4lHhb/9cpN3ualF4yd/PH4YtoRviRrc2yUZNQqKgxhub?=
 =?us-ascii?Q?yRtmLyDYO8F2OS+IxQCr0kB3Ar01CsjAUEjkEaUn3M7yVxctXCVeLDm7K7Ff?=
 =?us-ascii?Q?+BqWOcSDx552yMdoxtb7Utm5QPgKWkikleHHxQo2ILo0yspknZ7Ff5sLqqVM?=
 =?us-ascii?Q?2Ir4l2FVBg37wka3+CT6bhOplkZrb1ADmdudb5CourAdDfh1nrrF5AI+nnUx?=
 =?us-ascii?Q?2obKU47EvzXwQhKOpZAx/dZVzu1qhGE+dSU3m/LYWgEuUOMlOCl8Qxi6uDWi?=
 =?us-ascii?Q?lHNrwfBpfW/5EsPZUMg7oiSLZsCVmt4E3LK8HWudGM47vi2o/HDph0qWP/SR?=
 =?us-ascii?Q?sjDM/Pc1rWGibGkfQTCkcEQdXA2yMGnh3emAA9Hp1a6UXrFF1TTNBS3aQluA?=
 =?us-ascii?Q?yCAWY1IkGJNOcBOXzwUHE692OuVCxjSB9b7n/zu2FpN67SoVhmB8tdGUfTMJ?=
 =?us-ascii?Q?BiytqVEieJJH3syi0bbLVBzVk5Y43JmAmJvxYdG/IcNhEB2pIboqK3sqAHzq?=
 =?us-ascii?Q?tIryA3V61ZiVNGTOG1Yc9Lxl/pFQBzZltrGEap+P/B/dbf6S31yX4N/WwmgZ?=
 =?us-ascii?Q?31r/omZ84+wlPsdZI7WULy1zRx02WXOrYEk4sQ1ZcG+LAiC50fmR4VHNxyAS?=
 =?us-ascii?Q?masLASfzIMgbp4Cc6jOVf3YPH6kTdEGU0Uty+i2LFjYi6t+POjo1zVVvpIjs?=
 =?us-ascii?Q?rOfC2bD6zo7Sse9/Y9LJek/yKjP9VXovle0GlR8FMYILaoTMU2chpJLrEhCS?=
 =?us-ascii?Q?FobJpIdxEYx6q3ODJOrCQWegY2AO5hlRVjsBk9cirZGe8B/WDZVl4/0overA?=
 =?us-ascii?Q?g/KtApKmUBeJT+gmUb+YT5u5t7EFaAeOSRswe6+jLD4wt+DJh+8IRr4lamRH?=
 =?us-ascii?Q?ZPSJQy1KxYQCGOXHXB+WzbzfucCuKn80L/+XGiub8T3+qzjW30hTPnKaTQ6u?=
 =?us-ascii?Q?VEvbSQMCWXT+w7a1W2Oioamc8HPW2VKfE+X1yZiGTg/pMvq2z2YEcv2Sobam?=
 =?us-ascii?Q?eDAX3q/amQ/tUQrYLdH+bf4cbmjYxtsfGLlK3yKK5gaHPfEZlykxQj8GYGGE?=
 =?us-ascii?Q?kJhIVGW3VljNJhaYTHOG+hqa5+jVJvFzhqokmajafzDlVkcL1k7vrUSFEMEy?=
 =?us-ascii?Q?36csD3O0iZ6k53SsEkrhTXHvK5pWNnF6Ou/ca8xDOYNbRjWk?=
X-OriginatorOrg: nova.gal
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c91beb-b6d3-4839-56dc-08deec70c14a
X-MS-Exchange-CrossTenant-AuthSource: SE3PR03MB9967.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 06:23:35.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2adae87f-1bb3-4442-a538-a57c857641f5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/bHQABY48ecsAzY6IgoAcTljOCSzltunp+U0O2K52On6iWrU66fM5mv565oL+vV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR03MB10554

xfs_attr3_leaf_verify_entry() checks a remote attr entry's namelen and
valueblk but never its valuelen. A crafted image can set valuelen to a
value with the high bit set; xfs_attr3_leaf_getvalue() then stores it
in the signed int args->rmtvaluelen, where it goes negative. The
negative length bypasses the -ERANGE size check in xfs_attr_copy_value()
because the comparison is signed, and xfs_attr_rmtval_get() then
reinterprets it as a huge unsigned value, driving the memcpy loop in
xfs_attr_rmtval_copyout() past the end of the getxattr(2) result buffer
with image-controlled data (up to ~64KB on v5, where the remote block
header verifier caps rm_offset + rm_bytes at XFS_XATTR_SIZE_MAX;
unbounded on v4, where remote blocks carry no header at all).

Any unprivileged user with read access to the file can trigger this
with getxattr(2) once a crafted image is mounted, e.g. by a privileged
auto-mount daemon:

 BUG: KASAN: slab-out-of-bounds in xfs_attr_rmtval_copyout
 Write of size 4040 at addr 0000000061bf4ee0 by task xattr_tool/37
 CPU: 0 UID: 65534 PID: 37 Comm: xattr_tool Not tainted 7.2.0-rc5 #1
 Call Trace:
  memcpy
  xfs_attr_rmtval_copyout
  xfs_attr_rmtval_get
  xfs_attr_copy_value
  xfs_attr3_leaf_getvalue
  xfs_attr_node_get
  xfs_attr_get
  xfs_xattr_get
  vfs_getxattr
  sys_getxattr

The same unchecked valuelen is consumed on the INCOMPLETE sweep path
(xfs_attr_inactive.c) to size stale remote blocks, so validate it for
all remote entries: reject valuelen larger than XFS_XATTR_SIZE_MAX,
and reject a zero valuelen on complete entries (a value is only stored
remotely when it is too large for the local format, so zero is never
valid there; INCOMPLETE entries legitimately carry a zeroed valuelen
until the operation completes).

Fixes: c84760659dcf ("xfs: check attribute leaf block structure")
Cc: stable@vger.kernel.org
Signed-off-by: Miao Zhao <muel@nova.gal>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 86c5c09a5db4..b8ae25be639a 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -336,8 +336,11 @@ xfs_attr3_leaf_verify_entry(
 		name_end = (char *)rentry + namesize;
 		if (rentry->namelen == 0)
 			return __this_address;
+		if (be32_to_cpu(rentry->valuelen) > XFS_XATTR_SIZE_MAX)
+			return __this_address;
 		if (!(ent->flags & XFS_ATTR_INCOMPLETE) &&
-		    rentry->valueblk == 0)
+		    (rentry->valueblk == 0 ||
+		     be32_to_cpu(rentry->valuelen) == 0))
 			return __this_address;
 	}
 
-- 
2.34.1

