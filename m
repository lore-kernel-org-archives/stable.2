Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D037C925;
	Fri,  5 Jun 2026 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683923; cv=none; b=TKfFNAeJ8VD2TdbIyCBLkwSiZNuFYSYR86iuC0Y8V5Pi3/1axv/sZcguxUGv8gEv/elhZ1kNspnhmCYMOES3RI6vDcyTFYkwgOlO0P8qKavr1P6nFP43DzCvo8VvTlh4p0lh7FY6tj7+WcdNjBfDXCY3UK5s+4BPMQVo1rwrXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683923; c=relaxed/simple;
	bh=xKSk2dALkJcfG7FYHRnFSGtr1WGvMhlswavq/il6ass=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAbs+YTFjGu1vCZUKv7ZiYgQSUGDFllyS9g5PRhUpgUsvq04+P48uzcpkjUJhCgUAVeYh7/J+kmdVIsVfVddvPmFdG+vyWV8RLKcRTxjP8srfrkcntSyI+WLg7nPGeUNWHAb+1ajOyDO/+SfWotYVW0klENV6C+YQ166gcJOIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=hpBcXqju; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="hpBcXqju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1780683916;
	bh=xKSk2dALkJcfG7FYHRnFSGtr1WGvMhlswavq/il6ass=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hpBcXqjusVv+SWAEpw737RfZlyDkNywKi8SGONvl2AhYMnrsGuvS58+HDc54LvKs7
	 awVkZjN3RXGsxNVE83x5ohhh1Mm3a+QqpY2lOjmrM7L7BOkEWUg2tt6EJ1sM3Mg8fW
	 BZ6MBAZ/25rp6s0TsAwE2gaeRStrPvuBUCtpfLqqRb6lIDi2pfaPVNKCGX7HG7MaOA
	 IoTiRIxEA/w4TpBeCDlEWvI6Uu93EfQfKkMwxDAMK+b54ZHQt5dIRfKeBjdiJTEqLG
	 NJ1vQz9To2gEuW9WsD8uzQZ0w+MEJykwI4bUZwpU5GeBQui95svvV5rgY1PN5ywmUn
	 cv1FQCDckB+2Q==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 039661FA57;
	Fri,  5 Jun 2026 21:25:16 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri,  5 Jun 2026 21:25:13 +0300 (MSK)
Received: from [10.198.53.178] (unknown [10.198.53.178])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gX8xN74brzwQQc;
	Fri, 05 Jun 2026 21:25:12 +0300 (MSK)
Message-ID: <788800cf-061c-4312-9595-3da2b5814d47@astralinux.ru>
Date: Fri, 5 Jun 2026 21:25:11 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH 6.1] mm/memory_hotplug: fix hwpoisoned large folio
 handling in do_migrate_range()
Content-Language: ru
To: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Jinjiang Tu <tujinjiang@huawei.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Luis Chamberalin <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Michal Hocko <mhocko@kernel.org>, Pankaj Raghav <kernel@pankajraghav.com>
References: <20260605172604.16034-1-adiupina@astralinux.ru>
 <F08546F3-3CE1-4DEB-B65E-32D3FFEF4256@nvidia.com>
From: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGA0LAg0JTRjtC/0LjQvdCw?=
 <adiupina@astralinux.ru>
In-Reply-To: <F08546F3-3CE1-4DEB-B65E-32D3FFEF4256@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/06/05 18:08:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: adiupina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 107 0.3.107 575e75fe8e3b9d45c142d144823c5de38605099e, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lkml.kernel.org:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203696 [Jun 05 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/05 16:27:00 #28217824
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/06/05 18:08:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

05/06/26 21:09, Zi Yan wrote:
> On 5 Jun 2026, at 13:26, Alexandra Diupina wrote:
>
>> From: Jinjiang Tu <tujinjiang@huawei.com>
>>
>> commit 397f6d14f9c370e4910e6885294c340f39dedbf5 upstream.
>>
>> In do_migrate_range(), the hwpoisoned folio may be large folio, which
>> can't be handled by unmap_poisoned_folio().
>>
>> I can reproduce this issue in qemu after adding delay in memory_failure()
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000000
>> Workqueue: kacpi_hotplug acpi_hotplug_work_fn
>> RIP: 0010:try_to_unmap_one+0x16a/0xfc0
>>    <TASK>
>>    rmap_walk_anon+0xda/0x1f0
>>    try_to_unmap+0x78/0x80
>>    ? __pfx_try_to_unmap_one+0x10/0x10
>>    ? __pfx_folio_not_mapped+0x10/0x10
>>    ? __pfx_folio_lock_anon_vma_read+0x10/0x10
>>    unmap_poisoned_folio+0x60/0x140
>>    do_migrate_range+0x4d1/0x600
>>    ? slab_memory_callback+0x6a/0x190
>>    ? notifier_call_chain+0x56/0xb0
>>    offline_pages+0x3e6/0x460
>>    memory_subsys_offline+0x130/0x1f0
>>    device_offline+0xba/0x110
>>    acpi_bus_offline+0xb7/0x130
>>    acpi_scan_hot_remove+0x77/0x290
>>    acpi_device_hotplug+0x1e0/0x240
>>    acpi_hotplug_work_fn+0x1a/0x30
>>    process_one_work+0x186/0x340
>>
>> Besides, do_migrate_range() may be called between memory_failure set
>> hwpoison flag and isolate the folio from lru, so remove WARN_ON(). In other
>> places, unmap_poisoned_folio() is called when the folio is isolated, obey
>> it in do_migrate_range() too.
>>
>> [david@redhat.com: don't abort offlining, fixed typo, add comment]
>> Link: https://lkml.kernel.org/r/3c214dff-9649-4015-840f-10de0e03ebe4@redhat.com
>> Fixes: b15c87263a69 ("hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined")
>> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Luis Chamberalin <mcgrof@kernel.org>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Pankaj Raghav <kernel@pankajraghav.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> [ Alexandra: replace continue with put_folio label ]
>> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
>> ---
>>   mm/memory_hotplug.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index c8cc2f63c3ea..013db41f6ce2 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1654,15 +1654,21 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>   		 * the unmap as the catch all safety net).
>>   		 */
>>   		if (PageHWPoison(page)) {
>> -			if (WARN_ON(folio_test_lru(folio)))
>> -				folio_isolate_lru(folio);
>> +			/*
>> +			 * unmap_poisoned_folio() cannot handle large folios
>> +			 * in all cases yet.
>> +			 */
>> +			if (folio_test_large(folio) && !folio_test_hugetlb(folio))
>> +				goto put_folio;
>> +			if (folio_test_lru(folio) && !folio_isolate_lru(folio))
>> +				goto put_folio;
>>   			if (folio_mapped(folio)) {
>>   				folio_lock(folio);
>>   				try_to_unmap(folio, TTU_IGNORE_MLOCK);
>>   				folio_unlock(folio);
>>   			}
>>
>> -			continue;
>> +			goto put_folio;
>>   		}
>>
>>   		if (!get_page_unless_zero(page))
>> @@ -1687,6 +1693,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>   				dump_page(page, "isolation failed");
>>   			}
>>   		}
>> +put_folio:
>>   		put_page(page);
>>   	}
>>   	if (!list_empty(&source)) {
>> -- 
>> 2.30.2
> I am not sure this is right.
>
> The original patch uses put_folio, because folio_try_get() is called
> before this if block. But for 6.1, get_page_unless_zero() is called
> after this if block, so the page in this if block has no elevated
> refcount compared to the original patch context. You might want to
> replace “goto put_folio” with “continue” in the original patch instead.
>
> Best Regards,
> Yan, Zi
Thanks for the comments,
I'll send the second version of the patch
