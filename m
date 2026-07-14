Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CEC3EEAD2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021847; cv=none; b=sBHspDW9wxmIhZ1AGRwmdX3hV46zR/0ukKRZ5dazh0xvyvvmR4zEgBUd/ByR+p7JSHa1nmFJDKZWirgjonrWgdd0lu+Iw6+9WpXKUyAdV86EWFO215tMPESAtm/bTVHeAMgCs93+aHgch2QGfqNPhtvQk7NVdqEasjXsJDtEzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021847; c=relaxed/simple;
	bh=jLwqC21xb7zoZVvgedRMLOS2jDIp3UeUNShVHI/8WFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RG/Fw0JCQEW8uOl3fHfhtbXat/vXBgnG8ob7pZ0UcjRYkLFna2Kq+p86UxGgXsHMgoeee7AbZQpbA5CRLe4Zj3gaoJxsHPLspcH48eVQEwRDLgyAotqmRxvIw+fmYIo6yff+rLpmX85rCF8b3hcMHeLmpgXsSGMIqEb8e+NGY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MQoqCBfA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MQoqCBfA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DD9B2F;
	Tue, 14 Jul 2026 02:37:20 -0700 (PDT)
Received: from [10.1.34.162] (e121487-lin.cambridge.arm.com [10.1.34.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6163F93E;
	Tue, 14 Jul 2026 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784021844; bh=jLwqC21xb7zoZVvgedRMLOS2jDIp3UeUNShVHI/8WFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MQoqCBfAv/eWGkJQmLgUxzmAwK9FyI08a0gMRrPdYjV19f/XBQ1QSuGFIniiMoHr9
	 MlpnLG9GMapGMmANEKd6YVgwmxYdfoxSNzUxZuuqpKmZ9NofhE7Elp6Ro2Tccy+8AD
	 Sh9YdqmC/93JBtv/NQqrYe6qKpa/VMHtj5yVNgFE=
Message-ID: <8157087e-74e9-47bc-ad57-c2641a58acc8@arm.com>
Date: Tue, 14 Jul 2026 10:37:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/36] arm64: hibernate: mask DAIF before restoring
 hibernated kernel
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, maz@kernel.org, will@kernel.org,
 catalin.marinas@arm.com, Ada Couprie Diaz <ada.coupriediaz@arm.com>,
 stable@vger.kernel.org
References: <20260709121333.23507-1-vladimir.murzin@arm.com>
 <20260709121333.23507-4-vladimir.murzin@arm.com>
 <a88a1ce6-f2e0-44ff-9713-57a94c78c24e@huawei.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <a88a1ce6-f2e0-44ff-9713-57a94c78c24e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 04:28, Jinjie Ruan wrote:
>> @@ -465,9 +466,21 @@ int __nocfi swsusp_arch_resume(void)
>>  	if (el2_reset_needed())
>>  		__hyp_set_vectors(el2_vectors);
>>  
>> +	/*
>> +	 * It is necessary to mask all DAIF exceptions here as:
>> +	 *
>> +	 * - The copy of swsusp_arch_suspend_exit() in the hibernation
>> +	 *   text cannot handle taking any exceptions.
>> +	 *
>> +	 * - The suspended kernel masked all DAIF exceptions in
>> +	 *   swsusp_arch_resume(), and expects to be re-entered in the
>> +	 *   same state : with all DAIF exceptions masked.
>> +	 */
>> +	flags = local_daif_save();
>>  	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
>>  		       resume_hdr.reenter_kernel, restore_pblist,
>>  		       resume_hdr.__hyp_stub_vectors, virt_to_phys(zero_page));
>> +	local_daif_restore(flags);
> I believe that the local_daif_save() here is also unnecessary because
> hibernate_exit() returns from the "return 0 branch" of
> __cpu_suspend_enter() in swsusp_arch_suspend(), and before that,
> local_daif_save() has already been called to mask all exceptions.
> 
> swsusp_arch_suspend(void)
>     -> flags = local_daif_save();
>     -> if (__cpu_suspend_enter(&state)) {
>            ...
>         } else {                // _cpu_resume <- hibernate_exit()
> 
>            ...
>            in_suspend = 0;
>            ...
>         }
>      -> local_daif_restore(flags);

I'm not sure I follow, we are protecting path

...
load_image_and_restore()
  -> hibernation_restore()
     -> resume_target_kernel()
        -> local_irq_disable()
        -> swsusp_arch_resume()
	  -> swsusp_arch_suspend_exit (aka hibernate_exit())
	     -> ...


issue can be easily observed with debug diff bellow applied on top of the
series

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 4dd40593f736..709f5f4c420a 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -476,6 +476,7 @@ int __nocfi swsusp_arch_resume(void)
         *   swsusp_arch_resume(), and expects to be re-entered in the
         *   same state : with all DAIF exceptions masked.
         */
+       arm64_debug_exc_context(CRITICAL_CONTEXT);
        flags = local_all_irqs_save_mask(CRITICAL_CONTEXT);
        hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
                       resume_hdr.reenter_kernel, restore_pblist,

That would generate warning when run on qemu

 ------------[ cut here ]------------
 Unexpected DAIF+ALLINT: 0xc0 + 0x0 (expected 0x3c0 + 0x2000)
 WARNING: ./arch/arm64/include/asm/interrupts/common_flags.h:175 at swsusp_arch_resume+0x2d0/0x32c, CPU#0: sh/100
 Modules linked in:
 CPU: 0 UID: 0 PID: 100 Comm: sh Not tainted 7.2.0-rc2-00041-gc07d2a0843b2-dirty #288 PREEMPTLAZY 
 Hardware name: linux,dummy-virt (DT)
 pstate: 614000c5 (nZCv daIF -ALLINT +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
 pc : swsusp_arch_resume+0x2d0/0x32c
 lr : swsusp_arch_resume+0x2d0/0x32c
 sp : ffff800081adba80
 x29: ffff800081adbad0 x28: fff00000024ff000 x27: 0000000000000000
 x26: 0000000000000000 x25: 0000000000000000 x24: ffff8000815cd000
 x23: ffff8000815b4000 x22: ffff8000815c28d8 x21: ffff8000815c2000
 x20: fff000000a839000 x19: 0000000000000000 x18: 0000000000000006
 x17: 0000000000000000 x16: 0000000000000000 x15: ffff800081adb64f
 x14: ffff800081adb470 x13: ffff800101adb647 x12: 000000648200003c
 x11: ffff8000815cd8e8 x10: 0000000000000161 x9 : ffff8000815cd8e8
 x8 : 0000000000000162 x7 : ffff8000816258e8 x6 : ffff8000816258e8
 x5 : 3fffffffffffefff x4 : bffffffffffff000 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : fff00000024ff000
 Call trace:
  swsusp_arch_resume+0x2d0/0x32c (P)
  hibernation_restore+0xe0/0x1a4
  load_image_and_restore+0x60/0xb0
  hibernate+0x228/0x374
  state_store+0xe8/0xf4
  kobj_attr_store+0x18/0x34
  sysfs_kf_write+0x5c/0x78
  kernfs_fop_write_iter+0x130/0x200
  vfs_write+0x20c/0x380
  ksys_write+0x70/0x110
  __arm64_sys_write+0x1c/0x28
  invoke_syscall.constprop.0+0x58/0x100
  do_el0_svc+0x40/0xc0
  el0_svc+0x200/0xa0c
  el0t_64_sync_handler+0x110/0x20c
  el0t_64_sync+0x1ac/0x1b0
 ---[ end trace 0000000000000000 ]---

Cheers
Vladimir
