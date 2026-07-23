Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021072.outbound.protection.outlook.com [52.101.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1D355048
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830652; cv=fail; b=o0u5lbnn2sr6LYNjSCLqlY5B0ju6kTcqxdSgHcmhKoLruXSckkeuDzPKNHpoMaoLFYZYIAwO9ZJfkFV68T+lkaWv/7u5ZxKs+usNaDrf802OP1lSDjik1siEFBKXHTr7hUp5NI5J3d0un1dITR2YyM4bF7cGOlbF+dzckAbB36I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830652; c=relaxed/simple;
	bh=paQQjIxwEZz4PgtRrWznV9AHS31myduFJr4HYRR46Fs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uxFaJJwiDkiYJyWsLosXJ9FR83/RA9LPszwLeJUX3UCqPxeH1DGzgjhh+82u/Lrs7XKfAp51Yy96z3wCAsf+vWrPSiAixO9NvKpEvxUZ57Ai304n+QjBpVECz9TW81IMlnE7ZGpLL0sRIJAVKpXdYfywpx5+CE7S4zeCxre3RKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2M2vFly8omBNomjeftq7IyiTXgFu8HLEQdEgQNg/1z64bLHo1pzZUCpTGllFle35BANlQ8tHKUBNQhERH22ZRabKb5i7cb5D6xODiT9zfnLijXHpqHJ0rdub/vF1GT2rKtDWlEcc4emKl/yWHOQxIMNAeys/Fq3q/pCnsLs5DwSRqnkZEFaoTcWoV6hEITCR+A3CK9P8OZ6t7+o+2GMQOXSqImi8qzWgJSVKeZODQ+Qu37hT5GWFmmybrOjgImG/wnw7luk4v8Ion16oEboLmrxM+995SFnkzRTU6nNiuTcjTZrQjsLFW65RugTwgts+u9/vuVnCvLXm695g6KsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=KqdtM+rQjRMNCumQfCUDyQVc0tBxWcWhJVStPSWKnGk=;
 b=l+r0g9BirmmW3YlKopc+qDYKUHFWyiaWunr+CKVkoMf/rZV7RQVY7mw8L0KNywznkGTROknEARESfNh66rNkxbiNyoJR8esA9BXmsfpxCsDXx9hUGMaeKsURXzANc11AzzFHYav2JFRueqzcGXursrGcwbfC+t/iPyfKowGFSOJl8HCOcWvMHneEl/1k/9/+AkWkA7b0u2yHOxenzJ8OndarUTMZ4Pe5pGARWzkkAIziinTmvuXPRTAMbgWQ1aIj8NNhlgng5w3BhKg+Ds3psrM7jzRlYBQRWQ0cP5x5tBkmwfwtVJ8tve0aUoC5hvaEUFG6Ku05ijxDtUxWkdSVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3989.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 18:17:23 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 18:17:23 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] mips: sched: Fix CPUMASK_OFFSTACK memory corruption
Date: Thu, 23 Jul 2026 14:17:19 -0400
Message-ID: <20260723181719.540786-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072000-riveter-snowsuit-903d@gregkh>
References: <2026072000-riveter-snowsuit-903d@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:208:236::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3989:EE_
X-MS-Office365-Filtering-Correlation-Id: a5539352-9056-4680-9a91-08dee8e6a41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|5023799004|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H4Ftli/w39dRck6noIAFh3JL2QEwm87d6yhSdSlJ2P7PJrze5nKa8PfjFKKFl6Tu6tYgC7LhrmxEZko/9C8PL5gUwlj3E0dWv04JN3tqNBxGT3AUD6v6k9MZ4mnBMdIQsUT7SO6q8OAgnd4ixFZRYSg5QmwXXL3xplSIZ0veDqG97kJ6e9cv4KJpQNWXicsiXTxRgn4IiThjkdji3sDy6kWn/YAWeYotMBw3NPIAG2KEqt+s3gn+Op4o2CCR1yA+x3LZylIV/SbLtYzPOKKi9G8Gyt3LXitc7ImnT2/gHygimGBnELWkCK7J95APV9ObTuudceNcXfZALZf66GvN8GJqkU4rPz2PVXEIwTNww4JMdivWmJOjY4EOLAURd4juYoLS/id7cAVtfI82H02wVT7n9I/WmpnFMgdeY+cPvLJgUlhpSyKL5D2CVIAM0y28hi9u/ebMVK8z1tH/+O5/J88Ly6Yt1Ps5I2GVzMxbgGAgyV8y1SkEsxFsuKBXqP7cV/VcRkHeDH7+edC7Ta3JGOWr05dlKz+LbLCAqBb7UykNOx9eqd6q1VX1Tlz9P9XbwrokJqM1ep3026kgtLxSS/24Qspl3x++Wip0IULwUEdZYJfo/P7b5TZUAqIJJabb4x64d3mg0/gpfErkaIpv4OYFFwTN6wtrNYpj6x2MkL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(5023799004)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ix5y6lE+5OXxOKItlpikVdbY91S0j120aURufbhqeESEGhWtwUl5lvAYiYRS?=
 =?us-ascii?Q?CRIdVD4CeZu3ThWgM66oSJLPnVNXm750jllvSyOG60prCso8jBSoSxD5f9uP?=
 =?us-ascii?Q?thpmsITF+7lOh/10vokPEFCaDtNp5m3SF/91i40tGznT6dQT/Qq9E/wJQ8qn?=
 =?us-ascii?Q?AL4cAZdojwmxMNbNhCt69PzfO1fHTHhjZM56z2CGFUM6wTDtZu46ClLPlj+D?=
 =?us-ascii?Q?hF9JN+BvQs7pVshml3r4nJAOz7Ubm7MRVPwRs86HAlaydIOmtfnhTdYEfnGX?=
 =?us-ascii?Q?gYdnzwlyxplz9zbStsbtCXHaF6RZyvr2jz9hIQYQlOMQeiJ9hsn1jUnOZYtf?=
 =?us-ascii?Q?V99KNS1jQaCFdGB2nV+soRy5U0Gky0QOydqU1GJbvAWXg98mZ8Bhvgi6VYRL?=
 =?us-ascii?Q?Ha7SAKInd+RCtSS5nmMg5T4dHKZGoWTZrizlgqZs6k8e/F2h6BteDkehyxMa?=
 =?us-ascii?Q?vP46qPwVIzjW0j0UjZN9RFsrlNsywPe1a6yjFtw0WAYFNx43Lr4Sw9VXW/cv?=
 =?us-ascii?Q?hNLelwG/d+dmfBMn0RMKUjC1eq4qJknAOYE8GhoPWRyd6UOhKPaQACOm0MyY?=
 =?us-ascii?Q?V7/Jg1OOt7rJNT5O9oZR6FdGl2PM1+F1cUZF+MICvwkTDaHPt7TyYGjfXOXH?=
 =?us-ascii?Q?mVPfAlda/0GVqet8sCMK7vsL3Pl/gWd3IKtLMW5s8puL4kLYGnbDL4fJzwuo?=
 =?us-ascii?Q?8skuolbuaWM0aSu6jdpiIOk2st2eKTfJcq5iTdRGhIy2646ii2N4FpMOHDUv?=
 =?us-ascii?Q?gzt4KOFtnKl0d3EQ25pxsh9uJOMsS86wuZv/BNffC5LZtrtlaJHk7Q58iR8v?=
 =?us-ascii?Q?CWqdrWT7g+EFxU4kOk/FWyDOrCWqPlAFDZgsCzQqRLBFdHghm+D1o/tLx+vn?=
 =?us-ascii?Q?fZei+4zr2T4m41HnkVBok+h3h1TV1093w41Oc8brlghK0fZJYAySKu/DJ2bO?=
 =?us-ascii?Q?tvqoOsSwWuCsjzcw3iPLMhRpfqLH/0yXt5XHxpAj0Ri0/nRXPmizpUhfLjt+?=
 =?us-ascii?Q?aDhZpRpwiuqeNqnGQyvk/bW1mYmvNbOI+HBJgg+Pf5LPGUJfyGEiuV5B2SYV?=
 =?us-ascii?Q?7ef/whVoAK/t3nJBv99tx1pT4ktM58vsY5hA2vSyuKC9N51jQTa7jNSKdo8n?=
 =?us-ascii?Q?kJM07VYEx4Kxq3DnO8+NRWGnaieYgZFgyewTEpomNPVNl4Sm+72S1ZAqmnmz?=
 =?us-ascii?Q?T8wkz7qxix21M8hDrp1yyB5R7cr039mjpP9QMkjEveDBHG9H02iRDOE2rPVz?=
 =?us-ascii?Q?DXiEwe/fhPuNrC3WflkFV2QX/7xN1cNIfnfY3WUrfBAsfwhhhJhgLAev9fuc?=
 =?us-ascii?Q?Bl1S9jpgHXDHC3NHDHxfw7kcfHO1mwjqgQ9P+cx2zLHplkdSJcbdVqKJvSX+?=
 =?us-ascii?Q?hOrp0Fvm5Acf1UPtpAKvP6wiOo3Svo2s+DQBRdCOyrNYPbwYHLF9T+S+Uprr?=
 =?us-ascii?Q?hU4f1L3M5qU4FXLVQyFWYGkvRS+mRcndeZQPsO5mUkpWGku/byxZj+LUSwsp?=
 =?us-ascii?Q?atXy0s/6WA0A4w4YIR+OIxqvEuNSY8tHLV0qTj5lBCQE86VefbhnsJWaE/Sg?=
 =?us-ascii?Q?QDmXj69RneA4aIc1P0nISX2IhDbkzKsdQmyenli7RnKIFx/Db5vrx1Jy9Uj7?=
 =?us-ascii?Q?Z0vDtQMnXtioo97KW5aCHpeW/Ttt1ppMCOMNGVEEFgr4k7hlWGEbZaCmVKGo?=
 =?us-ascii?Q?tPO5bT2qR2VVcNmocx02JbJGIjejpC0BtXSQry+rAxBqcKbpt3pKsGm3nBJx?=
 =?us-ascii?Q?SlFJrqlHVw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5539352-9056-4680-9a91-08dee8e6a41d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 18:17:22.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCdttxgT66pRavVnhLKSHEak9x5HgBspEdYSuytI9CY8qEJ7bI7SEmYNvfKX+L7Q89kt+kek8z+mKDSXzD+pdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3989

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
 arch/mips/kernel/mips-mt-fpaff.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 6c590ef27648..e0f35f2bcdf0 100644
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
@@ -84,6 +89,7 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 		rcu_read_unlock();
 		put_online_cpus();
 		return -ESRCH;
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
2.54.0

