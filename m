Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794328506;
	b=21uhC5PNvyOV7dnbsabLynl5NhPnRKV48U2y+nq6ErCR/rjS4Rh6fW2MeMEJ1yH+pwS0
	 lVLduAgoBnwT7uk9QwMclNi1zS+ZONfhdfVHqJVCni0o/EgC3TyoBBB6nQ3RP/Nw8ToVq
	 0IG8bMCFfL2Ofi93f84T9QTMh7s0VA6287TCvSS4SGtOH8ptXBgiJUSl9sMlMl2jV0aRd
	 Bw2UP+epmNCAlVgtVLbk8aiUOgiwPrI3FT1zOyTKc5tRf60YyY+LICBfhKk6iT6iJFks8
	 ZFGQn+cSp6HWRNKjLOCjJpkPdbAKgvY8KnOiGi29Dwq1tGjrY9smTA9JO8a3Z02gwNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328506;
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
	bh=RW7n+hZg/mEco5yaPMk+2sefHheA/OtCH6qNZ34prUk=;
	b=TBP2Kj2dpy2aFZ3yy7IMwIAtU3fWCZuhYbCRgwNdZHxP5FBHop+tqNYTbEIsZiU2dUKD
	 Q7Rfb9mfHWc5KSnq/94S887GeQd0NiQrVc80ocZYFeF4d4NdLI+Nnr85k9HZ506ABtc2h
	 7lrB5ZPJTFwOTwV9efsblfv7htW4wEj4wmZwkxwZzbWOGO1CLsHfJzcYus1iBBv1BnMV1
	 oQdMCy6NDT2e9iQWRP6Lg3YATpDAUIMx4Q5Jq+hftwHVsjSMcplz5gPPrqDkPi6zfLL7U
	 FLZ7xoC5dLeM9mcx/b74f5D/WkHq03mEI7qxcGLJ/Y7vqZL2mj44VHyXiN4op5ocdrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pBG3EVmd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.53
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81D606A883
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A81D606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pBG3EVmd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfc7GajVtJnxxVBneo7wk6XgpSkBWWKbPwibhs8+FJQ2jvX1eIBefem0IHziwUKGfazuWXsAZ7ZCkJno6E3l1dwxcbH0H45+bm3VkcPOe4RJ+wCijoIQgTEkgJRWQybf2zkhy9Y1rmGVk/yyUio/bkYGSkAmvWN702iPvEK2v61fDiAyalGbwPe1dslKkl6hWq+ezRHGtujqi811a4kRVqx1loHXAcqa2uluEzo63pAc5uVyWorQO4ZwzfSeSxgzK65yG+6g4mqEGRr1z4o3rbUiBoWg0GK9wWQSin8rcBvKYs90f7fWBvfOAecezI6l/LwYhVtD+AjpGrVTcBr/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW7n+hZg/mEco5yaPMk+2sefHheA/OtCH6qNZ34prUk=;
 b=jPacXCMB6svhGyUzoHUn5EANDe17bihrlMDLo8Zsz/JJd4u5wqcuT0QG52C4laQc4xvRuWoax9Mj0TxSz1jiEZ6R8wghg581HB/8gx0+z2OtWHF81rNbOEw+Eh3EBi8Ay+ogRMIEktmSRtSvUVB4fC1u5+1pWEj/b10LPBnS7CQ1G6H171ZPTXbdQuAqlvdnDhxlzc6Dfekf72lpfDL/u1IVpfvj5W7bsircFeBPb9l6dpHicnZrCxnZady/9dXxKVsj+qm6ZYQvrhTFkAyffF5ncKcQNrHP30pFUvscZFbY4KNsaWik4MjTaaOp/kr9N5g/40qbMsBitBvkfAEHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW7n+hZg/mEco5yaPMk+2sefHheA/OtCH6qNZ34prUk=;
 b=pBG3EVmdA6GOuIFOMKrbh1pwALkuEZu4x7hKdIT/BLYT6d9gqLiXxBvsRdhyuUZarMGc2lHG1UV/+8XyAG4w+I3j5edUCRNqUlvvGR03E2AjWUmY/88D0rAh4y4EDQWZWTrGkF0x5+QOLvmHk6csXJeDYEPwWLkXnuPovBd6Kg7yBzl0fY3dSjRYwmFz/ctpaIpoBMUUq11Iu3CTHvAv57Da0lSqrwYi97P+kbuOmYw7Y/7Mx9x8OONR4JlevNvdh16zawfSTccdDRfJz+SSq/9I/80e1b4YzJvaKN+sjYYCIitOMtaEVA2Z0g2rroMaGnsaYTLDIYuPbgjGAXJGgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS4PR12MB646950.namprd12.prod.outlook.com (2603:10b6:8:4be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 16:35:03 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 16:35:03 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 7.3.y] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
Date: Tue, 10 Nov 2026 18:33:34 +0200
Message-ID: <20261110163334.2275922-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109200127-failed-7.3-7308ef8b4a67@kernel.org>
References: <20261109200127-failed-7.3-7308ef8b4a67@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008D3.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::433) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS4PR12MB646950:EE_
X-MS-Office365-Filtering-Correlation-Id: 55778cac-5a5f-4550-6da9-08df3f4891f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|22082099003|18002099003|6133799003|261022105027099003|10067099003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	R/0OOnyGJ2xWmi8m2qk5QEzMEjagnmaWOJ3dpGrYo0zYpqzpQ4nmIHvK1KUr3qdTdIlf81IpdSbsS/TJ+Z+pAzC3RSPLxpVOk23wXPUFvgebKjR9f6uVE6PAvEv6law/oe6p6UUqiKvLoVn2nIhd7rGvGUt3jeXsM6iz21o8XbPfIQ7jswNCsy6DCHpDzMt1mrsRylM97b0PESr6PCmsmXFk6fSGrU0KkC7VMmiNyKzFVpPPp71fs3Nb1ilQai6s+8+oy1WDclbbHdwe983y/g0IiTUpruMU+b7BM9YXs2iLDPYrVftJzvZ5cVBfODm8l+1U+rv8h9RQ9rWFSDOM7c5Ai+225Iu4xW2YXjot7jVZJZlnqpL1Li9CWtrDBfm4xn/7B2y+DjVLNaX41CtCcS666DicrxUyq5wdRAN2ShehIft8AWYZY1/Vnkyqyp/RN3wrAEgdXPnNRVNVLMAaXZm0H8s4P5MaSaRP0rfpBxzJG5uGXRUo99J+r3Fuka0ppTqEXp+c/RZeTvuegNofw5S0dNkbPyq0NXDujwucoisqibb6PxQg6t0Vlb4QWCKIaMopbRwqdDpKrSxZ8e1y16oOweFDB121V7kEXx/KsBdtxvD6tKE4XsWNoQDbeJNpavBSCcHhsD2V8pO3Mnz+nVIYqg+jHyi1K5GqbapMTz4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(261022105027099003)(10067099003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Me3WFiBluep0b8U2VpHTAgv666rEPpL5I4kv5mogJ3qvAhQpo+U2h/fap3C+?=
 =?us-ascii?Q?r4ey/sa3j0ai/EuhI7QLjbyF0XvzYHFXVGQWvgQ2wtDQSdhj9+ig/ZA762xv?=
 =?us-ascii?Q?hQfV8M8XyEtf1V7rFGvKwbEeU1lEK8AAdLMdHacZzG5zfsYzPyy3xgDP8QM8?=
 =?us-ascii?Q?TycczpivsE0oj3VKrxsK/nD4UXTxykCyymgjWIl6S366/lpaJl0JCNvFnjks?=
 =?us-ascii?Q?r3SYUu+krFIhERkXregPvZG2i9apNbBAC7Trdm3mToUdFt9AU97q4kvSElZ/?=
 =?us-ascii?Q?b7PtGVE3dQyq7TZxJJ35qPO58joIqxYwat+nMeVDSmwARw25KIAOmGWR/oBH?=
 =?us-ascii?Q?9ltF+WIpRgn01XZiZ7hp3CrxX8AZ94F8D/4+BDoRn7K8E/KRsnL5pEMkieLD?=
 =?us-ascii?Q?jjbBj0Q27281EwvEF+nLCloooH5Dr0uBRy1VR1dv0NmdKwLyOetO0PbR71Fp?=
 =?us-ascii?Q?STKYm6w8ZcIDyDvbOMdVUE9qPbjm09CvCdL0ZwyrgULLo9bVpZiW7YerXYlN?=
 =?us-ascii?Q?6dw8PrsdA3GVS8f9rM401iwRYjc77+TCswIO6k7p/IHLCfEMphumzybtqANP?=
 =?us-ascii?Q?hnHpR/i90koBSjUnSiogshjzbfHwHqrQ69whUa8DbqF3LLBziytWPFaJBeW4?=
 =?us-ascii?Q?y6Y3+OH+lxeHS4p9mFO9baQrYuYnEa5NGHjtZgCC0+/zxNPJmd1928g3WW5q?=
 =?us-ascii?Q?X19aDv5qPKosq3p5iUcOPWEuaf0LfP/FOY4DvSBx0D4tjm6wj6MQEp18VhHz?=
 =?us-ascii?Q?CpHTXXph5jmAGQuEED7f8oepjWavehCWWuqZ4+oM8grKRkJrI4tX6vL7qSmN?=
 =?us-ascii?Q?O1Pz2W5sDxU9NY2RUS8kSZPYX/xMY0KvuK91O/al27/VcwtnmdmogAU/nKFz?=
 =?us-ascii?Q?GKlkrTK7R2dO5OSSFurZ1MdU42f3yCnePRavxAYg4+9T8gCNR76QAJJsG1zG?=
 =?us-ascii?Q?YYpdLWf7RANWW4DyeMPXQabNDCXdAtIUtgworyq6QFXJZQvD6B11n0q7FHg8?=
 =?us-ascii?Q?69JEHsO63N9Q4WOjIz8c0E4d2rtpS/7ifNJshue328Q2Lm0R63FdJu3XRWRb?=
 =?us-ascii?Q?0Up5oZnYowewgpXr/UAPb+ZcCDQNtkd1HTWQMmRZnUb9WcH7qK2M1KCXQRDg?=
 =?us-ascii?Q?giq/NPqiJiY39OcGRr3FBHcU7OHfPD7VaylQgpvXeoCucUY6X85gzSFlS9Td?=
 =?us-ascii?Q?27+vTC0tb9+5aIFBlE0e4wfXmpA3NFCPUXDm+lPeXQxMinZXWrV/pl4t0O34?=
 =?us-ascii?Q?0wGEE0uz0Qw7db/5fVwAuERitT7p6y3MasiKwhPGBLy9UdgvaCOHtflZNF+j?=
 =?us-ascii?Q?FDNxKclbbqEsEvmnauFfk6o5vY3WZ9Dm/FmHm+JEz4WSuyBczLfpH/98jGU2?=
 =?us-ascii?Q?cE3Kn8UW34q/YBkCUWj6YiPEI/u42mOaqz+nG5nh9FFrecg2XTzWRJn/arh1?=
 =?us-ascii?Q?jUH4knW/Bd+vCENG9GnJhqCN8chei6fHRMS1KjYHgNwGFNHBJwel8AKPuyv0?=
 =?us-ascii?Q?/rIZ/PCH+TOkiGPr1kUx92TbgGiMPorE/NHzYYuvupp/XThGUz4UvUJs3EFk?=
 =?us-ascii?Q?3q91mmlBWFEyuWPQ8TpO2MmuV2DuQb0NmowYWO5sa1gPVc78SQAUrfwW1zXa?=
 =?us-ascii?Q?e/UeL3EF/tJf0pphEzun8LBrx8By32twaY6fG9IE+rZZRy+p/eoeJkfMFj2A?=
 =?us-ascii?Q?YO6AEGgusSw6JsgufeSNg5mujlxbU9mJNaffabj/r5V6es8VGl9Mwim8ksnJ?=
 =?us-ascii?Q?KZ2jhfWlyA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55778cac-5a5f-4550-6da9-08df3f4891f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:35:03.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+ATxZZepENAE7bRX+LrIwZNxWnVXeJ4U8bKhj2Qc88WG4kGPnUydodvvV4tPs6HCI2cUZdIZzn7blI46bYBAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB646950

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
[ idosch: fixed a small conflict in vxlan_fdb_add() and vxlan_cleanup() ]
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c              | 14 ++------
 tools/testing/selftests/net/fib_nexthops.sh | 40 ++++++++++++++-------
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3390e341d1e5..7ecd73a5a374 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -996,12 +996,6 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
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
@@ -1263,11 +1257,6 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
-		return -EINVAL;
-	}
-
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
@@ -2887,6 +2876,9 @@ static void vxlan_cleanup(struct timer_list *t)
 		if (f->flags & NTF_EXT_LEARNED)
 			continue;
 
+		if (rcu_access_pointer(f->nh))
+			continue;
+
 		timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
 		if (time_before_eq(timeout, jiffies)) {
 			spin_lock(&vxlan->hash_lock);
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 431d7bed7622..adbec51917eb 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -425,6 +425,14 @@ stop_ip_monitor()
 	return $rc
 }
 
+fdb_entry_aged()
+{
+	local mac=$1
+	local dev=$2
+
+	! $BRIDGE fdb get to $mac dev $dev self &> /dev/null
+}
+
 check_nexthop_fdb_support()
 {
 	$IP nexthop help 2>&1 | grep -q fdb
@@ -538,14 +546,18 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Fdb mac add with nexthop group and static state"
 
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
-	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+	log_test $? 0 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self dynamic extern_learn"
+	log_test $? 0 "Fdb mac add with nexthop group and extern_learn"
 
-	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
-	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
-	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+	run_cmd "$IP link set dev vx10 up type vxlan ageing 1"
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:18 dev vx10 dst 2001:db8:91::11 self dynamic"
+	slowwait 20 fdb_entry_aged 02:02:00:00:00:18 vx10
+	log_test $? 0 "Fdb mac without nexthop group aged out"
 
-	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
-	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+	run_cmd "$BRIDGE fdb get to 02:02:00:00:00:16 dev vx10 self"
+	log_test $? 0 "Fdb mac with nexthop group not aged out"
 
 	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 66"
 	log_test $? 2 "Route add with fdb nexthop"
@@ -688,14 +700,18 @@ ipv4_fdb_grp_fcnal()
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
+	slowwait 20 fdb_entry_aged 02:02:00:00:00:18 vx10
+	log_test $? 0 "Fdb mac without nexthop group aged out"
 
-	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
-	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+	run_cmd "$BRIDGE fdb get to 02:02:00:00:00:16 dev vx10 self"
+	log_test $? 0 "Fdb mac with nexthop group not aged out"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
-- 
2.56.0

