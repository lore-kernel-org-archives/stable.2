Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF737204D;
	Mon,  5 Oct 2026 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188402; cv=fail; b=SaQ1+GtDoIM2nUja46W6kaqE4JDvaWg6kjBIzl72GQsKgY7T81sGdliATj1uRCmn/pIhY2nHtJnjGVc85TSqDAw/HfyafO9NM0RJ1iws7qx5s0aO5jIaftdc3N3bIdUirwK4CBtn0lQMTElO2wqjHk4+OxKzI2xUcphn3GdkPx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188402; c=relaxed/simple;
	bh=KiQSGDC5s0wRyW65qbpj83xuSuMv4Vr9cSp0huB0Huo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fs3h9M9Lk38hPdJ+1BhYOOPOkpGqfAIrlgduJk/xj6aHnisMuQAiXvt+gk5Mwz2YBTELgDAe9c8a+ic/eaD57gMNgGU5mKFJ6D7FY7KTZnUh63b6HYxG3Pl2i/t4rfKtE9XXvlsqNcCHDoeNxHMp3QN+gJYu3XmIhrTOg39UV+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=vRHh0dVk; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="vRHh0dVk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFG3SaAFws314xFp9C5xtp2EGHe7CDI7jUDdqfjXig+t1v3+4Azq/vc8ZTuQK/XXBN9lDqqzQiHbHssZTN9xQX27sGNvmYTUx7HEuhfbnGqWj8d+0O4jwOv+XvBD/uEcf51RcCNFUWegcNmzfocApTr2wrfrK3ORWKw1mu/1sXgR8eA5aiZ+k3iM/tdGR9+8PCj5Vb8LzFWQC4frYu9bD2UqvRluoQpOh1mo0TWYS2nBSRMvkzb76QsvzgZJxpZnxhOkAuFQhUryG4W2eIXvYNjntdT1QDkWLNddaiKfmXXDtP+4oyexB4ErOjq/MFqBnDfOjXvj/JUoMHi5ztvi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiQSGDC5s0wRyW65qbpj83xuSuMv4Vr9cSp0huB0Huo=;
 b=LC38DXtkoVw4ppBcv/eHjEvFVtZYGzjVzOsU/PvpVSHNss282VHRcEiVmXNEt2srkGy1FGwwetsvMzucTR7tYoYclZyZfMyf6ChJ+4Jer/l5SFeuuBYml/GWk9a+tAyQY3Zx75JoNzG/+63RlxrsCeN3KVRQwz58kgmyccfBnFzllNVNKKi97dg3bl9rDyDvgJPFyKaOEOUBlNljVR0U8I1RPgVP2zZz1zRJKPr3l+SK3Ne2hnhDSH5fJJ3ug0XQntQR3LQmLO8jX0N4v/1VjXMsifoqoEuCrxlSDxf+GtCFRNQJjrr03YPwnXge3PnI6PX5XnPZcFxDz9+F86+Txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiQSGDC5s0wRyW65qbpj83xuSuMv4Vr9cSp0huB0Huo=;
 b=vRHh0dVkgo1nJ+379H/UZgurp/GdnXdgNZYrIjDfqRpPhNVZczs1Ym+th+P1LzkEP8y62u7wY0FQYAu0iT4Cgngz/sQIYzMQH4DXD4PRxxjTfxCFFZAwTlhWEpvAZTdMvycJ3PRDO4KZ6FiW6OeFxygokfndrp6tPcmIHdsxprk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by SA1PR03MB7122.namprd03.prod.outlook.com (2603:10b6:806:338::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 08:19:57 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%7]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 08:19:57 +0000
Message-ID: <ab077b6a-160f-41a2-a167-813f0560e30d@citrix.com>
Date: Mon, 5 Oct 2026 09:19:50 +0100
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, riel@surriel.com,
 linux-kernel@vger.kernel.org, qi.zheng@linux.dev, nadav.amit@gmail.com,
 thomas.lendacky@amd.com, kernel-team@meta.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, brendan.jackman@linux.dev, jannh@google.com,
 mhklinux@outlook.com, Manali.Shukla@amd.com, mingo@kernel.org,
 stable@vger.kernel.org, toshi.kani@hpe.com, david@kernel.org,
 mikhail.v.gavrilov@gmail.com
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
To: Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
 <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0167.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::18) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|SA1PR03MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e919b7d-31cc-4ddd-93dc-08df22b97165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VIfz5hIXbJz6LQ7D1VBvEi9CxOyw6fa/TZG9UJsGVQ8b3YnMp87IO9qgTsd7RU/h5I86MIP2cFMv1u+6uv4lDZRqG92UEqUK5WGh87Qm85zC5MRFFmN7q8PADOCTLAupq724d+LMAFq0tDk8Ywv6qBcuLHPMwhoPwLTOqSxOsJaAxYAydRNp3yFigxEAuQOf+2OfswYcIYYCIuCOJlFyU4rGCg3NbseJwh2EBLTDNbIBD3n+0lhJ7MJvoaU4ivVjM37ByTXjMmtUxutI2Ow6mLZQnWnqzbMCfAkpPzVdv55ah6e6OW/JAEfLDBVHrGbZFBQ32imk18iErZumxxnURZdj643ksKYbQU1ZT806fE+graCrBnoQ+xbseuFYVp/Vga03owK/W/o7YgVLI5EA1W4HhhlFxvxA/q3OpNXzGgyi1n6sEsTejSINErkOaunhazRrGhXbKEn7/GKbueURbl4j9uA1/9tVrFwxzw5N7T23mXmt8jlYlBxmPSJ8HwMqX3MPNlTzlzCWHD5rH6dvqRh8tx6GXiBg80lZGvMk76px19zTFggZpTBbspW3QZPsXWd4PYPWIQ0uBPdF/1jH5U0Lrep0P87cehYb2mlEea6lAcmiD7yTkWS2pDnoBfja
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUI1aXN1L3VTZGc1L3dlN05oSU1ueXRrQW1qUFdYVzFhUUYwejZUb1RQR01m?=
 =?utf-8?B?SkF0VndPM0RXV09YT2dnM0o2YXk2K01RZk1aNzVaTVNoRXFlOVNsMWxRZXlN?=
 =?utf-8?B?eGpBYzU1VHZ2SnZhU2gxM3REVHFXU2pIeUNKcnpza0xEZjdDUzFvMUxzOGFO?=
 =?utf-8?B?T0tzNzEvRlVsM2JvU1VFNU9yY3hEL2RubHExcGZHcjl6OFlNZjVXME1wNGda?=
 =?utf-8?B?VlF0SXJ2RGozWmZpZjVnZGZlNnV0cCt0U0htek1jVlh4cUNBckdnU3g5Ymh1?=
 =?utf-8?B?eGwrY2FzSXU2ZDQrTVBKMXN4TFVJanJJWS8xdTZ0ZE80ZjBVa3lkSDVyOGJo?=
 =?utf-8?B?UTc1L0JCRmtwU3pGS3Y3Qm93M3FPMlIvdWwwVnpCKzJDZGZjODErK1ppTXhH?=
 =?utf-8?B?OHh1SVBOR0JZTFNHaXRpbXJPUTB4eFdhOEM5T0JLMy9mUTl4MGp1Mm83TGZK?=
 =?utf-8?B?bk1MQ3kxZHhPU1l0NEp2LzN5MkFyUElMZHUvNDgrYlBhZmFwV3V6RGFjR0l3?=
 =?utf-8?B?YmJSZXVqS3MreTVaaGYwUEsvd1g5akRIR21BVXRDclV2ZEpWNkJjaGFwM3Z0?=
 =?utf-8?B?WFFXUUxoYi9FRVJ2dnJPcDZYZkFxWldPT2hRZGtoU2ViYlNKOWtYSHNxTEpo?=
 =?utf-8?B?TVNTalpMcDZGcnh1eVcrWlpVVkhCdmtrZG5KUTVNMUNLdEJ2ayt1NGROY0VT?=
 =?utf-8?B?SSsyOHdjQXY2MGFBZ2hLeVVzMXJ3d2d4UnZxc2YvZGk0MElqUzhlL2tEME1S?=
 =?utf-8?B?YmNxc0tHZFBqdkUvWjhEK3NOUmhnbDNXK01PV3hvaHVGdjJRNHVuSFdDcFcw?=
 =?utf-8?B?OWh5V3FYNnZnZGZQOXMyME9uOGdWbCs2bHorUkRZN284ZjV0LzBJdEQrZlZw?=
 =?utf-8?B?Z2RiTVFYZ09aOHJIUXJtM2NQUFhVMFRIalZaSDhoSXhIeVQ4ZWN4UklVcWVS?=
 =?utf-8?B?RjJzdlJXeHdKditoZllXc1dyVkV1SndycnFSTDZET0gzSGFsaWFrTUZGU0ht?=
 =?utf-8?B?eURDejE3cGtSTytZOTVueUw5bjMyeHE5SW83SG93NC9jME9qRGpyZWJlQS9Z?=
 =?utf-8?B?SHFienhhVDJlZzNaaEtLY2tqeWEvQjIzS2QrSlVpbzduSXd5R1Rvd0dxeExt?=
 =?utf-8?B?aFhQRktzZitQRTZZczJFKzNBc240VTIxWXM1VEZOd1lQako5ZG5XdHp3Wnpm?=
 =?utf-8?B?b3JTSlJXYU9qbFZpWUdrd1o5Qm1xbFNiVCtBYllPQ2h0MzhyR3ZPZVZVaG5L?=
 =?utf-8?B?aUdGRWh1NitVSU1DYXpVOWFmNHA0aS92a3pJTjVqNks5akltOEprQ3AzRVpU?=
 =?utf-8?B?Q2FNNEt6WUQzdGdsYXlJS1F5MXdhMmU5aUlFV2VDVFNYM2hMWXVKMEg2c0xN?=
 =?utf-8?B?d3piYmhSOFVZbXpYWkFpY3VLc0hETy84Qk8wTG9Bbmgxc2FsSnhYVU96SCtY?=
 =?utf-8?B?QThuclZSSW0vUEhvUmQ4UmE3bFhEdEJxUTQycGFGTVBKanY1K29WL2IvbDdy?=
 =?utf-8?B?SFZ6bGRJbmJiM0tDQndHVzNncWhxamg5TkFubDA3a0YrK044cHJtNDA1NEhH?=
 =?utf-8?B?cnEyTzZsbDV5VDZtMUp4VVFwdTNQTUFMOFljVmoveWJ5dmxzYjdneklpNW90?=
 =?utf-8?B?RWhqYUJjdnNvSEJFcGhDa0NscW9xQmdEWHBkcDNQT2x5cU9pSmY2VWJzZGZ0?=
 =?utf-8?B?bElFZUNidFNBSkdrelBVc25aRThlMlFnMVhVeFJYbmtSMjVXQzRIZFlkTER5?=
 =?utf-8?B?RkJlZHZSREZEL2FZOGRCZGtFU1lPaDQ3Y2NacHVubVdtemVjVDVyZG8zQkZH?=
 =?utf-8?B?dE9jNXVaOWNYNDErdDlRcWd0RkJoQUNiS0VBVXJZZlA4RWtiTkNsNE5STjdG?=
 =?utf-8?B?S2tIcWl0VkJkb2c3RFVJVzBnaHdEVWplbDlRL1BVUTV4L2pubVo0aXJqN3pr?=
 =?utf-8?B?TDFMNVk2SCtwU2lWcW9rZGlCQmJMa0FXN2pBWGhPcTluRmNRa0h0L2FBeEJV?=
 =?utf-8?B?R2crdTNJR01yQm9TT3ZjWVBUVEV3VTJpUkZ0YjQ5b29icCtTV1AxdUlTdC81?=
 =?utf-8?B?b3g4T3MvYzVoYWxTc2FtR2dtRE0rWm1odHVRS1Q4TzB1d0xpQ0xYNTg3K0x5?=
 =?utf-8?B?amhESmNJOHhvK2JKVzJBeDFYUVdMREVIcGdIYzEwYUhZZ1k3Y3liQUNxUURY?=
 =?utf-8?B?YXNya2pSQ0NPc1lPbWovV0lnVlVHbTBVcE1id3Nmc2UrRmpydEZsNnlCQndQ?=
 =?utf-8?B?dlQyT3ZDSmR6b0ZDb1prb0J4cTJFTGsxWld2enBPTWYvdHVUbDJxU1RIZUJu?=
 =?utf-8?B?clZudzlTV1FOREw2NWRmeU5DSEpJTkpaNDBXZEFkV3U5c002SDVWQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e919b7d-31cc-4ddd-93dc-08df22b97165
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 08:19:57.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCwa0fsf5X6Fa0If8Lv8Iw8lBn/WddmfGxEc0fRqKommMyTuab8TRgeS6rg3RoLQt+0XGUlv0dUObcPcoGEzGGxujRulo1Mkf9ANoPWlFLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7122

On 05/10/2026 8:29 am, Lance Yang wrote:
>>
>> Did you repro any bug related to this? The functionality is perhaps
>> underspecified in the AMD manual.
>
> TBH, I don't have a reproducer yet. Just LLM stumbled upon this while
> I was investigating another memory corruption issue [1].
>
> [1]
> https://lore.kernel.org/linux-mm/arY1Wq6R9OY20ans@pcnci.linuxbox.cz/#t

What hardware are you running on?

That looks like the Zen5 issue, for which you want either the latest
microcode out of linux-firmware and/or
https://lore.kernel.org/r/20261002211617.1001617-1-bp@kernel.org

TCE is a no-op in Zen1 and later, so unless you're on older hardware, it
won't be that.

~Andrew
