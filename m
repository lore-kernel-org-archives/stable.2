Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020087.outbound.protection.outlook.com [52.101.69.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DBE5519B6;
	Wed, 14 Oct 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991652; cv=fail; b=NsWRWE3uPMGK1zZBVFONsjfcIHJ0/PDkwLNubgpbOFwb2zU7eGOcDYNccWKDaPfTmEeIApKDoCxlnGrCK3TD37Tf2TDs1d2KnqV33H5phHSFApqZM4SEST4G3vTuCHGLXzJgYbvp48n1bQrUb30qHL4vyACjXPzAlgxQ6I1yZhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991652; c=relaxed/simple;
	bh=IqrjI1lUXUed0UGKWpxRXt0dLWYxaSiiVlnECzacSHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BtFAKnyMXxhpz0u58eme9mqL2pfez8+WKl7xSO5CNNiuZ5RDsNmxzU5vpgCN3hCjEd+6gcu8gYgkrCNqq87Gar6evoREVlhwUT3BMB0MNLD55NxghPuRTIRZx6EAREE6pEAJQESO1uSg7sMMINEjmeECzY1SOtcTUCiDJXrzLnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=mRoYI2yw; arc=fail smtp.client-ip=52.101.69.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mRoYI2yw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JURZXy6lnpmHF3hUVCKGCIQU83ad3ZOsc1Tf0x3131TOAYafDh7ql+F6WDHF9lVJCU83W531RUbQP3mr9et/nwQ0bCJNYG2jkur0rhYzyhAa7wy9o3mupKHCQ3UGJMwbCOoqPERfsUMOudnOCBG3X2Dwyzh9NEMgoga6VW/6cYnkTW2/0dcKpukvTPiSdug80r28wd0cRSQ0mWVOP+qdl8w3H6Sn87ktV4Xyqm2u/2FNmqXSIGzynPEU/0Ib80uyeb6dtSJrTw+ukEeeblkMXyXdN+F98T1btEnsDL0fvu7NXYYmOKPg9qopi5DwzLsgvCt3xFUhVN0JHXcYo63APQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfBpEQ2ryeYVrByhGL6wYfH0Kqc9ZBts4hFI2NsVd/I=;
 b=q0ZY9shYsK5F59HZPOppzVhAO2x17w3HfUyEVK6JCuChC91Z5U8q0BxkbxF0oyk92+AO/+UWOyJwqkBjUPy1Lri+lFX3al8EF5mqf4RAfKhwKr3MfrH//kZWLRJSwY/9/xXsQ16UIVDQUnm6kV5/XOBYwJPK38blDUTKXdRQrJnRdI/SZHaIaxD2eWPs1+BF+fm9X9R+4LiQPN9mOxz1PEHmw3h7h921sFpqtgTa7q3BpRAIvmV2kscw/iDgkXwB0/b9NwjY1F5Th8J8smSwwPUIEGOTuCc+RX+9jZUIF10AelXzoSk4kqWTXV9v11WCTzShEYA0HGqrbz4iEwMufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfBpEQ2ryeYVrByhGL6wYfH0Kqc9ZBts4hFI2NsVd/I=;
 b=mRoYI2yw/ObSH3UHLw0IH/1OBwqpZPE4ackwrRo8wWTsMCEaCcu3lsYYBQAu4zbLNzlNtUt4DqNrNEBy4Gc+3uU5orX8sbJYnLgPJzCNA5aKmZp8r1+tXn3v2epDa3RN2wly+5IPsIrZ1YDTepWyttf+EnmBnD0JVKs2AFahYTyJimZIcK0OdRESh7TFp07NkNjQuAB8Uam3yNhepthgxKCt2cy/US4k6WwNVGRgzmH+8fGVOrYPdOwMh3yBUf5z6mnuLfIK01sQE0NC2GVd6WeyzwcundGDYPEyane9ocMflW3bdDgCSj9Z/FrGK4HN1FNsL9AmdgCvQ5UJ92Ua+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by DU2PR08MB7375.eurprd08.prod.outlook.com
 (2603:10a6:10:2f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 15:27:27 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 15:27:27 +0000
Message-ID: <85b319d2-ba91-45cf-9f68-4182df93c848@virtuozzo.com>
Date: Wed, 14 Oct 2026 17:27:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: recheck a special PMD under the lock in
 copy_huge_pmd()
To: Lance Yang <lance.yang@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Nico Pache <nico.pache@linux.dev>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, dri-devel@lists.freedesktop.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Usama Arif <usama.arif@linux.dev>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, Peter Xu
 <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com>
 <58e8d79b-f7c3-4ded-9272-07c309917055@linux.dev>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <58e8d79b-f7c3-4ded-9272-07c309917055@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|DU2PR08MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ff5d98-58b4-4c11-cb67-08df2a07a753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|18002099003|22082099003|10067099003|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dvk+WfitNgf+sRbaaf4bunN5f9fmD8rb2mEeOrtJHQQMIf+leMJuWATYnLALrEIuuV1Nm9bHRGzvwkCiRXQ1RNdz8ErgE6JMmSF4uFP0RoW7joq5GtWojhX6BIbH9jRPUe9vV6TIVi/QonBij9F3obAxVlEVKJ9SLHw8yVLkx3KxSnQ/sFzzXdF2689ujOGSC5oYAD9Bo+7Rka7IfAqnRJOPmPyj8S2Wf6Cx/RHWkJBGVyIvpXUWZFzUTQ7iAk3RcTgzWxhPw4Pt6167mAb1ieP7kNf4ZOi1EsbefX7prTnNcVjfaH/KHF+LA8G5vKig49ChgkZzJE/SkKU0O1mLw0+peloxgO/vxjNyhNUmUDvxcrpYHeC0WJmPCop4R8Jrwd97nxn5xiWVwJdw9eCGzjLsWuPRjhQhIBprDAxsl3CU3KoQUxj8nPdpvnAzOUZVWmfMjtMIYppozdq+k3ME7/c2beMsT2S5e1/Sn2Yod17ht4+wCvfaDlnSPC6qSQ/QAxNrgABrnnzYK6JTwGnjP7ILk6Gyih7zmcyWvwbX+yru1TY8m/U1w5qd3GPr+GgOTwWkDxBgjppZAnzMgUX6V5h9cuHeJYDZ8bUflqs++ss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(10067099003)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJxaUorOTJKZFZ2MmhPUEYrY0IyTXF6VnAzYTVnMDJWbUNxQ2VCQ0R1UDBn?=
 =?utf-8?B?MFRaY3A4WTlhbmxaU1NYd24rV3dkTzVsSys0MGFlVTZGUDhmNlNYam9wdW52?=
 =?utf-8?B?UElEYjFEQkR5VmVCL0FXMXlQNytrV0x4dzVTNmY2SWVlTk1tVDR3d1cySUVs?=
 =?utf-8?B?anQvS3JkWU5pTEpOWXRiRTVpQ1o2NEkxckZleDVNcGVtSy9CZi96OXRsSTdu?=
 =?utf-8?B?RG1HUFF0WE5NRFZ0T2RQWi9aVXNOSitCM25aWGxNYXBadm03NHhIWlpibUdI?=
 =?utf-8?B?VkVSSi8xOXdaemVEL2FibHg2WEZkT1kwZElpS3pISmZhQ2lBYzVVWnYrdXpj?=
 =?utf-8?B?eDdDSmhBeDNNZkh2WUlZRkRBTmk1UlR6QVhET2FWR0xNWEw1UlVJdFlKV2ww?=
 =?utf-8?B?QmQ5NWs2UnpSelBpVllBNjc5dUZHSktyajJtdzNzeUFpLzdzVmg2cjdMblZD?=
 =?utf-8?B?NERPNDR0US96ZVRIWTc2T1JFeWoxTHNpMXFHK25QRXNqNHhVdjcwSnhZN0NT?=
 =?utf-8?B?Q2NmMHlSNUdiQ1ZSMVVKVzZmNm0wUlpvWWV1V1E5b1E1SzF5ZG5MUG5HVEQw?=
 =?utf-8?B?TjBhdS82TVkrTkNPMDJBdWk2SlF6WGJlb3JXL09MRUtDWXp6bkp4WlpUL2pt?=
 =?utf-8?B?SkJLWGdyOHA3TXF5bDZqcTVITEZ2b1Q2WE40TUdSZ0xsSjQrZEZFSzJ6ZThq?=
 =?utf-8?B?L1NDUXpVVDQ2aXRSUy9vRk4zTjNKaElBTWxjV0tPczVWU2dJNFlSU2dFSDl3?=
 =?utf-8?B?OEI5eWxGcmlKL0tSSUNvREQwOFY1Nm4vMkpha1ZsQ05nNE5yaFhzLzhtdmNV?=
 =?utf-8?B?blpxSEtPUTVCMDhPbGpoY3U2MGRlaUhHN3NBUTJkMERxUUFXbGtYOEE1dXNU?=
 =?utf-8?B?QmR4dTNOUHZVU1RHS0hoWDFRNlpwcGRxVXdZQ3Z1OUxZWW5NWkdlempOUGs1?=
 =?utf-8?B?Slp1cHBDRU81UCtPUUdFRzhFb0x0ekhuTGd0MEVibVE2T2x3THU4eDRwNVZr?=
 =?utf-8?B?TkVTSzNBZG45NTl4OTQwa2VOMk5iYUo4aGZtSHcwTHJJNHB0SE1CSzVQRmp2?=
 =?utf-8?B?bXlPOXV0QWlIVVl2YWJodE9pWXh1YkJrbnFYMjkrQ2ZFYzZBQ2JoaUFKd1Ay?=
 =?utf-8?B?YjJScy9hOGtoSWxlWjJtYzdGYVRDUXZMUW81OUVwdnJOSWNJOC9GVVc0M29l?=
 =?utf-8?B?V2xUWHlRRE90aCtBMENFNlExZXhpZmxzTmZXRkVpSUJhVlRmZVJjM1RSYTdB?=
 =?utf-8?B?NmNrbkdGUHYva0FHdWNTWEM1S0NtV1NYMGtsRVpCYTNRZFZycWlTMVV0Yk80?=
 =?utf-8?B?SWNPMmoxUTVnNk10Nmw0QXFBS3l2Q1lCWC9kWEsxUVBvZGdwUU16dEtKZWpo?=
 =?utf-8?B?K2dnSnN5ejJxeWFVdGpRVWM2dE0yRHpZa1dhUzVCdTJPTGM1R29PMGtXa3A0?=
 =?utf-8?B?RTNPSU1IQkRRTEdKUzlDMjhUYVVGUWV5YjNZd3liNFJlcnY4aGZaQXdnRlI5?=
 =?utf-8?B?K0Q2NmNCaDIwbG1mdS9RelJQbitDeTA5aXZtdkVuVURNWDU2NmwzTzNabzd4?=
 =?utf-8?B?OGVpUlRzTGdXdTM0SmF4bU1DK1VkZUFpelZwZWtrcTY1Smh6Q0lGdHNYRDMy?=
 =?utf-8?B?V3ZjdHJnQjVuUEU4UmF2WHdGZGs0SWxWbnVrVEtkZnN3MXNxMnpmK25lNnhO?=
 =?utf-8?B?L0xRSlgvUWQya1ZESVZobllKSkhqdUhjRHhuTGI4Mkd2V1RYd05US3l6T1JL?=
 =?utf-8?B?b1JMbkxJaUlnc2JKYXo2NEp5ZmxhM044SWFHRzl2eDJWT1J6d0VEMU4rakdx?=
 =?utf-8?B?ZDlQZTk1OG1xdElOb0RpNUZVSXlVM3lKbVZDNWRBcnY1ZVpXaDJzRGpLUjQ0?=
 =?utf-8?B?MFRKVkZLb1VpMGMvaWdMYVhQNkMxYVVIemhycm9KN1FvSHNDZE9ZTnBKMlBY?=
 =?utf-8?B?TXdkVmN4R0tGSnkrU2dGVkN1NEF0dVI0RjR1aDRjcEQxdFVuQytsQVdCb0Q4?=
 =?utf-8?B?UUZBOGNWZlhTeVNVTFIyM0ltNVhuYzliTHFLSEpyQ3A1ci9rSHJteHNyTVFz?=
 =?utf-8?B?cFgzK1U2MUVmM3dXbnVVMXlPRUlTRUVMSklOSzJsMFZUR3JKWXpyUXFWdDl4?=
 =?utf-8?B?N3dnOFZzZ25oMFNLVnFsS0dzT2pxR0RPak1iMThJMlFjNmhUSWViMU1YRFNL?=
 =?utf-8?B?aEVMRkJBdzBocDF5YWU3ZkFOeXZTWklNY05NTFRuMHYyeWkxdXREQ0RscUZF?=
 =?utf-8?B?STB0K0h1OGlGWnVkanVJZ2xxTmJabUl2NHZiKzZkeDdRbUFzaGRtQzlxalc4?=
 =?utf-8?B?bWM3c1R2b2xLeUhXQmFiUENRSHZabjdDOTcxRFArZHJMK2pickFGdz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ff5d98-58b4-4c11-cb67-08df2a07a753
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:27:27.1905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtNzeo1XuLBPzG0VX4RDD+Dg0PVZRdJkvsOl8nPcF/dK+fDfnur8S3cOklkz1tERAETPpVg14sjbCkjt5oJJgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7375

On 10/14/26 15:19, Lance Yang wrote:
> 
> 
> On 2026/10/14 19:57, Konstantin Khorenko wrote:
> [...]
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 1e5d68acf62a5..fcea98f0d8865 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1965,13 +1965,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>   		src_ptl = pmd_lockptr(src_mm, src_pmd);
>>   		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>>   		/*
>> -		 * No need to recheck the pmd, it can't change with write
>> -		 * mmap lock held here.
>> -		 *
>> -		 * Meanwhile, making sure it's not a CoW VMA with writable
>> -		 * mapping, otherwise it means either the anon page wrongly
>> -		 * applied special bit, or we made the PRIVATE mapping be
>> -		 * able to wrongly write to the backend MMIO.
>> +		 * The mmap and VMA write locks of the source keep faults
>> +		 * out, but unmap_mapping_range() does not take the mmap
>> +		 * lock and may have cleared the pmd since the lockless
>> +		 * read. Let copy_pmd_range() skip it then.
>> +		 */
>> +		pmd = pmdp_get(src_pmd);
>> +		if (unlikely(!pmd_present(pmd) || !pmd_special(pmd))) {
> 
> Why not just check pmd_none(pmd) here? We're holding the source mmap/VMA
> write locks, so the PMD either stays special or gets cleared, right?

Right: with the source mmap and VMA write locks held, only a zap can
change it, and both ways a zap takes leave the PMD none:
zap_huge_pmd() clears it, and a partial zap splits it in
__split_huge_pmd_locked(), which for a special VMA only clears it and
returns.

I tested the same condition as the lockless check that chose this
branch, so that the branch never copies anything it did not select,
but taking into account the above paragraph we can easily use pmd_none()
here, it even better matches the comment :), so I will switch to it in v3.

v2 is already out, with a second patch for the missing page table
deposit on ppc64 hash:
https://lore.kernel.org/r/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com

The pmd_none() change will go into v3.

Cheers, Konstantin


>> +			spin_unlock(src_ptl);
>> +			spin_unlock(dst_ptl);
>> +			return -EAGAIN;
>> +		}
>> +		/*
>> +		 * Make sure it's not a CoW VMA with writable mapping,
>> +		 * otherwise it means either the anon page wrongly applied
>> +		 * special bit, or we made the PRIVATE mapping be able to
>> +		 * wrongly write to the backend MMIO.
>>   		 */
>>   		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
>>   		goto set_pmd;
>>
>> ---
>> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
>> change-id: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2
>>
>> Best regards,
>> --
>> Konstantin Khorenko <khorenko@virtuozzo.com>
>>
> 

