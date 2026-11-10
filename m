Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794329975;
	b=pX6ZVcR8HQqFB8DiqqN0Aw0P0C4vVKYw1oBMlg4r5SQk84n7gSzSOLfZDg61XkBUNoCw
	 ZtspIEagZlJM8vU8UMhAEhsVtX7KQg9txE3KKIyQ6KDOEDwWAVCcFXrZdKzfwBqT1TMyg
	 a5CiJyom/EK4O30Wpyr6Yu+WQYYcBLWLPfcTmq8BIfOYAY4Oa5apHnubJrKPGyfvfvdqO
	 mks8h1VAt3aQRaYYxAl/udo6EFTCpsSuT09jeytMz5YiTwDklaD7ILcSPMWMwkA7uyCnO
	 0IVOtS7jRXWot+kVUFMbe+0K0UF8ck0znpZb1aQ8MBufe6b8fmf6Mn39KzAMFmENgVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329975;
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
	bh=w8e/Of9DTqiIvuKYpY/uMVIIbZBG2hxHBIoletkgGqQ=;
	b=UQqJGPDcXN4GXT+8ZOfb9yfqcgm5xiUf8AQeHr0j8Mag9ci90g4/meCCXoCpp1hRqvJX
	 2BfpYxcRiYV3ovKMMl5mbq9VFRmHpG2QqMBowoPmohv9UdFaKlgGFNwkDoVpmyFMRjBxQ
	 zH9wCTno2Kp66R04F2QKIalWwKPHAT4LOmy3+HK6af4FUkzEK1sVwG6gzJ6MQ05fB2k+u
	 Y0ERRrQZTmsOFdosUpKY25wfMCBsb0KkZzc/pBE9/HMCqeETfJr79Kk+EeRezpghsw/fs
	 KrIHWk3C47C5v+XEN0m43r4YWUaA4nUAZ6WHYGk4e/BA4pgHIULJN/w20yrDltTTYsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ba3F7sZG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.15
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3426606A33C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3426606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ba3F7sZG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyziXW7AGAMkJrMseJeloivJBoUKMh8fcn4678488/WSyB8dfj/3O7H4r/w8ExFBlMv9r/rRsF72lPNwki1EoOG2xtlVyG8EBjfoVck0hNFfY7TjVAJ0Wcrn2/5qPwRbpJtHQ2rThSVpp7VwvSzdal+w0OecV7i5Ep2xh/brf/xsSrHH+NFvx5i9vQBBGNy/r7sXDh1iwSqmP08c6X49PL/6e9ag6ZsaKxkg0fodw0A+JTy9vl386MUs65pI9Mi7kmyrb7jCYnma7axofksfj3WY0TdSvERgj++idh68Uqm4zaMzeypDt4GTYtCbOOGzRhBIy7FFojjsOuP3uq7Vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8e/Of9DTqiIvuKYpY/uMVIIbZBG2hxHBIoletkgGqQ=;
 b=V57e0d2SsdOzW/a3cPFESbjXa7CjzLF/1mm1ZIUeZcj7ttgyXCnr+7THtVAnPoVBQmAp7MLWHmlHReMSVPSSrVE5T+F8BIX3uffywLmiJn5b+HARSVdYDUvJbE0pfb2hUR9UvPzENMvdKtZoiH5/A1EU2py08R4DZQ1BpTxk0GNmMPhsUsthJnUSmFzzKnx7mBbRrW2jcZIesBB62NZcmN2rU9rbKhL3dRjTicahxZlaIqTR8FGjLb4n7AJlx8492l8mUHema41mw1f8QbpKfeMLPxpTiSCbJ0hPxa8E1enQsflPvknls0qFES638euUKPWet6CClQJiw2vt+yATfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8e/Of9DTqiIvuKYpY/uMVIIbZBG2hxHBIoletkgGqQ=;
 b=Ba3F7sZGGn1zC3RW8ZT/ooFsOKlhpxvsyErndheCEGFaEPtA6UI9MieKi01m3YmbiDxgqsqLpbZgb0Rd9B1eQJGz4x2h5JDneORQWAXX7Svm2MKeJrEsRhf71zIoaeNm5z+GmjFGU6/APfIuqDR39fSFDjNLySpwevjDSqghjPRD2UMP/k0a1iz3uXUBR3QGBgZhLdgPpl4cOlH/C/uh/RgM64/5zIh+fmMt5cWT+qBlZFMfmqTil2pQ0KQ9pV6u+zQAVF2Km0JG3t77TMJihCjsLjhY0O4ADZlhbOe4EaU9DBePPtIlVIK4f9/nQBtVU+oTHDlt63wsmQthz3JOwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH1PPF8423FDA82.namprd12.prod.outlook.com (2603:10b6:61f:fc00::617) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 16:58:04 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 16:58:04 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
Date: Tue, 10 Nov 2026 18:57:45 +0200
Message-ID: <20261110165745.2303675-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109201151-failed-6.6-7308ef8b4a67@kernel.org>
References: <20261109201151-failed-6.6-7308ef8b4a67@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::9) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH1PPF8423FDA82:EE_
X-MS-Office365-Filtering-Correlation-Id: 5726ddae-c439-4958-cab3-08df3f4bc96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261028144727099003|261021123027099003|11063799006|261009223027099003|261022105027099003|261026140227099003|261021121427099003|56012099006|261026121527099003|261102123227099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AZSf5VNeHHiSwc91kDzoS6OWZeCc3Va5Dbpi7SBdjXllPryqhutBrTWiTXgF/OG7pP408O+tViOitdnYvrek0I/vwahx+S3ghyikvR16QJiNtYMXMvBR79w4pQH33j4PebWQGEp1tlNB/ngAGxwHgjjYybtyjn18XJLHyWq0l5CLtZDiYI7JISQ1Sy/8eTGxN1EP60BbWU+s8O5/uixG0OgvMX4D0OQQpUodLU19RDuFOt1wHLC7hse9Bc6KZpQUsXUVmJeV9XfSLqJ8bosDcE7BkxDjEeIkJPogr4r1cldayrXpJNFtba/0AZVvoWcgdpLNm/uHgzvw1+/CQSsbR6MSBMC/jQcrqzuJf3XYXK8E+8KHiDrGjOkw8vGL/bCUIDnRZq7oPYA6kIdzs5lA6C54kyC9cjepqo/1ytUXBralOx58GKCORQpjHp89oAoaV5di2ZZuazk4NDLQ6WRnBeeIY7dwZR5goXkwoARLtB0txbytMSWdKmDs0sHKKo+seMA5/LGoUD5q++hssswgowwFg4yXGvjETK/3l4uxgGY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261028144727099003)(261021123027099003)(11063799006)(261009223027099003)(261022105027099003)(261026140227099003)(261021121427099003)(56012099006)(261026121527099003)(261102123227099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?czB0IRjpLWoAXQ8aI9KnSm4lBAY/ZB6kJtXeLrzXCjUadxyL3/Pu/FbbAUDD?=
 =?us-ascii?Q?2+hD0Zs6+v9orUjr6B/WOq8NjHsjPRz6z3KPmLfhCu/dYTtfCIKelCNd1HdP?=
 =?us-ascii?Q?LGUXTLZ+aY2MGeYcyChtoKG+A0zO0JZxJiARVYZ611YSUmP/i9u3PcdC1NDx?=
 =?us-ascii?Q?eSqU0MCizZRXwCmQNPIp7BAfaxZiol9dJ6GUXBtFLSY+dOkTYrb/d3ZiPuwK?=
 =?us-ascii?Q?TIOM3bB9uK9iWZPFW0EYPME2LbYeeRH6gaQrIf9zTFqSCcxmLx1VhI9ESTGw?=
 =?us-ascii?Q?rXsHXzI+94oU4V9TY6WBu3AiNT4XeKg781mU8WWKcdAVrjo1PMq7RAggYyqV?=
 =?us-ascii?Q?o3WNqW6kBhIp9XmtoD531P8leC+S06UxcrWpVo0a/78FfSClLSIevxxskct/?=
 =?us-ascii?Q?mryYaf4eFa2y0BcEnEf85Zg8Phg8d122cYVeLORaD/D1vmEdVqHWyYWz+Yvq?=
 =?us-ascii?Q?2sZ9+MNNhNarpKrCIF8hysANClxrp/TJMrxdekBjf7XYPrMi+SPHBmbpY1GU?=
 =?us-ascii?Q?vyDpXq6HoxTevS6+22aldfAYmje2s7XG83Bj0fKn4zEoPDsTD1oVjyqbnaYq?=
 =?us-ascii?Q?zHmmNBpp77neyZuk8FGgvZUSa9+6ye0MQfUA9wzotjjVXEBamNh2TgAULrj0?=
 =?us-ascii?Q?2Up3qSyDNyGneZ6kcPJlD9N6oCmKbcyzAvDNy4qnKeD7pvz0WC06ufMHjxHM?=
 =?us-ascii?Q?AdHzL/mXBnARhTDKVahJLU0LKD6OuTYGy+MGoY0vdqJ76HX0aRYMEkOSOHc4?=
 =?us-ascii?Q?d6MnHZC270LuwBuGAeJF1mtywGZMkm338w03tv/coEAiPCz7zvc8difNkoXg?=
 =?us-ascii?Q?58jAX9tSJbtAD4J6WbbRBS5yxjVc0bhVR1tQEFIF+YzgHtYNu1MqPR1Cse8V?=
 =?us-ascii?Q?NQExJg7y6Avaye8MeyGgd4BYmbtrcP+e0XQfFt8zc2HwlIQNllkJeCL6hG/S?=
 =?us-ascii?Q?RxiSw7qokyhivyDZwnv/ANA/G1Fl6n02mKTOPDvPQQuE5klmYYwubaJdmwbO?=
 =?us-ascii?Q?DbtRQfKqjNqEKMhBm+Cc3+lJXOTkoen7V7NxGapplsgTm3bqihPuvBkkeWzf?=
 =?us-ascii?Q?r5lirD5N8Wo3miEav+rbWb8A+kzshR2vNh66U124FwZTODsRCbBTkOsvnwV+?=
 =?us-ascii?Q?/a1kXe9E/0ADopiUVlGYzdjOx61YO7xWu5bI0kvKokJ1J85y4IoZmeMD7h3Q?=
 =?us-ascii?Q?uexIXBNmUvahU0d4qNl79Zm/DsDCoegdtpu56m/5O7IVcEdGjMEe3zNKIQ8Q?=
 =?us-ascii?Q?XJ42y0BK38tTOCZq81HGh9AxpLuwvyBuVIH473gdm87IXT437v9ilUoChmsJ?=
 =?us-ascii?Q?7fY9sN8w3qm9q1454SXrR1ap7xawqGJ0a12Hx1AsDB/MIq35RSIBuCo2nkJN?=
 =?us-ascii?Q?UEjoBMqGtiWjvMmC7sr/m2zWzQ7qni/JN/BER62hGaDeVm44eKi4a9pBhiEX?=
 =?us-ascii?Q?a+EphzcB4uaU+nQ94vNrfqm+EJ6qeg4FKpHa013DfPhfdiejT5vU1/rx/oW2?=
 =?us-ascii?Q?2F6Y0IVs52tHO025TIYThsnxCGRY9UbubpRi3SqqtmMk7F/GXfU0UiWUsIGl?=
 =?us-ascii?Q?kkOdPZa1Vy50F4tMi55FCcDQdTTFGdFXM2oJm+kOYjw21EF95n+FbCr8Akz1?=
 =?us-ascii?Q?n5K49eMS9qW5cmwiNuwD8jrpEDsC4z58A5nM0fHRXucW61LtFOH37ml7GFaG?=
 =?us-ascii?Q?Zw4Miiepsf56RVfNl/hx9VdL+07CTCU26XGVX61crEfiHtafSBfzygWWQBkm?=
 =?us-ascii?Q?T6MyP6MzIw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5726ddae-c439-4958-cab3-08df3f4bc96a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:58:04.5938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drLWlKliyF16Y426wisZHz5a1FNIN2GFsCmgOOGz4sx/rdrDZ+mBQmY34olZDJ/qfDlthF/XAygPtosPfXKg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF8423FDA82

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
index 355337d428e5..1bc25a9b8a0a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1007,12 +1007,6 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
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
@@ -1280,11 +1274,6 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
-		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
-		return -EINVAL;
-	}
-
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
@@ -2963,6 +2952,9 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
+			if (rcu_access_pointer(f->nh))
+				continue;
+
 			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 611403a5f4c7..55efc11e129a 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -420,6 +420,20 @@ stop_ip_monitor()
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
@@ -504,14 +518,18 @@ ipv6_fdb_grp_fcnal()
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
@@ -598,14 +616,18 @@ ipv4_fdb_grp_fcnal()
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

