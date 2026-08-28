Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46FF3D4133;
	Fri, 28 Aug 2026 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787945218; cv=fail; b=ktsxacWDFntT185Gu9QrYv70D86mvZMLQxZDalhJTSWiebxTsSyi+vadajwmhkAYZB0chhOXxbToPrJbvheh5t/qgomSCBUbWaPyDMHcLCIDGXGVp4rK/bre0wWNtjIb4uIFvKqq1EzVRFPk/GQXo0+rTgiF0npIkAoSA9KP+ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787945218; c=relaxed/simple;
	bh=R7DVfQahtNgLnQEU6GURrceI/kk0E8OJ0KeVrjbIyyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SKz2nTmcAl3urWNDYQXA1XoMyg4qk8yDaalyaw1NLGaVNSY+5qIjJZTXwWbxx4AA3kliiBB9cGbaSLLeqLYMjHze7jMJ9W78zT+QnrU3kX8JXS5e/8v1/rht1YB4Nuje4UTICsC0Vpf6ZtcRPXTnVlN5+yj+/KVXUUq4IaHlP1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i672JTxL; arc=fail smtp.client-ip=40.107.208.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i672JTxL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crLzHODbMUCBeKJGny1RVNFO/dXYhtDN1cO4TGRD1sVN/3d1ott2mplLDrgTuHHD/gON8lCPFQYqa2ASbZecPBpi3cI7MH+OvW+IEjQ0nzOUXQJH6765bQ7IJmRAeGPnP89wacIWfkkRhi3M4H2MlegyurGX3lH8qnBEE5JWqFBZMqj9W9sa3y0bnyl7IPRzEd+ILipQJQwCXxs6L8SDXXcglB6hdWQyns1pZ9p0VX8jH7I5R1BVNNCk05CCgsyq53iTWiC/Er8O68YCu6yt0rwZl43B7Z0Bw3294LIF7xTGTCkn3oJNy4LoPWVQi9635TQ/aVpYon7vP3KPe36Gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB9ZQZDQO11Gh3gdfgmufqW8zDmuowJJhS3yk9hF4XQ=;
 b=Ey0PWzf4O22tZ3bhDxy4UIi+/igPglfDod+cmETLFCV7Qk2UH3ZGwFbhYf+t7Z/h70DAxOVAMkK3j961PsmVeOc1ymQGAKoVquSpahA2fvQnbY2BoMWbNI+jRNS10+BKFUYf87APGklH0OGRSB5alwg80NDq8jNftDhgK1/3BkbGi1mABUSxC3ZxgGXnXgSdoelBDtKa0tDTOUiNffD75VthCoilI8K3FJdKKTYc4TzDNVCfDZuPM5G8bSWI007vhB8Y/sHpdcvlBm/xPTGeUiTuKfJSg6j/z4Pi1UbB6MhmPUXtRB7EEo3jk8kngKB0ArueGDEYR2ZNFlkKupLLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB9ZQZDQO11Gh3gdfgmufqW8zDmuowJJhS3yk9hF4XQ=;
 b=i672JTxLl0Z017G9XxXctxt+gvNK1vm3CravqIDyftzeBuRVleT9J0ypcxyImOTnVmp0T0W6+pobYPbbhb9LKlNMpBduIbRNZLIw9JPudefzDI+G0QWGJoGgJdvLjZjquHgotDSMi1Hu0H1xvu7OmiOFZkq691QP6kApVAWm2sAXxA8ak2qh+0AyofLiVZzD6U2RAJ6iS0Q/b3XJnzElxM9Nc+gLY9Q5DqyonT4RQLf1lDW3LOnUOEeHgp0VAMOmGpNd4E70Jc6ltLnSLd3h0SzmEoBArjl97e79fcRlgTXy1yv33Jx5sTad7Ulyt85USQUaSP28QIWVPN4VbdGQuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Fri, 28 Aug 2026 19:26:50 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 19:26:50 +0000
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
Subject: [PATCH net v2 1/4] ipv6: Fix redirect exception creation for UDP/RAW sockets
Date: Fri, 28 Aug 2026 22:23:41 +0300
Message-ID: <20260828192344.2596928-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828192344.2596928-1-idosch@nvidia.com>
References: <20260828192344.2596928-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: bf83c099-db6e-4ae1-aa6b-08df053a4f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0oGemD0whBcQcu9LgEnpSZnnPxLsZPyvLCMEgewxo69PfHuJPf3r2wnMDzOHuduax6wukWPwaEKvvfLAD9Rd8k93MQU6j1+xohfkeFYuyAXdCN3uZoaxPdISqs6DOW8W4YLXrbSBQInBI5wPpzqLA60eHH4jwoRprkkuUlLDb7xBKX42/lBa+fwZ6HxDMZmmjuz7uNx4sXjowE7piVaI/HQuc3ytKfZGYtPTjnCIGu9hT3voWJSlsT5EkIcvLcPxwPDoFAISC+05D4WRfe93TOIKIFJQKCrdRAFRUpNPAEck4QWTGQf42lXrcrCKEkyA2aNO1GKWjaQJGAs/pRqDHGTrGHElOGNq52+2W3HexKUBMl8sWr3tlEKFJcVs+qQ0ayjCdtuPH8Dj2MawfMGtdiWMvaz4qWB/J3Ei1C5XnMiLDY9s6ej0G4VzjTV55u3AoC9874uX6S7sVeftWzjGkhhGzztcwo5ZvbDqZ3iXeBEoxGonKKG3mn6igHFCPg04qejWwh8uB0cQ4KW3rFqGrdQN0SEzCpGw4I1n/uadm0ZI9jhoD7BeaJo5G2TMlASOF+gXfaiG9joPuqW0/4NvPjhEHBda8A2oj1FCGSDlNQyCob4000Ag8UQ8QDWe+yYUiQbrrfhGOwR0dxe1xw5xqeyMANyPDA3Pg6v4BNkuWv4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qsujCtORQ0Gj2TsjOE2Fjb+wpyX57koG3/KG8iJIDMs4WoF4mSvtVZgghX58?=
 =?us-ascii?Q?HmtnVHsjATyLF5cGqGU76t7JZIVwde6da5kV1bPv3vdsObg2wIejkxb8JOyc?=
 =?us-ascii?Q?5F05qQqeCLI6yH6ofondXYzmgfpvlpFAxhd51Q5dAo6Ds8aUmOlQuYEwxAeb?=
 =?us-ascii?Q?942idf00xufjoq2ctYNhBQDkBLCBfcbxEf0Xcvh1b5+8LkKXz0++9XqQKiQB?=
 =?us-ascii?Q?vOQ3vCrpqMVJGqRj0fNWqf8Qyp8EmDzr/ArQHNOa6x9ARIXlXxuyLyhArHow?=
 =?us-ascii?Q?6Hjuc0geU3icjgiz1aZjtLLgYgA0SbH5EgMHQI77BJkSiv+jkcB4UapFd71G?=
 =?us-ascii?Q?BfF0t17og8M7aOFmLDKvKQ0WvBIzMcqlTShe+rXAio8Z5ImUA81bLDOhmqEX?=
 =?us-ascii?Q?jYtw7+u8F5a3qBmz7p2u9VKT/Kbjc4xuTFdCXdJQhSFOH9lLTO7ZkyHc0VAz?=
 =?us-ascii?Q?/P4GR8ASJpb73amhYu50LBX+8lOk3ZXATV0EF4DxVAJoJdh9+i+jJKm+MMof?=
 =?us-ascii?Q?16eMOspkiXh6Y2S4IqpWSjVmWRiRJ4WzFXFFINxauV5OtezLi0a29x5KyMLc?=
 =?us-ascii?Q?FSSvBAslAkTdpazXcdPACuD4ine5YjKvBUMC6mprrEqmin2kAKV9iGerDGf0?=
 =?us-ascii?Q?AVUXrNKDfY9llekpOvSlPTuy1ahVnYrErVO7R5bxLq7f7w0NLJEiBWBANQyP?=
 =?us-ascii?Q?5t9beNbNr+Wc5MtJFmpb/5Phxw9dBIDK+oXfeJ0uXJkWJNt4VssQKnKK8gUY?=
 =?us-ascii?Q?/XrQ3WzGGzZqZ2IUi465E6/LdPebZTM9CSv11C/pM5PUyq53RYObXmY/4+L6?=
 =?us-ascii?Q?Xuysy195zFyEQeRe7vMdquXRY2dIwbmM+nx/0knAi6IurcH2CPsNE2Ffe6UE?=
 =?us-ascii?Q?xtb6nuIfWqa+K1HXNpQqOFtE3a3+8LdIx2TkxqdLvv0xBqdtAvoRe8jDKDXF?=
 =?us-ascii?Q?c9q0NcwCpB3XTq8DpZLT/u0X9CUbyFdb3/mO9sZvq8cal4VxhqJxtaNXEex+?=
 =?us-ascii?Q?/kYBxKTtZuYf8fFoGZw6LCGGZEcsyhTjjW3w7TRtk3/JHSU2A3qo7OMj2YSW?=
 =?us-ascii?Q?uLu8nvk/hb5HYr0D/kNtx+B+Mb+zyQZEuBNHHXxRoG71ma9ew+Y6Dps3htQ5?=
 =?us-ascii?Q?Fj2B/xfwxfhMd9d6N/uwxueI8LoFBoPidKkdeRzWmuy1rkIvvoAI1iPTBlQ6?=
 =?us-ascii?Q?WiqT1+U+nTHriqUyGW1r6csCcWOdeLM6oiaqUGUddlCo306JtvIH8di2U/Dh?=
 =?us-ascii?Q?fPD25tq0yLYKznEOCAweQEchbSIl+VoY8muFcVhIIWcMVJBr4ooxGG2NA8+t?=
 =?us-ascii?Q?GoBx6q2QQETBjBCmf3B6yLNW//l5H4E9/Ixb+SHsjAqjM5AAV52NQNXLCagz?=
 =?us-ascii?Q?rGaOuLF2K4wCm5Y2FAS/dA4vsbFJUa2HuRjYiTMg3ldrj0GhgbdwnwjwxBlM?=
 =?us-ascii?Q?rL/qk1BQoi5CfUltrHAs66/qyVc6PwzFNSVMrILFEw2eWRc39JjNbGUHz9mC?=
 =?us-ascii?Q?rWQF8M6SWRqSdcA4UgDxh1uCM7zaSlRVzkJMCEaWgdUDAeIEnj8skU87euLT?=
 =?us-ascii?Q?FzOGxh92Ba5AdWxsqIw8Pn42AtJ9OxYwG911e7CgkggVdOfBlbmXllVQBrYu?=
 =?us-ascii?Q?fWT6LGa+RCECE3kcH8zkGO8T7ha3+OwoAqKST6Ust4AdqPxG3gKYOlwlgVOv?=
 =?us-ascii?Q?e3hTgDnD6r/OjGW4XE9IqnlXIGORQUm0FgF6Wt4KIPrQEEYDyQeLFWEx9s43?=
 =?us-ascii?Q?+/j5hI2pUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf83c099-db6e-4ae1-aa6b-08df053a4f0e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 19:26:50.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlUyo6fK/vS6tElPaEgbrPHop0oFycJETbxC/nfhjlsrO9SBu6/4ximqgvN7vV+WxDToiL4JKRz0UgJ+WUHQMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

When an ICMP Redirect Message is matched to a socket, both IPv4 and IPv6
verify that the source IP of the ICMP packet is the current gateway for
the quoted packet. Both also pass the socket's bound device as the
expected nexthop device.

The difference is that IPv4 treats "oif=0" as "any", whereas IPv6 always
requires an exact match (see ip6_redirect_nh_match()), since the gateway
address is usually a link-local address.

Therefore, when an IPv6 UDP/RAW socket is not bound to a device, the
above verification fails and an exception is not created. This also
happens when the socket is bound to a VRF, as l3mdev_update_flow()
resets the oif to 0.

Fix this by passing the ifindex of the ingress device as the expected
nexthop device. This is consistent with the existing callers of
ip6_redirect(). Note that for ICMPv6 Redirect Message packets the VRF
driver does not reset skb->dev to the VRF device, so skb->dev is
correct, even when it is a VRF port.

Fixes: b55b76b22144 ("ipv6:introduce function to find route for redirect")
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6a40c5074543..9658939511e0 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3255,7 +3255,7 @@ void ip6_redirect_no_header(struct sk_buff *skb, struct net *net, int oif)
 
 void ip6_sk_redirect(struct sk_buff *skb, struct sock *sk)
 {
-	ip6_redirect(skb, sock_net(sk), sk->sk_bound_dev_if,
+	ip6_redirect(skb, sock_net(sk), skb->dev->ifindex,
 		     READ_ONCE(sk->sk_mark), sk_uid(sk));
 }
 
-- 
2.55.0

