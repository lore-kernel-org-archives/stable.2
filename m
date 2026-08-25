Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83A3BB699;
	Tue, 25 Aug 2026 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643717; cv=fail; b=Bszzcdwn5BaJJNdAcZVLqOagpPoMuTO888zbFY3pKak7Ts/mcNEREONIJgacY9uOin0Gd2/IkRCySWZy4I1PXDk3xxk0tx0LzcznZI4rMVcYdl1xR0LxjBpEWkDdygADtMn4tK0oKnAt6sYlVME/iKsrERVLuFkHt44NXxeYm28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643717; c=relaxed/simple;
	bh=UI7GbENFJ1dSrtwsj1fjCfWSh+Hthj91N3eQZgk+rFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kF8VOgngUTHVIcBDv0Q8ptUgLuZMGVWCwq1to4qqObQSzlKcCV9wdJfAR0b+jt5ktMVMrtI23vtH8F3u661ybo61cWyAb71wHpb3H+TjtePZ+ZR6r4X/403h+XpJdaiBihtpa/PU75ywaTSc9O9ALtLmjpu3/Vh24HC7SWmYJiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=keWaksC0; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="keWaksC0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAAEb+WIS52Hc7ykJeMZxupXpxeQKePBEMI1AFdAapzNp76/Ivh5suJm0gaM81u+O4EDvgZwQXOVgXq/Xhh7/zRzNJWjTQrkzBy6h/b3UbJTwMriRytfE08O383OMIs0C2pvp+vXWNQVACTr9Qs4kbCpfFlXiyYFHMf3Ay8wvOHDyGcljnCHfcXkn5UPzTF0Fk34tiJmnAP4iGzIFecNDXNHXTTFAzD0vhuxgezpt9hoOSBclHPMiinIh8ASyQBlYQWJyIV8vR1XAXOivUo5pQVLs/V2WxWT1f+LTUFvEe7U8W2HTacDAuEU6xzAkWc7mzJPBTesLzY9AntP9hYN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JgiR5piumWldObhJPNl8C9ICT4hLyp5el/jzyahhfs=;
 b=x9i3ZkIwmZlF34LeE2c0lM/SZDp7Fx6gOlD0FlYZE5hlhOJRtpbRPLj6OnoLS6y+uHM3VjK7ptwkjvAJO1dDOJIxmHPBw5bkta2tQ3t6tyhtZJoWzC1+FasiRqxLgncdx0PdjM5T6SxhMXqVWM5z7gxbXfT/HFKzB+jnmUPFjBEwvkCcNTJHP/uOqPcErAero/qQrb79WTIFDFD+bjGHZbmFgECgIr/kU9LtWy1vdBf8t04HV8SF5SZTXaiMzDAfigE8k5lyMs+zY8zPg3yGTFrI0hQ+HRnt6a5xfXAtacz9cWJ0KgVDDz2Gis5kz6pkv5ib3JjCN1YVKZrNnMRLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JgiR5piumWldObhJPNl8C9ICT4hLyp5el/jzyahhfs=;
 b=keWaksC0FmLii12Z8aq58DhCOCoRMYy1xkT8iUYlyTpqLzK/F94W6t7XR+OHSpXDlJ+7pQL7vTT+0D9aEm8utEJBfLNaPmTzIeaTHFBIkcVJf3m5w/LNKTkQKBZd5g1jphfKUDFrocBdmk6MfMh95EA/ZMbn8Pz+M5YNAaWtLveHUgyaT69eUx+xdbesk+enWzS9Rs43fiFmDVtJVVTPVQqTgNiXNMo74FqhCPRirxZ88ri2amsbZPuF64YV8Q/suYn7pfIO29eMXkJxJ+mHm0bjeUOt8c0gt+ysIphNgrMoB9DMUcVfWtKuvKyJ9B4Yq+HcDMiTZB4dSGzKPTVZsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:41:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0339.010; Tue, 25 Aug 2026
 07:41:50 +0000
Date: Tue, 25 Aug 2026 10:41:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Xin Long <lucien.xin@gmail.com>,
	William Tu <u9012063@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] ip_tunnel: reserve FOU/GUE headroom before
 encapsulation
Message-ID: <20260825074142.GA1219299@shredder>
References: <20260824111944.187200-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824111944.187200-1-nicoyip.dev@gmail.com>
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5ab62c-9e9e-44b7-79ba-08df027c52d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ox81OfxZrxCODAIabLnXK3fvHPHm953DQ07nYKiYBfGFXgr3lzxgkO6jC6x3A3Ju3bHq2BnU4O3MXYadoSn3I4UaomOZ2SWSe9+VjPygDM5VS0IPqPhcjxJx6eiGupNMiK3QsCw8Qk4Xk7dQ7/fhl+tbY1qkuKiSO1bhwQkKhJbtHDHzi3LVHr4o5aMb7iPb08sMfMJ+fI97WgKTFWLxHqpKjbKchdUqLGTnsjXdjEfmmF/tt2OxHxtzVM+o2iwKndmMrWThipF4IGfbuANKwK56lS1+8au2eHm8oPBmbO57JLW6/MY4w11mfppLDxexvTNok8ZHX36YIMtmYm5ohLRDj09SW/PiM0h5I53FgvU3Y69jaGnhRv3l6urcaM4ZjPQEsW7V2itlpio65CCMR5c7n/2i15wjeA5bpuDDgmI6xXLHwWyOTwlkA3VGMoLqCGbN4tmoH3vHqr+02gmyZdOIM33PUrnL2gc7SlRy/7OfKq6dcSYm+JygGRIWPe7iS3Cbnnc/Vh/tkXNUTyrKolcg/SLmVEHDnNh2+ruQ94LjmIfdmyXOWTffgojacUNC4U2lqXv5CA9lRY4mySyGiie/yXhDeA/IKwJx0UH3cWfG5OXQR9jHxCc3XNxDAU4J5NbF598r+ZvBpj+kIdsr5p6LKk89iBMb7sRZ11l3uxo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/c6FZD7epeIETRbPCfutYTS4uIMcfZq3xOq1Snwq2NMbcH/C8dQ1s+5qSQ1?=
 =?us-ascii?Q?hoBBhe9qBGIOuXsJ5az68dKyWtIun5sxbwODbHuS4bgWlcr12Apo6NgLwWxT?=
 =?us-ascii?Q?SMnD98zO4mh7tPh3D2VFg/299EIXJzgN9r4aUFzGpQAcg9zBkTSU/iE/M4yk?=
 =?us-ascii?Q?dx06rBALkqLH4iOV3rxQZPhofbgYdwJCv+EukRhCDACaOkaFZGvADGMyiw+0?=
 =?us-ascii?Q?u0yqIZkqusSpD2fmqxPLqSRiuF/BrlO4wtvmHHumlHj1g7nrEz8mMdf31MIJ?=
 =?us-ascii?Q?QNzKb3QSv7z7RVOiuLuqFP/PGooe+pogvdNsI4065TnFWMGYbXb92cDwtS11?=
 =?us-ascii?Q?T+3pKuI/C+e5+00TVVWI5NYNp/DMz7q1ceGTGnjUm8izpWNtoSETzAaGNnPM?=
 =?us-ascii?Q?DH814T1Gk7/6RK0Kq+FVL65YS1YeOIgmQKpQnfXGEERx/pfSSiP7REKhma1h?=
 =?us-ascii?Q?mUpDPP1Hdkz7T9V5LUv+kyCErfxRflT61SmY29oypQ76AZ8EgZsmfXJpVdus?=
 =?us-ascii?Q?N0ho2WHfPZXs2nIAq1jWOV6zLNFOYwkdcDEdlo29C+2bkbKBsnTPmDykPSCw?=
 =?us-ascii?Q?O2FBtaT6rd3Sf90edwHpUoZNUjcfjMA1LZtU0cfGTb4zt5wI0qjpt79tCKdc?=
 =?us-ascii?Q?BovMDmSZmXXxnxTIkj7Ae9YZ0Mq6O6KY/CnAwM2WQ0l5ToC5+5MfUyxjxylL?=
 =?us-ascii?Q?FMLX2+B6hc1ePqwLviG/M8P3zT4Phb372b9u0s/lY0LogMsNDrHukPWUo6qu?=
 =?us-ascii?Q?1um+nmA1odPy5Ty5XMP5Yv9zggNV4cpw5QFuo0iwxGWD6QV0QNSO92guGTNZ?=
 =?us-ascii?Q?O04IOst7r9EkISaHuGugSFS//SJuFg/X4zKsb2au7bGqF4GBZKy6TQ2P3XDr?=
 =?us-ascii?Q?ijMQDJmUPO8Ch776rhKs1n1dvFD0Gaww9+j8JjURYvtiVO5mj1KepvXcCIhj?=
 =?us-ascii?Q?CnQ+4xF+Ll0sNgLSrfFLPesM3/En2YvNu1YQQONcnnOu7BSVS5UOym054vdB?=
 =?us-ascii?Q?G5PxgUEnZ4J0RZKbsUB5YohL12i3OQGAlhmNogGDdRs5zJJc8VSX9ejPjOTg?=
 =?us-ascii?Q?Xhj7jCMR9UVl6RD/GgaqnujP+mbK8HG2aM54AHDRtx1u/61qQGjDF/7bicKj?=
 =?us-ascii?Q?81XYB4d92KSVzKM8dcmTftLHSV4KbpNzhc5C2LrNDX0Umwu+hHNbnNPIBeRW?=
 =?us-ascii?Q?rwWR1iLiKyzQtx5JsoxsSyCo5h3nXGEoHdzuIU1nq6jV4dnQBkjxQ9jWN32X?=
 =?us-ascii?Q?EzHqSw9iCYAYF1uReVPfBlYBkyNFYPT/Bz1cc2KZzuhHwXR7NPSB8pu5lFEo?=
 =?us-ascii?Q?FpKujCvPd4se/5niFCWMQZri3FpQ0muepS/rtx2Lb04UwCZTKxasOxkrWmn+?=
 =?us-ascii?Q?G+FBooq3BQxWkUUhGX1azbdglRmMB9XXfBrDw/ScNoAEKfyed/WyKJXUiZWY?=
 =?us-ascii?Q?zNKEHdWygBdcfppBGBmY68uJTDzoAT4QT6dzHhTcjNcvVOa4WZ0LZ5r11PZT?=
 =?us-ascii?Q?ZKXpyvFObwlWgjEBC655iixpmXrvpfJbogDFgJujVudMXlsWMZelbqgF4BqT?=
 =?us-ascii?Q?82A7UYTD5ef6M47/YLP9CvSYiRN0TKCY8tS188FRwH1iC3M5lN7KZDH9tSMX?=
 =?us-ascii?Q?VE3uHbyn1tqD2MV3Wox0yaVJI1Nvw+uTgT4QX668hku3mVG4P1FHCJ2twgOT?=
 =?us-ascii?Q?iizZzV9lXiaxDr6MxWD6eSxT7HkmNG2Twji7aTHhkJhgHUhe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5ab62c-9e9e-44b7-79ba-08df027c52d5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:41:50.1153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5Ybg7vAB85OP6imJLvRwdaK5H3jpTZKC4NYMttBI1roLAkoA84igDdhw0MObBcrsha0QUuDSfGsaiLsvWIuxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

On Mon, Aug 24, 2026 at 07:19:44PM +0800, Chengfeng Ye wrote:
> ip_tunnel_encap() expects its callers to reserve headroom based on
> ip_encap_hlen(). Unlike the IPv6 tunnel transmit paths, the IPv4
> ip_tunnel_xmit() and ip_md_tunnel_xmit() push FOU and GUE headers
> before they grow the skb headroom.
> 
> That becomes visible when ipgre_changelink() publishes UDP
> encapsulation before it updates the device headroom. The transmit path
> does not serialize with RTNL, so it can interleave as follows:
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
> GUE/UDP headers into an skb with only 32 bytes of actual headroom. The
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
> Use ip_encap_hlen() up front, route and perform PMTU handling first,
> then reserve the final headroom before ip_tunnel_encap() builds the
> UDP tunnel headers. This matches the existing IPv6 pattern and keeps
> ip_tunnel_encap() as a pure header builder.

Mention in the commit message that the IPv6 fix [1] is still WIP.
Otherwise, I'm pretty sure that Sashiko will complain about it.

[1] https://lore.kernel.org/netdev/b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com/

> 
> Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v3:
> - Move the headroom reservation into ip_tunnel_xmit() and
>   ip_md_tunnel_xmit() instead of growing the skb inside the FOU/GUE
>   builders.
> - Use ip_encap_hlen() to reserve the final caller-side headroom before
>   ip_tunnel_encap(), matching the existing IPv6 transmit pattern.
> - Drop the IPv4 raw-pointer refreshes that were only needed when
>   skb_cow_head() could run inside the encapsulation builders.
> 
> Link: https://lore.kernel.org/netdev/20260808005956.3761487-1-nicoyip.dev@gmail.com/ [v2]
> Link: https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.dev@gmail.com/ [v1]
> ---
>  net/ipv4/ip_tunnel.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 9d114bd575f9..5d5e7db11b3d 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -578,6 +578,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  	const struct iphdr *inner_iph;
>  	struct rtable *rt = NULL;
>  	struct flowi4 fl4;
> +	int encap_hlen;
>  	__be16 df = 0;
>  	u8 tos, ttl;
>  	bool use_cache;
> @@ -601,11 +602,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  			    tos & INET_DSCP_MASK, tunnel->net, 0, skb->mark,
>  			    skb_get_hash(skb), key->flow_flags);
>  
> -	if (!tunnel_hlen)
> -		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
> -
> -	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
> +	encap_hlen = ip_encap_hlen(&tun_info->encap);
> +	if (encap_hlen < 0)
>  		goto tx_error;
> +	if (!tunnel_hlen)
> +		tunnel_hlen = encap_hlen;
>  
>  	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
>  	if (use_cache)
> @@ -645,7 +646,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  			ttl = ip4_dst_hoplimit(&rt->dst);
>  	}
>  
> -	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
> +	headroom += encap_hlen + LL_RESERVED_SPACE(rt->dst.dev) +
> +		    rt->dst.header_len;
>  	if (skb_cow_head(skb, headroom)) {
>  		ip_rt_put(rt);
>  		goto tx_dropped;
> @@ -653,6 +655,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  
>  	ip_tunnel_adj_headroom(dev, headroom);
>  
> +	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0) {
> +		ip_rt_put(rt);
> +		goto tx_error;
> +	}
> +
>  	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
>  		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
>  	return;

I don't think we need to change ip_md_tunnel_xmit(). It's not deriving
the FOU/GUE encapsulation info from the device's configuration, so it's
not exposed to the race described in the commit message. Instead, the
encapsulation information is set by the bpf_skb_set_fou_encap() kfunc on
the metadata dst attached to the skb.

Mention this in the commit message, so that it's clear why only
ip_tunnel_xmit() is patched.

> @@ -677,6 +684,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  	__be16 payload_protocol;
>  	bool use_cache = false;
>  	struct flowi4 fl4;
> +	int encap_hlen;

Move this further down to maintain reverse xmas tree [2].

[2] https://docs.kernel.org/next/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

>  	bool md = false;
>  	bool connected;
>  	int err_count;
> @@ -765,7 +773,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  			    tunnel->net, READ_ONCE(tunnel->parms.link),
>  			    tunnel->fwmark, skb_get_hash(skb), 0);
>  
> -	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
> +	encap_hlen = ip_encap_hlen(&tunnel->encap);

This doesn't completely close the race. 'tunnel->encap' is still read
twice. Here and in the call to ip_tunnel_encap() below. That's why the
IPv6 fix takes a snapshot:

ipencap = data_race(t->encap);

And then continues to use 'ipencap' instead of 't->encap'.

> +	if (encap_hlen < 0)
>  		goto tx_error;
>  
>  	if (connected && md) {
> @@ -834,7 +843,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  	}
>  
>  	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
> -			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
> +			+ rt->dst.header_len + encap_hlen;
>  
>  	if (skb_cow_head(skb, max_headroom)) {
>  		ip_rt_put(rt);
> @@ -845,6 +854,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  
>  	ip_tunnel_adj_headroom(dev, max_headroom);
>  
> +	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
> +		ip_rt_put(rt);
> +		goto tx_error;
> +	}

tnl_update_pmtu() is calculating the size of the inner packet:

pkt_size = skb->len - tunnel_hlen;

And 'tunnel_hlen' includes the length of the encapsulation header which
is no longer reflected in 'skb->len'. You need to pass the length of the
encapsulation header as an argument to tnl_update_pmtu() and do:

pkt_size = skb->len + encap_hlen - tunnel_hlen;

Pass 0 from ip_md_tunnel_xmit() as there tnl_update_pmtu() is still
called after ip_tunnel_encap().

> +
>  	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
>  		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
>  	return;
> -- 
> 2.43.0
> 
