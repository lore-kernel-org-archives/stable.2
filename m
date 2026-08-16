Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022128.outbound.protection.outlook.com [52.101.101.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431933D6D5
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786840602; cv=fail; b=fhe45TXSgRd0OTB8yYAytqS3BOFa3q0EhZThz4ACWkldSvlAtlBGJ4kMrHsz1bdTR6nm17OrtgeeWjtP4iv686ceE7km+T2Z9hUCB9mhS7eJU9Upi15g95Xmt/cAO8Ot9MuDXfD1mxMwC/qaG83KhRtdwUVVMEw6sxxDSH70lfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786840602; c=relaxed/simple;
	bh=DKGj2z/F4tYTstjGYnq9FLTXkBcCdXhuoHKk5PFyY5I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GQs/0O4ft5SpeZaMsz/y6VrtFjElBdEMXbG7LmtzA7qSE4IUsF8xwWHzW3xsD5OrQBzarCEeO/qQTCe2vW1JE8CtG2tYw5LekXaNmSNC2bPTspZNXCKM0aDLDDrreNLQc9PRzck8u4jck8ZMCsz5xhKfrQ6T93cckOFuisLgghQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PawLHfZ28FuExPV3sGa/9OcrVt9oDB0Ngmms+L+IzvwSzhqhRAhitJCqdwN1z4hy/SbXRuvPK+nrM3DsAlh2M3Z7I54qqbCAUXAnzHfkPDBex63XZTAPb5kmbOZOAD5MPh66SuocCqwcRI4ZHeza8mxiyDEM7mrga7yVVs8lx4gp9a/g4E4DAWKgLDdP4VCteVfYBdWFABhLqknwQolpSDMlUfN4v4ek3oBg1R+WHtWHIbM8+Bj1tjnRg7oz6gKI3QuQnfB7RLNTiSZtNy2xzn+jZNkNentpsrI2dbAli1z6aTCRBNtUm/Il0Pz+Zmabzpe3vqUIeD/Ipju4Jb77oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=U0DAAuGowqoc11o+drNs/jhMiEXxn7iEPwboerg8S70=;
 b=OiYydOQQoVEaD0K4oSOj5YMGQPACsBwMaU+FZgCsZeBfO9e0TjWcqeTHiaOO9u/Mwb/gicM9dMJcA1PeDWEJeQ27Idmjgw/buJaHOb/b62672zMrM6OXHsYhu27fzrXc5a7X4ZAqs4YRXMCbe+i8AXBdxazBQbmuqcs6XWNCY0wDg4hYr/AMnyg0OFgE2tAsRJab4Iho9CoIBn1dHWaSvnVZcK6nNMYE0Yty9iJ433AGRK+x7hXWr5IBBm5YlPd62dHDWCPFx1j6Z7rFp3jceF6OJVgnVWO1qfr2oaRMMP+1lRDXRSsJ8PO7BSuHqCmsquA5idIuIC3Kxf7dsnO4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7280.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:334::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 00:36:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 00:36:37 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	tsbogend@alpha.franken.de,
	gregkh@linuxfoundation.org,
	atomlin@atomlin.com
Subject: [PATCH 5.10.y v2] mips: sched: Fix CPUMASK_OFFSTACK memory corruption
Date: Sat, 15 Aug 2026 20:36:33 -0400
Message-ID: <20260816003633.530523-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:408:141::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: f6079ac9-0c62-4723-7c41-08defb2e6e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|56012099006|3023799007|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	ex9yAKQ1vA5/sjsuHoP2JW2paGFDxKD9YeNbLgChFlRqLJu4mtN5bDuuIjA6WR5vVAcZB4mPKQlXdAQd8pdLr9JjD/kUCERZLfl4Fvbt8u6vNqgJrXRxrhbWc6jPaPiOzvsSao8lqgSstviEXhPsV1Gkj5tHZKSNnM8warp5uym26ILCp5W6l8dH6IsttTlipbT+P0xlXmiWl1Gc+Fw+ucKAd5IO3vB/ZA2JJEbrPeNwnt/EtXTJmh+Z1mIEHT77hZ7umRoCRL7z9UWE/+Sz2sAUXHYj/wo6HQvk0By8/5qLbR3UwfwguupipZCP70HLYALJMXOytln+xhfokoYNF5C88CxpfvfmXTCFfHrhrcI7aXaT4hgrDGPbgKFXm/SzComGQUBcR37jRp6qL5mOhjHwb97dXnrsrlhXHTFbfvlwr+8wDKmyGnkhEAJ7J9qGiRsmaDj0qWz0gVO+b5GYsSdHLaA/hGf29zVWamITUm+VvzyBlJtZjPZlELTRX9icPEL85O3e4fD0EWyDcXaMWuqDfWjSKSLhv62AkLpZWs3Sqy2wpqw8ZV2FV/dHnP9eAZeMYQYUXrOmt4Zn34qZlFlgxxCCBvWYBgaXfrDHyZTWb88cvxBxhYBReNIc6E9gSGUDEIP7VbAgWfP5vMzKdY2x6DOwCwzYWJop5nNL+Mg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(56012099006)(3023799007)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qPeUG7bxb3QdLP+dSgNPDHUJmjCaZfYSsAaICUwZnT0xg4mmlLBStSLLPrBN?=
 =?us-ascii?Q?waH/yjkQK9yLrRZZF35JO2N/TxBGMEjMOxamczI8979U+Ezzv0YNSmmzUTuJ?=
 =?us-ascii?Q?AhmBxrpPi7WORp/A3eRmsf7rEbV8rSPan1qjBKNur5KBRhAYmupl8P4Gf3V2?=
 =?us-ascii?Q?uHZS4WBoKSyI1h3KQW5YUkoYvVU9a99pxiE7y3j6JJ35ja8CIlKfuAjd8NUa?=
 =?us-ascii?Q?Eibjdxd1mXvGiWn/1Et+PSv5F8mFyIzFsp9YYVG7o97HdDuUXTKwLPAXEkAv?=
 =?us-ascii?Q?JsqKihGpzyrAN2x+MjJAHFkT0XP3Azks3TnckaZ3jEDwHyrQIkM8i2Zn6Yf2?=
 =?us-ascii?Q?RAmNnPB8fy9zdzyeRyYLQ3B59nR4PNmw2kF0eG33QT8loebMhUJgApccIMuw?=
 =?us-ascii?Q?JSLNVzD6WEGIhnJ2QzCyhyZohrwebmhCVgLKN8fnNLllsT9i//oZrbHiAFnk?=
 =?us-ascii?Q?mXj3GHgIcN57gxUJdEVZti2DDNWQE/4QS1b6rbOPr4chdQMKPKguh0fjDghe?=
 =?us-ascii?Q?EYHOEZewpmZPWvkMgyT1V+GsVE1m/yptPvR3ZmvlwpTmf7sQbOkZtYw3CQb6?=
 =?us-ascii?Q?Ud4uXSGdjo1ShxJVgHgUXfsh/ox3DPUblScBvZiwCYBRZBWHK84FWa12TZGf?=
 =?us-ascii?Q?r4xmoQMRZ0/loc4c5W3awlEveZVCSCnH7J6K4lw33FvATTaaybdGbWESscss?=
 =?us-ascii?Q?ax+AIPReI2HCPc/Gkn/Tywd+EP+AF/9AEMQI+CEIBV3SOKc1/ntNTNio8Mh6?=
 =?us-ascii?Q?z/W0nIpntA9r1vac1EDJUhAFlDI1N+2N5+xxuAv+dRdZUQM/Um441BpTc0JM?=
 =?us-ascii?Q?IkQve8iKOCTm+uojvvwvmrse9RfUi6ZvJ2FuEMMOL/Kczz7gcM1JYUdVT1oI?=
 =?us-ascii?Q?xJ3C6qfiyaVNp1zPd81wIWqhOl4LyohFKs4g6yBDmVAn/mfBhP2dr7QJDmkU?=
 =?us-ascii?Q?y+ejkdYe/nAtEKJr17Xmr0Zi4jGVqUI2Yg5SqYgD+SwYGfqFlymK0UsypfjF?=
 =?us-ascii?Q?ol70CO/eDgfZ5/p6pI76O0E1/naP8i+HIBtGBfYh3tf+0Pn1E1NNRTr+waYj?=
 =?us-ascii?Q?lfqka93krbT0iSLTs8Ye9iTysKs41ITICsd9b7u5O5fw8SWGy7pfywHhTXe7?=
 =?us-ascii?Q?PrP4ltTXFQsp4/F5IwYrMnmU5OUIIVcDqL0BhBkJDnHy1Npx/SkidbWnkUel?=
 =?us-ascii?Q?Fy4QOIqAr5m9WsL8yytm+Byek8fD3A/3dbao7Ja+/eu8p0JcCkYZ1dwoq/GT?=
 =?us-ascii?Q?7qApwUtWQaVRgBNf5GSS8KldYHjcNQDGWKbxFDy/5lHbdqaG8024fT72xL6Q?=
 =?us-ascii?Q?QUwDMljGmmskwtBGSlsNiX+JCL4QBUt/HbitOD13wto/fSQ80XoR+cZZtP+B?=
 =?us-ascii?Q?UgMbmS6s7tV9iIhOLQUJFYmDfQWMxVFa9mvjtAKxIR/MTblr9OaVJ+aHiC82?=
 =?us-ascii?Q?AGW3VS8LeidFTQeOiiUgtPcZYeDtlriMcz2xF6IXsHI6IgRrLZ+bhi1RJjif?=
 =?us-ascii?Q?fzJp9hl3KJtXf8lnCR4XfdQxRaj8pAIUp3ovSOfCB/Qb/Xx9DR0+F9cfLQ0e?=
 =?us-ascii?Q?m9xOH5IbmaoecdNPsXlbcxZzy+Vsqcz4sUjmLS8Ql3OjROfWOvmGI5dt1mvQ?=
 =?us-ascii?Q?QhOMVBsaWxQGTnl4O7NEX6lnSOjVbjbzWaWeYkT3KIbvpuYwszDVZEPHHBLI?=
 =?us-ascii?Q?htoLir5i0yLj1DdVjxAOEmaRnIsHCSrScv1KiS5/8VDa51U0pLyPhwzZsseD?=
 =?us-ascii?Q?ZWHSgu+U/w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6079ac9-0c62-4723-7c41-08defb2e6e0d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 00:36:37.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LfU6F23kZsSscPgMhm8wGU/f4pw4TrTxS1HF2G05kdls4toibIGihXmLHjefS9hPX4U6G36Yir5DSWbigN8QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7280

This patch addresses a critical memory management flaw. When
CONFIG_CPUMASK_OFFSTACK is enabled, cpumask_var_t is a pointer.
Consequently, sizeof(new_mask) evaluates to the pointer size, causing
copy_from_user() to clobber the mask pointer. Furthermore, the old
logic performed copy_from_user() before allocating the mask.

Fix this by allocating new_mask first. To handle variable-sized user
masks correctly, use cpumask_size() to truncate overly large user masks
or pad undersized masks with zeros before copying the data directly into
the allocated buffer.

Fixes: 295cbf6d63165 ("[MIPS] Move FPU affinity code into separate file.")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
(cherry picked from commit 98e37db4a34d3af3fb2f4648295c25b5e40b20e3)

---

Changes since v1:

 - Fixed the !p error path to set retval = -ESRCH and jump to
   out_free_new_mask so new_mask is properly freed on failure (Sasha Levin)

 - Link to v1: https://lore.kernel.org/stable/20260723181719.540786-1-atomlin@atomlin.com/
---
 arch/mips/kernel/mips-mt-fpaff.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 6c590ef27648..5feffc8708ad 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -70,11 +70,16 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	struct task_struct *p;
 	int retval;
 
-	if (len < sizeof(new_mask))
-		return -EINVAL;
-
-	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
-		return -EFAULT;
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
+	if (len < cpumask_size())
+		cpumask_clear(new_mask);
+	else if (len > cpumask_size())
+		len = cpumask_size();
+	if (copy_from_user(new_mask, user_mask_ptr, len)) {
+		retval = -EFAULT;
+		goto out_free_new_mask;
+	}
 
 	get_online_cpus();
 	rcu_read_lock();
@@ -83,7 +88,8 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	if (!p) {
 		rcu_read_unlock();
 		put_online_cpus();
-		return -ESRCH;
+		retval = -ESRCH;
+		goto out_free_new_mask;
 	}
 
 	/* Prevent p going away */
@@ -94,13 +100,9 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 		retval = -ENOMEM;
 		goto out_put_task;
 	}
-	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_free_cpus_allowed;
-	}
 	if (!alloc_cpumask_var(&effective_mask, GFP_KERNEL)) {
 		retval = -ENOMEM;
-		goto out_free_new_mask;
+		goto out_free_cpus_allowed;
 	}
 	if (!check_same_owner(p) && !capable(CAP_SYS_NICE)) {
 		retval = -EPERM;
@@ -141,13 +143,13 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	}
 out_unlock:
 	free_cpumask_var(effective_mask);
-out_free_new_mask:
-	free_cpumask_var(new_mask);
 out_free_cpus_allowed:
 	free_cpumask_var(cpus_allowed);
 out_put_task:
 	put_task_struct(p);
 	put_online_cpus();
+out_free_new_mask:
+	free_cpumask_var(new_mask);
 	return retval;
 }
 
-- 
2.55.0

