Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA43637CD32;
	Sun, 26 Jul 2026 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062095; cv=fail; b=WtElSszTf16VM786OGkOVXFEnSlfmthPj+hIAUb1SP2NVXvPrv50b+Gp+hGdwXeQNKbBZcvTdJNpyCsG6zImca66Vbbe1bLmFdklTXTpY2H4iUQknnkUzCkyC6TjBJ9rd0iGQWu3wewhXXeCiwCMolCxmFLr+rAt45Bmj5u6TRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062095; c=relaxed/simple;
	bh=XHZhCL4KhHRMyAuGwF2EW8IsItIXnu6aX8JKAy7DQBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EKy8bBPKTg6x9hzpzt+qYvNVgNn+xlqxhQ/fcVgFm+rrjxhuowtUJzfsHQ/13yZSUPgA+7ml58XDilD8Q43oQbPfEue6PnMgqERBh6+vFTnVPOVaDFk1DhXK6ajFSyJRhZVXHSn7NZs3VIaBnToOgFQiQ2UtMO1yunQnQ0lWVX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nfbOR4CP; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nfbOR4CP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvIaWuV2BeBJU/EsJRYu3h+mszyn252DtY8w0L4PIB9dvZyTo4FooHDvWEoJLm+biRo7D9Wao5xerSh4yWZxQtqEQgR8QohvAABQp7MoqEQsaJtYxuFuq7+LhePfRC5LLylPSDROiSd5drXS5F/+ZF1gPS5+YRRkZ8LaEI1rnPwe2h5VhdEmamR2VGUbeiyxmYYgwwYsy9Nhx3dFstiVi+IINh0VxaZRWNNZAxoZeQQO7XqBor8oGURrDOCmmng1onX8XnZh1UtqvzYoQPEMKeG1CtUtgP7SquroDfeeQeoeWuE0cHFKRTvzbU4/wcxxn/FCH0ouvTaGdCo3tA1Wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9Q8EEhsliVBzs0OsN9s5rr5eGlbqGRGhCNQgOlysno=;
 b=LLvu0WoJe11aI+A3yDF3jhRNYKZsvuQGIQD/YPFe2bvP/t+WsezBsHMmzlkAXXSecI2SXB4SKULgvwVZOWx9FbIig1FoR+GIsrnSqBg8p2iWSOBsdZaxLpVfTo32lwgURuWUK2JIWim9J+tRwzdkVUKZ9N3KPeUwXjU6Z7RPmK63vx88SltrZgks22jxHSxlpetyZEgMLHLh6raXuiuHASnNZIwF1Yri3jRLTcwHlTl6dCil1/TH1ROME7+VPvD5Ess7doTo1NvMT9quh87M3J2M0xzavae8ntwn+NZLbwc/isMLgCWG36ePZN3UZErDrz82gQi/WxuHHXWT7HH8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9Q8EEhsliVBzs0OsN9s5rr5eGlbqGRGhCNQgOlysno=;
 b=nfbOR4CPxoBtGEDw3QS1laYU9wglXGvAEYuCTLhnPBO6fVUkVXcw3NKg0yDUHhNyZZ9qMr0L1N1cjcUthCdE8PY29K2rKBXrcj8FOKKL5qhwSOkDrxv5vLkNq+vVvsGsSv4MtEfniXZ9Ba8Dddl+jW7dKqaqG3yibEMPI4gkeqnNVdtv52lC4c+GW0DXTi3MRYbv2KhtauHbH9v5vdTaR5r3zA/r2kDCIWigF2MGiUkyTRvpZTJ4TgnvZ1E85g2mzEw8QNrz9SMJIhR5RL4/t1L9kRdsO/Fm7vKrtv+4soZ+NQFOWOu135MBMRla+pKrCJROUIuzsrK6ap9xJam2GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 10:34:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 10:34:47 +0000
Date: Sun, 26 Jul 2026 13:34:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net 5/5] vxlan: use pskb_network_may_pull() for transmit
 path header pulls
Message-ID: <20260726103439.GA275317@shredder>
References: <20260723144249.759100-1-edumazet@google.com>
 <20260723144249.759100-6-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723144249.759100-6-edumazet@google.com>
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 18169029-8b0d-42c8-4f48-08deeb018408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|10067099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3rxmtnKSbnXqcLNHAwpKMKmJ5xwY1QgRR9gfuzHgkUFfwZdDPvg1cPeO4AokUspJ3GIK5FvMMrMPO+8tFAX4LB+6k9ETCt65ofoU76UuVuGVT0eFnhigFLRSJETlioauBxOpOd34+XM2FK1COXMSyDzaledEL+toXDjdE3psL2PD/I4YtvVey6XwLj+pGUtKs8rPkZimA9wyYQ7OCwOYoQ6tGbUXeKOfIRrJbaz1Dpp5w1GREcbrSJQviNAwIOo+ROQORBYupbz2zWTHbBpSmHiBgOfjYeLrZoLOhJ9/VhIEHOANzBz4omHlqEw/TNuTLGfhfEET02SVBU8Q5JK433aQZVnpaEUtvDcOPLYfFz4blKepH3H4/nHlR16oOUK8OW0hw5kyML+AbKP9eNXDwCIxfOl7+wRIr/DdECAHzwOVveuRiIMqcbUsyLDNAY25RpvkWVtNol3uhTd558PFqdimOYCyQXVu5qYOq08NYYGIQm4p0hTTwrkl8+M5I3KoAeT1Zcae0jxZxpH+FWt7wNmUqeTMJ4AuboORtpAogHE+HY7YD+AtgxUbKb4r/tLnNSvi1vHUNRnmFmsuvYB+HAl9kVco6i5HMmy1StKuG6fwCde5DFct77RevcZgSEQ8j1ZLzmHnRWd9z+dl/07F2lTEPjwDrCm+KdAolpyVaOU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sk13FBbDUgM8KU6GLjvUiU8C4XoDIh/aXbx1O/Su+zGh7e0VcQE4055SyTPJ?=
 =?us-ascii?Q?Kbi8HZDAoIz+L7Mcg7zGX+YDKpAb6IVM0zTGkTh9474bbJ2ltaojhZaH69SQ?=
 =?us-ascii?Q?QGKNJ4cP5jlAmYOccbSK1a6BfUasgQqrQ8LiL/iZJ5cmp4Lj5vz5cZnxOmHb?=
 =?us-ascii?Q?dOGSHuUtVZoszHsUcUyepuMGdpLX4NN6oPTo5lRPiwhnayyEca+oNTnyNvqi?=
 =?us-ascii?Q?GoHnmgHlvpaaFrSpq7ui+00imUGoKNDUkUBaRXfd5xkLTdkqoxVbpBE1J40B?=
 =?us-ascii?Q?ETAiDuTfTuYhQYx93OPbKPJTg51lo1ZL1FBc+bNu2FCwulFTqjJnyTyDc19e?=
 =?us-ascii?Q?BVvCcBfCejjr3SC6eilO22ZQ0+LRUkk5WW/xayfJtG4ekSZM3PBbawWxoiZ8?=
 =?us-ascii?Q?8wbZQ8CpKIFAjvNMBo6Xp5+joIvOkle5RlxUUl1tx1RtNd1nmF6xmI+G8a5d?=
 =?us-ascii?Q?vg/RR5lBlURbsAtFziUv37deTv84L5wtUeDoPPo4FKY9vX/zN6G0y0nQ/RxN?=
 =?us-ascii?Q?G3aNEGHel1Iy/266gJMpjynBQylpn7WTY+zgVdZ+4cG60varVsB/z2AhTWfE?=
 =?us-ascii?Q?k+zVclh6oyhtNa2hHewaIduR138xhljB6Sxhz1likBWoh7YvqhzHCVqZC4mY?=
 =?us-ascii?Q?kIuHfVbErtSB45jgdbbS6EXBPHvnI6xawLWCCKAgL0jz3+bc16LVpRrLQhva?=
 =?us-ascii?Q?13w/SvHsg2qYvXsT4dSG/ylioeixcYu2o+CTQbg9lIGQa3ELcGYlr6X3ZIy4?=
 =?us-ascii?Q?jwCYrykc1W73ufuJB0g9NqKKvxkpKoCBs7u/lpTm83wSZ/fAGI47fRrH577P?=
 =?us-ascii?Q?C/nxLfOB1Ri+yE5uozyt47UsuG3GLhtpUftkoDZ2/0flOefshv/Rp9bgFzaW?=
 =?us-ascii?Q?Pl69ZirLG/5QbFWL2smfZzCO3y3+gVfFo7P/s6/wt49R0leRpILiPU5reJQk?=
 =?us-ascii?Q?8QRSh2dA80pXONPRLNGwgyRalsER1uwTKNs0vVy0w7YNHzYI36XPadbNMw+D?=
 =?us-ascii?Q?bG7mhA8cH2KA8oqzJHTVmvAdGFDjG2+YpIs85MNBf/WDJryPZouheYw+9huD?=
 =?us-ascii?Q?ecUiMtGWaLNuNhszERO3+mCZYkc8f8Sg1RW0bOHeXWJ62HXquZ/l4M4FpcMl?=
 =?us-ascii?Q?/ChnFt6y2kWMxOlOfZYz8L4or5duaXjJ7e0N2sCbniqxLxsWhV1pPMeak9aQ?=
 =?us-ascii?Q?VSnU4cetKJHZOkM+csozWwno6QE04rlvO2KfIa3J3u9EWyCQR+GGr/4mPbnB?=
 =?us-ascii?Q?LRwJ098bK8v9OwhaAHV9eg+dDZ/QwYxZCCEHGuYnLsKW2hRKJUCxGMnB55Ip?=
 =?us-ascii?Q?PsXJ8Ja/tuzAEEmDDcFuEotfJBNWwYrU7zluitnvbKpEBFqphtyyDmkY89aZ?=
 =?us-ascii?Q?cPl9MGGLiuwsG83KiqYAkaxryo+0HX/fdwR4U2rE8DGbvCnE8s6Y45h6YMFV?=
 =?us-ascii?Q?RWBOqou2607puYvFFsAEZszWTcoRsWfICzsuE01Dod8W0wymptl8aTkKuLYM?=
 =?us-ascii?Q?ba2aS4tdUvnaEVOjIHp06s6PCmtZ9oYM2EDFXAR72WrsjX7W3cglMHJmCkGq?=
 =?us-ascii?Q?FHXbvxqLzQuG/xb6j6WVQT5Xkfqu7uirMMS2JBaSH78B8qTCc55yMiH4FupG?=
 =?us-ascii?Q?XppaL35RMrV28fSq52GfLfDb/ikTxKzdzKqGdbWcm6bNH1csCv5HhAA93qeG?=
 =?us-ascii?Q?TQ3a70PS3TX2m9RRZTziOBZdMPS8BxFr6Sqf1psWTmeFpnSg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18169029-8b0d-42c8-4f48-08deeb018408
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 10:34:47.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzoUxqYG/J9Vd2LqmUkWMP2/BniHYjN+A3AJ6gz8YKpkDSdrqBt7PLVt3bNPdBqpvFtGAACFGWX6KWrpKvCfOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982

On Thu, Jul 23, 2026 at 02:42:49PM +0000, Eric Dumazet wrote:
> In vxlan_xmit(), arp_reduce(), and vxlan_mdb_entry_skb_get(), pskb_may_pull() was
> being called to verify the availability of network layer headers (ARP, IPv6/ND,
> IP/IPv6 MDB keys).
> 
> However, during transmit skb->data points to the MAC header, so skb_network_offset(skb)
> is ETH_HLEN (14 bytes). Using pskb_may_pull(skb, len) only checks len bytes from skb->data
> rather than skb_network_offset(skb) + len, which can leave part of the network header
> in non-linear frags.
> 
> Replace these remaining pskb_may_pull() calls with pskb_network_may_pull() to properly
> account for the MAC header offset.
> 
> Fixes: 465016142711 ("vxlan: Add ARP reduction support")
> Fixes: 9e061a50a116 ("vxlan: Add IPv6 Neighbor Discovery reduction support")
> Fixes: 4e94f09d84bf ("vxlan: add MDB support")

I think you meant:

Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
Fixes: f564f45c4518 ("vxlan: add ipv6 proxy support")
Fixes: 0f83e69f44bf ("vxlan: Add MDB data path support")

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!
