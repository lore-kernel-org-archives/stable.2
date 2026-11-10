Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325720;
	b=btvl6qA1z19pg/wEdJWUXpE2H2jx+NRfhCEhV9dcDM88Voe3VcFlHhkztHI18f+LO6xc
	 8NXGXW2opE7fAg7PWBvzRlhDJZFou9y4ufz7qa0U5GpUZivdogs1txRLFuhSuz2pdjjjD
	 yjka+oW5HOPOR4qenJLYQo9knsv6r5jE3KgOyYAbJ4BiCTaKI0FYtAIHlOH/qUrb4Z9x1
	 40BpBMiMv0wqXJEOg2SNer9OIlEP4DIbto38WZY8pzLv2/k9oKuwFD54rIMVbw1l+a4P2
	 kIqR6xoXVzJoz+ehQCiyajnGeif9kyZwy7dnn1uKew/SX01NfB/+fB/dabZ6VkEqD2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6krrngdHCsjiOW3bLfxtRylPnkwePlq//L1F5r6HtXs=;
	b=usTq8G+g14gnQjgXdPYFKSrmWw4V4T70XBONu7RcLJ85H38H+j4UvRZ7TNIy+AwpSLMW
	 f0KtS9HYW/yAy036XbP7EaTiQ8A7ENR0j9t3mYuNz+fNTFSLB5B59r+TYVSNf+6eCWShl
	 d8vskkkEB7blhAf6gQf9FuHg8TeCQ/TtIqPDsKUqEZVFuI8LGq0uqcg7j+eL9LBGccCAI
	 yMsPG8sNqDrDI4KkbS2N2vuCilD755qbrlvwaugpW3MDGD1E51LcQXMdlrQw0N2bJXMQv
	 fHjRAIeQTZZIhtphg3JHGxIxy3EdmL2qGOtMk4ZBHmqEgRQvqwDxSidpImusXGRvjqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yky04A3m;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E260A2605
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 433E260A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yky04A3m
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eaae8d29e0so29764885ad.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794325719; x=1794930519; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6krrngdHCsjiOW3bLfxtRylPnkwePlq//L1F5r6HtXs=;
        b=Yky04A3mA+11IwDoahtA1u8/FozpA/pdBIB4fD9gb0UmTVifEKlT3Rp64lp1IqJ817
         tb6XsukxZw2/1+130CHFVNOLKOV1B8zCZV1WPXy6rJvLYo/zAFSrofMg1jBKc2MQePIj
         wQcgQvcltDi4D2kpLXSJlKK1Ac4jeCsAKhjBQe1vnZ+4NgWUnyi0zmS4tZSrBhVsrMTY
         gucEwhnU+5P2/y+ebovH0/8DCp6Sin7c64argbJtEGLokTzg80WdHQ3tSV8MnhHpYPGa
         JrTVs4Ikz3SNqODI7s8/EcS9BNqbaROVU39V5M+HcZoXhUFcSuB3wOD/z5CBqIqnemQQ
         U5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325719; x=1794930519;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6krrngdHCsjiOW3bLfxtRylPnkwePlq//L1F5r6HtXs=;
        b=GWxbhn1XtnHdlUkXThbZIDuW+hKz7/4usfETHWnllt/DsRNbTG3oImH6Xtu3izkZd7
         Ss9BL9i7Fc7hphYAhAE7e1j8vSToEQpqI9HposIpI+6Ppu9hOb3eP1NBVWovtt2H5sHN
         ZrHyS7qr6bM5ymbhyRQBLtXdG23ZN/DMuAsSi8W2AgO31+ZJ8yG3uOqfaFcSrWDiyNtN
         MWJGdjSU2q7vGHAIFZIoD1pMP8hj7iG9lLoZK1Oy9AtlLaNEQiLH8Bwfcf73+gW3p/q5
         pkj87wffvjlN7HiKWQAatyeP43sadE7j5Mn5oFuHA0Gt46ct7yCvpvO2CSWvET+6YpMK
         DA1A==
X-Forwarded-Encrypted: i=1; AL+hErHjsVJY/E4d8dRWBz8lCrZXAt0M2w8qfNRPkLBJXxA9lTpPVEvX9wS2eQNjM3GLZsu9zqF9Z5I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cXaxweQYONam4B3NO+Cz/k9p4EtsJ7pVE1up2+hPoh6LPrqdb
	1LK7cnB5BjDj7Tle4eL2XzqSAtoo9IBM8IpCRpbxXxmDoQhGWyXNfH/r6sxFaw/wGue3czcQgMQ
	ViHaD+g==
X-Received: from plzu6.prod.google.com ([2002:a17:902:82c6:b0:2eb:809:b8ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d547:b0:2ed:218:6043
 with SMTP id d9443c01a7336-2edb93052e6mr23931165ad.59.1794325718280; Tue, 10
 Nov 2026 07:48:38 -0800 (PST)
Date: Tue, 10 Nov 2026 07:48:37 -0800
In-Reply-To: <20261110110724.3614412-2-fuad.tabba@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev> <20261110110724.3614412-2-fuad.tabba@linux.dev>
Message-ID: <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 10, 2026, Fuad Tabba wrote:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f1407..da1b76ceb65e3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4461,6 +4461,12 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>  			break;
>  		}
>  
> +		/* Like KVM_RUN: only the iteration crossing the soft limit uses the reserve. */

Please don't include AI comments verbatim.

> +		if (vcpu->kvm->dirty_ring_size && kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {

Eh, I vote to just use kvm_dirty_ring_check_request(), I don't see any harm in
clobbering vcpu->run->exit_reason.

Side topic, kvm_dirty_ring_check_request() is rather confusing (clears and then
re-sets the requests).  AFAICT, it can be this instead:

	lockdep_assert_held(vcpu->mutex);

	/*
	 * The vCPU isn't runnable when the dirty ring becomes soft full.  Keep
	 * the requests set until the dirty pages are harvested and the dirty
	 * ring is reset by userspace.  Note, checking if the ring is soft-full
	 * can get a false positive, but not a false negative, because only the
	 * vCPU can add entries to the ring, and its mutex is held.
	 */
	if (kvm_test_request(KVM_REQ_DIRTY_RING_SOFT_FULL, vcpu) &&
	    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
		vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
		trace_kvm_dirty_ring_exit(vcpu);
		return true;
	}

	kvm_clear_request(KVM_REQ_DIRTY_RING_SOFT_FULL, vcpu);
	return false;

> +			r = -ENOSPC;
> +			break;
> +		}
> +
>  		r = kvm_arch_vcpu_pre_fault_memory(vcpu, range);
>  		if (WARN_ON_ONCE(r == 0 || r == -EIO))
>  			break;
> -- 
> 2.47.3
> 
