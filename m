Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792633197;
	b=dSX9/Gmd3O2j9ln8q5zbYQ0Qegzwf6Wg26DCnpCn3Z0VB8tM9ts+pQ6I0KM29RMBXBKR
	 9tKTjNDgg8I9ej+GNDYp7IpBVK787ZeRNbQhHCRnuq4Csyzmh4rIOTZJlo0X1kV2xcAes
	 kO0xQUUjn9J9u9OzcSSbiHSm/w+VfyLywIML4J6PI1X6He0ngG8xWX4P9/FGB4jWUVtS4
	 vc0SCyGbGbEaqxd8HlexreOIelYaekdCwxVAz1WNewJoDlanqteu0u1y84dJ5AFwq2HMW
	 S4u3AjjBYZZyY3gi8VBn6uTMRbyi7c7pai5ay8iggHNIGP4Mb+zDthpJNSefFf4YowA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792633197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pU6HCUeasNeZxwFvWCvMlbhRm1s4JLr9LlJFdndWCDw=;
	b=0CxmQx5hAX8K0+aD8viz+ogc5yC86joX3XcVGpfUUAHduEUkZJ7+P0+Ht+1LJQUpyZVs
	 Kq+5zeafcat1siWkkXc8tfywN+QvwLquVLsETB2mxNkP1RENBk6sCasmZ+wwdy/mI4rfY
	 eaRHVBe3WKidNWmfudk1+0wDyjDqwdsRlrg9DKu1iSw/K7ettyIRFdZbinzQdKGXwFGpN
	 mLiph/jWAWnyTnPqg9d/2flpSnHcwh8y5Ds0oUtiFIf4V/7kK6u5OihmlQbFMdH0xiX4H
	 mpqCV8R7dxH9ZmfAtkuXdcRvbBBFzMFXriP622wjJX1SiFrv27iskt7gh4OwGgFO3qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ROx4zo2c;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43BC606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C43BC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ROx4zo2c
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd67466211bso831397a12.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792633196; x=1793237996; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pU6HCUeasNeZxwFvWCvMlbhRm1s4JLr9LlJFdndWCDw=;
        b=ROx4zo2caC8jhYLQWYiGzG0vjjiQhe2abeMo8QZ/Fkvl8GPMHbR6ZN4jxpLehjg2bW
         FFqe0Jal/RXO2HeujOLr83LlnEY9QDCKkGzuQzLSP3bt4IwfOhCTMKJPE2rPubBUEpe2
         RitHSK8flvO8yzF4HJZw2zmhhIom9eRQL7ofxNtROHVr/LyZeb3dfCa3sd2GvkyxH3g/
         mFvLoWJCEpXxF+yEqAoz5QfI3F1OENuqjSuUFeoaNpaibvaZ9Q1mfnJPi7gRWUEDis8Y
         njsr4XcAkFTYuD7jFayD8EOionLyx8TOunTC1uFitHca+dukewMdOiOUfzL4ruZU0Eoy
         fI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792633196; x=1793237996;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pU6HCUeasNeZxwFvWCvMlbhRm1s4JLr9LlJFdndWCDw=;
        b=JPZ0hKCfWAtd8+/U/gAPQmVcXN89MCE5qRWgxgAGqmXE2S1tcJLwIrwUl8vLY9Xe1W
         l6fm/i00nel2q+XGLIKbJtOt8GuIYCTIV8In2EjRf8usJKOpRuPVFIlpEYxN1kJtjbWl
         xJLOWCscmx7DuQ4cr6ITYlw0DuCpgg1qaxyypWCAXrbX/HsAbHi6ZaYi18XmkWsJnCrm
         NdWxyOjtc15J/zw8kXjgZu724yhRk75E7LxqCra3WSKZ8qsMJOC0s6ZXTRnd9YwCf3no
         KPYPB2Q1XYgs645O53qWK9SHBu+J6ZdQPy/LXPD1+cDR5JJuTTsmjQIcH/Ig5K9RePzy
         D8VA==
X-Gm-Message-State: AFq9FYKIrz31sslgHCG4Nndv7ouuAaAkxIPd1lIkZ0ZZ0G/IdX4MLNoF
	DvakzPhoqJVS0loO5bJzD2Qn1JkY2FORP23qxTjGQgWcHNuyR/M5P6H17X6+et5ae5saSD/qF2s
	oPPVqgw==
X-Received: from pjhx2.prod.google.com ([2002:a17:90a:5302:b0:3a8:2da0:ee51])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55c6:b0:3a8:86b7:ad95
 with SMTP id 98e67ed59e1d1-3ad86d6be66mr3174718a91.60.1792633195910; Wed, 21
 Oct 2026 18:39:55 -0700 (PDT)
Date: Wed, 21 Oct 2026 18:39:55 -0700
In-Reply-To: <20261021154742.366022-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026102100-dominion-poser-834f@gregkh> <20261021154742.366022-1-sashal@kernel.org>
Message-ID: <atlpay_Wvu55LMge@google.com>
Subject: Re: [PATCH 6.18.y] KVM: x86/mmu: Cope with the SS bit being set in
 #NPF exit codes
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	SimonP <simonp.git@mailbox.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 21, 2026, Sasha Levin wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> [ Upstream commit e90ab3669181c6469e3647ef2b30ae408275f496 ]
> 
> When running Hyper-V from Windows 11, KVM is seeing the SS bit set
> in nested page fault error codes produced for shadowed NPT.  The AMD
> manual is unclear about when SS is set, including whether it can be set
> when SupervisorShadowStackEn (bit 6) is not set in the MISC_CTL field
> of the VMCB.
> 
> Nevertheless, the unexpected SS bit causes out of bounds accesses in
> permission_fault(), seen as either WARNs or UBSAN reports:
> 
>   kernel: UBSAN: array-index-out-of-bounds in arch/x86/kvm/mmu.h:225:27
>   kernel: index 34 is out of range for type 'u16 [16]'
> 
> (in this case, the page fault error code is 34*2=0x44, i.e. SS|U; the
> report shows SS|U|W happening as well).  Fix the handling of unknown
> error codes by dropping SS and (with a WARN) any bits not among those
> that permission_fault() expects to receive.
> 
> At the same time, given the uncertainty about when hardware sets SS,
> follow the processor's behavior when constructing the fault's error
> code, and preserve the SS bit as passed to FNAME(walk_addr_generic).
> While the behavior is surprising, there's a possibility that Hyper-V
> expects it (Hyper-V does not even enable CET unless it finds MBEC/GMET!),
> so retain the information when reflecting the fault to L1 instead of
> unconditionally discarding it.
> 
> Bisection shows that this started happening with commit 687ee95c1b6d ("KVM:
> nSVM: enable GMET for guests"), even though SHSTK was available to guests
> since Linux 6.18.  However, this is not because bit 1 of MISC_CTL (GMET)
> somehow enables reporting the SS bit; rather, it's simply that Hyper-V
> never uses CET unless GMET is also present.  The WARN is reproducible
> even with gmet=0, with some hacking of kvm-unit-tests's cet.c testcase
> to ensure that the first access to the shadow stack triggers a page fault.
> 
> Reported-by: SimonP <simonp.git@mailbox.org>
> Fixes: 8db428fd5229 ("KVM: SVM: Enable shadow stack virtualization for SVM")
> Cc: stable@vger.kernel.org
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Closes: https://lore.kernel.org/all/asUqYEisPp9MJ8mQ@rika.bernkas.tel
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [ sashal: Adapted permission checks to use mmu->permissions and mmu->pkru_mask instead of the newer page-walk structures. ]

I'm impressed you got the comment, I don't think I would have noticed.

Acked-by: Sean Christopherson <seanjc@google.com>
