Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794330538;
	b=FiqB2D3bnsrXMQiz26rrT4nFQPhvr3Sywsu/IhjO9T564V6JPdn/0+0iu6O1iB6osdjF
	 Cm5Gxj1UMiiUPkUPXbf1c7FyTvwnS0u94chN6sCQy19IcAxAlDTzCgpuT7j7WCyzApnae
	 C67kXxZwvhZUfl/suG7BaH+VUgKAcQj15/D3Ovi4Lx4a59/+Vi8Fw5BCh41mUbx5frFXP
	 /wxZirYcAV2Pq7gPfKRWjhKMrXtkiysae5ZpQTZWHYvvBhpjH4Opv5XjJmuTdLlK/SE+X
	 h94ga+nQqqnq141CWx1CNuXpvf5qEwx4Rpkk34TmrYXUuekyCEU1APqMR5mANGwpN/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330538;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KJc/LApr+lDx/asNzwzLM+0af4bnqP0ZpAIB4TB7FJA=;
	b=rBleraZc+vzAH2T25UkUZSJT2NTRhabMcEcYCPF2s4+7hFWhw04IT2bsHDYzLOcoxRbf
	 k2aAwHTzFosaOe9SC0OJRVVIwz9aKXj8ED7rcPEHtoir7JNdTtkKIbUDczRqX8+Li//mS
	 YPjMKKE8VpuDcQlebGVLho+R5kj8hFYy5Bjw7Kg1r7m55upzzgmUJQ6kvxWrEOxn9fnjX
	 AUG1Dm4spqKZUdSVSFM/zfEqPKNJjI+8DazuCWMRa7RFGy3WDN/NkYMCEwZ/co8NLFZA8
	 gpASpGCVDFyFleKIVaEHXcC0YXwhZIdtOITBf9O/A29bVSZ6AQ/dPUZHOqu0Enlm8Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cNwHKQV7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.68
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C93606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C93606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cNwHKQV7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xmx88n02EzU20263sSq61fa5bm1RZVWv2YW5vEHUeIbgc7F9RF923VqrqFcJ6rcRnyG5GCW2/m4kMutONwGOaxhru2frxci7rwuQJRlUvrTSw6ti5fZ0kNHdtFzLN71h9v34MBT5xplIbLmAJ5pPmqykZvt51ivV0nnzwcGYoz3Sg74U8/xz09lJ7nV3abSpjh/yih4MjJqMF1FIvjL4XiL6Zite9ApGrKpFjcG4A2XeGMvdggDrp4G/ZuvXTKxADDi8kb+taq9qmTq/ko8iAR7EqmLE1fWBoHWuBGtZSdKqRikf7kmgdTBp91c6rbso6xvwysdyypFUZVd8pUvj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJc/LApr+lDx/asNzwzLM+0af4bnqP0ZpAIB4TB7FJA=;
 b=cfx5TbeIC05OHA//TS98o/sd7BbyJYok2FJomqxyOvD+R2ewc1nuW9Pj+jc7bhxOOIh+KFdPTXuu1HBlxh20chn9laHVqdBn6gXkeBPrjfDvW+7wI5AyBxC0YrXe9z4yicENg98S+lZuG9XenojG9d5gTWv6pubhPrz4287aSGwmAHUKO95pA2rEMX+qBi+EN0u7pmwbZepcPqfkDszqgKyPDYyyEyIdjpJaJ8lDzLc+02q4vEgauuMbB35sbw9BilZJESBE3iX8UEHAATAseFOKwk2B4M+krWwgVi1hhOgCErAHWRiDUHYVKvOBoN05Ys12lRDcOZ3BZIDT3UuruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJc/LApr+lDx/asNzwzLM+0af4bnqP0ZpAIB4TB7FJA=;
 b=cNwHKQV7IreOK2LkdsduEFV1wVeoSqweucDDRMLcZvx7wZ+1JC3ba1vT4ZhAUS97x4rY0G/ql80lPn2bKuezV0SVzDfTwMKNO+ODNhW9YE0aQXRVdoXRijTkSbeLC6H4fb+ZwbwraQGM8r2akDVj8j2yPmqqz0IsyM/XLbAaZgOLVkHMD5X3i9/NWzOO6TVSc9cUGQijvNxe+meECMNssZasuSwvRf+K54dAtr6clZMHVBHSoPzs4GaZ/7+bIUyxuDq+TTEL+I7J4eeZNqvcAv1JIvHYMy212HvKsJvh/pXMOz5IZjaM5d4JjzD6I/5IdaiDl9ED44JBYspETmZUEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LY0PR12MB991423.namprd12.prod.outlook.com (2603:10b6:404:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:08:54 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 17:08:53 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
Date: Tue, 10 Nov 2026 19:08:40 +0200
Message-ID: <20261110170840.2317179-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109201629-failed-6.1-7308ef8b4a67@kernel.org>
References: <20261109201629-failed-6.1-7308ef8b4a67@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LY0PR12MB991423:EE_
X-MS-Office365-Filtering-Correlation-Id: d4dc589b-ec6d-4a46-91a1-08df3f4d4c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|10067099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	EgkGHFFUWhRwtCAf99YfiNSdDvhPJZO9uiSv2G19GEGOCLAsTHdZpyCr9HZNlNwCz81JJTzbYVxEEgJjICIRSkZdIAjd39PHUYj0RqXkF0BwLttM0Sz9bNujYx9Vxt8iilS/oMd/cl0HlfGnaTpc8uHgFIQAiVi28QpfyOsKGdu21KSqH1n5jU/k+iTpZhyIjixpjyXkm5hY6EYghKPjewayfw+7aUAyd4wKrA8apiTIGLMNVr0CdJn2nyubJw+KIgMgiVAlVFitpLuZoh7onsvBb3O/ZMRHJYQNurGtVQA5VUUV3zN3oZ1DdiqBl1UpyI/JwKwozscpz/nNlPNCepTkE0gc+XU5T/6opf4sJIwo71zRM5G1R09jZoWUwVZ7SO7mrmS1sQm3bGdi7fn2LzVu3rOmWkzq8hQHxiV0+7G36qOS4YpuaTUbkzAOneVEaGGQ7fbK7s+SZ4lCJvkZh7EmYnASULnc345wJCRJJmlkFerZIqIqWFH/fb1LHeI3T7vRGcsXRhYRfJKMOcJauFLsR8BylB0zF9DFZq3jyitw1d5mwWhzgIfXxHdjlud1tlotJZvbiAyGnZmTqiTxS/sVlRwu8y7TISm8WU3Ku90a31N/ucJ1Ntytb78T4MSxsoTOKrV/LsHViAGdQH6ay69wV3+9cAKSWEicl3P/Kqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QuPppBkbNf2zdzA7IS0xmiN1o9IkOeG9n9WlMJGk0z0P5zHONUTRhJ7bvEft?=
 =?us-ascii?Q?fAk9pRK1Ps2LNTvMrWGW5CRMulo52wA1adAzRhRhOiUAr2fBDgwmxUru0ebl?=
 =?us-ascii?Q?GEdknyXWEdM75lIRPKV4gMzwSdE3RQhMWUSNPkehLHE368Rdw93n6vzrpR0U?=
 =?us-ascii?Q?jWVnA43bvP/y8BYctQYbK4ZfmEgN8R/aPJdBb7rMlQpVnTiz8GPhpc+MbSXN?=
 =?us-ascii?Q?5tyegJ7YUnBjVmW/wRL9cA3NsppjKf8Rki/qkakIM6HMa7cvzIxZ5Ldr0ttd?=
 =?us-ascii?Q?2+YlkzRA3oPTfHgqpkqhSS764AANfwVfJbaX/OYgGgKfQW+EOD/IGTtzSZs6?=
 =?us-ascii?Q?hQzKbgrjK++KLMhYbw7JQXId8OgUmKmoB0Wb3o8WaEiNvzlS02iHQUzq6KuA?=
 =?us-ascii?Q?71ENQHLto2xKvqH63IHnTcvXajVuRIjznT7g1xMya5EHpN4o4l9YtWYCrKaC?=
 =?us-ascii?Q?eqVQeOtcsrsfJk33XJE9pMXBFR8S5/c4MXQpNJ1k8NmSuzid5J9k1Ql6Uqcz?=
 =?us-ascii?Q?5eBTiKHduvV125K0Tl+3CyzlvSJ6zI0SPWNj3pfcAwbaecNX+1mw93rwLOK9?=
 =?us-ascii?Q?Ct8SNYnE0zPckjwsk8OiltpNucCETLXkHwmU62vs7j89tTilXIDZMv5rV/Qd?=
 =?us-ascii?Q?FDKZXpTLVvsJu9kVC5OVlrwabvGvb2DhtKjosKGqhVBEsRIvRztkalM8yxVI?=
 =?us-ascii?Q?0KHOcSglEFhPh1pKZsJ7jmw0U2UDKVgNF1j7nBQLCtEkFbcGD+ZZmEGQGNm1?=
 =?us-ascii?Q?72ZQrta4RL+M25KXCOldDZrxIC7kJXolCofJLJLqgDOgpOuv5BtKkpgIaZog?=
 =?us-ascii?Q?PICLlDpWlJxPOsfEkOsOICRXL++s3PG9a3UeZhPE3SHZZ6/RH3vPkZPgHNR0?=
 =?us-ascii?Q?ApnUkwz94s2eIhMZGmu6alTj7d8gYjeQMnXXFxR0R1JfGKWykd4L80GyrLUS?=
 =?us-ascii?Q?DdJ1cr6Lpf3/n54BNwEpHfohZVlnkw95aOMKxdIBlGxgFOIrcE4P/ht3lnPM?=
 =?us-ascii?Q?tB4ZNYq3wzlkGnJ9wMU0cSZAI+bR5qddLcYwUwX/n+BHrvvR4zH8JbdMgXws?=
 =?us-ascii?Q?mjzz8koX2Q4QIwSXO2czsq99vUayFFAJAhA8CGRo2CAwA3kk60qKtg0KZqVu?=
 =?us-ascii?Q?p7bZn7+5+jt9YlJLJNeunrfmwOdelWsBYra8urT61zdg0FXgW0WgkXVft3Bl?=
 =?us-ascii?Q?a5oeFyMWvYxdrTCM7KtkN51e/SLmlLmKDEudk1gkdXm3YDHHej0KYLr2f7Vx?=
 =?us-ascii?Q?ohl5rVvEdRhakW4MkuLVR/VBcfrnXg2QMfqq+l2+a6IaG7UgYFPUalJSTrKy?=
 =?us-ascii?Q?eyiyZSDxtAku2MCeWMHm+WG8yoxdDHRPArwStSiui0MsCSktNdoikFK1cwDD?=
 =?us-ascii?Q?XPYJ+3oLG2HOAwfs2wnErycwFBVshKuxlmlTeZLs7rzKQC7Vq+sOjGds+ho7?=
 =?us-ascii?Q?f6ep4lQKOkUCQOu7O9fVsL95XuwDvtJ79lRK4fEbmA6/XK9ANByiZJxeeo1H?=
 =?us-ascii?Q?6YU4I6yxxh89BP8vngBwE8G0ny5O/0f8tgpTQOg15h2hWZtgsc+/mfLHYK3f?=
 =?us-ascii?Q?BwgWtJ9HTOHE2PreMzcUSwQG/ce1dOTSZevVAWIVt7PmSllM4WGwE8kuXxsr?=
 =?us-ascii?Q?8wGFBW7aaaCFXbzfgSKAF9wtLYsFHtzRThrQD7hIw2u5ucvRMfixnn4QCMW7?=
 =?us-ascii?Q?70L+e/9lzvbeJNtKViGH9zs3UswFJhb2ViFmHJg5wctZbevfAMD52TaU3ilK?=
 =?us-ascii?Q?W6aodk6rtA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4dc589b-ec6d-4a46-91a1-08df3f4d4c76
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:08:53.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ql/U1XxteEQ+i+7Sqm1FwRSaUUF66m8t+5k9GNf7vTS//veuka8MzFrnaw4PNR7NvaG6CMITpnmTjVGg1VVVZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB991423

[ Upstream commit 7308ef8b4a6779a39f68d053c19b53a5c584a663 ]

Commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a
nexthop id") started rejecting FDB entries that point to FDB nexthops
unless they are configured as "permanent" or "static". The intent was to
prevent such entries from being aged out by vxlan_cleanup(), which runs
without RTNL and can therefore race with other VXLAN devices that modify
the same per-nexthop FDB list.

However, FRR installs remote MACs that are behind a multihomed Ethernet
Segment (EVPN-MH) as dynamic FDB entries that point to an FDB nexthop
group. Since the above commit, these entries are rejected and traffic
towards the corresponding MACs is flooded to all the remote VTEPs.

These entries are also marked as externally learned ("extern_learn")
and are therefore skipped by vxlan_cleanup(), but exempting externally
learned entries from the checks is not enough: vxlan_cleanup() reads
the state and flags of an entry without the hash lock, so an entry that
is concurrently changed from dynamic and externally learned to static
can still be aged out.

Instead, remove the checks added by the above commit and make
vxlan_cleanup() skip FDB entries that point to FDB nexthops. Such
entries can only be configured from user space, cannot be learned and
cannot roam, so there is no reason to age them out. The nexthop pointer
of an FDB entry is set before the entry is linked and is only cleared
after it was unlinked and an RCU grace period has passed, so it can be
checked without the hash lock.

Adjust the test cases added by the above commit and add a test case
that checks that dynamic FDB entries that point to FDB nexthops are not
aged out. Without the fix:

 # ./fib_nexthops.sh -t "ipv4_fdb_grp_fcnal ipv6_fdb_grp_fcnal"

 IPv4 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [FAIL]
 TEST: Fdb mac add with nexthop group and extern_learn               [FAIL]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [FAIL]
 [...]

 IPv6 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [FAIL]
 TEST: Fdb mac add with nexthop group and extern_learn               [FAIL]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [FAIL]
 [...]

 Tests passed:  44
 Tests failed:   6
 Tests skipped:  0

With the fix:

 # ./fib_nexthops.sh -t "ipv4_fdb_grp_fcnal ipv6_fdb_grp_fcnal"

 IPv4 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [ OK ]
 TEST: Fdb mac add with nexthop group and extern_learn               [ OK ]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [ OK ]
 [...]

 IPv6 fdb groups functional
 --------------------------
 [...]
 TEST: Fdb mac add with nexthop group and dynamic state              [ OK ]
 TEST: Fdb mac add with nexthop group and extern_learn               [ OK ]
 TEST: Fdb mac without nexthop group aged out                        [ OK ]
 TEST: Fdb mac with nexthop group not aged out                       [ OK ]
 [...]

 Tests passed:  50
 Tests failed:   0
 Tests skipped:  0

Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Fixes: 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a nexthop id")
Cc: stable@vger.kernel.org
Reported-by: Sascha Frey <sf@techfak.net>
Closes: https://lore.kernel.org/netdev/20261028142928.GA8406@techfak.de/
Tested-by: Sascha Frey <sf@techfak.net>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20261030133750.28668-1-idosch@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ idosch: fixed a small conflict in vxlan_fdb_add(), adjusted the
  vxlan_cleanup() hunk to the per-bucket FDB iteration in this tree and
  open-coded the wait in fdb_entry_aged() since slowwait() is not
  available to fib_nexthops.sh in this tree ]
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c              | 14 ++-----
 tools/testing/selftests/net/fib_nexthops.sh | 46 +++++++++++++++------
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 893212fad6b4..83e809114d4b 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1054,12 +1054,6 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 	}
 
-	if (rcu_access_pointer(f->nh) &&
-	    !(state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "Cannot make a nexthop fdb dynamic");
-		return -EOPNOTSUPP;
-	}
-
 	/* Do not allow an externally learned entry to take over an entry added
 	 * by the user.
 	 */
@@ -1327,11 +1321,6 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
-		return -EINVAL;
-	}
-
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
@@ -2979,6 +2968,9 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
+			if (rcu_access_pointer(f->nh))
+				continue;
+
 			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 14476b96cbf4..9e25a4fe882e 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -397,6 +397,20 @@ stop_ip_monitor()
 	return $rc
 }
 
+fdb_entry_aged()
+{
+	local mac=$1
+	local dev=$2
+	local i
+
+	for i in $(seq 20); do
+		$BRIDGE fdb get to $mac dev $dev self &> /dev/null || return 0
+		sleep 1
+	done
+
+	return 1
+}
+
 check_nexthop_fdb_support()
 {
 	$IP nexthop help 2>&1 | grep -q fdb
@@ -481,14 +495,18 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Fdb mac add with nexthop group and static state"
 
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
-	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+	log_test $? 0 "Fdb mac add with nexthop group and dynamic state"
 
-	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
-	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
-	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self dynamic extern_learn"
+	log_test $? 0 "Fdb mac add with nexthop group and extern_learn"
 
-	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
-	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+	run_cmd "$IP link set dev vx10 up type vxlan ageing 1"
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:18 dev vx10 dst 2001:db8:91::11 self dynamic"
+	fdb_entry_aged 02:02:00:00:00:18 vx10
+	log_test $? 0 "Fdb mac without nexthop group aged out"
+
+	run_cmd "$BRIDGE fdb get to 02:02:00:00:00:16 dev vx10 self"
+	log_test $? 0 "Fdb mac with nexthop group not aged out"
 
 	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 66"
 	log_test $? 2 "Route add with fdb nexthop"
@@ -575,14 +593,18 @@ ipv4_fdb_grp_fcnal()
 	log_test $? 0 "Fdb mac add with nexthop group and static state"
 
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
-	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+	log_test $? 0 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self dynamic extern_learn"
+	log_test $? 0 "Fdb mac add with nexthop group and extern_learn"
 
-	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
-	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
-	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+	run_cmd "$IP link set dev vx10 up type vxlan ageing 1"
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:18 dev vx10 dst 10.0.0.3 self dynamic"
+	fdb_entry_aged 02:02:00:00:00:18 vx10
+	log_test $? 0 "Fdb mac without nexthop group aged out"
 
-	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
-	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+	run_cmd "$BRIDGE fdb get to 02:02:00:00:00:16 dev vx10 self"
+	log_test $? 0 "Fdb mac with nexthop group not aged out"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
-- 
2.56.0

