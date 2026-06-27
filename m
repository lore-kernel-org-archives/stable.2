Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C41991CB;
	Sat, 27 Jun 2026 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782542801; cv=none; b=MR654xaSHKXcoYpGC4AwUnjMmxEsOS364LbtXi7h0h7Tll9Cj6w5VI9OdjOBIsdF4cy73qBm5NZpdr865j9TPftzQPYKDiOr5QsD1BNhA34xMNXCawcn4+0GvWGjnYR8Q32z01gxwDvIq2pk9MLtv2M35HrHO1QKtxw0etkSCFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782542801; c=relaxed/simple;
	bh=1ZU4PXIbpJ62dFQtt4f4Z+ju5PABDgSmdwIvFY6uQbw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GOtBQCa89qwnexUG3y93+ht3LlFRrJBj8E40v9tbG6PdUyKCAb9/mT1hZo0Iguk7RQ7vGLXMV81Fbli56KDrDbnoXR3EG0icRdHrKMX28T5W7oja+UUaeR0AJxS4P0XEbWHGEi9aPWhdJGLwrDbyM0q2WksvjD3u6/Qvm2z6kOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cf/C9242; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cf/C9242"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782542800; x=1814078800;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ZU4PXIbpJ62dFQtt4f4Z+ju5PABDgSmdwIvFY6uQbw=;
  b=Cf/C9242AYPISZE1Yj4RgFS7T+/B2r2qqBv6l7zQisElv3xGxwm22pwT
   umoY494yBeWatn2a2mF/qjeWxutI89wXVRx3yaHxfCaj1euCYlpZtDA2O
   KCneDkMuDcdeCIlR0BJqbqP5kv1BD3253TgAMaLNlC5UgKRlLMrL5qfi7
   AVeRUz0eHQvmLVH2F35+It+58odkMT7y921FE63/Se6vSQ7L6rMz47M5G
   2KeKb/9poMYPpxCv7Dman98acB/B2YP6P7g83qd/UkEd/WxPPh5zd+J6I
   GO+RLnwIdRcEbi0WUXZ77Wqz3j00bmUmPYSs1le6rHJMwVOZrmalUk6+K
   w==;
X-CSE-ConnectionGUID: F5Wrz+fiTUeNwQFIp122Tw==
X-CSE-MsgGUID: 1Mqq2IGDQky3jWmz0wqdAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="108862639"
X-IronPort-AV: E=Sophos;i="6.24,228,1774335600"; 
   d="scan'208";a="108862639"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 23:46:39 -0700
X-CSE-ConnectionGUID: N/iVHx3MRlyP6u/Hxs8A8A==
X-CSE-MsgGUID: /6GuFxfyRByhAvwSio/qWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,228,1774335600"; 
   d="scan'208";a="245108607"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.236.63]) ([10.124.236.63])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 23:46:37 -0700
Message-ID: <be228d1b-f4f8-4cc8-ab35-717571d0db36@linux.intel.com>
Date: Sat, 27 Jun 2026 14:46:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org
Subject: Re: [PATCH] iommu/vt-d: Fix UCTP context table slot when copying root
 entries
To: Desnes Nunes <desnesn@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <20260622133540.48591-1-desnesn@redhat.com>
 <CACaw+ewAhmPYxnQgpzh-zL823YEuyZGDukwAzeDUOvRU9RrWcA@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CACaw+ewAhmPYxnQgpzh-zL823YEuyZGDukwAzeDUOvRU9RrWcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/2026 8:57 AM, Desnes Nunes wrote:
> Hello IOMMU mailing list,
> 
> On Mon, Jun 22, 2026 at 10:37 AM Desnes Nunes <desnesn@redhat.com> wrote:
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
>> As consequence, devices on bus 0x80 with devfn >= 0x80 fail DMA with
>> fault 0x39, which breaks drivers running in kernels with translation
>> pre-enabled. This fixes NO_PASID DMAR faults for UCTP-only buses such as:
>>
>> DMAR: [DMA Read NO_PASID] Request device [80:14.0] fault addr 0xe81759000 [fault reason 0x39] SM: Present bit in Root Entry is clear
> 
> FYI, this bug can block a system from rebooting after collecting a
> kdump, with a stack trace similar to:

So this not only addresses a DMA fault message, but also resolves a
real-world kdump reboot issue. When you send the next version, could you
please include this and the below stack trace in the commit message?

The change itself looks good to me. Thank you!

> 
> [   72.987601] systemd-udevd[246]: usb3: Worker [255] processing
> SEQNUM=2193 is taking a long time
> [  132.237566] dracut-initqueue[277]: Timed out while waiting for udev
> queue to empty.
> [  202.988014] systemd-udevd[246]: usb3: Worker [255] processing
> SEQNUM=2193 killed
> [  202.998059] systemd-udevd[246]: usb3: Worker [255] terminated by
> signal 9 (KILL).
> ...
> [  206.288378] kdump[569]: saving vmcore complete
> ...
> [  206.821258] systemd-shutdown[1]: Rebooting.
> [  246.858495] INFO: task kworker/0:1:11 blocked for more than 122 seconds.
> [  246.865319]       Not tainted 7.0.0-clean #1
> [  246.869663] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  246.877623] task:kworker/0:1     state:D stack:0     pid:11 tgid:11
>     ppid:2      task_flags:0x4208160 flags:0x00080000
> [  246.888942] Workqueue: usb_hub_wq hub_event
> [  246.893202] Call Trace:
> [  246.895690]  <TASK>
> [  246.897828]  __schedule+0x299/0x5c0
> [  246.901378]  schedule+0x27/0x80
> [  246.904572]  schedule_timeout+0xbd/0x100
> [  246.908565]  __wait_for_common+0x97/0x1b0
> [  246.912644]  ? __pfx_schedule_timeout+0x10/0x10
> [  246.917252]  xhci_alloc_dev+0x9e/0x2b0
> [  246.921068]  usb_alloc_dev+0x7a/0x3b0
> [  246.924795]  hub_port_connect+0x285/0x960
> [  246.928873]  hub_port_connect_change+0x94/0x290
> [  246.933482]  port_event+0x4bb/0x840
> [  246.937030]  hub_event+0x141/0x460
> [  246.940489]  process_one_work+0x196/0x390
> [  246.944569]  worker_thread+0x1af/0x320
> [  246.948383]  ? __pfx_worker_thread+0x10/0x10
> [  246.952724]  kthread+0xe3/0x120
> [  246.955921]  ? __pfx_kthread+0x10/0x10
> [  246.959736]  ret_from_fork+0x199/0x260
> [  246.963550]  ? __pfx_kthread+0x10/0x10
> [  246.967362]  ret_from_fork_asm+0x1a/0x30
> [  246.971355]  </TASK>
> [  369.738508] INFO: task systemd-shutdow:1 blocked for more than 122 seconds.
> [  369.745593]       Not tainted 7.0.0-clean #1
> [  369.749935] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  369.757897] task:systemd-shutdow state:D stack:0     pid:1 tgid:1
>    ppid:0      task_flags:0x400100 flags:0x00080000
> [  369.769128] Call Trace:
> [  369.771616]  <TASK>
> [  369.773752]  __schedule+0x299/0x5c0
> [  369.777299]  schedule+0x27/0x80
> [  369.780493]  schedule_preempt_disabled+0x15/0x30
> [  369.785188]  __mutex_lock.constprop.0+0x547/0xac0
> [  369.789974]  device_shutdown+0xac/0x1b0
> [  369.793877]  kernel_restart+0x3a/0x70
> [  369.797603]  __do_sys_reboot+0x147/0x240
> [  369.801595]  do_syscall_64+0x11b/0x6a0
> [  369.805407]  ? handle_mm_fault+0x110/0x350
> [  369.809574]  ? do_user_addr_fault+0x206/0x680
> [  369.814006]  ? irqentry_exit+0x7a/0x4d0
> [  369.817907]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  369.823046] RIP: 0033:0x7fe2958da917
> [  369.826684] RSP: 002b:00007ffc5c458618 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000a9
> [  369.834383] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe2958da917
> [  369.841639] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
> [  369.848893] RBP: 00007ffc5c458790 R08: 0000000000000069 R09: 00000000ffffffff
> [  369.856148] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> [  369.863402] R13: 0000000000000000 R14: 00007ffc5c4588b8 R15: 0000000000000000
> [  369.870659]  </TASK>
> [  369.872888] INFO: task systemd-shutdow:1 is blocked on a mutex
> likely owned by task kworker/0:1:11.
> 
> A summary of the debugging and logic for the fix can be found in the
> following RFC message, which came from the USB mailing list:
> https://lore.kernel.org/linux-iommu/CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXaFbd=ySXf8E5A@mail.gmail.com/T/#mf184c20cff4dcf491deb106b6d65b80dcb58368d
> 
> Best Regards,
> 
> Desnes Nunes
> 

Thanks,
baolu

