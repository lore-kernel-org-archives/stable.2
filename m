Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD067275AFD;
	Mon, 17 Aug 2026 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999240; cv=fail; b=Uy320TZ2uRMf4q7ZHp716QVr7vxpUiag3DNKRbYQRYQRbkAJosm4TqN9o4JrlmxmPLhc7xakCUqvymV8Uo7n4o/4QLU0OJxVEhk4qw8QbmDNlmy5PhAQE4ONmuOs8oYb2xlvubvc9iM/Nj0LZEuATCnqDBIUWfsnIfHMGLLJJQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999240; c=relaxed/simple;
	bh=0nscAM4Yjn4NLkVfpGhd632nZttTtXsVtrsPg6nZ1t4=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=pDGW0nvIwiWk+ZW+42gRGo5Jr5lTxYQ0Dyht9GnchuIHlvy04zAoa7V9OoFVp6GLRFlOke2mN4zuQIGl6MnzET/P0g7FxKdqGEUeKrCyZfs+mxP/z4KZlz8uHO0or1BNUACAj5RTPB/lmlx6QUif+1ulp4S5rFvbiXRTcJzZ3qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=neXNdyVF; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="neXNdyVF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCegzLCkwr6/6U72DlQ7hqqOZu0iB5v6Ea1Sag0iCfwofBHSaQmHFdbrC+M4rYjz3K5bV5WErCmucTqxqmY7XvwltwFq+chwsK7wR+SDQ2eTBtsJZdmpaRcoVw1osQU+NNOOmjjgWjCliPAc0O0e8I4FNIyLyLFb7z+vMvddeQYCyrXrPcpSepGAdOVS3foHT82fPdNw0kCBqZ0KkBABfbhO81YtMLc5ku9vNyMYavN1yucolfL2rlbobM0eyLa3yMMaKAVhyr26JgLvrv59Xuvb5f5n0GQNZBey0iC74TaQVlKEHMIodUjgZJ/RFSX8amuplGOEmzNcozUuDzMj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzAeG05qIL7rVxiu8rm0D/X6exi2kI1nigj8ApIdqBI=;
 b=R+2R8CWM59qeTLUEoh0rNyPhDIXRsyPo8vhXV8Qzn4fdxynlTermkrAYYCTpX2t1r/DGsl6jw88B5+qnT+Zpl2q6KmY4G0aU8eQloTajPxex/cKUPg/jM6K/9+P9ofzAjQyjGca7iARHF4LdoOV8DrPl63V5IWNiLV4DYoImoReR6f6I8f4ZZiXehrgnwAin5uUDZPtv+97L0CV3NK9Kn3uG55L39Xw7tTIkhobXdPDZzGsVEMO7jQcpQkrW49uUw+AxRzrXa/ZjRGIXkaoCnMetuz/qVh2uzwEE/uRE68/EIn4RcPgCpWDbWiM1pLSlMa1mGj6cEbWV6wmOJ4/8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzAeG05qIL7rVxiu8rm0D/X6exi2kI1nigj8ApIdqBI=;
 b=neXNdyVF8hOu6bKdT93C/gKVez2P9cPRlN2UKbHqRZ1apwNMDNU24+/2+9KYrbbe88pkT/cSNokcueEt8ImAcnNvzpDhKKXOiQnAiJi8tvWm7IdqcYYI0U4t5RCoX7pWOgV6GRJLHjixojswssWHgE0gr6fTCFnwYOriE4PYAB7svzR/PV1lSu14GEa9DfRxe+MNKnojt9eLpfa5I7mn4fn36Ng245dfDsV+k4isYuEewwAO2uBhUsl6yoz2efYrrE0BMOaKpnOU/HDLCjjGtbBbZHRg+0mmru2J/4rJrVpW0+Lw19LQdIThEkJg0y4S51b2VLsVaa0biElGy+qcoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 20:40:32 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 20:40:32 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 17 Aug 2026 16:40:18 -0400
Subject: [PATCH] mm/slab: reject unsupported kmalloc sizes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CQAxA4auQrp0EZowYrkIMKaVoZfjJFIyRc
 HcGWX6L91ZQDsIKRbJC4I+ojENEdkmAXjg82UgTDTa1t/Se5cZLL3PV9ej9SJXKj43DK1rKXc1
 IEMMpcCvf/7R8nNalfjPNxwm2bQe9w/MCdgAAAA==
X-Change-ID: 20260817-limit_kmalloc_size-3a4a2c73beac
To: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 syzbot+805630f1453e490427fa@syzkaller.appspotmail.com, 
 Zi Yan <ziy@nvidia.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: YQZPR01CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdac203-6960-4f46-830f-08defc9fc7fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	j+uS/zCNz13z/kHH3c5CZfWtK8i6kiG6xRoB+7ypERxhZHy7D/PyiWI7XJdYkNgf9eXTB0AbP2BtlIgRoNzh0EDZAxvwRzKsdblnMXFXfkNGMUGoatahtUQTpVwNiJimXm8cMNz6T9opVB81yBvRAnlqtkVQ2XDUgALxJHSA9jY6nl+pUkCNKMQsbdjLfuLxYA8gngflY+EWi4K3t20Es61I3MgZ1T7LxoIUxS+Uimm9JF0+oCbVlev5YGWTINlf3HYpFt1MfeJVmyOC+HbNsnA+rgbGyMOAvJwTOIn2AHn006Z8Dejp8kXDpzHJnbpXxv6J4aYCcc+jCxxEs5qt5DXgN53x8f2o2ZnpUk+DrnWh5bAvmp6EKT+8jMdfLewFjb+bEXd4ySXnLabln8kzLFfTtf7n8iDTOhOmA70Ag+gSez5nltJKiRjkSN/2hx20pPB8AVdk5sPUanoJ4TALpOCcUepNsRdlf6iSnh69B1Ics/dGv5Q1+8xvUsioiLR+lRYei5c+Dqdfm7D123wLgpX6hoxHyDwPmFrD1Vx+z7Kg5ziJwj8h1+ZGKnLiT59j0ghkRAeIe9KNfWWBbuQ9mX8gmuTLqZBpWzxLo+20NPHPX9ndtcRfRxD4rQndqMPchDgwH1K9bYufeQr/HTPocyEgXSEdAfHD7A0ZLERSnVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHgzbnJLbmMxekZ0Y21LN3gzWUJTdEpvVm5KbFBYdllhYnYzN0dKaUYyeERo?=
 =?utf-8?B?NmZLNjJPN1lXbkhpaWJ5TzBUNGlpbU9nRUVGVU16TWt1cGZBNXVWcFE5aDAx?=
 =?utf-8?B?T1JVMnRCQ3Fpa05jZWFmSkRPL1lYVHJIWVJ3YnBVdzljK2xDZ1hjYmE5NW9H?=
 =?utf-8?B?UXVINTJMZWwrTDRuQlpMcEEzTS9ZV2oySTIremdFUE5uR3VJQmpoRFd3eXFZ?=
 =?utf-8?B?SHN5elNTbHRaYXJWTi9Tam14NVJSa1dIbElpWFowRkx0YUdZbGV6TDd4cDhr?=
 =?utf-8?B?ZFJyVU5BVlpyZGhYdTFQdjlhMUprbXJTSXVJTnhmMDRKYVNFaTdtNWl6TjVi?=
 =?utf-8?B?SldOYmxjcDlPVi9CNE5jTHdoeTZUVlB2eWRHUHZPUmJJSzJhTTdvWThBKzJE?=
 =?utf-8?B?bHd6cnQyMEI3YmtVUHVQdHhYQlNOTkx0YlJRWjgybGoxbTdnZC93Z0lkYnZX?=
 =?utf-8?B?NTRPTWJHZDU4c20yenhpSytmdXp3TjJPcjhiV2gvSzI4NkkySmZ4SkxxdmZs?=
 =?utf-8?B?U2IwZHBaL09Zd0NYN0VaUlZFV2pkcVg3dmpPZFEzc1ZYS2JMY2NydEgzbVpL?=
 =?utf-8?B?bWVQMUZNMDBoWis3amlPRlNEVSs2eHp1eTdZZnh1WmpWR3orZ3ZBTEJWTTJC?=
 =?utf-8?B?cVhKcjhCV3pxVjA4a3p2Q2l3R010a0Nja3lmbFFqeDlsR1VIcXhIaGdteTRo?=
 =?utf-8?B?eTZJbHgxVGFVZlhKVVlPTXJjUlJ0WVBOTzJCL2xvK1VhdUxmazNINXAyR3VL?=
 =?utf-8?B?OUsvLzVvODBabXRKYjNBODdDSXpuUE45Yzc4dlRYSzlSd0JrdVV4TUJUSnIr?=
 =?utf-8?B?bjRVTUJ2ekNnVytUa2pmTGFKekdkZEZCZWxhZmVNeFNJTTFVUHVuWEovVHZ3?=
 =?utf-8?B?eFZhTFJlOFJrTlBGLzVKREx3cU9WOU5hb0FtSCtJbFVhblYwT3FqZEJWUWhM?=
 =?utf-8?B?Zi9jOWRnK0I4Y2tRL0FFNGlrNnRtN3JSTklibklMYzZScnN5K2tmTjBSbVBj?=
 =?utf-8?B?ZG9xVEJiN2ZhQ1g2VnZ6TzNmM2V2ZytoU29ESFVhelJMT1JLSm9PN2NmTGtX?=
 =?utf-8?B?b01kamhBdmhQQkcyZ3F5T1k3UWJMRHVaTk9Kd0hQSGJMRnlxVXJBT3RXWXB0?=
 =?utf-8?B?b05tei9SS2hqQkUrSWZQL1VnT0ZCc0pCSEdYNVlveDBWVEROOVRKZWtOaVY0?=
 =?utf-8?B?TVhlQ1l5ZXgxNHRENW1QZ205TlFoMDVTTEhseXlQWm0raHlvTFVrN0M3a1Rm?=
 =?utf-8?B?S0NZUUFIS0JLLzB2MVZ6aDgwUHpqVjRSZ3o5OXMxNzkwVDcxNHdvaWM2QlFk?=
 =?utf-8?B?SEpVN0ErWERPUThlVnV2TkZFSFZQTHhrdVR6dG9iL2MwSnhqdkxvMG5FdGRx?=
 =?utf-8?B?Mys2dVpObnZnSDB0TThZYlhwMXRCNUpiaU1Rd3FmaHo4U1lEb0JMQmdCTy9G?=
 =?utf-8?B?Q3JVdEkrOTI1MTNFK3JpdE5SY1ZQc2xJalNET2V5WWxwTm1MOVRxazlPam5u?=
 =?utf-8?B?ZmNpMU56OVVQYnNFVkNZOTJXN204UWR1bkZsZnhvbmk1WERYeHlkVXg4ODl0?=
 =?utf-8?B?TVBVQURSYmJ2aWhFdXRnTXFCK3hTZWowWDZNYWJsalVkVXF0NFFicVF0K3di?=
 =?utf-8?B?VkIrUnhaN2pKU2F4L3NPMXArYXhuTlg2dVJObFU2MFFKb3U1bmE1MFZUM0lK?=
 =?utf-8?B?ZDNiODhrQUt6bm85U2dLTGFFYmtmY2diL29qUDF3SlFnVnIrdjlreFhTamVy?=
 =?utf-8?B?QkFYY3ZVbEsrc2dZZTAwMFFES0wzZ0V4V0VrdEtpeG82bGJNMVloZnhSK1lo?=
 =?utf-8?B?bzJqc3dNTnRZM1Rua0ZiT2NUZGp3WGtjQVZwVTlrM2hRSVIwTlQ2a3h0cFQ4?=
 =?utf-8?B?bjRNNTF3d2w2Q2s0N0FmK2pDb3RnYlc5a2JENXJLWUJOYi9GZ3RZVGViVzhE?=
 =?utf-8?B?ODNBWUhqVkhQNUJGVjFNaFkzVXVmcytJQUlWT2xRbGpDTVh5WDRwOHh3ZU5Z?=
 =?utf-8?B?dW9oVDBIY2pHendxN2JzZWdVaVFmZTZJV0VyYzRFL3FQb1JxekorakxNYlBF?=
 =?utf-8?B?Z1B4dnhxdjFXVGp6RXltWkNSbG9wU2E2eTB3ZEtuOUtsM0NraGp5T0Nzazky?=
 =?utf-8?B?bDV5K2ZCRmhaK29VMkZpS2VOaXNoWE13N3FpREdNdXVkakZoa1lHYnU2ZVNZ?=
 =?utf-8?B?RXRVWDBOVW1sR2pTNXBHNmJEci96emE3bDNELzdvZldVZjkrVzlTNS9JazZ1?=
 =?utf-8?B?TG5BVTZwQllZU09sYjhBSC95a21LWG04WjUrUHdGZnhCbU05b1R4cURWL2Rm?=
 =?utf-8?Q?rneMwVzCt4qDG9XYsv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdac203-6960-4f46-830f-08defc9fc7fc
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 20:40:32.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwFsaxjOMz2f5atl4Jit8BONzlz65ASEehynxsLaKevsCicWhg29c+UMQqhssfKP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591

kmalloc is used to allocate physically contiguous memory for kernel
allocations. For requests larger than KMALLOC_MAX_CACHE_SIZE, kmalloc uses
the page allocator and can only support up to KMALLOC_MAX_SIZE. For request
sizes bigger than KMALLOC_MAX_SIZE, the page allocator can emit a WARN
because kmalloc allocates an order greater than MAX_PAGE_ORDER. Systems
with panic_on_warn=1 crash because of this WARN. Fix it by rejecting any
kmalloc size bigger than KMALLOC_MAX_SIZE.

Fixes: aadb4bc4a1f9 ("SLUB: direct pass through of page size or higher kmalloc requests")
Reported-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a820ebc.9ebadd4d.20b15e.001b.GAE@google.com/
Tested-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org
---
It fixes a page allocator warning (order > MAX_PAGE_ORDER) when gadgetfs
requests excessively large memory from kmalloc. Instead of adding
__GFP_NOWARN to suppress the warning, as was done for usbfs[1], change
kmalloc to return NULL without a warning for this specific issue.

[1] commit 4f2629ea67e72 ("USB: usbfs: Don't WARN about excessively large memory allocations")
---
 mm/slub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0337e60db5ace..a3071f4ef1945 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5263,7 +5263,12 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
 	void *ptr = NULL;
-	unsigned int order = get_order(size);
+	unsigned int order;
+
+	if (size > KMALLOC_MAX_SIZE)
+		return NULL;
+
+	order = get_order(size);
 
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260817-limit_kmalloc_size-3a4a2c73beac

Best regards,
--  
Yan, Zi

