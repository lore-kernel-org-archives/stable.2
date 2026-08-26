Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D394446062;
	Wed, 26 Aug 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755153; cv=fail; b=BFB0GYYo7FvncAENn0UM6ZGE10pfAcfNACNh7sdlvhtGpf89xLZsLDoxDWpkCUqUg1mMHHqcpO+lUrS5AWghlIfLgjWxIgo7e/BYbsHUADy/49XrzSwInTy1dz/WYu+0AsTgsi/q8oVnzJFP1/0jqtTmcCzNt3+m7F1m9PeI6Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755153; c=relaxed/simple;
	bh=aZ2W0VUyGrUuR/bCLqOXxonhbk+F4FQfDG1lBXl0wE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ti21cvvmFBaEWeSyTWzcrx2rhET+3qFtFH3DAxuycXYl7SgaH154FXtc7w0JrBgxBndsFVtLaT0DQAkjnQZwrg41C2SmsmLUgsK8nUkMZufscuiSWCCkWkwnF5OagljNLuBQ3JkcR5TidomoEQTlDX/0RdTZG7yfezx8brBoG2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WoPooMyJ; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WoPooMyJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UudBf9GLShEZIHvK6ehtd7Df/76SkEruhDDh02G6nwkYrxUCdCKpVvxmnQ/TVu6oO3/dJWXtTYwWrKWtxapWvIGeHMurWa4pAXarpcZU8Co82O9uOalRcfRZeLydaxgEMwelfm0HNERlv6jYgmp5ytukSGppg5mFcjhyPaPCvbL9rV8jiSFGwXngfccBwu6asED6Lk8dMOSGTl6R6TdRG3KE9P8U5n/SJVzewLIBNBp97ww8lC3zH1J6JuhEKiUbhbm9VE1X9rapimS0Nb4V/GbaxXaAa0ky+KITG/DAnvfoxH+91tpcRdxYJunQPdoz8fbyp8V/hze0NuSqNa94VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmLT0KQLz+PMRPQhRT6qbaWbsmgwKTTlZvTJvCGOByY=;
 b=bTkYUTzfeQPTcCf/ZbvG1TbAzfnMYVkd3ife9eSGFa5dreEcHoT1cSzrsbsXsq6RsGn5qi6tmBIBkKe+NrU9QW2crarJ6Kq0LygZ2EO9oG3uTNzCQlxo8t89g9hA/iMH5EfKrREySGm6TI7c65aWvM/WOZekibozid0/+h29o91kBriKDBE6v+cYykIv2/EGF+OF68pWMw2Ou8AO8oF6zjQ9PoCpQ/zB3iPA2aA04c/K9KdY6+eop5M9S90gnNZL3BPFc57WW2Mov504EaFFouGuEFmzwO/9a6nZqjKW/dIjOqFbOv5tC/IvL2jvLgr9S3VFzC3nZt7+/9+ejyzBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmLT0KQLz+PMRPQhRT6qbaWbsmgwKTTlZvTJvCGOByY=;
 b=WoPooMyJWb5GtcUpSqevjoQ9YRNQaGh/CQ096YwFbAbFut2fhDHdRwmVmBalbGf4PtdCAzMWin1jbcxh2AKimXCQbDjtwKQP4b+1t/p0+giUe9lJob7Bq9jYb2ZxJqJ11laeMV8PlZAwIt6NTxqyKYRJiOhSZsYsblnmXBNifUI4eD6qxQtqfix6wRBiuNWS2idXczYWHzTLVnGrRoS4sghXngTFaBA7i0o+ZoZkUh9Ee+xI07uwSVgU+VkDkZSW4etDeaR1+tHDRys4zZH0zXNNKDS5c4qNEOy7K+PynIAdhm2QODnFY1o1Ciemx7nN4o/RRfihcZ7TEWK9rD25ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 26 Aug
 2026 14:39:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 14:39:03 +0000
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
Subject: [PATCH net 1/4] ipv6: Fix redirect exception creation for UDP/RAW sockets
Date: Wed, 26 Aug 2026 17:37:32 +0300
Message-ID: <20260826143735.1819315-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826143735.1819315-1-idosch@nvidia.com>
References: <20260826143735.1819315-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ddc8d2-bece-474e-0cd7-08df037fc69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Yg1Z8YXKqR4htZcyxK6b+5F06m4DulJ1tres+BYluUikaA+8UMcRbtDkvgGrEKyC97XIHKxRd5QxbaaZp/SBaiObubr1E+y1ko8nng/DXyeZncK/2GXUM5KtOj2HuZITc3I+iyVf63eoqEFpfX+/gcEt0EIkcgiKLSABCVbOheoue5iuB5UsSx+cGxpeeonXmmbNED3Dc5TKdC7TRSrBSIr5Si4U5VclMjgNpe9pXNsUf0XZRPq/fcIb3XpGfEYgb5ormsG2n7HPgVQqVpTEzjjQZ5Hdg7Jqgyiq6TjyYlMvm5flXDW+u19mphzSGNYz88K4bwQxYXsKqtoLbMiLl8yShjKeTza9DbFsEZ9kocphYNG+mZP5jkJ9AsDk9JmlZHAgljEv3B9F+X0CmXlNmSAmzMmq8PVY/Sqlrce6ZqDHlq2WqKtLCT3ylnnkXuSd6ZdktMkoLBz9xPCLeFTzRlIQMXPfrsNJ5Bygt+/quD570NcsXNK4ZvFS5KWt6y9j4sdiHK3V/ph5GXhuqPzdfzR2wa76ZSUPlKvAKGasSh9FDa36VVp6wj2McrHvd2nj6sSk/6hZgOWnlYtZGhdWkDv4LYIMKmD+8hPlld/spzShn0B5Ia1pZV+EEFZ/mhJvxnZ7xicC/xC5e/mM4BCtx8Fho3lEt0XxcAjbTXu/lSg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6k1N8xRmSUvznBtB4UnX8r8vCuvGoOYU9Dp8c9A9tH2ParEjVTVYTKH4sCl2?=
 =?us-ascii?Q?Ea/7gm3raVXYgaPSyXaFLbOUZtITt0KZ9HBFtAwMdhVW6zvSty3Qa/1ui+XC?=
 =?us-ascii?Q?AXlY/DPZQ8SDubyFAUYitQO1qOONubjuK94GsuAAEqNDhXd7eOgVy5u0QCEh?=
 =?us-ascii?Q?XDSpmbiyTqLxc9t0jvR07HEuPN7nKbaHyQni8W7PJ9sH2TAFaMakVQlvaGpU?=
 =?us-ascii?Q?zvkIbNPaed8n3rAB2Lgm/EruRSfEb2SMMm42ghSzzw6WSS9Hm34wF04kgxWH?=
 =?us-ascii?Q?nCrHL8wIMfV/W6xlWi51zcbYunE/9a1YgoG09yP+X3MMb0BrgJeBKujJCcol?=
 =?us-ascii?Q?Ol4DpJO0cfqPTklJ/UF1y1ErB55WTouTdFoSeiwLDOaRMlbrCEiH0U9puyrw?=
 =?us-ascii?Q?3djBrkJ3GETdCDEfPvMta9nAWoQbtEw3pnLZrW1QGM/BlVcmgttCNXMzzEHm?=
 =?us-ascii?Q?av6QN0dRfdiEE2wfYyOmwIY89WpkO/YB4fe6HLA6bF+sz9A/hOn4Q4K5kcTV?=
 =?us-ascii?Q?ApAjhbHQmfhCeuIP7wUMatC8OaKQnYrn1A6EFn1T374ERwR47GfUTlI3i02r?=
 =?us-ascii?Q?zlD9hlKYwkBccgPDkAo9nYEmYE3v7lNRZp/Sz8APDn4FCHChD68ME3zPHRVp?=
 =?us-ascii?Q?TG+Ft+dwgtQ+NtiGQvt8B9wuIkfxPrfT6k4kpXNPe/W60Qx3iiQqpe39uSmy?=
 =?us-ascii?Q?P/f5bwbQhzqkKwVYpz4M7mipSx5ZGWp9pI5+RZ2poMqv0ZtuQTYuoxEZWxCM?=
 =?us-ascii?Q?I7Wr7sUms40ihRUKNdGW2EgAU4q25YzR+crtup1Y2bPmq3Hufns0RtefELMl?=
 =?us-ascii?Q?O8P8Z53O42l2t9WANWUOAdhAiovxIF2CH3jfLcI6fKDByzqFWIcwWg9b7FA4?=
 =?us-ascii?Q?O18D/sV/86L1RXrDnB9uILMy0+zj4WiUrVH6gE1UXBg0levlKPnKSYT73nCm?=
 =?us-ascii?Q?5JERe5rS4PV2XGbyrI9yhxA+WaSBL0J7cDkZfH0Rb0idGn/rWSdiD1FAXEtE?=
 =?us-ascii?Q?Axy6k3yy/FSiHJW2lxSI5aosfx7gezUUeL8p7bt8kLYRcnGdm+xbl0fnv9nJ?=
 =?us-ascii?Q?oY1rxRI3Ee2R7rBLgmsyAWlvU0TNWl+tbMIkB+FGghbYc1bjxWn+Bo6zRdO7?=
 =?us-ascii?Q?omiDgVT5tGD3z1wFwVBqTMAmH9UYXZvU7/gPVp9ChjvLaEhKWLNdqgCGtzxP?=
 =?us-ascii?Q?kWEjVqWrNTJuvySUdNZ5ngeYgJB97Z9CO3n5EzAGse5fXePfjko+rAfTyRAc?=
 =?us-ascii?Q?SHKsD7RQsL4PdSEAA+HxKN/4gg/n5SojyXBVhyHmweWXc7EKEtek3EiHnfSS?=
 =?us-ascii?Q?Wx7Gey8p9w4yXwcuNWqjkecBXm8iIZQSPNWlgHfVyRjB8R96RpF5/aoVF7SR?=
 =?us-ascii?Q?oE2CbKpoX49JYPfcvMnW2k1hk8FB/qW7quVqaTITihlSn+z6fiIJafR8PMhs?=
 =?us-ascii?Q?0PeStT6fXPJJXb2u+3SmQbSyI7LSTOTVoGaF+Yac6SnN5V1EZwQaa5WegnkL?=
 =?us-ascii?Q?Vrgr0iVBl1BVrr6ky+iWNJ9r2J+RBzlWr57Gq9f0RAFFo3XB8cYBnp3RyqKO?=
 =?us-ascii?Q?aVZYYjE/BlVUoYAmBLUXm4G/2MBvc2FEGx2S608nlZtDyNAD2H6Atp2H5TcG?=
 =?us-ascii?Q?pPfl9bHHLeNab70av0ZyzD3krn25sWXi75z/2DmJQHRzgq0qUqnTMdpeYTAl?=
 =?us-ascii?Q?EbTQ45pksBzLB6Sywc2r+uyxLH7P+j1igICF+jy1TuX67o5yp3FEpWgYFa+w?=
 =?us-ascii?Q?Q81fKg2Gaw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ddc8d2-bece-474e-0cd7-08df037fc69c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 14:39:03.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptyAzAQW4XF+6OaifoSof60WgaSOrVXiHPeocxi5QVbnE4khj25NnwjiBuR9cPGqEabJxedMViVRGT8lPxDvvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

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
driver does not reset skb->dev to the VRF device, so skb->dev is always
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

