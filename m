Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=161.35.211.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270312;
	b=YpcF/AF3yoShU0N2pQEpRl6A+N2sI0xUHQZJaJ2jZn/j+3OrfQQKA2MD2U5jdvGnknMB
	 DlfD1SDrz6HAm4wuDmMtjSzU9Sgh7tyCHlda2uh6WE7gDagVUS33Wprbmm6sHmwvUT7AJ
	 K7e0+rdvEyqIN3XFz1M4hnesHjOiXRFPAUOpmwy4lxDOgGfFzQOkx6ohUMOUYiQS6+R/U
	 CmpGbKwE/CvAHd+Q8VxaXflroT0bXj5ulLAhSG/hDdx3C8zE2It6guybMC2aIiwgDxUNG
	 plX8vP7PyLse9x5QMyZWaevFzOIrDL4PvNWSdA0LbRDruvOkXh0C+QxpJcW+nGCpTVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270312;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=Ld4QZ3pQQcZaz8vukIMO+uxQ90DsPcX0V4TVlD11JwE=;
	b=FiKQVP6EFgeS9M4EdVv2/erH9RBteelQ3sdRF1tNaeCzBgdAmCyojnTFOhQ7xs1+z4dm
	 t5BZ7nmOcUEAHI+TzAobCURV9ZWnzR7gwLXeuuv6WTnETmBZkSLbe4LV0MDc2zUp4uOML
	 e06S4MkIbP5Wf28lolNg68AdF1JxExhTBT6AZF/bNB6FPXm2GpEr5lKPz/AL4N/bqSezX
	 zX7RsRhrQ5Ev8GKJbp6LLmcoGh5Tfmm7DVD9inF461FvDQVumQO1WGnHmXNsCOwGhtVUN
	 H82UKRLMsqN9ZcILcyWvSQ55LnLV5Cq7PW92i83mQeIyiuIW26+Oj8n1INpzw1opvYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mifar.in;
	spf=pass smtp.mailfrom=mifar.in;
	dkim=pass header.d=mifar.in header.i=@mifar.in header.a=rsa-sha256 header.s=mail header.b=mPwfOPuO;
	arc=none smtp.remote-ip=161.35.211.235
Received: from mifar.in (mifar.in [161.35.211.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0467606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0467606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mifar.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mifar.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mifar.in header.i=@mifar.in header.a=rsa-sha256 header.s=mail header.b=mPwfOPuO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mifar.in;
 i=@mifar.in; q=dns/txt; s=mail; t=1793270303; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to : from;
 bh=cHpyh54zy9xh+wdRjyz3Jr7nU3jQZkJ9CsSQ6jhbF3w=;
 b=mPwfOPuOZNbbuBaKJ9oZDbH/i/v3oJlA1QMQsyrR9FhtCzSgn56yqKLptec5W7Wmhuynk
 UbU1pGPVchzuaIf38vtL9pvvEldm/hPtpr09U8wT8bgjOv3QyygX71y5wBjsnXSlxZbFDSw
 w4+6gSWFPb6HCkahd5u7qS2eXBMlP9TiqUOp1Gy3RTIN4uwBKVhASZrRSubjDRA357E8tzV
 5UUPT8Irc/2w7aWRU5zdA3cKnEsPa/C1yxaRRZuP7KCumqw1kvzQnVsbJSvIUXFCs335jn3
 EbATEzAZMctWNoS1UDDOeqfDxsd9K5PKk9zuA0Yjd7yMZzxMVdyK9ncaKljA==
Received: by mifar.in (Postfix, from userid 1000)
	id 213E044917; Thu, 29 Oct 2026 10:38:23 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:38:23 +0000
From: Sami Farin <lkml20261027@mifar.in>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@kernel.org>, kvm@vger.kernel.org,
	kimjw04271234@gmail.com, stable@vger.kernel.org
Subject: Re: [REGRESSION] KVM: x86: OVMF boot hang with SMM enabled after
 commit b3e6212dea2e ("KVM: x86: Use active memslots for the per-vCPU MMIO
 cache")
Message-ID: <20261029103823.3u32wxlxdjksq6j4@m.mifar.in>
Mail-Followup-To: Sami Farin <lkml20261027@mifar.in>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@kernel.org>, kvm@vger.kernel.org,
	kimjw04271234@gmail.com, stable@vger.kernel.org
References: <2026102314-CVE-2026-99082-e5b1@gregkh>
 <20261027124140.upuow4a3kv6kssvn@m.mifar.in>
 <auIy4UZMGxLhBCAn@google.com>
 <d4214249-5ec0-4600-91be-13632b180425@redhat.com>
 <69437bf0-45fc-4701-9144-a208c12423e6@redhat.com>
 <auI4kViOXpqxT3wA@google.com>
 <6f6694db-b1aa-4d9e-be82-b0d11cd814d9@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f6694db-b1aa-4d9e-be82-b0d11cd814d9@redhat.com>

On Wed, Oct 28, 2026 at 19:42:38 +0100, Paolo Bonzini wrote:
...
>1) if this patch gives the WARN (with vanilla 6.18.58):
>
>diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
>index cfe96962a4e4..a96d839a317b 100644
>--- a/arch/x86/kvm/x86.h
>+++ b/arch/x86/kvm/x86.h
>@@ -263,6 +263,7 @@ static inline void vcpu_cache_mmio_info(struct 
>kvm_vcpu *vcpu,
> 	vcpu->arch.mmio_access = access;
> 	vcpu->arch.mmio_gfn = gfn;
> 	vcpu->arch.mmio_gen = gen;
>+	WARN_ON_ONCE((gen & 1) != kvm_arch_vcpu_memslots_id(vcpu));
> }

This did not trigger, but would it have been better to do
WARN_ON_ONCE((gen % kvm_arch_nr_memslot_as_ids(vcpu->kvm)) != kvm_arch_vcpu_memslots_id(vcpu));

Anyways, I tried this with 6.18.58, but I cannot reproduce the infinite loop anymore!
I have Intel Core i5-13600K, qemu-11.1.2.

Please disregard and drop this patch.

After deeper tracing to understand why deterministic reproduction was elusive,
I looked into how memslot generations are initialized and incremented in
virt/kvm/kvm_main.c:1667-1673:

     /*
      * Generations must be unique even across address spaces. We do not need
      * a global counter for that, instead the generation space is evenly split
      * across address spaces. For example, with two address spaces, address
      * space 0 will use generations 0, 2, 4, ... while address space 1 will
      * use generations 1, 3, 5, ...
      */
     gen += kvm_arch_nr_memslot_as_ids(kvm);

Because KVM seeds AS 0 with 0 and AS 1 with 1, and steps each update by 2,
AS 0 generations are strictly even while AS 1 generations are strictly odd.
The generation sets are disjoint (AS0 ∩ AS1 = ∅).

Commit b3e6212dea2e ("KVM: x86: Use active memslots for the per-vCPU MMIO
cache") already fixed this completely by switching from kvm_memslots() to
kvm_vcpu_memslots(). Because the active memslots' generation already embeds
address-space parity in bit 0, an MMIO entry cached in SMM (odd generation)
can never produce a false cache hit in normal mode (even generation). Tracking
mmio_as_id separately is redundant.

The Windows 11 / OVMF boot freeze that originally motivated this was traced
separately to high-vCPU SMI rendezvous lock contention during an NVRAM write
storm on dirty boot, completely unrelated to the MMIO cache.

Sorry for the noise.

Thanks,
Sami

> static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)
>
>2) if patch 1 or patch 2 separately are enough to fix the issue;
>
>If you have time, can you also check if it fails to boot even before 
>reaching Windows (you can try any Linux ISO, or even with no disk at 
>all)?  Also, just to cover all bases is your machine Intel or AMD?
>
>Thanks,
>
>Paolo
>

-- 
Do what you love because life is too short for anything else.
