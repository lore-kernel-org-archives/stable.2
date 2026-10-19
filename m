Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792433766;
	b=nflj6DMojvtxQOG0ontDogkICxU9goQyVFu9pEUHYPw7fmo9XBvjrWSKSHWJMR5SE9W+
	 /vnPSkJfYpLPXVtW6nrtbjzZMG9VqywxzFVLymhvwm0Aoyb5JBG6SnZ//Aze+PWzZz54S
	 z9U5ir+SjVJ3+vs1IKh3EVpJfKCh5Hmuv9Binnat9pwRmdNtqz/s3Ygur4dcubqMabgAN
	 T1tv1eqM3XdStSKpVbvO0GC5K7flHqpPy5LnUsoxCMnpbgrkPgt52UEErNzSuM9ovY3J7
	 I6oE8KCf1UHMV2beXYfc5bthAog+13JiWErOx7fKJj2BkKL9CiPJ6zmZep/Pvxr9ZXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433766;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:From:
	 Subject:Cc:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=6NAS5FCOe0uWCTOSabYVW2oPkhuozyNObtB4DxBuEUY=;
	b=nrpUW+fW37S9SnWE0wezPo5SQuH+DYGagjnqS/j34uadVzjHvp3S+LA00M27xDWJ1x9O
	 DELhJm6o76YIZwU6BU0oLhvbQBxpe6XGOPYBrigu9NMFpHPaodpJQS+aDn4nWn78owfFD
	 I4eJo4B9uIyUDd1o4sA+zH3KuEA0QXN59axnpNZDLvO2qaoFg7I+tLFA909lB2mb6V854
	 j0R29BIpP7TW31Xh3HrOeuZ1mCVEscZW2CoZfePfDlGolCmsszGo7WwY79FaUQjc6B8W0
	 w4ahKnCcFWXBPHjwjFHcRtk8vJdNhUCnHu6AVplMHDOrb1GyOZK0eMGSKMYF8t7rE7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y1l6nEg0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.14
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012014.outbound.protection.outlook.com [40.107.200.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F9606A31A;
	Mon, 19 Oct 2026 18:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C3F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y1l6nEg0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh4J/5urzbpqLM3GjXqOJ9aqDadUjNmzW+QBC5MZRrbAt244zCZYhJ4jcIhbFubqf+hztYXTn9S82dctXgUt8mBD3T7RZw4QMfGoFvv+hnXqGg4IotPjIMQ34b6U/3LvHXPJOXOnpwtQsjeU0WYSZMuzuHYCptyZWjP8TY6Pb2Ij+j/rmi0zlFdJhvRB2HRfZd/viD3DDoypQh+58nya5tVpE+g2sJKqFHPGXGdWgaNbSUS9vz4b4VJBpLy5AMbTwar9rfXABwwAxnTmXES+iM5RGswX/eANSDo2Q2xpkh0hEBlKlzLeRDjrDgW0Jucw9xNLUXRjHEoZkxa4hw3u/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NAS5FCOe0uWCTOSabYVW2oPkhuozyNObtB4DxBuEUY=;
 b=E3evH32JIruihH1Ep3WVYWL7CvDQ9IvqhKFxGTAYNtni53vK/+ADbMXSTGprX1IzHLISTkaLPto2tImAVJIQOI8zERewSXohvIlWJI5h3mv5tVCTmhUZAVtXFUCOTCGr0mRJUtL4tWnrOEF99neR98s0IrSiLL9vksWPQhU0ueKAVsGko4+DxJovkMoI1brE41S17Z80PA/5f4/ad/k/y5OS2zarOe7wAM7NAYHsLMSsWQ5Y7ErnKx5VOcGGw7D9w8xcK0kiNiwRjd7It2UiNohsx8BzQ8UMKHp1WeblN7AIPOf90F5SV+2okEOPN0DY+mK2QV83YAyekGvJCdcFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NAS5FCOe0uWCTOSabYVW2oPkhuozyNObtB4DxBuEUY=;
 b=Y1l6nEg0OGv/ct0VRRvXuxIWfuXAcYVTh5yeVMR0UDVZAoiNKTiR2iU0K2KlC+TNXfk8QWqdn1CbQLh3LPept+G6TIbcZF9SVyCswlA4KfzuMpWkaJjYpLL+qQ2fhndnhvblaTuCK7eNU+Q385pfH05/IQsnSaMoXCEofeKWytdGBVHJUUO5wpT/+WlEiTOJUoAGfvs5MpybfnqGedS3DKnsIs42qckgSv1BK9yQR7g9VFEXaeCz2qn6lIIht5lMiIpnM+ccq08illX3O7vGGGJxXUE+hNAbOIQXskYlm/Z40dzKflpCS4h0wEGTdgiDVfIvgII/3HoJAcYUamR/FA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Mon, 19 Oct
 2026 18:15:52 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 18:15:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 14:15:50 -0400
Message-Id: <DM90QHKDUUUT.1130I6AKO8LN8@nvidia.com>
To: "Yunhui Cui" <cuiyunhui@bytedance.com>, <paul.walmsley@sifive.com>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <tongtiangen@huawei.com>,
 <akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [RESEND PATCH] riscv: mm: exclude invalid THP PMDs from page
 table check
Cc: <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260523042052.35476-1-cuiyunhui@bytedance.com>
In-Reply-To: <20260523042052.35476-1-cuiyunhui@bytedance.com>
X-ClientProxiedBy: YQBPR0101CA0354.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::11) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f72635f-012f-409c-4c4b-08df2e0d0298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|11063799006|261009223027099003|56012099006|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	UWY1h0y+x9RMWYDP1pGAhB7Q6QN7WyhaN5FVN4KW3Lx5DG2pKAtCeXQkIpv7DLRiH3gAY9DHlRZ12VjMNb5MiguSlUHoUekJ5q6u7wpWAH2rkJ4xgs2JW9nE0K+sPKM7PbuXO8d6zw2HUFAHnQSPNMnaa+RTDRD++oR9E7Ri3foGPo/tl3jCA8i8P0WoGk9WxBHb0MT04rcC53muHPdRMB78x2N4LpsI0Cqd6hDAH2bA2cT+uaaqnrvWO5jBob2w5s0H9cJzPPV2oU18zLw1J+AiL8Auep/5dufxTnDJCaRf5yAgajbAyXjxJ6wMfqr4Y3cMlaNOW6yyVdTvMyGNLsAQI+S2IP6IkeT5Wfb7+fLWZ9Rzd5GRESPPK5devdCHK0js6uyCXb4ABcJs5SkW1sU7I8/z7+COQ7VzvnqBEk3ME6LhBbEU9Ar+WtuIKCP2F8/yqR0CbZTbvu9qsI+pTolc88ZTvBSmShoj9jrFwZuUkGINV+x/WPVaL3fk8j6+gomqpCQET1DPykH54RbWkfJm+fZ3TR8lv6UJCIZmlxrc3BlRW4s8QY5By2fekUHT3s/ZQI77HXvO2zgV35j1dZs3YrJf+xj77YtTuvvHjRmEdJLTNRwRSdiDoQaFMuta7dUjemPl8qqbMLefEmoxmltxzRApwfXF1hqzA8g2kZ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(11063799006)(261009223027099003)(56012099006)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGhBMWV6YkRqR01RRVc5ZGVTT3hMMjlNQzUyblFNL0E3bTg0SmpaSzVjcldC?=
 =?utf-8?B?aUE5ejZIS0lva2RtVUNaU2trUkRidE9GaWNDbUlOLytOdytCcVhqYVduWHpn?=
 =?utf-8?B?RzVaK2VTY3dKUndtZVIyRlRGMXp0c0VCM0tsME02b0tFQVc4NjJaNGRtdFFj?=
 =?utf-8?B?dkRGc25uL3lDWnNFekVlMVVKU09CcUVURkZDTTdEQmducFdYVmdHcWgwNEJ4?=
 =?utf-8?B?cDAycjFuc3Z3RlZSY0VnWXEwQTNEMkI0Vnprd0kyelNJQkxieGZNUDZ4U3dy?=
 =?utf-8?B?bTVLTnhmZ3JkekxZaVN6Q1JDdEpLU3ZrQTVEamZHRGdZNmtxRGR5Qnd6NmIw?=
 =?utf-8?B?WWxTY2tEYlNkd1ZSVWhPN3hWMi9IZEs0MTh5ZDFpODZ3ZURZeGI3YWNkQnRo?=
 =?utf-8?B?ejNTZmMreXprUW0wSmkvZy9JZXd5dFBCRXFnMTZSeThqVUdxclREN0tkTFpk?=
 =?utf-8?B?dTRhSDRISFJ0aU80OTZ5Vk5vSGo0YWNoemdQbG4xWXpJNUdtanhrNUsrczJG?=
 =?utf-8?B?eERtM21CUHNua2pkekwvT01TQ1pGZkxEYnpYMXBuNnY0aG8zZ0tZeGpkWUNE?=
 =?utf-8?B?blhJMThmeEt5ckphakdtcGZ1SzkzaGVXREhHdUEyYWFhbHpVdldNd3gxQ2ln?=
 =?utf-8?B?L3JseFg3TDVyVUJNQW12Nyt0VllURlgrSnVIalpKYzNpOFJrZG15MXZpNXhQ?=
 =?utf-8?B?WWJ2L0w3RFBLdlNyanBRYW1Rejg0UFZFYzNhSmtzL1c0a25iVEJCRHpoeFpX?=
 =?utf-8?B?b2JHSTBkUGFJVGNjeXBuanZOZDdEKzRSN3oxM3BKL3hpVFE3WWROa3hPT3F1?=
 =?utf-8?B?NEdpMk5IRHNFS1N3a2lKWUdrcUNzTzQ0ekUvdnZBSnAwMWVwR2JrRWJKTDhN?=
 =?utf-8?B?T2hXU3dXNDQrU3VBd2VWK2xzcTJTamg3c3o5S3ZtRzZVTU1WUTR4MHdBL2Uv?=
 =?utf-8?B?MnV3U2FqcDBkeThTa21sY2FZYlpQUnRRVkYvTVlmdlJZamNqMzBITmNjU3Nv?=
 =?utf-8?B?Y0Q1eFFtNXpna2llOXYwUGVjdUlDclVXT1BuMWRzb2F2N1FkMDVYaStzN1Uw?=
 =?utf-8?B?enoreHdsYW9pZ1NNbHErTS9WWUtTQXR5SXR3L1Q0MVRyNnBNYnBETllmWWtu?=
 =?utf-8?B?UVpVTjNBZkpLQnNIcXFRUDZmVUNkaUk5M3Rxd0Fqd0xoSFRoQU03QXVBVVFH?=
 =?utf-8?B?VHNkYmxhbWMyU0VTTE9SK3FwT3QwQVdoTXFJT1MwV2tDMjRLWmRPdFo0aVVU?=
 =?utf-8?B?bmxXVHFoZnRaVk5rOFJYMk16L3R1Z0tpUFNpT3dBUUZWdGdXWWgydVB2dnBK?=
 =?utf-8?B?SmZLVEtLaU1PVEdibHVDU1pGM1BwTnBsc1dGRi9tNUpOOElBNUZDWHg0VlFy?=
 =?utf-8?B?ei95dFpuaEFsSkl5VjdLVGJYUEVQTUdQOE13TExMQVlKOHFlb1k4bDVlZ3d4?=
 =?utf-8?B?Mmh0bVlpOUpUb251TnBXSUhqVUUrNE41QzNSUVFUelZzalRmRVZjdWl6Zlg2?=
 =?utf-8?B?cWthVXplc3BLVWFyUmpubjMrTUNYM3JwM0NGOFczTXFjSUN5YkFMYmU0THBW?=
 =?utf-8?B?MFQwR3hNcmcrMTFjRlNOUlBUcHlaZDEyUFhlU3VySFBZRDAvNUpJOWNnNXVG?=
 =?utf-8?B?UURnNHhQVERjN016TE1YNUV3UFJUT0JidWJ2YlpQWTRUdHd5SHpXL1Y1bE1r?=
 =?utf-8?B?eFBaenpRWUxxRHBPbHFoejFPbUNYM1N5bm1xQ3Bmd3EwNlJOU2FqcDhaNVRR?=
 =?utf-8?B?a04vaThacVlqNGZvL293bi83akNWZjUxcGpERVd0alUxY3FpVVJGM3hDMXlN?=
 =?utf-8?B?Q1Y5OFZocGZEVFZhTGFoTzFXRFp3T2tXUU5pa28xeEJpemVYaUplRk91UVhz?=
 =?utf-8?B?U3BJVTk3K2RxYTg3cytFV1R4eDBWdEZteElHZUNKZy8xTC9WejZOUnRudXhJ?=
 =?utf-8?B?Z29kWnMydVdBR1lLNEJjNENxYmczeW9sZGxzWG5hQjJRRnVxaFE5Sk13aVBm?=
 =?utf-8?B?ZVAwaHdIZmVVMTJEejNvVW5RWG9Sd29sNXZYMjZVejBzN1Z0SXQydUhPcEpF?=
 =?utf-8?B?dEpDYmxpT0xqeEo5TjcwRjhWY1ZXczIyR0tXVE5wNXpoNGdraUdxank4L1Ba?=
 =?utf-8?B?bWxmMnhtcVlOb3R6WFY2Z0kvTzcwTWliNnRYbmhUVXlEMDR6VVRISUV5a2lU?=
 =?utf-8?B?U2U0Wk5BQ2p0UTAwSm5YL0xOOGZoY2xoekUwck5VZ25QTGNpL2l4S0JmYmxN?=
 =?utf-8?B?UHppTVFPY1N6MXY1U29ubFFheFM4VWFTNFZnY2d1Y2J2MEMvUU5qUDd0aHNj?=
 =?utf-8?Q?TiQjIyaLkPpWLEv110?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f72635f-012f-409c-4c4b-08df2e0d0298
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 18:15:52.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAUrAM2tPQB5tDZggg4H1xJ4TUcBh5/yx0E5g1xDk574ZL8l+B6ZNLc8MttUrnjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539

On Sat May 23, 2026 at 12:20 AM EDT, Yunhui Cui wrote:
> RISC-V THP splitting uses a temporary invalid PMD state where
> pmd_mkinvalid() clears _PAGE_PRESENT and _PAGE_PROT_NONE but leaves
> _PAGE_LEAF set so the MM code can still recognize the PMD as a THP split
> in-progress entry.
>
> That temporary state no longer describes a user-accessible mapping, but
> page_table_check currently treats it as one because the RISC-V PMD
> user-accessibility test only checks whether the PMD is a leaf and has
> user permissions.
>
> As a result, when a PMD-sized anonymous THP is split during a COW fault,
> page_table_check can account the invalid intermediate PMD as a live PMD
> mapping, and then account the replacement PTE mappings again when the
> split installs the PTE table. This leaves stale PMD accounting behind and
> later triggers page_table_check failures such as a non-zero
> anon_map_count when the folio is freed.
>
> Fix this by tightening pmd_user_accessible_page() so PMD page-table-check
> accounting only considers leaf PMDs that still carry either
> _PAGE_PRESENT or _PAGE_PROT_NONE. This preserves the THP split semantics
> required by the MM code while preventing page_table_check from treating
> invalid split PMDs as live user mappings.
>
> With CONFIG_PAGE_TABLE_CHECK=3Dy and CONFIG_PAGE_TABLE_CHECK_ENFORCED=3Dy=
,
> tools/testing/selftests/mm/cow completes successfully on RISC-V after
> this change.
>
> Fixes: 3fee229a8eb9 ("riscv/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>

When I am fixing inconsistent handling of pmdp_invalidate() issues[1],
this patch caught my attention and helped me fix a similar issue on
powerpc book3s 64bit (patch 1 from [1]).

Acked-by: Zi Yan <ziy@nvidia.com>

[1] https://lore.kernel.org/all/20261015-anon_vma_uaf_fix-v1-0-7b977303b42b=
@nvidia.com/

--=20
Best Regards,
Yan, Zi

