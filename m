Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE631578E;
	Tue, 23 Jun 2026 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197491; cv=fail; b=YOHbDfB8997cusVaH/I3kXnwFBqVHvBcStSnIrQ1mJtB3ix6lfd7K0iIuRF1L7A/dN5lJ5IW8epG/GbEQjInuwzIAz01hWGe3suxfvcRMWOrYkhhfTGOv5wFW447skR0e5Jfz3ZiZ+JfavM64Y+GI9ujdKsySeIP4sO3BAJMeHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197491; c=relaxed/simple;
	bh=Mtu/MItfmCykucqefTJ1EhnKQ2APN6/3f1F6JPz/z6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pc8KX3i70W9Esg/uT1FE5Z5vkQkgQs52St71D46tJF0Tk/7ohuU50gZnSRxKC0vJWzGlJKT084Yot8wANVKgKL9FWeYLm+Jt/y0U9bSMoWGXaTS00l6owPuw6/OBp5UpU75aXvkb9hCLBeykS7eZWj3T4jI2fC79dT+AfMoh5uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wQ1Pbcd+; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wQ1Pbcd+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaLiNLRzUH/3R9OAp2z6OiaBz4AZefhTl8+VvDHvO9roW5USRyCA0QWhj2H03qSl69YZqwZNAy6HBDAgqXixmMkwCb/1kpucf9qKoeDgJ7gP9dgDxUjpar9OzcaNa4x7S0v75Gqfc39izH0IMqes8cfdFkB0nppXnYnPJoIQX9Y63zgddNHrgYTB4pCKKO7La7TMFXup53Ul0rsZHM/glXqN3yXhga+/qGPnIHZ3qEL/DEbKJD6sT2a2CB7YN2fOlHgQ/xkH8wYBGsHuhQsjypfbcDGYaRrERIDV/scJ6Xdm4VwIM/2ttiwjydS/SOk/oD6VzDdPJ9P71Emxrzh8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vMzUSzdPxJruGFl7zA6HeoMhJqRMsj4uAf+iRMoYxs=;
 b=b2uynuGK25/NypL804onXnesjb51XMODk1OFvj6rtQ4LfRrRoAGZPs1iY4dpcP1v0b/YRB8tj6YTUovhs1d+97g1o9Bw/is9ToMTg8XGE99ywGqwHNRop0X3TZo94TpaWZLbpVpOp4HnTMMZgNjNZNqvLsnq/hk1hKpSRM3G5nRzUaYIcRFuMxmMOd4LHqnpGLYcYzhE79RLinhlvhXGf8avkDE+R4Ien4tNbYqDUSYlmHAK1EvEQau+ORont9Zq6GT7/+jJKScOOsDbColajDJWbo0qrTKLeVJn9oaR+RdDWbVcBry+mapGMA5jxXbVdvdPAymy88i1fHPE12bk4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vMzUSzdPxJruGFl7zA6HeoMhJqRMsj4uAf+iRMoYxs=;
 b=wQ1Pbcd+ve7Ux2dwxm/qAnB2yETIINuYVFWvg0WxIAQTvzhVd8JN/6kzcGu+VkYQWFaTJUsT6TcnMD40SyXo/GkO+Qr9d4sPujGxj+UXfhfnle1jEct38Si+iEb1+9DrojYehv6zImRNWAYmZcXDP+tR0mkuZw9IBNvcmLa8L0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 06:51:26 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 06:51:26 +0000
Message-ID: <1468fe23-fb87-4a24-b742-1aa8f989c0aa@amd.com>
Date: Tue, 23 Jun 2026 08:51:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mtd: rawnand: pl353: Fixes and software ECC support
To: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Andrea Scian <andrea.scian@dave.eu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Olivier Sobrie <olivier@sobrie.be>, stable@vger.kernel.org
References: <20260529-dave-upstream-nand-fixes-v1-0-8c72aa23aee2@bootlin.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260529-dave-upstream-nand-fixes-v1-0-8c72aa23aee2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f506ff-5c2c-4f97-ef02-08ded0f3d8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Sy1ZNSVqtftfkLes+BqwGVR9WKVB81F6izEPk/TCYfWeHS29uThPcM23TRGEXMVxhrsofJicQPIXlVaVmCG0mlDQ1G4pb0wqbZQ4GiTOtl3TTOFfqAkGbWv8MdD1klt5UhsZWaowI7OQvJgE/ot895WUDpHcyFVJ/rrwjbK15riFL+YjF7kmbdGM/fCaLIO24bE/QoOSrdTTszOeGWKnj+krJe2ECpAkJAFDHRYHmvX+hJ46eArrec6oi7+Jl0cC/sagZ5DA2V2dIi/1zpnqfvObWzfi2ybWTGjNqPtg5uAJqqPjhenFeJrafeDBcORyoqiv0gBXdM8HHbJcDQg9wz8UD/GuC1FL+EkbB4jLSm3D1kxMZQe6tbthjdmOKJ6O+BNU12tgZhMHvfYcn0tC2V8S8/yUGFgy5W5gd/MZ33jFXMKW6rqWzUj7F5J36BFZ2IlpQNXf2fjW3Kghva9Zs4lkAg+ZCHzKqfS2SIcN2j5Nklzg2UaDFBtaVeQyvGcnKD9VkGw2nU+puopsfyJdU1PMedYEdJxK2nd1eZwM5l2NDsWpRPCUAN1dC91ymlC1r7POAdKCvLKaMhmaTiSFQTZq5sE+Nn4AuAMpUodR6MNzbTIv6YlXOYfTrkv4zGmy35AXIZxGq5FpGHx7sxHTppOba0DpkfskpTS31zbOTRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2RtNExJeFErTU5MQVRWNERNcVVZbnJpb00zOVVZMHJsYnNSUWRVR2NaaENE?=
 =?utf-8?B?OHdjL3NvRHNsNlJaTWUreUxxWGxsemRHNXRVbFVta3JsbXVmN1Npa2FhZWtV?=
 =?utf-8?B?b0x1ODR3TWsrYWhwMGltMSs5aHlpTXlFNGdjQjUwdWVpeldlcmpqZ2pLWHo1?=
 =?utf-8?B?KzA1NWRoa2dKVWdYOTNTYmE0UmVhV2t1QTFmUHhsLytLWWxONzZhVnJjU0FU?=
 =?utf-8?B?VXpISGRWRUtudzhGdFdidEhmTWdycW9OeHJCZjN2ZmF5eWZWTWdoOXdQRUpw?=
 =?utf-8?B?cFlkRDN0OXkzdkUyMzJwNEh2WkR6ZDc2VG5Kd1Izb2paeFdHdGRTUGt3Z1p0?=
 =?utf-8?B?UlQrbmJqdlgxUmZqdUhCQ2k4MW8xQmxCekRVTk0vSlBFNjlHSTdRTWV5UXJ0?=
 =?utf-8?B?TGFyZDVzQS9NOWh5bWR1dklrY0dXOWZIdWZlU3Vzc2xzQmNOK1BQV011a0d3?=
 =?utf-8?B?clNvV2M2ZytsQjkyZVdvakMxbHUzdU5QallnVVZTNDhXRFN3RmRhcERCb3JV?=
 =?utf-8?B?UXNMNjBpVWNYVmFKbDVPWVdCQ2hadlVFWFR0Vmt0dFFYc2R4ZS83OUg2Q29T?=
 =?utf-8?B?UHJWa2dPaGJJSE9JK2I3d0dBQWF2QnJ0bEplalZ2TTZCN2NjTEtGcS9sY2Rh?=
 =?utf-8?B?TDk4L2VJWU90ZmRhOEhSL0dlcExrVzUyaEprVFBuNWRNK3BmWnMwWTZIWjRO?=
 =?utf-8?B?Z2oxNjFZei9FSGVwVHA1b3BVd0daSXJaM2MzSTMzTjNGMmNXNTBXM0ppT1Rw?=
 =?utf-8?B?eEZiZVNOd0RKRCtMOVFhMlBWNWRHMjdDSWQ5WTJaNkZZekM3clRzS3V3L0tF?=
 =?utf-8?B?blFlN1F5K2JhVWNSKzBXMTBoZkk5TXVBRlpab0JJVmNGUUdLQUp6K2lzRmNl?=
 =?utf-8?B?dFlmS2l4STZFdDdMWVhCMzdSejJKbnhIWmVZTW1nUEtsb3hYUm5sVmVBU0Z3?=
 =?utf-8?B?dmJGbFp3VHBMM3pPb05sZGJMYnZ6bk81MTIrSEp1bVo1UDE4NzIyZk1LTmRm?=
 =?utf-8?B?SzFMeDA0d29EZEc3Ly9jUUFjb1FoTTF2SmxyVSs4ekVZNW1HdVlqNnB6KzdP?=
 =?utf-8?B?U3RDWG9wZVowT1lwZ3BCQ0U1ZFVJTVAwK2NBczEvUkV2VVJKRXdTQXZwZU40?=
 =?utf-8?B?cithUktFeitjQzVOdjlvWjJkUU5WWXJkdlA3RHJuSVlwam9WanpxcWlXcHVy?=
 =?utf-8?B?YTdHY1l6VXJiZmZpaEQzZjJtMXBBMmtKanZsL3o3em96dUVMejZ2NldCVTYw?=
 =?utf-8?B?RW5YSGt4UTRTTnh0T0hnejJ3Y2JYV1dRMlBiVWVReW1PNTZWNU1weVBGL2tq?=
 =?utf-8?B?WE1zVDVpT3AyYURWK1A4aXFhWjFjKzFVVTZjY3BtMkcwdXg4Nm9lYWRTS0hK?=
 =?utf-8?B?MHVUejNuUjlTV3oxcHd1SGhHOFBJWk5NdnVYRU91MlF1QVJRTi96a1k4UDhr?=
 =?utf-8?B?NWZyS0xNckVvZThKK3oxOURua21VQjlaYXJ1MzJha1YreThnM3pMU2UxdVky?=
 =?utf-8?B?YVM0WWpYUDI1Z0w4QThPdGxIanJXbzh4RFFOcVM3YmVEaXNWckxrc29oWkNX?=
 =?utf-8?B?WEsvbS9vYkF5V2VlV3k5T1JSZzBhcHdBK0tqeFNhU0hJZDZCUm43SEFEMUw0?=
 =?utf-8?B?bE5adFUrZ2RaaGVjOStjZnlVcHFoME1rdlNOZ0Z1aDVNZFlmNjB1WHRyamlS?=
 =?utf-8?B?MkV0eXorU3NSbDhOTVlpaHgvak82d3RqT2FEeUxYM1VRS1p2bzR5MzV0U0k4?=
 =?utf-8?B?bXkvcUpoMW1NWGJVeVZpaXVsbFNveStSbko5Ri9vL1dzNU10VUtrUEU4dWJ2?=
 =?utf-8?B?cW9rbkZub1lrb015dFVtb0N0d3p6S05SOTVCQkRxckcwQitnZnl3aWhCYlIz?=
 =?utf-8?B?WGl3ZXUvSTQ3Tm5sbEphUlJ5ZUc5Zlp4Q25pOWhNenhMd05KYWxDNkhpdGZK?=
 =?utf-8?B?ZmlLdm51QlRoZGNUbElNSXBoSjBBb0J2SWNGa0NVNlROV1NkeGlzRkVDdk12?=
 =?utf-8?B?SnhYcTAyQWJoQ1lvK2VnTHF5RGdCOWJEc2MxQk9qVmFZNXdZd0xJNEtWaTh6?=
 =?utf-8?B?eFIza241SXpBS05hWGwxdWFxdWVOejVVOGFYdHRVMHJtL0FmaXh5L252NnlX?=
 =?utf-8?B?SW5qS1hIU0EwZWMwZldtL0tkR05oR0toQ1lHVXlWNG5JcXMvdm1pZ2lGaTBj?=
 =?utf-8?B?VWg1TVp5dzdtOE4xKzU5bWxrL0FBQ1V2NjltbUpkazljY1l0SzZzQUhudXFS?=
 =?utf-8?B?OVREOUtPMlhCSktHTitQdldua3kyQWx3K0RJUW93dFp2VENGY1lHVG9ZU3FI?=
 =?utf-8?B?NWQwemlTRGdUeEdaUkJTOWNxWC9rWVVEMEpRU1g0QzJ3aXRpYlVmUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f506ff-5c2c-4f97-ef02-08ded0f3d8da
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:51:26.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAKmU0mF6TDkPlYdKdB5r775JB2lNb5jfiBWxT7ToVAiQ2+9uRB9XkPUeWjn/9h8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356



On 5/29/26 18:29, Miquel Raynal (DAVE) wrote:
> Following the previous reports from Andrea, here are a couple of fixes,
> making sure the software ECC support works flawlessly and is compatible
> with U-Boot.
> 
> Link: https://lore.kernel.org/linux-mtd/MI2P293MB02644DC5515E56A2539C65739765A@MI2P293MB0264.ITAP293.PROD.OUTLOOK.COM/
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> Miquel Raynal (DAVE) (3):
>        mtd: rawnand: pl353: Update timings at the right moment
>        mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses
>        mtd: rawnand: pl353: Fix debug prints
> 
>   drivers/mtd/nand/raw/pl35x-nand-controller.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> ---
> base-commit: 4691d2a70b587e94717820d96a5b55f2b10942b9
> change-id: 20260522-dave-upstream-nand-fixes-5aa6d106e7c3
> 
> Best regards,

got information from our testing team that they can't see any issue with this 
series that's why

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
