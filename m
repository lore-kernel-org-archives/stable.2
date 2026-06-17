Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E93090C2
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701389; cv=none; b=uHyZi5Q4oR0CxmJ2TViN5VBaQbhNWkqkGUlcnuNQiP/gElTrlSTfc3ITxm6oQ7er9qVafR88Gd5Iya7Eo0jatE5rlPkicRfB9uOaljcsj+0UvNWoAW3CbGDwjUQ/29b5fJEOz7cPpXpkKExn1FV1q96V/As5ZUxNT9uku4WHpqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701389; c=relaxed/simple;
	bh=Jgplr6cJMoMN6z/aXhWQHWzsS0EgW53NNDnD4vyPhZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uGQebemSUtsXQLJz0ZoTBOZX+4qxFVJ3rQ3HH8I6qmYEzrh6VtXyvrIbPeV/3xf2CEx42Co01sqgBh+JyBUHf5sZgOvMVV4LDL5MXP9MwFrqdczjdnzk0BQ3WasUpVILBQm2xjUTswVQfKyTcPeMNuQEY/MoyunsgIweuSXJaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyVgetfi; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyVgetfi"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2c665easo5379990a12.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781701387; x=1782306187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EM28efTr5yjuE0SO3xRGbNYRHe4cnOYh7jH86+doO9k=;
        b=nyVgetfiil/tWAnxYrLZR3VqdHHcFYIRSi/dKFWgFMGeAwx0TVRN1K2e6nvwQPlkSW
         mTQllKK1Vg7fst9s/FuAA5sgQ7o9RpUJaKQUQlE2mVB9v7/c+g7LbNIru6xM/c39WxiP
         aqYhyLOSWDOISOnFCGHmsqyhkxX63JQNjepcansWzC7Cq/YUFcVG618CothgDS/qCbTr
         N7+OUBiLxTiBRb+NQkXXC01Gcuzs3yORhvWc7YMptwU40BjK/fkWo1X6UAxcrCp3O49X
         A2O+g+vvjrfCO+p9h/2ses3j3wXHqVEA1MPr8yMX3CpiD2yJtVPHjNFtwu227Wr461D0
         MWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781701387; x=1782306187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EM28efTr5yjuE0SO3xRGbNYRHe4cnOYh7jH86+doO9k=;
        b=Rfe0u+6sDwfyF54dmrIJeQsff+UEKIMTaa8X+yqDqx1fyoaxBrS4v6oI9I1DGxFEHB
         Q1Nn88WAC6Pg/gsPT6t7+1RNs4x3c3rCo7pv5a7sSQRtkqiol55C38wAH5PeFUFp4o88
         gdfHlSAtyX6a5hfgaWcU/R6nSYt8GLX089d608H78FVsL9pZg8aKXnIoOS8reNt+W9Gg
         jkE2wSr8xpLDpnYOy1LLu2Plq/YsaYXmoXasuPp2sAkPVMleCoUG+Fvhms5wAE+KegvW
         irXlstTR3K0xjPd75MxdjvXoVA4jvxvFskqXqbIVgxWvGOBQMomg4TLwQLSQxESP9AZQ
         U0Eg==
X-Forwarded-Encrypted: i=1; AFNElJ8wo26okUkoT6TVSDgydM/XUO6khI5O85CDLuz1/S8p7VVGAJfT4XtHGQ4fs5c4KfHb5NYgirs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+h1Iw5g8HDvvklWjqpAqlrr1yngH+HnJpgxjzrK+w+MGdjgD
	JG+9dnEvWqy9zMtT0CYIYQO4ySJcPL/mtLnIlpLn0hIgtCafQtzBEU9b5SOPc+yvqIPVreKHPSP
	+AjR2lg==
X-Received: from pgdg15.prod.google.com ([2002:a05:6a02:51cf:b0:c82:2bb1:fdb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748f:b0:3b2:b1ed:d1df
 with SMTP id adf61e73a8af0-3b8b72c6650mr4040175637.29.1781701387134; Wed, 17
 Jun 2026 06:03:07 -0700 (PDT)
Date: Wed, 17 Jun 2026 06:03:06 -0700
In-Reply-To: <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616214652.2157032-1-yosry@kernel.org> <20260616214652.2157032-2-yosry@kernel.org>
 <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
Message-ID: <ajKbCii_1LpyQKjJ@google.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "yosry@kernel.org" <yosry@kernel.org>, "jmattson@google.com" <jmattson@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 17, 2026, Kai Huang wrote:
> On Tue, 2026-06-16 at 21:46 +0000, Yosry Ahmed wrote:
> > Make sure vpid02 is always flushed on first use by setting last_vpid=0
> > when allocating vpid02.  nested_vmx_transition_tlb_flush() will always
> > detect a VPID change on first VM-Enter after VMXON, because VPID=0 in
> > vmcb12 is not allowed if L1 enables VPID.
> 
> vmcs12 :-)
> 
> > 
> > This avoids using stale TLB entries from a previous lifetime of the
> > VPID, that might have been associated with a different vCPU (or a
> > completely different VM).
> > 
> > Note that last_vpid is already being initialized as 0 when the vCPU is
> > created, but it is not reset when vpid02 is freed on VMXOFF. Hence, the
> > problem can only occur if L1 does VMXOFF -> VMXON, runs an L2, and KVM
> > happens to reuse a VPID that has TLB entries on the physical CPU.
> 
> Not sure whether it's better to set it to 0 in free_nested(), which also resets
> some other nested fields to clean slate AFAICT?

It needs to be set on first use, for the same reason that kvm_mmu_load() flushes
the root:

	/*
	 * Flush any TLB entries for the new root, the provenance of the root
	 * is unknown.  Even if KVM ensures there are no stale TLB entries
	 * for a freed root, in theory another hypervisor could have left
	 * stale entries.  Flushing on alloc also allows KVM to skip the TLB
	 * flush when freeing a root (see kvm_tdp_mmu_put_root()).
	 */
	kvm_x86_call(flush_tlb_current)(vcpu);
