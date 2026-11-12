Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502952;
	b=HXCAvUdUwAUA5VoJRCPf7mn1YckHF9Ie2Bkgh6r6nHh0sNWdM1TFEy3fQjxVFx4e+Zs3
	 b1LJZyPbTq5J3oGsMEEPeV8pFVqPckUScBSJEyWp3pzJwfPmL8QyW/GZlRF/+w7V10/dS
	 eqA0E9R7ZKa6yFmPrJ5A1xgiflTJ2Pd7BuspoKOS4N/9YruPHiy72GhbBb4Q6AhAW6z9h
	 oN6APbeDAkWAvT53fCy70e74YHD1t1yEcXZ3WGNUmRG1dudHe7gcg8gKgZkFmdxE4OKjW
	 a8g/pg06dA6b6HjChSpQuH62ExpFkPIUMrGcDOIq8OtnL7Z+Vx1GlTeReR9hnydjt3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=e140q58soQVFIR7wx67wIJ6hITR1M7nvq/sFQdp0L7o=;
	b=be2sL04wxpMgrnSZE+jguGn6EcfRNfhFCK/kHsy44awWbhJ5FGVCeuGUy1Gu7s9mMPzo
	 ROZayKi6biPvV/1Df0CCN5RCB2kf5ge58kJtXlmGX2MzovaOntK8X1KrXGLMZHA1/yIYc
	 +pRXRwDSRSYtgIkwxrgg+96k5/LWz6+sT/gwW9MYXTHd5DR1Edg0D3nk7Yx7RUq1IFGPL
	 RzbIiLNJ/cBCebcrdJ8Scs9hMXwOG53hJ383nwAXLZw+xDGCTj6UmSysuFN7jcx/D0hgX
	 lu7d6W7bSWabd2jzBfhBJGpV1QpxWVb/oQV+QwaH4SiF6wg1JqTejy1XrqtCbgoWUAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H+b9CbUw;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38814606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38814606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H+b9CbUw
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b18741aaf8so2490884a91.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794502951; x=1795107751; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e140q58soQVFIR7wx67wIJ6hITR1M7nvq/sFQdp0L7o=;
        b=H+b9CbUwryyuXf/mfjsvkYqPekeMTn2TFSfwdiflR5luvYx96042cTpTYF9H7RPB5i
         L+5IhaB5GQkJwDSCKr8nDp2P296b950XGNvIAdVlQjVm8CV7S8MyJualSEjcoI/wVZ7F
         9Vx63C/tAi3zJGfDWH0b+IVusToFpU1HDqEw9qB7gJPPxapMsVP/TLt+2VoYOfGYsrV4
         w6rzT8tVsSfs0t3q2oRUcMRv9ig4HZ0Oc+M6fIeoUYbrH9hOXKKSdAIidykH4cxM3w2v
         dZ4cjcnSnGNLZm+f4iYD5uVUBCp7MtDM4NDsVosj7Mnsk5cnXRwaLqftdwWKo7OJQDH5
         A09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502951; x=1795107751;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e140q58soQVFIR7wx67wIJ6hITR1M7nvq/sFQdp0L7o=;
        b=ylhIc9U8D68n5vL3PadD9bzOP6kcFP5Ih7kno2gmDSQmxh8FvdwRsnHTmdmO8u01Pm
         zIDrrXh6mp7OWa4yk3WeXwmIy8J2kdybELWePQe8dScrN2OsNAgv57PMeksFDKm3ScNT
         MoBJwwTdlopWzI0rh3cqhkEaH2p5XIQ56hav2TCcvqWMbLcw70/77LDR3LBEJdKcIWH6
         da4YNi/s6QsDtgx9oct4AfosmjT269uI+40FN17YAzmuQkiDk/O2Ks7OMjk2B6TLM95B
         3nwRlB5MTBlHWvetRUDjKngO2TffxsUHCwIhg+BQk85PhYg08yh3zWkvruHhz8j+VD3a
         J2CQ==
X-Gm-Message-State: APuU4Z93s2y2Kt2b37RZggxaq2pscjT2pAARZ77krb0fp9k4mJPvnvzX
	qxiiJhCMPpv7iTVMf46CnpyMFZYRUyE/du5/rTsZ+aX94YjQvtzavcbpOVvZ5+3tGjCPf3J7QeL
	NtaNrTw==
X-Received: from pjqm20.prod.google.com ([2002:a17:90a:ab14:b0:3b1:479f:4272])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2243:b0:3ac:4291:f569
 with SMTP id 98e67ed59e1d1-3b182df391dmr6596005a91.8.1794502951075; Thu, 12
 Nov 2026 09:02:31 -0800 (PST)
Date: Thu, 12 Nov 2026 09:02:29 -0800
In-Reply-To: <20261111193111.3654795-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109202148-failed-5.15-053621535f01@kernel.org> <20261111193111.3654795-1-sashal@kernel.org>
Message-ID: <avXxJfqVNk--aiMU@google.com>
Subject: Re: [PATCH 5.15.y] KVM: nSVM: Check validity of vmcs01 save area
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
> [ sashal: reused nested_vmcb_valid_sregs() with an is_l1 argument instead of
> adding the upstream cached-save validation helper ] 

Woof, that's ugly.  But I don't see a better option, so,

Acked-by: Sean Christopherson <seanjc@google.com>
