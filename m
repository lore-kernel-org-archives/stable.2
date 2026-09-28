Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868682DA756;
	Mon, 28 Sep 2026 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598867; cv=fail; b=EQC8rOtz8vbn9nVP9vP/sCstezQ6n23yPdtv0CubasMNFY2Da92RBJIuOxCPzw77VBKs5p0IDYi7RSSn8l+uGe4lq+0VyYyOmz0hdgpSPElgislaF8+Q3+x0sEnDwYf8Fc9yayDQx4hASxcyQkGn0hJRTqDBGm4a5+DexZahuXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598867; c=relaxed/simple;
	bh=ApHR+DKowN845oXFRDGB5PprWFTT+BVSADMDT7un7uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S1abWVMNt97xbi0aoM+SkimLEWVCwgDS6uAe1wjMx1p0GyJj5oAcEjJBGmW/jrlQHSnGfkGk1ozrSPoNzZRvIZkXnCBEiBLm6+6l2PLDGGs9o/stztZE4cswyAYHcQv7OwlChG9+ik9XIj1fDEW6YQs4HddmNhl5yWcKD7lH2JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dzRgf8lk; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dzRgf8lk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBRKcnjWICylm+HxmGnnSnGsJ+BjKxdTWYj5hQzt/qZxfzSpUMFD1jp/CFdsqUQldsNCk3qyC43uGXkzOh+9iBsXtZnJzNwSkNQ8eQfPlDUrUBhFJsd4uj/WAM0zfZoDrkMIa2eBVJBbb9yZmFVTZocSr4YCMP7Cyl/TDnEe+fnfEdhIm5YRXTmWaoO1O/6Dq+daE6hTNHimE8y0FuCmJ3/b42DkCpTzZo5ls8fhu9sFY/tiAk7cYLQEQ+EM0u2kwZCZjGIWi5l5TdLzNDHAEaQiJzcWRELfgkZKQ6IQcvil4Op3SThEcEMJglvEFWky9WgBmzORrBtcz7jNZ2jlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roRsTpaCXlT9R2w9XbaPCqx3fwNy6eeo3DWWOF3CJgA=;
 b=zUPlodDQ32JnKPNLMWOCU57pakSalU3dQJb3PsBJ5uYxm3aU+L4jN46gWrXuvAVvgRkQbTYIjAka4crDEFzXfoIlOImxaDVl14GKlqfUPSBHonwP2tK2JS0srmCci64UCIZMvuwI/hIK9pcJrxYaDDsMQNPWwxKB+A3oOGJZKelww7vyqf5LCX74TzLqcHik5offLUnT+Fpbs88LdnarahM/rkE5tYGfLJhh6S2V8XV5RrzN1RtYkPFki1lPy+S1oHYZv1SASQGDAl9CT8S17CmNr9rMUsF6LYTtn7KierGnkdbRkMWUhTtuA4NIksqjQdODrxPpHAyblOXU0babFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roRsTpaCXlT9R2w9XbaPCqx3fwNy6eeo3DWWOF3CJgA=;
 b=dzRgf8lk1X6CVR7V0PRCc516lP65jOGYUWRs1JEjixzEt6aD9rHZkgNzujQW1OPSsMgogBPsHXNhHCH7GI5FOz+xo0EzFlS8wHVdRjj+OQCRQdZtuMTVp4wnVVgDb2VvEGJ0v6MscRyoNW33hUNEqLAXOm6zS+W2ruRQMbYYB7M/AmR93sEl0q0fwBUCp3MNdG1oaf/VggCojyz/wXBbCh9PLRilYqmx4oZXbCRuleewYpMdZhvzzu38QwDX7SlfeLclqM1PAGpunuFm15Epm9QaQki8WYo7iQnJN7aqNu/tIIWOkBMUdVgfsatV442QKZEJe1DE5jc6jDJFiQ5GNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 28 Sep
 2026 12:34:21 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:34:21 +0000
Date: Mon, 28 Sep 2026 15:34:11 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, John Heffner <jheffner@psc.edu>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ipv4: Fix device use-after-free in ip_skb_dst_mtu()
Message-ID: <20260928123411.GA440063@shredder>
References: <20260927071051.3693368-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927071051.3693368-1-nicoyip.dev@gmail.com>
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 241bd679-f470-45a4-7c58-08df1d5cd226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|56012099006|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	zkoiByvj2uAHAr8KJZuX38lmaZJ6FEvRHjSv8qfSf8bv5g1ixPAmjT3EWRhYM6rUq+HTNLr2Na9W4xGbwEdrbVw423tt8qvx/IjXrIn+nO9dzyNPgRyNBNbRDjj06CxudeM9P5INmGzL0ik4PuJMfYgN8l1L1bCYelDlHaKGMGFTlcYGHS3pyhrSk66BPQ5oJQ71xgrOxQHAJ7xCjKnhuCOsSOgvNoFJalnp+xz626JfgMYkRYtk/BijRq8+O0NXlAEug0cWPd1qsKZkWq/b4orhCv9e5jf3/U5PIXIW1XS1BdFrr5EHehfX4R6a0mdUPsu14uJnjHM18CxZ4o4qm6TtF34OXJtSUk45euL6vPnshr+IhD0HFVXJaoQhDuTqXr4kknKHmH4ZFLMk2ceaI3gRx5xTUq6NWoFGtvj/a9JLOJX8LzRk0G/jL6lCt9mK0FJxW3vDDFSmBQQL165QGE/ysG4fMoOldUt3K2q43vXGcrJO5YKhfEg3zYLrCHNFDujuvRiLUXOpyeZJySlswY1bhEnqFIAYEwLcBeuFjQkfOmaxhB3mBsFRRNZu2qSEycnWqY+B58EVtcGR2emrEzXhp9HX/DJK1n7iMYyPNZEJCmS+dLL4/MMKKxGP4K/dhITQu1+I8kdeRO30SoSl9UMKh8FtW+YxBOSH+mT+9nw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LQm8kJVyiuMnsGWI6Y9QvyFYpbyTFT5d3U6YQN6cTh7wtGxImVjOVWkpufRX?=
 =?us-ascii?Q?pgHcjVMpYsZhas+P2LDxVGQkVKtp1ydi5LZn2Uvr43h94XpolFuVCLFoebcY?=
 =?us-ascii?Q?KgpMRMz7spEMqVBy46keCjEYsVgfft/9cY4AMtp4AexbAhDv8kIK/QNgV14S?=
 =?us-ascii?Q?Jtp+r6i4aZdvRwbV6sPymKLYRUEsSx12Rx3Rm4Hdw1aa4MqBBImV8f+EQFMP?=
 =?us-ascii?Q?M9n4+NQN3tCvqcxLCrzq7KJa6L/2SND3FPeoGhsnPCVXKAJqG0CVnzkglgou?=
 =?us-ascii?Q?OG5x9aDvRVi0QPggVmDc7DLkYUIgwVbT1Y76wGE4RHkRUR2wlv1vjefHp0fi?=
 =?us-ascii?Q?8+3FIQh+6zCdDkkkDWnAbu18BVOJkgWYOzMotpuorgIqiEiuf1bbLj+0sp0X?=
 =?us-ascii?Q?1bKMBA01g5FVdEwmd+170aUPlG+b/X4w+s8B78h/zkN9dQiCIjY3oYxIh35j?=
 =?us-ascii?Q?Hg6N+wKt+UxN6ozRU1quBNPpFOekpY3+ga69J0mbNkK3K3o4VMCIUp3Fsm5C?=
 =?us-ascii?Q?Wb4iXoe/ac5VBFyAiZhWrN1YIGKUnyOEgPxTKmdVesXC+ZTW+zAGNxEG7zg5?=
 =?us-ascii?Q?CFQ3gEHbH+LH/QheIGHQjQmMN4iDKE3D8njRn93weQ9R8D/dBdyRTi+/qn1I?=
 =?us-ascii?Q?gWquTFFf1tEJafAfCf+VxY+hTK3rI6c2nmNjPVZkO3iHkxTkJQY2YAayvmEj?=
 =?us-ascii?Q?GMyXjvrfqwxfERRSYIqYXdvi9lXA90U1itL5alaibYkJFcBseROFyiSCyYhP?=
 =?us-ascii?Q?MzhkVfA0d1yICKs5N359bLlS3UmBFlDtuvjwzWS3N4YIQPAMiqx1C3Q/pFW+?=
 =?us-ascii?Q?5aXHsKo5sBKvlI2AfHY5X65app9juy6oxDSFZxkdv2bY+xRjTTiHVeVfZkin?=
 =?us-ascii?Q?XxtF5zPKFzi3d10UXINDHNozCsv14SfBZ/5Muu3q5QEDfozrsXyM2awfuxtK?=
 =?us-ascii?Q?gFUVHS5QvIngdLhssaKntJ/UmoYk2bvsb6w2AwRYcSa5fNL7NC99Tw+JHVGd?=
 =?us-ascii?Q?ClHnBueILRm/pJAaVjFAFBKapSjgmx8EmMr0jZro/tPIn7z7VN66ZzLRycbc?=
 =?us-ascii?Q?LHLSocIW7ZmTmxRSGDQ1rr4RtBHZIg/ECj/SBAEi8sUHgCdqQMW6GLOl9OUO?=
 =?us-ascii?Q?MTsRwyNdOP3bqJKJVlu31rcfpn/761Refc5atNxdIh3b4y5Y0t4esKhUSDnO?=
 =?us-ascii?Q?rqzwjwzzwOLEvV76js5uOIy8ef5VBBqZa7RHHMjCnvfjZjM7gYQRYR9xmv6q?=
 =?us-ascii?Q?MguGJhOQebsjUjj8vC+X6tH2sbdE117bAp/5GUJIK2cglLsoB86SNo1NMAmN?=
 =?us-ascii?Q?PlKLXeLlzi8E2oUWkpZllgVJkUdOKpETB/ATXOUltDIxVSjwDlGqA/Jm41EN?=
 =?us-ascii?Q?c9B+QOT8UxtIVCNsTwwiDCDmnY5d7qUZZ6Tewf8/dqoz9uatWYIxxB5S4fYi?=
 =?us-ascii?Q?ySIw4Vc5phIN356RgoocfnNMGM30Z4bwExlWTVsg9i9sr+Ak8ziFAVlkkNy9?=
 =?us-ascii?Q?9ehoLAFBEDZ+7HHlz0n3y6G+RuRHh5my2/gXSOeIiYz6Q051wG9kfyDJLIeP?=
 =?us-ascii?Q?PZwRTCxJN+Q7J2emEPHOMmCAW06VxGVsi04kXVLDco/H4hNO4PWOQa+A2EWA?=
 =?us-ascii?Q?qkXdFhDgmLX9aAOtLEZzWAwwAfFSnNubfxwv9LAMlpAEgfAVZUkz74tZxxSY?=
 =?us-ascii?Q?tZ335SMv6p9uA76Zz8tLjXKu+BSROhM+XVdqybR+fdYb0fsV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241bd679-f470-45a4-7c58-08df1d5cd226
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:34:21.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzVpDb4Q+FEcKATPG+aXyi7uwy0EDS6MEtPtAQRKKAj6estfpbcSoBr309CbCl+Xo+7vst+zuninpJzt38RZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

On Sun, Sep 27, 2026 at 03:10:51PM +0800, Chengfeng Ye wrote:
> When a socket ignores the path MTU, ip_skb_dst_mtu() reads the device
> MTU without RCU protection. The multicast and broadcast output path
> through ip_mc_output() can reach this helper without an RCU read lock.
> Netfilter releases its internal read lock before calling
> ip_finish_output().
> 
> A sender can load dst->dev and then be preempted before reading dev->mtu.
> Concurrent device unregistration replaces dst->dev with blackhole_netdev
> and drops the old device reference. After the grace period and remaining
> references drain, the device can be freed before the sender resumes and
> reads its MTU, causing a use-after-free.
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in ip_skb_dst_mtu+0x634/0x740
>   Read of size 4 at addr ffff88810921c038 by task poc/98
>   Call Trace:
>    ip_skb_dst_mtu+0x634/0x740
>    __ip_finish_output.part.0+0x22/0x2c0
>    ip_mc_output+0x287/0x930
>    ip_send_skb+0x11d/0x150
>    udp_send_skb+0x63e/0xdf0
>    udp_sendmsg+0x1235/0x1da0
>    __sys_sendto+0x32c/0x3a0
> 
>   Allocated by task 97:
>    __kvmalloc_node_noprof+0x1d4/0x620
>    alloc_netdev_mqs+0x81/0x12c0
>    rtnl_create_link+0xaa3/0xe30
>    rtnl_newlink+0xabc/0x1f70
> 
>   Freed by task 99:
>    kfree+0x131/0x3c0
>    device_release+0xc8/0x240
>    kobject_put+0x14d/0x280
>    netdev_run_todo+0x4cb/0xc70
>    rtnl_dellink+0x362/0xa90
> 
> Protect the device lookup and MTU read with RCU and use dst_dev_rcu() to
> access the device pointer. Keep the MTU limit and headroom calculation
> unchanged.

This still leaves other potential UAFs in the ip_mc_output() path.
Better to fix it by adding an RCU read-side critical section in
ip_mc_output() in a similar fashion to its unicast counterpart. See
commit 1dbf1d590d10 ("net: Add locking to protect skb->dev access in
ip_output"). You can blame 4a6ce2b6f2ec ("net: introduce a new function
dst_dev_put()").
