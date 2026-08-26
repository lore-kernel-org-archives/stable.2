Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3CA445AF6;
	Wed, 26 Aug 2026 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755165; cv=fail; b=X2jjhBrmdf2agvv675SDzeglzbob1I9Vfxgn2ZbzNmN64Xi11dMYfdLf1Jc+qoijbrpM/yZvUaJWIB3xQYS/63f89TOB9ZDO7IEF17WjlhBnMS46u35OYqfZD6Tzjl8ksIDlq9cJ79k0x4X/XWYIOnRstLqBssgYVOBgr1/lM24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755165; c=relaxed/simple;
	bh=g1XjOTApS4fcM556I1RksV6bAXtUviXd0b22TPpNCMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NkOarQd8s8/4NFFILDdi3rZeB2glPq2gVZxsm5oSM5tAcBwa9lPoXhhVdK/N22zsBc3RyKETFsOhvoYs7FN6Uz5VFbl/3RO6M3c8gcHUcFRb7P5nN/uTtc8lun9z2p+eNMnKgIHWyeduEQXvNfuWR9HISUNf4/LW0w6LRUpaPZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FX9r0wnG; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FX9r0wnG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNd40qnKqIxGbVU/XB7deL3FhGejvayp9ejsW5vqBw/TAFJao1AFqChRNODy2MzaziixY6lgj5Gmw4nNuHAoLMV79SYdsm2qDxfcvoYGnVkT/p2sP46UdiIs23xeUtgbigQIb7NCiFd4J+LhoNux6/bwRre0cg8CNf9LB2+z2IhKWc20xdQBny0bvKW2tZRSkK2XK5a9n9/bGbqA/hLLEveNBoJLgSu2qSpEZQHyLDrjh6Fg9CLU8GEU1cdVSPoxV4cGmHvgg2QtVOiwkqmuXLTWXDQlekyFxtTXbjtiqMVF9a9LIJGiGEL/OCwDTZ9dSNzXM+wdKdstTGXqRLvwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdAVEudjkobALm3GxZLIGaAsA50OrdaoMNi6WD6dtyI=;
 b=QOqStR0YXoBR3ckv7On1DYeg2hJ2nx4DGpgzG2JWFc/XIzH6sObSswE5kPf5jy6MXSpwzkFDaXHq7e1jzHF6ESz45Q5tckMLFS3LoFSUcwv90zpV7ulcfcEJQb5QpXe3SI8xOAJM0mYOpSG5ZLKcQajgRKthdaaJCyTsSZP9m6SoffBrsEu11gLUqkqCCahKCgdP85ia8CsPqKXYVdiEpU/z9wEKqVGZX1ZCS1kg0nSZUIbaYMl7hdPKazHGLUi2l1TiQuwo3mvDnbzdExtjprhIZI0jzbK6ALQsDYnKnlaogoIITZ3vZSbXYlQy5ivbTB3KGxVcvJnBJkvn5iUSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdAVEudjkobALm3GxZLIGaAsA50OrdaoMNi6WD6dtyI=;
 b=FX9r0wnGcDpi0NKZKYMyro5MR5MyxIxB5dbvFOJooysrPReLLIaHnQibDvbvVba2SjZ1EprKwyB32NApEqWJF5CXUCaQ0A7doTKd1gtk82Y0m4wJ/jbGKSan4mGxb7MpToYOuD2HoBvrFr8eyZ984h5+BHz7Nob7SNpJups6o+WFmnRx2ITSJeginjI2fOOxZFD4X36LRmJd+YNCVMjnWC7xk3jwe8Wh+odiOoRBDE9Bx3a1jQQlDgb2doxNwi70WcCgQZ1ovUFIQMUnHnF7kCilzmPq+RnI9ALf8muVjn/OFYl17U5VfqkP9Re+tYuOs8eTfRx0Vhsj2gp04NJOZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 26 Aug
 2026 14:39:14 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 14:39:13 +0000
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
Subject: [PATCH net 2/4] ipv4: udp: Create exceptions when socket matching failed
Date: Wed, 26 Aug 2026 17:37:33 +0300
Message-ID: <20260826143735.1819315-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826143735.1819315-1-idosch@nvidia.com>
References: <20260826143735.1819315-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: c243847f-edb6-4708-4707-08df037fcc7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|10067099003|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	ECg7HV1UepihgO25NJ79jkbur2Rf1QoKJRFLrgnf6pGq0fRiXbPzIspmwnilGKPoKCWUS4St2LKr1DQHMm9gOGw8FNVKIn3YzhuU8AdkTyjhE4DISFyY/bmC/zFjJU1v/FSGWYZWV7dKg3YBcW2bgGLQ7XmNUiK1ohzZNM4B1/HzmYju/j/FriSdgsABI+cdAnVZk+VpW4HomvuYaTUomMI9sH6BlJRzEQktRxPn7JA3SMO4t45qqWkGoqKnKtEppLDqzUBVuCZ2fn1r8B7POhDa2ho8zJyhDD9c+7ixLhqnmbY8+ee90O5PhH9YMOI6xfm1nsSagK8lbuzS7nanSBKkv+ZBKADeNh4amOYoQ28KuewdluRe7OieYMyUgkPaAaEFUZe7mnS5diXbPHF35C0eMlBUnNWJ1D7xc5/YihmbOHFaW2dthSJd315lBaJDu3f3LTeM/8snaksgnhID1g2SQGriDvuAw6efZR3YTvJDubZX01fCWchB+uIhe90a7Fkh3LTXs7dWe8G5WNa9krotJfjTL6MQV1U4IJsNBKD4FT0Zapc2R2DhFnKj7A0JyY5Kwfj6vDIBdCHAMcwJHhnwtXgiRxZdEahuIVnBZOE1yWfJuqXUWN/JqgICp8YRmRaASLTViuTEuo5UxfNDVzdfk6UcE/FKyMGYDjDg1Yk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BVXzId0V/KdM+aJ2iApXRpI39wf3Jv3lmaKb2Z/GE7ikhlxa/vGRthA2EkWG?=
 =?us-ascii?Q?Dah4bWKt4unvcc2biSjFoS7r/aJv45gHVNpjXKQMyOZOFtrzho7/UL1ilIii?=
 =?us-ascii?Q?aipbeASrP3oL621KH6nR1frvZNXvh2KanXYiAL0OjScKTK8N1WLucNrfr7SK?=
 =?us-ascii?Q?IO9wxFdCgNIdPXqcB6cbTzSC/dQ5DQniL3t0hBU/ZH/9cHOyyOE2MkTQb4Og?=
 =?us-ascii?Q?ekdlFdq6LtSdSz0TzoIbnvmMIZoS+bO0s1Ec1mO92ZpmnIQVp9+cDSrDvyYz?=
 =?us-ascii?Q?5c/AMeceTN+6EzEGlcF/z3j282j352NpzeM/8s8yIaynO7mBYGJlcxrlQdAG?=
 =?us-ascii?Q?BB3AMmmfRYDMVGNLGakVRqdsXWxqHsmnEoHathfLZhS7IM/MRsbs66K+5c+b?=
 =?us-ascii?Q?YV3tIp2JLPKOdjOWRaCOhDU75wLvAzlaNbRumwnU3I0dlCWECfwX8W1S40td?=
 =?us-ascii?Q?rh26TVHVHIvEBepGPSnFwryqmVsgRjQkJMhuvc36xJdQ8udJRKzwCx0Xu9kP?=
 =?us-ascii?Q?v53PWawuSG2Q+BFGDWMigC981GMLu9YBZ59yC19f6gQGlAA5k27ARzPJ07BO?=
 =?us-ascii?Q?g78DJKjMO+TFRWuIJbBDNSNXBVz4jxNeohdb6NNk2pDDAh3n48SnZKbmPeXk?=
 =?us-ascii?Q?f191EQ4TblLQe1xjHsCZiMudlpr3IDj0zv8filgSrf6Ib2YiLdtvGNQI0FG7?=
 =?us-ascii?Q?h+HDwNaalKAWbVRki1nSfNM1uMYPwVHubqZq8qLNdjthDfM2dDp63066lPug?=
 =?us-ascii?Q?DFrAbjS7/q4HcdJxOqMptJ2DUfZ/J+dEgLReW7ToMQFsX2tusiynZ1AQ/hil?=
 =?us-ascii?Q?YGgnqyR8WaxB0twg0rDuc9hmhnQW6Sr+ZfUsnnUPpYjTYTvZgYBtOMv4NlcG?=
 =?us-ascii?Q?I9+wGdy6IU3VWN0s7eEatDGHLDbDu9nWoQi0wEH2qlGkYTCIZuY3TKTosN5B?=
 =?us-ascii?Q?EYb/a5InT/1hgv08LuUxUZ/0FS6wlDvgoaaBHpQZUifEgp2W2mtOHVBM4J2o?=
 =?us-ascii?Q?L7JIY+tBdmnTLyLaDbIbKcS8vYkhA1r5MgJX2XsGzLOZ3oWxA3fwb3aPv0C2?=
 =?us-ascii?Q?86X7HYUByLtJa1mB9Vyyhvl6W95ZzHIWygBf4FD5kFGBxkauZdwjzeqEYZ1n?=
 =?us-ascii?Q?kjtg/yFsT7qdb3gBowRKAnahaQSAAcNo/deqdWXNPRytCzhnQPu/ixAUwCOE?=
 =?us-ascii?Q?1FWtT4KVgrpUdD0jo8wZEap1T2jw2NYQ6pMVAOz8GvzA0GJFoZ8L+vPKH3af?=
 =?us-ascii?Q?QCP8fKEX/A7ta7j6V6eavdV8xo9yMy8NJfrJ+4sxdEhqI9VOlutW9leeRRHd?=
 =?us-ascii?Q?lYntORbu5v1lD3sO3OGw/ksD9KdRP1mXYaAd4Tzsnw8b8AxrfASHA1XmMg+A?=
 =?us-ascii?Q?gd/uBtmd3o9yWMO9I4bjCLyQ8pkmQhyqlFcQtD42jLUrjn+IrzYLaX1z4PSL?=
 =?us-ascii?Q?/3Ovf36dEkHkA+ZrNetP2aoeVvt/w3Ozvny91J2JlEYmcKXswW3f8aXj6rdl?=
 =?us-ascii?Q?j1T/qVXI/MrftxnQoGG9lPNjVlNIYpBz/iEIkvl5oxEo4vQuk1qWW2Wsrt2G?=
 =?us-ascii?Q?O/mn+Hsmlz70OsSh0sY2crzPZgQk9jLUko8z0RjEBergI2Q6s0OoCu1qxPwJ?=
 =?us-ascii?Q?XkW3gpnVZEgF3ySYKaWRPK4HPoAcGWP7Ac4BZ2hIETZIT4jtn001K/Mf91uj?=
 =?us-ascii?Q?QvkbA59dU1Wrsb5OlWUFBzzj9rQQUNQ/AooCi47B2/M8YFr4y0VKNDL/5mh0?=
 =?us-ascii?Q?yFCXafpiFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c243847f-edb6-4708-4707-08df037fcc7c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 14:39:13.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB3VyOlT5U3w8BzKG5MFhCoDMijOBA++5yc3aLVJ5S70qbfUlWQiQwLtijbeW2pKNmSuMjwJKoJy4RGEUsWHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

Currently, when ICMP Fragmentation Needed and Redirect Message packets
are locally delivered and quote a UDP packet, a FIB nexthop exception
(FNHE) is created only if the kernel can match the UDP packet to an
existing socket.

This behavior allows off-path attackers to conduct a side-channel attack
on the FNHE cache in order to discover the ephemeral port used by a
connected UDP socket.

Commit 6457378fe796 ("ipv4: use siphash instead of Jenkins in
fnhe_hashfun()") and commit 67d6d681e15b ("ipv4: make exception cache
less predictible") tried to mitigate such attacks by making it harder
for attackers to discover hash collisions in the FNHE cache and by
randomizing the number of exceptions a hash bucket can hold,
respectively. Unfortunately, both of the mitigations can be bypassed.

Instead, mitigate such attacks by always creating a FNHE, even if socket
matching failed. Do that by calling ipv4_update_pmtu() and
ipv4_redirect(), the helpers used when the quoted packet did not
originate from a socket. The resulting FNHE is indistinguishable from
the one created when socket matching succeeded, both in terms of cache
occupancy and in terms of its contents.

Pass an oif of 0, in a similar fashion to icmp_err().

Note that this does not allow attackers to create FNHEs that they could
not create before, as both helpers can already be reached with little to
no validation. For example, by sending an ICMP error that quotes an ICMP
Echo Reply or one that quotes a UDP source port that matches a wildcard
socket.

Also create a FNHE when a socket does not wish to accept PMTU updates
(e.g., by setting 'IP_PMTUDISC_OMIT'). Otherwise, the fact that a FNHE
was not created can indicate to an off-path attacker that a socket
exists. This applies to all ipv4_sk_update_pmtu() callers, so ping and
raw sockets that decline PMTU updates will now create a FNHE as well.
Such sockets are not affected by it, as ip_skb_dst_mtu() uses the MTU of
the device for them.

Fixes: 4895c771c7f0 ("ipv4: Add FIB nexthop exceptions.")
Cc: stable@vger.kernel.org
Reported-by: Amit Klein <aksecurity@gmail.com>
Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c |  8 +++++---
 net/ipv4/udp.c   | 10 ++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 37674d76f90f..692298078700 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1157,10 +1157,12 @@ void ipv4_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, u32 mtu)
 	bool new = false;
 	struct net *net = sock_net(sk);
 
-	bh_lock_sock(sk);
+	if (!ip_sk_accept_pmtu(sk)) {
+		ipv4_update_pmtu(skb, net, mtu, 0, sk->sk_protocol);
+		return;
+	}
 
-	if (!ip_sk_accept_pmtu(sk))
-		goto out;
+	bh_lock_sock(sk);
 
 	odst = sk_dst_get(sk);
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index af9603217444..6981526bd59c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -900,6 +900,15 @@ static struct sock *__udp4_lib_err_encap(struct net *net,
 	return sk;
 }
 
+static void udp_err_no_sk(struct net *net, struct sk_buff *skb, int type,
+			  int code, u32 info)
+{
+	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
+		ipv4_update_pmtu(skb, net, info, 0, IPPROTO_UDP);
+	else if (type == ICMP_REDIRECT)
+		ipv4_redirect(skb, net, 0, IPPROTO_UDP);
+}
+
 /*
  * This routine is called by the ICMP module when it gets some
  * sort of error condition.  If err < 0 then the socket should
@@ -938,6 +947,7 @@ int udp_err(struct sk_buff *skb, u32 info)
 			sk = ERR_PTR(-ENOENT);
 
 		if (IS_ERR(sk)) {
+			udp_err_no_sk(net, skb, type, code, info);
 			__ICMP_INC_STATS(net, ICMP_MIB_INERRORS);
 			return PTR_ERR(sk);
 		}
-- 
2.55.0

