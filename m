Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7833346A08;
	Fri, 10 Jul 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693481; cv=fail; b=Z0Nu6g6vYz6lWZRibq3VYrvrt5c7IlgMeg6/4KVAOyqnTYx/Sv5IOQYLoegRmpAz/K1T/FepdssYnCtxDi9511+LQTQfpOtAEoQ0bLs/vBkNKt/UWrIUBK7l9YqTBv+W9JrxbBbr8B7Z6SBa/w9Pc1FE1sWktO/oSScfHEdXsiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693481; c=relaxed/simple;
	bh=4NByQ1m0aJBkpUMFhGCEAE7Hz13+lhPEOYnnnh80rJw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=acskWyfALLLQXJwqTfe/4Ze2yN0204IFdgeI9nkUTImaxl7Go7TD39z21q94cPBiJNqc6GoW4118OrUswssMdjYp7SDORmRavMSL4dWcqYtv3D7Kab4nuZZus/V/NrLml1cXrwjoby5qHa29XannyH/yJYcFoXmw6vR7qwzCXg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9MsOTjx; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9MsOTjx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783693479; x=1815229479;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4NByQ1m0aJBkpUMFhGCEAE7Hz13+lhPEOYnnnh80rJw=;
  b=L9MsOTjxcjUGRxmtULlDgk9Iwm8twOrGSECzPCDibYKqzX/MQ1CdzhDO
   aS1PZO6q6f9Rwzz4orTyY1Uvz8PbIlQiA3Dj/VN+bbj1iAkqziSNa4I2/
   A4ojAG5hOI+iet9OW/c8D9sRcbDX011S5jyMIgxQy85owLvAsHJbiR3fM
   NJhicvVC+1c2xNC92+VSCum+NGjCDBpmvQK35MVyQQM01751IBluZs559
   W8nMqirsEPd+NRQrUwgJ51XhuTx6mRz9Rq9+iMQXpfds2mmWITeCWtU2a
   NTsR+BrDCTS0f2sVVw0Uk9A841qgMFvGREyyJkrGLRayB9rkzJgRPP5lx
   A==;
X-CSE-ConnectionGUID: PFGebDtdTGK1PXMp/Lr2vA==
X-CSE-MsgGUID: coiRC3WQSRCjdh5TIBTycQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88077860"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88077860"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 07:24:39 -0700
X-CSE-ConnectionGUID: 3KVOH+dCSRi9ob8XzhJ7ew==
X-CSE-MsgGUID: rQt0fzGpTIOy/pisZJl62g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252254272"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 07:24:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 07:24:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 07:24:38 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 07:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQr2s/jywAMBdEkePn7fp0rw1ic6eW0vDMeuUSxBRTZpXIAXvoaDWHD9D5ByYMKy6l1becUp9xr5RbQk7OZvGdKxQgdx6SofgrhN3Bj642RIT/yQuq4KWg+MjaknhEOWKxZpk7hQdHthMkxhffh2593CqztONQfxwUVCKxtOzU4UUZBJGYMwq8oz6wVZEaXEpv+e0nukH4G0HN83l7nY/sF8Vp1F/qybsKlPfXDtZURNaDasAun9ybM0ELZHjlgCvhsXN+i0k81Cn3yNktmI9NQ083c95N1ZVP0cq5TrFRQGIpz8HLG6Ir710QCbsKfojZN/4n5/hBuYuL5Op9G0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTfc9et5wWXFmFPz3JtzR3erwWs9Ibv1M+gB6wZw2Iw=;
 b=VkK3QaO8Ud+k3jy8/lqChpZJFF8aqMF7S2m6HcY96ZyNkvyP7dY3OXOGwnl/RReAAIslhCAm2SBlelvhNliOXH3rg8m9tUTXY4lerRjnBBhW4L97iuM3A5I/gRQiXGd1OG3cyOGOITUM4uwDsHgttpHipaZGHARS0Lt5gSN9jvDm8TjUs2Sl0/hlvYDpvBWHNOFaSJJ6U1o7c1ASSY77Qs5vvECAeotvb6ZXBC5LK+H09Qj4L/YcV1vx0GrqAF77vDvUAwRAt04pFq+wr43m8XRsuzCf2VTbJYVqXHxokPdfuFPbAL3RE4rB1h7lkIQlxONq2RPoPRmPv//tgbYvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 14:24:35 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 14:24:35 +0000
Message-ID: <0f0e1e47-2f96-44cd-9337-c3d910f1e202@intel.com>
Date: Fri, 10 Jul 2026 16:24:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] gve: fix Rx queue stall on alloc failure
To: Harshitha Ramamurthy <hramamurthy@google.com>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <jordanrhee@google.com>, <netdev@vger.kernel.org>,
	<nktgrg@google.com>, <maolson@google.com>, <thostet@google.com>,
	<csully@google.com>, <bcf@google.com>, <maciej.fijalkowski@intel.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Eddie Phillips
	<eddiephillips@google.com>
References: <20260709211906.3322883-1-hramamurthy@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260709211906.3322883-1-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::30) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|BL1PR11MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b88431-36bf-4435-fda3-08dede8ef785
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: Qu0fEvf09fjI6MFB7J1DyHg7ppur+3l8i4WXgfOYczissqEXrvmjU2Ne7d1GsFg2hrXAM5LQkzholT47D9yvGMLMCn0k2iUiV9xYkBVR2ARKituZ11jpBSq3HgltojfrHf3TWo7agYq14arJS4Uaf9sAofoamR7cpQuaTEwZ68LrYl3btL1hF0ylHJfYSuzuNbjGpgAuGRm6CRU+fnBXJ18R7ybV/ArgxGNeAPvHOAQXEIVrOVkz2jizBvODxeu00P9pubeI2A3NRkENX6kTHMuRHnCpCbBVeSbScFeCyUgFh+eZm4dVZP1Gvmzifgs1xQKpqKwKPWNt/PHelztTykZpyj4lp2Zlr4tCen66HpKCDK9roWhmYi6/TrUezG+qRR6MO+DeyZg6xdKjLknW4b/PYIepgbv2u4VXsKG97ZxPV21f5vvgX2UFINSXMH2svr4qMer2ZXJ1LOO42GrJmdUdBzmEAi5XXVHtjHgGIgiewWbQ2xfBVwpCEkaR5Jq3hDx4z+EHQ/AAGhoepotrYRUVGbUFcmdRNXxl8KZL9iVX0T8J4lGQyGL+K1KoOqhqzisJ8b3z8HnMWijB3VE0kyOc/k36/G22yhGHxZka+18Tv/MqOycQnF6SAkr3QFFg8of9kEBUBfOF1tSWPpLqh/WzvWvtv5mW/NodiFgBJHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG8zSkRNMzd4YzJlQjNzTFhOVlBLcnFpNWNObXJyb1Z3NmRjTWVkOU42WVpE?=
 =?utf-8?B?Qm1OQytBM3pYM1psSTR6MVpsckV2SDY3UnErNEc1UVdLT0E4QUpJSnFoUHVa?=
 =?utf-8?B?QXNnMzduakdvVGVMTlFvcTdISGlia0ExczhiaVlyMTdBMnpuNnJUU0RGWnVJ?=
 =?utf-8?B?bzd2T3lrNkE4Q0kreVJuTWhucDVDdC9lYVRncHRwN2R4ZlMwdktuWUhJUThT?=
 =?utf-8?B?Z1ZhZjZMVEtlWGY1azJGSkZ6RnltZS96NkEvNkNkVnJoNUlTQjZYUGFVTklr?=
 =?utf-8?B?aG11eTdETFFKSkU1SHRMR3Q3bGowUE1wcGVTamh6dzMwQ1NUcHBsR0V0UTZo?=
 =?utf-8?B?VzhkdTdybXJjTHl5N2dDSGVqcGVnZGpvalJoNXVCSUhCbHFXRVlHR0FrV2t2?=
 =?utf-8?B?bElKTjJ5bG1HUndiSGJHd3gyLzlMY0dWN0VGQW5DQnpUQ3JSVU9LMUNFSi9i?=
 =?utf-8?B?c01zMEgyaUhJdDFSSFhZOHRuamF2SzNzZ3dqNC8vRmlYNUpWRi9maVZQS0Zn?=
 =?utf-8?B?YjRzYzJlNzFKRTFuNUdqcFhIZ0VSdExLNnlBTzRVV0tSYUpKNFlnSGFYU0Rm?=
 =?utf-8?B?dWRiTm9UejdiVlFsRHlsYXJ5UTR2Sy9hbmIxd29SNVBXNUh6dnU3V1pFLzJP?=
 =?utf-8?B?aEc5RWpHNERuLzF0WTFRY2dSRENBMkFhbDlHNGhpSlpnVDBGeWwwWStjNzM1?=
 =?utf-8?B?MmpjSGJtdXVCR29RVVFDcGtjaUV2NGFjWklnK0ZQMVV3dEFrQThZUW40TmN6?=
 =?utf-8?B?cFBXS3BJS1ZsMWVBUExOd0ZmV0JBN0RUZW15Z2hFSk1TN1pWc0RPY1RmeDFT?=
 =?utf-8?B?Yk9rNE9id2FiNDZ0c3FpNVJnWGI0U3pTd1FneHRXUDFuL1gwaDVLSDIwSGlD?=
 =?utf-8?B?OGVDZ3ZkVThRMnBRZmpDTGxPVFlTVlpPV1MyMkVzdHdOMlpuSXdtMitJemhz?=
 =?utf-8?B?ZzhiZlQwQXI4WkpSNGpldWRuUFFrZjlzOERMcitjVnd3VWdMNXZlWmVITEFr?=
 =?utf-8?B?SXZvS0xqa3JGUERnRFA0Uzd6c05jMkQ4R2xmOWswaHFlWWI4RWc1YkwvY2lK?=
 =?utf-8?B?ZTl0WTNnQmI4MS9UaU1FTGNvenNIZUNMMGxPbFhRV01vVU9UU2ptajNjYmRX?=
 =?utf-8?B?dld5Y29rbHYyVEwvUTlXaVR6bGxxOFQ2a3BtaHBKSkU3eW5xQ3ZCaFRBb1VX?=
 =?utf-8?B?MlIwdm5VODBueFY0SXV0VnV0U3dsUmdpSHIva29KQ0ZRdTd5dFRBODV4Ukh1?=
 =?utf-8?B?Z0FhR0hlSWZuWmRucE1ib1QzYngxWHNRZUpqdzcraDVQNTlUNFhNdHA1aTFQ?=
 =?utf-8?B?NmlaVk8vNEFmUWVDY29NdVZPY0M2bjhheFJEK1AxUWtvVVFUTkxYdlY4bzZE?=
 =?utf-8?B?b2FLR25XNmxxUy9HSExRb0QvTG91R1RlSmd5Vnpmd2JGYUtyeitKL1poS0ox?=
 =?utf-8?B?UStTZFpxWEJRTDdOVzU3dkZaOTQ5ZVpoTTlISkFacE8yVnlJakxaeUtxNlVL?=
 =?utf-8?B?QjJ0MjRyR1dZUThNbmxpZVdaMFF2SUJzSkl0My9rYjMzTGwxVHJxYndjMGdz?=
 =?utf-8?B?UUIxVk5TT3NRQTBwL0lOOFRMQnNaR3RBUFU5Nm5XMW45cUxwWllrSW5UUEpL?=
 =?utf-8?B?RWo5QlkrWjViaTZTNHRWQTlmNGdlN09LUU9VZ1puSTQ0QjBmUlhUNFVMQUNr?=
 =?utf-8?B?cDF4NnZWZnNUYU95ZGtSZytwcEVZWSs2bnRqQ3NvdGF5ckVqLzQrUDJ5ZTcy?=
 =?utf-8?B?Z1hWK1VFcWo4M0txbE5NcUdqa0JiRlVsRklaaWNiMjN3ZVhUOGRXZVBZcHpG?=
 =?utf-8?B?OXFJWTUxWGJVTWFTV0dxYTZSMzBkdDZJVi9BWVVQN0h3bEdWTUJydU5ZTHVr?=
 =?utf-8?B?WEYrWUFTVmVxOTZ2ZWZWMGkwbm9EWkVndDFRNENhOFF0SFZ1ZUYrbjRoNk96?=
 =?utf-8?B?bVVSWW9pSE85SlNBamt4cmhXdXROLytNZTQ2VlU3WlBjbW9oa0E4cnpWME94?=
 =?utf-8?B?Ty9rVUNvWGd3U1JwTkQzUlhYK3RXQ0NQbk9SWkFaVFlPanVtZnZzQmtCekh6?=
 =?utf-8?B?NHBOdTFXSGp3RTFORGcrTjVIU2I0SUpTZzVLMFJRTlNqaVUrSXNkRDRiQjRG?=
 =?utf-8?B?NGRudDVEUXRuTDYwQU9TRStuZzUwRFBxVm5va2wraTR2WlhQZUxLQ3ZHWHpQ?=
 =?utf-8?B?dk13SFRlcmI0ejJuQTY2UGRVMUhLL3hjakpKR1RmckU5Mmp2WWNLS0h6c1JW?=
 =?utf-8?B?VUtBVXlBKzQ3eEhtMlZYWEtoZUFQNnlkS2hFemNNUnU5NkJxVlFzSGhYa3VS?=
 =?utf-8?B?OElMQXFTWHV1c1FqbVVaTEtrQVJTby9wVmd2Q0NHUkQxblpDZDdwODZ4d2l1?=
 =?utf-8?Q?sgAF712txAccvg2c=3D?=
X-Exchange-RoutingPolicyChecked: OOGrFp09938pDCNz+xviyRW53hT61aIc1Q8YCLjdIdSJaI6zfVCgodENsHmJea9QbPYJ/Qy72zKoAIY6L4sWRi2LkDpsKsmSow+LWQPyc1bAFbEIM9KIgfCiye7YwrosY9lFbZ9poTWD9goJ4n69zqj7nIm04u8VfUMT2Hb/+M2iYQMsbKjam5A0nf+o5kL1APZkeq7pFpWRcWSo3ng/VKds+2sCpBVcMJlWzzf+TpwlSt6um5/OdpZipOuxlMqUJnRvKzMSLUJskhXSHPQz3a3GsSMb1YdgZUteBol8//yPBmrKt0xbXn6+S0AV5QzDAoXEfTpRoxZT2Kz25FZzCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b88431-36bf-4435-fda3-08dede8ef785
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:24:35.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/W5Q/XGMpEoykvSX4ocq+UaIpKY9sWHufXTeH61cP9oDkVzCERzS4JbtV7wcgsI3OGRZKfFNLbSJY8EkTyfV2b5/3SCRoOzynngIsuY7Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com


> @@ -400,6 +414,26 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
>   	}
>   
>   	rx->fill_cnt += num_posted;
> +
> +	/* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> +	 * visible to the hardware, the hardware is in danger of starving
> +	 * and cannot trigger interrupts.
> +	 *
> +	 * We use a threshold of 32 because a single maximum-sized RSC
> +	 * packet can consume up to 19 descriptors in the Rx path. Lower
> +	 * thresholds (e.g., 8 or 16) would be unsafe as they could cause
> +	 * the device to drop/stall on a maximum-sized RSC packet.
> +	 *
> +	 * Start the timer to periodically reschedule NAPI and recover.
> +	 */
> +	num_bufs_avail_to_hw =
> +		((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> +		 bufq->head) & bufq->mask;
> +
> +	if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {

nice bit-arith tricks, but perhaps a simpler condiion like:
	if (num_avail_slots + num_posted < GVE_RX_BUF_THRESH_DQO)
would be sufficient?

> +		mod_timer(&rx->starvation_timer,
> +			  jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_MS));
> +	}
>   }
