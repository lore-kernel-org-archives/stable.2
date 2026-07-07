Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456D332623;
	Tue,  7 Jul 2026 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434554; cv=fail; b=hskNpSrzGfMqPzzWVD1aQ4W+nJLKK25aXJGjDz549t6TYubDR1HfbvdbrLAlbRygwvIjgIGc+vG2tXEqsNRhPxJJNk8RDQfN3b1IgjUjxQlIU2l3kyekU+Yu6dRsa6QIRxYGBxXNRuzr95s0VtH/xN6e/5fuGTafgoefcPaAFp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434554; c=relaxed/simple;
	bh=e722Hx1/U35kXCRm8E/dFFpi1+b3we0hCI2OrXkuA+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KZLuMEcUO4v13Xo1pqrnxBvtpzF2FqRgINtIdtKpC/BVCYx0IGaPmG+dW+S9+nPN2NiubdXgs8a6p4ylKvva1pjMNOXBWRfWrjc8oIIcM1i4GQNZW2kbtPzikMm8lkbtGV05Mg9H3BJeCZ0UOns1E+nkMMNWFWXMLKrZMSpeTzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=weidmueller.com; spf=pass smtp.mailfrom=weidmueller.com; dkim=pass (2048-bit key) header.d=weidmueller.com header.i=@weidmueller.com header.b=fKDfIgQ3; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=weidmueller.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weidmueller.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weidmueller.com header.i=@weidmueller.com header.b="fKDfIgQ3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXfzviyTn1iIvCfr+hoAM5nf8uhjTYczgS5InG3fVhGcejo5Fx2wT7WiHtQ4QS5QwiBVXsBVm6XpxzLAWD8pInWBd5l4vXRQEvrXJcQ95yFv57idaw1ohZpbCZGDNthBwBygaGPJpIMjqvdpLBJ5AsKCs3OI/M+G5S0Tmcu8qr69eBWk/7RltZH4DRmKLD7NbnQshFtEasa6FW/Qdar5vUlf8nyJ/K4FHfwuRzpMhxWv8+sGo2J4bs8o1ya7KDmh/vMJopbxYg9IXs17AChzGi4UorS4xrHVgHS2jKa3Ef5BlHk120K3Yy4piE47mmTexznKz08zmIihCo/m1WqExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCKG552j8rdy9jQL22SdONcp6J1z8Ihe68Q/A5NtI9c=;
 b=lUw8QU1PqdeNPZbhYG6FtaXZcheiJ3jmbd+cYwUe2ygWgoaHr1XknQpQAdL0wzMb7/aY3YbvPZ9aZXfYQPBV7BjSAAMaCTMO1JMg5sFIRHOLiRfLGyBY/9yhCGhijDakw/I6nxqO3nbheiyJI3+7POwaXe5NS9zrKSSf8DXBtYz9GTb1BeYCvccYo/uE8Pu84JA7/EB2ZVjnEuQTmQ5t7JUyV8t2rVmrlvBJF9AWNo0crM8LFJljHa9O8ejUJfanPwkwNtXtfUZSgzDdvOVssKrstERDYTHL5KRmOH+IQRx2WfK2BV/B0GOkMSf0SnFLm4R/0At9RY1YYRz09Fx5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCKG552j8rdy9jQL22SdONcp6J1z8Ihe68Q/A5NtI9c=;
 b=fKDfIgQ3SuItqXCUjZIdfT6DUhkKK6xur1F7Waam4dxZEeuSSdgyf7WCGAzp+Z8XNOHU2uAa0+QaajNmfwCB/OJr5HKUD6CbqwN6OXs+hLtM289oBoebnT5W58zOYH98eQQ7LSOGMo94YfNV3jX7G4RVOcjMfFsc00cHrO0AieXIv4Z5v0f29ZDQgKH1Lnl7Z0zT2PfbFKzT0m78FneeqOjzMvnpf33TFZZ8Q6R3hUc91+euAp8G00wt9UenmjJp/P5MaQiUFwHjWtc9Kub/eQjm79FNbR/gqEBxIRKvVpHNkXK4HZxIUAtyYhOxHBbi3dAt1dSRXIIiPPy+QDWB1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com (2603:10a6:20b:578::22)
 by GVXPR08MB10786.eurprd08.prod.outlook.com (2603:10a6:150:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 14:29:01 +0000
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778]) by AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778%2]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 14:29:01 +0000
Message-ID: <8d53c3d9-7918-456c-8c27-e9d73c896452@weidmueller.com>
Date: Tue, 7 Jul 2026 16:29:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the TX
 ring on link-up
To: Kevin Hao <haokexin@gmail.com>, christian.taedcke@weidmueller.com
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
 <akzDQrmdYwHAMMmw@xiaowei>
From: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
In-Reply-To: <akzDQrmdYwHAMMmw@xiaowei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To AS2PR08MB9199.eurprd08.prod.outlook.com
 (2603:10a6:20b:578::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB9199:EE_|GVXPR08MB10786:EE_
X-MS-Office365-Filtering-Correlation-Id: b94a6a5a-7bb0-4d6a-164c-08dedc3416ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|11063799006|4143699003|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zzdOxSh1WvHQ2P8CIfeAApP6aIVYfjg6PwW5COeAxUaq4rJ4nGYwMhaPXRuQuc7f1o0qv8LwByZSU6HXrUHHuf7oGUrZ/S2YoU0KP4A89AhS0bwe3xwwGqBKWYeJXNgj+HFDzGz75jnh6HYkQCUDN2DFaEcl2DTldwv5bpI4UtjLCwpwoH9o3dc7J77stCNopOi5CR5dyEV6qz8fPtNTWO9eod43VfeSt6gcdQ+v8GG/9AmjO7U25OnwztSuhhV6Y1MkjGRcW74mQfC38bwhbUh+fI9iREUmgPtdxTkWhyJIbJ0MEfkxn7FeZRm3ioDwRMbTPr3wkANq9OcK/9Y90QTnqyDE5NVwbwVTldF4iVDORL9r6+Up98Xyxx2KMgYjUgmjxTYyOX7Nd0abKx3h7FEh5UG/BwY+I+xEQlYUjXFUhLVdpgU+ouaW/SA15p4FqRYa1mTROkLdFTp+R8pz68PKSdZ8O+dq4KX5gWvRCv9+1RlKAi15iAqDseBnG4ZjICY3kWYxhXlmjyvw73P2Mv/k8kz5Zgw+DZzqkrgFEn6axBdvJCB18KS9ufH2J9M6vRlbgGqAkUzltrdEUI9Y7pJLalnxW6Ao+ad1YUp6+yPsZz53afkCwHBtXCwuyZBanPIQPXqD4PlLFTCI3yVIDftsLCuF8VP0pOzjIV9KySI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9199.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEdhdFQ5cUZ4Vmswa2dhTzJIS1BFK0JrVnhrMjV6bmZqSHhqMTRjT1JxaWkw?=
 =?utf-8?B?aGlSLzFkd0lvQXJwc3I4dWNtbjJ3MUR1QjArMEk3SFE0OHU2ZFhpOExpVVNZ?=
 =?utf-8?B?ekwyUldwRHZjMTQ1dXlkdTNMdmVSMlVWM0lqejBGQjhTWTdnbkRwSzJGKzFZ?=
 =?utf-8?B?OGlHNy9GUFF1dzhENUIwVnhjR2MrOC9taUExQmNReTI2MmdLc2lxS1Y3Mjhx?=
 =?utf-8?B?VGYrOEsrMmk1MGpUL3oxd1NteFJvRm12RlhuNnQwTFpHcjZkZlAwWEhtcTJ6?=
 =?utf-8?B?OTlFM05jWE5aNkJ4cVl6cktuVEZXclY1TXJTTWJ0S3g1ZXZkWTZHU1ZvVjh0?=
 =?utf-8?B?bnJNaFdJV2dJU0JpcllIdzJSRytMSWw3RVNSZzNUd1BUNHI3dE1MdHAzWXVl?=
 =?utf-8?B?cmVOWDl6TENDczJ2b1R4dGhBUlVBdVBNQ3pQTUVHTUJjR1QrL1pwMXFXSUV4?=
 =?utf-8?B?b0tUVW5nWTRQQ1pCRUdScDRLcWZSbU1hVGdISGtuYzdtTnNTRStHK2UrWTdj?=
 =?utf-8?B?MnJYWmNidm9LamI2V3lvZFdKVUpNbG1INkRDN0V3WTI4T3pPYTRLY0I0c3hx?=
 =?utf-8?B?cFZUTGtTekhDNDNRci9IRVo4Z0R3amJyNjd1UzJqVEFZTnhzZ3VueEFTZ21Z?=
 =?utf-8?B?V0ZIT2Q3a09jSVBpL3pEQ3ZqVm53dU9LRVR4MjJUNjdUNis1ZldOOWpubXRk?=
 =?utf-8?B?aDB0VmJ5MGZ4MkFpaEJMVGhMY3dPNnBLYU15YnBiU3hYYnRrSWhNam1uM0pn?=
 =?utf-8?B?Ym1NVE9QMEkxd1pqQkhIcWgyZXBXOXo2dUhOd29qdng1R0YzU0dNSURpbERE?=
 =?utf-8?B?UmxpN1lsWUZXbGVqNWJTOHVQSmpSMkVvK3pUK2JCbldzSkVmaUlkRHd4Kzkx?=
 =?utf-8?B?UGQyRTJ3TTBCTGdxbGNsRnpFVmg4aDE3RkxxZVhYSnNXMUhvY1cyV1JJTnZh?=
 =?utf-8?B?RDhaNnN2aHFBcnpTcU9zc25JSHV1RWlVeGZDNm9ZemNGM0Y2Z0hZaTI2bHhM?=
 =?utf-8?B?ZmZoTlJ0Z3BXWHJjL1NrOTRhTURsN0Nld055TFhHcW0xdk1tdmR5WmFuZmE1?=
 =?utf-8?B?OE9ac2xUY0JrQnVtVEpOZjdtSFE3R2MvOHBWeXhtSStMemRlM1puTzZzMUhQ?=
 =?utf-8?B?M0JSOE1CNjFPM09xYXlERVhFMXNIRlMzYTlnQ3hEcVJBWGhSSXYrYTVVMnZL?=
 =?utf-8?B?UGQ5OUg1S1JEbjFKSDdMNW9KbUE4aDBudm8rYnlMalZmUXFZOXNnTHFzUWJP?=
 =?utf-8?B?WGgwMXBmNWNDOW0vcXFqdTR5MkFtVnp4aUZab01DNDFEdEM5MU5DWDRjL3Nr?=
 =?utf-8?B?NHM5OUZoeU9RaXZ0WEpDdDhDc1lmcWlEVDlRZEEyY2xaN0FFNjFWaE9xd0lY?=
 =?utf-8?B?Z01IdnovZm5JWkQ4M1A2ektOUXp5Wnc5R3MyU0JEdW8rSyt1VlZEZjZRcFNN?=
 =?utf-8?B?SStrbFo0K1lsb29ucTY0RmQrbUtJNkJOVTl4ZWpvWlJOSVZId2JwN3dxcCtj?=
 =?utf-8?B?M29adnp2NFY4Z3R1WDJqamVWejhtUnl1bU80d2MrdlBSVDhQbUU4UjJCelo0?=
 =?utf-8?B?TjlkL2REZUFzQWU4aUhuOEZiZmJxRFNwQXgweGpPOXorMVBiQkIyYmJsaHdu?=
 =?utf-8?B?U0ZtTDJ6THR2dlZMMmhWcytDZ0tBOGZlRXBrUTRlZUwxbW1QQk5DZkt5eHUr?=
 =?utf-8?B?RzBVRmIxRSsvcEtrWVNWc0lyOWlWV1ZsU2JpeU1RVHdBKy91MEMwbUloeUN1?=
 =?utf-8?B?QnV0cDRaTWJkcVl5TmxIblZSL0RIdE14STJVckRRM20wMTFnM2RTSkxYaklm?=
 =?utf-8?B?NDB2eHo4ckZNNjlOWTdBcTl5OTJxdy9RUk4vTU8xOThBQ1ZBZTd3OHBVb3Bv?=
 =?utf-8?B?NmxydEl1dXd4SjJLQzVpeFM4bzdNalU2QWdLSWFDZDQ1UTZ4ZmxSZVoyYzhK?=
 =?utf-8?B?VkJUWVpnMHc0Y082aXpSM2E3VEx5NEpqbnZkNUJkcUNYcTlnYzRKOVBHblQ3?=
 =?utf-8?B?Z0diYjdxaHNxc2xrMm9HUFlLVWNwdWhJWWtKVXVjOWlPcjQyRHFPYmkveVRt?=
 =?utf-8?B?aEFDOU5tNUZiMDNsdzVXZkxLQStGY3pseVFSR2xGLzFGYTZVa3FRb2VtdUp1?=
 =?utf-8?B?UDdPTWlKM3RlWWVNQWVXSkpwNCtLUjl6RGs5QTBxeXIvbStoSElyNStsSXVt?=
 =?utf-8?B?MHBWRzY5ZFRYYk5UQkRUMEpXSDBCUkdMaHQyNDNhb1pmMndXSFJqRTlWUThB?=
 =?utf-8?B?Ym5jVU1tdFBubXNxZEZLUWk2SGVjVXlMWlloaktMRW11NVhYTDdFSmJCT2du?=
 =?utf-8?B?bW1jcjlLT3VPTnhmZ3ZEcWNDMUtXWEhoOFdYaTNqZU84UWNaWkJpdzBPbEFM?=
 =?utf-8?Q?BplsbV8KoNKNWKEmRMd13mqowpqzAR9muVI41?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94a6a5a-7bb0-4d6a-164c-08dedc3416ed
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9199.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:29:01.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAiMwY+TZOVEXEsZdqy0Kl8Iz7CSZJ/7OV5Ueb3/iZQskPLfdaj+V+SRv1AfzUnk7QwIFlniSmEu5eRvwajfFDEWDe0WJ6ce9yemyCpmv5No6P5ia3fX9kTBnsXwLZnW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10786



On 7/7/2026 11:13 AM, Kevin Hao wrote:
> On Mon, Jul 06, 2026 at 04:02:14PM +0200, Christian Taedcke via B4 Relay wrote:
>> From: Christian Taedcke <christian.taedcke@weidmueller.com>
>>
>> gem_shuffle_tx_one_ring() rotates the software TX ring so that the
>> tail sits at index 0 and resets queue->tx_tail to 0, but it never
>> reprograms the hardware transmit buffer queue pointer (TBQP). Other
>> paths that reset tx_tail to the ring base (macb_init_buffers() and
>> macb_tx_error_task()) also reprogram TBQP to queue->tx_ring_dma; this
>> path does not, leaving TBQP pointing at a stale descriptor.
>>
>> gem_shuffle_tx_rings() runs on every link-up from
>> macb_mac_link_up(). After a few link up/down flaps that leave
>> un-completed descriptors in the ring, the stale TBQP keeps pointing at
>> a descriptor whose used bit is set. When TX is re-enabled on link-up,
>> the GEM reads that used descriptor and raises TXUBR. macb_interrupt()
>> schedules the TX NAPI, macb_tx_poll() makes no progress (work_done ==
>> 0) and macb_tx_restart() re-issues TSTART, which makes the controller
>> read the same used descriptor again and re-assert TXUBR. As the MAC
>> interrupt is level-triggered, it never deasserts and one CPU is pegged
>> at 100% in the threaded handler, eventually triggering "sched: RT
>> throttling activated" and a dead network interface.
>>
>> Fix it by reprogramming TBQP to the ring base on every path of
>> gem_shuffle_tx_one_ring() that resets tx_tail to 0, mirroring
>> macb_tx_error_task(). The early return for an already-aligned tail is
>> left untouched as TBQP is already consistent there. This is safe
>> because the shuffle runs from macb_mac_link_up() while TE is still
>> disabled, so the transmitter is halted.
>>
>> Fixes: 881a0263d502 ("net: macb: Shuffle the tx ring before enabling tx")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index fd282a1700fb..b11cb8f068b7 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -820,7 +820,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
>>  	if (!count) {
>>  		queue->tx_head = 0;
>>  		queue->tx_tail = 0;
>> -		goto unlock;
>> +		goto reset_hw_ptr;
>>  	}
>>  
>>  	shift = tail % ring_size;
>> @@ -869,6 +869,13 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
>>  	/* Make descriptor updates visible to hardware */
>>  	wmb();
>>  
>> +reset_hw_ptr:
>> +	/* tx_tail was reset to the ring base, so TBQP must be reprogrammed
>> +	 * to match; otherwise it keeps pointing at a stale descriptor. Safe
>> +	 * to write directly here as TX is still disabled (called from
>> +	 * macb_mac_link_up() before TE is set).
>> +	 */
> 
> Could you elaborate on why we need to reprogram the TBQP here? Based on my
> understanding, the transmit-buffer queue pointer automatically resets to the
> value of TBQP when TX is disabled. The following is quoted from the Zynq
> UltraScale TRM [1]:
>   While transmit is disabled, bit [3] of the network control is
>   set Low, the transmit-buffer queue pointer resets to point to the address indicated by the
>   transmit-buffer queue base address register. Disabling receive does not have the same
>   effect on the receive-buffer queue pointer.
> 
> [1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm

Thanks for the review and the TRM pointer.

I agree that the TRM says the transmit pointer is reset while TE is low. My
question is whether this describes an internal pointer being reloaded from TBQP,
or whether TBQP itself is restored to the original ring base.

I will instrument this on my board and check how TBQP behaves across the link
down/up path.

> 
> Thanks,
> Kevin
> 

Christian

>> +	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
>>  unlock:
>>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>>  }
>>
>> -- 
>> 2.54.0
>>
>>


