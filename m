Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9CC56853B;
	Thu, 15 Oct 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088012; cv=fail; b=ow/T/TUa+FkHLFn4cdlQMGvLeOPLH0aZkkXdhBTWAXPkKvFm+6mNytrxbBcjZdVbuRslAbcxM+iED1sXnZXww/4D5aHo+zed7B6QUFrpOXUNlNKScMNc1P/Ck3YfX8LhGYb03pwXn9/rEEDG4K17EphkNiOkFUqSBBglRPf+NkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088012; c=relaxed/simple;
	bh=v1fImGEKGzE3nGK9ANJDd5Vs3iN0fItPFzkZy0ddAgM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZFx/8Z5gdxpUq3fzrvMU5nUJ6qjOYMj0K7JDpNomAsZl20yZZ/Oz4zG2JwJwY0JVKqiRnqpldjPMvS+KPRPiIJPON+pe170pMQg++aeKU9z2ryPBfAENhOPqTkov6Wq+/LG/7bEOXOm+XC5YE+IlPU1oU2Jd57EWaF0SCmXspFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JIa9G1Lj; arc=fail smtp.client-ip=40.107.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JIa9G1Lj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWhxSSXdnn4AQ0FlAFUr+9WsaB2YbLysjBOTEeahA2/wQcGh2PW0FjY1IHKmf32VnmD1Z8Y4iJ1zWkoiAajhSv3SUG6ge3SFllU+xi0aeFhKHiN1XahRPODIIGZR4rHOg3RRrQf/6GQjwOUEvVk1fHs6pwtkQwHUykYqKgR9f9R/j+Mklw2Y1jO+6HKOCQ2nJLt52vU/DclRHPOfTSdqYo9n8mm6UjSF8y1Y9aCwFN77KiuK3s5uSI+4SatCIf450y15g1tEkn9F0uQzfGs0+b7x+SZrCyj0OmYDfYnTO2zWXXhDRYDsDh+Luo4OdTej2QVA/qIznT7Z7ukgZyAVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nQRG+P0Cb5YJVXcWEOM09eq9a7157aYbKeMOoFYutM=;
 b=VykgrT3j4CUprB0Ipc5Tby5Nn9xSecrFk6B3zYOcq0Y1kd/XHXmfXWfjCw0qQ7TYUOndKd4MijhWPqx2HoLhqSK39QmsJbeSz0wPbhnE0q0l4clmycO+aK4Bkx+ZWnFVJ7pd4dcymr/TDJmClcLr2fQC9wiyzsIlz5Qnlfsv6aadfQ6MJlbfeFk1PmWttKA9A915Ho2N7gnOYWxi71T6q3D3mgE1Ljl1DyvNhfdzHoC2jnS889wC7hHpm7pn2ADZ2lK04qqDezio5kkFyU8qKrGK3FQe5ZuBdhV6WuwB5NeifkLIa/lGkKXyscWl0S2j2qW6rxGBLYrIL2cmfyupmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nQRG+P0Cb5YJVXcWEOM09eq9a7157aYbKeMOoFYutM=;
 b=JIa9G1LjQTyoJzxSkf0UfcfJVMr41d5nJMSdM1dezYNK7It3QSCInlx207MuTj8WMOz4bTHcuNgunzH2Okvktm3XnlEBon/s8tG7C7FjuqRokBYb0wvdJHtfGmUyWPrBmu/J1J2QOOg7lPL+QM9xGFhuAcU1m/lox4LT/In7M0FKZJWWHB1tK3S7l7o83GXZACS5EZkJFo0gsKHy2DCYOwfTUOHBHGTPy6Peka5itSGuBrSYhA+xqcNlOZhd+/v1bI/VCiAXyE0xuB17Y22iipqUbOtWxl2refIBagyzox9Vjf+h2P36S9kporlE7eL1/ruIGGhd5qB8Y6/7lHyUtA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 18:13:12 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Thu, 15 Oct 2026
 18:13:12 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 15 Oct 2026 14:13:01 -0400
Subject: [PATCH for 7.4-rc2+ 1/7] powerpc/book3s64/mm: don't count
 invalidated PMDs in page table check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-anon_vma_uaf_fix-v1-1-7b977303b42b@nvidia.com>
References: <20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com>
In-Reply-To: <20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com>
To: David Hildenbrand <david@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Kyle Zeng <kylebot@openai.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, stable@vger.kernel.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Andrew Donnellan <andrew+kernel@donnellan.id.au>, 
 Rohan McLure <rmclure@linux.ibm.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: YQBPR0101CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::29) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 62527d50-ff55-48b6-2f3f-08df2ae7f955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w0d5tzQhOwY6iSSgqyhAYg2J78Xhv/ZrYHuiGIHwgQEkJtui6nJCmb3F/fIE6Oa7uCju/elLcwT4w7Zk1mt26g+ZiWEt4Frj8br+VMEPc9CBvhWojMErB8YPvy2fyp5akm32+eV29grTRJynhnoDDrTDRl7uUZxYhu6PrGnWvS6YFZUFBGEF2CVLOiumDfms1NyS6HSe6RaCM4dnEIQRN6AW4Zmc3xZzgIOMesrPUrguZnWdj/QrkAa96YEuS2qGeFETJS2HHxZ9uIphPgeIXsYOJIWVS0IorID4LkO8K1LGbst6W9/pBNhSpGx6DldBmt0BZ5fAeKnBqVxeSrHa/+Dzz3acG65FTJkEUrptMJKG3Jut8KPS3e0NTbuV/Igc8mipRQS4+aWvSkbWQzXI0HN7x9qUstoUdF51U2TRRnYizSBfUqAJMIS3d07awditqJEWCOtS8273GywcBwkjo/lK34xFK8x3uTy5E9CG3L+yNsNDeZzm3UWEdMWqqyrLMgaWuN7m96iI9TFoP7BVcOScC+oDeAU484Jrsb6rz/0ETucL2Z1KNXCDYj8m/v1znfnyCJVOGnzvzjdHhntvlJ3luE0Xy24wYk07oQ+mL6iM/vRRGcz5la1GYzfvfKLp1Dqq6K+S+zMcdK/WH9IzlFeCU14t/DOCAalop/pikw5UkNAb2FtV5K4vgeRKbuOw/ODc7cn8874fUNM0K1XYoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHhsb3ZiM2lJYXlqMndULzBIK2tiQTk4Rlh3MmZtRTlUU1NjT1RVUWhKa3Iz?=
 =?utf-8?B?RStuTWVSTFBtN0txY1c1WWowdklLcUpmZ3dPM0hkanF0Sk5oM1ByWHh1S0Rv?=
 =?utf-8?B?MlJQa25HeHlzMGxKV2hJMDc1QS9iZDdZaVhoV3NUN25MQUpoT0RHdlJxZXda?=
 =?utf-8?B?bGhuVnArODFSdHVhczE5ODI2bU1wc2Evb3hxYzR5V2lweTVoMi9LaFZEY1VL?=
 =?utf-8?B?b2UrL3IwNWM3Mk1BdWRwbDVIbENtOVRRUXdDWkR6MFVjRkNXRHB0bnorUTRy?=
 =?utf-8?B?VUw5c1hKM3lQU1hVMmFzSjgvQjBjVFQ4WFRlT3FVVVlxVGwwSzNsTmc2TmI0?=
 =?utf-8?B?bUhSQTcrODdyczd0NHh5a0NCMExKa1RHc3NMMkw5VXFVbG9CZGRkamwzckxs?=
 =?utf-8?B?TDdMbFZoVVliWC92d2RyRXRlTnAwOWdHN3VGVHdXbmVnV3VsTXNwdGFBTms4?=
 =?utf-8?B?M3l3M1hWVDR2RjcwakNxM1dGRThPK0cyUS84OU8xdGxyQUVGc3VQWTYwVDVB?=
 =?utf-8?B?SlpqMk9KUDRkMFVrUHZLbDZTbVJvS1k1a0JMRHlVVE5NT29BVjk3QlE3T0t3?=
 =?utf-8?B?aUJKM2QwOWFqWTFjVHUwZktPL0hzaE1CdGFFU1kvRTgxeFN6Q0V3R2JoMDhD?=
 =?utf-8?B?R0VkaXNPT09EZTNteU9XdEtQYTRYZDZSenAxQzdDbUtDczFJOE9sbElpNHdx?=
 =?utf-8?B?bWx3MDVhMkIwYXd3ZXMvL1U0MzR2Vms4OTFsZnJuZ1VXVEx2RFMwd25FTTVU?=
 =?utf-8?B?STQyV3NVMHd5RDE0MGxSazFPdDdqUERnclpsekZVTkY2K3l5eGR6T3hicVla?=
 =?utf-8?B?MXV0YzlZN0NQK1ZNVmV5M3VDNDRDNjhDREQvRHE2K0xxS3Bzek82bEhCcDVq?=
 =?utf-8?B?VnhZSmx4N3N3YmlBaFZ2THVoT0FGSnN5QnpMcnNWa3dJS3puWFRGanZ2SGpt?=
 =?utf-8?B?VXgyRXlyZ1RQRG5kNE1BeTloOTlPenY0aUt1Q0tWQllYTWkzUnIzZHhDdWxL?=
 =?utf-8?B?WXZJZHRBS0duTUNBRW1TMVJjMFg2U2hPV3pDR2V2dWZUcE5aL0RXZnNqRnNl?=
 =?utf-8?B?YnAwa2VVVGVabFU2cmVEY0lvRllpbFVIaEZOREtoZXhJdkRJTm5EUnJYUURn?=
 =?utf-8?B?WkV0VVE2SWt5Q2ttK2RqWm1CZjY3WlVRcURUc1oxRkw1cmJrNEJ2ME9Pek02?=
 =?utf-8?B?U1JETHNIdlZkYlZodzdFamwwMHB3dHp4RFBzMDQ1Vm5xaU4wOGwvUmtleDNo?=
 =?utf-8?B?TWRSV2VROUN2ck5wUC9nemd0VGlvSzFQWnBNT01XNTZzUmQraXdZcDJ2NWtW?=
 =?utf-8?B?YU01LzR2ekRsSFpkNklxYVZRTFdDSitWTlI1Ukp5clhuUnF6RzRFaTVDSXdv?=
 =?utf-8?B?R1JsN0tjS0ZyUk1KVUF2QUZyd2M1ckNHam9IS1JjSGN0OEZublovOElGbWYy?=
 =?utf-8?B?RldKWE0zZjdPMk5oenZGUUpJV3QwdzhQRDU4Y3R2WW1ROEx6dFpHTkJqNUNG?=
 =?utf-8?B?TTVxUFZXWUlIWEFreU5UZFlvRk1rdkZBTUJoQW4xRVd3b3A4YlJZYmtWWDh2?=
 =?utf-8?B?cnVIN1haMStNVDcvVTN3YTFieXU2K3dDSlJpY3RGcXRHVm51Z1MvTzlHSnJS?=
 =?utf-8?B?dnpvdlM0MlNuQlBVTUUxRk0zZWZBK2wrN3NsNVJheTlvOHQvdFc0MnZTaFlY?=
 =?utf-8?B?V0tINzA2V2h1UlZVUkMrWUhtZlJ1dTBwWDNMSGNHYWhPMlR4dW9rclNIMTBL?=
 =?utf-8?B?VjFKcUZSZjRxd2pOOTAyeGJwWHd3ZjJZRUVtNENiV2RvM3o1eHRsK3d5UVM1?=
 =?utf-8?B?dEhCMjNRa0EzR0tFYmZQOXc1OXFhNlNuL2s3aGY3dzQ3ZCtKTUZXKzdJSHlO?=
 =?utf-8?B?WUEvU0FRMEtUaUt0M3JzWjJpYzVJbFg1anVBL1lKWGVCSkhiZVFQK0xlaXhL?=
 =?utf-8?B?ZWI2OElyWEpxUzBtdFM3T1JnSjVBNnpjYTJjekxITkJ1emN3WE56R1pTZ21T?=
 =?utf-8?B?NDlRbkpWOXpIYlloNDJDTDBGWE9VYUFPRE83OWdTVk9yS0o2MWlkdWdFY1VL?=
 =?utf-8?B?OG1rOHZSRjBPd1ZIQ2FOeER1V1k0V2d4dHpqU0xuYXRWZW5kSUNFUG83R3F1?=
 =?utf-8?B?Yjh5elVrdGZIOFlyZXpJOFFFTjJHMXZSWkRQV012TldtVVgzQmxIL1B6QXN4?=
 =?utf-8?B?UkJoOGw1aW1Yem40ckVFMGh4bDI2TTYyaHk1dUNnM3doUVg4bStqZGVMd3F1?=
 =?utf-8?B?ZWNVelJiT21XZVFDdHU0bkZGWStSdWY4K0VQWFRWUnRIYUNxbGs3SnV6czJl?=
 =?utf-8?Q?WJvJ1aVdlfz39BlY3S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62527d50-ff55-48b6-2f3f-08df2ae7f955
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 18:13:11.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAJSY4HiRsI0JFy7QfG+HifWNUwMHC2SsmYWPk7Tizs6E/5LlT4U/uF6uJV1HP7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058

pmdp_invalidate() replaces a huge PMD with an invalidated one
(_PAGE_PRESENT cleared and _PAGE_INVALID set) and calls
page_table_check_pmd_clear() on the old entry. This decreases the page
table check map count. When the invalidated entry is later replaced with
set_pmd_at(), as MADV_COLD, page_mkclean_one() and change_huge_pmd() do,
page_table_check_pmds_set() in set_pmd_at() clears it a second time and
decreases the map count because pmd_user_accessible_page() still counts it
as a live user mapping. The same happens when it is cleared with
pmdp_huge_get_and_clear(). Then the map count underflows and hits BUG_ON()
in page_table_check_clear().

Found by code inspection and confirmed in QEMU (pseries, POWER9, 64K
pages, CONFIG_PAGE_TABLE_CHECK_ENFORCED=y): MADV_COLD or mprotect() on
an anonymous THP hits the BUG_ON() with both the radix and the hash MMU.

Fix it by only counting entries that are hardware valid, so an
invalidated entry is skipped, as the patch "riscv: mm: exclude invalid
THP PMDs from page table check" did for riscv.

Fixes: 641d47d4c963 ("powerpc/mm: support page table check")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zi Yan <ziy@nvidia.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Andrew Donnellan <andrew+kernel@donnellan.id.au>
To: Rohan McLure <rmclure@linux.ibm.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index dff8790a047db..392474972777c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1091,7 +1091,8 @@ static inline bool pmd_access_permitted(pmd_t pmd, bool write)
 #define pmd_user_accessible_page pmd_user_accessible_page
 static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsigned long addr, pmd_t pmd)
 {
-	return pmd_leaf(pmd) && pte_user_accessible_page(mm, addr, pmd_pte(pmd));
+	return pmd_leaf(pmd) && pte_hw_valid(pmd_pte(pmd)) &&
+	       pte_user_accessible_page(mm, addr, pmd_pte(pmd));
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE

-- 
2.53.0

