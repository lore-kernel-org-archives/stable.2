Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CA316197;
	Mon, 27 Jul 2026 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116195; cv=none; b=VN29wNsUu84VQkkBYSCmRWRf/ciAgJZiVZ01VceQ6Q1pdUayD/Rfhks69uuX+kACRVrOIKnGgTpISKJ16X7NzIGSplB7QMKTBoZFDGNR2EBxEMvMIBuKi05DpLt7otBljSn6lHqC03RM2zrfA3SqU8FcqJc6lB8RIBzdYUFIk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116195; c=relaxed/simple;
	bh=562HreYReXuoSEl2SeYNQ1DL16bmK3jUOLJqijSyGp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqIigweeR79VWs3PH1MbtFz7IGhqEHJdOYrYV5VMM2hzeinuPwxHJF6wxw3uzkNQf3rKKdV4XTm0Rlmy335++gOsRkODf5Rj+13+OHNBnO2ANhOI1kbTiAng0NPpbZLj4/Rkk4tznXEW7tubLZggLazd5BOZOxh8DrjukzUapJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVq8lRLG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVq8lRLG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785116193; x=1816652193;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=562HreYReXuoSEl2SeYNQ1DL16bmK3jUOLJqijSyGp0=;
  b=YVq8lRLGD0MZ2f8dCoaW+MChF/tf0ssbHrzOsGyQk4SbPNK4+WPY6+Yt
   s7hEUMLGL5nIy0kpgSAAMpu0K4GAdLDDZ5rVwyZFm/G9n6b/yr3Vv2p4n
   Sle1c8icnq7i6PqVCS76iN7qWhpbeHSbySejZ+DKANGLZjI1HnUamANJA
   g8+TE8vybEkDBrmVykwJZ9bgnZ+cZj6iuzs+30Ns6MNMZwHqXdiiAyNIa
   0909F1CKWMJ68L2DDFa29lxCn1KOORxKTUb2BUVNuMl8ZaJVs/aACBIap
   YB0E8fmEb+DSSUN+tIfobNGsRIV7yZAbeinyxFFS++H4YKohf5vC95n7g
   Q==;
X-CSE-ConnectionGUID: u8KQpysKQHWGNmMMQSZ8eQ==
X-CSE-MsgGUID: 9ummfTqhQxOrLc8c1QpJSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="96270481"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="96270481"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 18:36:32 -0700
X-CSE-ConnectionGUID: /o7fGayiRaqdrqWgbe/Wjg==
X-CSE-MsgGUID: k9XOl5HGRa2ECceUibDVjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="257482430"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 18:36:31 -0700
Message-ID: <47f1eaca-5d8b-4d25-83d1-5be54586ba06@linux.intel.com>
Date: Mon, 27 Jul 2026 09:34:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: Fix UCTP context table slot when copying
 root entries
To: Desnes Nunes <desnesn@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, stable@vger.kernel.org
Cc: dwmw2@infradead.org
References: <20260629144837.3244851-1-desnesn@redhat.com>
 <CACaw+eyE+Rk3NeGaWmo=Psw+aDNp4=Ggzj3DnrkL-fp04NZc+g@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CACaw+eyE+Rk3NeGaWmo=Psw+aDNp4=Ggzj3DnrkL-fp04NZc+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/17/26 19:59, Desnes Nunes wrote:
> Hello Baolu,
> 
> Can I further assist with any more requests or answering any remaining
> questions since the v1 review?

No. I will queue this patch for the next merge window. Thank you!

> 
> Best regards,
> 
> Desnes
> 
> On Mon, Jun 29, 2026 at 11:49 AM Desnes Nunes <desnesn@redhat.com> wrote:
>>
>> When translation is already enabled at boot (e.g. kdump), the vt-d driver
>> copies context tables from the previous kernel's root table. In scalable
>> mode, buses that only populate the upper root half (UCTP, devfn >= 0x80)
>> should be written to ctxt_tbls[tbl_idx + 1] through copy_context_table().
>> However, the current copy path always uses tbl[tbl_idx + 0] in this situa-
>> tion. Since idx wraps to 0 at devfn 0x80 due to a zeroed LCTP, new_ce for
>> LCTP will be NULL and keep pos equals to 0. Thus, UCTP entries will be co-
>> pied into tbl[tbl_idx + 0] instead of tbl[tbl_idx + 1], and written after-
>> wards to root_entry[bus].lo instead of .hi in copy_translation_tables().
>>
>> In short, devices on bus 0x80 with devfn >= 0x80 fail DMA with fault 0x39,
>> which will break drivers running in kernels with translation pre-enabled.
>> This fixes NO_PASID DMAR faults for UCTP-only buses such as:
>>
>> DMAR: [DMA Read NO_PASID] Request device [80:14.0] fault addr 0xe81759000 [fault reason 0x39] SM: Present bit in Root Entry is clear
>>
>> For instance, this fault yielded to locking issues between systemd and
>> xHCI, blocking a system's reboot after a vmcore was captured with kdump:
>>
>> [   72.987601] systemd-udevd[246]: usb3: Worker [255] processing SEQNUM=2193 is taking a long time
>> [  132.237566] dracut-initqueue[277]: Timed out while waiting for udev queue to empty.
>> [  202.988014] systemd-udevd[246]: usb3: Worker [255] processing SEQNUM=2193 killed
>> [  202.998059] systemd-udevd[246]: usb3: Worker [255] terminated by signal 9 (KILL).
>> ...
>> [  206.288378] kdump[569]: saving vmcore complete
>> ...
>> [  206.821258] systemd-shutdown[1]: Rebooting.
>> [  246.858495] INFO: task kworker/0:1:11 blocked for more than 122 seconds.
>> [  246.865319]       Not tainted 7.0.0-clean #1
>> [  246.869663] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  246.877623] task:kworker/0:1     state:D stack:0     pid:11 tgid:11    ppid:2      task_flags:0x4208160 flags:0x00080000
>> [  246.888942] Workqueue: usb_hub_wq hub_event
>> [  246.893202] Call Trace:
>> [  246.895690]  <TASK>
>> [  246.897828]  __schedule+0x299/0x5c0
>> [  246.901378]  schedule+0x27/0x80
>> [  246.904572]  schedule_timeout+0xbd/0x100
>> [  246.908565]  __wait_for_common+0x97/0x1b0
>> [  246.912644]  ? __pfx_schedule_timeout+0x10/0x10
>> [  246.917252]  xhci_alloc_dev+0x9e/0x2b0
>> [  246.921068]  usb_alloc_dev+0x7a/0x3b0
>> [  246.924795]  hub_port_connect+0x285/0x960
>> [  246.928873]  hub_port_connect_change+0x94/0x290
>> [  246.933482]  port_event+0x4bb/0x840
>> [  246.937030]  hub_event+0x141/0x460
>> [  246.940489]  process_one_work+0x196/0x390
>> [  246.944569]  worker_thread+0x1af/0x320
>> [  246.948383]  ? __pfx_worker_thread+0x10/0x10
>> [  246.952724]  kthread+0xe3/0x120
>> [  246.955921]  ? __pfx_kthread+0x10/0x10
>> [  246.959736]  ret_from_fork+0x199/0x260
>> [  246.963550]  ? __pfx_kthread+0x10/0x10
>> [  246.967362]  ret_from_fork_asm+0x1a/0x30
>> [  246.971355]  </TASK>
>> [  369.738508] INFO: task systemd-shutdow:1 blocked for more than 122 seconds.
>> [  369.745593]       Not tainted 7.0.0-clean #1
>> [  369.749935] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  369.757897] task:systemd-shutdow state:D stack:0     pid:1 tgid:1   ppid:0      task_flags:0x400100 flags:0x00080000
>> [  369.769128] Call Trace:
>> [  369.771616]  <TASK>
>> [  369.773752]  __schedule+0x299/0x5c0
>> [  369.777299]  schedule+0x27/0x80
>> [  369.780493]  schedule_preempt_disabled+0x15/0x30
>> [  369.785188]  __mutex_lock.constprop.0+0x547/0xac0
>> [  369.789974]  device_shutdown+0xac/0x1b0
>> [  369.793877]  kernel_restart+0x3a/0x70
>> [  369.797603]  __do_sys_reboot+0x147/0x240
>> [  369.801595]  do_syscall_64+0x11b/0x6a0
>> [  369.805407]  ? handle_mm_fault+0x110/0x350
>> [  369.809574]  ? do_user_addr_fault+0x206/0x680
>> [  369.814006]  ? irqentry_exit+0x7a/0x4d0
>> [  369.817907]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  369.823046] RIP: 0033:0x7fe2958da917
>> [  369.826684] RSP: 002b:00007ffc5c458618 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
>> [  369.834383] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe2958da917
>> [  369.841639] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
>> [  369.848893] RBP: 00007ffc5c458790 R08: 0000000000000069 R09: 00000000ffffffff
>> [  369.856148] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>> [  369.863402] R13: 0000000000000000 R14: 00007ffc5c4588b8 R15: 0000000000000000
>> [  369.870659]  </TASK>
>> [  369.872888] INFO: task systemd-shutdow:1 is blocked on a mutex likely owned by task kworker/0:1:11.
>>
>> Fixes: 091d42e43d21 ("iommu/vt-d: Copy translation tables from old kernel")
>> Signed-off-by: Desnes Nunes <desnesn@redhat.com>
>> ---
>> V1 -> V2: Updated commit message and added xHCI stack trace as requested
>>
>> v1: https://lore.kernel.org/linux-iommu/ajnlKDglN6wEBBrS@google.com/T/#t
>>
>>   drivers/iommu/intel/iommu.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 4d0e65bc131d..737936f942a0 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1443,7 +1443,7 @@ static int copy_context_table(struct intel_iommu *iommu,
>>                                struct context_entry **tbl,
>>                                int bus, bool ext)
>>   {
>> -       int tbl_idx, pos = 0, idx, devfn, ret = 0, did;
>> +       int tbl_idx, tbl_slot = 0, idx, devfn, ret = 0, did;
>>          struct context_entry *new_ce = NULL, ce;
>>          struct context_entry *old_ce = NULL;
>>          struct root_entry re;
>> @@ -1459,10 +1459,9 @@ static int copy_context_table(struct intel_iommu *iommu,
>>                  if (idx == 0) {
>>                          /* First save what we may have and clean up */
>>                          if (new_ce) {
>> -                               tbl[tbl_idx] = new_ce;
>> +                               tbl[tbl_idx + tbl_slot] = new_ce;
>>                                  __iommu_flush_cache(iommu, new_ce,
>>                                                      VTD_PAGE_SIZE);
>> -                               pos = 1;
>>                          }
>>
>>                          if (old_ce)
>> @@ -1484,6 +1483,9 @@ static int copy_context_table(struct intel_iommu *iommu,
>>                                  }
>>                          }
>>
>> +                       /* Track if saving UCTP or LCTP entries in scalable mode */
>> +                       tbl_slot = ext && devfn >= 0x80 ? 1 : 0;
>> +
>>                          ret = -ENOMEM;
>>                          old_ce = memremap(old_ce_phys, PAGE_SIZE,
>>                                          MEMREMAP_WB);
>> @@ -1512,7 +1514,7 @@ static int copy_context_table(struct intel_iommu *iommu,
>>                  new_ce[idx] = ce;
>>          }
>>
>> -       tbl[tbl_idx + pos] = new_ce;
>> +       tbl[tbl_idx + tbl_slot] = new_ce;
>>
>>          __iommu_flush_cache(iommu, new_ce, VTD_PAGE_SIZE);
>>
>> --
>> 2.54.0
>>

Thanks,
baolu


