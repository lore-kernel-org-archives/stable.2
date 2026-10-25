Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792912749;
	b=KVEajun4XDHBYCuiQyqrcsFL5v0eT+X7XNqI1GU5wFw0aR0GGUYWJ1297Gb7jWLQOFnd
	 j+yjy3mP5oQ4aHMWG2VUanvfXabAi1hkKVsAEYLRzXWBe/DFOLIMMt9QmT3K9p1WqFNFL
	 9v0cqk6gePoHfkwmo02BnsbP8yDli77/+4Ks+L5X/aN+YtoE1vCUN7R3yfN7/N5gwYlnV
	 tTf4PDlbtvKLR4UL7f5sTaqMcalgoi6LJIcinvAY744bzz6bJCzKXxXX8MEol367Qv6ol
	 +qXDQ7ChxCHoTOVhRyCilCKlcZVd3/MOZHGz+sutPJTZYqA5o+lZ78azJUQV5GXPHkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792912749;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=H7fvf+FAKdfocTW2aEGHJKbNMtmGzseTesP/qvMD45w=;
	b=Tf7rZUnMhtH/2p8uhBNu75xCIVcOjv4LOw2Jf1Cj6uUBj+rUBQqlRoGFSfTPZPq6yLBB
	 JCMfA6ZusZnJ5Xp55yC6xmfIv0E4onTSPgjrH9k4l3682VDk2LGIyyJ78LqXYD8YhIjuk
	 0zMw19YOMjki8XMaUtj8i0lhk310FfnumU5KbmeRMd/MHF0r8NBUTAlbuesmR2uS9kcMA
	 ta8zfupIR8VgkQTtLAVX4Z+hvyOs2gkxElhE+DzB5JZBwGHg8+g68wz2r3BmMEbuu4ER4
	 Mc6fbvYkiAvsZJad9K/yO3bPCoaZVu2MK86HL9AChBksFYvsGo5brpT71O2+0vUr5gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E64E5d7F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.29
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB921606A31E;
	Sun, 25 Oct 2026 07:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB921606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E64E5d7F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roij3v74Hstx7Y1Z7HkrzMTf0D34AWmNivAH6N5D/lacHm5g/s+kRoTNppddLVokZmgYAZDD3nnMdDdTWWuJfOisTBNj2ysGVlnY2O5kAEnasIAqVJcmr1kUwk6ZQgYrRuLxsFB46QhgnuPSn1djS2L9netGH3per2LZ5VAG40YnrCfwjZDJJ3KgR0xS65DNkJXP5AtSBONyH+X7fed6HVwp8Tk9V8CsDW/F1Zqyjjk3ALntCF139px5RM0PPAu23wpd/33T7+V6YK+KwXGPw8ht7YiRxxClbx3x5zZj5nslStwimJ9EwZOwUX/Y4rdIWyF290y/RhlL7ZR08ltStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7fvf+FAKdfocTW2aEGHJKbNMtmGzseTesP/qvMD45w=;
 b=B7Q70JNgrpfuhnCTQq/aatQ1tv/ukluaJeLCKriii4l7gu4gXKIeYf8rC4Zx8qjn7KXpc3FWke9dbXifptFkEt3fMYrDcYO+zQ5hOy9fT0Arf94bvrlXHmLyZTgKAxiIYRegfteWYxDaujXwPsKIhu9FEl5vOd+tRe18IZIh97oqL9xZ75sWT2e7LJyWILXfF14pg9wBd7w/lPsO3dTtO57XuT6pe6C59hs6/Wx1uPeyyjLVR7qj+/seutDVqXrfg/BXWW/55oHNYgsgASwDFpJ8+Y5M5aZ/LUPGRRzXQA2FX0cpxYmGn38gvyhLAbb5HlVbUd1omu8E1KhuQHu4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7fvf+FAKdfocTW2aEGHJKbNMtmGzseTesP/qvMD45w=;
 b=E64E5d7FRb6Fw7dtFQX7BTNKcgKv29ZI9CIyiQNb5JF2AM363ORTbC7vk3jfJN7OU4bYNqtrxNg+kbvfSGdUf837NarXDOjZ/YFMD2spvIERCccTHhF5O9QJAGuAqCJ7pWl+hrCciCgzSDkrU0FM/K085PNnFXIcVgJPhSZ14kVHpzOVm0Ezs/kOFYtXOndCscnj5sc87z4+LE7xQOV7RsSuvwFRcmH9c7whVVqr+vYB09n/R7rsE+vndNsz4My0XTPYXZNub7pUOCp6vUnyFbSANzaP+D2ljxyhsMttgYbOsS47XjBDmCKzaEGgLb7ZOFbzy/bPOuivoHWFi/ZgZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sun, 25 Oct
 2026 07:18:43 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 07:18:43 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	yoshfuji@linux-ipv6.org,
	Ido Schimmel <idosch@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] ipmr, ip6mr: validate packets injected into the register vif on xmit
Date: Sun, 25 Oct 2026 09:17:29 +0200
Message-ID: <20261025071729.34967-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025071729.34967-1-idosch@nvidia.com>
References: <20261025071729.34967-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5e2a29-1911-4d55-8e35-08df32683361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|3023799007|56012099006|11063799006|5023799004|261009223027099003|261021121427099003|261022105027099003|261021123027099003|260925021911599003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	h+C8ylEcNfoEm278j/KrP5O8mEJZzJcCBmLHHZbkf/HOYHofQFhUx+WhIJ3GYaQRdfmhWsxXnCqgDHNK0Mbg929D7urP+gMl7kvOGKkVP8bjenNdGZGRV9NTSwDnaoBd1cHXf5iqXV1xsvQCfURRJc83setsmzzwSLXFRBPoY+vKpehLY71jPJNJYxF8EOO+cp6/nXiFY6pxBHOIzoUWR4qk1VmW8wzZsVvy7JSBJLUkqfiECO3SMib7tXlzyzyvY2ZdNwi1abR6LP5Hf0v0OrXKkBEjM/Bv4I5HzlW+TBirkFx5O4aJuuDS3S0rhtshoNQnZFpmp/FYPLd0RgHUNmcvhkKpTd+KJyUGmilbCbXtQEa5NdoPArjEEqrgJ1/G3IevoAPVAOwG4fSOZ7VgXpg/GWl2XM1oEARahULZ7/opjYWqES2fq/5FHnGsDFr8JplyugTHrb3ZBiDpjldjLYWBw8kqhL12lHI/sk6qtF49bsC6tcJdXizPIfXgzoBNZQONwlUWKczhm1AaF/GEGyNnu6yAQhneIlH9lVVA6T615v63b3xwOoxpYQnU0+93ZrTDb/t92YQ3Xd9G14te+LjYQqiKh9jk3+ZSgZzNj6eEzNrDp2RzoPhy3GaLaJWpJExuI/vKvIM6iXXm2hQnByFjzVwkP4XQKZFDtADKPdA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006)(5023799004)(261009223027099003)(261021121427099003)(261022105027099003)(261021123027099003)(260925021911599003)(260925021311599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gZSVER9R1xiTuW7WzT/qzsP93EpiGftzU8N0CNdWPcBTGAl7rDJmAXHuNoX/?=
 =?us-ascii?Q?b+/M1co8zXNz6rFi47sSKX3S8FpvO+3e1dD4pu/RaQNpQFZh19/Z9Au6LhsX?=
 =?us-ascii?Q?IgMRBx5nmQV1Z56ZCZ2PUsd+RnqyKDgYyiWXUBoq6CEMZbp6oklEIQG/iIKg?=
 =?us-ascii?Q?Fup8SkdI1EMrC9ZGimBVeFp8jzJFBelyCg60EyF7uOkRnBFyOF3S+jphy+gJ?=
 =?us-ascii?Q?jiKpL+5Q7PiM86ofL71lFBv+edWsUB+SiI1pyfK4wOmnxcE9J3bThXwiSqh/?=
 =?us-ascii?Q?5zZcfYemeFrl+ZMxIptr0XDV/s536vqRo0Ex0prPyTIZRkV3xZbhsltZu7pw?=
 =?us-ascii?Q?Q9ld1co+bouluTLl4xmQgWRO4QFiWwQrjwsxmyYFmO/urfcTI3f35bfRdT5+?=
 =?us-ascii?Q?QOwDLGwyJm18j1crys34K5ovq74SKdM/OUGXTzkIJ+SXRZ9YISQNHHrvQp8b?=
 =?us-ascii?Q?YJMTyiBt4beXEog3NpTup9A7FFPlZ95PJlHyiB5FP7geXIThaJNcROOCUtgJ?=
 =?us-ascii?Q?VEwTgz+fNT2AeJrnQdlysp+G2vyHVRjyP/oHuvXViNvkG15TPxUJ44nhCDtm?=
 =?us-ascii?Q?pCHw9f+Tm6jG4JmRpk8H8nhpH8agjZpdPAX7PXCMTnhDWgPUytHifVqjEfBf?=
 =?us-ascii?Q?fbcWfh5savia6VzoPaO/ZJcbPwlcBb+sG4QOjQA73SuGdHtNvvUsW4awXI8c?=
 =?us-ascii?Q?jehlTBbbDtlCaiReI5rnHh0NzmqbEQedUipwszBeZcEeVudUNR8DmwS46Lyd?=
 =?us-ascii?Q?vnEEENc2tVOBG+hivqiIwHdCoc0oWPf+ElpDeXxGVFHhM1RWE2ae+sg2gLUO?=
 =?us-ascii?Q?orX6/D1y8Z4Pjua55fZEMAeffXvzzQD9FdZRhb6xnLit+DqnKjU45a4CTcxp?=
 =?us-ascii?Q?12LFXX76OZLooS2KO5373fM9kkPMJGgOhS7mJUqYok3knaAC3QXgehvPoAhn?=
 =?us-ascii?Q?/IrsZ9zlQInOCCu7xZkA5cQYQWk4Ch9wk3o8k/p8W067cj8rJgA9WTGMr7mX?=
 =?us-ascii?Q?7tssQwALsQFmXAtjM/Ug35Le1+jgLh7cUbGs0iFF5Yd2WXfv1MVBsym7L68a?=
 =?us-ascii?Q?inoIIoFx83GkKHqjtsiz8R15RKkSAItkhragvmaQ3sGkmB1sPRA7etflCRBb?=
 =?us-ascii?Q?Z6w+xZf1LCrw7SFy7z52gdMR6DCs56cEfJ0t1YaxP0K5SF/rHbtEoNAuzITE?=
 =?us-ascii?Q?XGbl6gDVM+5gTPY6F9GP3qoss8ALsyI0Vb4SAB/xDOvQan7L1dktMh3/+GF1?=
 =?us-ascii?Q?jW623yMZPky2o7gALmTaxp6ERr/p+ZAYQHrMePJDiHnYPQ3hX22Ie1FszEOn?=
 =?us-ascii?Q?luyi6QGxYlfzwNu5veoTuf2HRmJphD9wyEl0HQ7ctfIW5pTaY8ntD9AVrO1J?=
 =?us-ascii?Q?ipgJ2YxM1XQIAWuJ7VX5ZzR6MO6DB8Md8HmBuX+YIF+tU0M2PzJKvxBeTNam?=
 =?us-ascii?Q?cL9fOcPc8/RylIxHwqfHOxM8B65De4IpFiQqQ0i14+sIiIygQNuC3rX+5MsC?=
 =?us-ascii?Q?r76Gya45lZU3KIdK8nKAcsyw7GTDAibf0Jxb49z54Bl4G44bCAMC3cuMm1iu?=
 =?us-ascii?Q?962fs+N/nRKWFXn6QcL7VwjICt8RZRY5K6AZjiLaG4+xbifTgwOBdmOaxP6E?=
 =?us-ascii?Q?zX2HwaM657hhVQpMm5P7wiFrSO0c5eXSGmzCq4MPD0ZhBlYJe7kF3Q7T55UV?=
 =?us-ascii?Q?FfW/wTw8MOtB88dWQiHeSk1JWAiKBX8BSEcoEr3noOHhZA/K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5e2a29-1911-4d55-8e35-08df32683361
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 07:18:43.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzGxuPcgx0R2HUJHFxtPZVQvFbcCIeInwB7pDC0ooFEUspBQ56/Gt2QKog5nZy8gX6JaRrwHg0leH39LlBkP2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684

reg_vif_xmit() passes the packet to ipmr_cache_report() which copies its
IP header into the IGMPMSG_WHOLEPKT report that is queued to the mroute
socket. Nothing guarantees that the packet contains a full IP header, so
when a short packet is injected on the register device (e.g., using
AF_PACKET), the copy reads past the end of the packet and a recvmsg() on
the mroute socket leaks the uninitialized bytes to user space [1].

IPv6 has the same problem [2]. Its reg_vif_xmit() does call
pskb_inet_may_pull(), but the helper keys off skb->protocol and does not
pull anything when the protocol is neither IPv4 nor IPv6.

Fix by dropping packets whose protocol does not match the address family
of the register device or that do not contain a full network header.

[1]
BUG: KMSAN: kernel-infoleak in _copy_to_iter
 raw_recvmsg

Uninit was stored to memory at:
 ipmr_cache_report
 reg_vif_xmit
 packet_sendmsg

Uninit was created at:
 __alloc_skb
 sock_alloc_send_pskb
 packet_sendmsg

Bytes 1-3 of 21 are uninitialized

[2]
BUG: KMSAN: kernel-infoleak in _copy_to_iter
 rawv6_recvmsg

Uninit was stored to memory at:
 ip6mr_cache_report
 reg_vif_xmit
 packet_sendmsg

Uninit was created at:
 __alloc_skb
 sock_alloc_send_pskb
 packet_sendmsg

Bytes 8-23 of 41 are uninitialized

Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz%40nebusec.ai
Assisted-by: LLM
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ipmr.c  | 6 ++++++
 net/ipv6/ip6mr.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index eac23f251bfd..d6691c917af4 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -539,6 +539,12 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
 	};
 	int err;
 
+	if (skb->protocol != htons(ETH_P_IP) || !pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	rcu_read_lock();
 	err = ipmr_fib_lookup(net, &fl4, &mrt);
 	if (err < 0) {
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3a551be30f15..a628acf50b0d 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -642,7 +642,7 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb,
 		.flowi6_mark	= skb->mark,
 	};
 
-	if (!pskb_inet_may_pull(skb))
+	if (skb->protocol != htons(ETH_P_IPV6) || !pskb_inet_may_pull(skb))
 		goto tx_err;
 
 	rcu_read_lock();
-- 
2.56.0

