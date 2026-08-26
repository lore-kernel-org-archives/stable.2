Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C8446BF6;
	Wed, 26 Aug 2026 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755176; cv=fail; b=biO7WzP2ju1Q5nUQ0aqUDsaclDtkoQmyJIqp3uaVLdTSF/RrVpGtgcM2tuAAAbtFixx5Ogifvpm5XH/tdn9MNaG2fqmEIEXMVTcPJqgCqkZ/eyjlJO22ghS8IYi59NhOhXOOpn4gvjazNjL/YxrDVgMQLow09qdQHx1AXdSHo2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755176; c=relaxed/simple;
	bh=68OCw96CyGZNmpvdTUOeTxwKxyN38CHOguzVtfwt1Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtFLWw91/GIUnbqNN9g92AsOTKIEplbNBV8d8DXTDG7fU6WZVd0vxMR3h+fhalooqWoPeKIJB0W2iY76t9WtqnQ3klZ5snTsfnXoi1Z6duX2qOIPJSN+XVVsz6jT3mPtv1XgvYDCL4LvmamH5ISrSHfD6yBRXihblKsOOiqwOB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o8FDOcyf; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o8FDOcyf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYRYnPsC6Cb0dZlhyfwp4pautOZNWlzH80pQRbF1u6WqNFNRA8AMtjeYX0oICDNvEzS1owgFybkXUv5OzkwC5j635yKZgctyAjj62I7bqCQrdzx8pzyKZIswk8bvCp/aM7OLIdeJMW+w89e+EoDK6PSWSyH5ZfT78ah+jD6bDWcoetWYiFGPOAT8yu/uc/kQFO+/GwMBUzTyocgoAd4jNxrWyy+KUileVB6vHCWwaILrLcD567W64ETQR3v4RxoTg4OfBcFPyeThZo5uiyARcLEBifDzoN91k0DTDwMAsnwDitxSNT2aI5eg1x0AXwfJrVHPss1stuZ/wDXjECc6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUKROl08nTEcwSy403PCKBYzmCqvpYTPxiewsrf2s7Y=;
 b=nNbpnKd8yKbnxgI9gTY5c+j9tiyl3rWe9FJa2rHAMBOVL6lVwP5OZEKpSrx569oA4L/i3pU0w0pebUgeNO/pBsbPD1/AZMgtg2g1NQyWSdTfk+bj0zWXNFPaFYXfDYD5oXS8aDntx/SvCDiMssdB0tIfIgpyGyeqqZ+HaXn+Hx04vl5gall0VjWE3BVaiXOU9eujvOpBGS552vb/Ld4KwAuenN3eTbijq6uvySgOMnHL0ZEwN40/aABMh+5WqFvA2O2+d55ehnKedpGZcAFQF6FdXDJxd7bS+7Hf5jt8NJ4DOOBaqrUojdSXmXGTW/N0HWVBT+vOdyjvLBfJGlXp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUKROl08nTEcwSy403PCKBYzmCqvpYTPxiewsrf2s7Y=;
 b=o8FDOcyfKF26X21+Ds7b4nbkM6IJNKQpSgE0EvWXe49UNgVFTY+vaYVTY/jSds1GnInMlkICSHQyQ7/CBC326zQzNIGO+06t7+b7XV0FwS5b6AOW0aACkx4U5zHeVgV8lB+xlRmr0+ilwGHP3Db3ZXwAUbEEsUt8uzShNzG8b84fvhw/BsjQtUzp7oOoY+Qse8L12HbtRuJ5DxiUVgQJPGt/KUeUZ9Mhg+mBCnQ1zkT5tkYFxe9w1XYhyaN5aU8GWN3EnPMKTbjcXIuP6ucKFyREIw/YTDe965SfTv2NNGcB2BGuiAYft4ihhPB77wca0l2n3JG6VO7XTzzl/tZTyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 26 Aug
 2026 14:39:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 14:39:24 +0000
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
Subject: [PATCH net 3/4] ipv6: udp: Create exceptions when socket matching failed
Date: Wed, 26 Aug 2026 17:37:34 +0300
Message-ID: <20260826143735.1819315-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826143735.1819315-1-idosch@nvidia.com>
References: <20260826143735.1819315-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc2b8db-c882-4cc0-f6ad-08df037fd2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	rKGCzZhz3gG41+D6utNifmmxkquwZHqMj3CRgZ0wMogC0tfBYWHCN4YhnEkJCgDBV+SW+F6Zyk+HRMcKh2sTcqZYu2gUmVD61/r/ENGkaUZFx0cdEDZJA/kuJ+3yFe641c++X7HkUMhJ/0coTUbhyaoSPromCa19Neo8YxDiT5xEUAq3fbNf9mu5zmXGvBTogYcrrPaK8abT5idqLw+NjJ0lh0rxbtOh+l/9pNk8uRoMLsxye8Cehgsgou7zSWFS42cV984fC2MFFBMb8uhqQmBe7elvwtFFFjVTTYbYceCj4O44eswHoCEl7D4lPMRR37RF0awMFfObkKgigOTf6dGittbhhzXesNemF46sjctkX2KT8dsUPS0oCbpzl4aScq9AGJcLtOzEafAKnZ8HlqdAzayAkGGwXLl2xQAoAxAYlIyIcj5dnh2MEh2Tp8X/G10/YPsA3hk5QUZ6rUycn1jTWCRa1tE9UJF07BpnP2qIAZPsX09K44qXjLP4QCnTMf0uofStSnHlmlViv2CiWW3NHclPdyUEX9CV1Yam8JM2T3v2VCEqZCpmNcybHTtWzk7bJ5EcKnS2rDqm/BBHridqXZVDRhtNAhPQofzWVLTarCRUVFXufpDTynIe97k3fyYz22WrTHzyr37d3yKmlzq5QMn/MTLTwYwSS+4jkg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nzcjUSMlDlh0rGKwFPBYilXI22nnzomNn2boDK10AA2qnVAAStO9A+mQg6oe?=
 =?us-ascii?Q?jzt8++6250Q6hhRvha43z6CLnplL0C+blsqxd8djIm2jCHecowVt2R8XgS4l?=
 =?us-ascii?Q?0qIfhYNTsC5eKN9EhUCe0ZgcJq2H1IUZOzGauZZDDxHBHjPVdkccpIC/buGw?=
 =?us-ascii?Q?2RW45pSPkZ9LwJYZKQXpm07ZOY6Z+KC0k4otqvfnXPPFcAS8lwCZPR5UJWdU?=
 =?us-ascii?Q?P1EUrYzmhPwgZ5iAJcbRNqjTLX1TSUIBtsL0Xu8W6tDRgntxQw4O8x0uLqm8?=
 =?us-ascii?Q?enS38vbdixGrOqTH1vVj2rVuvfAznrz9JPw2u3qej2cypZrVaOVjlSZCEqWp?=
 =?us-ascii?Q?hxqV+X+KxfUIH4/QgIlBrXJoXaeRNlUX7yHnMEhX8rhFfB2hXjSWG9AngWwx?=
 =?us-ascii?Q?jleSNhsGpFsj22NyAEBKgLYNDlRrxTouCZKLbjKdelxV3V2c+gJlucOr7hI4?=
 =?us-ascii?Q?cYqsOWiBKC2fnUzqLXW00pKWu9tvMBpNWOJmmh629xZlDj6GKddiY1Z3YVQt?=
 =?us-ascii?Q?45yf3X3FoXGxMC95urN1afnewYKh722fGiyAUGGWsj7dMahYauX1DB1kksqn?=
 =?us-ascii?Q?jvyR2u6YcCnWCXYjBDA/bwOz5akJzGpCIGN3jhvDojlorQ4hN8cn1k/9X/rB?=
 =?us-ascii?Q?Q1jM760NW65UhSiAOB3fO88sUPV2El320SFPttCE5VW8bVHjUZKySuRU58RB?=
 =?us-ascii?Q?wVo9hNuyi8NkmFx8+Sxgqq3jTTnRtP4+JopAlNwl2D+Xx3vme/HSly2HYTL5?=
 =?us-ascii?Q?X1xkb+hpnYeGN9SaX6G65a3NJnnf+7wQ/EfeM4RGaaOK70P46DgAHfT4x7w8?=
 =?us-ascii?Q?XGbH9rPWMO9w7KInp+PxpvEB6wialjN9r5SD4A3YcQvstZlicRc7avPoKPcT?=
 =?us-ascii?Q?0JShaI6J7tuvM9pI0BR8jKAuiwUZM9407CC+8kKVRFwGbZvtN6o7PlXE3HEX?=
 =?us-ascii?Q?F4k4C7d9SKcL3DBTCbOKV0HAmIlSIDspxdr6BroD7UDmWD0x4O0BFq0U7U2P?=
 =?us-ascii?Q?91R/o6wtgf2CQPL++HL05twEnNG71JByalzgiU74VxBbets31Cn2M2XsSo2S?=
 =?us-ascii?Q?5haACnErcgHS3mzj91amTW+z+hYhzx7CJh3sHP2TvaOPNSrLL5U8scG3ijQq?=
 =?us-ascii?Q?rHasCoV07RKswk4Oa/C6jPv8FzFIe3kOOK4MkO4GwG1jxz+TO/ixV80J+QEh?=
 =?us-ascii?Q?MOReFWzLf5dmr18J5jmMGY1I7LZYPfYqimhyNL4YvJYx6nBPJK56Jj05L/wn?=
 =?us-ascii?Q?uqh38unU4jt8xq5YsyViQ/xWL9BeZH1oIbMHuwIsZEYtM1Z+rW/jjxJzfRQC?=
 =?us-ascii?Q?WC/vRkfh1mS1g091wh1CAOo5daYOOAQueIr+6qxpLy51CcTHoRHYXM7sHNU8?=
 =?us-ascii?Q?p5xa/NZg09fYCU/1x57i6YWWK5U7rTvKAOXK+CF75IeLgyWa6RUduSh3bGYO?=
 =?us-ascii?Q?n6ObLpp8M/F60bS0mkHLIuHiawpJMp1YcToRWNUPZrRyVRu3zvGcbGTEDqXO?=
 =?us-ascii?Q?3P/nwKTzkEx/QKb8z4G2vzqhIfarrxEBUSG7UCeHa1hDBSjsj4qf21VvI/2k?=
 =?us-ascii?Q?lUBvVCbeBUh2DNl5MNveg9gQVJaGPBlCA901Hh42ZBzsVh8XN7a6L+6iU/sf?=
 =?us-ascii?Q?oISAIUojOaDuucfNpVyBv77skD9g/3NV4WdzV9qvwSd9oy6S+Ra9elKOfuDH?=
 =?us-ascii?Q?8ie8UnNRH75LDQtFIgsynlGUbb2TLvMvVQQEcgyIF5vk7th4067W86eF9ExJ?=
 =?us-ascii?Q?glyJT4q6cA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc2b8db-c882-4cc0-f6ad-08df037fd2f2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 14:39:24.7408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWH4ZNFMjxVsD7jFmqZuuCGTPtl/FSWyOdNEkKRMRQpI2eKGo1r8GE8w3xOvId6lKTaaN8DmHE3cj/39gEm8Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

Currently, when ICMPv6 Packet Too Big and Redirect Message packets are
locally delivered and quote a UDP packet, an exception is created in the
IPv6 exception cache only if the kernel can match the UDP packet to an
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

Instead, mitigate such attacks by always creating an exception, even if
socket matching failed. Do that by calling ip6_update_pmtu() and
ip6_redirect(), the helpers used when the quoted packet did not
originate from a socket. The resulting exception is indistinguishable
from the one created when socket matching succeeded, both in terms of
cache occupancy and in terms of its contents.

Pass the ifindex of the ingress device and the default uid, in a similar
fashion to icmpv6_err(). Unlike IPv4, an oif of 0 would not match any
nexthop in ip6_redirect_nh_match() and no exception would be created in
response to a Redirect Message.

Note that this does not allow attackers to create exceptions that they
could not create before, as both helpers can already be reached with
little to no validation. For example, by sending an ICMPv6 error that
quotes an ICMPv6 Echo Reply or one that quotes a UDP source port that
matches a wildcard socket.

Also create an exception when a socket does not wish to accept PMTU
updates (e.g., by setting 'IPV6_PMTUDISC_OMIT'). Otherwise, the fact
that an exception was not created can indicate to an off-path attacker
that a socket exists. Unlike IPv4, the check is performed in udpv6_err()
and not in ip6_sk_update_pmtu(), as its only other caller, rawv6_err(),
does not consult ip6_sk_accept_pmtu() and therefore already creates an
exception unconditionally.

Fixes: 2b760fcf5cfb ("ipv6: hook up exception table to store dst cache")
Cc: stable@vger.kernel.org
Reported-by: Amit Klein <aksecurity@gmail.com>
Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/udp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index fd875908ac0c..df14fc2afe8a 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -690,6 +690,17 @@ static struct sock *__udp6_lib_err_encap(struct net *net,
 	return sk;
 }
 
+static void udpv6_err_no_sk(struct net *net, struct sk_buff *skb, u8 type,
+			    __be32 info)
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
@@ -719,6 +730,7 @@ static int udpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 			sk = ERR_PTR(-ENOENT);
 
 		if (IS_ERR(sk)) {
+			udpv6_err_no_sk(net, skb, type, info);
 			__ICMP6_INC_STATS(net, __in6_dev_get(skb->dev),
 					  ICMP6_MIB_INERRORS);
 			return PTR_ERR(sk);
@@ -731,8 +743,11 @@ static int udpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	np = inet6_sk(sk);
 
 	if (type == ICMPV6_PKT_TOOBIG) {
-		if (!ip6_sk_accept_pmtu(sk))
+		if (!ip6_sk_accept_pmtu(sk)) {
+			ip6_update_pmtu(skb, net, info, skb->dev->ifindex, 0,
+					sock_net_uid(net, NULL));
 			goto out;
+		}
 		ip6_sk_update_pmtu(skb, sk, info);
 		if (READ_ONCE(np->pmtudisc) != IPV6_PMTUDISC_DONT)
 			harderr = 1;
-- 
2.55.0

