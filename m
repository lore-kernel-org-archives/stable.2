Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694D4A23;
	Thu, 27 Aug 2026 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859235; cv=fail; b=pd2sItxUZvb/Wiimwg2fzo8ga613rIN+F43NWZ7hRV/Cvq/+3iz4y5haS/yJvO3OR/YC+785eDG+1zw9c8JZRr7Qd7VUr87C9saCOLNImt+TYH4ibsKZIGubog940uRGzYW4FyWoJesEqp9ByxdRvoIkPbYvdS44eCr4LlfG7Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859235; c=relaxed/simple;
	bh=Eir+UTiaL1aje10DVOxkU8RMx0dfV8IJQkvJZJ34xlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=inGebx6HtK3pLLex7o+dvhTur7SvLPSHQ/gcZAhcsJTOB7ZjIDKEChOka3AWF0JE20/y5eBCelK8aM9eVKdX0zifsk1JR2pOF722LoW//wp4vf4aFzp86JRSCUIhzRZWZ+GwCKzLO/rs+VFQQoGNXCLuFMd/F9stzcKZVNcOQGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TRm4lBHR; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TRm4lBHR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9RkQrCaZRREytvTQ8iOLBPELesCTHcm4QIRFS+wntLyAHF8UyjkGSGyJdv+L+v6J1QWxIzk7FrIkRd67M6ayxwS2C26+7jnq78wpqOtIMaE0lgHj5sqDz7poFr5kd1YMPAzrpsdbxuZyg351YHQsEUNoKxwoeUdqQKZaGYBHF4GzOneJ3Tjqoy4E2ip/sbfwKrgFiMhI8aYzRgdwmzq8YhZgL2K83o5MN8upkbOztjLgdZS8zpDpvU4FsMFtPj+sW3247gf3EgoC7ss3lPUz6I3SItYWR+GkXMH6l5rmgyrD26TPcCbUygTnOmEEVWhbIVkzMBkiJkvLstMig34/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64NhxSruPhK4JzC1i6GECooj2Bc+BjgIVt7CtUQurxE=;
 b=op6P/weI0IkpDq3wW9ioddfUxYcfNSOY56XMU05UWucMdqfK/LPyMQBvXP5BCA/8/Cna7w6hyJDLL2K9YM4i0MCnoxfezsMUipByhrpetxL4PO5a59VAcqCWYHzlIkkSagVKql3Lxl3O5IqBxgE4RreRYI4wg2GfY1W0NuQ3JbZAbdU40cIIuMTV9BA8gM9yxe0nvSIop7MVaLk4u620zMGiDqdUoLVknrLgEAK+Dzxk6JKhPl+WmBe34/ysFVs9y6RSWds6nYRbSDmww4O9Z/776d3RfU1M1QyRawJCJINECk/59k6I6/SSaj0DEqbWlo5ZgD/kEAjLsSVHoeWXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64NhxSruPhK4JzC1i6GECooj2Bc+BjgIVt7CtUQurxE=;
 b=TRm4lBHRO+n2wGS8SE8cKO3eMvm9N8AAwokDjlRXANCF3E/hum5KieVZXQJqELCNcpjm50c24awdsUL+1fJ+0q/CtVG9UO5XSbRXlMNG4/mGMXNLndjqhftqxipPrC0CUiO2iYCi9XX8wLIvXz1rPwVbSiyVzW9k4Y6/vyNw4ERjOrMO1JyEv6IowVqDHlWM0sa6a817JdpxMxM26xGK2PraZVByOo1NUD/kd7FCpHT4RKpp+siFDRP5IG27zKw2ZBpnz+V8Ng2aMLm2x17Pol4g7aGHHYZZcR+lq+dOcE8gmGsW/o1IKM/pnZ9YEo95+/9UjN54Knh0L87QYbHh1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 19:33:49 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 19:33:49 +0000
Date: Thu, 27 Aug 2026 22:33:36 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, aksecurity@gmail.com,
	noam.caspi@mail.huji.ac.il, stable@vger.kernel.org
Subject: Re: [PATCH net 2/4] ipv4: udp: Create exceptions when socket
 matching failed
Message-ID: <20260827193336.GA2283998@shredder>
References: <20260826143735.1819315-1-idosch@nvidia.com>
 <20260826143735.1819315-3-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826143735.1819315-3-idosch@nvidia.com>
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b19e9b-927e-497c-5ecb-08df04721e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sj5vUVvenMPAuwKnDPxcPuaEDt80lMUnAdiIrtDzD+TUuNzhTw6nQMFZIF5tL7Wb2N1ciXAX1032XEn/NOufIebbtQPFWFoaQzXYotxPfoDmLtstftEURGA+QY88j31Y8wrkGTUSfdLcxzMXhLCAWEVU2UcO4omz9FYoKM3yfwykA7IekdVha+eelvcPAVpzsC+LIh6aw7oPeXs20N45EuJAQFzoB+CKd0ZD4t4wHjvMAUjSeSYK1FcEuVcli3GmSfPJ/kM7Y1uRGXyrfY2ekhSoHCJ1d6am/jFoPGH6sU9iv1n/cRBrwu0YfwAN+g1OoAPtYe3JjZwbpQFl9MO2n3vgpeF3hjBthoErRvNCWAqUUcHTjuWJUU5uEUVYzBCpm99QeivE5zuTVevR12vSMmeYHuLNVFP9yvwoUBUADBMStIlAyd2DtzXFrhkbw6CqgjvvRQJ53QNzb2cwETzFrCwF0fe4zkhI4xh+wjmPAt2SS+B5ODcOcLVTpSTtQOidLtb2L0gqp/GO70kPoLM/2awDi+lQkcAMn5licQB4aAKcD1STsk04ug6lGSg69leRVhflONsZ7wXcsIFy6dIAU1uStWhCrl4Ua3bnDNPGWxKXdKlHJEohgchZffd12Qa9wDoaXQTQ+lX+1fgOuOAG0j0yDKQray93M7SSXdWL4RE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wOQJIl3nE1LN0Wg7MCXreadrhagRM+d7LaFbVhyhOi7RCrBNYZXLN2aM4buA?=
 =?us-ascii?Q?Z1/fdojJjyGUL8TorO0nneGLBgpHNDDmy7KmTA+TB/VAiTtAsPER8UQwxPma?=
 =?us-ascii?Q?vZsTXmNAbJUX5sCumzMm6KLVExVQCJKCmS4EJo3gWV2AlKzJx5s39loFd6Ba?=
 =?us-ascii?Q?ngG2GHvgoJDkLn5AhZYzeBPkQJ6aHjk5zUy+OPZm3EAf7v7CeDdnNi8VUHID?=
 =?us-ascii?Q?1GWOvdlFRq4UKbGKZ6Z8EnNibHegyvMfZOBC1iyGfO7ckPVG5FdQmuQO8qvD?=
 =?us-ascii?Q?550xBSTCyNNW6Qf5lwpTeM9CqrSHWKhgRPNzExz87dfKx8GPW0p8oEh9YGvg?=
 =?us-ascii?Q?Pwe+Vlp5T1TFeilo0HmOnGMeE3vuYOtUkRj7N7UJVHeNLSZqDrEv3vg1nVNR?=
 =?us-ascii?Q?NtoVFdMYsUD9N4ZbbJCn30IOSgGOGK+70+7r+pz1DB0bIdI1kEJqDiDEdmtk?=
 =?us-ascii?Q?YP/0TFSaynKbWRSNcfOuy5LFCkWAvq83H1UFKDL5FmsaaL/6HDRpPsFiwMNo?=
 =?us-ascii?Q?/Gk1obgTK/Lu5V268luQaucvXCm3faeSl98yKFVhU0f3uukZNKeGm4Amrcs/?=
 =?us-ascii?Q?x6/E8lDzcT7jXop7GY+pt/seZzzt5IoKQ4yrUomFhfNb7evwlYcDvNFDlE/w?=
 =?us-ascii?Q?sLI1numtnyEA6+FgOGv8369v7eXK6DOmhtD3hIT9m7tpl42vaKwZJqqmgHm0?=
 =?us-ascii?Q?7IBeVr06AaEN3792yy+75MpX7ZrU/V/qZqz0CqwjHAbNkmceVUjcAFyah95U?=
 =?us-ascii?Q?p1A/rWV/Y3mtUd0AvCQdX1OOIN6AmaJxjOuBl/s0eFKZlfBhv1lzi5yE+fZl?=
 =?us-ascii?Q?/zDjg9XSlD3j6fJW6MCnw9uGoi1yZC3UWfvhAJHgG8WWJIFjVp91N3Nr1Qoq?=
 =?us-ascii?Q?4cWya1g3VbyEi1L3u1Lmk7ryBrwNEa8iZsuxAx4CifxjHzDOOu3Mx59g3CaJ?=
 =?us-ascii?Q?Lx2p+yV27cVqy1oC2S37CzQo/rpBYMe2CcLytxzaRH6yjZYu5b4brGlkDzzo?=
 =?us-ascii?Q?Y8gzZWcJbpRz7HzdeILBoeIRmf6FzBJ0W6a3cjh2ivyRboicig11DzIhe/RQ?=
 =?us-ascii?Q?QSc0YrZPTQ3pEvAFzNBuT+4sEXYNgL9KoJKiZjHvkcWN8eL/qxahhg5ezCyo?=
 =?us-ascii?Q?ahoDqXF5YQ3JIwVXKDQrt20rANxNnfeZmRSp/krGLuVQgRBjlMEWqwlT++mo?=
 =?us-ascii?Q?Pvu3xdj5fUzQLizdfaDa4byK7edfrZPpo+xw2wllyC4KJ1dyn+VhltokaFvT?=
 =?us-ascii?Q?Dh6ZgvaV422ONmCvr6ihwws/d/Wg+rF88rgJg6kYrhj14wNrbWO5I81qEGYq?=
 =?us-ascii?Q?az+Xlkh0Li73RhRNXH0uQHeJYmcKAm1PLB/FWb48TTwMQbnOYryrOfpx9/or?=
 =?us-ascii?Q?NB9febxKvcJ8P0Sksvz+tMP0oOYKU/JK6FQ8iPHpXkb3Y46SA9AchYdpKP3+?=
 =?us-ascii?Q?Nugth2bFf+058DnUw+/4zeXOjQL9kMTOKDzHlD1m5pCBI0sE+weuCPxluTQG?=
 =?us-ascii?Q?9W6LIFBz4cuWgWmIlvgoS/MLOslRuK6+L8EPvZqQayxc1JbCqocRhQH2vJBx?=
 =?us-ascii?Q?HY8SVdjX8B8A4wjWlsmL6CeYjXwu/y1wSqMp1u+82gS1SnNicClmmcU/jXPC?=
 =?us-ascii?Q?tNuSwRt2LODPG49TujHrfhRA4bGgN4L7hL6lG/gRDZQ4+HAezR6ezBLNCErK?=
 =?us-ascii?Q?zG/Kf4QMrTb8myUCUSoIYI+ik2dxiYIiN+yMP+gXgHXBmIxoE10wE6//muwj?=
 =?us-ascii?Q?hvCHy4fJOQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b19e9b-927e-497c-5ecb-08df04721e59
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 19:33:49.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tJNEs3LHPiGZPMzkzdUnDnhzy5CRkWMKR41cCZwqidnFDKVLjT8LzaiU8WZyJwUbbwKSUcowmVnfIZ84M/SHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674

On Wed, Aug 26, 2026 at 05:37:33PM +0300, Ido Schimmel wrote:
> Currently, when ICMP Fragmentation Needed and Redirect Message packets
> are locally delivered and quote a UDP packet, a FIB nexthop exception
> (FNHE) is created only if the kernel can match the UDP packet to an
> existing socket.
> 
> This behavior allows off-path attackers to conduct a side-channel attack
> on the FNHE cache in order to discover the ephemeral port used by a
> connected UDP socket.
> 
> Commit 6457378fe796 ("ipv4: use siphash instead of Jenkins in
> fnhe_hashfun()") and commit 67d6d681e15b ("ipv4: make exception cache
> less predictible") tried to mitigate such attacks by making it harder
> for attackers to discover hash collisions in the FNHE cache and by
> randomizing the number of exceptions a hash bucket can hold,
> respectively. Unfortunately, both of the mitigations can be bypassed.
> 
> Instead, mitigate such attacks by always creating a FNHE, even if socket
> matching failed. Do that by calling ipv4_update_pmtu() and
> ipv4_redirect(), the helpers used when the quoted packet did not
> originate from a socket. The resulting FNHE is indistinguishable from
> the one created when socket matching succeeded, both in terms of cache
> occupancy and in terms of its contents.
> 
> Pass an oif of 0, in a similar fashion to icmp_err().
> 
> Note that this does not allow attackers to create FNHEs that they could
> not create before, as both helpers can already be reached with little to
> no validation. For example, by sending an ICMP error that quotes an ICMP
> Echo Reply or one that quotes a UDP source port that matches a wildcard
> socket.
> 
> Also create a FNHE when a socket does not wish to accept PMTU updates
> (e.g., by setting 'IP_PMTUDISC_OMIT'). Otherwise, the fact that a FNHE
> was not created can indicate to an off-path attacker that a socket
> exists. This applies to all ipv4_sk_update_pmtu() callers, so ping and
> raw sockets that decline PMTU updates will now create a FNHE as well.
> Such sockets are not affected by it, as ip_skb_dst_mtu() uses the MTU of
> the device for them.

tl;dr - I will send v2 that calls udp_err_no_sk() unconditionally and
remove the net/ipv4/route.c hunk. Same for patch 3. It means two route
lookups in the good case (matched socket), but I think we can live with
that.

Two comments from Sashiko [1]:

1. "Inverted signal". This is correct and it's something I considered,
but it's impractical:

a. Without the patch, a wrong guess is cheap and an attacker can keep
scanning. With the patch, each wrong guess requires the attacker to
repeat the setup phase which brings the cache to a state where a wrong /
correct guess is indicative of the presence of a socket. This is
time-consuming and therefore impractical given that the sockets of
interest are short lived.

b. It requires "non-default routing attributes" which is uncommon.

We can completely eliminate the "inverted signal" by calling
udp_err_no_sk() unconditionally.

2. The comment regarding fou/gue seems valid, but it requires fou to be
loaded which is again uncommon. Can be fixed by [2] or by simply calling
udp_err_no_sk() unconditionally.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826143735.1819315-1-idosch%40nvidia.com

[2]
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6981526bd59c..c32c416601da 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -941,8 +941,10 @@ int udp_err(struct sk_buff *skb, u32 info)
 		/* No socket for error: try tunnels before discarding */
 		if (static_branch_unlikely(&udp_encap_needed_key)) {
 			sk = __udp4_lib_err_encap(net, iph, uh, sk, skb, info);
-			if (!sk)
+			if (!sk) {
+				udp_err_no_sk(net, skb, type, code, info);
 				return 0;
+			}
 		} else
 			sk = ERR_PTR(-ENOENT);
