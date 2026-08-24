Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C237AA9F;
	Mon, 24 Aug 2026 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557823; cv=fail; b=ll3rTj6FiwoJB/DZ0JnZTlZApz/jtyOWsNwkSuDKX38Ha3peNqXYixuaVWuQ0LU3tTJrHRxi/n4K02McT9M3cuXD8tTYT2NCn5j8dFeUKqWjHq+TK6lTB2H1JVxtPWIGwcACutoeDqJzbbhRTJLI1UwofpqnzCJz7fZSAxaVg2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557823; c=relaxed/simple;
	bh=5+SaYVDuPiyJZp1F8HiZFViNLUFzgARcpBRyOsAaKnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sidgB/xwyy5i97zrvx6zdKYMowiRSIJxqgJOogmf+hXShRKNeTj6eGH5sTEnKWiEhnRU65LyVRiqsAmZBiIHLztgNu3/jEI+GRPlaQrlM8AnJTBuphLcoaQEkRVWCsfUi0ycs/IzoIX631XSEPpNoDx0vMLLAmT7yoVTJo9toPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eanA3lJu; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eanA3lJu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FigOesXpE2yD0/sZdhy2ib5X8ZuS6hplBiv26IPG2bvsyfbNTPLlP+cRIK9FbWWas57WNNFhYrCoA9/bR6zNv9ZKHDWeaVce6CatY+KduQ7cfHk20Zl0GJi+SQpktD1l0dD+VsIjFApUcXOF8aDUMyxMYo4CpiOJvg1zubIpF4BRa4rENU93QMTqgRO3vkfI9EBfnPy7GtGbdfcZZuCOdDEYGYCHxsdExGi1SyByH1H1EQuD/raV1rE/qsGO/7lCsucAJV8jm5hEvgtSL/S15P1XiN9O9iau/UqtHG2XL6j1dM1tq8qU5KzTubZ0SoNaKRFCKRc9D9sf4bDBBcs9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNGO3SfVfQnAuWLXFKoH+Nb33rZRcrrpJPd6gGnPR24=;
 b=ihLd4dNHjynZuir0R4Q0I5gRKLqNI8rLEmuAjFhZvRWAvFsAa/Sy5vZsa2F5Ho+QnRljgNF5rhsYISp3vqK00PIGqteRoH5dJiCA93CibiuIjtHOPcpFZKcs5hTMYtsGzToCkXS25Cn+uBNhI5a7IvJI5gcnurH5mmswSpUTcwRiRCxSiXAgpAj2BqFrnJTEid1XHnrvDwaDPQnC9oFQNbv7RNj1LCqcmxlieTD/jWedCsRLgkgDj1sZhZDPW6+2Mx2l1naECyu/jGL8ZMbFIDyZn5y08dBF0ZJC/NphjcGCA+okInopgBoYzXYakjFHtV90E8+cbeqx+BrYDAJhHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNGO3SfVfQnAuWLXFKoH+Nb33rZRcrrpJPd6gGnPR24=;
 b=eanA3lJukZI+wG7cMWONH59Th3PfbhfRxBpZk0BE6xdTF0qbv+VqaQEc8YC3SS8tvXUN01eJoPo498BIDmBLtSqurrS3MFda5rvX2yhlM/cYefYkHgDjqSi3t/rOU7cmBRPugrvtxEhtffQtsYEPB7eQtD20pxuqN30mT0YxSGNrfv36xzNjbPDIk8dcNCMfet3uEou4chtIsdh3ugGsK0CI2Xs0XFWcUZnHTRNzQzbRHAGsb3hPI8UHXz3B9GTiLnqzIduQytIMk9iccpN52OM1tfW+RpaxaW5DObIy4aTC6+tlqyXODEo1MNxBIZsq31CxCE2eGteMq4v/GdnLvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:50:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0339.010; Mon, 24 Aug 2026
 07:50:19 +0000
Date: Mon, 24 Aug 2026 10:50:11 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: netdev@vger.kernel.org, Antoine Tenart <atenart@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] fou: ensure GUE headers have enough headroom
Message-ID: <20260824075011.GA858321@shredder>
References: <20260801060115.3538849-1-nicoyip.dev@gmail.com>
 <20260821145908.2829132-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821145908.2829132-1-nicoyip.dev@gmail.com>
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: 460ca554-6792-474d-e82c-08df01b457c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XUV7g6eDzAO2brPKDeSNumRS+8m7gILi1O0bUTsaM1Zl5wV+s9icxKLHU7rZpX+0oQ06fObMFCV0jGgmk9eLxJ9FrkbF9BI98zsZOdCgqnr3YhGLFMgPEGPaVrK59RJ1AccJjOuxMM2UdYH3efsui/vhXs/Lrch2pvxu6lzZD34qBqYRu89xQZITxUTb+8dlXbW7YmGsEh4YEjeRQcXGupqy1evrvg3ld0Gippypivsh4hGZOP9pSwrbvJXwyEK4ijzEN47ycyGNtr1QgdcOa5uXC6q/WjZD6rQMGkHbP1WMpbLj2sBBi8HXtS6cV87a7AnE/eUoutYoM0A9FVkgaCsTE4ubpgf/ayLvE9KQKiAZsScARtBvDbtOzsLeBGAX+tWbliwr6xMS6DlaUePmulIlgK6ni6u79IBcbXj8PmhfG0LX17ae2K0vu3ygMk3HtYt3ONq1p5fxiVpbZEBNcrL9xE1teApop/F7fRggmSa70CtShwqC/ut18UgKdTxWCAuOwq2fCICAqD/tQisImbVgCy+6rvqmxFCK7L49cMcT//tqnfCNu0nfrK84IefRCLo6wiSebqAQdIK8UaOKiqEIJKr4hCT5HyNCGA1sVC7apXDtVGekE2OS62Tt+OzxKh+XkFAWHGYC8JUrlSOsj52zWA3YoB1QKEGYeb0AYso=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZGeOdmid+zH2nqBo/Ku7QSwVbJjcafVT3w7eS80uyrfuQhcH+a57IiqAmGl1?=
 =?us-ascii?Q?dpHMwgnL71Fyqb7qdzNed+ksaYoB5Jza3EuXYbeFzLF05IFsvL48NtMnz1G1?=
 =?us-ascii?Q?BuVg3LaWZ7P9LETQiKwecM+xCwr3kJLPxQky3sIgNCjsQW+YSMZnRz5v0m1B?=
 =?us-ascii?Q?trTYLHieWMcRZAUEPWbe5CmAhL1wbGBwfaWUqi4hqeV5s3gnN89MzOcTIp3D?=
 =?us-ascii?Q?AYnhD0YntOZ+vYw6ld07ZBBzNNxq3mH8Uu9FvRbyaBok4zoxMlUVfKqp9x0g?=
 =?us-ascii?Q?0ZBQYTMORCiS3aoCXEB3g8qeg+77lIQPFTon/5cDW3SPSRMG13k1w0ZASVeV?=
 =?us-ascii?Q?KGEL1lxr1rkbHuO8bKNLEvMDt5VOeeIndSXjafYHDv4LbVY3OLQzn7TkhFuo?=
 =?us-ascii?Q?6wgBckCtxXv+scxUv4FVyKR73nrLOF7oAmCH0ucWb/qakFEecyQ7MlPAVf0p?=
 =?us-ascii?Q?frDhe8/51gMEzNTo+7DxxFeFtrib5lkPquHAPLfmy0EHhSlIyar796kRSbAN?=
 =?us-ascii?Q?egabOcxDsmPa8qCoKwPIR3L8pCQX5ZFRc2r/E9iNR4UGdBMJKXhU12vatBRL?=
 =?us-ascii?Q?Sy/t+n3MPOEELTb65QSY4VcslTzquPQmPoq/aWo5DP+a8MNtg3JlPW2lFQEJ?=
 =?us-ascii?Q?qHRXpf3OMAK+yHX7r5g1hEE/mk6WXOKdACcqZSE/hNVShMCOdXWYkL7fqBrE?=
 =?us-ascii?Q?Fja7zJsoNGrRMXZtxnhBvoNIiy0v1tnY/RIajvEk10n11SamsJnDNvYZ0GMU?=
 =?us-ascii?Q?WBkYJZ4WVcLwtfTqlE31uGVaVeC1mp6kYwT6zKx0hOrZqsN8d5vNP3GPaFxB?=
 =?us-ascii?Q?pLeQQP6PGNp2Fkg6Qa7JXIgxz4LUF630e8dOrb+5Lbzz8vt0QX53FcSQqYFB?=
 =?us-ascii?Q?PvRSrJTa6Wdf4qqeYXcba5xpfFcmlSOQbHu0tZsPqkpQlsk6WHa5umFeyF3a?=
 =?us-ascii?Q?q2KOHEUY8i5TnvVMeEybSU9w3DXJI99GIPDAqOFCziTHdOiS2J3L9U3KvSC7?=
 =?us-ascii?Q?LbROOfd+jjz0dX++0WKjclSsY+LlW+4XCluANrNR2DLtgvHi9/OH3kiiiUWi?=
 =?us-ascii?Q?CCnXWWJcaZtntzJ2JNa3U8d4jCnPTeir5mrrrsSRan1ZnsrIfl6nxB7lBytw?=
 =?us-ascii?Q?ezPs2LGX9f8VSjZTAiUTsL0ZWt+GnnJFNzj5fUJce7x0cun1aWxaY9UGoAA2?=
 =?us-ascii?Q?icMlomCWjtD+mvpznLIQhhm+rxP62kVnPaWS3CAFd5kZDtG4U7fammTc0yKo?=
 =?us-ascii?Q?etIlmPbhgB1sSvml3/PTEKhNu2aEbjJvjNFxHN2404VOYuHA9YcFAJmpBVCM?=
 =?us-ascii?Q?x9kdQMNo72e0vZ7iF4sm9F1/SvEPJEyj5Rb/G0HW8rSZ7tsQ+aVx/OLiTq+K?=
 =?us-ascii?Q?TPrDM9oJjFCoe9uhVQPouP9pG/elGXG96C8bjoKlsHP8K9NcZ7K9rO8J6mKU?=
 =?us-ascii?Q?8U2Uvn9rDT750QT27/wY0h+Fqiow2mv47MVXg54rMyBlGwhy5tmeJMDLhZyF?=
 =?us-ascii?Q?PlNG2hkgtF39QFr40FZ0hskeowfi6UyLqzrUMMr3gUKbNY9zdDu8NpQAhDhg?=
 =?us-ascii?Q?rDpPT/tT3oycNZBSONAdWPo1hi82zEZCuRnX5ANnxaqorjrMSPlwE0SLZpJs?=
 =?us-ascii?Q?Z31kYDII+ls5mSNwSKYkSPvM9w2oXLYPRoyrbIvoXmHWocfY4ksM2IxTv88X?=
 =?us-ascii?Q?ZHR1CoOFPj2rctRk6LRaMgSZaA2USJ/uujnKBy63vhNvUZ49?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460ca554-6792-474d-e82c-08df01b457c0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:50:19.0390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVoIV+ovmk/pSGgMN/kM8m+BHIWGhQ/p7yMDDwNRmKB6l2WaFccd6ttgpZMSu6hpsuJo1xyWziTWoURj+gYQUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646

On Fri, Aug 21, 2026 at 10:59:08PM +0800, Chengfeng Ye wrote:
> ipgre_changelink() installs GUE encapsulation before it publishes the
> new GRE header length and updates dev->needed_headroom.  The transmit
> path does not serialize with RTNL, so it can interleave as follows:
> 
>   CPU 0 (ipgre_changelink)        CPU 1 (ipgre_xmit)
>   install GUE encapsulation
>                                   reserve the old needed_headroom
>   publish larger GRE flags
>   update tunnel->tun_hlen
>                                   push the larger GRE header
>                                   push the GUE and UDP headers
>   update dev->needed_headroom
> 
> With REMCSUM, the new layout can push 16 bytes of GRE and 20 bytes of
> GUE/UDP headers into an skb with only 32 bytes of actual headroom.  The
> final UDP push writes four bytes before skb->head.
> 
> With the update window widened, the kernel reported:
> 
>   skbuff: skb_under_panic: ... len:128 put:8 ... dev:gre0poc
>   kernel BUG at net/core/skbuff.c:214!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   Call Trace:
>    skb_push
>    fou_build_udp
>    gue_build_header
>    ip_tunnel_xmit
>    __gre_xmit
>    ipgre_xmit
> 
> Make __gue_build_header() ensure space for both the GUE header it is
> about to push and the UDP header that follows.  On normally sized skbs
> the check is a no-op.  If configuration changes race with transmission,
> skb_cow_head() expands the head before either GUE write, or returns an
> error without modifying the packet.
> 
> skb_cow_head() may move skb->head.  Refresh skb-derived inner_iph
> pointers after encapsulation, and read the tunnel fragment and TTL
> fields before ip_tunnel_encap() so ip_tunnel_xmit() does not dereference
> tnl_params after a possible skb head reallocation.

It is up to the caller of ip_tunnel_encap() to make sure that there is
enough headroom in the packet. Otherwise, what is the point of the
encap_hlen() callback? Also, adding skb_cow_head() in the build_header()
callback forces every caller to refresh pointers to skb->head.

There's a WIP patch to fix the same problem in IPv6 [1]. I suggest doing
something similar in ip_tunnel_xmit() and ip_md_tunnel_xmit(). Note that
IPv6 reserves the headroom before the encap push, so the snapshot is
enough there. IPv4 reserves it after, so we also need an skb_cow_head()
before ip_tunnel_encap().

[1] https://lore.kernel.org/netdev/cover.1786088695.git.petalzu987@gmail.com/
