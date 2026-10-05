Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C952F6918;
	Mon,  5 Oct 2026 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205593; cv=fail; b=uaXa5IiHVsmicJPR4BCBbsol8FbLrOgaSK3dqOJ4GI/ahMDM2wfxXOOQODQfRazXOd2kQRClQCEA+aOKCu1abqJR0nlATKoZ+Jkq4DX5zhjLiSXDuxhPRNn7t6tk3yVaZZSZBu1IKsu79p6KOl73oYpjEIhkwFbT6RzFmtU3+9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205593; c=relaxed/simple;
	bh=NPXDIPRnlSmpx7nFvr3RL6HAjZJGhClpVAQ0Fpg3a5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1g7yEUrA/PdNCBJF59iHCMRVP7HWg6npn2rAkFkm91rd6wMP4sv5zB1Y/kvR09JC/9mDNKtQvrUoXwPLR8GrTu/xKOQxWPbF1f4jzIRGC2x+MRQD9RAO57HyvppGobLFOQK4TswFkjMwd54pGyfJJ0HqCFuY62z5Yl37xo6N4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q3qyUHj+; arc=fail smtp.client-ip=52.101.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q3qyUHj+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JN42z06Spz5/mMsdjTULiI9o0a/yexVGmTXissY2VAeDeqQyb3v9HwrH233yNewfIPAVVzdb+ddpmi0YPOORph+YlPlw9pApNvSJSXE+cY9az8RTnGyKTcy4nysgGjjZDNUeLkOTGQxT5zmt6snWePhpoBulwiH+uOMwVbt/QotOtA1UnqGW9RvgNn19J8+yTTf6Jtimd5SXcy6vG1b3HnaQU4Gu94blJBQ0ZapHqDW17HDFGhmeUHZB+Q+in6NWzsnO5HYoDSIDKLDfB6zz/Gs7XIov41O3MpYzi706Gtl8niKv8+i0Vx7sbY8FXe/SIO6MwO54T9MEclQ/wS5xFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gxtng4HM4hkAl7XHNhm4oa+DaCzv3GaI2NMaJ1Ynp8=;
 b=P+K7dSNihjVrK7IfRkNHTzAYiqnk0ymRwvYd5xvH6XKiHlZdV4eZ+HZ/3v41jQY1cMaga8CCRqpNatxq54MJA9joMWV8OTUWPPhA0c7BXF6e/1QQztI7F69p4fkGPs+jYwEIAM0pTrSY7J1rlefvOveyLnQbsvPQxD+PqyydbmlqDTq+CeII9PBtwA+paNKgv4WC2NkmgnGaRBnIGnisE8s91fDOK3W9zxnDdFyDBSSnUxZSB6yODTO1Bd9aMf4dmDLSA5tsxuEow/LKS7OP4yH/Oy1tYP9/tM4qizm+yociwvjpa1JnKrgteLvQytBbRc2T0m3GQGDc3LJNI1nPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gxtng4HM4hkAl7XHNhm4oa+DaCzv3GaI2NMaJ1Ynp8=;
 b=Q3qyUHj+mBFlSw8lcueZtQ6zI5e89Ol3csAjgdro029JWUZn0Ba6xiRMaJkhWQxk/Gq3vmo4TtUoijZpLShU90UGmGgF9n07y2foPmkotzGGb+7GVpnrtUzl6nG52r1ZHzzG6C969oqO5ddEGY0zI51veIWAax83MmtO3c1MnFahD/XsnM3cUxz50BjRJyRQ95/Dsb24kwSqvDQvkSBqprGrn3yYySGiNRHslqTnpRzDsgjwZiYJ1XqtKChtSduJkdeYWknm7PtpZqaVGVLTGl+0OosPjYfW8uo8LIwPtI7GbpBXDbjGn/Kbinht1vqcUCF78lCjRMA42eV2/yizvw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Mon, 5 Oct
 2026 13:06:28 +0000
Received: from SA0PR12MB7090.namprd12.prod.outlook.com
 ([fe80::de78:df30:c2e6:7adc]) by SA0PR12MB7090.namprd12.prod.outlook.com
 ([fe80::de78:df30:c2e6:7adc%3]) with mapi id 15.21.0472.015; Mon, 5 Oct 2026
 13:06:28 +0000
Message-ID: <f50caced-1810-4f33-99bf-cc69a0851c08@nvidia.com>
Date: Mon, 5 Oct 2026 16:06:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec 5/7] net/mlx5e: Use the packet sequence number for
 the IPsec IV
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
 Sabrina Dubroca <sd@queasysnail.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 netdev@vger.kernel.org, stable@vger.kernel.org
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-7-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260930144523.435271-7-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7090:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cfccca-f6f0-4a80-6916-08df22e17798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Q6W+LK7iX5MotMHbNmYXOiS2bh4E3cDcLzE3nZPrIGdlyjVqsHRoz1CqDJQSi+n9UrcLNJbsGcnSzErLPdRkGkEwViUP0dNUWDOuJplX1j+u8t2IfsdheXDDJw00b6XLcBGMe21VASTdluHv3bI9rtWjtho7JPyrCNU5fNsp7WuXfU+BcN6yOP5joDvSYbzevg3nTIMqrjYFgpBEMlOrZxO0F3qozXRsQO9nu696EYxwVRLI41F8/JDaIpSiXH+zmo5eB7jptxrwHe+PrQsLIrZXZl6LrxLgadrkNWblSQxg7QxAWugbDgg1v/Rn7U15g02yje5NL7n0VYGKIYTqvDecxj5QE3o72lxNABhB3dmQZdgNZtxbSs/KYcs3pNC7ynNtLrTpXCwTuwRtEd46oFk3m4d8g63qyXLABARVHXhON2fokA1OP6B0Q2ee8KWqrgBcwkimRVo9ftDC4qLnOatnH4BRDtFEjHgFghg3RWUiBYM3IAjuRAQpA3IPVc0MZQqF2GfTRE18fAIuufiC0E3vtfowD+TciCJuSYvl4g56k9k8PMh6ANx1+n1QMwqCMbi3Ax4ND2fPkBjZA66hjGdM4j9vLiVoR1aZ1xWvUdhEfNRA+F1PcQJUaQ7felaEclu1C8VUqg9elDqAQNRR8mGKAbB7N3VBduO968qjVS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7090.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTNNaTlXQWQ4U1pvWnhOQTAvRW1KZkR5cGRnZ1lkSHJGT0UrcytvcG9JeHNJ?=
 =?utf-8?B?YUpUUWZVZXArY01ZYTRrZnB2N1pBL1p4eElpYVlmbVY2T3dWUGZsN1pCY1Jo?=
 =?utf-8?B?b1dwc0hoZ1hoSkk2alJsTXJpWlJXQ3Y0WlJuQUFEYmdUNm5nVzNEa3ZHbmta?=
 =?utf-8?B?dVZzWkVHM0NRVFRjYkFmakdhdi9WUTNQaVhRd0pGUURaVVJMVlF4ZHVIVjY1?=
 =?utf-8?B?TnpMcEVpYXNlMUNralNLTG9vZmNoOGgyWU1jS0RmNFZIUWNqTWptUzF4NVVt?=
 =?utf-8?B?UTdTMjZ3UnpLUEhTSnEzUi9lNkVheXdoYUhxTCtXVUNmYXF6enNkd1M0NFFZ?=
 =?utf-8?B?cnA2N2VmNXBSNDA4aFltYnZ0Qm5oWVJWWVQ1c2RJSzJxeWlMVkFvU2tqdmVJ?=
 =?utf-8?B?a2JGYXBOTHdJSDVWTndJREUvaXhDSFpoaGdNeERIZWY1VkZJVmI5WmN2cUw3?=
 =?utf-8?B?OE9aeXY0N1pBUW8wVWhnZWI3eUR3OWYxRnJqNWJlTHlhZlhNMFMyeDA4Mk5V?=
 =?utf-8?B?QXhpUldNWk56QXdVdkJ2Yi9QQ0xBK21RZFFsamd5Tjl2QlBmZkJ4c2U2aWY0?=
 =?utf-8?B?SVFWL253RkwzV1FGcFJSN3Z4VHgyaWk3a1E0R0d4L2ZNdnhDNVh0U3FxVkF1?=
 =?utf-8?B?cHlSdHl4cHRyYVBFOStXdUJKazd2SHRWZWpwQ1VwR0tKN25EbndPK0x2QlFj?=
 =?utf-8?B?dXB0UGlwdlN1c2JvSU90bndyRHRnOVI0Uk9rZFFSZG5nZkxFdzRaTm9nM3hR?=
 =?utf-8?B?WVIrYitWNWxRUEt2R3hUT2F4Um1HY1FGaE10Qm8rUXR3RG9BNVJobVVLRmNR?=
 =?utf-8?B?blZPRWtlOHM2S0pOVmxWOG55ZjFERWUvQjRVNWNpWUg0MU05ZyswQVJOSVdZ?=
 =?utf-8?B?Y1oxblh0QS9CcCt0SXpUbFdubk9IQTgvZWhFVWhUTVd5T0VXV0h0NWVPZFJP?=
 =?utf-8?B?a0YzYW9BRWVDdFRiL21tcGs3OFJ6bjdXYVBtdHBuKzMxVTZHbkNlVkZISFR5?=
 =?utf-8?B?Zm9BVHlzcjZaMGJkbmcxOTJZMEU2TFNWNnE5ckM1Qno2eUZWcUFpK256bDRa?=
 =?utf-8?B?S05IREo5Mm9kMGFWZG8yRjZubHlSa2plQm5CMWRMQWhUM1RxNVE3dEJPU1pC?=
 =?utf-8?B?TDRtbnZ6V1BwMFNrSTIwOTJ1ckc5Rmo0cW83Zm5LcGc3MVpHMkRyOSs0ZjdX?=
 =?utf-8?B?N254L0c1akQ5V2FBckkvSThKbVhVaW81WFJlUGgwOS9FdGliQlkrTHNvM2xI?=
 =?utf-8?B?ZSs0MVpZaytZQjFOYm93NThETlZtcnprSVlBSHIvYXVwcUhSZ3VqTDFZTi9v?=
 =?utf-8?B?OGd3QlR0ZjRCQ1BvdllvMXRUS2M4MGM5TVB4SEdZTERyWWhsNXd0QzFjRmZl?=
 =?utf-8?B?K1grSjFFNUZrMEwzS1FuN1U3R3NiRHVRc0VzTGhSNXNEVWN1U2pFWUtoM1RM?=
 =?utf-8?B?SU5SdmtCVDA1VjNnY243T0RrZUNOdTAwckZhd1ZQcDFJU2lKb2VWSW92QXhk?=
 =?utf-8?B?aTlNZ0YxRk9lTmJIUVJTSXo0V2Z2SENDSld1T0Q0VFpIWkRFQ2ZGeTQvS0ds?=
 =?utf-8?B?RFN0R1BUZm1GcG5rMGNpSVQ2aUFiSXRhNE1MbEhtNGxMMFhtekRRVGU0bXh3?=
 =?utf-8?B?Si93RlptY3BYTFE5dDVGS0dsaFR5K1dDOWtNcVdQbFU0TGwrTW0zTzhzTWNn?=
 =?utf-8?B?eTE4MGZiVzUxNjFlNEFMeWpIVkpsQzZQTFNrcG9pd3l2cXpvUW5xWlh2MWJN?=
 =?utf-8?B?ekZpRGpqUENIV3A1SHFITHd3SnVsMnV1cWRha1RHQlVFNHFUSVdTTncxUjA4?=
 =?utf-8?B?VktHUklQRHlyNjRwa3krbHpSYU4vdDBxd3RzWWRFb1B5S1E5WjdFK1lOdHE0?=
 =?utf-8?B?cHMwWE5DZURzUmMrdGI4endUQlQxZjBid3FFUXNRZjNrRVlvUVpleUI4S1Iw?=
 =?utf-8?B?SFgrTGxRdE5obEw5Z2F5TC8xbDY2MmUrcS9zZ0RJZXFpVm5jNCtqL0haNVFl?=
 =?utf-8?B?QmFOMzBqTFAzcXFjSE9sdDRuT3dlcCtnTjZxVUF0N1hXcC84eHYzSDljZTAx?=
 =?utf-8?B?Y2p2OFpTaWJ4TjNYTFJJbzI1UXhva2d0TGNlRjlCd3NBdUF4eGgwZHV0UVZF?=
 =?utf-8?B?MHdpUGM0M252ekx0MTgrMDV6QkQ1Z2YxR3E3eXhkS2xkWDVuYTVBblFoR2hp?=
 =?utf-8?B?Tm0rUDZtWTBaVytnMTR0Nm44OFRWTCtRZ09oQTRMM3RmbEdkRHBvb05FQmZW?=
 =?utf-8?B?elo1QmUvdkR2dzF0M2JqUW1wblkxRDFLY1ZEZDV1ckl1VjhoQ3ZML2Yzc0VK?=
 =?utf-8?Q?1jmsQ1vyf1cIXL0kFv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cfccca-f6f0-4a80-6916-08df22e17798
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:06:28.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKYvP5BL8tSBg+EBCPc2h8UgwpbFh8RlUQ9LngXp6gZZYSayXzyqoEgTEl76eVEfibXejrjyqzIEODp+Ddz7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312



On 30/09/2026 17:45, Jérémy Jean wrote:
> mlx5e_ipsec_set_iv_esn() may decrement xo->seq.hi for a GSO skb based
> on the SA's current output counter. The metadata already contains the
> high word for the first packet, so this can produce the wrong IV.
> 
> For a three-segment GSO skb starting at (H, 0), oseq is 2 and
> oseq - gso_segs wraps to 0xffffffff. The helper then uses (H-1, 0)
> for the IV instead of (H, 0). This can create a situation where GCM
> reuses a nonce.
> 
> Remove the high-word adjustment and use xo->seq directly to generate
> the IV.
> 
> Fixes: cb01008390bb ("net/mlx5: IPSec, Add support for ESN")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>   .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c         | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> index 6056106edcc6..4aa9f9c52f57 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> @@ -153,21 +153,11 @@ static void mlx5e_ipsec_set_swp(struct sk_buff *skb,
>   void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct xfrm_state *x,
>   			    struct xfrm_offload *xo)
>   {
> -	struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
> -	__u32 oseq = replay_esn->oseq;
>   	int iv_offset;
>   	__be64 seqno;
> -	u32 seq_hi;
> -
> -	if (unlikely(skb_is_gso(skb) && oseq < MLX5E_IPSEC_ESN_SCOPE_MID &&
> -		     MLX5E_IPSEC_ESN_SCOPE_MID < (oseq - skb_shinfo(skb)->gso_segs))) {
> -		seq_hi = xo->seq.hi - 1;
> -	} else {
> -		seq_hi = xo->seq.hi;
> -	}
>   
>   	/* Place the SN in the IV field */
> -	seqno = cpu_to_be64(xo->seq.low + ((u64)seq_hi << 32));
> +	seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));
>   	iv_offset = skb_transport_offset(skb) + sizeof(struct ip_esp_hdr);
>   	skb_store_bits(skb, iv_offset, &seqno, 8);
>   }

Thanks for your patch.

Doesn't this make mlx5e_ipsec_set_iv_esn() identical to 
mlx5e_ipsec_set_iv()?

I wouldn't keep both copies then..
