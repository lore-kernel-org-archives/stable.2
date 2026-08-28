Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C513CE0A0;
	Fri, 28 Aug 2026 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787945227; cv=fail; b=BDoSqBorLXrJ/7xrC2fL4xUPuMMCrsZDOOaYH9+LMZzJZYhF5w9Fm7n2ZoNXk+7XGRCNXI0rlavMS+I3onAp1sDCI3Rjfs/8WeEjGFitgnskrUfAj0x+NA8wgX39/2dwSE/nAqtksYAdV5aVK6Bziyp9sXg3/OpGb+AyuDdWUwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787945227; c=relaxed/simple;
	bh=Ax1H7U8+b3OVX7izRn5RF54q5sfnM5M1lcabjuPmeMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o5xRzTYXPn4GTN/5vu2TcQJcuVIfw71IoHa/ZGi07rV0UMAITQjK6OtrKL6GXSOIxVu7OckTB+drM/1EKixmPt8xcmqMwJbLmLwNJ8YDf1aCiK5U49q5pJdEUMxO5wyCGTkdkdHB9Xgsyro76GjDQ7m0OjHAYVP45ushM21EiPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qmGLpYOE; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qmGLpYOE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgAQVP22Ih/dsBPR11zGnefK5Y9+I07nf+53wX68KN1JsMt9a/gCFRfdLHTQH1jdYN24G+F2WEMU4Z2rNm6U3TYfcYQLUZRek9EBQPPFPeIZBQaG4xJPhov0umGYrmkXxzcsQc2MEK3OxrfFuyB/fQfdyfNdUSlq5A+zK3/URaZ/aOAdw0Jlx6T+DWr98/KDhnV+Vv+qaGQSdHJnmfS06v214oUGY2zUBJvDu8JlPPN2DR3r0TiFO6T0J4jWzTa4+sE5rBl3EHqaFBtX5Kyi2rsMWQXCqCjvRPdzvbOzfctohM6eQ6vkOLQ4Yyau3zaB/1Xr7b7SICdboDStHRIeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDw8BDLXF0kA14+5zGLRWp8uYL03/6clZGJT7O+oUuw=;
 b=sGTqMSnaV1qRtpEkI/5SwVCyq8zTl5UUmnyNaycNb3zu7boI6YnlIEPswA0dCP+tymbrMvnfW/Z/e44PrFc/rLKdVIwWPVMl0+PGCcqt3TT4tqa5SodmbOb7XH4EEY7LAeABAYu9HxExjXHFlRkvplN1dpGcx0E6rysYBgUCFwy1msOlVesKsZq7L/UMzJfX0QdhybUnBEMSIZr8xbT2t/PG+uCEhJr3FxzqEe9qBMEZZc3dC5CLEBxZkp73yCagiscWHMw7K6+khhU4izFgZtJDWa1t5+2itSXWEUbCwZlO88d+h0U4lU4CPVPT/t7qGvuLVJ7i+PZ4QECVFzlC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDw8BDLXF0kA14+5zGLRWp8uYL03/6clZGJT7O+oUuw=;
 b=qmGLpYOEQvFHiXQHd0hQcUgNLJmF4vlvLV6ezBUZKFnUr/J1S0dkWnWUfzfiPyyBNba8x8dnpISlRX5JHGcddsPs/oEAX5VAOFL4U0yrON/ltNZJBFSGHg0YIRDiiq4Yu9epbWUeB//MMDsIha1fTzCo+vPnMCghJFRhjeyCCxV1C52hXGvHg/d+0A6VgcrBgBiZftCAdCSdHp86FcF7myuDcVml5H5Ymn9PMe6RhDM0kpQ/9Xk1Y8CsvgnU7VegWsig1R0AToQD5C6P0uAZfIqM3rp3PqqyxZrXfuXpjaKHLION35Dh3fd5pY2vEtTn1D2fFLT+kdLLsaZ54RTrfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Fri, 28 Aug 2026 19:27:01 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 19:27:01 +0000
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
Subject: [PATCH net v2 2/4] ipv4: udp: Create exceptions before socket matching
Date: Fri, 28 Aug 2026 22:23:42 +0300
Message-ID: <20260828192344.2596928-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828192344.2596928-1-idosch@nvidia.com>
References: <20260828192344.2596928-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ba0fed-6f0b-48fd-c97e-08df053a5585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	z1lAXGVv/GBxvPJrzjbqhXRH0SLlp0wDAre82ktt9ePg1fq+3Ydu4LcAuGREtdSzz5U4lAeuBpxocbJHKdbx9KK1dcWDwpE29seDvDIn/w9Thui4kzArE0+3xGJjm357AP0PHnanyiMUfmLM6K7WEGyrEW8u8vCPdhInNcWpIAo4WLJXD8P7GODfnjIMWqi77y7MLx62SwECZpiHVCn/+kCa9o7Iqvz74mPj6uDIJzqGLrWerxBTEBoopFbda/3OrNjLtyVGajHEQcduOOtFyvNbpt3KSu/cdtE97Ph4gFBR0BUkCwLJ0G71fXvdx7nK8NME1f1PdNLaJoSHJ1vEbWjp49iGbyKiW72jV2TVeVdlQ4QZxTBhSWycOIME7wnImTeInPc6vHXDVr8uFcOScaTZznhUwL9RNFb3nWfSBLI/YhUTQgxyTPxTWm5b28zp+SNI5qq7L1iXD803hCXznwsDYCOt4V9oGU65URHwc9Lag+qwah6R7r86pQA6WRnIfR3zp+MEts8XzahiVlaZiB34iQt5HhmL4zUKOaJQn3OopOQQC/o7hOwsds3q2F7zFasVhNvdeW37o2i4e+cNy+nFRh6O1N3Rt0Uj4YDiRpz5EYucEPJaEACu+vz3KZ5jxIEM/Tv7JuRl3eNJKl4nCAGc+VMs+I8cXUMLQ1RQ0k0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3qwr59x1PbxzkUTOb1qr9+iC/mFANoXubPtJn+1zjbJbXuBueTGtBAjdq/2o?=
 =?us-ascii?Q?BH6t4DWKdkhJRlYVmmYhVb044KOT4Yt9j7Fkv28tkxYgNQj5UOdd4XJcfyKa?=
 =?us-ascii?Q?G182ScpU1JiY2y1sM2StkebAj1g7pYlHRt/0e1/yDZz7vb/PbPURzxdvy4rm?=
 =?us-ascii?Q?alElosdaO28pgmCewK7ch8TXd0gTypr5xMTkUFu/DCSOI+YX4/HamJ9dnzO8?=
 =?us-ascii?Q?aYYiaqHvUicX90EaIkYNyps3YjhHxq/inSf1zXsleBRh9ehXyvOv6rHKK43Q?=
 =?us-ascii?Q?2HJN174X/YpNlethd5XTUdim0Iolnuq6+eSnpBVYOEJt2HpwEBi1o86BRZEG?=
 =?us-ascii?Q?Nb8y8fTjecC44bg/W8l0ZcfQ4uOFSXDQqmpsFTJ/L2CeuXKTMOAxwru4fvqs?=
 =?us-ascii?Q?IKhsoMYEXWunoCfI7ssRl0OzqkZBmykXwg0wJFMZ1viXiW1uTXZ6NO/WXMjW?=
 =?us-ascii?Q?hK4B2ljFj/SpF5dlmyCpkJTv4GPXhM8T6j+NieeX1o0qAhldigxDYRp/Z9jb?=
 =?us-ascii?Q?lkOocSMxyOOASpB2Q6//zLrus5cXZudY9znai3Sud6WSkghqVz366wnBOdIw?=
 =?us-ascii?Q?nG4KYOCntR/Jun08YAPXvizZGERvQuoRPcVsQg6DCms2mGJK0lhQXVYKa33v?=
 =?us-ascii?Q?1rrwZjoP4IimSFQosL8kZjAmAZdl0HtMcpFkf0H19AJFAy6lof56f8hLKq/5?=
 =?us-ascii?Q?F5oA6qBcjRC2qz/QSSFrDFEY4lWlkXKhDCz0gFplOu1pfExyz966vRQiDYS6?=
 =?us-ascii?Q?97sWNhxLTHN74rM06/TAm8BeVysW8ydLc8DeH/K+HyWrPRp6R52F807N6kiq?=
 =?us-ascii?Q?Gz1+X9B2CiDc/5Vzxsv6gFJ21QDNToJiQDdUmMXLYMT4nAjJM4ssUHHAeFHg?=
 =?us-ascii?Q?wOCUbSUnz7AWQdfKqufXc6VEyIFxAkIkq46+5W8FBcyMhL1OdsO5Q5pNa/SZ?=
 =?us-ascii?Q?ED8Tbga3P+5rAQxqtXHMoHtn4gOh3jNso8hmsl92spWKUTME7+7uMzhlroPT?=
 =?us-ascii?Q?K3paFDMZR7ZuUBBvlchzaGVqVnnTClfsH3wj92Nu97U8gJi6BmQb8oCEP4r2?=
 =?us-ascii?Q?HekPER54pK1vekhiAzKWUXQU02tLZVsYcnf/ztBdCLSjy3hB8XsU0A9NaMFA?=
 =?us-ascii?Q?rqsxUQFJFb0vMUqxwQD9O11Mbx/v/d19cJQPdyS3AtkCUBBaA7f14cdimG+W?=
 =?us-ascii?Q?HSk2uNv3wq4fPop6hHkS3l6hXUadCk2YEtLgX6bmtUQvPPqqefl4CZDbJ+3F?=
 =?us-ascii?Q?BR0VaiepIQMRWHlLuFxpA/e2G1Lk9YLo7V65RYWL5XCmRv15aB7aUGYLHa+L?=
 =?us-ascii?Q?aZsVkP6OAWjxrXs+3PKEExg6UIoWrBEhW/aGjQHwRarG8ZlCDm0yDU8LWYWr?=
 =?us-ascii?Q?pU/rVymjBzKtzFBqb6xhHBYxgft9kHS6w0mcVNmyum0scV+Hnyb3FMGff5va?=
 =?us-ascii?Q?L73MlJvQOTwV33S6yeHDKrljHiICQbwbEy/hqSt5j9LW4do4d6m+hIs7x2he?=
 =?us-ascii?Q?GuRzISIXx/CILfS8EecCh0m3hLAKkHYb32XN10zq2RVeKTizBKCuzhwsZt7z?=
 =?us-ascii?Q?LnP1Fbp1sigMA641eTPMROxKi4XwWjQHdWLshpuFMc8+m0XnK/lt55OfLsXA?=
 =?us-ascii?Q?I4DByJB+ijA0rsTCjIMw9AOglAodwxQty2EbFGD5Fnjzo/1z2UJ9FbIKF+Qc?=
 =?us-ascii?Q?3hvOAPjoGhtuzbhILqx4B6TadCkYQSnnec2mR9jxCx1uiQBXbanRmH6lhG1s?=
 =?us-ascii?Q?OqIpd3XweQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ba0fed-6f0b-48fd-c97e-08df053a5585
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 19:27:01.2230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+coPIOjKBJFsROwFYSPPPWGQP6eBNKtpin7FL9Wv9lFMAzdThZ0lHOPIejrGrPIRb3MTsbgMGqXxAwWWCPeWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

Currently, when ICMP Fragmentation Needed and Redirect Message packets
are locally delivered and quote a UDP packet, a FIB nexthop exception
(FNHE) is only created if the kernel can match the UDP packet to an
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

Instead, mitigate such attacks by always creating a FNHE, even before
trying to find a matching socket. Do that by calling ipv4_update_pmtu()
and ipv4_redirect(), the helpers used when the quoted packet did not
originate from a socket.

This means that guesses (right or wrong) from an off-path attacker will
always result in a FNHE being created or updated in the cache that the
attacker can observe.

Pass an oif of 0, in a similar fashion to icmp_err(). This is also the
oif used by the socket path for sockets that are not bound to a device.

Note that this does not allow attackers to create FNHEs that they could
not create before, as both helpers can already be reached with little to
no validation. For example, by sending an ICMP error that quotes an ICMP
Echo Reply or one that quotes a UDP source port that matches a wildcard
socket.

Also note that in the good case (matched socket) the above scheme comes
at the cost of an extra route lookup, as the no socket helpers perform
their own lookup before the one performed by ipv4_sk_update_pmtu() /
ipv4_sk_redirect(). When the two resolve to different nexthops, it also
results in two exceptions being created for the same destination IP. One
in the FNHE cache of the nexthop resolved by the no socket helpers and
another in the FNHE cache of the nexthop used by the socket.

Fixes: 4895c771c7f0 ("ipv4: Add FIB nexthop exceptions.")
Cc: stable@vger.kernel.org
Reported-by: Amit Klein <aksecurity@gmail.com>
Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/udp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index af9603217444..479910deae7b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -900,6 +900,15 @@ static struct sock *__udp4_lib_err_encap(struct net *net,
 	return sk;
 }
 
+static void udp_err_update_exception(struct net *net, struct sk_buff *skb,
+				     int type, int code, u32 info)
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
@@ -923,6 +932,8 @@ int udp_err(struct sk_buff *skb, u32 info)
 	int harderr;
 	int err;
 
+	udp_err_update_exception(net, skb, type, code, info);
+
 	uh = (struct udphdr *)(skb->data + (iph->ihl << 2));
 	sk = __udp4_lib_lookup(net, iph->daddr, uh->dest,
 			       iph->saddr, uh->source, skb->dev->ifindex,
-- 
2.55.0

