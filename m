Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA333C73D9;
	Fri, 28 Aug 2026 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787945244; cv=fail; b=oACcWGUpKJ0BVFnEHHcPgBTV3o7XdxAZsJax94VRKZoFZdCKKRqyiwVefTVqKeCrVRdK9t2Ve1leCR5wcD3swvc69gy/fMGrk/BldQ/OtwXtmSi9LJCdVPznITXmFjZd8LbJxxkKWrc78YWATgw5NoKQfiNNdzRghAWx/xTPvsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787945244; c=relaxed/simple;
	bh=VBOr4GhPs+BCtCcE3BWnR3j0Ps+BDIuEFHsA5/9yrAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQH5YqRQpfTfbujp9hiqFttjkBZ+bID0pF5uxmEImWS9FS074+KF0PnkLnuvf0zjjQ2RPwHNjBSo7e2kfdL9HuDp8XyykN4KcSsS9h7tZkv2xT9bnkHz9nBTdRfYXbhhYxSQvkOfaZ2u4umQVCR+UFoZ25C25pFRBFCjUiS6nps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J69ME0vM; arc=fail smtp.client-ip=52.101.57.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J69ME0vM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KATo9GZO24Yh2vG1vdYUMuePBWJaOjjyDn5ofDVAzG4J4Kks3gBSJ2KGHOfKdPSphZkvfcOeYSCDnvWsbkKfw2JCTXBU1FYnkUThqbl0vlmtC9S/jfloUQuuegylevIw2xuX88D+4JXKWVT8Qz+ccGIlDfAuQrzDkKvHBa3l7ShH8UJ0lUyBPMjRMwSLdFPC8MCf0UIhwMzbomFC6H1vr4zPeejASpVQ70lNEAxAnR+qyF5uooJIXTuoUr9PubN62MJ3TF32P6bsiDslmJ1vKqux4bf7a/guERB1hX2DuLQZCOeDKlUb30chxbIcpX2g3w5sPlt/UkWBRlqIt9/0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRNHD6AKMxQAm7Aj5FbxxnErvnkY39CwzXPicg3FLPI=;
 b=MP73hyk3Td44Hg5FWz30wQhb4SbxayixbtciFGsjc1wN8++jmPrOzWLH+lK52gToiafgt7lJWtCtFcW3cxzesX8Hg6NqcX5W5/8f+6IR0d4OLjG6JKknDx7oucYjuRPg5JCSiQ2/LTV3JgKNEctMJgID7yaxxaOznKciXLZxnXubIkErn78CmiJPNgi1/N8XRv9Lsl1C6ewL48wxVpB2pWdv7aXuNGwtbIemsDH8vcAqYJkjfBDMpoRAh/LPy8kUTeJ5SwuaA7gdNeYi3gCvoZHzz6iFN/q3IiTU5sVi7Q+laUef7GIwVqDmAFU00MfSsipa3bFbTknK3qMEoBmDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRNHD6AKMxQAm7Aj5FbxxnErvnkY39CwzXPicg3FLPI=;
 b=J69ME0vMPKn3qptcX0iR2dRI3irzyYlZBewGFoGUAVz1KmMG86jn/3jlt/q40Pg8B0obaVwasHSBFdzU+ZtbBtUqo0OCBCwvoUYKeKVPBEWZ9OT63nnUbaPeWeKI5rWXl1ns9RGTuuiXpiQ8Fg7WXIZLBTgKywIpW/2oIfotUo2GpekCAfLeU8Ks+Ogxejnnq9fFKqyFn4HIvkGvM8VJ8ogUbp+UvGThjNdykbysNSuevPb1a5+/i1vxT13Vld1If3Oi2NLp6zpMYlYjZ5muY/gNWLNaTfrO8sRDrp/6LtL3bHwCbFlb5IAouPmZ1xV3742L/rdEKBr+eQ/tAghJdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Fri, 28 Aug 2026 19:27:18 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 19:27:12 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	aksecurity@gmail.com,
	noam.caspi@mail.huji.ac.il,
	Ido Schimmel <idosch@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/4] ipv6: udp: Create exceptions before socket matching
Date: Fri, 28 Aug 2026 22:23:43 +0300
Message-ID: <20260828192344.2596928-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828192344.2596928-1-idosch@nvidia.com>
References: <20260828192344.2596928-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c57f26-9534-4009-3f8b-08df053a5c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dfmLvyp4DdKS14VUvKjzWD8IDbTgQQMxcesJSs6uxpr//qMh1sjr3t+TG+KgmtmWR2OGwBvIn/zzCg/m1Be8+8z41/rzZkXNVpX2tWLItPvaxslWbgp5pId0NVSTazAXVouiju4rL9FcIgC2byG/dQyiVcFlpJgAqkxIlygBYgFos4t53/g8HvsUCEDENtgljSZvivqMD8my7fwdkFbqW1lrGmAi+ZkSxaAqnd6vfAZDyaoiirjLt0O6seafgxEwhqJQ5iR4oZ1agi/Qde5TRqY6sTKJCyvAiZ8G2ErbBaNwYY+qq7Qp+vEMvoEh6cHTR6QqpakZoBeEbvIfdmyJx5SrYq1Lh78Bupb1gEbvizUN9/b7tGWQObWLn4XVJvPn7OoSBg1e0xtosMAproNnqBiCSsurrLkMJxtnfNehVX1qrP1fbiQy/AT3Sq5pkvo2A/07Ia4cvv+LyUiZQ5HCfvAqgVLbBoUmXwSjLNBZ1hH/4ufiRIgGt2m1UD6BBWuKmMjaH+sRFW2WI0YAAYOPoxZ8zy+IzCApt4EdRmThTUMATkc5GlLTr6bjRETtXUbue5bkWCFuKtw8LwQ00t+3n2Mk+w3jQZH5fx+qaHDGiMxgrzoB0pASpWJqVziaQmECVoyXhhEHfISaq7Zx8jyVGzm87iJY1HsYNG5/wFEQhN4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vx9SXjTIXxoT0MkwytakUf1oUiqXdueeOTOQKV9WaZEJ5QhMNkrVfW2byIX/?=
 =?us-ascii?Q?aFW9AA9lB24eGB9YoCSMeIspIYtSQSxTL5Rr1D8wHYp/uuPpJkSl8Q9u1dYK?=
 =?us-ascii?Q?gKqi3VmZ8KBwwNDIIAwQYI92eh9XPBCslkOaZIcmQUzPCH4IDf01HDFzUVcL?=
 =?us-ascii?Q?bUksCvBbfOQd3xHOgg8Avp2WrLDRfBRFQ059HbvzXVbJpjq75VtL5XCiiuL0?=
 =?us-ascii?Q?Bu7B2c9MifqQm2Ll+ItH1eEyudILjhYKJw+F36fX/T0VP1sZyO6KnKDMclTZ?=
 =?us-ascii?Q?0A3hJe69ez/YQbUGM4j8csOTEUOWcIXNiZ9EX0InvPuUzk5i9Zz97dmixvex?=
 =?us-ascii?Q?gCT25MtrWJGfXvEidYwL58cSlbli0cSbkdju2Ck8tYJcp3Rz0pVlPou34hJW?=
 =?us-ascii?Q?nSGGKKJVLebBwn2eEypE4xfSjj0kEAwwEifbBSlg/ZmPXZ/Vi692epyvLH2e?=
 =?us-ascii?Q?sIvlDQU7UkOFbR9X3S9FqaXuGZkUJUKkJNmYWFqYNRWcw5MPRILSRzTdQ5Wh?=
 =?us-ascii?Q?v50/vHuKOY1flooax8dqeX37/uCr6nm+/oVWnkDhJXtFx6m0dCJ0FMrzYyb6?=
 =?us-ascii?Q?Hf5OpoYCEzu1lEXx7SySAU13DOhWqTZQ7hYU3pcpHGFZAHTur8Q40u3xBMtC?=
 =?us-ascii?Q?aav+l6iVtiIzvZEtJcsp9vd1rHbMbcT/OnW9L6k0skCLE1p2S/1PJPY2ko2C?=
 =?us-ascii?Q?BxchQNuAEqwxXTg7OwNV+Ji3Fkl4l+7+5zWsEh+oq5vGhqSk8cjnQ3blAhVD?=
 =?us-ascii?Q?lPOlZIsastklp8M9FVQ+46cjfKJ1Hc4sxKPL8VRIA4L5LxBMiuMLe/imj3xS?=
 =?us-ascii?Q?VWiQ+A0R1Xn97Q57mVnJP1UpyoXoLVVNhQECCrBa3kH0XjGHwaDwyOFz+dgN?=
 =?us-ascii?Q?TrlxckMBhZqMqqhsqNRJIIaQ8jK+ylgNLoWQytcAA9itdOkED6V6lVk0sANe?=
 =?us-ascii?Q?Cy231OP26Fug5Kq0bwUyXXwecfUJY3RSealZO5Lsu113+Fa9dAhJEwFWyWgQ?=
 =?us-ascii?Q?WZx+bw9y22ERhQZGdksazY2C63rBZ9BBnjqFhsn+EjC0YdTxGeeK/c8MlLJH?=
 =?us-ascii?Q?ZQ/nMSLKXn+hJIAgk+mTrwiCAoIGzXxF9c6HCypp7P4aL8gNtQa1czTrKVBz?=
 =?us-ascii?Q?CfJPPNkXNzHCV9CgBFH1N0ohvWOo4AY2M2VLfs+0S6Y/wGUNt1V70CKVpLW9?=
 =?us-ascii?Q?0p8p2eyu3cTQjDNdTyOAGahTpphdbM/gJh8RYd02yd3GLUMotEF7Aljo2+pj?=
 =?us-ascii?Q?46y2chuDQnKtXEL7iV+RxicG+9JwGRoWaBv7FdWy5haPl/3q6Bb3WpubYw1t?=
 =?us-ascii?Q?Qz7LFMwYuMVfKpeyEugsTsd3FdDP7s5CPVIuKYqwW7YUSa38ABw6v9n+NkRP?=
 =?us-ascii?Q?H/NOnRRGX8FwzHJs0RxqKICo0Or7kc4NwpEfoJwmBUrQtW0ytFF5Nx4FRCVm?=
 =?us-ascii?Q?4FsIfTQmWZwW7le+OLtcXoX9V8joY2BKBxIL+i4JaHS5iV3oq1Fb3aCKWzEz?=
 =?us-ascii?Q?zLd/PjdKw0ifXF6qdObMuaiAMDZ5Xx64iVDXL2mp9IhUdm42sXSxxx2cnG2L?=
 =?us-ascii?Q?o58LaRteH9NzbncZZ70h8raP4p/6I48zT2Zc0HJbN+9zgQ+tJ1bgCGXMUlzF?=
 =?us-ascii?Q?lUHwuUOGENxOcEA3pkBlgML0iXfSYD0Exi0+EfgpVVgtHxg7RZlD8Pi++Wnr?=
 =?us-ascii?Q?WXUBGXHGMRz3tvNo/MvyO6ZdPbOHoCHSU43zCGBj7c5ZSqvFcSQ+WTOgayPz?=
 =?us-ascii?Q?sdQvQb2Ssw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c57f26-9534-4009-3f8b-08df053a5c0e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 19:27:12.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/fwJAIw6MppQbdB5BpbZmzI0nk4gS4Jbve7AC8JS4zELKm8tBYJINq3u4PSo2caR2AVdCaE5PYbwJ4dl5H8Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

Currently, when ICMPv6 Packet Too Big and Redirect Message packets are
locally delivered and quote a UDP packet, an exception is only created
in the IPv6 exception cache if the kernel can match the UDP packet to an
existing socket.

This behavior allows off-path attackers to conduct a side-channel attack
on the exception cache in order to discover the ephemeral port used by a
connected UDP socket.

Commit 4785305c05b2 ("ipv6: use siphash in rt6_exception_hash()") and
commit a00df2caffed ("ipv6: make exception cache less predictible") tried
to mitigate such attacks by making it harder for attackers to discover
hash collisions in the exception cache and by randomizing the number of
exceptions a hash bucket can hold, respectively. Unfortunately, both of
the mitigations can be bypassed.

Instead, mitigate such attacks by always creating an exception, even
before trying to find a matching socket. Do that by calling
ip6_update_pmtu() and ip6_redirect(), the helpers used when the quoted
packet did not originate from a socket.

This means that guesses (right or wrong) from an off-path attacker will
always result in an exception being created or updated in the cache that
the attacker can observe.

Pass the ifindex of the ingress device and the default uid, in a similar
fashion to icmpv6_err(). Unlike IPv4, an oif of 0 would not match any
nexthop in ip6_redirect_nh_match() and no exception would be created in
response to a Redirect Message.

Note that this does not allow attackers to create exceptions that they
could not create before, as both helpers can already be reached with
little to no validation. For example, by sending an ICMPv6 error that
quotes an ICMPv6 Echo Reply or one that quotes a UDP source port that
matches a wildcard socket.

Also note that in the good case (matched socket) the above scheme comes
at the cost of an extra route lookup, as the no socket helpers perform
their own lookup before the one performed by ip6_sk_update_pmtu() /
ip6_sk_redirect(). When the two resolve to different nexthops, it also
results in two exceptions being created for the same destination IP. One
in the exception cache of the nexthop resolved by the no socket helpers
and another in the exception cache of the nexthop used by the socket.

Fixes: 2b760fcf5cfb ("ipv6: hook up exception table to store dst cache")
Cc: stable@vger.kernel.org
Reported-by: Amit Klein <aksecurity@gmail.com>
Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/udp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index fd875908ac0c..93478d1ad576 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -690,6 +690,17 @@ static struct sock *__udp6_lib_err_encap(struct net *net,
 	return sk;
 }
 
+static void udpv6_err_update_exception(struct net *net, struct sk_buff *skb,
+				       u8 type, __be32 info)
+{
+	if (type == ICMPV6_PKT_TOOBIG)
+		ip6_update_pmtu(skb, net, info, skb->dev->ifindex, 0,
+				sock_net_uid(net, NULL));
+	else if (type == NDISC_REDIRECT)
+		ip6_redirect(skb, net, skb->dev->ifindex, 0,
+			     sock_net_uid(net, NULL));
+}
+
 static int udpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		     u8 type, u8 code, int offset, __be32 info)
 {
@@ -703,6 +714,8 @@ static int udpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	int harderr;
 	int err;
 
+	udpv6_err_update_exception(net, skb, type, info);
+
 	daddr = seg6_get_daddr(skb, opt) ? : &hdr->daddr;
 	saddr = &hdr->saddr;
 	sk = __udp6_lib_lookup(net, daddr, uh->dest, saddr, uh->source,
-- 
2.55.0

