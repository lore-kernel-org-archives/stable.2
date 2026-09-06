Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1093C2D;
	Sun,  6 Sep 2026 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788708851; cv=fail; b=VSseMzQI42xGzGS4UB1aTqrpuVs6jiRT/LDeBvyeRJDvLdg7nrmUAdARy6QESkZdhq4R6AapdY07vLmFTeshKpN5K9/Uk7aY6waZk1ohMRH/0gBe3OR0Oly8kN6+ksWXBcJxG1n982uhJ5syPyGxl9VjKATW5+x9hRXrvoh05pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788708851; c=relaxed/simple;
	bh=boWuphgAwuQjO5285QN5oUMdfv+G80fHvWqTJHjFYeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZmkI7M2ElUY4LgQMEmVtuqohbZ6dLnNEXIjw1IbBWnWbXG8iGrXRjeyBrOZ8DU3NqQHQ4NuNGlxpalp8Y4msTfYGhKov+rs/ikPGnDDj4GUpxgg110OimwqQCP7CI1LqNhLu468duHOgpooorgL7wbWPI59rweo6yPihcUpH6ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ox4XR967; arc=fail smtp.client-ip=52.101.57.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ox4XR967"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eotdHg5Ngibqg4Bx6MEhxnOa30lXCMzXl+ybUD71tJqMILVrhrJ0k5meh4izVTFKaMoUa4hGTezlEsYRA4U0v8wdfGdv8fzBi+oDqjTNMHEIvlfgHKNwW6bQ/SacmUisp7oHgfMUo1qZ+FqYHipkJwJqZHOb/JubEEFbbF34gVB+TpeqJGZbhAqaxCBH5/dsOgMkGELXgg15KeIcEPu6h9INPtlhUI3M4JGXJUotXcYXjnILB39Xmh3Y1VySGE3qbafYZtOj92+PdmML+TKVmixDUAv+wjNtT+eMsenb31HUAoXuDWOgFSvrZ8LSzk+VfDpISDgQRKODWZB8YWJ+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r51klYyAF6Y0Dn2BoUkZOjprt16HmEtV87812zPwEkA=;
 b=TKVT9V9KKCfD1zHtEtxIJSXT7lge7L9VWFNFUSXKy28MM1v0axYqqGeB87oXuq/Bz/uIZZ2Y2PkSvdckxC/PdxHTbL6+XiV9DL8GWNLTae7r0HmCkW5uwJ1KjlGE+T+5+zac8yKhT5QcyslV/J/AdEI2e9frRTsopNpRfZwi247AIheImR0Ai8kvdwBGeGbkcAvXnNvcXKElDp42TdfDjHyx0MABEzXwtB/QeQAv0JaR4Re0408wy64/ocIzGAJFvkeGlMIaGHTk06Cw2cykIEMsNE+annyvtdSK0XhtmXhii5ARDzup62NJEVASdRjGIIg17UewIzAmxuR/ux4j6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r51klYyAF6Y0Dn2BoUkZOjprt16HmEtV87812zPwEkA=;
 b=Ox4XR9679kPA0x3o/ToPA0/WSYZ9mmBI8QgbnVE88N8Sz3YQK+m1ypqut2lqPfv5ufUKc9bBeUTx4OWIY9OraA1KFUzUtg6bOiREuI/jziP7MN9QyYA9PON4ujYxMa6LXeTBt2PebwMF46eieefNYn1VcopOQddlc2tFIqCooKwFlF4XQ4gExyIa5ATujhtJrvjpf9hJclelAhHqmY8OQxIS01C1Vxi3PyaIycvhoLvwmji0ONYPAopYg7moA/jOsT5dcTLXfQmWjKswPWpLZKInymuj62LVtbU40O28zHJanyuLGsHSK+rotDCBD8PFBAy1JxLY1oB4YWOGWKM/Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Sun, 6 Sep 2026 15:34:05 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 15:34:05 +0000
Date: Sun, 6 Sep 2026 18:33:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Xin Long <lucien.xin@gmail.com>,
	William Tu <u9012063@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] ip_tunnel: reserve FOU/GUE headroom before
 encapsulation
Message-ID: <20260906153354.GB323313@shredder>
References: <20260904165544.1362052-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904165544.1362052-1-nicoyip.dev@gmail.com>
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: c18230a5-db46-4020-ee66-08df0c2c48e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7FbHHB26rVAZvtjXRifNObMvj3E7MlUCJnfGrb3zc0wj7+WO2cce3yqcZJ466hXY/m0uv5rLsiindfEixcC5AxGlW1Zq8/Cb29/jEuNekfRWAxMxFL6mq3YlB+mZEP5sVXb+WadaMofR/h1CdRvr0VQ5eCJKCpT8zGn1WQMZM3WDpapQEx7L+KBRv+bPYGQ1O+scr3/weGTNHvQAP7h4TNc6l9gUKbyAUhwQkPGSLCd63HsIGY3uqjtIXrRThlMWWH5+52aCXJjCEfdu2fNf1VLeK0vzDhvMlfr+XN/rvN3Vdva9u3dRH+Sk3H7qYG07rfy4DnH58Y5ZHAbd5eMW13VgRZPB31YVYTZ2pN264X2YGoUtpgk0jHasBU+2H11bMpe4aMoEME4GM0fNgVBoyr+6wuO70Rai8FB6wZ4ryjh2DYK0yTwV9ClaFbN/36Qe8T2SzXUSuBN9rXpCksxj7zw33Va2pWP8PQv3VstjYZjeaCJ5TyXhwTMqto64QdDUms3Qt+qOx/CvkDytDyXh5Vq9kjaEVCA/y9FlEkVZ/ErNF2KQj/BgCtno9VA0/N1N9U0wqnArc/A6SSNGC5nKG8YfXPpnZCtfyXihVjHcQ60xk3mEK2F4K2Amjed/mLOH547qtq6UcEIrUz16oYgh7bhSZVyd9Px53ucA/Clr7Jc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3fgn4kwDfq0VmvsrBFLmM+8r4BOJDfucJWdhBY/cpF9eQh67ZtnYdBb1pbND?=
 =?us-ascii?Q?1g8KbGEZPPcALPQnnnDdO6rDtaK3qbWJu3HysclYbiCoRRXVl91jXvIqq2a4?=
 =?us-ascii?Q?L4b0A8q7lJfUUnPwqEX6xx87a5q5uDjh392ZbZ319KfnJLJsP0iwLILtzomE?=
 =?us-ascii?Q?5naHryfYEmVSIcmbPJriUIQp0/SOy2cMYnj8gjN/Ij2eav8U+nTgTsjjg8h5?=
 =?us-ascii?Q?7MDfohPFng6y3tPH/VDHgW3imG5DH2ZPTtMwNBnZTx1/NAb4lHM8Oo5u0Nc2?=
 =?us-ascii?Q?iU5oCIehnfgdG2kWv6UByaC2pKFKQ6UAq58ic5mzeubvBn2oCco6Kghp00Hj?=
 =?us-ascii?Q?OJq2CrCkq7QipOL9+N7BrUzghhZjo3uY2u+SaNYqub3Ib2KVsX0deeCrU11T?=
 =?us-ascii?Q?nTnTn8GCJkaK7qkFkwyf4QOGHXvMkunSsrBDF/WKinvi4cQ3bcboJgYBONrH?=
 =?us-ascii?Q?AIvDyC2bXFD2rqkDh1xkx/PP+tWrgKJmLdLAzh5BPUFdJnWpJQ0cSfl85Ij2?=
 =?us-ascii?Q?tnicDaBTlpVowbQmMv3GcBsd57P7ln/nTT9dkQql95+UoHoE63mN97E4QuDU?=
 =?us-ascii?Q?VmHHeNGQGlgt8tks5fV9pbaIHhlVPqi4rdcgRj9MtyyjKTjuIeg6k4zq2ytB?=
 =?us-ascii?Q?zDVYZZkfgttE7vzipqt1LvaI0rbDKQ0mPLbe0gXuM/eygPNfYnBeT1uGhVGr?=
 =?us-ascii?Q?oQB6xgCAqNRlpA4hvj4aWJeq5jP6lRAJFiNcX4PCAqfmksh+TK/51MzRV2Y2?=
 =?us-ascii?Q?DLljWo0+QCCijd+D9OfIwkbE0IOU1PrHbQkknLGyhRP6Ic2pLK64W9lybHu5?=
 =?us-ascii?Q?K9XtczogpYgsTn8vy48NTVwOac4DAnk2nr3Z0yKjnnEpzpo1gzKVg3ki7DWu?=
 =?us-ascii?Q?A1nHwgKbh4HCgSLWdD5ptUv7wanArxJyQfiB0oPyEroI9dwc9UyG9pUGWA8F?=
 =?us-ascii?Q?jvDgs+KAy8EeHdPOsbJYrNh4lwkIARsgAu14jKlKjxfryZ0wY3gJacHw85OQ?=
 =?us-ascii?Q?hemLEkkVQoS5IcKZZY9Bec6hn44qoi6e5dk0YzCKstaqDDcieNGHoYBi2/++?=
 =?us-ascii?Q?8dQikvI6XvjkxFnITD9rflbFdG9+Jgx5UG1YegtZ2Fkcnwr1M+FBwRqsK4m1?=
 =?us-ascii?Q?tuhsRvDo9E8CigBFo+V+mY+BTw1YvDmgrwUAcWcVoLKPhMS0DSr1yNYeLKLi?=
 =?us-ascii?Q?8OEmsVR4xOLpmBCO5UIPJJskv8CjrzGAMGXlrUZccNkwVhtDmnrZ3oRQqmPx?=
 =?us-ascii?Q?EGVtV/Gg6MRY0aPTtW7mFYz9p0H+A7M6cdrwp+5infjFQTSZdy4bUCKZ23aD?=
 =?us-ascii?Q?OX6obG7p876PmDw/4xN8F8dD7mDzDYe7a9Gu4+q4s+ep+9oTIpD0yClnmJq3?=
 =?us-ascii?Q?2SZukmUEXh+4Tm1tTTnYmfqh1NNxsHSUVeWQS6vhoXtz6pbnWL+lAFtH0Zj9?=
 =?us-ascii?Q?9kZNy4m2potehLrhvfWdX/npLjIh4mMxhyaedpECXS/F/AHMem3UGbstkF52?=
 =?us-ascii?Q?o/7FjY7Y8hK6aPew5Y4B9ACMLCO3U27RKDl8VaT3ivNJZHtS/e/bg9CIXCup?=
 =?us-ascii?Q?3afPntfCB8r+mWtoOTusUejRlM1RT42PSm2Oo29gF25itd051CLKqP6gVJ04?=
 =?us-ascii?Q?O82BIIqFDJfWyNrWLFrzf7Tv/eUdThlvl7SYgcPIbfc+xIoiQ53ymmSw9veH?=
 =?us-ascii?Q?eiZ4uitX08ubqgMOIfpTJgGdumz6cw1fblEh4DdIwkf++EuW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18230a5-db46-4020-ee66-08df0c2c48e3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 15:34:05.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPi5Tq37ls9AclVo14ZauSX4kakQOwxd61Xqr5lUsY8adduZopSjzg3XUTFVTu3qYw9I2t9LGJKjUcPKpR4AcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043

On Sat, Sep 05, 2026 at 12:55:44AM +0800, Chengfeng Ye wrote:
> ip_tunnel_encap() expects its callers to reserve headroom based on
> ip_encap_hlen(). ip_tunnel_xmit() currently pushes FOU and GUE headers
> before it grows the skb headroom.
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
> Snapshot tunnel->encap, route and perform PMTU handling first, then
> reserve the final headroom before ip_tunnel_encap() builds the UDP
> tunnel headers. Because encapsulation is now delayed, pass the
> snapshotted encap length into tnl_update_pmtu() so the inner packet
> size stays skb->len + encap_hlen - tunnel_hlen.
> 
> ip_md_tunnel_xmit() is left unchanged. It takes FOU/GUE parameters
> from the skb metadata dst, not from the device configuration, so it
> is not exposed to this race. tnl_update_pmtu() still runs after
> encapsulation there, so that path passes 0 for the extra length.
> 
> The IPv6 analogue of this headroom reservation is still work in
> progress.

Please wait for the IPv6 part to be accepted (some changes are needed
there and here as well) and then mention its sha1 in the commit message:

https://lore.kernel.org/netdev/2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com/

> 
> Link: https://lore.kernel.org/netdev/b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com/
> Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")

Looks like a more suitable Fixes tag:

Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp encapsulation")

> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v4:
> - Not restructure ip_md_tunnel_xmit(); only pass 0 into the new
>   tnl_update_pmtu() argument.
> - Snapshot tunnel->encap with data_race() and reuse the copy for both
>   ip_encap_hlen() and ip_tunnel_encap().
> - Fix tnl_update_pmtu() inner packet size after delaying the encap
>   push: pkt_size = skb->len + encap_hlen - tunnel_hlen.
> - Keep reverse xmas tree for the new locals.
> - Note that the IPv6 FOU/GUE headroom fix is still WIP.
> 
> Changes in v3:
> - Move the headroom reservation into ip_tunnel_xmit() instead of
>   growing the skb inside the FOU/GUE builders.
> - Use ip_encap_hlen() to reserve the final caller-side headroom before
>   ip_tunnel_encap().
> - Drop the IPv4 raw-pointer refreshes that were only needed when
>   skb_cow_head() could run inside the encapsulation builders.
> 
> Link: https://lore.kernel.org/netdev/20260824111944.187200-1-nicoyip.dev@gmail.com/ [v3]
> Link: https://lore.kernel.org/netdev/20260808005956.3761487-1-nicoyip.dev@gmail.com/ [v2]
> Link: https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.dev@gmail.com/ [v1]
> ---
>  net/ipv4/ip_tunnel.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

ipip6_tunnel_xmit() also calls ip_tunnel_encap() and seems to have the
same problem as ip6_tnl_xmit().
