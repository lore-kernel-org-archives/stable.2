Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847244;
	b=f/I9KLzLZFSyDcaihl+dH9o7SSvcbxpmcGoW/VHHUpxxhae9TsFJaJwV8QAOvcrHDDyk
	 MPrDdp5Mbk0epkWuskzUnQ5uNZWTYQciudTajySB0CgIQmpCC9W1Zs943wloAEv5zM5HV
	 s84yek2wnDlSTHmrjNBjnZ/QMqB9KoDtZJ4QmAy/cPG+/3imcUsalc0fDDay/nW6xNGNO
	 xpSa7AzL88Lg0+IXFNiJ6sSyJSqLiP+MhVDarsvI5xpvdTEgP+3D3D/eGdaPHp3OV45d5
	 k6q5njUaoM1Y2797IzoU7HhyZsVcVAQu2VxMR1NqsmB9I5W6NIzU1c6s3X6kZ4r+BEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847244;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nYCrwawl5mXf5IPHXNapVWkXOLVwxEgDcIuZ+9Nec9o=;
	b=cQIQWX9PfxOeemaWe9CWqnaJgFlS6VmJ9ucHnTI+kPdoZSqIiWZvzKkrBHsHo3Bu8MY/
	 u6IkBBDDSxlSc0dB6F+8ckodPIVyaWWF1Z5JZjyK/FyxMyerCj1IjHASvNlyVIgaHt1VW
	 wrEh+YMjZRUsKk1tGAzXixB47yTY2mSv9h0cBbweAoQIlmtOH6vPE27QNFUt/KHzyzf+5
	 z8m0Zf1uv82rtGvG0l9VfDaH7QJ3psuMm0ry3vRZNjo4Bt/z1H6edoRdI04CZyQuOe87m
	 9t5nClsPwGMsdvooDUQVI51kaY/GmF+Fs+Mgp0iCQh561yAf4ra2m/02H6iB+7cl14g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T4amo9O4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.11
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6138606A31C;
	Mon, 16 Nov 2026 16:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6138606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T4amo9O4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACjjDTl+V8vL9I8RKnbXj7/R5/AOZ9TtWDQJopqoqFSDQakmMaEw0iNuz9jgo/7Hc2ZaSvTDbUkw65HsV8wpMxpvKJ9wSG33RCAQzK4md6ILAzOq/NXEI4mUyPjTjxZ4kZnjbS72QDnZoL3giux5T6emOgcAM0g7euCwUrBws+Mrm+CxZkDkrPmE2J0iGpdyGmazf0W98Y54b2XIZPjVCMK9kv6s+MkUspuFepk3DkDdM+7iYwuncs8oqCJ3koVW+jtkWlmNcwkdA0kf3xl+sEviElpk8AuPOYm2v7g40NdY3emqU3uQNd1Ish2CAPlqMTGQo0GE0Gie6pXG07E5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYCrwawl5mXf5IPHXNapVWkXOLVwxEgDcIuZ+9Nec9o=;
 b=MRgRWy3paWpHHnXqUyzUgv2KcDgq5QsOEAmqpB0ZawSXdrSIaMdv6ph1M6ObmxzoUKynL+Z9VYFPpb5513fXo1CsxGoCVRyzdPRBNHORD1BJqJA0ZjuLEHzNfkpaiS7P3kX3E8QC4V/qIVrI1e8iLvyaTOyG658zP0e0uqM7TSaOuWndgZK4mMAWH39nIv6bRJ8Oj5I4lwOvTeD08wWtr3im5BGZKPlim3max5zfF+7z8709i8Cb7K7bOnmvIyQRfiH+phU45zRNXuYtzFgIo1F2BtMIUDcWX//eNJjrYGUFovET41SM7JBdq3GCVgiLxuO3QZheuJKauy/0BCD9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYCrwawl5mXf5IPHXNapVWkXOLVwxEgDcIuZ+9Nec9o=;
 b=T4amo9O4sn+XswkEXwURqzyBV5XQWqABtKQxjJrgJKGBemUQW6V7yJ90gb29fem7UijHabdLk27hD5YZxktUolWrY3H+mFn41P3voOAA0PtAEAZ18p7X1pPge83B0dSBNKPvBF1DCx1ojzeKj/OSg5m0xcrJca6RyE3jFN6gNgL4jB9Loh7vrQ+9q5A27uxxPsJZ7jNfCnW2i5qjXXm2oiiMZ8wNGM4BsBlbBXj65/o/zwdHHwLHJ/fhAll7j1MOsiRvyKZObwPNdgM/6h7z379nFuZQFd2ORflxC6FC9SjCQk+Zdl6nPqjdZTn7MM/wuc7Y3FP1rdqZjSYd0sML8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:40:26 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96%4]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 16:40:26 +0000
Date: Mon, 16 Nov 2026 18:40:18 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ip6mr: prevent info-leak in ip6mr_cache_report()
Message-ID: <20261116164018.GA422990@shredder>
References: <20261112042415.617221-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112042415.617221-1-bsdhenrymartin@gmail.com>
X-ClientProxiedBy: MR1P264CA0156.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::17) To LV8PR12MB9407.namprd12.prod.outlook.com
 (2603:10b6:408:1f9::13)
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9407:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 865817a8-d65e-465a-24e4-08df44005103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|261009223027099003|20046099003|11063799006|56012099006|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022115727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	muhPy856YtufI65CWGKGZi6ypQAA0rg8VTDRlyKzg14yIuq23MMvhowzcl4qJuUQl6g6rL6DlX7gP5ZG+b2CHBOvUK1+6d1268jhdqFWDinm1O6fcaAcyaa5kvllIvI6X7tPbz1gRm9LqIIyj4aLzTFMaRoDT6D8sf4ha+mXLuqCjaKzz1jR30o6EjaOP3C/FrDD3qtL4NhZKDfXf1MiXGhYVVRt/oJMZGxdyNuN/Xtsv41sT//DzovgQaODTeOHHD/dsZKVCgt6w4t+Dh9lVJErlqkQ4wjqbfal7S7ocCZ4Jtq9qyk76gxo0AxzdOZCYxrDxiyDkzSHoz5Tbdwo23P3AeP4y26Zpqe6GypKZ6k4rsgVFuBjsC+1KwnDx5cCvcA+w69KsrgCKLb37DoQeug5s5GgB4ZlccyrI66Pmx3R+DDYXhmbmTI4mgNPo4JYNIL3xC/DS4kFmD/M6EEalWZsK3FDdJiPpd3s1wB6SOfAjmI+dwk8fpmHbHDIfKo6/p7r5Lfkv4iZ8fWszem+8x9xBJtV2J9GoA3LXnKTDRa9zMQh28x5sd/+9vtto0d98xJVsKjTBWg7+0luIBPVLRuBfr8gRtmaiPsMj+3mVmm/bmxQd42Ezh8dZgmnuMaAa7otuNBGYwnlDUvtTU1FB+TC5KrtkJyoTSm38EmbcEw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(261009223027099003)(20046099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022115727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ea1/buw8XzRLUOUu6o9EvYdjTNXeobSGmJfZJkL7Vl231oryLL+5Z39su6uJ?=
 =?us-ascii?Q?vyhwgo2LghXFiRi79uH/kEfW+yFzO/1w1LjD1fv3Biyg0D1VJAa2138nqhj2?=
 =?us-ascii?Q?sWFdN01PHtgoCYK+PmjiNvjowAYiMBBibnR0XBRQa64jzWkxqV2tVbCIsN6v?=
 =?us-ascii?Q?ck2gr75LvSYo7M58DupWDIn/2SXIHbEf8oHMWTIrmVtRWlvx7oJB/nJmEmiS?=
 =?us-ascii?Q?9Dimw00FULvQcIZF9e+kY0pnv1ZvDlTm5m166G+r2I+4KPcOh6HqcktFRHM2?=
 =?us-ascii?Q?eyMjrgcCVz3fdeGa+2Qcx6/eU6RBT0C5Veh697gec77xfTm6PSniLZWShSrO?=
 =?us-ascii?Q?1aYHdKK7JpTt5ZNuh4k0s0fiD7qkG1Rvy2x/Y75/mBDrVN1yIcXZvmavtrgC?=
 =?us-ascii?Q?IHz0uXDldNRZfr62HSzextbbJnUBfqTbSFAqOLFNy2yw9fkt2Pjio5gUQtmW?=
 =?us-ascii?Q?MFFnYh8VmvabIrUzNPZxjFaiB7BrH1kdzFoGL1BYWjg117Lxkx8Cl/hySl5d?=
 =?us-ascii?Q?lNuxrNuKNy+F4ObqJB6qx1x/XX8IeFCG80XADg33YoSv2/37ELuGOPkpqS9q?=
 =?us-ascii?Q?CiPMudQYuMtjvob/j1YFHQxH96FRqEQ5t+klCws+/EJp0G/6QxfKzgEVnjOS?=
 =?us-ascii?Q?SeHmiEFGiI49ygrleHIgWQepT3m/9cXpSzE2Jr7ozjaAK1FghtO2d5Cy5NVO?=
 =?us-ascii?Q?T7PKAYjs02tI3hMENnYzE42A/ozbTNCqcCj98Tt+8MR7Wz2DEUrziFvuAVj0?=
 =?us-ascii?Q?xUppcgBGHAxAP/anpLG33acg/7nyVyHtSpjM4ZqVXZqkzTbZr8XMMgc9yJiF?=
 =?us-ascii?Q?QXR5bwfCvyQBSouvmKoDtOyJy4iunmKajXc20GMzWR7Xgzxdx9fvnxlJCqdP?=
 =?us-ascii?Q?lgQATQf1WRpexrOyr47MNQLZFyM+1Boruo3I61PzRkr1AexPEs0mnJXUoM0Y?=
 =?us-ascii?Q?cMhcTFMpwHmhWzNOWQ4XJ7fBIAJAPJS5lpyDtyXstGnZDvop/h/nN7nImk53?=
 =?us-ascii?Q?V8n/ZZtJ3l0uAPDyKjiYza6WJEPRfgFs/HmX2v1CeWpfR6tsJeS7LfKpwGH0?=
 =?us-ascii?Q?gHoALxEnIidCw3ACsTJZyc0TAFtYVp1gHK0Tybw9hCeIgV6OBFMwtkXjugph?=
 =?us-ascii?Q?1udiXvAt5AxnEBz/oiY9zo5smXhioUJCcnZPt7cUVNW5W0Y/4a+PnNsJ0eE/?=
 =?us-ascii?Q?rGDaC04Pjd/MZofJtszuvV8WW1NGv0eewkVu3tX+L8ne0Ptabpn+eb+kdVMx?=
 =?us-ascii?Q?EDr5Jeb4tary21KbyCdu7mPxyo5D96Pn/35BLIcz9AibbC+B/b2f0o137kPa?=
 =?us-ascii?Q?dK/hZ0mfD+biIUMicNi4DLSJyVfy/UW5URIzHYkbBNVDYV0D392VbmAWxvxU?=
 =?us-ascii?Q?fjLvVbuHRZgcZxK8EyGnqwM0wfHJk1g/MZrkq6NIdex1LBWgJYkbIz56JtXI?=
 =?us-ascii?Q?Wp9z9so60/y0DgS40AIPn4Vku2kY5dpBCxe8wrmEeR0j/E7qWkrIBW8PiVb0?=
 =?us-ascii?Q?Ar3vNicS+lcx+sodd6czfX996zyve8R6OwwUmY/5J8mXre/Ninp9ApntIRsm?=
 =?us-ascii?Q?cGVOS99hyV9SP3Xe87hDZiKq5/mUJ6/v95Li3EfKAgZrzs7G+lTT9aTQsc6a?=
 =?us-ascii?Q?zA5AkPPEjYsEABRT6tg+hjEyunyC2EdZoXp8SIQHkY2U9uLSJqkg21ggtvrC?=
 =?us-ascii?Q?VGpMggFHE8ru7zvlHJC2t20yLNY3VNx4xAGU+HrDc4E7VXYd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865817a8-d65e-465a-24e4-08df44005103
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:40:26.1718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojStABsnJu9k432iOgG24ahYv61Ff5ugzItMFzDCeAlnRUUEjy0INoZ7+D+Uol/TN12FnDAL0i2eL30oKwxkrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474

On Thu, Nov 12, 2026 at 12:24:15PM +0800, Henry Martin wrote:
> The non-WHOLEPKT branch copies the IPv6 header at offset 0 and then
> appends 40 bytes with skb_put(), but the mrt6msg is written at offset 0
> after skb_reset_transport_header(), so the appended 40 bytes are never
> initialized.  They hold stale heap contents.
> 
> The report is queued to the mroute6 socket and copied into the
> IP6MRA_CREPORT_PKT netlink attribute, disclosing the stale bytes to
> user space.  The stale bytes can contain kernel heap and image
> pointers, and the report is reachable from an unprivileged user
> namespace (MRT6_INIT in a new netns, plus the non-root
> RTNLGRP_IPV6_MROUTE_R group).
> 
> Use skb_put_zero() instead, as the IPv4 code does since
> commit 4f34002e2e376 ("ipmr: prevent info-leak in pmr_cache_report()").
> 
> This issue was discovered by Tencent CodeBuddy Security.
> 
> Fixes: 7bc570c8b4f75 ("[IPV6] MROUTE: Support multicast forwarding.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Note that:

1. You're expected to answer to the bot with the requested information.

2. Better, avoid getting your patch flagged by the bot in the first
place by putting the relevant information (a KMSAN trace in this case)
in the commit message. See commit aa1799e93f5e ("ipmr, ip6mr: validate
packets injected into the register vif on xmit"), for example.

Anyway, this code is quite bizarre. Unclear why it allocates room for 80
bytes, writes the IPv6 header to the first 40, then overwrites it with
'mrt6msg' and leaves the remaining 40 bytes as garbage.

I will follow up with the following diff after your patch is in
net-next:

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b7ae220d6b21..31f0e1ef5601 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1107,7 +1107,7 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 						+sizeof(*msg));
 	else
 #endif
-		skb = alloc_skb(sizeof(struct ipv6hdr) + sizeof(*msg), GFP_ATOMIC);
+		skb = alloc_skb(sizeof(*msg), GFP_ATOMIC);
 
 	if (!skb)
 		return -ENOBUFS;
@@ -1143,20 +1143,9 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 	} else
 #endif
 	{
-	/*
-	 *	Copy the IP header
-	 */
-
-	skb_put(skb, sizeof(struct ipv6hdr));
+	msg = skb_put(skb, sizeof(*msg));
 	skb_reset_network_header(skb);
-	skb_copy_to_linear_data(skb, ipv6_hdr(pkt), sizeof(struct ipv6hdr));
-
-	/*
-	 *	Add our header
-	 */
-	skb_put_zero(skb, sizeof(*msg));
 	skb_reset_transport_header(skb);
-	msg = (struct mrt6msg *)skb_transport_header(skb);
 
 	msg->im6_mbz = 0;
 	msg->im6_msgtype = assert;

