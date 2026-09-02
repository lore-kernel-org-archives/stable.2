Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF874AA59F;
	Wed,  2 Sep 2026 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375743; cv=fail; b=PIy3MSwIjUpy4ELPsjSfONHtosvk8T87w/no7xa1DfWU3wh7MMrf5JNmfCDdeIvRP8GlpW0fl0ncvBQzApYiJWSsW+0bFvVpVBW2tz4hh5B8JUdqXUs+FTQFVgzTfTij9JotDsknmdBZhWLr8GsCntPP+ynfm9IorYyX8G2tqNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375743; c=relaxed/simple;
	bh=+AL5sCNxp5l15c1LM3jiJL3XioMk+BA1hVsleImU3JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lU4e6XSPfT/gc41gxdudv9FvVvTuXSSl5VHJ4Xj3YadXp9f5xjz9cKIEf84qRrArTxKtnNpt/kyIGsAfsdLVzPY66wpseCNJ8lvFxv9BZM4JOh7lK6Z1iB5JwQDlewwufvXIIyPu7MOXiAM5emEZA8p2VB0MHM5ceKORxDEdz0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jfKS7gQG; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jfKS7gQG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAe25QlQPCzNxbacBgQSoLYSNX+hb0+Ig4YQcHf9gLymyh328fimUd1E0YeYRmJSsCwA6iIDlL8/NeOvIlkEhOoCc7pmreaqlqhK+mtFIFoV1zPFI1KgSFXkF060uY45c34I7Vxot0EXc7w+gE7VI1o80SMdSlwIUk4H//NZsy+h28g4SFKvEHabHoxqImpgNEcEH2YuzuIpbBsH5KBwrSzS0tLW4ZPwdfk9S6FSilFUawBEvDHhyW4QwKaoUOxrdfmnXB7B8RWeJJVrk0indGH+bkBgdjGFusv0Q7I9tbotiXxLKvz6199gxgkwEqudaVz3xvhyrPiTTNxnM4cY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDr//jq3cv/nBbOSB2t1nPlTTL98oZETxCQxH55bZMo=;
 b=S8GEWv9YNhU0wGN6pjHOFfyWvq210Ln2XME10NORyO0VFVE8TOOY3o5Yjyqw3mX3G65AOWr2xfd1mp8wNoPUjX8SAmjB8xs0th9MayGGLVl2+32bhsXSaZ28KsucZYMhzIKrJVMYKv7f4TYxjlN7MVHGs2BvPj4fkZrpBdk3Vm/Ku+wTP1jKTVMGu4QofpoAC3S4836pGUl3ZwC/c9ZhRMGvDwKCdOl1xNpdqdexn3rOf0HTlL1IVai5bIAJu+OPdTICS03IuXGXV2cVRQ6Mq+A77ZthY+rZTt5xBv1PCeaoHvuHWde6GdQaUjk0N117MY4JNzh4FcIOZ4VQFSM82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDr//jq3cv/nBbOSB2t1nPlTTL98oZETxCQxH55bZMo=;
 b=jfKS7gQGsI0X/cQYKqYSBfKOwcdyvvLE/bQdVyxo5lKjeI8FdqZ0jDvRTTBXwQ4Hg81ZNZQnw1RHibF94WODsDCiH/F1U5UiE6pzsFGAEQ+qW6Ste9Fx31469jP5Cievk4fvIf4rdq4Rzj9eU51LJNTwfGNdu34NIz+et1U9crUJ7UA34xjxMYQXtM67pKjKqRTrkUFczACKfbKwQf/X4CdCnlT1At+Q6kdX6GXXXbF3kMeMNJWL3S1zt+I5ouqCzFCpFbUrvjfgDiEftUsU08uvMf0PZbXaQx285BhNGb+O1MPT10DdSqUyuMHWQVfNU+bGxGVISJPC62O1lvhfXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 19:02:07 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 19:02:07 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	aconole@redhat.com,
	sbrivio@redhat.com,
	gnault@redhat.com,
	laikabcprice@gmail.com,
	aroslavdudkov622@gmail.com,
	rough.rock3059@datachamp.fr,
	Ido Schimmel <idosch@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tunnels: Drop stale dst when building an ICMP error for PMTUD
Date: Wed,  2 Sep 2026 22:01:12 +0300
Message-ID: <20260902190112.4126199-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5a4d2c-208e-44b5-5557-08df0924af02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|3023799007|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZznoHN3Lz/6IVNwp0cnz+ylrq74uAYWaoHr6ISKBjfhb+mvEV/0TTa3uJxzMEv5SKO3/ShtJVG04ZiQ2fuyjB2Jf622LIvSSR/LcCxyYIrURTjgNL4qJMo5ja282VJL6rWsHIMA7W+8VfMLt4jLuDKGL0m5D4NKo3FLZb304RjQG9t2RFF76jn14rBQ4t+p3AQQh1JbxY2Us4pkzz5kTsxQeDwoh8VZSBAWpIGFgEXRLwZ4XKOeTU83U95snQJCIQMLIVxcl+gfrP6cbYXsYShXJ68zmtBAoa2v9dorn2Id80wNrexgH7a30bKLWK3HQVsHiZu/UHCi8p17PQnI2UiS5mmeMGoJ2HD98Ih6siNjzsCgOOr9pobCLl6L/xmhu/Nj6EfURHWmQeTjMmE13L/NLZ7m8XxTSiFkYeFIoxNHczf7B0esWVNT7MKTOMOmZeq6al6E/Bjjfk1lC7jS1MZzRBnGyES8SgRFc61bm99qr66NHqT55EjW9yx9+k7U3+jAMGzlDIK1MigG6BaLleyl6Emt7RzMqSgcmMVF+Cqz4HNcUs972rIMPluADONA16EFBAZAccXdOMGXWBRStiw92m1C7u9XXPdhl8B9mrkgOm27fihfQBt9Sn+sjf9KET6Zn8iKfEO4N5Pz++P/t+UZGUigALaR85s+GTk29xoE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(3023799007)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UBESoi/fssR0qdtNQaY6kiAsriIkP8bh2Z0oIOOjBi2M4ULSkDguUSHFPX2o?=
 =?us-ascii?Q?eZREpv/NOZt32ja8FeyYvz1A44hnVHdyVnp1Q2/cn1/oezh37qwiQHilsHf1?=
 =?us-ascii?Q?Orf1SLCXuKIzV06GEGLY/GjzpiuVa6L1BjVRpGM6+5uqaEFNogs5neJtcNDw?=
 =?us-ascii?Q?lJZEG+gjoJ/2XannGFbA7Jraq07H3ao6y8jX0mIrQLLdzLbp0EGEhf6tYpRm?=
 =?us-ascii?Q?iPL1n0++sxOMpftwIzNzVWlDOXGHE63DQL+XR45JA9NFeF8Luv0PLcLQIGXT?=
 =?us-ascii?Q?lBWET8fJzbXxgpvNsIlzeSnt+GlQXuGqW+JjJIM21dtFz4EUdMnIajBFY0Q8?=
 =?us-ascii?Q?/1bGBK3L+M7nupynmOEQ98RnlxSicfH6fyKZb2X5yLhP3HsE2KDmxGCk0HpM?=
 =?us-ascii?Q?TwxZlbJNrW5B4BwHn84cgBn/YWhLWEpE2ncZSnPrLI/dJSPFHlfOyoyGO1J+?=
 =?us-ascii?Q?Zfz3vomhHOcpkc9j3SUfePgvr8Y+OwTymKFW0vUhBgspBK/+kB08MeFFOuGw?=
 =?us-ascii?Q?AY0IuqLcazl2T/5xwzCoevasArN54d0BVrQ6FMyOxUy7giAKUmZA3YjP31O0?=
 =?us-ascii?Q?mopMS5Q05seCBGnRhVTZH8k7A7Jy9jiNI2YYd+rFYLCYq1tboa5UnPOyl4Yo?=
 =?us-ascii?Q?axkFFpTvHaSLQmYqk0/+Afs/3xG6spBG/FHApTJBJtmnkULmqBcoxuKyafoD?=
 =?us-ascii?Q?m2SQSauhXFCYZ3Utuu1omBdhEszaBMkhGmG/0ujUvYPZ0uMTuRXLvBep6/Vn?=
 =?us-ascii?Q?P4XEgqphvxrAzVx2mVZCI9mgQWKAfsxcZG3y9fNPeusF54dbdbGIWACOwBGK?=
 =?us-ascii?Q?BaYgmvLieZpzplgwk4e5WuNUsTcOevjxUaB01uiOax1LJNrE0HY2CblZvSrt?=
 =?us-ascii?Q?2b8C5/QelbvwmlkfmKx/CisXnuRCBoXnXCAhtuozVPo2kC0/Fs+ttIDNaqee?=
 =?us-ascii?Q?AYPG+HN0h7++8nMEZhqb+5hfGPqDRwGJg12o73L88AOw5oOYg2QzLLi9gpUD?=
 =?us-ascii?Q?b05GRf+V/faC4osZ41BHToWRC6e/a55gotcJ3RqI64UIJOr14fYZggWXu+Fn?=
 =?us-ascii?Q?nGhcyxsS0pXLeS3PYmxhmdT8yuCWj6BalkjwKpGQh3cDWwlmUM/hSxGzT9A1?=
 =?us-ascii?Q?YHDSts0IgmQi9aGl3xhqL4Gs+sLJ21AgogOlwgTaLvkcnsx5vubuM3PtTRr/?=
 =?us-ascii?Q?1+e5xoHQMIEzIENzuPIDIx5O26RKj76ID5rRebcwZCBY5lJzdNuB0RAIh0H5?=
 =?us-ascii?Q?WSoM1qBVwE9rcXfPbvpA/eWjTsTLKBQPVjd4EnuxRExXfFf7arwSGrX39Hqj?=
 =?us-ascii?Q?Wi+T0XBlvq80kImUwUEUCGRkAsPVBPepsEB2ZW1rAsth/sYv4xGWKmZLeRQ3?=
 =?us-ascii?Q?qj8QWZ1k6TXFcWCc0zteVJymIyscT1ysSemWkqL1Mbsmppq8r/6zN9TSBLVB?=
 =?us-ascii?Q?VSNw8AjxM5Y2q5DRXVUiSS1ASAfHGwOZZnPqCP6sliDiDGnUNqfhruDPMAh8?=
 =?us-ascii?Q?HhQcDkHugmo2YyJ/aixGCRkXFI9n0i9f/pENIbsYXebVGsAO7p4effgaAAYL?=
 =?us-ascii?Q?+fjh41oh/DafMmM1GHyo/uSsF6iIfInCWsX59SCYaHqnBELOXqNPWIWtzdkR?=
 =?us-ascii?Q?r/DGQPrU0hh2I1jyvxxHqBqWfq8eGRazwdw2tk5dLlc9VJsOC8NBaIVv0+Mw?=
 =?us-ascii?Q?ZNHi634xzaAU16bxaMN1PCB2M6fB+HPlKgOfL3+PYVmFDR02KF1RXAocid3s?=
 =?us-ascii?Q?BXw1Gy+UmQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5a4d2c-208e-44b5-5557-08df0924af02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 19:02:07.1291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfJpG/1zkDqTVCeFxFbEPaD5C4PnziR1jnnUtiTKhyrhBIs5hWQ3A0WsSNQk6yIHqg7IPW6OaljyB9Pmgc5s3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825

Bridged UDP tunnels such as VXLAN and GENEVE build an ICMP error packet
around an overlay packet if the packet is going to exceed the underlay
path MTU. The ICMP error packet is then injected back into the Rx path
with the source and destination addresses swapped, so that it will be
delivered to the overlay source.

If the overlay packet was routed to the UDP tunnel or locally generated,
then it is already carrying a valid dst entry and this entry is not
dropped when transforming the packet to an ICMP error packet. This
causes the IP layer to reuse the dst entry, leading to the ICMP error
packet being dropped or routed out of the UDP tunnel interface in case
of forwarding.

Prior to the blamed commit this could not happen, as
skb_tunnel_check_pmtu() did not build ICMP errors for PACKET_HOST
packets. Such packets were instead encapsulated and, unless the DF bit
was set in the outer header, fragmented by the underlay.

Fix this by making sure that the ICMP error packet does not have a valid
dst entry, thereby forcing the IP layer to perform a route lookup.

Adjust the bridged PMTU exception selftests accordingly. When the
local sender in ns_a pings the overlay destination with a deadline
(-w), ping exits on the first socket error before any reply is
received and returns a non-zero exit code. The test therefore only
passed because the ICMP error was never delivered. Use a packet count
(-c) like the ns_c line above it, so that the ICMP error counts
against the packet budget and the exit code depends on whether echo
replies were received. This passes with and without the fix.

Fixes: 8930424777e4 ("tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().")
Cc: stable@vger.kernel.org
Reported-by: Laika Price <laikabcprice@gmail.com>
Closes: https://lore.kernel.org/netdev/20260614-master-v3-1-9f5060ba1ed1@gmail.com/
Reported-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
Closes: https://lore.kernel.org/netdev/20260901081825.287173-1-aroslavdudkov622@gmail.com/
Reported-by: Charles Bordet <rough.rock3059@datachamp.fr>
Closes: https://lore.kernel.org/netdev/aHVhQLPJIhq-SYPM@eldamar.lan/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ip_tunnel_core.c           | 6 ++++++
 tools/testing/selftests/net/pmtu.sh | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index d3c677e9bff2..5168d546ea2f 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -268,6 +268,9 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	eth_header(skb, skb->dev, ntohs(eh.h_proto), eh.h_source, eh.h_dest, 0);
 	skb_reset_mac_header(skb);
 
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
 	return skb->len;
 }
 
@@ -371,6 +374,9 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	eth_header(skb, skb->dev, ntohs(eh.h_proto), eh.h_source, eh.h_dest, 0);
 	skb_reset_mac_header(skb);
 
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
 	return skb->len;
 }
 
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index a3323c21f001..c7cd271714ef 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1457,7 +1457,7 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
 	mtu "${ns_b}" ${type}_b $((${ll_mtu} + 1000))
 
 	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -c 10 -s $((${ll_mtu} + 500)) ${dst} || return 1
-	run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -w 1  -s $((${ll_mtu} + 500)) ${dst} || return 1
+	run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -c 10 -s $((${ll_mtu} + 500)) ${dst} || return 1
 
 	# Check that exceptions were created
 	pmtu="$(route_get_dst_pmtu_from_exception "${ns_c}" ${dst})"
-- 
2.55.0

