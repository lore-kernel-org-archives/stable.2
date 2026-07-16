Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374A318BA8
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215099; cv=fail; b=W4adpRY7ZEvwSf8w3IOhNxMxUXD+c8Hfe0AgI0CtOHIRriomaCtQ382rCB9HqOXkOCYxkPHjsrLiKayTOZhWGRaQ5HEPdBPGg5f2BrDj5DXqauU/lyui91MiwIAwpRhXdTzlBePq9e2XB4pYJL/KRSkXxSH+Cp9T3n8pAjGVO2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215099; c=relaxed/simple;
	bh=5T38MbBcglniOjVCbW6e9CGZb90deqU1POtyJYEB6ZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ACCbbwp5pSLuDE3j9YzMFXfmQlI577JnidwL3EA924hZeOlBzTRVkieYoM5IEtF8B79sSdw/15mUIEXbSpX39To8tlX/5fBRfdyVQ/MUENsgPUzwRE7gv1Tjhs2rmq2J1C8wJmHt9XL4EOQ2MncdXVSHJYKfWM5cv/Jzn3ClGfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com; spf=pass smtp.mailfrom=criteo.com; dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b=Y/365lsT; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criteo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b="Y/365lsT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ho2vDbY6WBkoPIuobtdYAPh7vc39aibMMWXhzGX0H31EygSJV3ytlKgqlIagwhINz2rOZ77WX7S9hkM+jQOMk4likHeGdY30Jh9KCEgJX1ZFXR+i+nywYXhwT19qtzois9sC1AQ7aCpg7nykfwOPTBk8g7VlFPdVw4RswVOEc/ukoMAedEsFkeFgw4POQwpirjtz80IKnGmbdmbsDyGUp21BzYtvsJPPn1y9hZs27oK3QRKoDyER66Chgl5pgO1rYVXGfltQY+0voSswLLFhTVdU2tdgBle4L1MRR2ibclVvoqn1tgv/56bEbCDbJUUtFivTHQQ5GNAr9xHkIlHHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riIwEXKS11wi6TbhBMlk83lG+Q3qZFy4m6IbJARSXGY=;
 b=xZPmPBldBPD4OHxhQYjFz96fcVTx6myk+uK+1VfFICQZpmWbfBKgO1MWearww4dJgmCQvSYkaiOkYVAOm09SEmljo0RziIDzKvB3cDqDzztXh+BX5lPdHhQt2wD7cl+WiF5+Pzr4ZCegqzovQe7ebyhv9XrrsuAyp1t2839Xp1lq6N+UTQVaezmkH4UIud1LFtkJbJpPh/m+wm/XFzR8rqP+uZI+wR1VypeSGny6PbxfiAXMekpWKx+YBMexM9TxKgNmYQ+GgwvWBWANaX5xG4KbexVLsXQjZLNRWncSK5Srg/YFw9ntmRSJgs5i3Mx+yYmuzg+hzWB/PGR6JKKR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riIwEXKS11wi6TbhBMlk83lG+Q3qZFy4m6IbJARSXGY=;
 b=Y/365lsTzAjm8gv0p6eodC05TUrQLILi7x5uPM+sdlC9XS0bPC+gNmkerBH1YNING8t9cw5hhfWxY2FCaHK1b9+awZ2nr1wfnM/BT1fv4pD9yO6241jXaj9JncWu6TVlr2+3/4rPjJYXlfw/jhE/oxroxvQ94Vhk+LEPI5fNUKrelVlSPscbKbINZqpJESm4CYYHVPU3dOjqP8T7faguKvNuU1ju1gUusk8gOrbKZ7XGRLDu3CSOX9zCI0cUJxCzuxd0Elp4RNZxjj2af1eNk2eMToxEQPKr5G6Jmxe3OVofflqrV26WElpwpTirxbX2Nlv1Kkngfc1aZpjhMF98Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB11017.eurprd04.prod.outlook.com
 (2603:10a6:150:21c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 15:18:12 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 15:18:12 +0000
Message-ID: <028250e8-28a1-44bf-85dc-c74089898a6b@criteo.com>
Date: Thu, 16 Jul 2026 17:18:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: sched/fair: Only update stats for allowed CPUs when looking for
 dst group
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Adam Li <adamli@os.amperecomputing.com>,
 Peter Zijlstra <peterz@infradead.org>, colin.i.king@gmail.com
References: <d4ec6ce9-7c08-4c76-89eb-7bff345d397a@criteo.com>
 <2026071635-goliath-clamp-5cef@gregkh>
Content-Language: en-US
From: Erwan Velu <e.velu@criteo.com>
In-Reply-To: <2026071635-goliath-clamp-5cef@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0503.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::7) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c03d93-ad1f-48de-3fea-08dee34d7341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|56012099006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	43/5ZZ5SGSInw9QTmpSqBtqIKtqaWQPzd9NWuohynr4feppLdNJ14tC6VkPMwL7o1Fj4VYYe02HS/aLNYTb3INIR4e+UJjzy9ntsFbU2gxdx2zL4XeCE54GvCqrAYVaZHTnQX6axPrjgO3FzjlhCKDgmp1v0CqAePcCQ8di72Tf+t0Lufm0hhG8yORL6vmX1zJnlBbo1+MNmwOgWxGAEGzUbnt/xdX4/RYGuUGyG652Xb1zCzUTEHXLfWPx24F6W3I4f7wlUmnwasl8Csl80GO97/LDuJehxnLTReMHWMRizY2s6UKwJHtQxdqUiqW6rqrSq+spoFvWxznC5ZzS7iuKvpeWV4XD6vGcSB691dsXYOISrOWeivt08fxH5HbKqr36V5xC/zmvNxvF8E5ReTcAxVmff3VI7vFyi9FnRci3Z90k1s4+1Afv5Q6B/f0WvXUwZtcLL0qKPc09NpiAeB9SPuCnqzOFX13p3Iw5wPgtFXk1dwK3APAT5vwaZYOEUvesOLvEV6LAXWGJ5IcNPmctilYAARd7l3hahl4GqFnJkrxoIBJa4ujrsebIExRcd+1LE5zrl+aD2wU5mwIQuwclrIKazSMVtukRftvcrfaCJ2um3iOT3rH0ErbgYo/+paiHpe9QUDs1xI5bbzlB6yShN2AG0eu+2SPBvv1hEp1M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVhTMXlONWNKekg2SFY1ZHM1eDBEVmFkTjROd3FuYXZ0WVc3WVNMTFd3YVlt?=
 =?utf-8?B?K0hMWmdvTkR5SW4vUVErZjlWcXFTa1JVTjRtdWJRTlRrdjFSWHNaS0JWV25B?=
 =?utf-8?B?VVhqNGx6VDk3QkhCcmdQdE4vOEtLa0tCcFJreWFZdlU1SG1lYWdJZ3BuTFpr?=
 =?utf-8?B?Y25aaU5nMmRnTmMyOVNEbmRPV2lMRVNCT0I5M05zM0dyZmpFUG9JYVhRVWFI?=
 =?utf-8?B?UUpTV0VlNzFNV0pUTnc2MEVQaTNNZGdLNzlkd2JoWkNvZW9ENEpvcmZkSFkx?=
 =?utf-8?B?SmhJTmV4M0ZCdVpDT3VpN2dnRDQvL3VwQUpGa0Q2eEthdEpVaUZiaEhQdmFD?=
 =?utf-8?B?M3NWSE9HYmFEY1c0d0ozYUZRczhVVnRCZWtCNjBnMWhKS25WeW52ZWp4T3hz?=
 =?utf-8?B?M3hHREluOEZWb1NXYmpXWkNncWZLQW1MbGdGL1FnV2lYNDFPNmxTaVlQckVG?=
 =?utf-8?B?NE45dy9YT1JsQXJocTlwMXVVcm1LY1g5R29hVGt6aEdnNlhqUjhZRm0yLzlm?=
 =?utf-8?B?Z1ZFSG84ZFlzNEcwSjlCbCtza1IxUHBEeGlBcUsyeWJiQlhJdDd4bEcwTkVv?=
 =?utf-8?B?YmpIRml6bzBYSjZHYXJyTThmRXh0aFZMZkYwOHJ4eC80aURiaHRhUEJaNTV3?=
 =?utf-8?B?Znhoay9EaE9LSWJqcGl3WHUzQnYrcUlLV3BERWFwSnorM290cHBEL210cmtk?=
 =?utf-8?B?T1JJNUFOYVRxYW9JUW1UUmZYRXpBd093Sm1Qa1dNT1pNM1ozZXIxSC8rOVA1?=
 =?utf-8?B?MzNvNFdwbzA5V3h2U0Fwc2l6THJzempldnZYRkVHNWEwUjR2WWdRMnhCRGNy?=
 =?utf-8?B?THc2d3k5MHB6eGc4enJKdjA5aDlaRVVoUm1pa2dqUHB3QzBXT3owVWRYck5R?=
 =?utf-8?B?dDNNRFpUeUN5YUNpK0tQei9vblovZVhlRDdmZDJyaHpVd0ZFSkJZOWs2YTNa?=
 =?utf-8?B?YmtwYWREckNyajJBdWFSa0FzSXR1MzJPTjVBcS9oU3F5bDZqM3d3ZDZXWFU5?=
 =?utf-8?B?THN2OGR0WEQvQmNxVzQyM1RMdGw3dTJsUlpWVi9jZ1JwMksrWVV1V2l6cGxO?=
 =?utf-8?B?QmRQTUVFSHpSOXdseDhuQzF0Yi9mZktBQ0c3MG1RaUNHb0RlVFpXeVhkVkNP?=
 =?utf-8?B?RGUrT05nOTJETGZpYTZUL1NkY1ljT2FmQ1pLNnFlVmNkYmI0cGZJZ0hYZEth?=
 =?utf-8?B?ZXhIYWU5bTVFL1pFZmVXVWQ0RmZPWitXcHJuSFVGbnI3RTcvZHlYZUN0ZjVz?=
 =?utf-8?B?ei80TDV0MU5wQmpmTHBiL2Vlai90SlhYb1RxMGlxS3lkVGJIbkxLRUNIWENt?=
 =?utf-8?B?R3J0UzRjQVBhcS9VNXkzTDhDN1F1di9jbVp1YVlKMzVQS0dmMEs3RVZaVWdO?=
 =?utf-8?B?VVhmYW5wYStlbnFncUxnbnFCOGFOdFdncEJRa0d5NXA2eHJVeXdjNkk0R1F5?=
 =?utf-8?B?Q2IvZ0k4UTFMOUxoOW5mTFpyYko4dU16MGkvaWdRN0wzSFhSTXhXUVc5dm96?=
 =?utf-8?B?TDYwRE44VGdxRFMvckxuVXJTaVpiWkU4Ui9UeFo5WWMwaVd6Z0pkVXFhS1lT?=
 =?utf-8?B?b0ZnT3dRZThBMXk2WXdYZ2hRbmM0eEtITlkxeVNablhwQ1YvSzNUY2I0Qnpm?=
 =?utf-8?B?ZUg2UFk5NHJSWGJKeWwvVnh6REthSWZyS1NvdkNKMEhRUFBHVStsK05VUGl6?=
 =?utf-8?B?L2cxWEtkTWMxNVFiMWdaaVlpejlkT09Fbms4V1dEMUxKZW9heStDdDU0a3dr?=
 =?utf-8?B?VkdERE5GcjNTbVRSMXVFT3g2SUVaa3lzRUpxNjFjamJhY2h0UDFzR0pEeFFa?=
 =?utf-8?B?amtBdUVFOGdlZ29OeXZDQ0ZESWFCR1V1TDZkeFAwZHcxR084S2x3ZVRGcEla?=
 =?utf-8?B?NUFXZjA5YkRXUUlCazVLeG55NlNXQXAwWERKK0pFRFdNazlYU2x3dTdtVFY0?=
 =?utf-8?B?NlIxNXJoZ1ZXSUc3NG14MGdtam9WT090SFM2L2tMcTR6ZFBMOHZoV1ZVeG5K?=
 =?utf-8?B?dHJmMkRhc1lEb0szREhwNmplTnY5cVB4TE9Ta2dnSVhETVkxMEhkWkNGYW1y?=
 =?utf-8?B?NkhBMzUvQXZVRFU3REY5Q0JKWnRMNFFEKzA2TUtLKzJVdVg4TS93eTNGRllj?=
 =?utf-8?B?cnlQWExDRnl5UVpDQkZJWXNHSUVlQVN5YXptQ0ErSmI1SFc3VGVMNDIyQUpQ?=
 =?utf-8?B?RXVvcVgwRXJBTW85MlpseXk5QjJPTnpaYUN6SmRjSVVJbEc4SGFMam5MSkZD?=
 =?utf-8?B?R1h2ckZxUmMzd1ZYckg4Qi8xZm1weGMyUkluSnZ4Q2lPK0E4cVJQRUphOFZ4?=
 =?utf-8?B?RkFxa3pHRE5Ga01SY09vd21jdlJETlpuNVBzOThvMWhhWjF4cm5zUT09?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c03d93-ad1f-48de-3fea-08dee34d7341
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:18:12.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvYayBU6uUkjHJ9l82aWTH8SG8t5gooUHavJ1Z0qIwQ5+14FkODhDwbWn8+fHslZnKwOF78xrEWTJ3XU/q+Qag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017


On 7/16/26 15:12, Greg KH wrote:
> On Wed, Jul 15, 2026 at 04:29:09PM +0200, Erwan Velu wrote:
>> Please backport commit 82d6e01a0699800efd8b048eb584c907ccb47b7a, introduced
>> in 6.19 as all stable kernels are affected by a significant performance
>> issue.
> Now applied to the 6.18.y tree, thanks.
>
Hey,

Any idea why it is not cherry-picked for 6.12, 6.6, 6.1, 5.15, 5.10  
while the patch applies perfectly ?

Will it be cherry-picked for the -rc2 ?

Thanks,

Erwan,

