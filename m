Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F82BEC55;
	Tue, 30 Jun 2026 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783347; cv=fail; b=Bc74Ew3/1K/DsNKpfLN8byz+WSfy9nJKHuUuoDkH0WVQRy9gI6UVfVm6TM4GQZkr78d+Tppp/Y4ROtneParV0nWFBbqhyGeY+xIjs5bTVhSWcukJ7c3+h4Lg1M897TvD7sD1Nlnr+xS4X501/IFCKKMQWVy0HJWHndONjdArdiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783347; c=relaxed/simple;
	bh=IHjgSiEzsKpM8mcJTE3ASPulccXlYlYjLb2EZia63Fk=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=XEWM6fXMmb6ULatULuUd/dJl2oIV1ovrPmcs/uPWrUB6/mQ8QqTXuzkLtShxH3xa3Xm+cgtSvARJdnmtr1fjUbfeIxscmepPSbQoFY2drxoFr2Q576kxKUmenEWJtBmOZXIkm5UYkWcMv9SmB0XSMUKZPLYYF/WPwHzp5jahocU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AhQeBqBw; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AhQeBqBw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKzL9tFuJSVKOp1bcLC5BR5K0JBHE9ehz/Q60eghBO2pvswSEUKaIyEw3l1Q0/6+69ntr5q6MdPBP/3nm2LaZ38cjVObJ+WnyyC2d8sUEy+GMr5MvY71FUX3xHQWeiiO+p4yVgfbLvNniZP2y0wuNJWydheJOyIQAerFGkpqlvUMa4xDpJ9y7BlJlZwmbk1ksG4o0fRO4nRRErYPvfX6mV40SUvWqmTQaIaaWqf1HXuEneqtEKPE5NQUpEpyEYw1572KRDFRsYsBF9AfWOyzc6Ia98R/GeuU2cntazgZa6agvDdkICo9CvqkjqtY5yKUfczFoWR0RMj1aIBy0mesPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBcHXxsdm+wf5bTFMS/9j8E2D0dctkB+v2o4r7vMNfE=;
 b=Ghc2yqnw0Sv+dXB0ACkB/fSR5M0q443m7ohGV1Egc0ytDfnY9Ms7MOjXTk/x6WrALhszb9098R+rvfIxvAA6rDTNswfDtILxiqqrQBPao9YvZmElyJNX27d8eIir6xHKTda+HQpp/ZyBDAbxjAZfGuDQF8DtpvLdGMZBxmms4Qx/9w3CYkeN03LF+yFuVgLBr3DgtjykUsWhXe4tSe5SggiIGuHREgzKL7gDlEERxfaZdkRUHbbninu3SkzIxXr61oRu+t+OzNIzQZ90HBLt4KBujER2VfCglwmu4qmiDnagdN5Q+oTr9qdhfarS/XmfLSvlSu7ON4cirJ5iccnK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBcHXxsdm+wf5bTFMS/9j8E2D0dctkB+v2o4r7vMNfE=;
 b=AhQeBqBwSOtTX4UI5J98vnbRN+bJXXh1se+6SvdN2/PiWW0ttsGIH2UU5XDqUQ+0ItrJ6ISEQwEpDKYJ0Kc9+pthzQXkB0ZeARdq05BeevVIpkqYVaiyDBhGEYewZ0Qvq8dwg2GwGAZZNIMmcQgQxQI6RansbRGfby3LVncM3xt979M6xizn9lQzj7iVavdxtM/v1Te+HFC6bfI716TneVF5hIZyCu0RNTJIIzJaDNUBPXpOhhVMvCy9/RoT0m7RsZWResY/gmQ2Or9cDS+yF9Jo2dLQx9EzG5TrsSjQoW48Fv+s9ZUWD5Peus4b5TIlz+a0Q41D19LGntGJ4PDjiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 01:35:38 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 01:35:38 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 29 Jun 2026 21:35:33 -0400
Subject: [PATCH] mm/page_alloc: free allocated PFNs if the range does not
 match
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAGQdQ2oC/x2N0QqDMAwAf0XyvEDNpLj9ythD6VINSFJSGQPx3
 1d8PDjuDmjswg2ewwHOX2li2mG8DZDXpAujfDoDBYoh0gOLM2MtiqaYts0yZtNdFvTLZndzrGl
 fMeUcwkh3muIMvVedi/yu1+t9nn+j/nYUewAAAA==
X-Change-ID: 20260629-free-pfn-on-alloc-contig-range-error-path-acc001232468
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: CH0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::27) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 876cf5de-2823-4843-23a4-08ded647e3a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|921020|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	pOT+NS/zDQy79O1+7y2Dj+TqF1fakenIFwPl/Y7m9uKNU1KfYuN/l/E4bUOEVhNQMkziC+Dzhf9JO7s+zwK1vlo0n8XuYoAqr3l/xACcc9IoEEjpH9qztKPj0twTylpffQpxls5LB1UPnTbGgEWPhbnO2AaVFO/yqP5j5TlKLAzDiAw/Oi19og2mGxn67yiW+urgaoM5W8exVgUZGsfO//vJmUmhKjSE+LGdJwTDZxUuQ3bQlOyWuXxW1XxljqXBTlD4W5FeoyeBA+w2aoKPBXMaHfA2LCvTkDE5g2QVpKS78dbodc6HxAkgKh3+yJYA2ssgL8Nd+riXWw2zFvGDai4zOW3ItpXPKPGUknO+YQkMSmehJb2s62RQnkk20sEQkQpO7Aedmxy6cPqOU10L3sw+8KOGK4fAQrPa6C+YTrpCpI0Yy2zhx1gKvXpXbLh70k8VedPSdAxEGBOeuf9RX+uPLzib2eZNbOP+71bpA3m/LmP6dS8CDitNWG6ePKZIs0aIwvId29XzzBToBMygpr9MnaN6TRXh9OANGaKKscs1qAqW/k0PHjN3MVFUadfcAEKdmW8DnU2e3UK7CGt4JwQOFuKsNCC3RMVZapiL0J2WGJ4Fq0gOS0QFKUxI8aahcpZvAvF9dkK5UQFNWLD39U0vCtAoqC952ewuCY0pnsoB3Edw55ZyvlMe9LTAAyGuhxG9n9KsJgFKL90NLD15Eg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(921020)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3ZRaWlNaitMK0tpK0RTaXlMek15LzN1TnhINXhicHNlcDM2SUUwaEJWSUVF?=
 =?utf-8?B?YlRGWkZicW5Gd3RUNkE3QWVnY0xrOThPY0xxMlNZVUw5Z1ZSZmRqVG5VdjdJ?=
 =?utf-8?B?MVdDbWkyellFRG5iSlZ6KzhHUlRVdEdxbnhQcEp3RTUzYXNLdWNITHdZRlFW?=
 =?utf-8?B?RW52SWgwSEtqRUJHWGNCZ3pvNEJLWWN1dlUxeGRqaEFnSE5mQVlvMVAvVG9S?=
 =?utf-8?B?NzNha1U2MDZ3T05KMUNYWUdHTTJGQVNpYnZvSWJnbE84TDBkcjJDNklEQmNP?=
 =?utf-8?B?MUJYd0pVMEljWVBSQlMyV0VzSS95aXl5RVFWbVBNd0MyTko0ZTU1dEc4ci9H?=
 =?utf-8?B?Tm1KdGYrQnpHVEFYa0pYZkV6VzUrRnpBUVBlbWxZejROMHdJOVpBVHVwK0dP?=
 =?utf-8?B?cG1oMG9UN0pLWmg3UTZ5ajk1TE4yNXFtOUFKME5ma3dieW9lMUc0d25CUHZw?=
 =?utf-8?B?VDN2bmRwcjNSVmYwM3lGa2lLNUhvK0dzZU5aL2w4UzRENEdDVm9zdGpldGxz?=
 =?utf-8?B?QW1mbHVzcnpFZ2poS2lGNFEycVNVc0FEeWhLd0lRblNxY2p6ZkR1WEVza3dm?=
 =?utf-8?B?VHhXRklZUmd1KzlyVnlIeU1SU2ZKRTlVK1dGSmxSaVg3emRQaGo3amFRaGtF?=
 =?utf-8?B?NmFJSGhUbmlKMEVSZGtpK1lDMEx2enpaUFVDb0pEcHpwV1hvaThuV01vZG1m?=
 =?utf-8?B?WEdITXB4YndoME9RSFdBK1ZreDU4SXpWdGhUZlFPN0kvK0RJUldCbW1wV01E?=
 =?utf-8?B?L1NRUlBvd05scFh2eFJTM1Bxa3lySDhVRGQ3TmdIc08zZ0ZNUkJIeFd4ZmR6?=
 =?utf-8?B?c2hxb0NYdS9HT1MyWk1BM1dzcWhSbmlxMmQyM2dvaVJpbTFkUklqc20yVitv?=
 =?utf-8?B?RmZRVDFWYjN6ZkI0ZmtTQms0eDdoSEpvME15VEVTVU5acnZncGJ1SmgzQ1BN?=
 =?utf-8?B?M2tsTkJIL2dBSE5KZk5HZjBLYTczVWZ4eUw2WGI0U1Jjalk0Y0JFVnBwSHNC?=
 =?utf-8?B?UU9OSmZ6bjhNV3pkVWdvZktadzJtVEIzVG11OHFGd0UyR1FsWHlTdGY4RG1U?=
 =?utf-8?B?T285OG5xUHIrRnRRWGhZMlVqTTZKRUFyZm1lc1h6RFZpSkV0Mlc0QmhPbVpZ?=
 =?utf-8?B?S0R5VVFTOXNXWEgrWnI2eTZPVFF0NWlVZ1hvNkR0RE9HT0NyMjBxWDF2QXVF?=
 =?utf-8?B?TnNTOEIwU0NHMTR1d25yRXZxbGg0QW9JVHJhVk5ucmNmWXB0WHhXaVJEb29y?=
 =?utf-8?B?czc2ZEkxQy91SWo4ZHIrN1NNdVdpb05mZEtNVldjMU1LTDNTcmU5UWpVM3lH?=
 =?utf-8?B?d3p0ZDVtZGl2TVRsWWROSHVEbkdBTHA0UkkzZ0J6SmFzYy90SHRrQUJZYkdT?=
 =?utf-8?B?elFDMlFGbDI1M1VzS1JqSmFIWnhjZVcrdUcyT2dlbFd1a2hGZFpBbERHUnlB?=
 =?utf-8?B?VFNLcWNLVlpkUGZMZURPc2kySVBkZHVZWFFrQnhZTG5oTTVZUjJONmNQUmRw?=
 =?utf-8?B?cU9PL1JjbStWYlNaSm9rbjBjZlBqYWxhWk44aDJvS1Awcy9FbTFFcWJkMmdS?=
 =?utf-8?B?R3ZoV05ldkxzMWFpUGJlSHpmNHJ5dkdnK3FaZGV6c2FnZi9hOVJkSGl6TmV5?=
 =?utf-8?B?dmpWWmZQcjZRcjZqOE5ZS0FNd1lzOVBGSFlWeEZFNDM0SVU5bGcxQklVVTNi?=
 =?utf-8?B?bktVb3grOUhITlZ2am1waUY4ODVGNW1vMi83WDdoSDRFQmVTemtkS3pBaHBs?=
 =?utf-8?B?M0ZrR3Fwb3hETVMrUTJ2cVpKR0o3NFkwd2QvMnRCMzVPN2ZUNVJvUTNTQ3Q1?=
 =?utf-8?B?NmZ4ZEJuOU5jcXIrRHU3ajJuV0tuOFJ3SEJ5TUEyc01HMzdpUUZmY2oxVnFG?=
 =?utf-8?B?TVZMMHpSTFFaM01rRC9mVUFORFo5YWRGakk0aGIrU2lBd2FRU3J3ajBIL1BL?=
 =?utf-8?B?UTNVSDNVS2RMVXhpeEpTc0lQWGRvZmJXeEFhSk5WSXVhbzZvRDNsNUxidWZm?=
 =?utf-8?B?QW52dHd2MjZ6VEdydUphaW0vK3ZLbnRGZFIvc0tkWWwyQkFVTEhXaW9jYi9q?=
 =?utf-8?B?aTVxNlNLaVZnWnV0dm1ORDJHdVhMQTRXcEp1Q1c3VmR1aW9sLzVvNjFRaXhx?=
 =?utf-8?B?NGlKQWE5aXJCSnZPRFhEdUJxMDlnL25kcFdUQVNpV3lONmdUQ1FxdVhCZ09V?=
 =?utf-8?B?cW5kZkU0U1I0OW9zSUVwU0NkbWQyUzVlNlRGNVd3STVla2kxb0tkelUyV0kx?=
 =?utf-8?B?OGRtVzFrdnVJVk04MFhhYmZIYjZiWlh1c0dPY3JqeDBJb1Q0QUJDSUtxM3ZR?=
 =?utf-8?Q?yBAgxeUwPzs1OFfA2f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876cf5de-2823-4843-23a4-08ded647e3a7
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 01:35:38.4837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnCwmPtHJDs5a3PC73iuXs3XqA53T3zni4ZVN3uaY5uhrKbzVZBeeLLmbbqp2UIm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871

When using __GFP_COMP in alloc_contig_frozen_range(), if the allocated
range does not match the requested one, the code errors out with EINVAL
without freeing the allocated PFNs and causes free page leaks. Fix it by
calling release_free_list() in the error path.

The issue is reported by Sashiko[1].

Fixes: e98337d11bbd ("mm/contig_alloc: support __GFP_COMP")
Link: https://sashiko.dev/#/patchset/20260628-keep-subpage-private-zero-at-free-v1-0-f4ce3930d10f@nvidia.com [1]
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org
---
Sashiko reports that if alloc_contig_range() with __GFP_COMP cannot
allocate PFNs with the given range, it returns EINVAL without freeing the
allocated PFNs and causes free memory leaks. Fix it by properly freeing the
isolated free pages and adjusting WARN message for clarification.
---
 mm/compaction.c | 2 +-
 mm/internal.h   | 1 +
 mm/page_alloc.c | 6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b776f35ad020..4e3f06ff9304 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -88,7 +88,7 @@ static struct page *mark_allocated_noprof(struct page *page, unsigned int order,
 }
 #define mark_allocated(...)	alloc_hooks(mark_allocated_noprof(__VA_ARGS__))
 
-static unsigned long release_free_list(struct list_head *freepages)
+unsigned long release_free_list(struct list_head *freepages)
 {
 	int order;
 	unsigned long high_pfn = 0;
diff --git a/mm/internal.h b/mm/internal.h
index 181e79f1d6a2..6f9e5c2a6065 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -821,6 +821,7 @@ static inline void clear_zone_contiguous(struct zone *zone)
 }
 
 extern int __isolate_free_page(struct page *page, unsigned int order);
+extern unsigned long release_free_list(struct list_head *freepages);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(unsigned long pfn, unsigned int order);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ee902a468c2f..c1a35adb40f1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7235,9 +7235,11 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 		check_new_pages(head, order);
 		prep_new_page(head, order, gfp_mask, 0);
 	} else {
+		release_free_list(cc.freepages);
 		ret = -EINVAL;
-		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
-		     start, end, outer_start, outer_end);
+		WARN(true,
+		     "PFN range: allocated [%lu, %lu) does not match requested [%lu, %lu), freeing allocated PFNs\n",
+		     outer_start, outer_end, start, end);
 	}
 done:
 	undo_isolate_page_range(start, end);

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-free-pfn-on-alloc-contig-range-error-path-acc001232468

Best regards,
-- 
Yan, Zi

