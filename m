Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503484;
	b=4wPQ0Zqls5zbOdyWCDKCdR3JtwTcNsQKmZulY/k4GTTGZGA6nIgm+mMWug2Bs30gm1xD
	 J75bq8DZfEmdUrH/AI3VmgPBdXiS58zx4nHsQk4WDHhvfI2V5Su45hWGNDOp/SKYqGuIG
	 sj+tLbc8kRQICk2mUreOiG3K417t8CvmrtftDBJ1ailFf4tfO2eT3NgvRpCHOy/Fefzh4
	 Unuq0gzda/jRP8YmMCQQsVZDk3XU8cNC5yO85KTu9go5LRK6svrgI5NO7hH7CIGFlNUe0
	 m5u2yMvM4ji0Rpuz81e+VqGbzJy9bH1XU/BPhf55Qykws68GVQaFu9DL2VFz0cFNPdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=8SezjP7qMV7JA1xyNLi94WxImA0k2Vv32vond9P/7CU=;
	b=P0u7oT88AQionlNcg8kHfhSJEiPXTGfTbYtuJH62JuH9kZrza8PJeZbNsjXgmeXxizgf
	 gK1P9+ffusqL/pgZR04akH4R6Z7SWXuCUPkDf+kOhDcebx58wkszEpE9NP/IKZsQtJ+v4
	 Xb5hXBq5dvH9M1wCjaUyzusAnhBy382vT5dLlPdf5Lp4NYN32wG8uM6Iy68IBzFZerjUF
	 OeIfdBnVkx8ElVbS1ESo0/1Eux+/0tXCKSXDH7hE1ZTWzfCUUY4F3+BWTzgFSF3fnuUDq
	 KicNZj80JvvGKSMR+qhaFaVDdSOAdxYOAZejpYx+9zO3ZZId32VrNU/2L5Lhpae+u0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q+d453Jv;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD11606A33A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDD11606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q+d453Jv
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0a528ca65so5553a91.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794503483; x=1795108283; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8SezjP7qMV7JA1xyNLi94WxImA0k2Vv32vond9P/7CU=;
        b=Q+d453Jvop3A5CK9RjICQ6OG10CQhBnLexCTQJTCwPCK0/k95ls9tG0gDh/6ILseR1
         3g/lJLi4mXS733gopPoaKjaXKdMdwWJiCID8pHYvJuyMXCBsJSiqGyV/IFAsdMHDPtQW
         OomfqCFtoPhA9pJyFx9hD5wjfzz5iPcksgUASsJ9o2jJmd6j958dsC/YAopLVXf31ShA
         q79ps2d8axYXfBnT2yLvMz993A5KtipWliL0p8vq/Y/LSYVARvac0bjFS8/rMzOhAITE
         rjtYdTIZP6EEryHQV8QHJtv07t8UOSmfQkOaX/tojsk0fMyvMZEEYSxoiEZzSJDvMLDp
         CB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503483; x=1795108283;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SezjP7qMV7JA1xyNLi94WxImA0k2Vv32vond9P/7CU=;
        b=Iyo2QPPfApraaGn/aEhpNaXEuFwCc6NqO1EAb0dK/8fKRGfU4SkLZ1VScUaRtqP/Kx
         ba7hQM4soUIookeNYnhzumFlKAn603gICIyMIHCRfc9WONIivuJEEuaquhr2T4O1BekX
         e62lOXDKVs8Y46eDlnyFCw/KcIuCXLEH8WX2brodvDqWfFnHkwKLI32PlNbmFw5iKMMW
         nKbi2k9OanffLvYYYJdKlYw+O+NpIkM8QOGnMLQN7lGJhPMJhHsbvD/TvHSsptrC0blI
         q8BiQoRGyK7+FJlUT/LEnpi4XF5Wq+Q2vkLS9O1JR6AdffN+7dXM0czlucxFA+P9B/Yg
         F5gw==
X-Gm-Message-State: APuU4Z93qaiFrhvxizH1WayEr7ztQJU2RjLZrhtUJdBh08MtXG8yAzvN
	ZeJGp6JNkDPmGIAvWSITVwS8mtGWzuaTm8u8Sx0Q0ieQNVj0brreW3b9/d4MR63ZEUkiVRbFOzk
	sBpqYHw==
X-Received: from pgbm19-n1.prod.google.com ([2002:a05:6a02:6193:10b0:cd8:b29d:d82a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:580f:b0:3ac:80dc:f40c
 with SMTP id 98e67ed59e1d1-3b182ec1d23mr6024916a91.14.1794503482718; Thu, 12
 Nov 2026 09:11:22 -0800 (PST)
Date: Thu, 12 Nov 2026 09:11:21 -0800
In-Reply-To: <20261111170439.3395604-2-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109200129-failed-7.3-053621535f01@kernel.org>
 <20261111170439.3395604-1-sashal@kernel.org> <20261111170439.3395604-2-sashal@kernel.org>
Message-ID: <avXzOcWZAbejU2In@google.com>
Subject: Re: [PATCH 7.3.y 2/2] KVM: nSVM: Check validity of vmcs01 save area
 copied from SMRAM on RSM
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Bill Wendling <morbo@google.com>, 
	Stefan Teodorescu <fane@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 11, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 053621535f014085c935879582dd3b65964a0dce ]
> 
> When doing RSM to L2, validate L1's state after copying it back into vmcb01
> from SMRAM, as SMRAM is carved out of guest memory, i.e. is writable by the
> guest.  Failure to validate L1's state is especially problematic for inputs
> to MMU context, as KVM can end up with impossible CR4 vs. EFER state.  E.g.
> without the recent hardening FNAME(walk_addr_generic), a guest can trigger:
> 
>   ------------[ cut here ]------------
>   UBSAN: array-index-out-of-bounds in arch/x86/kvm/mmu/paging_tmpl.h:435:15
>   index 3 is out of range for type 'u32 [2]'
>   CPU: 3 UID: 0 PID: 92 Comm: CPU 1/KVM Not tainted 7.3.0-rc1 #2 PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5f/0x90
>    dump_stack+0x10/0x18
>    ubsan_epilogue+0x9/0x39
>    __ubsan_handle_out_of_bounds.cold+0x50/0x55
>    paging32_walk_addr_generic+0x889/0x970
>    paging32_page_fault+0x79/0xa60
>    kvm_mmu_do_page_fault+0x125/0x270
>    kvm_mmu_page_fault+0x88/0x7b0
>    npf_interception+0xc8/0x220 [kvm_amd]
>    svm_invoke_exit_handler+0x16d/0x1d0 [kvm_amd]
>    svm_handle_exit+0xb7/0x160 [kvm_amd]
>    vcpu_enter_guest+0x428/0x16a0
>    kvm_arch_vcpu_ioctl_run+0x479/0x920
>    kvm_vcpu_ioctl+0x316/0xb00
>    __x64_sys_ioctl+0xa3/0x100
>    x64_sys_call+0x281/0x23d0
>    do_syscall_64+0xba/0x550
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x79bb30deb04b
>    </TASK>
>   ---[ end trace ]---
> 
> Fixes: 37be407b2ce8 ("KVM: nSVM: Fix L1 state corruption upon return from SMM")
> Cc: stable@vger.kernel.org
> Reported-by: Bill Wendling <morbo@google.com>
> Reported-by: Stefan Teodorescu <fane@google.com>
> Tested-by: Stefan Teodorescu <fane@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20261022021046.295001-1-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
