Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813002;
	b=EsSMwAMucpT2sOvnzd6WfuXqMil95z/PAzJTTufH/VcbQ8Ucy5Uk2K2x2YlEURlEias0
	 CikifsC20rpvb9rOxxZCA6AeudPCslYH3UK8q4JW5uNhIFqOV5Js6alGOdzrEnKjLGQbP
	 duc5oQIf/JX0YJ8DQRWBEyRhuJk6rTMMbmwLlTTi7ZMANT2gwFQDc/9r1TqntmwDKgzdC
	 /ZKW3F5i/RkLtbZHanK/ToPnM0lxORZuuLZfE1NFuHgJxBif8kZHwIGzexgR1DAKSI/x7
	 IoM1rPDHjxX0ELL8JktMCzjBfklXvGXAVy4WRGzjcic590E1FXoaTTxCPDFUCUnj0Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813002;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HgNH1ksBGX98CE2bH1jPY9l/0FuthN2fRlNKJOzVZwA=;
	b=aj+F3jrrWShkLzvgQGHSCW/uJsEDYq8hfs+uLx03fXfs1Y4JTQLvmmqSw5yc14Gn3XE6
	 Ap+2rVx96I6Jvo94wHidz6T/h7209x6pkE7ZUqEwkk+zMHfn9Gygk/oLGeqbMplz4eNLE
	 Tt1JlbF+gpunJwEU3GXpEzNbgrPjrTCGkGPD39PMfggFGSQALSG3+4l9S29QR4G0AR6Uk
	 mXSEfr3zlJ0D8mKFOZyXhVOmUFhfFUPHIcmPwiL5k9xkC/VtsIJizjl+SHPLyU5XjaNkS
	 Zuk7Z8oUiTL4KR1RZTz+HbggZv/J+xDf8Lq77MDsY5nMjJkLHjr5EeTGidTHpIVQzKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N6jU7FA7;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDA606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACDA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N6jU7FA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794813002; x=1826349002;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f2FoQxrzWoSx2bDTdb3gWUp/L3kL9UPOZIPpU94A6x0=;
  b=N6jU7FA7kE1AHN/TKxWOw2+o3+HHpENIZCj/qVwlejEyRQGgBSOXi/B3
   fco7YJi1N06ljpjXJSFmvD5dZ+u5w5FTCXlL6kRGOPF+QA4h+zPGY9F2i
   OSP5eNU6cgSUpzU07Gv3t5iIZaPcIaUFjUsIkCONANr0v32TxEFa6krpS
   5JpR5r8MGo61H7zMVTM77bJJOlcaJq2XyEgEyqKpxGuX3u2+jo6Fbe4JH
   uQGaN3z8D2JQ36/AuuBzyubgKkVcyJjXMFkHpp9wYKbnkpA0VNPvQ9OKx
   emu/KBtUQGueR6cwdOuj+oedyQa9Jle8+xiY/IkICWv95tPLdm6VN7T2Y
   Q==;
X-CSE-ConnectionGUID: O3sus+laQJuz1juxj+ztjw==
X-CSE-MsgGUID: EMY8dMP2SOCtIw8sP1kDFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3577667"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3577667"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 23:10:02 -0800
X-CSE-ConnectionGUID: YcVgVu1AT3mxZpR4pyPdsQ==
X-CSE-MsgGUID: 4xjtn0sJTMS2Mup/uf9NXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9280860"
Received: from unknown (HELO [10.217.180.38]) ([10.217.180.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 23:09:59 -0800
Message-ID: <3f41d55a-1e7a-452f-ac9c-04703a600ffc@linux.intel.com>
Date: Mon, 16 Nov 2026 08:09:57 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/ivpu: Defer recovery until probe completes
To: Toast <swizzguy76@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
 <CAHBKUQaxYcVQvUc336wCOZzpS+GDw7yEbmAWvpT8CEUSg+cK2w@mail.gmail.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
In-Reply-To: <CAHBKUQaxYcVQvUc336wCOZzpS+GDw7yEbmAWvpT8CEUSg+cK2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15-Nov-26 16:24, Toast wrote:
> Tested v3 on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware 20260219)
> on top of v7.4-rc1 (d48723711bae):
> 
> - 4 kexec runs with the NPU runtime-suspended (one from a 7.0 kernel,
>    three from 7.4): every run hit ATS_ERR during probe, recovery_work was
>    not queued, probe failed with -ETIMEDOUT, and there was no oops
> - FLR plus rebind brings the NPU back, and it autosuspends afterwards
> - debugfs force_recovery after a successful probe recovers the NPU, and
>    it returns to runtime-suspended
> 
> None of the runs had probe succeed after the error IRQ, so the deferred
> recovery in ivpu_pm_enable() isn't covered by this.
> 
> One question: v2 had"Cc: stable@vger.kernel.org # v6.10+" and v3 dropped
> the annotation. disable_work()/enable_work() only exist since v6.10 and
> the Fixes: commit is in v6.3, so should the "# v6.10+" come back?

Thanks for testing, and good catch. I added "# v6.10+" to the stable tag 
when applying.

Applied to drm-misc-fixes.

> 
> Tested-by: Daksh Sahni<swizzguy76@gmail.com>
> 
> On Tue, Nov 10, 2026 at 5:45 PM Karol Wachowski
> <karol.wachowski@linux.intel.com> wrote:
>> An error IRQ that fires after ivpu_boot() enables interrupts queues
>> recovery_work during probe. If probe then fails, the device is torn
>> down while the work runs, and the work faults on the unmapped BARs:
>>
>>    BUG: unable to handle page fault for address: ffffcfc6680200f4
>>    Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
>>    RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
>>    Call Trace:
>>     ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
>>     ivpu_boot+0x9e/0x270 [intel_vpu]
>>     ivpu_resume+0xa4/0xd0 [intel_vpu]
>>     ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
>>     ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]
>>
>> If probe succeeds, the recovery runs concurrently with the rest of
>> probe, and its pm_runtime_disable() discards the initial autosuspend
>> request, leaving the NPU active until first use. Any recovery that
>> starts while the NPU is idle loses the pending autosuspend the same way.
>>
>> Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable().
>> A trigger during probe still runs diagnostics and masks interrupts, and
>> ivpu_pm_enable() runs the deferred recovery before the initial
>> autosuspend request. A trigger racing with ivpu_pm_enable() can cause
>> a second, harmless recovery. Request autosuspend at the end of
>> ivpu_pm_reset_complete() so the NPU suspends again after every reset.
>>
>> Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
>> Cc:stable@vger.kernel.org
>> Reported-by: Daksh Sahni<swizzguy76@gmail.com>
>> Closes:https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
>> Signed-off-by: Karol Wachowski<karol.wachowski@linux.intel.com>
>> ---
>>
>> Notes:
>>      v3:
>>      - Request autosuspend at the end of ivpu_pm_reset_complete().
>>        pm_runtime_disable() in ivpu_pm_reset_begin() cancels a pending
>>        autosuspend request and pm_runtime_enable() does not re-issue it, so
>>        a recovery racing with the initial autosuspend request in
>>        ivpu_pm_enable() left the NPU active until first use (Sashiko).
>>        A trigger racing with ivpu_pm_enable() can still queue recovery
>>        twice. The second run is a full reset that leaves the device in a
>>        consistent state, and autosuspend is now re-requested after each
>>        reset.
>>      - Replace pm_runtime_mark_last_busy() with pm_request_autosuspend() in
>>        ivpu_pm_reset_complete(); it marks the device busy itself.
>>      - Shorten the commit message.
>>      - v2:https://lore.kernel.org/r/20261110085003.3527014-1- 
>> karol.wachowski@linux.intel.com
>>
>>      v2:
>>      - Rework of Daksh's "accel/ivpu: Disable recovery work on probe failure":
>>        https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
>>      - Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable()
>>        instead of disabling it on the probe error path, which is too late as
>>        recovery may already run concurrently with ivpu_boot() (Sashiko)
>>      - Run a recovery requested during probe from ivpu_pm_enable() and wait
>>        for it before the initial autosuspend request, so the NPU is reset
>>        before use and the autosuspend is not lost when probe succeeds
>>
>>      v1:
>>      - Link:https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
>>
>>   drivers/accel/ivpu/ivpu_pm.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
>> index aa813262253e..e4b79c946ca0 100644
>> --- a/drivers/accel/ivpu/ivpu_pm.c
>> +++ b/drivers/accel/ivpu/ivpu_pm.c
>> @@ -150,8 +150,8 @@ static void ivpu_pm_reset_complete(struct ivpu_device *vdev)
>>          up_write(&vdev->pm->reset_lock);
>>          atomic_set(&vdev->pm->reset_pending, 0);
>>
>> -       pm_runtime_mark_last_busy(vdev->drm.dev);
>>          pm_runtime_enable(vdev->drm.dev);
>> +       pm_request_autosuspend(vdev->drm.dev);
>>   }
>>
>>   static void ivpu_pm_recovery_work(struct work_struct *work)
>> @@ -415,6 +415,7 @@ void ivpu_pm_init(struct ivpu_device *vdev)
>>          atomic_set(&pm->engine_reset_counter, 0);
>>
>>          INIT_WORK(&pm->recovery_work, ivpu_pm_recovery_work);
>> +       disable_work(&pm->recovery_work);
>>          INIT_DELAYED_WORK(&pm->job_timeout_work, ivpu_job_timeout_work);
>>
>>          if (ivpu_disable_recovery)
>> @@ -439,6 +440,12 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
>>   {
>>          struct device *dev = vdev->drm.dev;
>>
>> +       enable_work(&vdev->pm->recovery_work);
>> +       if (atomic_read(&vdev->pm->reset_pending)) {
>> +               queue_work(system_dfl_wq, &vdev->pm->recovery_work);
>> +               flush_work(&vdev->pm->recovery_work);
>> +       }
>> +
>>          pm_runtime_allow(dev);
>>          pm_runtime_put_autosuspend(dev);
>>   }
>>
>> base-commit: 54d3ff1b5ac08d0e28029b93a1719ddd9ff670a4
>> --
>> 2.43.0

