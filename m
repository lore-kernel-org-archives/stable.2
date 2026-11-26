Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795678943;
	b=DRsn4+nk/2Wc/Ty9ManDKr/+4QQsDT8NXMAcvUKA/XmnYehB5Xjfs0vf3KeOJv/55Nl/
	 0xs59EP02XJp7Fl2N6JFF3rqL1JM3CvAaL9fSqDC4utAYJuim5NgYUVNnqqsRWSlHS0Nj
	 ejLN8agCsysdJfplOUJy0eYSyhI+CANIynxD4LEHMOo53kBt0UujxrlRh3ubUU8MMm5Ly
	 xbmM/2xJPqgBl/WM1Ry8QOX03uKX5rscnoe/QyQPP0EEDvn4GNQcA/j48/oa36UHGkVoi
	 L3yBvc/POmv8M4E9ydvkqbPVuEttLMf8q0P7r69fXyO8njnHzntaOuB20e22hmht+8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678943;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DLq1hmRKlsKrNzutbFCaV64yHiU9mrbx+abvlYW2xnU=;
	b=i/aduU3wnJOhQwdD1nEnXLwJawkreCxquHRfnaKm6xcfN0bHxTPzURYL9ajCQLtMMJaJ
	 V9XlCYXR6adc6Jknrp5T0YPHicAm2qkHuFoaL6xhHIv97B9KQs+k0Nlxtug7pi88RY2f9
	 ws+C7N5f7qjABxsIrA9tKeK01RGEyJP1WXns7a8yAOPUVTte9NoPJznBjTZUzKenXHoon
	 3eznZdl4yulNERu931d+dxEIIwq6ZUUgNm/Ub6dzrkrGjqPhj68GIQdRVlfhmJi/vwhyJ
	 gq6TEJfMT8rYZfTyX4b2y/iDznxKhuFtv67/72nP05GCGeJCmEEpZd8tTt65QOmXlLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="CfRDr3s/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.60
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52692606A31C;
	Thu, 26 Nov 2026 07:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52692606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CfRDr3s/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqh+wBplcbb0GN6O+wtfignQS53GjVdzmXjGYx3gQsfFvn4dg9KIu6WHgF5M+j3R2cD9kNEVMCcvRsm6cGoi7VjPbxaLRtFUk+m1ocETcq1GqQX44aw2Ua8JNiSm0wb210HNA8d5W+MbV45AQFH/rAsxV+qU66pRqTDdO2/7vxZOdYFr6QwfBvg+2esHG2tx/yv715ZSIQWEqtaw2IlTBsL7+pniqlS9JDUPf3UBmnRvZxcpcXf0CsxMDE5SNsd87BvKMuifUMWPfUGsduSy9/SwnB4S9MnPXQw2vve3tec8qTsCweeJX8R4n43gAOnsENzpytwJsAE2rYfE4WNguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLq1hmRKlsKrNzutbFCaV64yHiU9mrbx+abvlYW2xnU=;
 b=zH+raYYDSkpKCn6DzIh3NmIxQv10TMDvyaWPYkl+aQLp6UBIhksz3ufeFWiiWEJZvWTXhmBXHF+rhp0Je1Rmy6OIpvehRzZMEuoAI9EW8AiWNGV+bjXgsp0qv70XIdRwkz82fOA+J23n/nCzicanvSbdeo8bAQ2MyHL1iTi0gR3tQStKw0v1eeySbkKgkri6UWHlEaNjUDcVsuZz8CKTFpUfGe/iiVbFtXdDgbtGgtFrXPzUUApxJs+0efDhD86IXlvX5cka9BaS3WTzZK29HSauEs795SsoU/depuMHl4HX1KsTPpdfU8r9ypvywptoJYrOlxexj+XPgMlquk2BwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLq1hmRKlsKrNzutbFCaV64yHiU9mrbx+abvlYW2xnU=;
 b=CfRDr3s/+MMZIptawbQCmJOjticTWUTyk21P1S2gQvdBPhMxHT+tbBFklrPktTO9Wid9gHcqxWcgCXtNBwHU23FWuoteuHavjZFpuiwCplo4awNLSBXldHOlrH07XX2R00HWM8PABGtpMmETK0HWnlrL/Q07NRQTwfx1TFV3oBDTJV7SGbj9o+FBWBayZZ/5bCou8sdLcnwIrMSNSF0d3KIDFuNm8ZTqaZHbdXjC1Uo8b9v7kIGmcHTnykvxHm7eA3zlFNzHnyxmemnQ8iMfT4LaV+FTFK427VVTKjPaUAsGj7H4v6lRqZLc2f/vWK1Lf5SUc2/elQ5w4BRcsLtDVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 07:42:20 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0639.012; Thu, 26 Nov 2026
 07:42:19 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Laxman Dewangan <ldewangan@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Cc: Shardar Shariff Md <smohammed@nvidia.com>,
 Krishna Yarlagadda <kyarlagadda@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject:
 Re: [PATCH 1/2] serial: tegra: Fix overflow in tegra_get_tolerance_rate()
Date: Thu, 26 Nov 2026 16:42:10 +0900
Message-ID: <GC5VPrgKRqiMtmL3TGQ-nA@nvidia.com>
In-Reply-To:
 <20261025-upstream-serial-tegra-overflow-v1-1-267b5b7a79ee@tsv-stahl-riesa.de>
References:
 <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
 <20261025-upstream-serial-tegra-overflow-v1-1-267b5b7a79ee@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: fc623661-a8fc-4c1e-104c-08df4b90ccc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|10070799003|1800799024|376014|10067099003|56012099006|11063799006|261022105027099003|261026121527099003|261028144727099003|261022075727099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009221227099003|261009223027099003|22082099003|18002099003|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	x5fbEWe6IyaTBa9W2nWzF/c/0jMca2SZXLxN9D8Zx03RBjnnpsK1BOBhsYhIpXFR2be6X3YSeugepdFZuyhmckGR+9YIWKQoKqpBlTfl9BHR9TqlVAQJIN/jFivV2LHnXawrnzVWTdPx/gbP1YR/nAFRBX8kfd+1Bt+3+AmUhDZLAZ6OVIHjzybPUKoCs3CyKK8sTrk+Fo2DjcZacB/fJBsFwJ5ZfRN7fciap14jBEOSIuGHgvwMfobSiqXj2FLcfFiOmULjtIXnYNFQlRy46gqk/elMsqOpgCzYgKEZq1U9X/J/6a1ghuCT/g316hncBgGZ4RPC5qKGzgFLm6guaEbhiM07tOa+tJGibFKBh8Ka6CwLXo6ktfVdF9yvmfyU2UYKHyJ24m8herpKFn36i0no8GbjdJiFb+hwUINWB5q3uyLq8IDQcdV0Z/YVjkpeV5RvHeAIQ/BVLFYVvlpCIxUb1MIhCBe6M0NLrlbm0k79UgQwrU5283uZ3Heoyb4SQA9PWG2Qnv3gCLdxvEanJrrGmtP9YlJeLLvPyhYo7whIh3rdVwnxhIcIW8UZ8BHPqVxVP9P4oTgTRX5ECuzHGXbpCB7IyYvInaGBsQ2r26QbgFTCPj6Zj8+KZJs6hi8g0Ovvr5SqE6ExWtbVfozyBFbq5OQurOs0F3FoskBTSXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261028144727099003)(261022075727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2l3ekR2NE1iMVFlN1FZeUJqcU5uUHhuTTBFdjFleFQ3M29PR09HMHdCSSts?=
 =?utf-8?B?UjZVMnI1QU1LTnc2VU1URjduWlZVb1ZVcjRCYUNMN0lxWGUrRUwzYzVXRXZu?=
 =?utf-8?B?TCswbVpQQnUrcitUb0V0dCs4K0dCanpZeUlEejhCUXVuSnR1WGtFRWtpeCtx?=
 =?utf-8?B?T2U4cDJCc3d2VmROQ2tSL1FzS3A0U0hiV2p6NTlEUzlLVnBGbjVrREVNNVRr?=
 =?utf-8?B?bm9VTS9PVjk2ZWZvM0RDYWhVa1BGamtzZm1hdm1YbDkyNWM5T2VkVzZsSUwy?=
 =?utf-8?B?VU4wVW9kb1dBazVtQU9Mc3d0T1Yrb1RydlViWVV6cmVlQkpoMDBHR3pQaU9T?=
 =?utf-8?B?ZHpldXhGdjIyODltUGxRZUZ1a1VPL2tHckNLYmlIZko1NmpDMGMxNW56WXFU?=
 =?utf-8?B?cG0zMFZkeWsyK0p3Qi9pSVRZUnFrTmt6ZHJUd2d3YVlSQXMxVnRkU0xjSnl3?=
 =?utf-8?B?SmpBYTZMaHNzdmpBVGZQWHF6K0JPYlM1RTFzeWgxekJpUkF5YTVEV1dqcU1x?=
 =?utf-8?B?Qnd3aU9aRUtDWk5ObXpsazVCVEZsYVdGaTlhV0JhVzdDU2p4RFRsSnBxRlkw?=
 =?utf-8?B?TUNqMHBuRCtkajZyMS8vV1hlMmY1RWtmRXF2QW91dXMrUzhpc1dPdEQwWEkv?=
 =?utf-8?B?MEZBS2NwR3dDekZrSEdZVFVzcHduVmdtclhjUW1sZGVZc2hwVm5qeStnekNm?=
 =?utf-8?B?dXVzN0x1RlJUYk0vay9XaG1qMEZaOVpQNWhIbmFtQ0dXdkFHN1U0eHUrSldM?=
 =?utf-8?B?a3k0M2xIbzdsdzdMV1YzY25aOEJvdGMxTUwxV0NSYjVaK3NSck01NTBYTm5G?=
 =?utf-8?B?cUxuclVUNytQakgwSUpIZEpxa21tTE5FNlNPMzhyMVQ4Q3lDT2NyMlo5c0ZG?=
 =?utf-8?B?QmRHdUtIenNFZXFVMnkyZHFKWnQ2Z2xiTGZ0a0NFQzI5eUx2K1VZNlFQcDRn?=
 =?utf-8?B?VG5RbVd2QldWWS9uMy9rZWtQVVBCNWZBa0cvd2R6SUtpdUFUZTFCSmhSbUJS?=
 =?utf-8?B?OXJQTElCWitHejVKbGFPZTJZWHBxRXAzb0haYldhb2dXUHlFNTdJRzZheW9n?=
 =?utf-8?B?OU14U21rRUZ2VzBqclpLY3dFVGt6bjJUZHZxU2JKTmR3Q2J1cE5UcEFXcllj?=
 =?utf-8?B?SzJJUkZ1c3FqSUZEZzV0QTVFOHU3b3ZBajhTMWR0SlRWcE9BNmdCQXpOZ1p4?=
 =?utf-8?B?cThkL2VKSjJYTis5amdnTTJ3eXY0NzNMQ1hmOHdNZzdRK1RNOGRWS2ZObVpu?=
 =?utf-8?B?OU9QdEJkclBuVjR3bWFWTUNMRWFQMXJISDZiVUFvUnhBaVFjbHhhUCtoRm85?=
 =?utf-8?B?OGdvSzRYejc3VVJ1Y1VmaDliTDArd2gwaGpObHRpTTJaUHZPS2JHNjhFQzZa?=
 =?utf-8?B?YWlacXNJMDkxZmE3eEhpajBFSVZvbzI5czVzSkl2Wkd6TDZHYUJSWGNsOEQr?=
 =?utf-8?B?Y3pzU0UzY2NlYTgvaThTdFJMUWpFSmdReEdISnNRTmEvL2NDSFY1RTRnRThL?=
 =?utf-8?B?MEJsQldReEN1SGdMU2QweXBZR2MvMk90MjFFeFlrQVdIRWN0VytKRFZ0eFN2?=
 =?utf-8?B?YVV3Vmw3RG10N0paZTJQT2lzUmkyMTBmU1RtdHhZdFg4WlNCeUFXNDM4dVBo?=
 =?utf-8?B?TENEVnJGMVdjcGs5bFNhYjhvall1YzNaeXF5Z1Fxb1BkQ2JKVkg3NXdzYVZS?=
 =?utf-8?B?RkVSbWlkZTJrNDdGNitRSDZKZXhkNjA2NFVuZTJVS2g0TnlDWVZyTTJZYjZO?=
 =?utf-8?B?RGdMY3ZVR1NhdHNmY3ZRa29DUmgreTY1WVJ2dUNSTFBvbWx1SWRIMGhoQTNx?=
 =?utf-8?B?ZGxPbmRHcUgwVVU3K0hEL3BseVVrWDlCRWNQb2lPVC81V3NJTEVJUHA5bUJG?=
 =?utf-8?B?T09DcHUzdmJhZVpTdjZUVEkweGFpN0wraWNaTFYzUmFlcVRyTjNBNlNrSFEz?=
 =?utf-8?B?dmdnVjhMVFhTc0twWTZmVGlmditRUWlRVmJYbHZWajVUSkVxRzg1OEZKRUhy?=
 =?utf-8?B?bmVCY25lRXU2cUdUblAyVWxNcUhpY0ZCekdWdkQ2T2M0MWxEVVRlZWZ5YUVS?=
 =?utf-8?B?aThoS2YvSTdlWk9hc0Z2UHJldzJOdWEyNitoeE8vU2dzamYzZ25TVFNGK1hq?=
 =?utf-8?B?ejdlRkRwcWNXYlZtV1IwUk1JYnIzYWNOR3ZEN2kwQXVicWNkOUxuT0lQSVlV?=
 =?utf-8?B?a0xUWTBnelBMYVh5SnpnR01FQmNSVWNQOVc4cXBWMUZBRUQ2L1RCNHA1MmVC?=
 =?utf-8?B?dUx5UlMxTjdmZkFJajFlVW41ZXVJekhSUTJrNmhOdGpXcWc3TDNYUnBjRDhy?=
 =?utf-8?B?K1lUQjNmRTFuaCtuSXBPL0VYL3N6VmJZNmdtL3BxdWcrbllXdFBWOGhQczU1?=
 =?utf-8?Q?oSJGI1SdDqGXNsyWNBeQEnz6TWbCwJJIz3vCdiCSA3XVZ?=
X-MS-Exchange-AntiSpam-MessageData-1: WYtFlWTFJ17O+g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc623661-a8fc-4c1e-104c-08df4b90ccc3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:42:19.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8F2Dh6bS4sINwBTa7Tj0RCIXTqRYHTQQG4C+aIOs6FEOCB8ScxhqMVq7EJezz2PZSqcsdM2dcE/Q8LpPj06FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

On Monday, October 26, 2026 7:50=E2=80=AFAM Patrick Fischer via B4 Relay wr=
ote:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> tegra_get_tolerance_rate() raises or lowers the UART clock rate by the
> tolerance from "nvidia,adjust-baud-rates", given in units of 0.01 %. It
> calculates rate * tolerance in a long, which is only 32 bits wide on
> 32-bit ARM. With a tolerance of 136 this overflows from a clock rate of
> about 15.8 MHz, i.e. from about 1 Mbaud, and the rate ends up adjusted
> in the wrong direction.
>=20
> The Tegra Note 7 (Tegra114) uses a tolerance of 136 for 1 to 4 Mbaud on
> its Bluetooth UART, as in the downstream device tree. For 3 Mbaud the
> driver asks for 47.79 MHz instead of 48.65 MHz, the clock rounds that
> down to 408 MHz / 9 =3D 45.33 MHz (-5.6 %), and the WL1801 controller
> stops answering after the switch to 3 Mbaud (HCI commands time out
> with -110). The same overflow gives 23.31 MHz instead of 24 MHz at
> 1.5 Mbaud; both rates were confirmed on the device.
>=20
> Do the multiplication in 64 bits. With that the driver asks for
> 48.65 MHz at 3 Mbaud and gets 48.00 MHz.
>=20
> Tested on the Tegra Note 7 with the tolerance of 136: Bluetooth comes
> up at 3 Mbaud, scans and connects to a paired device, and the HCI
> counters show no errors.
>=20
> 64-bit platforms are not affected.
>=20
> Fixes: f04a3cc8d455 ("serial: tegra: add support to adjust baud rate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/tty/serial/serial-tegra.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index b0fc4ae3686f..cc09fbc3aad8 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -18,6 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pagemap.h>
> @@ -368,8 +369,8 @@ static long tegra_get_tolerance_rate(struct tegra_uar=
t_port *tup,
>  	for (i =3D 0; i < tup->n_adjustable_baud_rates; ++i) {
>  		if (baud >=3D tup->baud_tolerance[i].lower_range_baud &&
>  		    baud <=3D tup->baud_tolerance[i].upper_range_baud)
> -			return (rate + (rate *
> -				tup->baud_tolerance[i].tolerance) / 10000);
> +			return rate + div_s64((s64)rate *
> +				tup->baud_tolerance[i].tolerance, 10000);
>  	}
> =20
>  	return rate;
>=20
> --=20
> 2.56.0
>=20
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



