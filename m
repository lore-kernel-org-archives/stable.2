Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.88
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331147;
	b=vFSX1/1mkakEgNlhpgq9RyLiCWmFz1q1acC+rhoVb3dDYR6RKM/qmAMhcOeFNtfBlqss
	 nZvzKE3uL7LCtjelUvd5VM2WH5AAEL7qxDkOThoiB2qru/hKfK9nf0xCiKbpL8xQMq6/R
	 tPvbZMTABLUlkX8dYdaKojOrbx4cigcuDNCfsErv2nCbYBsuqE/5p5PJlp2BuXhsCGElr
	 ZVraVj4ZrtjScmL3u+LamwTPIjOMk8PLsxrYVHp1a/sTonWJ49JhK7xw/5kmLop/b8w9u
	 +2jFqv8fOZpZaYA/ESEcjwzqoPSXoLk2HCgyfLXBiv6Yd/j2wF7QUCWc6w4sjk8p1HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331147;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=V7fyh20lQdCfEvkMlKmFXdlszEDXLNAOR5UNt1WFBvY=;
	b=qtk+CYmKy39VUZj/UZ49uOaL3KYattjYIm4vS7kl7JOS5UBTZRs7d5egrSYU0LE+pJLY
	 VOkFNWknPRTf5ddouPZDklv6eOwgol7GEZGKAW7b14BV8rhG1yDyLGesAUYizR6MUAYdQ
	 zvQDBAZGutCk4Vp6Cw0DfM4wEjgUu5l7eN4NNHjIK9AR6vbljC31UH3XVJU2HX4koRsi/
	 1OnBNUzh8d3Y+CNpQ62+KQgpjbE7hPOMTcF+UXGDJF07M6ugeGFgMRRZ23G5z6Mj7K/Qk
	 TsS/pD6c1xpOEXMmWHCbGox/f5jdvGlE/A5tkaTxptBNa0kAcJbJgdJUvFaIlSOCWnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nqNAPJyr;
	arc=none smtp.remote-ip=95.215.58.88
Received: from mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A967606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A967606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nqNAPJyr
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5N+pLaOxaXEBjI3kYto3LAKJTxf1OYPE2hTSsrnSYYI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794331144; v=1; x=1794935944;
 b=nqNAPJyrr0Ds9wQm2r4y6Z8BxTtSGQFm/wTwnfz59I7GNjjdKAldmTKk3Hb/U/2crh7A+SCq
 AE8/Uy/OofTS0+vQVf/6v2MaCWNjPorE9j2INEc9mu40KDkVMLrmanTX7MOIWKzoaXay7oO9v0V
 2fwPBb5zw3yYHe9kJc/Nj1xw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e45fe2ec6f6926a9;
	Tue, 10 Nov 2026 17:19:04 +0000
X-Mizu-Trace-ID: e45fe2ec6f6926a9
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be58ad9600so9174e87.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:18:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHkQp7WuqtSRCLjhiaLYNgj2nhOd30fkkeic6YIsecLLUkdqsOHLtr+Nx3XeETRnwHcHn83SRA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/P1H+vHEHon59jQ7eH+VgTqBi0Vfdnr4nC/+27kCNU3V1ONY63
	LPSjjyaEjJYWqtijAE7WFweL0haS4g5qyWSfdVzAOV/xokeGff43oqnfG0C36LSEsJPcW/PiXU4
	/SdLCp/NjUFvOa+DL4c4i/jnSeN4DpgB+6AcRQlZW
X-Received: by 2002:a05:6512:1153:b0:5c1:5361:4aae with SMTP id
 2adb3069b0e04-5c157dccb40mr145514e87.11.1794331138677; Tue, 10 Nov 2026
 09:18:58 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-2-fuad.tabba@linux.dev> <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
In-Reply-To: <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 10 Nov 2026 17:18:22 +0000
X-Gmail-Original-Message-ID: <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
X-Gm-Features: AclHuK8XEMs-LG2DuXG_orFbD_2iTQdN4-tg95UYPdRQQh0AwcU2lWY30uJCy0M
Message-ID: <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean,

On Tue, 10 Nov 2026 15:48:37 +0000, Sean Christopherson
<seanjc@google.com> wrote:
> On Tue, Nov 10, 2026, Fuad Tabba wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
[...]
> > @@ -4461,6 +4461,12 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
> >                          break;
> >                  }
> >
> > +                /* Like KVM_RUN: only the iteration crossing the soft limit uses the reserve. */
>
> Please don't include AI comments verbatim.

The series is LLM-assisted, but the comment was actually me.

> > +                if (vcpu->kvm->dirty_ring_size && kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
>
> Eh, I vote to just use kvm_dirty_ring_check_request(), I don't see any harm in
> clobbering vcpu->run->exit_reason.

Will do.

> Side topic, kvm_dirty_ring_check_request() is rather confusing (clears and then
> re-sets the requests).  AFAICT, it can be this instead:
>
>         lockdep_assert_held(vcpu->mutex);
>
>         /*
>          * The vCPU isn't runnable when the dirty ring becomes soft full.  Keep
>          * the requests set until the dirty pages are harvested and the dirty
>          * ring is reset by userspace.  Note, checking if the ring is soft-full
>          * can get a false positive, but not a false negative, because only the
>          * vCPU can add entries to the ring, and its mutex is held.
>          */
>         if (kvm_test_request(KVM_REQ_DIRTY_RING_SOFT_FULL, vcpu) &&
>             kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
>                 vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
>                 trace_kvm_dirty_ring_exit(vcpu);
>                 return true;
>         }
>
>         kvm_clear_request(KVM_REQ_DIRTY_RING_SOFT_FULL, vcpu);
>         return false;

I'll send it as its own patch.

Cheers,
/fuad
