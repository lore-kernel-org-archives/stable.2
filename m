Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460C363C63;
	Sun,  6 Sep 2026 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718772; cv=fail; b=Fkts1BXnTY5IUTU1OR826CJY9QrSNisobYsfCDePWlx0wVXpgw/L+jPNLJuO+hQwqR2HmSafN1ancptUD9qdqheI/dp6X6Op8/EVpYWUv87u/PaR1tIWS+oO/xGD9K7PJLYojtjp0PCguLr+jxbFGgTcziJGxJ6Y4az3knA2JkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718772; c=relaxed/simple;
	bh=FnXemtcSosMMsRobJ954dXcIegpOx0SIFs1vg5pUp5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QelwevBT7A2fCjPCnAP+tKraMBhe6i+B62DoPjhKGhS2nmLcDvGSks0fNqaeuuxhyWnKhDM+meEj4vjrGTD68lZ6kVWkAdeZn4WQR/vMJiYCIbqCF3PePOo6uzwA77R9yApYh8RlDYAsiGkKXADFqaqhjRRocvb3T2wRt8syTvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QWST2oug; arc=fail smtp.client-ip=52.101.57.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QWST2oug"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGq/9fchFmTfj8c5lBo3vQdrbH4L2PkdivLNGLalwnUI66HIQ8ZHz/iiuBNu+2M2Sw+7RNsmhD7eVImD0QNT8NpfRWw9oKGZvXPAY3louFS6H3vQ8U06sE1cpJKohaxIq9lOcA9kEKb0z9C4q+6DlhqmzehW87wBlwQ/tM7MJ4UN4qZdGkuw6PEZCSZivliRBw1+G2yWVof9Jcta7FXEfZ31tr/YTt7CW3b5klJCbuUR/3rEWVyg6IlMP4+XGYN2t60Kc833bSPGm0pGBjXVCKN4yzgMXGGktTPsspLMq266ilUKxTRWDuaRwxOPaxQwoS4aZqgFimyrlt4E8PRfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQJEXf01y1p9b5wsVfxDHXXTZrgUE9dZ1sS4bRUyW7k=;
 b=VZrQRkhujrIjPmg4LLa++BL/lPpB3LByVnTvIrlud1ESS8vCtHAG1KFA66WlfvbokCA1GiJ3vWWKaW+2NwvsWJ4d8lhwW6LHHjNEIidTRt/cBAnRMZhAd3SPJ+pVwf0H25viMMKkQA/Zhq5SnYvbHDFozsw+xrgORLbWnFwOqNLB/70/dhKN6v2UdUfC+7QkzYRXc1Iyjdz1Th04gE5VBTTu9antZX5Fxcj0pMlgi6cUlhL9nkxJc5B81DcbjOgjTlwytCRFb15HwbJMGsuKPmG2kLbnQxhh4VIYcBcsZCKRow2YIvkLMjwjP6KtZ+j4MrLZdgZ/DkCyuQQu4VgPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQJEXf01y1p9b5wsVfxDHXXTZrgUE9dZ1sS4bRUyW7k=;
 b=QWST2ougz7+LWBY5wheNoBIxb4i6DSr2Sg7cegOsrX0zpaV0gFlvJMGrsHKxPja94Z7EQ1jLOZhZST8MZMvzZpRqMsbg2dEWd013badH0Bfd5ncPPAP5IVD6KCas37RT+T4eB7iier07oWi51ubplrlJ8itVQFek+vzcP8emx0/KXVLuX5ocu+QAR32vT7MSN38ol2QpaJMff5hA7BK4WzSvSPQYbzeKM3HflAJ0nkAwAs0iUHJiaa6cSDay+jfl6RmcU6b2bm4KkVfZUh4iK9E6Rrjnu6VoBxOJlIp7h6UGC7ypvquSLMxR95pEJen1TR/YytXkHSxY8nw5wdYlow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Sun, 6 Sep
 2026 18:19:22 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 18:19:22 +0000
Date: Sun, 6 Sep 2026 21:19:10 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Patrick McHardy <kaber@trash.net>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: Re: [PATCH net v2 1/1] ipv6: ip6mr: fix mr_table leak from MRT6_TABLE
Message-ID: <20260906181910.GA455897@shredder>
References: <cover.1788622674.git.zihanx@nebusec.ai>
 <5fc14a8ba754126b6897939e11154167281d4c5f.1788622674.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fc14a8ba754126b6897939e11154167281d4c5f.1788622674.git.zihanx@nebusec.ai>
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d14c14-756e-4213-1852-08df0c435fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	dYZAcnKpq/jCvCOKfaWuaprrIg9f6Wi1RROMjx2ukb2Z5B7Gk3VHamKpe/Zg8Zl0cbbiOkRSxfxlL1IOPvdcWajFQx5gzX9bsb06NG8OrROHoh5Mn1/df3tXJ+qRjWbMHQuYl0sD9q6UV30+cs+TUjMPA2cCG2ZN8ontnokzoshBfIOneTEatvC6ywNc5ALl0l9yul2dekvfWdEKZU7zzr1B1qzrmfgxpUMUMVKMLDJyVmBipd/ZwBBn6m9kfMErCLTOtkbUzq0NKUF97jBVoxJPb7Z7NMcGT1hDocoETqLa4amPyje7QR2drnOftjPPV14abkaLTEj8xMIKT9p3oM6bZ/vHsgh+rYF0XZHaKM9bfYUrYzGMz5KmQGIg6JSu17KM5VCTRQxnmH3B1hiWMT276yRKhiIXiqe0eWwbIolDTFu+PAO3YD+zAmFHfLcZ6WxYNhpdWfXwxQzdCMEDopKyAJ51VFYGM2cDkdmHLz3eL3ZBwp5H+sTTt769l8wdIlrKXEDEoqTg/2AqYGoWd3tm+FEqJqGlBu3wdmgBDQ2yMS2it/Z4BKxvelmuecI2ZKGzY1ueiBEmdq4SwjyrzHsdf4edxM1JOFe/hT+wZJFgUe1LabnvJNpJhzEQnss+snS/pfL/36rsoRqtwpYXu5+1zbmPs7+BUR5RqPowIW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RNVajQ/casScwa1aN4n9J3053rGH+rz7f3yIN9cvguCWWQq9Lii+wLXJ7ZRh?=
 =?us-ascii?Q?tufTuupn8Y7Sbecho+DsVXiJwRY5DfhvChW+Ec2EaB/3IHUoRfqw6IF6yLTE?=
 =?us-ascii?Q?bhCLcO5wCuI61Y0+omHJX19KpzLZrZ2kr0ND/Xyex/UexWu6uRP3JLfEZa6f?=
 =?us-ascii?Q?mnWQ6QlqVr8Rh0uzXaFqTDAfdOfy/EXgW4LJ27M9PatpwDxW65AdxlzZNY6f?=
 =?us-ascii?Q?RQGOxPQoQqWA0Jz/GllbDC678lWJfr0vR1p0uK/Cq0tefSW/wSCD2JuCAGyO?=
 =?us-ascii?Q?Bv5dcwdHPbZhopsz/bIAnTZQ3863yfhXyssraGoVwkMIigJyIo0CY6yxbzaZ?=
 =?us-ascii?Q?07CQjmf9W7SkMvs419/ZBwpFaBZq+2OMiApYg9fU9tNWW9qsndrGBuIpgQqp?=
 =?us-ascii?Q?ifTFe5qV1Ej1bIczad4ZFHt6pt6SdmqpxxvWNgyM08C4varTkCohU4kd5McD?=
 =?us-ascii?Q?1+x69oYCazI8x5Naztjb13WTlcHOBWvBM0Peveam3KOcnJfSi3CLVz/C0yBg?=
 =?us-ascii?Q?xu3Iy38+lt4a/ophvdyQRCPrmvSirKNMtxQgN0UenZw2SJ7ULrPU87G9UPLP?=
 =?us-ascii?Q?ODwhSyFxRvwUijtatog2ZGTUB9wtXGPpZA0u5fyzMwOdWm0PFSvRmc46fKN9?=
 =?us-ascii?Q?XnZ2E5COnKpID5XvrvHJziJUux+aMT54j4gUR3tu64M3/z5w8U8BcmEhGz1N?=
 =?us-ascii?Q?I1KR3X9WXqBBaSXiElqhVTrq5qpH44WkIL+YYku6PUpbVRydzTQHVIRa0esj?=
 =?us-ascii?Q?r7FfqG/h3WjrnBsVrHFIZTrwOuexl4akqDYxupyWfMV5CKdUgEYogh/grsiR?=
 =?us-ascii?Q?xqkdW/DxmgLfjSptoOmNeJFlS1BOfFoslE5rA/NqpGpMyhfWN45iyITmGnMA?=
 =?us-ascii?Q?ZVFoK38mzRZe3SN4kDop7qPcs0IYv+6i1/i+llqB+0PjlIwlGWvVpDOa1OzM?=
 =?us-ascii?Q?7QnmXnB9XJGUK87PuSgoqGYfrqlyYESKGI5OZ3SRM/GYqLO3L9GTeqMkV4jd?=
 =?us-ascii?Q?0YfUlWXqlACRk7nwfp7QAo2eU2Ojdr+pa/FhTZWWxywysJtP4Ee22HA7DmUj?=
 =?us-ascii?Q?s5KZA7ssTt8Ge6cgTNQ5aDYkPq3oZZQcBcX2HoVMox9fqDG5NrE8MUsoNpVt?=
 =?us-ascii?Q?85jSJ/yyEosPweQm4GZxF3H6EAjJnCKVbJbCJzLX3YzXXwcHogaC1z6kBjOO?=
 =?us-ascii?Q?EG/zAauoUjt1i+cqk1dYjVJ3s4FQm7GlBK7eZwAXfy0Zu7B+ulFs2wfCMRMe?=
 =?us-ascii?Q?c8Xg9X6mkLvhutwvjD4R3Wmxavp5xevwaskLgUW6/Ev/CgLy1difBtYWchn1?=
 =?us-ascii?Q?aRoOkmz3Q1V+Jke23sw4roZgmi5guhAp+Vd1cvPYW5sQops9gs84S2qYUIsj?=
 =?us-ascii?Q?GHkGpzzFBOBvQezpNNC1p2vIpeBobKcJMcpAQYs/Nv1XsOjS4skEM+S/BDnw?=
 =?us-ascii?Q?mzz/Tp1FBcB0Br5L97susyexqEl6GA+OG3UgNtkRxXbGNoj+bGNJSBdF2kJk?=
 =?us-ascii?Q?nz3Be3Jv92B5KowjNKQDrlHLy6CrgD/UM3iUh7glgAmB0VhUF+61Usg/2Qgc?=
 =?us-ascii?Q?xCuY+x6Y3DUwosh185Vs98OIa3Nku9Y9HtFj0L4MGmZwJXDI3BnxfcVuRiUg?=
 =?us-ascii?Q?QR9n8WLD/HE0XIp0pd3Zlre8CgssRPbY1J7v/aGvBsFTiHvyJmG9+Luo+NSv?=
 =?us-ascii?Q?LQ+2uHdg/JazJc2Tjg2BsgOiUzAQd0HLum1BRIQPAj3NV0Z9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d14c14-756e-4213-1852-08df0c435fbb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 18:19:21.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niVHm0KWcmabzy6m7O70R4AOACxdZqciHiYZ8mF5ntyGWwGuFiVF968NVXZSpuJRhPmnqq41LnZHjes9lKXKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405

On Sat, Sep 05, 2026 at 04:30:07PM +0000, Zihan Xi wrote:
> MRT6_TABLE is supposed to select a multicast routing table id, but
> ip6_mroute_setsockopt() currently calls ip6mr_new_table() for every
> unseen id. The new mr_table is linked into mr6_tables and is only
> destroyed when the net namespace goes away.
> 
> A raw ICMPv6 socket with CAP_NET_ADMIN can therefore loop
> MRT6_TABLE(fresh id) without MRT6_INIT, close the socket, and still
> leave the tables allocated. Repeating this grows unreclaimable slab
> until the machine OOMs.

Isn't the established way to deal with this sort of issue to simply
account for the memory and assume that the admin put some kind of a
memory limit on the container?

See for example commit 6126891c6d4f ("memcg: enable accounting for IP
address and routing-related objects") and commit 5d26cff5bdbe ("net:
account alternate interface name memory").

This diff [1] accounts for the memory of both the multicast tables
and the multicast routes.

With your C reproducer and this diff I get:

# echo +memory > /sys/fs/cgroup/cgroup.subtree_control
# mkdir /sys/fs/cgroup/mrtest
# echo 64M > /sys/fs/cgroup/mrtest/memory.max
# echo $$ > /sys/fs/cgroup/mrtest/cgroup.procs
# unshare -Urn ./mrt_poc
allocated=1 current_table=1 maxrss_kb=1788
allocated=10001 current_table=10001 maxrss_kb=1788
Killed                     bash
# dmesg | tail -1
[   63.360047] Memory cgroup out of memory: Killed process 297 (mrt_poc) total-vm:2424kB, anon-rss:92kB, file-rss:1448kB, shmem-rss:0kB, UID:0 pgtables:44kB oom_score_adj:0

[1]
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e5f2b1c6150d..b9c544d48c45 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3376,7 +3376,8 @@ int __init ip_mr_init(void)
 {
 	int err;
 
-	mrt_cachep = KMEM_CACHE(mfc_cache, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+	mrt_cachep = KMEM_CACHE(mfc_cache,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 
 	err = register_pernet_subsys(&ipmr_net_ops);
 	if (err)
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 867b24beded1..a0ec6d19a237 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -52,7 +52,7 @@ mr_table_alloc(struct net *net, u32 id,
 	struct mr_table *mrt;
 	int err;
 
-	mrt = kzalloc_obj(*mrt);
+	mrt = kzalloc_obj(*mrt, GFP_KERNEL_ACCOUNT);
 	if (!mrt)
 		return ERR_PTR(-ENOMEM);
 	mrt->id = id;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3f2ed9b77deb..9d8116b5edb1 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1427,7 +1427,7 @@ int __init ip6_mr_init(void)
 {
 	int err;
 
-	mrt_cachep = KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN);
+	mrt_cachep = KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT);
 	if (!mrt_cachep)
 		return -ENOMEM;
