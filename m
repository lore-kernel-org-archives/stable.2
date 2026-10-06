Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC3397943;
	Tue,  6 Oct 2026 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269398; cv=fail; b=uV1VAGHHu4HO54mVMRADvtIsBaqWoXZqs1K5Oz9fyl4aaGyzFO+binhvkUcxRR+Re1yzcw2iK9Jm2ElLiN+ZAKNKAMT0wbgsIM2pPj06oyW3ejHF65VFescvbWboXYdFyXNC8QUpJ1WDHbR3bkisanCOQLulG/zomIYOTHkjDcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269398; c=relaxed/simple;
	bh=cXu2iLvtUwCqeFlJ6MvnVEmMb7CUGhSRohyr4NOp0VE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=frSty7PX80Ug7dc5ZXoiM/BixBieegqcm80Hh2rivpf7KsKWSyn/zDj+Gc+XS27Jb+kAmXfhXi5jfRoQ3ZtdggCKO9zc/aNKfgEM72S+pRxVT4p0jSJ6gHo+XCdmkzrDE3+w46WScTg1lwyHh6JyREQ785+5N9yn0d+4WxPD/tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b6x30fkl; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b6x30fkl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhnNw0sPTBAqyLLmhgtH/BJnuJ9hFNFpAjnktNXtfszOCtZP0emLgq9D+IregSQeUiTs925Vd0DMJ36f12sbXUarxJVSkIAr8qm6EvPnkuOfNserzXY7DhCsoqMLPvaUS2D99LSRqre7Dyi5oCAaPM+IT8whbXKyzk5cdOLycBYusiyEmUj2MDjad9BHc6YpDbA5tBonRrmkqELFd6BT4zlMK4e6fXA+QyZVEV0taLGThutQVKaRvKiq6LTjJlbl7kjRtPvHNRXGz43i/lsUdShJkSUQVS76QEVJ45IlA8Yew7y0DoUVhszkYwTEk2yOlPe8ZSUws2RFv8/G6aT+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfGHffjCWumkZz8WhKNhhGvGshDV/9JqnI7f96ohXWI=;
 b=s2HsaUc4RHTB4wjkjw0r3ogqnzeTZu+KgVfcNayf6fd1Bs8TptwX5EtQEUwSfcMX3wb1Nsh3T2xQSQaMjiXsb3OH0xxiXAXRxmtv7t6vFTtxzoG5UAfnJL4+FXMBOwBvLK8tHOZObDDh9aDPRV8qxOHnXfEu9cyhNZcd2+Pva/kDwG5wQ4MzXEDW/0jwen23f6sYg/Acr1fy0fRbsx+aI1cYrCUCMLTy7JL8n59xMjUtNrF/y0wVOfpUlmd8MFcv8TUFcoNNZBqpxGpi1v39qXyMfzVTm7XEyDF71e7Ae9wgRshjrIFWxzgiSLJ+PdavYHJQtcqHIWE4hTcF0mRiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfGHffjCWumkZz8WhKNhhGvGshDV/9JqnI7f96ohXWI=;
 b=b6x30fklfLYr4ReHokp1N27JbUhhKA3uqxK9FfcJ2JB3OupJiaLItkYDcgydIpou9pyzGXKoPJDVMjcU+GTrc3yDt2MtQgmFic+F4rNPC/lJLyRmDGHUY+5aduGuSYT25AA0ZPwiNPWTWE0x8P+Wo1O08BX/JqgN0Fyj1+SdXwPMxMGPVkgbPqYMlMBHXc7pMvq5g6rBjXik4AeF7H94kRXEHnqKelZOZnwffy+i2a+ehKDn2drX0FeAGD2naAHISd2dcUvZ17CyJ5z1q+PUaGcFMwO7kAv0sfCiTARY7Sl7F+6va45KfZyBPMfJJcf+H9reksl/q/XRoyzHL11YgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 06:49:53 +0000
Received: from SA0PR12MB7090.namprd12.prod.outlook.com
 ([fe80::de78:df30:c2e6:7adc]) by SA0PR12MB7090.namprd12.prod.outlook.com
 ([fe80::de78:df30:c2e6:7adc%3]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 06:49:53 +0000
Message-ID: <76e305ba-47c0-4028-afdf-294dcfea11de@nvidia.com>
Date: Tue, 6 Oct 2026 09:49:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec 5/7] net/mlx5e: Use the packet sequence number for
 the IPsec IV
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Sabrina Dubroca <sd@queasysnail.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-7-Jeremy.Jean@oss.cyber.gouv.fr>
 <f50caced-1810-4f33-99bf-cc69a0851c08@nvidia.com>
 <af8f1e51975cb74188f645a8fd20a6cd@oss.cyber.gouv.fr>
 <e65b8b035eadcb1a776278b0887a57d7@oss.cyber.gouv.fr>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <e65b8b035eadcb1a776278b0887a57d7@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::13) To SA0PR12MB7090.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7090:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 527a7542-76c7-40ed-81c9-08df2376066b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|3023799007|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Gg7bykKlp61FQ5iLXYbUxbJ8wRt4rCsktlLjiIS/mHjGzEaOc/0dZSYDrW2pwKWLdfXHi1gg+po+rHLsjQ6oldaNynbDyxqFtltaMH5Zl5Zju9Qd7LcokNvjBdMbe39ETo16rF4kyQBXaPf/cHEzp9u0c3KdqrU8LZGb3jf4BPUzTusxsAfDJA/24dHOlBF+6hpqT4/r7YjN33JRdwEfO3sya6DWFpQO6vJPWs4BwYycYPTkzBrrN4ZDyPEfKKbA1/+599dxWGbUCO5M9DvWdGbPQVxHpgedlL1u+07+0Tvv7TZRk76YtKXfZ7wjMAmQ/budD15rqkIEejRZbkYxUtRh0i3PfTOwGFxUIHac/g9uNmnTzP8CyUuwnOh5gtkwd82sVx4nAasE1k6Z6hX5VobpC5XNo8lO5EIZ6wvUASHHqEy9yoLwCgmErgVjZ4zyElLM3aQGQwkbOs9RhV7ZjBT6jVNJMbFQJQ8czceqxR1YDBCXZ+k2QigJ0hOmvRxaQZpFEKyEtnjt/E1lTxRvR0UQkGIjBjl5CAOmWkQQ3zdXKgs5d3P746KceEp9Wx0XGdg0ymih1uUpSaiwaSYYkp1xq2VfNXDgNW6zwJrdR3TQ1VcSnAVBQlJ8aJm19KS+DP12k+IZbUB++p4ZdzZGokzWDhODF1vIreSunCi9aTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7090.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(3023799007)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEdvL3hNRDZaYTNHZk1sYkkyMElncmwzeDZFYVZxcHhmbE5XS21XSUFkTkZ3?=
 =?utf-8?B?bWVRNWRLRFBjWFAzZGpvZ0s2YmxKSVpSeDRoZ2xHbFUxTmxkVW03d0dURllL?=
 =?utf-8?B?Q2tUZUxQYlVTSjhIYUhUNnBIWUtJYTdYL2NVNUd3UmtMSURDZUpSK2FlUmhR?=
 =?utf-8?B?RHhMRTVxZlRVTEMrS3JnR2dPRk4yMTZmL01odmh6MmlFcFZaZ3B0WFlZYWpH?=
 =?utf-8?B?TmM4UWJLN09RNjZadUpIcEFYZUptUElDNHlKclNxNHplK0VDRkJEajE3dklU?=
 =?utf-8?B?WndQNXNES1Z3VmxXUU1sMWZaVWNnUllaRW5vZFdqaUhnV0FsZm5aZ2JTU1dB?=
 =?utf-8?B?NDJtNXpVYzFyeFo2LzdHc0JYT0orSWFNSWIrYXJNdTd0eEtWd0ZsSGxNRWdY?=
 =?utf-8?B?MER2NnA0a2ZDR3k0WThURW1BTFpSeUxubjRHR1pjMklmT0tWUytEbHVNMW5E?=
 =?utf-8?B?YXpkZEhpRnBHK0RleE5vQVBQcDhRYnYxR1FGTjJ3WHp5dEpodUZVTmJ6c1Yr?=
 =?utf-8?B?NGtYYnAxU0x3dWtNTGpZeFNGc2FlbGVIcjgvZ0ZQM2pMVmJjemduUCswRzg4?=
 =?utf-8?B?alYxVUtBbnpVajlCQVZvY1BZeG1jdUtHek9OZTNIZG5jamhhYVJIV3pkb3Vm?=
 =?utf-8?B?aXljSGF5RHVmejBDeDdhVXNRZ29yVU1pQ0U5dWlwYWtwdkFRSERPRUh2UXo4?=
 =?utf-8?B?S3BubUY0SlRsOGJsRjBrMmxKRFdsbEhmbVNNYTJpeS93Wm4yZ0RqMjRENDNJ?=
 =?utf-8?B?eThMY21MaU92VVltb0RSUkdPem5MNEZwam81TGZsOGRaamRSLzhGSkVWVS81?=
 =?utf-8?B?dlhkdGJzcUxmSkNDSVgwc1MvMTFSUHpQcU9JeFVPdzc1TkZkUVczcG53L1FV?=
 =?utf-8?B?SEswZUUzQmVVb0RzVXU3dFVYNjJmeW5GejczaUUvVnQ4WGczeEdpV2x5Tzcy?=
 =?utf-8?B?aUU1NDJGZlVTWG0vaUIreGNCLzF5dVNXSVRxODBsWTdNdms2T2ZQUGdvVjdW?=
 =?utf-8?B?UTZjeFFLSXhPdktmNWNnRVZ2Qmt2ajFKdjFEakNjOUE0eFJNakhHTk5HOFVD?=
 =?utf-8?B?M1JlQ3M2MGp1Mk1KbjVWQ00wSjVNUjg1SDR4SlpXaHJEUHhnaFN6U1BnVFVi?=
 =?utf-8?B?UVhnaGZNc2RhLzVNOE1uVVlLeC80K2gzS0lOS3E4d3MxWGdFNlNiMkQzSU03?=
 =?utf-8?B?b1Fzd3Q4WGFUVThFcWVibUlUdExNNGF2OXR0bDZScG1Fd3lyUDEycmVFR0xJ?=
 =?utf-8?B?RXhQcExOSnNjN0RzN2ZMR1BVSFJDZldHSUVhTkJqZGNvUmZDVzhYWmcrZUtN?=
 =?utf-8?B?djZEWEtGL1greTc0QXhpa2w5a08yeExnaDljZUxYSS9YSlBzTVJKbmt1M0Z2?=
 =?utf-8?B?YkFXU056SHp3eGNTYzhjZ1BDQWFwQnRuRCsyaUhUaFFMdmcxSXY0b2ZFYk9x?=
 =?utf-8?B?WG9YeHdhQi8yckFtZG9XaFNtSWVOcHB5WWFDNERMSTJzaXJ6YlpkcUZCdFkw?=
 =?utf-8?B?U1hhZ0NwVGFzTWEvQWFkVktPL3hhTy95ejE1R1dRQ1p3aEtmZXpkYmpFVFh1?=
 =?utf-8?B?UFdxNVUvNXZCVjA5UkxKVnc2SEllMENuSTRaNG1RL3JTenl4ZEhnVUdQcmt4?=
 =?utf-8?B?MWFaeEVpRVZ0WktXSDRGbG5DZnBPSGhxaUg4UXZZWXR5bXBnT2RyZVhuSGxG?=
 =?utf-8?B?VFIzQ0sydFpWSzlNdjdGMEFZZEhVdE8wYmgwNHNCY0J0TEMxcS8yUWM4ZUt1?=
 =?utf-8?B?cnFqcWkxT3JLWGtXUDlQRnhOK1E1NTBvZFdNRDhXUjFoTlFwNkphYlpwT0hz?=
 =?utf-8?B?N2pxbHc2Qk5zUHNDN3JIVVpBeTN4dDlxYVJIRzBxMmZCTzIydTdvZE5scHEw?=
 =?utf-8?B?ZXI2L3lmeWZzdUtXbWhlTk5kSmlnUVpHV3NyVVJWYnEvVFREK1ZLNkowZEMr?=
 =?utf-8?B?RGtRdXh4eDNnbDVpOHNFTHA4QkVZeWp2NWJTdHM4R1pURk10eWprRjAyeUlM?=
 =?utf-8?B?Yi9GSWRlYmxxRVNCQ2hzaU5abDRUem9GQ2ZicHVFR1hpNDZ1UUNJOHhsbDcz?=
 =?utf-8?B?WHp0amZNaWFiWFZWTXJFR29HRDVUOEtFbHlpTVdWVmNoRnVpM3RKVFNzRGk3?=
 =?utf-8?B?KzU3eVd1cnp6Z2ZmZll4bVo4QXlTalp2L0FmOTYvaWRKczhkWFVUVXduOGVG?=
 =?utf-8?B?T292TW9SNlBseVMybndRSDU5dnI0dDZTU2J0M2k1SGRyYW4zM0hHVHgzUHdI?=
 =?utf-8?B?RUlaL3prT016RkNxYXh5ZElFTUN0RTVjN0RNRENaWTM5NXpKbjZhVlVPRlFM?=
 =?utf-8?B?MHRwY050TnFZMFY4NUFsZmJqZTlHWHlyM0owMGZWSzhNai9udmNCZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527a7542-76c7-40ed-81c9-08df2376066b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 06:49:53.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0mkcIosRWchpBm9c6u5YTBsg1qZzk3R7obk0CmBTcecOSCQdGO4eRR6cwALNbwocCBNudLfjCduu0VBepyT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586



On 05/10/2026 21:28, Jérémy Jean wrote:
> On 2026-10-05 15:50, Jérémy Jean wrote:
>> Hello Tariq,
>>
>> On 2026-10-05 15:06, Tariq Toukan wrote:
>>> On 30/09/2026 17:45, Jérémy Jean wrote:
>>>> mlx5e_ipsec_set_iv_esn() may decrement xo->seq.hi for a GSO skb based
>>>> on the SA's current output counter. The metadata already contains the
>>>> high word for the first packet, so this can produce the wrong IV.
>>>>
>>>> For a three-segment GSO skb starting at (H, 0), oseq is 2 and
>>>> oseq - gso_segs wraps to 0xffffffff. The helper then uses (H-1, 0)
>>>> for the IV instead of (H, 0). This can create a situation where GCM
>>>> reuses a nonce.
>>>>
>>>> Remove the high-word adjustment and use xo->seq directly to generate
>>>> the IV.
>>>>
>>>> Fixes: cb01008390bb ("net/mlx5: IPSec, Add support for ESN")
>>>> Cc: stable@vger.kernel.org
>>>> Assisted-by: LLM
>>>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>>>> ---
>>>>   .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c         | 12 
>>>> +-----------
>>>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ 
>>>> ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ 
>>>> ipsec_rxtx.c
>>>> index 6056106edcc6..4aa9f9c52f57 100644
>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
>>>> @@ -153,21 +153,11 @@ static void mlx5e_ipsec_set_swp(struct sk_buff 
>>>> *skb,
>>>>   void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct xfrm_state 
>>>> *x,
>>>>                   struct xfrm_offload *xo)
>>>>   {
>>>> -    struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
>>>> -    __u32 oseq = replay_esn->oseq;
>>>>       int iv_offset;
>>>>       __be64 seqno;
>>>> -    u32 seq_hi;
>>>> -
>>>> -    if (unlikely(skb_is_gso(skb) && oseq < 
>>>> MLX5E_IPSEC_ESN_SCOPE_MID &&
>>>> -             MLX5E_IPSEC_ESN_SCOPE_MID < (oseq - skb_shinfo(skb)- 
>>>> >gso_segs))) {
>>>> -        seq_hi = xo->seq.hi - 1;
>>>> -    } else {
>>>> -        seq_hi = xo->seq.hi;
>>>> -    }
>>>>         /* Place the SN in the IV field */
>>>> -    seqno = cpu_to_be64(xo->seq.low + ((u64)seq_hi << 32));
>>>> +    seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));
>>>>       iv_offset = skb_transport_offset(skb) + sizeof(struct 
>>>> ip_esp_hdr);
>>>>       skb_store_bits(skb, iv_offset, &seqno, 8);
>>>>   }
>>>
>>> Thanks for your patch.
>>>
>>> Doesn't this make mlx5e_ipsec_set_iv_esn() identical to 
>>> mlx5e_ipsec_set_iv()?
>>>
>>> I wouldn't keep both copies then..
>>
>> Good point: after a quick check, indeed you are probably right.
>> I will look to simplify this in a new version of the patch series.
>>
>> Jérémy
> 
> It seems to me that a delete only patch would be okay then? (see
> patch below).
> The removal of the check in mlx5e_ipsec_set_esn_ops() makes
> mlx5e_ipsec_set_iv() the only callable function. Then it seems
> one can simply remove lines. Do you confirm?
> 
> 

 From a quick look, it seems we can do even more by totally removing the 
set_iv_op function pointer.

>   .../mellanox/mlx5/core/en_accel/ipsec.c       |  5 -----
>   .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c  | 22 -------------------
>   .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |  2 --
>   3 files changed, 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/ 
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> index db260e3..43ef5b3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> @@ -659,11 +659,6 @@ static void mlx5e_ipsec_set_esn_ops(struct 
> mlx5e_ipsec_sa_entry *sa_entry)
>              x->xso.dir != XFRM_DEV_OFFLOAD_OUT)
>                  return;
> 
> -       if (x->props.flags & XFRM_STATE_ESN) {
> -               sa_entry->set_iv_op = mlx5e_ipsec_set_iv_esn;
> -               return;
> -       }
> -
>          sa_entry->set_iv_op = mlx5e_ipsec_set_iv;
>   }
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ 
> ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ 
> ipsec_rxtx.c
> index 6056106..9ffe094 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> @@ -150,28 +150,6 @@ static void mlx5e_ipsec_set_swp(struct sk_buff *skb,
> 
>   }
> 
> -void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct xfrm_state *x,
> -                           struct xfrm_offload *xo)
> -{
> -       struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
> -       __u32 oseq = replay_esn->oseq;
> -       int iv_offset;
> -       __be64 seqno;
> -       u32 seq_hi;
> -
> -       if (unlikely(skb_is_gso(skb) && oseq < MLX5E_IPSEC_ESN_SCOPE_MID &&
> -                    MLX5E_IPSEC_ESN_SCOPE_MID < (oseq - 
> skb_shinfo(skb)->gso_segs))) {
> -               seq_hi = xo->seq.hi - 1;
> -       } else {
> -               seq_hi = xo->seq.hi;
> -       }
> -
> -       /* Place the SN in the IV field */
> -       seqno = cpu_to_be64(xo->seq.low + ((u64)seq_hi << 32));
> -       iv_offset = skb_transport_offset(skb) + sizeof(struct ip_esp_hdr);
> -       skb_store_bits(skb, iv_offset, &seqno, 8);
> -}
> -
>   void mlx5e_ipsec_set_iv(struct sk_buff *skb, struct xfrm_state *x,
>                          struct xfrm_offload *xo)
>   {
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ 
> ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ 
> ipsec_rxtx.h
> index 45b0d19..a3d92c9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
> @@ -53,8 +53,6 @@ struct mlx5e_accel_tx_ipsec_state {
> 
>   #ifdef CONFIG_MLX5_EN_IPSEC
> 
> -void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct xfrm_state *x,
> -                           struct xfrm_offload *xo);
>   void mlx5e_ipsec_set_iv(struct sk_buff *skb, struct xfrm_state *x,
>                          struct xfrm_offload *xo);
>   bool mlx5e_ipsec_handle_tx_skb(struct net_device *netdev,

