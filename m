Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBA347CC67;
	Thu, 13 Aug 2026 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633543; cv=fail; b=qoePZ+uW40QkjyHXpqBB1isTrHO8sQ1hyHLwfRTSc8bfc3vnwC2wvXPAbSUTxrYsu6lHyecQpDtODAOroJIVlWjaMvXFTQejsvtvK7/d8UAPL1H5jCPtespVKZw/rt0mwhZhHjYKQOzkIwR0bbvhEj+vPjCQJKKI9AcDMuYYmQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633543; c=relaxed/simple;
	bh=n4j25oUu0YnG7yGDdTmw3Ad8RRk+Mtf82fboeL3MW9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FgI0jR1DKgFonHTwyDWfsUr/GEaPgR/6jP+EraklC8PFTWSUhRBGXWN2Cq1kIpk9LymOb59hvtGY6ndC/oZAosiW7BRIPrFKozuGC8a+mYTQuo2gb3K/MjeFzamls5oG9xjYVgN1CBqbpO4o2RCraQkLRcWVgC5DOxSnVLDqd1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kdq9a4Z9; arc=fail smtp.client-ip=52.101.57.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kdq9a4Z9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSAEtoR/b3hBdxvVg+fmggq7WEct0NG7Gah2cQrwcZh/8u4FVVWHRhyTaeSyEo5N03PY6WKPFKxxAUwOc61G7By6ETsQpjsxGcL0WiCmgKKqMHDxWs6RzlNVUJEHt36vqqePKJMlKgyqXapCmuwVxDRf4BQw2fNrrNJu9KBCvEa2pB5XWrddU7MTAtOAHyob1K0Fy+CF3SVaLveFA4Wy7siJttQWFUlMIk1YxxevBy6IX6EhIkbeHo+HTICcWqehjCKAOeV8nbLqvi0ofNK+4pwxrJ/iNA/2HscNvvZJpjDX/rH4lqrRhSX1qBot/gB68CgL3fO94dxs5ZNKEI38EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJRPDVNFkoIGEtPSsM4V0s/cxNM3iCKkSXYCwWb6Hd0=;
 b=sbeI56dB2hZc6mHC6qfL6ZmM6qz5jYxVTLKGZii3g+LQIpiMN9i3GnIjiMASRlTiA54ZGM7zy+79JeTZ258xEueRjGFt5wKooacqU1kQjeDTKEj8LYCa3xAUQU8BUA/Wghzdnuoh164IuEHUDt4Rz6+qhYU+DreXCRCwYRyBDlXSVMDyeyS1sd+/vWDsjOtG0VoTnjF9Y+8nIpXKLmerQ7kmwYQngKr6RRz5EuE9oRCS8nw9OBIVjklrneqEuyD1bFPvE/Dp92xnu8sYv1fQJhNg5AOPdpwEjvdk89Zar4T3CeAM1CXhhNKW2pT2T46IC8OP0jRv+LYEOGd/FDaecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJRPDVNFkoIGEtPSsM4V0s/cxNM3iCKkSXYCwWb6Hd0=;
 b=Kdq9a4Z9G+F4PyvuFF1SGNxLKDy4WPHHVVUGXy+nJ83wt6MLr6lP8qX5IFm6bcCLCCIMdzJW84zLWScwaQZ2/R1YHsYrf1Hm82v/aj9s5WZPdfiqZF+iF5ebA5Q4YKRoUMid69TbZPg/3KFCZRj/n5so6Gq4QUiPKP+nE12n2ZA=
Received: from PH0PR07CA0068.namprd07.prod.outlook.com (2603:10b6:510:f::13)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 15:05:35 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::33) by PH0PR07CA0068.outlook.office365.com
 (2603:10b6:510:f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 15:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 15:05:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 10:05:29 -0500
Received: from [10.252.195.98] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 10:05:21 -0500
Message-ID: <9cfaa5d1-83b4-4b88-bf3a-05d2e074cadf@amd.com>
Date: Thu, 13 Aug 2026 20:35:21 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] x86/mm/pat: CPA fixes
To: Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
	<luto@kernel.org>, Borislav Petkov <bp@alien8.de>, David CARLIER
	<devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jiri Slaby
	<jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, Kevin Tian
	<kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett"
	<liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Pedro Falcato <pfalcato@suse.de>, "H. Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Shakeel Butt
	<shakeel.butt@linux.dev>, Steffen Dirkwinkel <lists@steffen.cc>, "Suren
 Baghdasaryan" <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, "Toshi
 Kani" <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <stable@vger.kernel.org>,
	<syzbot@syzkaller.appspotmail.com>, <x86@kernel.org>
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7241df-7718-4a43-fca4-08def94c53cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A6qrJXQ6+74WSY/vWmEuNnfXoUfKHpbBG9ntX/x+BaeOCsQ9SfTAlgocyK1O8fEwCOXaLX/isRGJI1aIMY1SfoKrlAF7ytRi9Ru6+1jzmoDzYXmIA+lY0lKLGGBHMeMn71XVCMR6HNm8GINhhxHYULOoJxjpUb7KJvTE3vhrj1AxqatzdCw0mnzlyr0W8ZvgPqhD+u1fkiH4wP5O9k7Tk7Ok2pJBsDypq4sF/QQrc7U8uEHzHbUJ4cQxdjTeUZh/Prp38Q7bL1yIA4v/6G7/R3UnN5jCh+dRYpF9uz0LKHPrVk7KmE2cN5LA3N5tNlQgjkAi9a1BtOR9PEA5iodIzaCTeB0gbPrIgLT/G3lwV4ZzSL5+c5nCoQTnslCzhTHF8fDljV6elx0eUUsZQMQo3V9SoCNfSRY9cm3VA+98SkSDbxV6DHKeoPl3TNEdjzPkoPPXHkMVs3TXD5d7ko5YQqh65KWNYdIKr8vWfhciXtGJl/L/jNpX1YJNwEQN/xyiz8vVTmIl01IckFTRzd969VR0Kipawob0RGCczvUwk8TT60IdiPCR9HtY/DBgiVVqsqv1/xGpWwWf1zr1XnhfTdEWjkrxMLrCwTZR1IPxOo0gNnLSLpMu43w8eYiAgS+3TnARlJlYOMIlDhE5FxSkHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+dA4jVR2CAZ9FEjaAUwSgsJ94Av0dIhKLfdkwVlYESktF9NkwKKyKUIrpFyo+qyCHl+kGCCCQt6Z2D8fHM/5+rFJ5c/zoY9NrLKgMOlnY5QUXz1np/PGAO4l1baN4Gy1hKZQYKAfquqLQglKFXJE05/sNnHm8VvBTZNvSF7VqprvVrXLF7HC3DUGdJcrcVXnIh+Ucs+ZLVUgU485CUC1k6/KcpwKE4mjJaDkUt/NR1c+CQyy/UxrGpUmTDs2pxGS762DGBAN68yBAGH8TLRYsE4j5w3PSSiZZZKkbEIUL3hex7ZKcu1PgbLy9X89eI5cohvbpyItEmUxHgaOprFIS2Vu0Vqa6BZoASJcI9275bf0+VmaKCykQzsxTouIJiReWm3mrjXTzNfd/uuKPT2JoJ+DA+VkJps4fSSEhw4PrmoiZLvwFg/+nGWccnu8Z1Mg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:05:35.1368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7241df-7718-4a43-fca4-08def94c53cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225


On 8/13/2026 2:31 PM, Mike Rapoport wrote:

> The first three patches are urgent, the third patch fixes BUG() reported
> y several people and it depends on the first two.
> 
> There were no bug reports that the last two patches fix because bug
> manifestations won't yell at users.
> 
> TL;DR version:
> 
> There are a couple of CPA fixes floating around:
> 
> Denis Lunev fixed races between split and collapse of the large mappings:
> 
> https://lore.kernel.org/all/20260715183453.2381141-1-den@openvz.org
> 
> Lorenzo Stoakes fixed UAF caused by races between CPA and ptdump:
> 
> https://lore.kernel.org/all/20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org
> 
> and an issue with stale page tables in IOMMU:
> 
> https://lore.kernel.org/all/20260721-fix-cpa-kernel-pagetables-v2-1-2b255deed710@kernel.org
> 
> Mike Rapoport fixed a check of RW attribute in lookup_address_in_pgd_attr()
> used for the verification of RWX:
> 
> https://lore.kernel.org/all/20260715144519.934289-1-rppt@kernel.org
> 
> Pedro Falcato closed a race between text poking and collapse of large
> pages:
> 
> https://lore.kernel.org/all/anCK3eWFMwZqq5ka@pedro-suse
> 
> Some of the fixes got merged into x86 tree, some of them got merged into mm
> tree and some are still hanging in the air.
> 
> The changes here are collected from all these fixes into a single coherent
> set on top of tip/x86/mm:
> 
> * fix for races between CPA and ptdump causing UAF
> * update to the fix of the race between split and collapse of large
>   mappings
> * fix for races between CPA and vmalloc_to_page() in text poking
> * fix for stale page tables in IOMMU
> * fix for effective RW computation in lookup_address_in_pgd_attr()
> 
> ---
> v2 changes:
> * rebased on the current tip/x86/mm that includes peterz's changes for
>   DEBUG_PAGEALLOC
> * added fix for CPA vs text poking race

Tested v2 on a 512-guest concurrent boot harness across 200 iterations
with no splats. Both crash signatures reported in [1] are no longer seen.

Tested-by: Nikunj A Dadhania <nikunj@amd.com>

Regards,
Nikunj

[1] https://lore.kernel.org/all/20260812063316.21371-1-nikunj@amd.com/
 
> v1: https://patch.msgid.link/20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org
> 
> ---
> Lorenzo Stoakes (ARM) (3):
>       x86/mm/pat: acquire init_mm write lock on collapse to avoid UAF
>       x86/mm/pat: acquire init_mm read lock on attribute change to avoid UAF
>       x86/mm/pat: allocate split page tables as kernel page tables
> 
> Mike Rapoport (Microsoft) (1):
>       x86/mm/pat: fix effective RW computation in lookup_address_in_pgd_attr()
> 
> Pedro Falcato (1):
>       x86/alternative: exclude text poking against change_page_attr()
> 
>  arch/x86/kernel/alternative.c | 39 ++++++++++++++++++++++++---
>  arch/x86/mm/pat/set_memory.c  | 61 +++++++++++++++++++++++++++++++------------
>  include/linux/mmap_lock.h     |  2 ++
>  3 files changed, 83 insertions(+), 19 deletions(-)
> ---
> base-commit: 7da514d819a0afb148634aac92b3d190f34947c3
> change-id: 20260727-cpa-fixes-d3c73c075672
> 
> --
> Sincerely yours,
> Mike.
> 

