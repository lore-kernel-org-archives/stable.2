Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4F459AF4;
	Tue, 18 Aug 2026 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051619; cv=fail; b=l4oLBju6p16AGMp/uU/IOqmi1fOKSnQO5gGdGPa1MM6UFsIfbe7Up4DFSiUnEN5LbGKrLgWAKo/vTQJZmNeZWctBS6POp1EOZIKiy1wSB2WcBPKhLfCb5gJUW7bfMi+JSFr1mVpTyOUqWeQRbrB8YGcbGwdrBxTXD8M+iD49vvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051619; c=relaxed/simple;
	bh=HXQcW25mY6wyPeUYWomLhnjxxrC4DqlxwPhqrotcmuA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E5u2attXu1pPj+RdxLuvmbThLgszOk83rgHNQ+lqiBQAk2lEoTL7jN9nVkJBGDane70V6xaQx/R75GL5dsTV9CeEOdh1rYCLKir7Q/jXZ5M0JAd4fJgYNIZ2Y2aD07tCnhjBruTj3IkCCxo541TJvvW5j2eEWgcaYa2WtKDPQ0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aj90WoOc; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aj90WoOc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUTzc2wCiC/Syx+1TydhE9AP8QRHMk0sbm7ViUzWDK7fylcMrIZMxQbRt/fP2szxGQ6a9RiUWLoCyEPg/cEkzhrZ3WMwZ+XM/pROqVEFRFs9i0xLtLQhIz9+vafShxL806uecEQxj2HOHzye/rH5hfFFnS0G2w8QlkVb8nDBJ5BFbQPospJXUvWFmZtWmisnx2eZQ4o08dvDW95IjCuJMt4uHug5RsUFT8cYPI+Ju6s7JVT5G8gd9CPp0fmXBXBnB3QlQbsYuIJHuM8gJsL9OBIXeHVOAmrC7tPFWaOIxX0qfFmnm7EB9+EOlSPNm7tGQMoRLzPjr24RNryG7bd+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLUzXjrh+WWc4l0LXpbfIQ0qVkc588TQYRg808JgDG8=;
 b=oIo+CpNylSVf9DpW0KiVv2Id/1mODjpANCDvEQ2KD2mwzODbjOY1eMCdx1keBzryjp1dLva2DoeqvS+pS/Toqr1S/UoeOpPm7Ns3e4g7G1FKA0BRtNuIpqyxGxIXQASoLiUK9SrRsLYNPpH/XXXF7PyUF4/rSpZakRnvoDWxldW4FdN7bf4q+s6Fmu0XTHru42eg5zZaismpeWWN4oNkDvJBkvAaXTlJZBDNOU7goKoF5emLiOmrb3Dj3Qor3iLtQc6u4kS9yWo2v+VTe7NjgITmbyzb/AguydOaa3uLkHFDIUsgj4Yd27ny14IBk/pZBgZndqL66OcoKYFW9cXkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLUzXjrh+WWc4l0LXpbfIQ0qVkc588TQYRg808JgDG8=;
 b=Aj90WoOcDjH4IzSPHLC6pZHFFD4MvbR5KUmqJDai/3YgoYdS5z8NKpGYRqiIirfN/uz95Gnc5oYYhyojqWT01P0w4MsDy9/zOFzIV6Ja2Up19geYu25Kz/uSfFtTIURBNgqxzRQdoEVjXzYAmNylUoWbmWf2WtnK8S7w34BK2CmRTgXHOp2XY7EogXQeeFLBkpKo1xl5/iyf88BVbbJRF6BVAqgr7481ZP2KwrwwBEg/109LxbUnedxXMnfbb3SjW0w0EXYEVTFUilvyF0+L5CeinT+Pl22Wt/A/1ywIuOmJSitxcLH3Er0wlrz10tuAHYVnhslVN3I1/3Tx+OorEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9670.namprd12.prod.outlook.com (2603:10b6:610:2af::6)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 11:13:33 +0000
Received: from CH1PR12MB9670.namprd12.prod.outlook.com
 ([fe80::416:ea1f:d17b:2811]) by CH1PR12MB9670.namprd12.prod.outlook.com
 ([fe80::416:ea1f:d17b:2811%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 11:13:33 +0000
Message-ID: <f039fb9c-465f-479b-a909-2e57943d545a@nvidia.com>
Date: Tue, 18 Aug 2026 21:13:25 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/migrate_device: avoid out-of-bounds writes for
 compound folios
To: Andrew Morton <akpm@linux-foundation.org>, Hui Su <sh_def@163.com>
Cc: david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260817120758.669807-3-sh_def@163.com>
 <20260817112150.aa6cc927cf501d687336c0ef@linux-foundation.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260817112150.aa6cc927cf501d687336c0ef@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEVPR01CA0027.ausprd01.prod.outlook.com
 (2603:10c6:220:205::15) To CH1PR12MB9670.namprd12.prod.outlook.com
 (2603:10b6:610:2af::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9670:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6f72bd-4979-4e96-f078-08defd19bdc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0h5lgHmOyTMMbnNJ5xTOSAasooRAW92bTqSvOXp0MEkfq8KnaBbi2vZ8Y2Tez3yRbx+6XR6SWWg/qSCaWn926nxRPDp4dmBsAmnJgZZe2JxRSo+PyTSn4SSUioTIrgQIzPrtLiRSa8VhxV8u5ixJE5MFeotXvDQiEroXWvA5HI6448TkNmq3jiSQZIo1pfSF01l2JGjtm7WFNXDDoqNsnwLzXnyYekRSraf40+7audbJAosgS2AjDBdq0rVyHelj8s8efCHMcrM4TFYQM3lKkFYv9xPQ7glaEwzKg4CNmp5jgkXCCmQ+jZUuGjR/hG46222dlupS+Hk1+TlpjyJILKucOZShaQmh73ptjSSvt11LptGnMQ8wfrSJZf2khvUnYs6ztmTfiP39aYkBj1LhHRVzjgqADtxVaCjuj8JdrQ2zPqM2LHJorbp32r4AplwF3uVSQk2raidQX0lZX6pFr0PYoEU4wQSxSGX5HDRJ4nydus3/hFjpXvIwU8bEDxAst5w6nGMZ4EPmq3C3S2LW8iE7jDRgptqn5uRydo6dOYoNHdd7nUPuf4GsGbUqtfTVJWbwEQI0oLzG/e3OBlIosrP2Yl0y9iJEy7XzUbARQk8yiHTz7BVbdMo5sY4JPPUPfCJkkKipYOQvUKS/oFPbBxTYcRDNfdaxPDcIF+LgjWc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9670.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MCs2cWNXaG1jRGFLVmRZYTRPN2lZN0RFem9VV0VnMXNaVlBVU200SWQrTFY0?=
 =?utf-8?B?cUp5M1VQRWNrWnVQVmI3RU55eEppUlRMVkNXWldscWxxNXNHKzVrWU0yWEU2?=
 =?utf-8?B?T2EvQnNaVlAvTlZXOG5rK0MvbDFQYytDODN1UXdTVXZ2UE9VQ2ZhMkpYeUpk?=
 =?utf-8?B?cEZ4TlN6WjFDTUs4YjcyN1JHLzBWaktEb3p1eDk1WXVPazdWMURBWUwwVGFu?=
 =?utf-8?B?MW9xTUdQcm54QzN6dTdDZ0NKZ2tKTUNyakRHL2ZUL0FEb0plME9wMElWU2NP?=
 =?utf-8?B?MUJGeVpNUUVSWUtCVkZsKytDVlBHdHdGdDFtUEdkYVR5YThYaXlveGpkTHBI?=
 =?utf-8?B?UEdqak80YUJ1TW1PUXI5ek1yaU1UZzdmUllXNHpOcVJDOVJGZUpuWHVLcmVa?=
 =?utf-8?B?QzRieHF2YVIwVjJwT2s0ZzdVMG5YU2xzc25YazF2MlBydC9Ma1BqUzdQclQ3?=
 =?utf-8?B?Z24vTmt0eExEYmxNTGRkMWVQYTRhR2FmczdTcXh3Q0JpazZBTzBrN2RBd0xG?=
 =?utf-8?B?OGJQMUxLY21SanZtQlMrZEFDMUFVVlZtbnhIbWRrQ0RhR0tNT1QyMGc5Nzh2?=
 =?utf-8?B?M2xwL2JFS0JWVWxtOFVIdytMTzUwMmZac05iaGJXR2Jpb2lEY0R2eCthVzB2?=
 =?utf-8?B?QkExbkxwWm94bzY5QVg3Y2NTTGFuVnliTHJoSVluRmtpbXhhWGk5aGhCaVJo?=
 =?utf-8?B?L1FmTDN5VnNGeXNDNTk2dFVOOElFTS8yTXJNZ1BkNUc3akQrUjlqUXRTTHhS?=
 =?utf-8?B?MUdMd2daRTF6enFOZENTOXErTDBZVWFUdHg5MFBBeks3K2FrMlpMWm9DeUNI?=
 =?utf-8?B?YkpNY2ZuQXVlMWQxUnE0YS9qWEVTalV2ZDlCOERnUXVwUmNGY3ptOTd0QS9B?=
 =?utf-8?B?Tng4VVZHV0xUZVcxM1hUSHhUSkNidExSWmg3b2ZBR21yVHBnSDlFNUVTMTd6?=
 =?utf-8?B?NDlsL1ZtNlFTYTJhVXEvdzc4Yzh6S3RaWUZxazVhN3BjeTVGUzNOMVQxbWRN?=
 =?utf-8?B?L0kzZlhySWlMRlFtQlAxTVFaUXVZRGRIVHdid1BLT2VyOHlFVnovZUlmQW5L?=
 =?utf-8?B?UUV2dEVlbEFVeEorTGRZTDAwbHMySkt6MWxuQVpLL3RzQ1UwMG13b25YMG84?=
 =?utf-8?B?OEVnQ2diMkc5em9nM3RLajdqanRZN1lrSzVYL0lQTXhmMWNsT3BQT1Zwb01p?=
 =?utf-8?B?YWQxbTlIN2NIRUZoNHF4QzZTM1MrM0FxOURWTXVDY0cxQXN5UWwzbldQNHRF?=
 =?utf-8?B?anhxaFRYcnFGdjF1bmx2TE85S09mZzJKOTI5QjBRMEpSeThrWUJMajRWTkpl?=
 =?utf-8?B?endNUTR4c2dEeTNLL3J0QTcwM1dSZ002ei9RL1BkalZ1alpLdnhXdTVCcnpS?=
 =?utf-8?B?OXhTdlYvWEhtK1ozMHpBMDZFMmVSbCs1L1RjcmZZVnNjWVI1cUJSSFVNTkd1?=
 =?utf-8?B?Vk1kbGFHZUhESTIwRWFGNkpSNVFveGtkSTdLclRweXhVVkVtVFo3MkNzaE1m?=
 =?utf-8?B?YUZ4RVp5K09VRzdEMG1hTHNndWxPdlNHcnVBaGZkcE1xMU9VT2p3alVGc1F6?=
 =?utf-8?B?N1NCTk5IN2NBZ0VaVkFoenFQMmFNSERJeVdOSnE0VjhTb3hvc2Zab3lqWFFy?=
 =?utf-8?B?ZE9ua3YrSVFQbHlrMFhlUTM3T2JDSFB2UTl4TW9wOGE2TFFqM2RPSFZWNFFr?=
 =?utf-8?B?REl4bXNSS0JqUzltSDQxTW4rc3hLdTlXNEdqM1ptSThjbFBVOXhnWXdLZFNq?=
 =?utf-8?B?Zy9kenByN1NyZG1BUkJlUXNNaHVuaXQxMklDd21DSlpWVzd1MjU2MjZMMHM2?=
 =?utf-8?B?K1JCS212dDJpZTFrU2NjQndVQUk5YW1hZFpTUVF4eFhpcnc4ZkIzWVFhMHR0?=
 =?utf-8?B?amFUU2NHNmRlTGRCQnQyZHl2VDhkek5VbVN1ZjU2L1RmR1pQa1hQWi96dDNS?=
 =?utf-8?B?RXBlb2ZSZmtJMDBQMWtsOVZ6V2EzN3ZjY0Rad2xFcUxZbXdBelNyNFZFN3hB?=
 =?utf-8?B?YmNOZko5a3h0TU50bDNDb2hOeTNTU0FQcmJVK25pZnB2emEvSjFnKzZhdFpC?=
 =?utf-8?B?SnpIdVR3bjcyU3cybDZJcVVrdmhadFJxeE5jZ3E3UzQ4ck9YWGNOcHNMYy9s?=
 =?utf-8?B?YWtjand4RFFUSWUyVzFUTnlNSVFwNVMzanVEMENrTU56QkFoTEI0M2hUVGdx?=
 =?utf-8?B?YXZibVY1Tm9mcGlBaVlCUU4ydWdxTktRdmJjYU9jV0UwTFd3c0xrQlpPMU5w?=
 =?utf-8?B?KzZkUDdCZ2VncHIvcll0VjF1NWFXRllqMzRrQ3JGZ1dZOGdUWC83Vk5BU0M2?=
 =?utf-8?B?dG9pYUx0dXJtRXBiVVNrWjZSMlIwOUd3d0drR3BNZDhxNnlaeXViUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6f72bd-4979-4e96-f078-08defd19bdc8
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9670.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 11:13:33.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhtUYqtzitdNf3RotO4kXB71xwqFiquvKLjbqG3Z+7uB8UUCeL9eSiTCqnT+iqIL63SkaU4ZnMWq4lLlwWGyMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655

On 8/18/26 4:21 AM, Andrew Morton wrote:
> On Mon, 17 Aug 2026 20:08:00 +0800 Hui Su <sh_def@163.com> wrote:
> 
>> migrate_device_range() and migrate_device_pfns() clear the entries
>> following a compound folio so that the PFN arrays retain their
>> page-granular representation.
>>
>> If a compound folio extends beyond the end of the caller-provided range,
>> the loops clear all following folio entries without limiting them to the
>> number of slots remaining in the npages-sized array, causing an
>> out-of-bounds write.
>>
>> Do not proceed with a compound folio if its page-granular representation
>> does not fit entirely in the remaining PFN array. If this happens, drop
>> any reference and lock acquired for the folio, clear the remaining
>> entries, and stop collecting.
>>
>> Observed with a KASAN x86 QEMU kernel using the HMM
>> migrate_anon_huge_zero selftest. Closing /dev/hmm_dmirror0 after
>> migrating an anonymous huge page to device memory exercises:
>>
>>   dmirror_fops_release()
>>     -> dmirror_device_evict_chunk()
>>       -> migrate_device_range()
> 
> It isn't clear (to me, at least) what "exercises:" means.  Was there a
> WARN?  Did the kernel crash?  Did it erase all my cat videos?
> 
> IOW, in detail, what are the userspace-visible effects of the bug? 
> Please add this info to the changelog and maintain it.
> 
> Sashiko might have found some things.  Some pre-existing, some newly added:
> 	https://sashiko.dev/#/patchset/20260817120758.669807-3-sh_def@163.com
> 
> 

userspace-visible effects are a function of the usage of the API by the device
driver. If the device driver passes in npages that don't account for PMD pages,
it would be an issue. In the case above, closing the device will evict pages
from the device back to the CPU, but I am surprised that the size of npages was
not properly split, we should fix that as well.

FYI: I've tried reading through Sashiko's report, but there is too much
pre-existing content that it points to and it can be quite time consuming. I am
working on adding new test cases to try and catch some of the issues found

Balbir
