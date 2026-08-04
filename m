Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F32D5922;
	Tue,  4 Aug 2026 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877488; cv=fail; b=Z6ceqqrGgpGKFp858EmIBPtdSXJcjPooZZR/Qw88ajcRBeQlYUGJB256O+IAbOYpUfxVafRJJ2G4RezGPP0mxqsAMOFPo3RDLPxTfKuhu8DLz8QYrb05Qfr79uor1eaHpiwFSGyD7Jyijm+lV6Li33Zqgg7AHikQnUArvavZHlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877488; c=relaxed/simple;
	bh=5+JzvniuvyPV541DQ0aR08mGZoumijHybDgUaZcei7E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JfF4RbwKMwTNIbfTwhbWnOk7VisZw/NlgScmTAqNWqJD0s5V83gmT07/+0sFTNr+polObkZSITy8StgS8P43AqBptvhibWm/UQA64N64UJJn397zYe3mYmQTeRNZ84odfE5rCbQEffd/qXv7/o0a1g1rouDfuSuk7vXAegVlYyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aEYcbBTT; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aEYcbBTT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nvpe2i9+5yPXn9U6p9Zm1lljDDSz41Y/1kYdJdR/dwx88LMgcpKz94qBShGgh5TfSvli3ELB5WQ8cWOBbuoHa9gLpw+OAR1fDKY+KYTshRnrEXC5dZwsbJ2nfSnpYp5DiEhObmegQwRhxjEkk0aK07j2vKzHCdhzl0Mby66fGH5fbmSytq3euffe7FbS0ZwVvET1hcZVoVh8ItiP1eYQhfVVTi5HaIk0WVLDR2dDKAsbAjTJXJTE0xrGdb+HUh/Ubu3CssK5raBivu1o05NJHmB1b8b2J+QwyAGH8vgQCA6qAwWbfPpvQ+goq5ISJz++ts0Qdl9XvgzrnOskX3RJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4S+m23xlBKvBqpZsZ91mt2HRpKesyJrx0XFG6m6+Q0=;
 b=HSmHe9oaefi3/fhI4Q36IXz/naEnmRUCc8zLHxwHt6Mo8RieUgiecwomxfoSvL6GhMabD8RGPVYPHKV/1Y4bilTcWRp5OPZWkdcWy5EsiV1w2zlRjyqk0rjwMX5MioLqQxkS+aWHKv+/E6Kh4LZXxXEfKAjtrF28IDoLywNqZGEzCQfqrQMtKgtfHcmjz3X9mzuFfbircbd9MPZPiudxMrWEMrosc9eXTPueIceh+4TNdsHiy6VCQy5A7fzHmzOkaXSHh9ZpzU2Ma8OpoYPJA86m939wUf9bLgkan4nJswUwZ+EtrN6+YDPYx1YAFyEGpYgR/flTQicFlgX8Gt4D3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4S+m23xlBKvBqpZsZ91mt2HRpKesyJrx0XFG6m6+Q0=;
 b=aEYcbBTThNovO5IS3qamnIERsJqVpoNg+9iKsBruk4yn8Fyr60fmHnq58dJWCUNnd7nc3drNG0YPsCELEhmit1+4oovASu4g/Zy3x63mJilwe99X3ALoK5TYIzBG7MthAz8Q5s2jPv8iwIicL3wRn6HVYvokxEk4OJnuBohU4U2usbir8bnnRyMPjm38s8J8WFemcGvz1G99D8Zkr3ZoGaR+U/YzjuXJFIpPG81GdiYnmac8p9F3ZQ4jfuh4Py/l5sD6M/PsXwjh3xdIUCMWCIlWfUMhxHK0zNiECnKHgBaB2UaQuhf8uIDO+7Uqro7GulD1Rwcmmi6qy6q/NO8SxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) by
 MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.15; Tue, 4 Aug 2026 21:04:40 +0000
Received: from DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a]) by DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 21:04:39 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 04 Aug 2026 17:04:28 -0400
Subject: [PATCH v3 2/2] xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-add-gfp_account-to-xas_split_alloc-v3-2-38cb3ff325c5@nvidia.com>
References: <20260804-add-gfp_account-to-xas_split_alloc-v3-0-38cb3ff325c5@nvidia.com>
In-Reply-To: <20260804-add-gfp_account-to-xas_split_alloc-v3-0-38cb3ff325c5@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: DS1PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:8:44d::18) To DS7PR12MB8371.namprd12.prod.outlook.com
 (2603:10b6:8:e9::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8371:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 78792e03-1aef-4d52-5aa4-08def26bff6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|11063799006|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	L16MSbewyQDXw9fl3ANAfQLDrJjSdKITRJcz41EKmrU3AhTif31Nefetql+aJaYkjPAbAMJ/Zu8yC0NsEWTt2b9gLXmkY8cg7LqGFYKS8kln4KtlFxdZlZKkPEJ0aA12073XfDmGtXB8+l5MuRZmq/4hIFKZRFgg79EIA6l8QjLnjuS/vEMWNzeUmkGUnhaZuOgrhjV1UbZ3u1c7G3K/hQ6ozX34HaBaDCvqjIBwlzTI/htuH2uCPVBFIgd79LDHGHdDwdAP/LagLw0vok/TezjdGq0dzJpsoAV1Plo1qi8D74T0c7T/gVkEEHJXaSd59+vXmetAlbEKvWnJM5Ct4d29ud+ZTgcdQ6xW3YZ0yn9wLbqfxdSk+fqCZLuz3arA39XSy+kc7vKunI7bTIRn4irbThZEsrl/pzFvSvxhzIKZut9fq8NmgGb8MM6RP4d9eAOIumM1PBX9Hq+CG3YZWrvYZ2Ilcp7qGYeBTGUKk6fkRFwXjiyguCvYeLkIHI9OpQA8GTKWUuHpjR/4nj1RmO9B+5ozYrU8mBoZoHrCzXYpfRTnrWjlS0kC+yzhuf1RNCM/oYMzJc7d+G9q/qjwUgV4Caz6FDhSDz8OzEtH+8g4B5dbrUYrX6QbKpw4egK6UgPSCIv4x7XNsCzAoTj50uP6hQnnYwM0NVZUZ9i7l+O2+T6nLmPhIwVHqUN9RUnjuBBEH/oOMmwf2/9yd2q3eQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8371.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3pvdFJqYTk2aXNDZ3Fwc3g3ODRVSlFrL09ScDg3b25URkNlY0FxZld3NE44?=
 =?utf-8?B?ZWZJdUhMWU56RWpNNm91WGROSWwwRGhUNlhhRHF0OU9RSzBiOEk2UlNLSGhQ?=
 =?utf-8?B?TnJueXQ0SzNLZHNBNVh2RnRiR2JzMWtjNkRWc1BVQ2VqbkV3TFRtNlRGaFR4?=
 =?utf-8?B?QWJ1MjQwT2kvM2pIS3N0b1lRMnBkZTBqSW9YWXJEN29qN1JHNHRFOFkxd0Uw?=
 =?utf-8?B?ZXpOL0E5b1dDVjJYYmNVaDF3clI2UjRpMW12NXcwNExEVWNHUEJUaTRkODVB?=
 =?utf-8?B?YjhxZjRCMDJaSGN2L0hYM2poUHpIRlZ3djMwamhUV3VGOHBRSkxOUXRHNzNU?=
 =?utf-8?B?Y09wZlNYQnQ2V2N2TXBKc1RvUEhNWW1yeDdvWm9IWkJJbUYxNlMybENSQjhG?=
 =?utf-8?B?Zm9BaXJ3c0syWkIxcDlZcXpKL3BYUWxoS0p4MmJpaGx6OE1yaXNhOVhyb2l1?=
 =?utf-8?B?VEIzd2ptM3NlVHJRQmNxbUNuYTZjayt5bUNQVUFWb0M0cklxcm1qWjY1K0Vp?=
 =?utf-8?B?d3pxS2xrc0Y4Tm1HTGdrVzE1eHVaM2R1dTh0TG8zUWlPZUFCQjBMT2ZzTGJs?=
 =?utf-8?B?bU4wVlBKZmNNVk8zVmtxTG84L2lWa2FqMkhONEcyLzRNMElNZElKaXUyeVJh?=
 =?utf-8?B?TURYTnJuRTg4RWhyRno4c3F0cjgvOFB4dDVrWVd4SWQ1TmpXYWRJOTlucmZq?=
 =?utf-8?B?V0tYcHNpbXYwNjRzcUdqWDYxR09EdUZFZ1N6Ujlkd2dKNkNlSVBDcWRCMmM4?=
 =?utf-8?B?TnBxbVpSNnBXbjVCMHk5NnhBMzdXa1cyVm5jUmVwaW1YSjEzNnp2YU9hb3dv?=
 =?utf-8?B?TTZtVDY0cXltVytQUGRxcGc3YnZVcDBBZ25JVVJ3UStsdTUzSE9QUlV0RFVE?=
 =?utf-8?B?TUtHOVIwKzEvQjl5TExyL2Z0R2pSaHVLY2lUU2ZPSSs5RjNUYzR2ZDN1aXMw?=
 =?utf-8?B?R3RtTkc4cnpFL0s3cnlqVnptQUhxV0xaUUczNHJpOVdpSmpzWXhaK3ZMT3BV?=
 =?utf-8?B?dUdEZ0ZjUHZtaENjbExOeE8wWDhkMDNRQnhFbVp3UjVsM1JjMXNXSUNlWndJ?=
 =?utf-8?B?aTJuMmxkZzIvYitrOVFUbWhQcG9zV2NvWGJ4UWJQRTJmU25wbmJ4R3FIZy9o?=
 =?utf-8?B?MDNZSUpUNmxZUkIrR0VLZnZ2ZFVnUjdwUXRzTXRnNUJLb082NGJ2RHNIeDBJ?=
 =?utf-8?B?Qk1sWjVOc3lOaSt5eEgvWXYyR3JJQlFQL0R0aGNHMjFGL01IaFRKak03TzM0?=
 =?utf-8?B?bkJzbnRWN2N0WmR5RzZxRjBTUnhsQXYwOVdkSHFsdjBpOEYzNTJPVWJ2d3pE?=
 =?utf-8?B?aHJLcDlZaUhhd3pFTzlZUjQ5dDRSUG9JTjloNlNtZTdKdlNCckk3OHRQZzQ0?=
 =?utf-8?B?c3BRZWlHU2RxLzFsczhRZWFYN3VINDR4MDNJMTBQWWxURHRKK1cwQ2VuclFL?=
 =?utf-8?B?TjVSTUJiNzBkSW9hL0RETnlEUXJEdGttblFUcFRJWXo4YXppRXI4MmFPYnFD?=
 =?utf-8?B?NGJPVlpjSThOZzVRaUZTcHlnQkZsMWZnT0NzSXE3aytWbUVqaWx3Y3lsTUF2?=
 =?utf-8?B?ZTNJT1FXekg3VXFycVc3V3puVVRPRjR5MGFFRUNuOFFGNDRTRmJFM2VyVWR2?=
 =?utf-8?B?SVRnOXRMb3VDa25LbzJUSTIwRy9ZVEswTEYyMFhLRTYyN0tqSHU2cVhHdFBm?=
 =?utf-8?B?NXd0eFdVVDBrL0Q5NUVlVDdVMVoxQUI1RUt5R21FbGlNQTVwcW1TS2x3Y201?=
 =?utf-8?B?YUxPdWxOcFRrMlUwc2VCQkdTWGhyR202UFYrRm9vTFBqMWlpZHg4ek5wNWtU?=
 =?utf-8?B?L3ZPN3BvU0MyOFhRNy9mMW9kL0g1SmlqT0tKSnpqMFlkcTI2bm9jbVB0a1Rt?=
 =?utf-8?B?UzM3SElIb1dXdHRUci9pbmY5cUxCS09pclV0M3J1T040UGx4czViZGN1QkVW?=
 =?utf-8?B?NTJoNGVoRTd2Z0dxeHpYdG4rUm9VQmZlYjFBQmtmRHUrSWpKZmdKNEMvOUFM?=
 =?utf-8?B?T25iZ1haRU5QSTdEOER1ZnJZK3VZR0VnUWRNazhxUk1UYXhmYVRsdm1SbXRW?=
 =?utf-8?B?bE1GNnBEc0s4RTlIRGw1NlhzMFZQY2NxcFdkS2ZJNW8xNk1HQm5YTUp5c2Vl?=
 =?utf-8?B?elNRYVhzcWU2b3BiVlJ2YWphRVpYMnJRbDY1WTBqQStFWGlyWkxZMDBmdHBm?=
 =?utf-8?B?WXNCVmljV0J5Y0cyaloyeHVreVZLOHpJYWVTZ3B6dWdIaU91TDZYZkRjb3BB?=
 =?utf-8?B?SUh6a0JwMXg5Um9PdDFBUnZnWkR2dTNpdkI0R3lyU3ZMZ1dsL0hRSnQ1aEx0?=
 =?utf-8?Q?RBYReJHLhWlT2IklwY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78792e03-1aef-4d52-5aa4-08def26bff6a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:04:39.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSOPH8loiAR/b9pXdmW7526DRZxJabwoAJWEOjya5EVHnOVljN9TtA1cVPWJHWAv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269

XArray operations that allocate xa_nodes, such as xas_nomem() and
xas_alloc(), add __GFP_ACCOUNT when the array has XA_FLAGS_ACCOUNT set.
This charges the allocated memory and avoids the workingset convergence
issue described by commit 7b785645e8f13 ("mm: fix page cache convergence
regression").

xas_split_alloc() does not add _GFP_ACCOUNT when XA_FLAGS_ACCOUNT is
present. Fix it.

Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org> # depends on mm-hotfixes-unstable patch: mm/huge_memory: initialise workingset state before folio split
---
 lib/xarray.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 9a8b4916540cf..bfe7bef80f34e 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1053,6 +1053,9 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 	if (xas->xa_shift + XA_CHUNK_SHIFT > order)
 		return;
 
+	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
+		gfp |= __GFP_ACCOUNT;
+
 	do {
 		struct xa_node *node;
 

-- 
2.53.0

