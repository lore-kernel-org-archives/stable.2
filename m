Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD537998B;
	Mon, 22 Jun 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142274; cv=fail; b=TPn2S9KMDXAFhQtXBO3+Zecc0xRzMai0NRiFhz1l2cPGQRIf+qExLMu6bIiTmkFqtqw6PAQjg01LexTcRdjDA1InaGHMAvwx3HL3UC9cT1pf6n9vRaJKk5cfTdxMPUIBUK7ElVs7MSwFaecJboUa2r+ye5EYgDoVdvjNjF0oVjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142274; c=relaxed/simple;
	bh=SMKFSiHn0Gzj8MCgUn3IkJf5/mB9+YS/DrauxHt7jI4=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=QVtU3/UPjIG9Enym94lZp+ADwOwfQ6hH8wnEBPLLdSeeBT/zXDUYgeD2COvtCXNsuGCycK2eb6BGiRyTq2g47ZF4HKo90IzmUOCrnyplH1//dC17Vju7j5nsY2K/XT/pCKT6lEO5SUVzHCsvET8gWpfHKD8jwa+aH9/oWSvGtM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lwd8lYMD; arc=fail smtp.client-ip=52.101.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lwd8lYMD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg0VHa9TFdJ16WTh2EwTZBzj9UpLhydyrgLVHFk1Ssm2yVjlVSiuUX8RlMFifaOQqtO2w9QfvcPIRk6uQH8vnD2I2sXCjnxsXz3vhbIeSA3gMwm6EMLf5dLbToiOesVNvjDSKVKZGA+Z5Op+vY/4T73Urxty0K8wVsH7JdMl0UjCQSk7JhUMPrVrtWb4DT6q+W/vCuv1IwNvsECal0DBYn50+dsiEs7BE1Jz4F4mX5RKySqiLmbk5p0P/yInw5yYMBVYn9OwqF05XV4Y0aMSke297NMzWsl3w7gi8htm2uBkkch+N2X2V3GrvcB+Zejb+d2Sq9ncwQBRHKhFTMO+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWWYrLCtFtmXUP2uTqq9VVcqp2e1JGtepIDtQceHh+Q=;
 b=Fzwg7KL/63h6+qJE3kVCYyry2/aD9hZ1u2TaBFQF8e6es5x13ktt9FImA1KzvJ39uZfcxr0wZR7qaf3ad2WT0hca0NqlYbtAcaSRbW9tc0LLlW5SjsUYfv2M0hn/JpEWoX2+NuibwIKVWWwAaI1WGexeoj1larRwEKizR0bGigIejnIDEYl2qlX2cj3xCUHp+XXOpF/ph6C3vUNA/aAAwtsJlwItY6VkLsy0lHXynV3tpVmyCHsM4l7OlLM+wfikbrMhT3VyuFonDUdg8jZVrm4WUg1C6NjZnQquDtBDHHPRQegS8rQy2pRydbfAzFGItfAu+yVgLdyqFgXAIsajSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWWYrLCtFtmXUP2uTqq9VVcqp2e1JGtepIDtQceHh+Q=;
 b=Lwd8lYMDtz9k6HTMrtbGk1LkIaCdl5mQDb3FJPg+SaUicOCuA/5FvWC5Ei9FB6Di8rDaSfuHcJHum1xbDj1a3j48+thbLnM6QLWjQLGkYLQdmYPAzS4kvUsXWJkFT7jAUKiDmW7CMbr1Ns1pA9uFp8f0n5oaD37mCNQ9Q99efFWs28jkb67/eY4GbxqxZgtvgUEfr7on6K3IVgwUvOh3dDTc3ZBW9P5Hw5AlMNIZG/UVh1zMdUKejDykkhxmbSGjYTeH3+ahM7FJlGoUJh/aKMc7/+6HLbZ997FbNr1BWmQ2n91r/ChvT34KeUYYobp/R8b0I6xFLwrlWW2lDqQjHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 15:31:05 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 15:31:05 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 22 Jun 2026 11:30:42 -0400
Subject: [PATCH hotfix] mm/compaction: handle free_pages_prepare() properly
 in compaction_free()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-handle_free_pages_prepare_in_compaction_free-v1-1-fcf3b14abcf7@nvidia.com>
X-B4-Tracking: v=1; b=H4sIACJVOWoC/x2N0QqDMAxFf0XyvEKtUMd+ZYxQYqqBrS2pjIH47
 ws+nsvh3AM6q3CHx3CA8le61GIw3gagLZWVnSzGEHyIPobR2bi8GbMyY0srd2zKLSmjFKT6aYl
 2a1yCm4nSlLO/T3EGS5qa5XfdPWGruwG8zvMPX6/S94YAAAA=
X-Change-ID: 20260621-handle_free_pages_prepare_in_compaction_free-7cca3ff08367
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: CH2PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:610:5a::30) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b236104-38ae-4602-e0c6-08ded0734680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	47QTu4aL5indWhO4JaoxSNBpuXausqy1hVGCrE9Pj5sF0bJZdkFy4ogVScrVxVRb/fWyhWK3XmhGDOF96Z/2VNsukgs0v7mDIMAbmWpKkK75dazqCEtudEfhEChPOav9QrovV5UmF0Hz1uYclvFMBRzdNDdaB6rv1YOdec2yEBn+BCyMMUCUFsXbr3E590hGqemc2/DIQjC8EIBDE2acYmgLg51r6UBlbAAEVYcgCIK+URvbhR328YLlmtUk5pAbNOvBuu7x2broEd+/Ir1VyebUrXesQBOOFLDfYbhA+J/kyDhI01O2WCSofqViP80Elpgo71g5npwRf+XoI3BxmIx6Ewy0wHJRkJ+54JUIHtlA1avczbUpiG65ZumaA+jSOs9i9KXRexjSZqhC/2zeh/myAKfiOednwNYSv9z8HLI6IaXBPcv3WV7EQ+/Vg28grj9HdCxclz6MlpeMBqJcpokslFqopRiCMg3VaCTAXdHUmOPyFJ1zODA/yUFNFVQzNivkScnG/RljB3jLZ0jW9EBUCist4pJQFN4+qRps0AtMhn1iAsCMfrt96FuQ/hmwFcMJTwTfbtYQr1f6//jvyEbZuV/g7jeiL4lp9PB4QXZqZmjqtlY9t9dk6yFKTcuemRbdz2KkUdsULUca1uc/ZFRBrhZV2VYkygfGygAeUgI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzBPYXFjdEZuTytPQlFKN1RZaUwvUkQ0eXBZV2dsR0RYMWxIcDhOM1A0K3h1?=
 =?utf-8?B?cmFRc1dqRzBWQlBmQ0xhcGlqMTRha3JqQm5HZXRXeDlxUm5ob21OWU5WR1B5?=
 =?utf-8?B?VjE1QytUSFV6NHUrdWc3UUxJbTRBd3lPYVZ1cGFJL3VTSkNqQ2NZUVRQVWl1?=
 =?utf-8?B?QnR5a2prOWVKbmptYlV2Z2ZncmJXQVcxckZ4RU5BZ1lrUzZXNWYyV0J2dkZE?=
 =?utf-8?B?Qkt0cmRob3pPMVFiYktoTGEyR1U0YUdQWnBwakFFRHFvWHNEcyt5K1dIQU9k?=
 =?utf-8?B?MVRnKzAwQzJRMk15MzNyREdlY2V0Q3pYcTE4VytLaitUVUdNUkdlbDVUcGI3?=
 =?utf-8?B?MVNKcUc3MytmQ0t6a3JSMG1rVlhrZU96K2lObVMzdTVra1U0ZEpXdldwSTRS?=
 =?utf-8?B?UEwrLzUrVmtubXdMK2ZpY3FqMGYzMUx5SmdsbEtkOXRWdWJRZS8weUhmS0V1?=
 =?utf-8?B?ajRoNWREU1NsZ0xpdHZNdUpXbTRrN1BERW9pM0RGNHNpU2hwNldYdVNESlo0?=
 =?utf-8?B?VzRLN2tTM0NkOGNQSUxiNUh5NTM5am5RUlJHUWZwaUxsQ2VnTVFva0VlMVZl?=
 =?utf-8?B?UHR4UCtjNWFrdkFybDBHenA2TFAxY2xwWmJhdENWOHB2d3F6STdzaWNSVllN?=
 =?utf-8?B?c3k2cDdBN1diTmdUak0xNUlCbkw3bTNIOENZVUNMVWVJZG5VOXFEUGhoK3VD?=
 =?utf-8?B?L2xybDMvdEF3aWszOVErZ1FnOFlKNnpVRVRWakNmTWR5Y0RvWjI2cEQ3M3pJ?=
 =?utf-8?B?a0RSbU1SV3NXempIb3QrSkcyT1FqZFpCWHU5SEpVY1U5SjNmRGlNSHgvQWp5?=
 =?utf-8?B?bmo4dis1d3VtYVMyam9YRm96VG9NOWsrVjZNNEllQ0pKYTNLVXBQOGF6OFZr?=
 =?utf-8?B?QmRSN01qaDRYZllscXhtVGQ1VG5rem1naTJzb0NjS1Bzb2VvL0RHTUxSSEty?=
 =?utf-8?B?RkFZYnFzc2JCVXpFbjE3dGFLRUpDeFlrSENVU2pBdjdvWkVwV05sNHAzVFdC?=
 =?utf-8?B?TTRWeEZzY1NqazIvZ3NlYmp6VTVLVHJoUVpVd1dBS2J2c3VxbXVnYUllWGRQ?=
 =?utf-8?B?aW1XdGd4dU5uK3pZV0N3bFI1b2huelY4OFIvUDRhT0s4bHRTZktTYzJTb1M1?=
 =?utf-8?B?TlZTSGdjdklMeVIxSHBTcGtkdEJhVDJKSzRYTHlSQjhJcmZpSEdtemxuOVhD?=
 =?utf-8?B?bldCWkg1U2U0YUp1cXZlelVyY0U2OU9kUVRaeWczN2lwQ2p1dkNqdWxpY0cr?=
 =?utf-8?B?Ny80VjlzZDlCeWdQc3hvckhPVzN3UVZMTnFyRkFuQ0Q2emkxU1dFdlhtSUht?=
 =?utf-8?B?Z2QxdDJ2TEl3TnB4NU9TR0llbDVCeFlDNlNNdjVUeUhHYnN0YkNLM2g1SFUr?=
 =?utf-8?B?d20xbVEydGRPemhkYTFpU05aSFgrSVNybng2bUJPK1FCR2hsV0ZaMTZMU21h?=
 =?utf-8?B?WjlJUzZhbEJZanZFK29HUVhNSWkrTVhSZHlWRDZyZFBJSmpjbmU5RFUzYWpW?=
 =?utf-8?B?d3Nod3hUMGJpeFUySXFWMnNQbTkvRDY3M0lLMVhVYUpqbVNrZHVoZGc2MzU3?=
 =?utf-8?B?SFV4SGRyMEFjbXJBQzNmdkMyV1N0UzV3cFV5WGxMZHpmUHZtRUlabjNRaVVN?=
 =?utf-8?B?QmZxK254OEhVRXFZa0MzOVdqNWY1MklaMG5qbVBsMExaYTZZQ25vRThmNlF3?=
 =?utf-8?B?TWJIb3RtZDgrSXg1VVM4MkowY2JMRXBFMjFjeFYyREhnV3NOS2hPRlZoU0lO?=
 =?utf-8?B?M3BFNHF4NEtQdFUrL1hzN0ZmdWYwdTJjRnFJN3BnSXZ4dklYNzJVTTZGZkpo?=
 =?utf-8?B?YkhmdkpiaDFnUlQrcXpyMlNvbStzVEt0aEMzRFN5Q2NvbWNVclJRTkVhUWZw?=
 =?utf-8?B?clRjcm1hTGFoWWlXbHJYVjM4TW5LLzdRRk8xVUJBK2c4dXUrQTF0UC8ySmZj?=
 =?utf-8?B?TmE2Tzh0b0VXRlF5NkVkUFNWK2ZPRnV4OUFMd3NneVV2NXFPckd5RVM0S3pl?=
 =?utf-8?B?L3I4UkdhUFcwY0tOTzljeGw1akRIbzVGeVVDVkFPWExZSjRmR2dQM3o5RkM3?=
 =?utf-8?B?dlhQbGtOeFNXaFA4Uks4QkhoV2V0LzJiV1hWUUxDcDhBdHdKK09xQWRnSTJQ?=
 =?utf-8?B?cW1OZU1hRnVUaXdEMDNneGNDSkdlOXFrRTBWNkVmM1gyYVNheVFlR0dObXNv?=
 =?utf-8?B?R0RxamZPVEYyU3RpbklUSTBSZUlycGxiM000TElzUlBkWHhmaVRMMDVlTHJJ?=
 =?utf-8?B?TlA2SFBEaEd6VWpmd0lEUDIvNmM4WEdsSCtCcjBjZ2tNcGRkNmdUbVN6UHRG?=
 =?utf-8?Q?xCwFqV6RVeWvSGAs+B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b236104-38ae-4602-e0c6-08ded0734680
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:31:05.6917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdMrV6x0r3sO1CNftfZE2mwmngS9vq6eMNB5JWsaG3xNKP/omYudURiOroT1jZKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

free_pages_prepare() can fail but compaction_free() does not handle the
failure case. Failed pages should not be added back to cc->freepages for
future use, since they can be either PageHWPoison or free_page_is_bad()
and might cause data corruption.

Fixes: 733aea0b3a7bb ("mm/compaction: add support for >0 order folio memory compaction.")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org
---
free_pages_prepare() can fail if a page is PageHWPoison or
free_page_is_bad(). compaction_free() needs to handle these cases to
prevent failed pages being reused in cc->freepages.
---
 mm/compaction.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b776f35ad0200..f08765ade014c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1875,15 +1875,14 @@ static void compaction_free(struct folio *dst, unsigned long data)
 	int order = folio_order(dst);
 	struct page *page = &dst->page;
 
-	if (folio_put_testzero(dst)) {
-		free_pages_prepare(page, order);
+	if (folio_put_testzero(dst) && free_pages_prepare(page, order)) {
 		list_add(&dst->lru, &cc->freepages[order]);
 		cc->nr_freepages += 1 << order;
 	}
 	cc->nr_migratepages += 1 << order;
 	/*
-	 * someone else has referenced the page, we cannot take it back to our
-	 * free list.
+	 * someone else has referenced the page or free_pages_prepare() fails,
+	 * we cannot take it back to our free list.
 	 */
 }
 

---
base-commit: 13a1e1a618858407fa12c391f664ea750651f6b2
change-id: 20260621-handle_free_pages_prepare_in_compaction_free-7cca3ff08367

Best regards,
-- 
Zi Yan <ziy@nvidia.com>

