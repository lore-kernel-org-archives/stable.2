Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794900878;
	b=bH2tKUbm2PQ4xXpZsh/AnOklRlOTYFjvzj+Pt7S/RD+9kkuKLAAytQxFlRdm4XtO0KKu
	 PESV5fRbI/KHxeeuVVvzZOY5qB/LDNTpCGc9HVWAD+BI879/BkwKBN5V2EbjVqvWC07Eh
	 dKBXDfI20KqMRiR7QrImvJrKJDvIKoMN4UgT0MhOBjnzcL4YL/79lFQLYWF6sArdDmZju
	 6IlZc/bOx4A0fTybzOBDEIqisGq3PkldgFpssKc78qmyNAuVzs37N2xuV8oSC3DesBvpu
	 Vm3WqwuL7Nb2Shlt2HqAei9Cn+aEprWkw9dGCh/Oi5kqLQMFACcWf8HAGxbkIJDOZ9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900878;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=3o4c1CPEElcl7F6vuRJpov7E2OiC2FMX4BoyTCVJK6M=;
	b=B6SR3Lk7yZ3R9uKlsMVv3iz3FzzFKvb+kuGxunWsslh10/ZtUAGHGpCuGeqpF94s99pD
	 7cUjSSVJzUW2e7FOhiRFGzE0WJF34QYNSjI7EkAfxk/tAvR71FgzYt5SVpUjE6zVyglSE
	 pUSxZl1PBTtwRNWNg7onnKGXwRMRG6elAn7NZTx2HyhKWW8tYtNqiHGYn0LuljMNv+UgK
	 miPSBsPU7mkUXzYrPGshGcRAU57RKZxbleALDOzAtfyhh161Y54sfdW0gru9MJH2zyqNd
	 Ud7036mrjbKWrKvtVzKEGeBINKipAkVQWpX/XrKEBLsvkhTJRuzFgM8jK057P582mfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PAX3i5p5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.40
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0CC606A31C;
	Tue, 17 Nov 2026 07:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A0CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PAX3i5p5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hG76CR2X0FsEcAA7mr+5wsCOU6urLFWjU32aFcPDoDw58F39i9lbc8Jd8Vt7M+Svvl1365jFpuqj+h5r0UI3drv8o3PWyvMJ53/mNw884dyehQc8f0dQ/SCXHI6sD1QF0dnwcaZe+xx4ZIbKfAlq837aSaNQNbkAqrfQZcxY8lPeJ5GfbiSNNfxwCeovXxRr8rw8OeWAZ7b7IYZG+Df0yrwPWhdQ8FDok5TIU4KnSFzt3XiWZC9RxT5fEmhEpFRl/VAzjIld74f0KITdgYAf6usq4tlYVNq6zPBz1b7mZyhAM7xwPxcPG6FUIKqWb/cuEiM8IkVOW339+doG3Szfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o4c1CPEElcl7F6vuRJpov7E2OiC2FMX4BoyTCVJK6M=;
 b=fsiN3IHuIwa0ZaVOTDbY8g4ZzbUnL47HLug8mhQhuxevetyALxEwkJVF2+YQERy8VX6dQ0Z9izrfVavxhxb2feqX+nzUf0i7Ar1G5Of+EIlRwHCFJzzyXOE7QmIKZMkYDiz6PFHl4pk9H1HsiUTDO7DahvegZQadI4RaaaJBVgT1I+QfN3qDzbLEwAIS09GsFc6Ox8NsNYUIYisPOX34cmDRzKaIfkL4xC3LIavqFv6vcYxWk2dikzgou57sDB6N0wJ0PJBPMZToBF3wBnOICiTprx08J6dvKRdir8AfRHUVT18Qd6IaSJDvIzKoSJv894GXm/vEuUyZCe8p8KU5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o4c1CPEElcl7F6vuRJpov7E2OiC2FMX4BoyTCVJK6M=;
 b=PAX3i5p5+5GEVzt5Ax3wY1oQ+H/Jn/3SS7R+/lDCghizcy6VPkAmEICsSr8uKRtlxkqB7b0oOgm2tVSRaxaTfDaL4Ln0cpOevCGQ0/mn6hMeVSZ+KOvDYmQhyXmqUvjcstD7S5YYhhSIHK8qlPCS0rXYVR2Xudyf3tNg4lpYk/o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Tue, 17 Nov 2026 07:34:35 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 07:34:35 +0000
Message-ID: <82163263-ac33-42e9-86d6-9b1cebd287af@amd.com>
Date: Tue, 17 Nov 2026 13:04:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] dmaengine: ae4dma: Unregister DMA engine in
 ae4_pci_remove()
To: Lee Jones <lee@kernel.org>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Gary R Hook <gary.hook@amd.com>,
 Philipp Stanner <pstanner@redhat.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261111215349.1983909-1-lee@kernel.org>
 <20261111215349.1983909-3-lee@kernel.org>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20261111215349.1983909-3-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0097.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::12) To DS0PR12MB6559.namprd12.prod.outlook.com
 (2603:10b6:8:d1::6)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6559:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 158675f8-c7ce-466f-f24d-08df447d3a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|4143699003|11063799006|261102130727099003|261026121527099003|261026140227099003|10067099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261009221227099003|261009221727099003|261009223327099003|261009223027099003|261009220027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GYb8+ARFEbFWoDdO9RFO2zU9DbKhXVhR3relodhvLt4nYcAbZjoeNsiv3/9taWVQf2BMAZQ8wwliMA2gPPIh5XCfuWa9Nn5mMmsJDPsIqyXVxbwQhG8ldsV+W/rKxnlCq8tqSny8bm3Z3rg0O+1k4e4QZ7wiQKVXnOCop7KOU7xzUq0qQaAbHIxx5UBBx80DP6y7GMtJ6yIHmKFluXR3BBgFz8BJtOtMGWUTbtkq+zN3NwEYEMAVlvJueypBeO/8C7Ape7SCBER6NH0J1NaoLdc9i0Xp+Fit8JNM+71YahqPSwqkDdB8lpC6HR8SYmU0N5VQ0jJ0OgrBD51vO/XBxiQd5Okx0yPHsGKFyDtgXXQDE3UJ6+lZptw5A9aLEg4sjMOk6DjLiGN/YMZRMcw/g8SQZNSkiar5l9FhHDfnLG/0QedJor6drKEYIoCajku/qKAsu4p4Q60SQ/ZDyUEAlDbLL9PAtF+ckF6txSRl8XrH1GGCNED2Ou2d/a5gUsPVSU4dvTvd5uynHyC45yolzR9OGVAdEx0L15L2s9BMx9W18CrOEVo+GtqWLFUYDISxLZBBMfOoacwHB8Crf/utNKrsWNOkU3CHmuT3bIc5+tQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(261102130727099003)(261026121527099003)(261026140227099003)(10067099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009221227099003)(261009221727099003)(261009223327099003)(261009223027099003)(261009220027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDZ0U3hLcTdXeUMxRXZ4WXNJMi9UWVNJZVlPYVJ2UmtndkNMTzBzUERxQ2hG?=
 =?utf-8?B?UmZhRlRRRXV4Z2FlSGYrTkVnVDRMcE1tYi9zY04wblZRZzBYYmFldDJuMVli?=
 =?utf-8?B?bTdrYkNzM3VYbkFMclNPSnh4M21vY0diSWtZTStlNlFaNUFGOU81OVA3RGlw?=
 =?utf-8?B?K052b0psb0lJV2NJcmxRL0l3L0lCY2tqWEJKMXhVbzJOQ0hkMmdiS1NaMW4y?=
 =?utf-8?B?amRCV0JTZkVKbnpPb2h4em5JTlY4clJLVUowWmdWNjY2a0htTXd0WU81VE5W?=
 =?utf-8?B?cEVGS05IWVczMXp0RTNoZmNwcXR1YlJUT2RQVkJ0TTdKK3pSNEgvKzlMeUNF?=
 =?utf-8?B?OFFzbEh0WkVuK0JDYXBtUzhIdGVtaGF4S3VLOEFrM0ZsL3dTNm9BVThDVUlY?=
 =?utf-8?B?Wmg1SVdaT1AwVnFlR2p5OHJUcU9GTWprQ2ZpY3IwQ3Mvb1pQVzR1SDY3Rjcx?=
 =?utf-8?B?M3hVejJOb1pPaGprb1RrU1hiV2JjQjZydmhPU25SY29uOW5TWldpNnliTGc0?=
 =?utf-8?B?ZnkwaGlUbGMreFlCUEp4OVBuckdRb28yRnRYUU9MdURqK21DNmVTbjFZOEpJ?=
 =?utf-8?B?c2FybG45dmFTeWtwVmdDU01SSjE3K2kwcDZ1Vk9na3RrZkdkWC8rbGR4OWZj?=
 =?utf-8?B?dmU2dW85WE13YjBENWZQVWdXdVA3K0FicEY3d3UyNm56L2lVeDFPOHFpaTM2?=
 =?utf-8?B?TCt5ZWMvMmxlR2FpdlZva3RiZURiMkRKQXdrRU11L3FEWHlzZGw0Q3ZwZy9v?=
 =?utf-8?B?eGd5ck9YZVFndDg2Qi9WSk9FTzNKMWI3Rmh6UFBYYnVxeTZKWWFLQ2VUTUNy?=
 =?utf-8?B?NTRBM2F0MFdYMXNFYThsRTNENHVvVHJHNHljbTNma3FsdWZIQ21CVE9BRFF2?=
 =?utf-8?B?OEVSUlF5cmIvMVFVZkV1MWxLWitqdW1DOGlNMEFGUDZlZDV2Vk9KS2RZYThs?=
 =?utf-8?B?TlpkakxtK2tHYWZ4bDJ1d203a0lXcWdQNU9OQnplUXE3c2lGenZKemJrb0My?=
 =?utf-8?B?SE9waExpa2RaenZqT04wejhVeW9HWjZ3bHFyTVplTStRQkhBR2pnbUozU01V?=
 =?utf-8?B?ZWhQRllseVdIUERBRitBTDVDVGlyT0ZPMldDUEF4OU1tYVhaNGJ0U2hHRVNy?=
 =?utf-8?B?eVJ3dUJxTDlPNDJ1NlE2OUk1WmszK1drS3JPb0RueXJKbmFpeXFZNFdjSzZZ?=
 =?utf-8?B?bk53UUdXNzZMVnIyZ1RqcGppS3FlTEJrUEpmZ2phV2FYdGpHNnJPNEc5RVlO?=
 =?utf-8?B?Z3dnV2JNWFdyalkxZE9kR2FxZnlKNnB6Z3RlUjZkZnFmNVJlMk4vM2ZPa09k?=
 =?utf-8?B?ZElXSTk0VDFDL2ZGNnl5TlN1YXFnR0thUURWNG5LNTdZS0d4bVI5K21scStz?=
 =?utf-8?B?STF4a2VHUUxmUzJKMEd0c2RpekxDMVlCYWd3SnZlOUFvMFBxKy8yNG8wTjRF?=
 =?utf-8?B?ZGZlUlJaTHdzbDRkQkNwTVRDRUxiYUxXcXZ4enlqaHpYR3ZSMUZ2QVUrSVVj?=
 =?utf-8?B?UGFxUTJwdmd1RlQzdXZDU0dlWmZGeDRuS1VWczZhVW9VZHc3a1ZzSE1pcDlF?=
 =?utf-8?B?WG43bEJhMkhsazVOSkZ1UzZ3OVc4eEx4bDFIalA4WldlZmNLeGpFbWtlMzZD?=
 =?utf-8?B?SFRaVldpdTRHRmQybDFZSnVWVkYzd2l2QlovN2RBaDRkY1lNcnYzZkF2L1Q4?=
 =?utf-8?B?ZGxQTTRjUllhS3UyNmpoR1F2ZXNoeTBoODdmQ2hHdW1CY3VTOUNOOGNsVnla?=
 =?utf-8?B?RjFCZUJFVGVkZHFUQTdDb09SK1hCcE82UTNmMXhZbUs0SUVSTkNwNzdRSm5I?=
 =?utf-8?B?N1hXTlUrNWZKb1Rkc2dCWENxZXdkU3N5b280d3R1SVNzek9PVlkyS3J6czlw?=
 =?utf-8?B?aWozWTE3R0N4Y2xDMWhZY3hHQm15MDM5Uy9DVHRJd1B6NUtKQ2Y1Wm05ZzZh?=
 =?utf-8?B?ckc1RmpTZFNBSUxYVmFSbU8xWTNKeURSTTE0N0hMdzludlRCMWZaVzVvLzFL?=
 =?utf-8?B?MWp2RE5aYmdEKzhhbllqU0pIZlJkRDVZd05jWGZOUHBHSXVzMEl0SURncE5l?=
 =?utf-8?B?SVZCSHNKUGxKTHNmSGpWcXpML0k2T2JhTHFlYnJsdEpQbWlRbDRNVnNMZmY1?=
 =?utf-8?B?T25zQ1VFMlhmUzRrak5PQlIvazltVlg3YnllNmpzVzBtdHYvZU1mZjdCeXhv?=
 =?utf-8?B?YU94di9UOThLUlhtbzBZeVZUa1ZRVnhlZW9kVzNoSHpiWnh4MTlwRitYRm1v?=
 =?utf-8?B?WVlIWStYK1dBL0ZxcU9KR1dmNCtSM1VlM2FwcGI1TlV0RWdNUVBHeCs1dFpl?=
 =?utf-8?B?WFlwSmZtRUhiR0p6cW05WU56K2FEMDB5TW1vakJvc3Q3QkdTZHdLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158675f8-c7ce-466f-f24d-08df447d3a64
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:34:35.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b6VVwGc+iHDy05I/89dJnE8Vxjc39xJJkamALtfPKXlMMgy+ZbHcFhBIN/y3bP1MDoycTED7c9qu8HOUCwaZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182

Hi,


On 11/12/2026 3:22 AM, Lee Jones wrote:
> [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> ae4_core_init() registers the DMA device and creates the descriptor slab
> cache via pt_dmaengine_register(), but ae4_pci_remove() never calls
> pt_dmaengine_unregister(), leaking the descriptor cache and leaving a
> dangling DMA device registered after device removal.
>
> Export pt_dmaengine_unregister() and call it from ae4_pci_remove().
>
> Fixes: 98f5a4432622 ("dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register")
> Closes: https://sashiko.dev/#/bug/linux-10d41112-e133-4bc5-8e53-b3e96592c70d
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/dma/amd/ae4dma/ae4dma-pci.c     | 1 +
>   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> index 2c63907db228..8712f4f65e28 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> @@ -132,6 +132,7 @@ static void ae4_pci_remove(struct pci_dev *pdev)
>   {
>          struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
>
> +       pt_dmaengine_unregister(&ae4->pt);

The cache must remain valid until completion processing is quiesced.
pt_dmaengine_unregister() currently destroys it before ae4_destroy_work().

However, merely reversing these calls is insufficient: the existing worker
loops indefinitely, so cancel_delayed_work_sync() can hang. We need a
teardown sequence that safely stops DMA/completion activity before
destroying the descriptor cache.

Thanks,
--
Basavaraj

>          ae4_destroy_work(ae4);
>          ae4_deinit(ae4);
>   }
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 628c49ce5de9..22e7b3ae26a1 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -657,3 +657,4 @@ void pt_dmaengine_unregister(struct pt_device *pt)
>
>          kmem_cache_destroy(pt->dma_desc_cache);
>   }
> +EXPORT_SYMBOL_GPL(pt_dmaengine_unregister);
> --
> 2.56.0.567.gdb80ae8cd5-goog
>

