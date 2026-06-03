Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DEF409112;
	Wed,  3 Jun 2026 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476197; cv=fail; b=sOFTn5vqyokUpu97mTw2M/G2BNBtzEew6lrzATOIaT38sC7yLLJ2ujo9mbM2lHzdO3hizFuC5eTAeQ0JoGYrDra7ZfI0KZK6ekPMYQXoqR1vcFyefJSY3dYNIKqyRm5yGz/tZT9eUgHGQUbpAYk0Grh4zbIX4HOsBt4yAj+AJWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476197; c=relaxed/simple;
	bh=4p0Qji9VB4TMniY/JdNzisKEjfVnxyfdqoUFdaRdhqM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XGBbQMrPdpn6IVIkvjLg9pKrzYW62rKpW7n16RZBQruRfHnxP77JeMslkQaBRXzVczK3ZEXjcnXnxSkqCA9YSZMniXck+wfg9hX2CIOxv+f081OWQci3BMSTsx6yvyVf2PFk7s8Wf6tF6D//C7pNlFZKjF9RvheQA2sNVnoPuQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o3O9yHYe; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o3O9yHYe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8rYPgv0RR9j87fsU4AvAWNKzy074ALDyUBZ8cHVOsEDE270A40sV7SnRlgCEBsnVKD7mbzVxWWexk0BDHOahx5NbM75REnoX+HRkkXeQwBakFj9OxraMVVFqKPqanUtqOh+CWpL9WNfhvd8bTMdmN/UPH5WXcOZ85kCE53Jh465lhfsWcPIxVNh7XqUXl2Cy9LWqGj6+chyPwYYjx/Ud2pflWVf0frQO6wtVdr1gnm3F4J9SFD3tCQEtzA800rcPz6Wk0xi8F9E3WJdtd+ojoMcJ5UUDODE/bXrqzmuFQ14X7ZkZ50LvaeM5hY95FJnURPwRQmc+ywjPGyvL+ATOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP8Q+NGZ958OHJkxsdWuGbMBfdm8np4hNh004v6EVh4=;
 b=SalzSOhqEcU+L4shJI6HxAH+kDLmupKL5xBIZA1ZDobeNf86jU+lDJFCtWGRboar92rp5ALmQIr1oC8vXPiQwgP71nEnRf/g2ILssrY+neUd82tVegcixINAGJZwFM5vSU0Kkk/h7ZaXnKTQslH5AQ9UUfNrULale+/o6jmjkB3VqzOlubcPZJrYUZBIXQVokJ8L24K6cYSINaFBa/fGbgynBRnPdxmdIg16sPA7K3xGq5VW19enZrEQnWqSx5UIaTx7/EMwowIvARHM53ftEq+3eOEI10f0kw3rEtslYGs4HLNlxNUaXWERvyTI0PVsu4lBXR20Fpkp9huARdDy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP8Q+NGZ958OHJkxsdWuGbMBfdm8np4hNh004v6EVh4=;
 b=o3O9yHYet6EttUqxIl8GTSB5ORTBhGrybsi9hfpYBTnNn/3No8cuDTFeEuExrGh3x3jNyTjB0dh3HkF5YoAmF2Jwc9H6vGveSvdvXLxKvKCs6Ir4OeUlGxUvoacEoJBPuiSJ8RPE+OpuIAz/LUwChVzy5Zl2rkdBkWY6RWToumw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS5PPF7856D51FE.namprd12.prod.outlook.com (2603:10b6:f:fc00::654) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 08:43:13 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 08:43:13 +0000
Message-ID: <e1b4d2a3-2de9-4bbd-a1c0-a4b1afb17e69@amd.com>
Date: Wed, 3 Jun 2026 10:43:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mtd: rawnand: pl353: Fixes and software ECC support
To: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Andrea Scian <andrea.scian@dave.eu>,
 "Dubakula, Venkatesh" <venkatesh.dubakula@amd.com>
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
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS5PPF7856D51FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b3e86e-0e00-4145-f2b0-08dec14c25c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	cCOyks468X3YwE3TG0nz06dL5p/2n2qsZLAvJ2CxPiqn3nBfzYG8BnFTWGuMjd3cFZRwWxMKJpeaH0qDhvO+wL3ZLyOEaRRtGG68AVLS7H0wm1bBuE6UpUvF/xWBKwtMe0EC06ZQujCQh/n1pkF/mLyeVTi5icj0qHQ6I+Rz3VXycCo6nZStXMKYMyULiruxmNOozOr07Y6Wjt/f8GklmuiCCjYIMgzKC6WeMFRZLasmxf4Hm1Vay2lDO3/zy0hmuqpbHgU/aqE00ybHzu0hGmN2hYpUHj5frT5HuAYSagxB/oqGnOZ7TyNLFHWFEZfBNR+/C5usgPPuA2gR32Wct8V3/7X8+sUTGShd83FnRqO8YWwhiWV4cJCOxa6e3aIVfE8uCfUvCqbTgzAwy/0VH8W8nfhXrO2dKmen1HbLui0dusFiL93xBL4izKm2mVSnRu7TzEx82rWfVvCASIlrSsnhVvbHOaXTHghh1g6F0bdhUTIVoXAK1FbjeL4l3t7nn25M6LFbMy2FWbQe+MrAIfGOZbGlZHF9qxTl0COddOR6cbRaB750Z1jG1o+tTKSkca8kgG04BnD1i/+0U+XmmBr/6hjh9oi5kxzQjSq0TUWBoIctzDzbkH9tR0Xt1ycV78trTfcXCV5G4W4oBT7fgaSI8ReVr2nqM7Ynk3pQ8PHja8sN4g1roy38irAYdeK+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFZaN1dYRE1QeEx3VDRXdHlCQ1NhYmJFRFpYQ2UxR0c5M2I4TzJtMEswMzkw?=
 =?utf-8?B?dmxzM0NsalNUUXNua2ZCWmZCdVk5dlgvcWo3eDgvMEtxZzBpL2s5azRabUs1?=
 =?utf-8?B?aWRFTXdMUTVuMDR1SmIvU3Fwc1FkRnVaUFVMZjBrL0FySWFMengzRnd4ZVpj?=
 =?utf-8?B?TFRnWTB3VEN3K2lwelVnanozVW5GcG4vSEJRVng2VkxvU1RMaTcyNmpWTlRy?=
 =?utf-8?B?YS96WTFIZ0xrcEFSQjNnN20zQ3QyV3QxaVZsaHZiQXJrVnozdlI0MC95NlZt?=
 =?utf-8?B?M2tVb3BoYjFaSk90Z0Z1Z2RFMjAyMFI2VUJGaW4zaXBlRGMzS2xoY0xwc0Nj?=
 =?utf-8?B?WkhMNnFqN3ZTd1JaOEs2OE1SL25ablljZUdPOVRCajhmRkxUUTcwMzMyWGp3?=
 =?utf-8?B?VkI2SE9sVlBzTzI2U25FQWRjWTFwaFdrNVpqWk1WV1N6aGxFRWpxY25WQ3h0?=
 =?utf-8?B?eUpLak0rN0svMTFPazN6QzJRWEZKckZDS2JRbXZMZGUwWXdQUExHOXAxWUdO?=
 =?utf-8?B?S291NDljOGVUdEkvNUY1SkhwV29WcjNCczYxV3ZHZEROaFlVNCtPTUkrV2xG?=
 =?utf-8?B?RjFBTGRhWGF1b2UwVWJFVDdXTCs1cU5aeDErektTQldwY3Y4MEY0aUIwRHFG?=
 =?utf-8?B?cE1TNkZEYnhOTWUrSDlWcFVtMnhqak9qZm5pV28xeHU2anNDUHgzc0NKNHd0?=
 =?utf-8?B?c0Q3dDB4V0pMVW9JQ0Rzem9iaVBtQk81NGFDUGlIaXhSd0swSXZDdTI4R05Q?=
 =?utf-8?B?YiswbDAzRjEweFdsTStqMHAyOHJPYm1xNVJ0ZTREZEdEeXlCQ2VNR1JUcm9l?=
 =?utf-8?B?ZlpUcDZZZytqZ3o1TE1VeEgrZ0liRXl5b0o1Q0x2clZVNWNEZERsTEFDWGFW?=
 =?utf-8?B?bS93L0NBZXZyV2J4UVI1QUlYbm5VZHRJOTNSRlpJKzNjV2hpa2RoS0h0b2or?=
 =?utf-8?B?QjBRTnhNV1htTDNzSmg1V2lySGVsZnJ5c202RGM0WDhkQzVmMTJxZS9qQmVE?=
 =?utf-8?B?UEYrQkc5VERubStuaDl1MnIyQkJVTndtVEh5WldaUzE5MStWbzVpd3NucE0y?=
 =?utf-8?B?YkViY0ZDaHlSOW1hVDVWK05ZdFRtc3FKMERheVY3V2d4MEtkaThUckc3Wm5w?=
 =?utf-8?B?K01EbGtJYUZPU21rN3I4azZPUndvZnZzaWtQVm80QzF2SnJpUlNOMFMxc2sx?=
 =?utf-8?B?UnhOekhIWWxPUitMVXpOd1NnclRyKzZBSDgzNytWcWthaDZuQ1dHZzJEYlJt?=
 =?utf-8?B?dlcyeTQ1eVFETXRSNHJuSTJ4RFNIdnJsc3V4N0JLMmJaQzArNmprUk0vTzJn?=
 =?utf-8?B?ZlhPVzYvRFZmMEFVK0Q0bGlvb0QrbFNIQmN2NXNsZU1vRmtHQU9SREdSbU1L?=
 =?utf-8?B?Q3hBQmxtU3JSMEFWbUN0cm5TcXhZS2tZYmQ4M2gyZDUybldRRXJtN21QMFNJ?=
 =?utf-8?B?Vjgrb25BYXFudWtaV0w3eHgydkY3V1lMSkhUc2E1MVBZV1N6aEdYUnpreU55?=
 =?utf-8?B?dlJuUXBCYjk5VXlZZjlOckxtU2ZrTGJaT3hGU09IVDFhR3V5QzhpREVadDBP?=
 =?utf-8?B?cEVjNGpOVHF4NVRlN01FUmJaeEZ1LythNTBOMFpncEt1WjJJSEExenRVQTRS?=
 =?utf-8?B?Q284anpxNmNnNU5DQ0t0aUwvS0E5Z3BhRWpNajNieUVPVlMvdUxCeDd1c3lW?=
 =?utf-8?B?SCtnRFpSaGdIL0x0dWRBL2tTUXhKb0lDbldxSjNKSVpCMmRtVXdMMmhLSFpS?=
 =?utf-8?B?TndHL05BVTFhbHF5azlnbkhWL21lQTNYaDNGckpWeVVGdnAwUDBRVFJQcS9u?=
 =?utf-8?B?Qm0zUEs5VGdrVThlYnB1dys3UkZGQURDSjg0bDFIYUNYTFFscWZPM2ZlUVhw?=
 =?utf-8?B?clN6bFZyaVc2azJ1MmY1NnJBbXk3MEdTYTNNUHhCV21sV3RiTkVpZGFqalRr?=
 =?utf-8?B?RGJLRFR4MDFybUI0ZDJHU0ZDWmFHWU9jMTlXYndxN1A0YjlCNDZxQXhRZEZK?=
 =?utf-8?B?emRQZ2NRUTFUcWRUalp5YW84RXR6dElaU2F5SHFzVG1BTUFQZFpZMEEwNzVy?=
 =?utf-8?B?YmJGdng1SGJydFo0cWplU21xenV1TSsyclRlWFkyQnpYaTVEdU9GUVB4dUVI?=
 =?utf-8?B?Mm9qRU9RcVRyazFOdmpoeXQ3YmxHOFpHUjdKeUNiQnBYV0tHTzJNaTNFM0po?=
 =?utf-8?B?M1FGYlROS3pha1M0cnhCdHJpUHpQN054RzFEMFA2L3dnb3VjalVXYUFFRytH?=
 =?utf-8?B?NElvczdUNGJIa2hnRys2VjJyaXpBSDJlSXR3SlVOb1J2ck16SWlHWElkWlhv?=
 =?utf-8?B?a2hmN2hPTDNsdC95UWE1czNwNjFqczJpdnVqNnhYWmZDYVFYWGJFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b3e86e-0e00-4145-f2b0-08dec14c25c4
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:43:12.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMZsK+5vRR80sL7f0eeXnfmhYoGqfNyfKCwxXOsnPE01FIvUglrdA8BNFtNQiE+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7856D51FE

Hi Venkatesh,

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

Can you please test this and provide results?

Thanks,
Michal
