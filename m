Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343C1ABEDE;
	Fri, 18 Sep 2026 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700266; cv=none; b=EFTRWzmGwFHhiKg2oSbrTvLn1WVYkg7RVpSaL81g0meddmfqNsYs/RIL0sMOKCgxzsNSG2Cjx1JOEEpifeumOAHsyhyVEXiXQH2zI7URBL2mxJO57FPDp6J2FWMICsliGSb39/e9QHsjhtk+VINJi1BVdkNf6GUCliYfJYUNb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700266; c=relaxed/simple;
	bh=aAjpa6bnnLolC2AH0MQcbXXLVxzjP3SG082xAduKhq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbT3goVr8Sj7FRJJot6YC7sSsxM3QkS4zsVr3G/Ykj3GRqaGzGXr48gLHwtGCa9jYhv8dHh120OIE0s74Vq7PBTNM6rJWaWNjFfEPGXVAiZudTh/fWg+jQZGPzliZEXdW6Ci5LgkWNOir+vtX9u+mHX9pQ7XyMb7BuxsMoQN6w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=w95KzQGy; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="w95KzQGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1789700171;
	bh=xQ+zTE+9vU49o9RNcQsSxTV6kk2iH8SW9z3RxuGwdfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=w95KzQGyaMM//iF6gTjs6Tk9n/LNyXS+GGDxD68MvvF4Ekh/e+evgc/T+aWXtVmfF
	 ZtOvVWpR0UH4Oy86w5rdxN1vlrRkDyk/iumO5OcfA56a/AsQpXVhRgFhOiVXld0oOu
	 LlfX4kfwyC5vHMCHxTZU40/sUA+Lc0EQALLm41/8=
X-QQ-mid: zesmtpip4t1789700166tfa6ff522
X-QQ-Originating-IP: +IoAnuJOqXSFdaflOmt99MkgoaB2Z5g2bJ7LVggAuA0=
Received: from [127.0.0.1] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Sep 2026 10:56:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15218402641133599604
Message-ID: <D5E5A48ABBA3A691+6cc38c11-c7a0-4e2f-b3b7-501fc1685808@smail.nju.edu.cn>
Date: Fri, 18 Sep 2026 10:56:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: don't bump pin count on failed re-pin in
 nouveau_bo_pin_locked()
To: lyude@redhat.com, dakr@kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, bskeggs@redhat.com
References: <4C61D1CE5BB7CD58+20260910080659.2798052-1-peiyang_he@smail.nju.edu.cn>
 <fb1701bbd7fb65ae808f495488880e2f0fbbced3.camel@redhat.com>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Autocrypt: addr=peiyang_he@smail.nju.edu.cn; keydata=
 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
 Jf2f8FkzVjySi3JGfg==
In-Reply-To: <fb1701bbd7fb65ae808f495488880e2f0fbbced3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Ocns8ug84zPh5VotyTHfI4UHS7UOULyEAEOvhoMPudxzBr21g123S6We
	fot8rKdR4ABJwRRwO9Q1GhDwwcrISwTABQxlSUMBvWkDCU/9FhGlvdR3MMpowyfKFMLKtCd
	JdYs0RvgFXRgnlWlGMJ9qEjsrbks+yUeow7hXWfj7hqiB9z7gb95HmDYIAhw7lTlMmPRmKJ
	ZasalP88OvT2eEX2KnAe5lYb2k38d53pAM9+1VJ42/yzxlSzBCnXpdml4kyAHXw78shLIU6
	h5ekvbRDLwK/I+uS9G/JAm7CpTKV8CAQQeljcoYDw/JT6Jd8H8rrQEq9BZATOBO9rb3XD+R
	4GIxEvMscmLQEh05xLMsJQIS5wsrzcvlI+LMeYDFWZP78/3akpF7QSrV8bywhe+9SXI3klZ
	Pmk5KzPSb2f6ymqgJZw0cAncqXFBESxBoH3HUW4IoSN1R6gQUlOBS56jrKy282eeu/4nNXM
	xdziFO89/cfW6BB/XQ1BRwbLafGbts5zbiKhLR5DINdlsQLlyCPsfBwNJ1zp1I5v5L/yPfa
	nNN8iar2xd5NO+UFVcgNitIQ1Ih92PWXEB17T5vRiGXT0sszGekQ3/roUbAtPP92PW7PIfg
	D4E26mwfXaahPct+pRsJ8S2BNjphpUE1yctj2GNXt/tFMnsUmd/jYI2iXTCeiaqfUwF93hH
	44J3hpIq+SKEPd5UIfAe75wdO4wb+hzrpZf6v4wOmoTtmxZ6MpXGbfx4L7Y7wiiYRzKHDhv
	ELehWuf1WVhwHbtvC2mLpMNbR8wbpzxK9wpghV/i/Knwn1MBIPXJbj7aGv6ArKonj5OX6B2
	r2hi0QhQ+v2ecmWd0Bryu0+8bXU3jZpnIMXledFNL0pDYdtU1TErXh5BlAMbDWm6Au+0IrV
	Ua7M1E7gPY+4vdv/lmYUvT9QewYXGSvmOkIj1lGJo3VILKf5Me7ygWHkC0GaPaki0PUTZPo
	nVSU/Xggfi/zKfpPeDJe0QDiSKhynT0FyQpw+JDUe0kM7ytT8twfIwOX/t1yhffU03XUNK/
	4WusBxHawRQuF21Kr/+Jq0RGEn511yTaWV+iLcu9/uo3YUqLDR0WA7uT4aJzWgYpBwP11SG
	tjhqookUwp4cVdUNXuXmwn2cMaBUghfTQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

On 2026/9/18 05:20, lyude@redhat.com wrote:
> On Thu, 2026-09-10 at 16:06 +0800, Peiyang He wrote:
>> nouveau_bo_pin_locked() checks whether an already pinned BO is in a
>> memory domain compatible with a new pin request. When the domains are
>> incompatible, it sets -EBUSY but still calls ttm_bo_pin() before
>> returning.
>>
>> Callers treat a failed nouveau_bo_pin() as not having acquired a new
>> pin,
>> so the extra pin count is never decreased by a matching unpin.
>> This triggers the warning in ttm_bo_release():
>>
>> 	WARN_ON_ONCE(bo->pin_count);
>>
>> Found when fuzzing the nouveau driver with a modified Syzkaller:
>>
>> 	WARNING: drivers/gpu/drm/ttm/ttm_bo.c:256 at
>> ttm_bo_release+0x827/0x9e0 drivers/gpu/drm/ttm/ttm_bo.c:256, CPU#1:
>> syz.3.24/2212
>> 	Modules linked in:
>> 	CPU: 1 UID: 0 PID: 2212 Comm: syz.3.24 Not tainted 7.2.0 #24
>> PREEMPT(lazy) 
>> 	nouveau 0000:01:00.0: gsp:msg fn:103 len:0x40/0x20 res:0x19
>> resp:0x19
>> 	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> 1.16.3-debian-1.16.3-2 04/01/2014
>> 	RIP: 0010:ttm_bo_release+0x827/0x9e0
>> drivers/gpu/drm/ttm/ttm_bo.c:256
>> 	Code: 02 00 0f 85 51 01 00 00 48 8b 7b 08 e8 d2 20 01 00 e9
>> 80 fd ff ff e8 d8 15 c0 fe 90 0f 0b 90 e9 e1 f8 ff ff e8 ca 15 c0 fe
>> 90 <0f> 0b 90 e9 a4 f8 ff ff e8 bc 15 c0 fe be 03 00 00 00 4c 89 e7
>> e8
>> 	msg: 00000000: 05 00 d0 c1 04 00 f0 f1 01 30 00 00 2d 90 00
>> 00  .........0..-...
>> 	RSP: 0018:ffffc9000f5cf710 EFLAGS: 00010293
>> 	RAX: 0000000000000000 RBX: ffff888018e5d2a8 RCX:
>> ffffffff82bb1b36
>> 	RDX: ffff888017b68000 RSI: 0000000000000004 RDI:
>> ffff888018e5d2a8
>> 	msg: 00000010: 19 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00  ................
>> 	RBP: ffff88801261c720 R08: 0000000000000001 R09:
>> ffffed10031cba55
>> 	R10: ffff888018e5d2ab R11: 00000000000000f3 R12:
>> ffff888018e5d290
>> 	R13: ffff888018e5d2d4 R14: ffff88801b219c18 R15:
>> dffffc0000000000
>> 	FS:  0000000000000000(0000) GS:ffff8880e0f6f000(0000)
>> knlGS:0000000000000000
>> 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> 	CR2: 0000001b31223ffc CR3: 0000000028e00005 CR4:
>> 0000000000770ef0
>> 	PKRU: 80000000
>> 	Call Trace:
>> 	<TASK>
>> 	kref_put include/linux/kref.h:65 [inline]
>> 	ttm_bo_put drivers/gpu/drm/ttm/ttm_bo.c:325 [inline]
>> 	ttm_bo_fini+0x55/0x80 drivers/gpu/drm/ttm/ttm_bo.c:330
>> 	nouveau_gem_object_del+0xb2/0x1b0
>> drivers/gpu/drm/nouveau/nouveau_gem.c:90
>> 	drm_gem_object_free+0x5f/0x90 drivers/gpu/drm/drm_gem.c:1165
>> 	kref_put include/linux/kref.h:65 [inline]
>> 	__drm_gem_object_put include/drm/drm_gem.h:562 [inline]
>> 	drm_gem_object_put include/drm/drm_gem.h:575 [inline]
>> 	nouveau_abi16_chan_fini.constprop.0+0x44f/0x5a0
>> drivers/gpu/drm/nouveau/nouveau_abi16.c:195
>> 	nouveau 0000:01:00.0: syz.2.23[2209]: Unknown handle
>> 0x00000000
>> 	nouveau_abi16_fini+0x1d0/0x340
>> drivers/gpu/drm/nouveau/nouveau_abi16.c:225
>> 	nouveau_drm_postclose+0x18b/0x3e0
>> drivers/gpu/drm/nouveau/nouveau_drm.c:1284
>> 	nouveau 0000:01:00.0: syz.2.23[2209]: validate_init
>> 	drm_file_free.part.0+0x6d6/0xb60
>> drivers/gpu/drm/drm_file.c:267
>> 	drm_file_free drivers/gpu/drm/drm_file.c:237 [inline]
>> 	drm_close_helper.isra.0+0x11a/0x160
>> drivers/gpu/drm/drm_file.c:290
>> 	drm_release+0x1ab/0x330 drivers/gpu/drm/drm_file.c:438
>> 	__fput+0x39c/0xa60 fs/file_table.c:512
>> 	nouveau 0000:01:00.0: syz.2.23[2209]: validate: -2
>> 	task_work_run+0x15a/0x230 kernel/task_work.c:233
>> 	exit_task_work include/linux/task_work.h:40 [inline]
>> 	do_exit+0x82b/0x25a0 kernel/exit.c:1009
>> 	do_group_exit+0xc2/0x280 kernel/exit.c:1152
>> 	get_signal+0x1d6e/0x1f30 kernel/signal.c:3046
>> 	arch_do_signal_or_restart+0x7d/0x6e0
>> arch/x86/kernel/signal.c:337
>> 	__exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
>> 	exit_to_user_mode_loop+0xdf/0x440 kernel/entry/common.c:101
>> 	__exit_to_user_mode_prepare include/linux/irq-entry-
>> common.h:207 [inline]
>> 	syscall_exit_to_user_mode_prepare include/linux/irq-entry-
>> common.h:230 [inline]
>> 	syscall_exit_to_user_mode include/linux/entry-common.h:318
>> [inline]
>> 	do_syscall_64+0x4f8/0x690 arch/x86/entry/syscall_64.c:100
>> 	entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> 	RIP: 0033:0x7f12bac8594d
>> 	Code: Unable to access opcode bytes at 0x7f12bac85923.
>> 	RSP: 002b:00007f12b96e70d8 EFLAGS: 00000246 ORIG_RAX:
>> 00000000000000ca
>> 	RAX: 0000000000000001 RBX: 00007f12baf15fa8 RCX:
>> 00007f12bac8594d
>> 	RDX: 00000000000f4240 RSI: 0000000000000081 RDI:
>> 00007f12baf15fac
>> 	RBP: 00007f12baf15fa0 R08: 00007f12baee8000 R09:
>> 0000000000000000
>> 	R10: 0000000000000000 R11: 0000000000000246 R12:
>> 0000000000000000
>> 	R13: 00007f12baf16038 R14: 0000000000000006 R15:
>> 00007ffe2ed394b0
>> 	</TASK>
>> 	irq event stamp: 47867
>> 	hardirqs last  enabled at (47883): [<ffffffff815cafc6>]
>> __up_console_sem+0x66/0x70 kernel/printk/printk.c:347
>> 	hardirqs last disabled at (47892): [<ffffffff815cafab>]
>> __up_console_sem+0x4b/0x70 kernel/printk/printk.c:345
>> 	softirqs last  enabled at (47880): [<ffffffff81434277>]
>> __do_softirq kernel/softirq.c:656 [inline]
>> 	softirqs last  enabled at (47880): [<ffffffff81434277>]
>> invoke_softirq kernel/softirq.c:496 [inline]
>> 	softirqs last  enabled at (47880): [<ffffffff81434277>]
>> __irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735
>> 	softirqs last disabled at (47875): [<ffffffff81434277>]
>> __do_softirq kernel/softirq.c:656 [inline]
>> 	softirqs last disabled at (47875): [<ffffffff81434277>]
>> invoke_softirq kernel/softirq.c:496 [inline]
>> 	softirqs last disabled at (47875): [<ffffffff81434277>]
>> __irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735
>>
>> Fix by going to the out path as soon as the incompatible placement
>> is detected. This matches the correct bahaviour in other DRM drivers
>> such as amdgpu_bo_pin() in amdgpu.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: ad76b3f7c7a0 ("drm/nouveau: teach nouveau_bo_pin() how to
>> force a contig vram allocation")
>> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
>> Assisted-by: Codex:gpt-5.5
> 
> This can and probably should just be:
> 
> Assisted-by: LLM
> 
> Instead of mentioning the LLM specifically used.
> 
>> ---
>>  drivers/gpu/drm/nouveau/nouveau_bo.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c
>> b/drivers/gpu/drm/nouveau/nouveau_bo.c
>> index 0e8de6d4b36f..bdd0390b590e 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
>> @@ -578,6 +578,7 @@ int nouveau_bo_pin_locked(struct nouveau_bo
>> *nvbo, uint32_t domain, bool contig)
>>  				      "0x%08x vs 0x%08x\n", bo,
>>  				 bo->resource->mem_type, domain);
>>  			ret = -EBUSY;
>> +			goto out;
> 
> Would probably be better to just turn this into an else:
> 
> 	if (error) {
> 		NV_ERROR(drm, "bo %p pinned elsewhere: "
> 			      "0x%08x vs 0x%08x\n", bo,
> 			 bo->resource->mem_type, domain);
> 		ret = -EBUSY;
> 	} else {
> 		ttm_bo_pin(&nvbo->bo);
> 	}
> 
> 
>>  		}
>>  		ttm_bo_pin(&nvbo->bo);
>>  		goto out;
>>
>> base-commit: df2908090cda368b01ff43709f51890076c56157
> 
> 

Thanks for your review! V2 sent.

Best,
Peiyang He

