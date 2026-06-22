Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8DF349CFD;
	Mon, 22 Jun 2026 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157480; cv=fail; b=MFi1ZixHTR0FC1Fd36x1JLOukWXa5XoOs7zBYBujFbGOSfcTq5sOMqUm5v9fwgUnuWu9bA0LWzJhVTMdZZ+UrRXr4HHYBz2WLgDdE6aTBiIj3GDhTxWZiuifl+9q1x5Rd0PHOMF5GqgV0vfqBjqQ+AxOFTHaDJ52cMefNtfgHg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157480; c=relaxed/simple;
	bh=M4xEzD5xYvtV0E/DJeuD/yrD2kdo4c/7TVMhNE1jUtc=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=ksyYhlQXd6JA0SaoK+toZTIShSELl7fqig/BTVJIRzvRWCcsZlcGSGUB0nntre/nqVDGVGyr8uK+AHPrx/x2jVHIp00I32h8kzl7f9Pj/b8jbCNNemtGd3jCW5fG9XC/MggC5ESyCPmBoDIFtwvYll8OM6Ik0mngKsiPiLtcLyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fRhYUEeQ; arc=fail smtp.client-ip=52.101.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fRhYUEeQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1+hpoMCE7Ik+GXJYwmDLd+i8WeoqBl4HTeWVyQ7bRNh2iWIZQTpGpunUEZfsEiU+29N+h2kfgLBUV1UIC/OUXg8x5djF0wejvaKnQJWGWvhF11OMNC0gi9FUPDrkqUvPE1hiLsEuhwyxl1aICz9k26gKxlys2UoIzxYwwJeFV7bQGvS3ev2IfkxS0rk3dGaigSHwSMmU357G/cma1Y09gCx4SDTLdUidh/1EuZpLsOrjDadE7TqsixKBpxqNa3JGa8W0c+13b+G1yoknHHo5Fqlb2+HDoEPR8r7PW12C3hegCYhYJbT1qFvHoK6FC42zLH0X6M2e0jSaZlC74Lo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcxLdbg2wMfcO5DViw194V286oVJ72doKU4pBCzXZaI=;
 b=OnSaTxP/S3rfbKfqBSCWGdvKtMkY35vOlgEUTMigFbpA4RxevTmqrGxMZawNp6ESynnr6K8wzeCbV7IevaOo1YL78V3xV8bfsxS4xXaP5vM6FgWb/y/BM6q9k23t6gei5yvK9HiicpNxBqSlY/1tl+HzP5qH4VMhhhoU5UvlfBwWeDOY1FwaUPpF3gabNkucVvHw8xUfhGW/nVO1PwLZLNBN7UPpGjLD0rmNQaFLlzQmvi9M/O/K57XXwuioASiHi498OOVE9pPtOs2/0q1fcr7WFoFmyC+CHn+bAAQVW+yOIsjsVPmUa0f1TqQKPdv61n1GEbXxEomLXlzt3xbFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcxLdbg2wMfcO5DViw194V286oVJ72doKU4pBCzXZaI=;
 b=fRhYUEeQf2G1jIffEBcGxT6Q68DgMo/9qv67il4rEtCiu9hl4XRXOtX1mg8Zm3G3qaL8no0cVNLqvYPYGkogABUW68ZnG3HC1uPLm7QdqysMDYYwerNY+cipaTyq0KccqKWzX8UgS8IzzjnIOWUP3YVX+paTss9qtSOzYvWPcrHYwLUu/nFlBSkQnCxL1OSaTde5OMwKbBh9J+w9izjpFTrLL5ZzSj2Do9yg8ROWYRwjpcf7FpxyoCGcmeTo7C47otsZ2Rjjr8F+gwckwaE7AWhTz+k10pfh5Ow6d0O8adL9x2c2Edz3cPyEnWRAfYxKS4N707gVf6HSal9bn28nIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 19:44:33 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 19:44:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 15:44:32 -0400
Message-Id: <DJFU3KAWA9Q0.7PMOHCSBGIIF@nvidia.com>
Cc: <kernel@oss.qualcomm.com>, <stable@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Matthew Wilcox"
 <willy@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>
To: "Ketan" <ketan.kishore@oss.qualcomm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <jackmanb@google.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Luiz Capitulino" <luizcap@redhat.com>, "David
 Hildenbrand" <david@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v2] mm: page_ext: add count limit to page_ext_iter_next
 to prevent invalid PFN access
X-Mailer: aerc 0.21.0
References: <20260622-page_ext-v2-1-135d4cfbc42f@oss.qualcomm.com>
In-Reply-To: <20260622-page_ext-v2-1-135d4cfbc42f@oss.qualcomm.com>
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: f5eaceaf-5f96-4e02-ca49-08ded096aecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P7NbJ0X5e8nxs8Hr9Epmqa926ISX0lLn3IbwHVyszXrzOIWv8KbUNNOImqESwaBN+7nganm0xMSVsNUAOOO45Xns1Kchqa1Qgd+n/F5j+DDhopVxHG6lhKytro0bkyKp+rueHkqsFhqOmNNdkPH1TyPmdO5QPDabd5KvB3XwZc/xfigaHSDBBDsBmAoOviugH/fbIOinAWm6jUgieHTXVBP5UuQmvwrDwzU6qJKdZQtNKi9QUO2fOJoCGmX/uaR/+47/n5sSp3/Ltcu3RvirpTPMGSPMfIKopVImldQpu/6DTbaTCr07tcimhMrvTaYkZ6uDmyNW/h1mG2ODDdcoQ4Be/yT/VZDvab1U77P4xRkO/ETQrWYjBZwFSiv978gImGKDo2ekGIyPgKz485GKEL3oQRKAL/vOS212QK9S986ytWrlYImvo/jcTfJS5liPIfL9xgBB8BW07IX1YHmxCzIlbez9ydRJ8qmXx5MUqEFPKmsKaoh2NiQic0SyClxs8OrdBUnroATCLlwuSAJq0y/HSPEw4oHuZRwnvzL3kdASHYR8trH7FuYC2OmCmhc+wyQjHjO/xcqOiLKCEiY4DdBBhdTJIo9tl4kCrGj9nIzu0l7co/kPuqut9lRTybmgq1AhCaapqBedY0haIcvGSkuObVa1Za9dEC0CrCozzHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTYzQzJwamZ6TTcrRmcyNTVzYTV3QTNwSko0OU9XWVF6Z0N4aHFNcElWLzV3?=
 =?utf-8?B?VENLZkltTWg0S0t1OWlOM3NZNnJhUW5pcGJUZ0pnUjJ5YXp5c1VGZTNiNWJT?=
 =?utf-8?B?dDdybHU2d2ZoVkpvQVVCaGhMRUVNMnBFbk9CcGdQNTVjMWt1OU92TkFjbDYr?=
 =?utf-8?B?M0FuQ1hFNlU3VzcxM3hGQWNpNTRqeVc4YUIwR2hCTy9SODVMWTVHU0tWNHJJ?=
 =?utf-8?B?dW5RVjlrbDRibCtBMzJyNngyK1JremVuK1pQTnZ6VTFKTHlIK3A1RGJLQnFh?=
 =?utf-8?B?VEtCaFVLZ0tsQlBqUWJRTkJ5RmIxMlFEWVEwNEdCdFRGcFk4WGZsNjkwaVg3?=
 =?utf-8?B?Z2lmd3lrWXNlc25TMmlNUjJURmVDL0ZlY1FRWUFWaWpWUUJ5bEU1OUFOMS9q?=
 =?utf-8?B?N25kdktLa2N6Z0x1RkdoZDhYWDlEN2JmcCsybGx6TEFmdW0vZTBSTzdZNTBO?=
 =?utf-8?B?SHB6azBnN09JbjE2b0NCK1JTYll5cUM4Q2tRS25CaGo3S1MxTm1VOXJ6M2JV?=
 =?utf-8?B?WXV3LytmVmlIUlpmcTVvSWJ6RVNZTFhpcjNQbVVGcndINU5nTzVGZDEwV2xK?=
 =?utf-8?B?eUhGQnR5QlNhalVOTkZGMk15a0xTM3JkMGgvQWdPdjE1WUdDVXVuOTZHL0t5?=
 =?utf-8?B?aTI3R3Fla3ZGOUZkelcvZ0E3ZWRIY3lsT2diSFF0ZjVuYnBpay9oWTVqcS8x?=
 =?utf-8?B?RThITzVPRXdmdWFZdFJ6V0VQdzQyZXRWYms2c2lDV3dBUGw2VWJVbG1xUjZS?=
 =?utf-8?B?UWtWalo5alJYbFdwcitoM2dEcXlIU2tYZVduYzJrOVdQTHhKSUp3MnBjVmFs?=
 =?utf-8?B?TnRQL1Ryc3h4SHBRZ2N1WXhocU91OTM4S2pRcGRzZnVqNURtekQwYmQyTHJH?=
 =?utf-8?B?akR1OXVSZkptUXVPS1lWZDAxdjFBbnZnOTZ5VzJ0Z25KUmlqTVBqT2t0TEFO?=
 =?utf-8?B?b2hFcWtKbUpjaWRTa1prVVZCSW1aQzM1L0YyN0Z5NVNjczZtaG9TUldDTU9Y?=
 =?utf-8?B?d2ZybURoQ2pHQUVlM2NLbkZYL3pFREhxNkNUMk83SE5SOXpHQ3RiOTlsaUd2?=
 =?utf-8?B?RlVjNDVZSmZFbHNNT2o2Yng4R2tFUVlRNUI4a0RHOS9xWStlTTZsdHBGbWd0?=
 =?utf-8?B?Q05uZ3hUTkVoaU5oNHFscHY1WXpZYm1CWGFKYS91Wjh3amozSkJjRm9qZmpZ?=
 =?utf-8?B?cFJabHVscHRwa1Y4MHNxYUQ1eFZyU3F4WUVTSjVydklTV0s4bVNWdkZrSDVx?=
 =?utf-8?B?UVhUQmVLSjBHWG9leDBNSW5TVEVnRTlJRUVPTjVQUGFMNkhzeFMwZFp6YnUy?=
 =?utf-8?B?bEZCNmc5cHNUekRzS2cwZkQ4eSswL2tjU0ltbnpXT1hlMk5RUjBWWWFXc04v?=
 =?utf-8?B?UXMzUCs1eGl5c1lxTGsyYTI5bVZ5SmlWZ3REVmNRSE4vNURtTmYxbmg1Ykh1?=
 =?utf-8?B?eHVUNmNpQkF1SzZPUWdnZGlNSWFCL1J2SVV2ZFdxN1VWMUp4Qm01NExmYkdB?=
 =?utf-8?B?djNaWE93QlZIdWlUNThmTUYvaC9tVmE0cmlaMDZYeEdPMERyc3Z2U1hyQlY5?=
 =?utf-8?B?ZFh4NkpuU0dnTkJHSU1WTFBSVW5nOTM1dkJXY1BpU0J3RTRnekZnQWVZc1Q3?=
 =?utf-8?B?OUJuQ21vSDdwK2VFbEkxN2lndy84bEcrU0hWaWx6R1FnSXp1OFNaMkdnaTV6?=
 =?utf-8?B?aWZyTnpzWk4yN1JTajJQVi9nYWNMVEh0dzRINEJrN2o0TDg0cUdzS1piQVBR?=
 =?utf-8?B?OTY4QUxJVnR3OEJWYzl2dzhmZlBqRVQwS3NpVzYwTVdHbGZGejlUTmNyNW1k?=
 =?utf-8?B?Y1IyTjRqTnYyRGtMSmpVUlk2VVBNTSszZCt3TXVEWDFzRk1hcUF0Nm5yQysv?=
 =?utf-8?B?Y25OaDJjTVlCZnBmR3R3NGNkdXE3L2xaMDQwaXJGc1ovMjdEcGkrQ09LNndF?=
 =?utf-8?B?bVRRR0xBMUtEOG5NcFdaSmpyeFpEOThSNTRwRWp6VmE3bWZhT2lRcVRTbnkv?=
 =?utf-8?B?MVFkVnpnSFhUSnBGYnhlOG04ejFnTmhVNzhIemtaN3FpaWNTVDB2ZVI1VW16?=
 =?utf-8?B?U0VnK1RqQ3duQmxZMm1yZHZpbC94eFQ0NzJmTGp1ODk2eGRzT1JvRFVVMGxl?=
 =?utf-8?B?eEQ1cUduRGNUZW5ybnVYdTBFVkVSaE91TzRYRDNmc211djNTTDdXRVFPTWx6?=
 =?utf-8?B?bHFYcCt0RzZrdjl5UVU0d3JYeGZvRkw2S2tGZ3FqZzE5cy91M0UxVnNZYVQw?=
 =?utf-8?B?T3U0M0NDN3B1ajBxbTlaRXJkWE5zZ3ViZkU3dW0xdnlTUm1UWCt6WEg4d09Z?=
 =?utf-8?Q?190q+Xs7coO7d7+qE9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5eaceaf-5f96-4e02-ca49-08ded096aecd
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:44:33.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ypw8NYlWhNbknddyeJ5g3qq15rL87kCTC53k1ulLgxQ3aoB4BtldiIBzhI9jXbG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081

On Mon Jun 22, 2026 at 10:14 AM EDT, Ketan wrote:
> The page_ext iteration API does not validate if the PFN still
> belongs to a valid section while advancing the iterator. When
> dynamically adding memory in the hotplug path, it can lead to a
> NULL pointer dereference during page_ext_lookup at the boundary
> of the last valid section when iterator count equals __pgcount.
>
> The for_each_page_ext() macro calls page_ext_iter_next() as its
> loop increment. for_each_page_ext() does a
> "__page_ext =3D page_ext_iter_next(&__iter)" at the end. This
> causes page_ext_iter_next() to increment iter->index past
> __pgcount and call page_ext_lookup(start_pfn + __pgcount).
> During memory hotplug (online), the PFN at start_pfn + __pgcount
> may belong to a section that has not yet been initialized,
> causing page_ext_lookup() to trigger a NULL pointer dereference.
>
> [   14.555124][  T846] Call trace:
> [   14.555125][  T846]  lookup_page_ext+0x6c/0x108 (P)
> [   14.555127][  T846]  page_ext_lookup+0x30/0x3c
> [   14.555129][  T846]  __reset_page_owner+0x11c/0x260
> [   14.571201][  T846]  __free_pages_ok+0x5e8/0x8e0
> [   14.571204][  T846]  __free_pages_core+0x78/0xf0
> [   14.571206][  T846]  generic_online_page+0x14/0x24
> [   14.597782][  T846]  online_pages+0x178/0x30c
> [   14.597784][  T846]  memory_block_change_state+0x284/0x32c
> [   14.597787][  T846]  memory_subsys_online+0x4c/0x64
> [   14.597789][  T846]  device_online+0x88/0xb0
> [   14.597791][  T846]  online_memory_block+0x30/0x40
> [   14.597793][  T846]  walk_memory_blocks+0xac/0xe8
> [   14.597794][  T846]  add_memory_resource+0x280/0x298
> [   14.656161][  T846]  add_memory+0x60/0x98
>
> Move the iteration boundary enforcement inside the iterator
> functions, so callers cannot inadvertently access beyond the
> requested range.
>
> Fixes: 9039b9096ea2 ("mm: page_owner: use new iteration API")
> Cc: stable@vger.kernel.org
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
> ---
> Changes in v2:
> - Incorporated comments from David and Matthew to check for invalid PFN
>   in page_ext iterator rather than checking for NULL section in
>   page_ext_lookup.
> - Minor improvement in commit description to include the issue with
>   page_ext_iter_next
> - Link to v1: https://patch.msgid.link/20260617-page_ext-v1-1-37ad802b1a3=
8@oss.qualcomm.com
>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: David Hildenbrand <david@kernel.org>
> To: Lorenzo Stoakes <ljs@kernel.org>
> To: "Liam R. Howlett" <liam@infradead.org>
> To: Vlastimil Babka <vbabka@kernel.org>
> To: Mike Rapoport <rppt@kernel.org>
> To: Suren Baghdasaryan <surenb@google.com>
> To: Michal Hocko <mhocko@suse.com>
> To: Luiz Capitulino <luizcap@redhat.com>
> Cc: kernel@oss.qualcomm.com
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/page_ext.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>

<snip>

> @@ -138,19 +142,22 @@ static inline struct page_ext *page_ext_iter_begin(=
struct page_ext_iter *iter,
>  /**
>   * page_ext_iter_next() - Get next page extension
>   * @iter: page extension iterator.
> + * @count: maximum number of page extensions to return.
>   *
>   * Must be called with RCU read lock taken.
>   *
>   * Return: NULL if no next page_ext exists.
>   */
> -static inline struct page_ext *page_ext_iter_next(struct page_ext_iter *=
iter)
> +static inline struct page_ext *page_ext_iter_next(struct page_ext_iter *=
iter,
> +		unsigned long count)
>  {
>  	unsigned long pfn;
> =20
>  	if (WARN_ON_ONCE(!iter->page_ext))
>  		return NULL;
> =20
> -	iter->index++;
> +	if (iter->index++ >=3D count)

The before-incremented iter->index is used to compared to count.

Either

if (++iter->index >=3D count)

or

iter->index++;
if (iter->index >=3D count)

works.

I tried the latter locally and it fixed the issue reported by syzbot[1].

[1] https://lore.kernel.org/all/6a396a5a.ac26f6c2.9a9c4.0000.GAE@google.com=
/

> +		return NULL;
>  	pfn =3D iter->start_pfn + iter->index;

--=20
Best Regards,
Yan, Zi

