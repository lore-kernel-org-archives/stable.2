Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6141DDFA;
	Wed,  2 Sep 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343240; cv=fail; b=QmdcOcZQpBJm0IRCPYsZt5fVuqJwJeqVINCsPp3bT3h28tpmcb2/L/CEdZFRVHNnbQLmwmHMuGT5Mu2AnK0m4/XM0QSF4G7m1WyplGTNGgaB+/ujMFTIgoYOWL8hSeVwK9tSQ8Mxv2dt5F1Z0P2KTz3U7VidWwICWgKywNLKf9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343240; c=relaxed/simple;
	bh=p1IBVH65GAqh9n4XfrLEv9lJZhZANT7r1t/Rq0/G30Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QH+tTxd52IcVKqFOoeHZLH6cgvEVem0Hm2suv3zXUNnxy+YbiPbCSPVdB1ARpNTX+u4qaxrMcm5S2HWTzXTfN4uiRaWp8pGiudQFVujKjDLuiNna15kN3HFx6CG0fihWHeUclwDhPOXtfGI/HfegMLvxDemfRc6fEfTVQFvfjtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GAVMRQ6D; arc=fail smtp.client-ip=52.101.85.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GAVMRQ6D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJwBgJXk/Hp05jXOwlY0v/1Gv8HHoEprCiO6lTADncbrxcWC/4vpJ2TznVBSMFXGRJJvHKmkiGTfvumSiT4Wx/GOgthbpQV7XCJKoVKJ6bkTjWBVgfJkMkbXdDCZkpyySjdoRmrea2945NZecJ7IXlTZXDJ0ngMes9mInhZyJzG4zC6g4tOKiwy28VfXrKHFL2lnRygjN58szpi7vN7mje3fRHoy8af+VZL7QNrUTCgy1Z5r4r06r3+X7zgTHPXkn5Jh5fRdHJjoz5/vC4xmudRLNLfkpEHtd312+Zb2F9bMQ37fPzuZKKDjpDSWbUyBZ5kLB51pewkn2oDBOlJuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIFNRqKXnOZJHzE6OX0NTZjnHdjH4ecpiQl6Sgc9nZM=;
 b=ANipPF1eG35z+vBTWSc+YrdshNJ2xt4o8sBffrSusFk3gq9UHA3JQY3vGQNI8j0HhsdINc8hSbDWDQJ4AEdl8/0+3uxKxnd1bi0Cg8kfr/v557/PYXHM2lPup5xmjEetjD4TQE/AYQ4AId3mOCcf2s6nR3W2pm2w7lreRHLwnNacTNPn2Ol0fcMYX/ye2lJ/5axbHFynxfQgK3sylDjw8YdwFErNfOC51K9Lor+ox/9L3wigcIc+EPoAmZaxc+sjfeY/hmIDmZ1CeILRAGEsr74nPOpSn8SPmO1PrSnBLU8zld7Jbk1ftW2P4er3uor5LV3QvWOnWItPm5Zcd0ZUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIFNRqKXnOZJHzE6OX0NTZjnHdjH4ecpiQl6Sgc9nZM=;
 b=GAVMRQ6D1cgAd+S1G2kn607SLed+0x5d3pX+wHfbhJvZq7kt2nSq65I9lqKHxSXlSHfgtB5yHTswzC/DNtBcfufET5UFQppAPzmddT5cIuz31zScJAlW0M5+tdLYaMc/VdIZBuIfFDA9rTSC/Xo/Glh6+CsMEy/R5VoeFPULVXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:00:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 10:00:31 +0000
Message-ID: <65dc4ca1-6882-490d-baad-3e0abd708af3@amd.com>
Date: Wed, 2 Sep 2026 12:00:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
To: Leon Romanovsky <leon@kernel.org>
Cc: David Hu <dhu@x6u.co>, sumit.semwal@linaro.org, alex@shazbot.org,
 ankita@nvidia.com, chriscli@google.com, david.laight.linux@gmail.com,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, jgg@ziepe.ca,
 jmoroni@google.com, kevin.tian@intel.com, kpberry@google.com,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org, viursachi@google.com,
 xuehaohu@google.com
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
 <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
 <20260902083232.GT24140@unreal>
 <aae19599-2ba8-41fd-b3a9-b1f80107f563@amd.com>
 <20260902095338.GU24140@unreal>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260902095338.GU24140@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:208:32f::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 7568e83e-7d44-4567-eb0d-08df08d9063b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	jcUe6roz4DwyyRo7qAym0hPigAPtavDhyj4P04XRJkRlx1S/Rc/wQj0eAW/0ykPdvOEHji9il/YhsSyN2guS0JC79mKFTr8TqtqhUFTTRUkTPxQRK90N7VMKwyEZw1cH/HxchcQsvtDqZewZdz0y5OcqIsG9qMNqTgu/f7SN0xHh54eESfiC77un1LARbHVgALbK273IVIbh6gU8/fugQlSmENA00xQw0IWQ0Sjc77Bo/RqzMl4duwdLHcnNHiQGs4YKuwVmKVSOjVHKCg2ntzjqEIfUMd0qt2VEgX40mf67EwsNGvy6uW8woPnbl+Z6VY0P5IiJJ4299E4rfNobevR+cJVNr/mMXfq20Br4Rw+utNbTMQaQNnTlBYsb+1WKx/WkWYvBvBs+4uPDpy0J3mp3SW8WefBXWZIeMOZ5e8Cvmnn2uLPcZkNMAKd/A6f2ry7yWxnDjJLa3qwIvtUS6/DKc8X60giJGzPrCN/PCvbLTPFCQq5dRvNQc+J4rEhpHO1CwGzTKxyqxNfMT5H0zXzn0tiXP8HcKrSpBBfHBOyPRd+yxu/uFmt2G7bsTtz/xUY0wntrSxHR03xi0cg/mWFcIv05/On1BEXGu3ox1sYFbFARu0/9mO9MCyKXdQhn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVJpS0tvOGRKUURVaStEaXlxOUdibmdURkZ5M3JxZzdQTmcyOXhhSCt1NlNt?=
 =?utf-8?B?WFBCK3V3M2NIN2ZsM09abkFjRi9BRTZZTXFQNmVOUDdiZmJiRktyUmNIVExW?=
 =?utf-8?B?NEJrSUtGQ1N1Wk1kV3RJTGNNOVNsMFRHU0FVWjBzdkRYWUdBUVc5bUoreG5n?=
 =?utf-8?B?S2FmSzdjaU9wQXhHMDk5dEpTazRvcGtraENUYlBRaFBYUXZjOFhXRlZvU0l4?=
 =?utf-8?B?d1VhUXZJdG5xWE92V3RWUVlwbG5PQzZTenFKK0xvUnFDaUV1MUxML2c3VlpO?=
 =?utf-8?B?RkRpaUcyeUljd2ZuSkxiZ1ZBMWtaa0crdTR2Slp3SHdJUnJkK3VRVWFTMU40?=
 =?utf-8?B?eG91YVVreEU2aTdhZXNCbWo0dHFNclJ1Tzh5eE5iN28wM2tHWVZIM1BSWDVC?=
 =?utf-8?B?UlNKbktiVmpqLzNTSElzWVhEYUVWOVZDNmRMTnNDZnRoTnZuTXQ2c1Arb0ZY?=
 =?utf-8?B?Rm5ZQ0R4aG9qSmk5L282ZFJqaG0vZmo3aFFLaUQxRVFvRTJZclRSbDNTZnFB?=
 =?utf-8?B?OGc2OGo0OTNmZHBxa2VTUTVIcnBhbHhBc25GeEYzNEhFWjIrM1pqdEF5NnR3?=
 =?utf-8?B?WFk3Zld5MjlvU3FCN1VZbThjYnorcndhNFNLSEwrKzRVcTdWZUpXUWYxMjdB?=
 =?utf-8?B?TjZRNXhIZmlGMkRTWi9McVE5MXZlZVBYWXdLWm9KY242UXFtdmFPcTR6Mm5B?=
 =?utf-8?B?czZwM2dNM2IxVFpLR1ZMZjJsQ2loWkJjaklKVmZmS1BqdmtESXUrb0FaRXNZ?=
 =?utf-8?B?dVpaVWs1QmNDaEFReXhTWWRUdkY3S0cyeUp6THJhQmg1bHp3bkJyTXVoaEp4?=
 =?utf-8?B?Q3NKNk5MRVdPeWZpVnNWV2p1cmRXVnZvRE5EaEdSZ1FTMEZudVdrN1pmNzUr?=
 =?utf-8?B?Q0tmaFl0YVYrajdGeVo3djA5aWN5SWNWTGpFcTAvQUlrK0I1WCtOWUE0Mk9m?=
 =?utf-8?B?clAyY3ZWenBUWXJPOXFrYlMzZ25qYkRTZHZjaXdTeHNrQnNlK0RCQ3J3N1pJ?=
 =?utf-8?B?Z3B6SlRUdmNnT2kzVUFUMU1mckl3MGhPeXFoeDYwcStkMDRnUFMzbi80RWhS?=
 =?utf-8?B?bmlycElmNThhUngrRCt3aEgwcGhVN0theEN3TXlQL1E4N1JEeDFIRk5zNHpP?=
 =?utf-8?B?U1d3NnExRk9DR1dDRmpnU2V0T0N1NXVEb2x2bFdjSjVzT2V0UENWV2liYmhN?=
 =?utf-8?B?cUZ4bktOb2t2NmtGWm5ieDYrRXEralVQUW1SYzFkSHd1bzlkY01Jc3UxalJv?=
 =?utf-8?B?ditSNyswZUZEV0V2eFVyVGt6Ui9pcVpMcW4zajVIcHQxRG9RRTRFYnRGTzBi?=
 =?utf-8?B?YzNjT1dKRmxRSXg3MEV3VEN0RlNzREhreHNMTit3a2lmamIvNGZHU3BvVmZ1?=
 =?utf-8?B?UkZCQ0p4ODN2QmwwOGwxUkFtWEZHRHIyZitOVVcwU2pXbTk4UU0yYVp3blla?=
 =?utf-8?B?bkEycjE5UFg2OVdlQm1JOHI2ZlNXMWdsRjlhYmdBc0JPUlNpbnlKbWhjYStX?=
 =?utf-8?B?SVk3ZUhLbTREd2VGM05TUVE5TEhzSk50aVFqdkk3Q3FvNVp4Z3VrVjgzSVk2?=
 =?utf-8?B?LzlJOVJ5eUtVRkNpZmVON2JUb2FGdlMwcHZIUXVlZmtQNEEwVzhKbmowUlVU?=
 =?utf-8?B?VnlXcGNjNVArcS9MdXVCR0xoYUdKTEpNQzFvS21YWkZjTzNXeFM4R2dmeFky?=
 =?utf-8?B?Tkd0bnNna0pBSk54ZkpVK1pCTmRYaEN5cnRHYWNEWnpOZzFDS1h0VW53Z0xN?=
 =?utf-8?B?eVFhZjlDQVZKclFxSFBEWFdYUXlNWC84em83VW13MkFOOXgwNGdEWWdYVjk3?=
 =?utf-8?B?MThXLzNNMUd6d0hrNDdZUjVHMDhhNFFyc2tzMGoxMzZZbmplMGlHanlRY2Zz?=
 =?utf-8?B?bEhIYVpOOXdZU3grZTAvdXRHTFhXbmdoK0pXcm93SHNVc3o3YWVkbXVndmE1?=
 =?utf-8?B?djZOaCtUV2kzbVNaV0xPdkVaTUVWUzAwM2praGtWY3VSVmNyN1d1Y1RhaGZ6?=
 =?utf-8?B?V1FPekFMWU5uWFY1M3ZxeDdWMzhyaFdoeklCbHdIMVJmclQyUFg3aGs4aEpF?=
 =?utf-8?B?Z0pCek0wL0JVRS9TK0ZKbS96U2lUQ3Z0U2R6bkdXUXpwQmZ5MCthczNCekxX?=
 =?utf-8?B?L0dhMlB3TGQzTjJLa1FyL1BKWndta0lPLyt4a1I4NXhTNzQ5MEtvMmp4Tm1s?=
 =?utf-8?B?aWUwa2VjYXRhalVLVlBuRWNMWmc1QWRRdFViQlhUVjVuWjVjY1N6WDFNOFM5?=
 =?utf-8?B?amRHcVdWRjR2ajI0TXRqMkxmQ1BpQjRXd3h6QnRSTEhLMXZCVXNTdWF3ekll?=
 =?utf-8?Q?NU8hc/dCm/WoC9S91V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7568e83e-7d44-4567-eb0d-08df08d9063b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:00:31.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIXPPRdO5+mY8QMcOzABY6Mi2Tt/ov+lFCPu9hL6yzxFsW5AbNnBvKOb1/JW9MaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458

On 9/2/26 11:53, Leon Romanovsky wrote:
> On Wed, Sep 02, 2026 at 10:44:59AM +0200, Christian König wrote:
>> On 9/2/26 10:32, Leon Romanovsky wrote:
>>> On Wed, Sep 02, 2026 at 09:56:06AM +0200, Christian König wrote:
>>>> On 9/2/26 09:39, Leon Romanovsky wrote:
>>>>> On Wed, Sep 02, 2026 at 09:00:46AM +0200, Christian König wrote:
>>>>>> On 9/1/26 19:08, David Hu wrote:
>>>>>>> From: David Hu <xuehaohu@google.com>
>>>>>>>
>>>>>>> This series address two related issues in scatter-gather mapping,
>>>>>>> specifically for the MMIO based dma-buf mapping. The fixes ensure
>>>>>>> sgt mapping is correct, and proper for large MMIO regions.
>>>>>>>
>>>>>>> Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
>>>>>>> (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
>>>>>>> phys vec to sgt)
>>>>>>> https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
>>>>>>>
>>>>>>> Patch 2 Splits sgl by largest page aligned chunk
>>>>>>> (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
>>>>>>> https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/
>>>>>>
>>>>>> *sigh* such issues are exactly the reason why I didn't wanted the dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.
>>>>>
>>>>> And this is why so many in the kernel community want to get rid of SG
>>>>> lists. It would be great if DMA-BUF could also eliminate the need to
>>>>> convert to an SGL, like Jason proposed.
>>>>>
>>>>> The DMA layer no longer needs SGL. These bugs belong to the DMA-BUF layer,
>>>>> which is the one that depends on it.
>>>>
>>>> I'm all fine using an array/xarray of dma_addr_t in DMA-buf, just phys_vec is a clear no-go.
>>>
>>> You are proposing the same thing as an SGL, just in a different format.
>>
>> Yes, because that is the right thing todo as far as I can see.
>>
>>> It does not address the issue that dma_addr_t is expected to hold a DMA
>>> address, while that is not always the case. For example, in the P2P case,
>>> the addresses are not DMA addresses.
>>
>> Yes they are. They must be DMA addresses because that is the only thing the importer needs to do it's DMA.
> 
> They can perform DMA, but that still does not make them suitable for the
> dma_addr_t type. For the PCI_P2PDMA_MAP_BUS_ADDR flow, these addresses
> follow completely different rules: they are not unmapped, require no cache
> synchronization, are valid only for peer access, and require separate error
> handling.

The PCI_P2PDMA_MAP_BUS_ADDR is not supported by DMA-buf and as far as I can see is a complete dead end.

> All of this information is lost if only the dma_addr_t is stored.

Yes and that is fully intentional.

DMA-buf handles that cleanly on the buffer object level and not like PCI_P2PDMA_MAP_BUS_ADDR as a completely broken design on a per address/page basis.

Technical background is that the PCI_P2PDMA_MAP_BUS_ADDR approach can only be handled by a very very small subset of HW.

Regards,
Christian.

> 
>>
>> It can be that those are DMA addresses on private interconnects between devices, but it should *never* be a phys_addr_t because that is limited to the address space the CPU can see.
>>
>>> Jason's proposal:
>>> https://lore.kernel.org/all/0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com/
>>
>> Yeah, I have commented quite a bit on that.
> 
> Right, I posted it for reference.
> 
> Thanks
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Thanks
>>>>
>>>>
>>
>>

