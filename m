Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5A3FADF2;
	Mon, 20 Jul 2026 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549816; cv=fail; b=jfagOwJdCHHGlPwhEu1+dHAqtNqD4z75/tHB0AZJhBj4KE+k0Hg6S+KqH2GMy4tGWmNYcEv1ivkue1ImgATdRj8FDAOIQURAN0O2apRo/pUgcUjiI70QEpN5bODOUNyHexrsy/GK4NJv5RBv9Bzv9M+4tJ7euwcbFIUcFFwGvx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549816; c=relaxed/simple;
	bh=0RoDPcYf7tp+wePUL/v33emQ4MzTlzUsuczL9g5zpdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t+IDTRQs3hMNpMnJMROYWJnlGI3FJ7ekeg+WeTkNIA0Yl09Go5vJPBrzW+6ERCR7rSWNX5JVWfNysHyul+GiR7yo3OXDtM6Kqp6Pe35wisX3OZXr10/6LqPKAMgUox0t6j9Y7PSr9Ey+t/L9V7zYkdXNx5MfEbcz1iJE3UskzVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LOHL7xtV; arc=fail smtp.client-ip=40.107.200.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LOHL7xtV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpBGCTkA5+Ezpd3KJigMSR195uDd6g7e5em8HdFX0Vh7lOiFOJ1OnCAQEUIQ7WD/Loc7MM4zwPIAH8gTj8G6jQZr+hhPfJJRvt/cw4ykoKFjf7niaAsfarzFhOHU66VtJ9EqP3YLLKXD/letvXdLnEdJAf6tpyy3ZVY3Lr+3g342/HzLply2h5u+AdkBPublj4zz+DO16vJf5JruQgjfpEw62uVGTnE0y7DyIwT2N1d1ebTN0RKk7aWJJOaiaVyvttqsCDkfdNVWFVuuCyD805TQDZNLbIfADABSpHsHuGvBlU09V8SCo4bHhe3zmXsCKhMiXqJ0BEewGjX7N93NEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJHzbhDGqQExC3H2PqPBr/JcfhUUiL7SE8xndOa8ido=;
 b=exaJoD+bQCP5+SB1/Yj7UZk21QgSmEUKaX0LfoaAqzGgIzsag+Z3/i9u1Lg/riCjx7s7bbubD+mDpWLXix/UNfZRQpUnniYKF6HfD/XhmroPDVjIpuLobkfNu0yN+z1UnX3MMep/erZTwCEQeRVxLO7YamHAHU8V3UQ/fKxWLgQLX45LoITOi3tuPif8X/FfuFIoobVr6YZwoGGCPUOVzKwGOHpxlSm7EJIDebUhf0mFjAYqQiTKyqF6ymj2KxP8CXZFBSgVCI1Y1pZYp2OCF9Y++7rvJG69d1Nth3JoCZLK5re+DGIPClQUnYbvKb7UQfrKCpzJUZH2Sb+f82qcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJHzbhDGqQExC3H2PqPBr/JcfhUUiL7SE8xndOa8ido=;
 b=LOHL7xtVnmQzZQIDGVLQAEmlMew38nAyTRGW73LsBOTngZ1mSRNh7KiGcH5Ss4oa9X65giqpDFrEjeq9XhaMzsrxhs1ui3gEkI8zaZ1GRH0nuhvD0g/Z/SCZrPoStODubqA1Hw4JJqbhS7u5nI7FXWCrTKrgvw5KbjS1DRkV9kBJP/oqOcFgPA5fpBwBE9ieJgACJiG5dCpMM0oeCJpy+n6BR/tFNoDjv4W+pS4ZdQtD6pLsTjITMuNjbRiU44zDQMqKA70l8ueNRBi+CiMCjNmbSi1NQGWmocY8RzzT0Qkr60vb/vtYf4Uvi4vzNrhko0b+nxSwLFhstAF6aX3AMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 12:16:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 12:16:39 +0000
Date: Mon, 20 Jul 2026 15:16:29 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, pabeni@redhat.com
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ipv4: require matching source address for route hint
 reuse
Message-ID: <20260720121629.GA2309447@shredder>
References: <20260714122618.21698-1-zhaoyz24@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714122618.21698-1-zhaoyz24@mails.tsinghua.edu.cn>
X-ClientProxiedBy: FR4P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e11fd50-3f06-492a-cecb-08dee658c06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Rl8B0VsJORnIvbeDgAozNBV14txjOpwSKXSgqqrARyZlxFz15ghvt+ulraErmYWXnS2otbyE/E3xCftYmvNlpkZZcqzpckp92uJxj5BfkG0znOoHM/FQJFl9VM3zJbKiT/jnbEB0XxqfDeqDtBGztZAweeKg1QlQ5FtDEINtJLnPGq13JzDC/doC6h/on5Td2OApPWcUVF8SK7H3aoFMlNV7JSOG9rSfr8oB+wFpWnB8/YAetcjjcdXxQTnf2q6X1KQEQnWoypGu0J59rJEntIHmJnt8cSI07AmNX4dCYrKdNYYlP8k+9L2LCVr7nYlO/DL6HElchZeoHfm85JUFyqWzBVq/68hAKjV385eiM85dyNB2WhZllNbqfZ/ECut45mvGo+o5CnXolmzdHuzSo7NuMrLU3eNS9Tf1YlMyTq2I9xjzmMaty6NB8S9DUI40NXXkW5P7jRD/bZxE2fLLoItEPbj7FDk6rUK12OmM2Gsj1KaCD2rsXoRJSr5Rm0GOSRMTUYiw7QeWYpZIrXkv/BFer8dV5Ux3aVt/M+6sd3IueVZYRDAcQ/3OQNM7n+dbwEtFkFNPbbwK9JAjzAWqAIu3Psn4CvaYeD1Jr+T10cdTB3oROClCmYL2T05NOq+1AYdJwVUIDFKGWiHnK/UcqGu34HG+6WMsceIucRaVJFQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ywXXNYWeiWeiivdZMh//Ou2XDEIz9pdOEmUyugDCV3RtYtn2pzqUY9quJIA5?=
 =?us-ascii?Q?QtGBK6j2YWKHl0wUsjmTNVgLytDMcAs21I9UnxHl6/FoBqtl+YqJykpmGwtD?=
 =?us-ascii?Q?ccftQl6c6pzq8lAFiPovUavzsRaFjlUxO0F6IXbD1SmLKr4JWqSGe6mTKz8O?=
 =?us-ascii?Q?46J6VX68YJdWTC0KVQU2wbVgCY1z15+NC8ZOdVSNv1xFS67MgE21MA0AnRju?=
 =?us-ascii?Q?gtu6ANkonPQ8HrtbkbIQKBIqeVHuY0kTxKNXUZ6hPtj5y+qaqZEm+9MpmHo7?=
 =?us-ascii?Q?dmNPmruR5rOBdCFXQ/JDNHVXPymar6GDV5jdWBmhYr8hFoFYvWpGoOixXapj?=
 =?us-ascii?Q?lvVRiKhQqkNZfuF7jhfEIoz03TOtl1VTdg8teuU99PvOC3cD+Fnocm6lwL3P?=
 =?us-ascii?Q?Fk0kXH/6FNiwB0U5DkY2cPngTJZusrRBmomFEcHfQ1SEm0vQTYf54ZxiMg7f?=
 =?us-ascii?Q?2xOZjUvweD8LCrHZcyicUrrI1h0i5TP0B7vL2uwysWsCISj+KIXYX3ourZlT?=
 =?us-ascii?Q?TfTqRQZ3VW5XkOhaF57Z11oGRy2AX4VoVgzySM4rykN2kuKh5o55dfKT5KHk?=
 =?us-ascii?Q?/9M27EwW7xf2fNZrqhUBMHr6dA/KKzH6R6g/iID+1cX51yxafJDibCfQw02E?=
 =?us-ascii?Q?M5tojwVln+NT4HiC3UaQS2JIzuApl2oAPs7KATwN3hVZFpsjOcfBaBeRDCvL?=
 =?us-ascii?Q?xV70waFdqf7g883DRYEw4iWp87045odr4baYFB6Dm00epyCWgaLg65ASqhge?=
 =?us-ascii?Q?ztnPR61xVYpxNe1bKL3aH66xEKbmDIHyiQAe+jyP9wuT2v+IzmaNsDZmqvkS?=
 =?us-ascii?Q?IHaJpVykIlSGocdn32uqRlCQABrMk6ZWciHTlRfD547GY8M8dJcot0WWTdYh?=
 =?us-ascii?Q?ibqJGHWMfWSoXqFFmjupE6fHV7NpL0PyEUxKJZTtLa2fe6DH1NjlO0yKmjIf?=
 =?us-ascii?Q?bg3EdT+9YMuxZEADG+LUqQTS/xF+YTHrqNe2nYtnqYkEXFOWNBqRGN4oZ2Bu?=
 =?us-ascii?Q?UHgBcpqCKJ1DZejdymXi9dq+TIOwVxA5ILxFx8laboBpKNf/icUv9ZtA2gsJ?=
 =?us-ascii?Q?VVPvg1unokrGlqLqzWarnIUA4EgXemaa31CNZQDIydym7lpOevJ7xIGGTx19?=
 =?us-ascii?Q?nNWo/JTXdiCJBRJaEbcCd6JwgvXkPHhBDXPmNH4GBSQ6+zneXzX9Jn/1qo5O?=
 =?us-ascii?Q?PGyRFvEzr7dxIHK2lgZq2IqnCjTgqeb/88xxyhnY2wOBlMGsnwK136KPFqx5?=
 =?us-ascii?Q?nnWhprsOkIABN2L1Vtaz5bSsSRcUu+G+oQxnVLghHe5hzxaOwFDt0FWZg6Uk?=
 =?us-ascii?Q?mQKmSpEB9fbdwWsgxNaWGVbkPtkH+jDVEXJ8UHfxX/33Yacr7nmr5RRYjlqP?=
 =?us-ascii?Q?QgazF5V5mhiXINYWNg5dqGM/f3Gl6HayBL1T31yXp7KDupR8fh/ShrnXa0Gd?=
 =?us-ascii?Q?QpwfSchpj6Ft7TcujYx1fkeSKW6M55z6B0nrmh0PMou+gEhpHR6ULYs1TTNl?=
 =?us-ascii?Q?XyoqZ6hO8az3LJzGgfDEOvJ2fOZT5DG2oK8FLpspwmDVnq7zhuL0wnImUDYc?=
 =?us-ascii?Q?WFMqmWSY2HX7CHubNKLmp9XW95DOsqcTH9AaFJiwy/lG69cJk5D4padwRVjG?=
 =?us-ascii?Q?LydUzzXKMezWJ2WN4YSTML6QQU8/7rnYVkoR4Ybv7brRKdEkk5weww6rRPIT?=
 =?us-ascii?Q?q6h83b6Nrcd22L4rKmJXEltzwTcYBvxsYkTlpkEliJM2Q4yK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e11fd50-3f06-492a-cecb-08dee658c06d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 12:16:39.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2plU72X/YNF7+0VhtxtgRP+IgidbWQi4KauztSkf6cg0P+LsIhdlMvjXKADvcNGtDj9Ft6j8gvaTwpVfoTogA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621

On Tue, Jul 14, 2026 at 08:26:17PM +0800, Yizhou Zhao wrote:
> IPv4 list receive can reuse a route from the previous skb in the same
> receive batch. The current eligibility check only compares the destination
> address and TOS before calling ip_route_use_hint().
> 
> For forwarded routes, ip_route_use_hint() skips fib_validate_source()
> unless the hinted route is local. This means a packet with a different
> source address can reuse a forwarding dst created for an earlier packet
> and avoid source validation such as strict rp_filter.

I'm not sure why we are skipping source validation for non-local routes.

The comment above ip_route_use_hint() says "Implements all the
saddr-related checks as ip_route_input_slow()". I agree that
ip_route_input_slow() only does source validation for RTN_LOCAL, but for
RTN_UNICAST it is calling ip_mkroute_input(), which eventually calls
fib_validate_source().

Paolo, WDYT about always performing source validation [1]?

> 
> In a KASAN QEMU router with strict rp_filter on the ingress device, a 

Why mention KASAN? How is it related to this bug / patch?

> bad-only burst was dropped entirely, however, a paired valid/bad burst 
> with the same destination/TOS made all of the bad packets pass rp_filter.
> 
> Require the source address to match before reusing the hint. Packets from
> the same source/destination/TOS still take the fast path; packets whose
> source changes go through the normal route lookup and source validation
> path.

I agree that it fixes the problem, but we will always pay the
performance penalty, even when rp_filter is disabled. According to
commit 02b24941619f ("ipv4: use dst hint for ipv4 list receive"), there
is still a performance gain when we perform the source validation
per-packet.

[1]
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3f3de5164d6e..89338111793b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2194,6 +2194,7 @@ ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	struct rtable *rt = skb_rtable(hint);
 	struct net *net = dev_net(dev);
 	u32 tag = 0;
+	int oif = 0;
 
 	if (!in_dev)
 		return reason;
@@ -2214,14 +2215,13 @@ ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	}
 
 	if (!(rt->rt_flags & RTCF_LOCAL))
-		goto skip_validate_source;
+		oif = dst_dev_rcu(&rt->dst)->ifindex;
 
-	reason = fib_validate_source_reason(skb, saddr, daddr, dscp, 0, dev,
+	reason = fib_validate_source_reason(skb, saddr, daddr, dscp, oif, dev,
 					    in_dev, &tag);
 	if (reason)
 		goto martian_source;
 
-skip_validate_source:
 	skb_dst_copy(skb, hint);
 	return SKB_NOT_DROPPED_YET;
