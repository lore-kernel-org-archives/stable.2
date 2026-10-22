Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792683674;
	b=nFL9Aj2ziXPw6xN7sxjtmewWODTxSP9jeC6rcotMajqAqyMZAmxMJyjTP534kcNBtkTT
	 hSeIgqxXzLwdAk49r1hNExM/CSuiUl6T0zcS8OeF2whAqwM+rLqyzxZxHhgvNbNWEfPXs
	 i5GGMRcjIEdbPfyUypG/cdIKjoC5AB+2T8W4L0Canxhj4iB4g+bIeLSkeBvR7oP9macjU
	 K4mSWgV6aYh2K6ffLM2V8htSNSG9l/FstFPKHZFHAd17u6QVju9Y8LzaQEImjs371JD/0
	 pV8+03Qo+kOTvXsiNf/G397jD1RxGjxFyq2MjQnyyFAP+a/nh2+dkluFqAI2mxZtw9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683674;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 X-MS-Reactions:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=51bAgWKZ8bzrXoxoovitJnctqga+4cKVORV5uxz4fWc=;
	b=fJk/rOtbAWtPjSlw+Xpjh2+lnq8KJTTVo9OCGTY+wCih3hYyTOy93NWMgP2XBanzM54k
	 Xdvodm3uptR7bCqQ9JP6zBfpRWFbl29/OoE8jmTeXGusuExxp/F+QAzCkFUGDSeUPvXjB
	 epXPiIh20TCDFxCpWyuBcZPKt75DeDF2HiX5cvJD1loxFckyVO3D91oGWDWfKoIf9mMpz
	 OXsWinrnPLLf7pULY5eXYzfkMpSVWSbjTDIDz8+T9Z+KfR+CiXGwqayQbD7eB0j4NebDC
	 VI9OhT6XPgpT5EyHLPnJ5RL0JgXnmTmDcO6dOu25bzq0WT/QpQeMMCZkbw8+We3neOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ePUt6iL1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.27
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17E606A319;
	Thu, 22 Oct 2026 15:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC17E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ePUt6iL1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExlhRBgbf2cSLaqdUImqibJSFOJ8UPUc50wRs/ggm4urg0rtbVUVFoxwke5e34pb0GskYAtp4zOdG0W6CfBnWJvvrayQNZZ3ii2UkQvI7jVNSgZsokFcyi+aUWX6g5lHVrgGwqLeg2QfQ130KKV6vpD3PLbI3bMGdq60FxuU+JpYpWkBP0BBpammWEYgLqm6QViEXf208TTnF2V3GxAlVH03xbhIPlJJ/NfHc5FfOKjqXNo84+UI19EY6TWA/pFiY0pWr2LYkQKWImsPH1aGwKRK2fIPsiRnQKubQfcuhAN6tvbd8g6UF+wHD2Yw+iN8WCLMkIqSpKbPrHtAlou7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51bAgWKZ8bzrXoxoovitJnctqga+4cKVORV5uxz4fWc=;
 b=j/AQzMQvE+uMea6Mcwj6cCNQPvRzJmvoHrepAuliNYpsM6Z/VSIavxSdGGhnNjUwxoNxKbQa5Zvx8tcwCe9p+izcp1kq8tiOIeZgEqzUBvz+Hya/7NBrFe/8I4cvGCTJdfI2iN8H1g/ay7yI0e5EHlYGQN6Nok6AKxeiXUCc25lX0PzfKI4x7QIFA6HlwEWlfE+4A0mD+RzRZIkxKddH7EdmXjlTdqxeZ0EuxZE9BAlmzqot2i2xKBOPy7zYsGrSGJn7t7QXI1n7MarrGufhtU5Go4KcK8TahcoYh7Z2n9wwYUsbLLvahgsKhbMP40cXE/I5ZVv0DowFZliMYV7aiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51bAgWKZ8bzrXoxoovitJnctqga+4cKVORV5uxz4fWc=;
 b=ePUt6iL1Nfb1jbso9u7i3zk6KV/6UdXIOKEuFTMZVBWKg7cQDvVj5tt8gT1Ga1lHtelc5l6V0UgAxmCRy2gNn4FbdlpQJjBCW0hb00Gw0spvUzrIhWRf03Ks1dk3dHJ9NN6nTzff2NPipZTFJWiv34Wa9ClPVc/DFJA0t9RFBguxQan5Y5Oe3nkeXDdsT83/MAy1B1Uzmx6dKM/RIiQZwcYkEsKarCZuEDzMNh+SJxmmplhWhaLHIxu2MEysuJs1kqPpe1yLn6w04jy8reX1LXD7QbHGhFTsp/0x0mWGYS4OmQD5OVZ1wjJnKkGy8rjWisBYO3lqqDE0ncpIwNKqhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::605) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:41:03 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 15:41:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com,
 mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org,
 flyinrm@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: let the highest memory node recover from
 hopeless state
Date: Thu, 22 Oct 2026 11:40:59 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <1CF47F72-BA4D-435A-924A-5CFB66FFB8DD@nvidia.com>
In-Reply-To: <atZ6H6IIx5gmiAkg@gourry-fedora-PF4VCD3F>
References: <20261019184850.3427905-1-gourry@gourry.net>
 <DM92ROTIF1U8.26CQNH7ZPEBG@nvidia.com>
 <atZ6H6IIx5gmiAkg@gourry-fedora-PF4VCD3F>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:408:f8::32) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a10c3e-a2ab-4065-0b53-08df3052e0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|56012099006|4143699003|5023799004|11063799006|261021121427099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TvxuwysXCgYf4HopAyP8N3SaDk/fDj/cUnPsZzTBrnWQZLXsdXHH6nh/evPKpDC2ScWwEPs3hM6WFcUc9PqJefQQv1Eft7LsnqNMCPA3Xoa2lSARKoiSBV9cZRyNxZIt/lrGudz/tI6RHYrWvMvMu3I4mUVpYuxFteDeQWwkZi1kb4c+InkYbPy5AIO7drLUQAKevILS3qAtC88XVH7XmqQ4herSeV5ehwWxBrIQo36X3U+qCy+zCvrTaKLq7Wxth7M08n5QamQBcqG4E7ky8xMbIn4pFOeb2LsnMG4SQYy3K9aloyToUtameS7dD+v79pz6VBvePyZw+f7OqQ2Ma82YkDDcdy1JqYnILS1mdCutSZsd37IkmAbY5ODfDfaNlVo0tkjbIhNMK8VKxMpcRRwmqSyQ7CpKvJbdp+CIg803VPpBZV8P8cLUT8yCnx54qjUDJA1GiFSSJaO1ZtwGOQkxe/GPTaNEUSHW4xeEn9Suu+N5UQZyvyBq67vyjgFpSg5PMwc9BiAksVZa5Sj0msi5hhX9O43n6oqV0dIPAuj0LLUCr5DiCbhvsPRlIk/er66FbSqg6yPH2o0RH5APnHNhcmDXfMHcg7JIV3dH3cgfHH3RwsXLor2TaMWCzRBXMW47bu0wDPA3+sKCaatvoCpvXzX2jWBN7rfzSBLpD0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(56012099006)(4143699003)(5023799004)(11063799006)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?efq1qG8YbownV1qedizJVwfQ0U4/DyOvOstyljwF6PbqQzjDOj2mKHxgLKVM?=
 =?us-ascii?Q?oVryya0igFnd13EokeNgn7x4+9LKn+ykhH1dTmD/cPn/p2/DO81r5ixY99lu?=
 =?us-ascii?Q?Ep61HDiobDVVzPVi+zrPnznhOBBZynSoOVpPPlRV2DCt09WFDJ+k5lnoGdCb?=
 =?us-ascii?Q?0G/Bc73YpJxmnmcrkPBBH7jPgKoBuwXibf1COHpiMeC8+8MT4edAvZMLsY8q?=
 =?us-ascii?Q?rDIUlEjDlH8yOi0jm6a6nHoIT7bh9H+Hc4zqC8zL/6DKM827rTyLrdj4+/D2?=
 =?us-ascii?Q?VqU3WBnGTcwwk7cCk1AZFJ2+5xG58ywd4dByefPAmVNXtCe+lA5hLjrp1HN3?=
 =?us-ascii?Q?/kCrtHMlB//o8xKFBV0rMnJGquH9TpFVmGcr2aFmOXEUklGiwjPdvrzTSQuS?=
 =?us-ascii?Q?crNp3wrOCRTb5lCpY9+N7F9gK48IHzAGKcJqDO2XpZH5BczkTSfp2J4+BTQ0?=
 =?us-ascii?Q?gY0JLHHSdvwACBuvNB3+MosMmjMcGgYJsB2A0G35Hl93A/aaMSLLLBH5/C9H?=
 =?us-ascii?Q?1A20K61Snv+THvYRE6VUvn4V5djOy2R8UZbhiwmKupbE3NkvJsDiHXRJa5bQ?=
 =?us-ascii?Q?WXNYYR3a9r9d1zqCtmhVosQ8mBZ9WY6L7vUEOcTrAAToSTAmVe/sZC9An0vH?=
 =?us-ascii?Q?cig+iTMGpwOlpQLSyXOJWTCDKJr5d1eTDq5bXVbs2/WEQcrIv7iCRgqe1i9Q?=
 =?us-ascii?Q?qUlG9PP2SekGEtcY5ZcWHGtEGf59FK/0uDbKC+P47pCzQCiWwZM1ISd8VbZ/?=
 =?us-ascii?Q?dMpgzDjbPgSUIi8EzMj47SJJo0e9pykzfR8WgH5IMGoP+VvaJn9bUUpzXuXT?=
 =?us-ascii?Q?ZZSqMGUvV/k+Cgba7ktq9mtMK0mVpSYlynv0shd+64cf4GSAaQSAszV9PJcV?=
 =?us-ascii?Q?1pOVAYCtIR4i7atzF8QwOMzCK25BsWIHGUGbt9WxEXqMCCpnna5jqD5/bRWw?=
 =?us-ascii?Q?s/1g8hwiykyIWsKA1Yvku4HpFvxgTL4Ct6MK2XcYtT2Tv9XQ7VlWMdOjvKoC?=
 =?us-ascii?Q?Ksp0W9vSMmDqvbh/ha413aINAScN3gxdnLCSZhZVWziFVAA2O06WO/oS4oXE?=
 =?us-ascii?Q?ZMpaQbGj4NsuitUd4uJcwWTep3g2Uo2haYVcanEReVb/yUNcMcN/Z90Q6O0A?=
 =?us-ascii?Q?D8yfSVshhD4hfCOgRkpJjxt31ro/JRwWs6kWz3qDyi220Yw3ybxNbtWgTd3z?=
 =?us-ascii?Q?qOhZoRrTBgmlX6xilBeNcq2DCbgaf1W/JqCGXXvOt07/v9rhiVHuu0QZ8LeU?=
 =?us-ascii?Q?3gYrTYxvMa8RJ6QrF33E0n0imPAOVtsCgI5sL+7Hzbsn05OwQSMrNQY6K3O1?=
 =?us-ascii?Q?bK0AXHtVtU9UhSYUAaDvTlTMKDMne/jGy49H7UX5f5FOw0qwidw6PK/DrqvV?=
 =?us-ascii?Q?0zh/AI4kW3YcliJZkO1mDvg/WzKSOvedLcV6APT3RZouANwgtSHGEK9/0Qdh?=
 =?us-ascii?Q?55aP6JTo8k35xU9ePejC/eQUdkKcH6Ansj8X+3qAzpaloZiq7dGjentrFJzl?=
 =?us-ascii?Q?ch6d6opodA636NHU6nc5y7XRmXlcORsPtKYSGi9PW8biki6QooknLyCgBCYr?=
 =?us-ascii?Q?pbOyuzDmjU3Xg48UmHpxwRGvTFMcxoSMSRBp0wH+9STL2K0xFnryLXwSiv9B?=
 =?us-ascii?Q?9/4y0HeL/2UMoG8DWICpbLCFtsxIigfHZoPcNa1YB562Z0YvMAQtUdEAL2VC?=
 =?us-ascii?Q?3zqbDK+aXetMWRbuRSjrLfga4/po0Saaqx7TThzKmrAyAIWR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a10c3e-a2ab-4065-0b53-08df3052e0dd
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:41:02.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwQtf4LNBYSBD7vi7Tq2bnWWLNXgFQTPWIPgi1kjK04Zcdm47o1mPLeErRlBnot8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6

On 19 Oct 2026, at 16:16, Gregory Price wrote:

> On Mon, Oct 19, 2026 at 03:51:27PM -0400, Zi Yan wrote:
>> On Mon Oct 19, 2026 at 2:48 PM EDT, Gregory Price (Meta) wrote:
>>>  		if (kswapd_test_hopeless(pgdat) &&
>>> -		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
>>> +		    num_node_state(N_MEMORY) > 1)
>>
>> Why does a runtime behavior, clearing kswapd hopeless state, depend on a
>> static memory topology (excluding memory hotadd/hotremove in this
>> context)? There is nothing telling us if a fallback node has available memory.
>>
>> Just reset it regardless. kswapd can go hopeless later if the node
>> cannot be reclaimed.
>>
>
> I mostly agree, but this was more of behavioral change than i was
> outright willing to commit to in a stable backport.
>
> I can send a follow up commit to drop the check altogether if you
> prefer - but I'm not sure we want to drop it outright in the backport.

Yeah, for that specific Fixes, your patch works. Feel free to add

Acked-by: Zi Yan <ziy@nvidia.com>

>
>> BTW, LLM also points out that kswapd_try_clear_hopeless(), called by
>> direct reclaim, only clears hopeless when the node is balanced, but that
>> rarely happens. So hopeless state can stay much longer if there is only
>> one node. Adding Jiayuna, who added kswapd_try_clear_hopeless(), to gvie
>> some insight.
>>
>
> Yeah I have some additional things in my pile on the hopeless flag, but
> i haven't gotten around to them.

Got it. The above issue will have a separate fix I guess.


Best Regards,
Yan, Zi
