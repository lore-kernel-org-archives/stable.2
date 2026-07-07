Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD6C299937;
	Tue,  7 Jul 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431937; cv=fail; b=ZYW7wHKElPwwgmyP3ByJPEXaHKsEAVBbVybvXS+r6NiElKCFsUJDTJXpgtAJhrjY7vJcJEIT23S5PFLWAxcFAQ/6GR5cmrzXpPk6/Z+zwzhJ1h9FTahyZuFfKzL9taT0gEUFuSlSE3Kbr9tzm4iEMj/2Rmo2dxiACOJ8ezSh8BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431937; c=relaxed/simple;
	bh=9mC9ADEVAPYGH+4YlVju7Et5x91IYM8p/A9UBRnz7rE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aX9kHmwRhCIqj0kH2iz6fR1vmSGkRxyMuOViZFJl0kjhimqSrC1HhHA8U82tn6UNfHtQe0nyxSBVS1G3i9pjpBeoJ3GqVcbCfXp7f8mkDH6oPEhmptjHz4wQsxa+LDQ3KAmwCDKFX2yqc1wI3agSRJZjG3sEGCMtwa07LM93kaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UnxjoMs6; arc=fail smtp.client-ip=52.101.53.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UnxjoMs6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTCAYXLTVrI0ijLqjz5gh/YKdownLJDgTbYVeLVZFohEQ0DZp2+HNG0onjaLwWQ9h++ScJXsX1XPvLvMvgc9aRxOqfv7C32mGRDhfIk1LQPRBYP0CxC79YOrAsUhkzjaA3YSTuDG+nnOue6KMvN183LqpAt+Kcv2WJcU5FI7bp6M7Y0My7nHIVUT9gY7tO+YXmLqmKPuC83m4dnJ6HL1oQoJmJf0ZjOaYJ2IlmoT3QG9iXODwQVOFO14iuMAGG/lB4VBzi5XqYaZqDqtIztBBinguvxQZ82BdXyB8N/h/Ldm89DbgSAVvNBfIh4oOUDxR9T4VOtYcDrsJK3ekAaYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOU69Tiy0z2tDGAQHnAhd5Umk1N+XXOs3g7XF7F4Ft4=;
 b=VeGS7R7jxTKa0OUxFedF4u8LisL2JjyKVkHJDztHHMkq7fNzrrX1Wtv75uaQbsCCZxFsHCrL/CK0SO7INEOTXvLfBLS9Pi2SGwxgJaCtVuk7XBweYHZxOzXcmFOAy4+zu6TXj9+EYjnnw79EnMA3UpOU3aBadKEHzJrBpE0kw3EMpfDwkCjUYNoatUdX3/Myg0zWsNVP1UPcfZ2FeHqiRIjJ53GP3tLyqDxoRYJS6mjrsYUAloYu765DQQ4kNxzLhd9U0oCuucfKZLW2f/yFUPverocjocM3WxQlMsgvziujKRr9ziSIS/h2n4HJ4AWSpc6SndhQNw8SPHvKl+rKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOU69Tiy0z2tDGAQHnAhd5Umk1N+XXOs3g7XF7F4Ft4=;
 b=UnxjoMs6LxcfTVdDw9geM0CSVbH9i4W346OFDAqv3Gcy1/tXN8BBMKGbUn1vBhY3oo+OikrGoANSZ/U/nZFupA+jgR1NnX4nwQHhBXWbfMeTRxgGIvnNDFSWFVDEkBltlxszG6OU0YKAaIVTSu4Fw3GxS6iVOyyqmOR8icOo7nY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:45:30 +0000
Received: from CY8PR12MB7433.namprd12.prod.outlook.com
 ([fe80::faae:d638:bdc9:4bf6]) by CY8PR12MB7433.namprd12.prod.outlook.com
 ([fe80::faae:d638:bdc9:4bf6%4]) with mapi id 15.21.0159.018; Tue, 7 Jul 2026
 13:45:28 +0000
Message-ID: <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
Date: Tue, 7 Jul 2026 15:45:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
To: "David Hildenbrand (Arm)" <david@kernel.org>, seanjc@google.com,
 pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com
Cc: bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
 yangge1116@126.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
References: <20260701144543.39582-1-pankaj.gupta@amd.com>
 <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com>
 <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To CY8PR12MB7433.namprd12.prod.outlook.com
 (2603:10b6:930:53::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7433:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 8221565c-6256-4780-d7de-08dedc2e0111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|22082099003|18002099003|11063799006|3023799007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	TLqjuIQHQ/So7a2oADhi46H+79LRsLrTYEyDFaEX4rQjqiXqMnHDLl3Op8WkfAA1yPPl1nA7QO+N3Nv7TqylDJxN3DAnI7zwFSbgJzJ8pNKRrW1Fs72qnURztOVYJt4ZIPiSZIiaCVORZBABOpYjRQAK7ENwo7qKD0l9coCaPvQtucNmPop0eR+c8QgV9txcjIzfhsunrAhhZM5bb/ngChiWPdPdzLlPijitKQsR3viEa6Ec7JlBe56vKMUono3R2qeQ9lmMUog2RPCDwuc4bYwg+yFljovC0lZC6MFS5GBkPHVhj4ZV+j16TQmO69l5zBolZwVNWXHouydJuuVSuSrXX16kohzMEsNjtilMCdH1HcHDXveVSkHdc7acyJRvUDHT8KhaIEagIsaKWIxg1y95I1rphha0gY4Jz8jeYr1EBD4+IhtMqWp5GNOuu9CXM4yN2NEWj+KCoQAbE+2f5Arul8CAmmz5LctMnGjBhbgRp7C1paAci1nQRd6KUVOcHq/6L4jgG+U2imkuqXmzYYNxDxMd3yX/yfx+/oHspOdP4aWbiKu4uQIFZTKBdx66OV7ErVoPnVHsrQjlfxRe8B0MXkiB9Lj/EEGS3pns36cQQKBEQL7uB5F3aD5OvHVSJpoC75J95P/ReN+eXDoCAR3eM/q6WNmn7rMX9gu8ReE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7433.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(22082099003)(18002099003)(11063799006)(3023799007)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mkl3NFpaUWdDK0htQTkyQ05yR2t4c3RLUzN0Vjc5YVRGa2gwL1hTeEd1emtY?=
 =?utf-8?B?TG05Qk9zcWdlcDg4K2JUbUZxVGkzZnBLU05LcnBCYVlnL01OS3ZrWjVGL1kv?=
 =?utf-8?B?cko4OUlEYkFZc3lnQ0ozWkN4M0hVK1pQMEkreG00NnJWZ2R6UUp1MjdmeGJh?=
 =?utf-8?B?MXZoVERmaE0wSlpPd2NQQU1oa01GUVBRV09uTDVsaGplOFlCbTNreDhrS1VU?=
 =?utf-8?B?Y2JOeHV4WU5KdEkrNloyQnFqaW9DS015eitaL1RsN1AzYTZhZm5jTlJEVGR1?=
 =?utf-8?B?Q3dvbWdoR0pJMFNEWEhvczR5SW9NdWJVQ0lTYTBmMmhCWkVIa3hCc2hHQy9u?=
 =?utf-8?B?TFhneCtZTFZQendMUGJpejZYOUpnbk9iZ0JJTHFlbkxtS3J2UDU2QTVzVGRv?=
 =?utf-8?B?TTNMWEttMXdYSEtYTXpURXpPVm5HMnlFK0lrazdKS0daclFLSXBMRHdBdG9J?=
 =?utf-8?B?NDg3SnA3VFpjbytCZ3lSOFZ2NmZpTE41UjFSL0wrMitUTU9nUmo5YVlPYVVB?=
 =?utf-8?B?QWx6RnZ5VkMyZXRSYVNkYUlDNXVlaEJRQ3FmSkRBT2dSOEZPN2hOVFdPaTBu?=
 =?utf-8?B?TUo2WjlYMWVoZVl0ZDhwSjExUCswY2xRamlicnZTQjFiZjBtczJyd0ZPdVMz?=
 =?utf-8?B?TXZKSWpiUFRISnhWVTNKWExJN2JVUDRXVWdaUEhXbm1xTS9JbTBPazVWMjJQ?=
 =?utf-8?B?bUJKVmRXTmd1MENFRkZ6OFJsN2pVcHYzeXhPaHhTdW9aMWRCM0VzOFFtbFp0?=
 =?utf-8?B?OVlaVDFKVkw5OEdCR0ZyOWFNU0k0OGZYRUlRM0pWb2VnQi9RTFNGay9sMklT?=
 =?utf-8?B?RVpVS3p5aVF1ZzBwRDhYNGdIRnZwU0RYNkU3Q29qS0lBakZocTRxcjFmQVFL?=
 =?utf-8?B?dFJyaWhaQlVtMUVBazhOckV6c1NnejhSRWFPYXV6QWxFaThMVmJISCtmZE9C?=
 =?utf-8?B?VjFMSzBtZTZtUDdGUWpJckxmbmkwVG56cGFySmVPSHc2ODNlbkgxalVJWE9T?=
 =?utf-8?B?QjVCVHIzczVTeDVtSUowM2U4a0NMaXJ6bDU5cUlyVWNHUFNxWk9HenhzNlM2?=
 =?utf-8?B?K2pFa2xzbG1UZnB5U2pQYVNhL3NtQjB2S3RoMGorOGJHa1RZbjY4dGF2aklK?=
 =?utf-8?B?OTA4d0IxTzkvK3FSdkpOendjY1J5MUt2ZzhZc2pjYm16WFVGQWJMSHAwT1da?=
 =?utf-8?B?clVTZG5lS1U0MHdsWkwyU1d2REhVMDMzRkJnZXYyMkV3MU9PTElQNW1UbXVO?=
 =?utf-8?B?MisrcDh6Vng5RDdLWjZjby81Y0hta2Y0ZE9BZUhpRlNUS25QdHVmT093NDJj?=
 =?utf-8?B?ZlA2ZGdNWVhWd05PQUJLUkNhUklRU0ZRYU83OHA5ck0vbGJsaG0xL2xzSnpY?=
 =?utf-8?B?SjUyMk9tZkdRdVB1VHN2eHJyeFJYT1hNOTNxWmVJdVpNZmU0S24wdGpNLzlk?=
 =?utf-8?B?eVJzRE9BWkZXNG15WHNkZ0VQTGZEUW9naUJPSkVOd29hZk42STNUdi9YTms1?=
 =?utf-8?B?eVRsaEJOQ0pGUVFTR2p2QkZYRWUxQkd1bjJkQVorQmtuSjhJeFFPKzkzZDlP?=
 =?utf-8?B?MmIyc2wzeFJDOUFTU1cyZkQ0MFE5bTk4ZmwyaUMwR09xUXBtK0pyUXZ3cjA1?=
 =?utf-8?B?bVhMSFlZT29ZK09NK3J0eTM1SCthYlovWEhoMU1VWGxrT3cxUTU4QnJBcXZ6?=
 =?utf-8?B?NnRUR0pqSTlnU2V3VzJWYmJNdHV5azFEbW9adzR5R1dxSlhHeHZoak9XZnFD?=
 =?utf-8?B?QXhMZjVuV3BoZSt4MVJuN09nMlUvUERwdWpuNjRSa0FHcFhDQ2JWdW10ZGF6?=
 =?utf-8?B?NHU2K0pVYnNqdVE2L1hOTFpxUUZKbCtHK3hYNVZiTkRpc3dsL0QvRWZsRWJv?=
 =?utf-8?B?Z1VvTlc2YlpXTkJhL3ZXNDlaNzdUT29LZnYzNGZ6MTN3UjdxcDJ5aFBRMG5i?=
 =?utf-8?B?Z0FqcnNHelUzYm54bXcxQVg3OCtMLzI0eTk1dXNndGg3TnpxUWdDcXpKQ1M2?=
 =?utf-8?B?RU9kS09HOXhXSnZOMEkyMS9xTUpkZzdsWmlYcEZkVWt1Vk95YWFENGpjV0JY?=
 =?utf-8?B?cE5IZXNXdHRPSmdJVTg3dUVubWVzdUo3cFo1MjZGWXhwOXIvVHpQUEY5T1VQ?=
 =?utf-8?B?NUZkenF1Q2E4aTMweHF1Y2xENmZ6V2dSUmFVakhTcnlPS2k5Ulc4eDcvellF?=
 =?utf-8?B?RCtwUlJtNDN3MS8xb2l1OE1VRlhLanVnNVBHQjJ4VTBNN3pHQ3BEN3VqUHk5?=
 =?utf-8?B?a1pzTlQycFNkZEJsdXpuNWxQdVc3VlRna05NVGVxQWJwWFNpemhRVnFIVThW?=
 =?utf-8?Q?07zdxvJ+9yXy1758Wc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8221565c-6256-4780-d7de-08dedc2e0111
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:45:27.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNlkMteWS7gIR+GqMmeaRE72kF6ejdvbrDkSg/kLbJBgPOa5+RmEV3PHlHVAFrxdbnApiPwcl5EYgtVNLDX4xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886


>> Hi David,
>>
>>>> commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted
>>>> memory regions")
>>>> added FOLL_LONGTERM to sev_mem_enc_register_region() so anonymous guest RAM is
>>>> migrated out of MIGRATE_CMA/ZONE_MOVABLE before a long term pin. This breaks
>>>> virtio-pmem which has file backed (MAP_SHARED) host mapping where GUP rejects
>>>> FOLL_WRITE | FOLL_LONGTERM since:
>>>>
>>>> commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to
>>>> file-backed mappings")
>>>> commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
>>>> file-backed mappings").
>>>>
>>>> Drop FOLL_LONGTERM when registering encrypted memory regions and restore
>>>> the previous behavior.
>>> But that breaks the original issue of breaking ZONE_MOVABLE/CMA?
>>>
>>> If it is a longterm pin, it must use FOLL_LONGTERM. :/
>>>
>>> I assume we fail in check_vma_flags()
>>>
>>>      if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
>>>          return -EOPNOTSUPP;
>> Yes, it fails in this path but for file backed mapping, vma_is_fsdax() returns
>> false because
>>
>> vma_is_dax() returns false:
> Ah, okay, so fsdax is not involved and we really only fail because of the
> writable_file_mapping_allowed() check.
>
> I was for a second thinking in terms of nested virt :)
>
>>> IIRC, fsdax cannot tolerate unbounded pins. Is that the case we are running into?
>> Host side backend is regular file backed memory (no fsdax).
> Okay, so we'll end up mapping an ordinary file into VM memory, and expose that
> to the VM as part of virtio-pmem device.
>
> That also means that vfio etc. won't be able to longterm-pin such device memory.
> So this is not a problem isolated to SEV.
>
> Forbidding to longterm pin is actually the right thing to do if the filesystem
> relies on writenotify, as spelled out by Lorenzo's commit:
>
> "
>      Writing to file-backed mappings which require folio dirty tracking using
>      GUP is a fundamentally broken operation, as kernel write access to GUP
>      mappings do not adhere to the semantics expected by a file system.
>
>      A GUP caller uses the direct mapping to access the folio, which does not
>      cause write notify to trigger, nor does it enforce that the caller marks
>      the folio dirty.
>
>      The problem arises when, after an initial write to the folio, writeback
>      results in the folio being cleaned and then the caller, via the GUP
>      interface, writes to the folio again.
> "
>
> Hmmm

Yes. For file based mapping we don't allow long term pinning.

If we take into account the fragmentation concerns for MIGRATE_CMA and 
ZONE_MOVABLE allocations

solvable with FOLL_LONGTERM, I can think of two options(tested) to allow 
file based mappings as well:

1. Fallback on FOLL_WRITE when FOLL_LONGTERM fails as suggested by Sean.

2. Explicitly restrict long-term pinning for file-backed mappings with a 
change like the patch below [1].

David, Sean,

Do you have a preference between these two approaches? I am leaning 
toward towards option 2.

Thank you!

Pankaj

---

[1]

arch/x86/kvm/svm/sev.c | 27 +++++++++++++++++++++++++--
  1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6a6d663e29..c4b53700f69e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2743,6 +2743,29 @@ int sev_mem_enc_ioctl(struct kvm *kvm, void 
__user *argp)
         return r;
  }

+static unsigned int sev_region_gup_flags(unsigned long uaddr, unsigned 
long ulen)
+{
+       struct mm_struct *mm = current->mm;
+       unsigned long end = uaddr + ulen;
+       struct vm_area_struct *vma;
+       unsigned int flags = FOLL_WRITE | FOLL_LONGTERM;
+       VMA_ITERATOR(vmi, mm, uaddr);
+
+       if (ulen == 0 || end < uaddr)
+               return FOLL_WRITE;
+
+       mmap_read_lock(mm);
+       for_each_vma_range(vmi, vma, end) {
+               if (!vma_is_anonymous(vma)) {
+                       flags = FOLL_WRITE;
+                       break;
+               }
+       }
+       mmap_read_unlock(mm);
+
+       return flags;
+}
+
  int sev_mem_enc_register_region(struct kvm *kvm,
                                 struct kvm_enc_region *range)
  {
@@ -2764,7 +2787,7 @@ int sev_mem_enc_register_region(struct kvm *kvm,
                 return -ENOMEM;

         region->pages = sev_pin_memory(kvm, range->addr, range->size, 
&region->npages,
-                                      FOLL_WRITE | FOLL_LONGTERM);
+ sev_region_gup_flags(range->addr, range->size));
         if (IS_ERR(region->pages)) {
                 ret = PTR_ERR(region->pages);
                 goto e_free;
(END)
-- 




