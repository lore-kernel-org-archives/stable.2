Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047945;
	b=n1drhmrfZWhG4Si6tr3f4xqXODfmtTAwS+7mNqNdfL8iTKCH/jJChcKu5lqQH4OTxMpZ
	 u+sS6DPF0NmzlheTfds9Tatb9VnrFTX5gfG94lmtpwQbPk25dFElhQtBWujc4UyP5fxFg
	 rlgv42A/EHBQDFaeJvYN4uWL4AXAytygoU9Lo6kMPUIvfi6MpXcJK4JuX5XEmVM4aBb4G
	 PBFcMjOXmzrmwlj3NHu9JDEl2b6YlI4XYTYc63eshGAh0pdcJCPCpOzFVetvxphqEr0mO
	 mZlJfwrLcTF9mm0Qpn7CznpkeIZCf6o+c9ytLl1a34Sxa8Gtjf1hzMYtZ3qAWrlVkHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=yb3RT/dSHycHHUvHrQYfX0MzmZ7Zlc0xT6PVwRVG2IA=;
	b=itVLd+oT6WRDtKBy21cgFbvqQWc5jQ9xJu31K5UsFQUo3ix5L2PBBsvoLd5M02pozKcD
	 Hvuev4rPvXYnLlBF1lZqOTi184GCt+J2BRF/vD8kjpiRGGevBOY+13HqWRJRRzJBgTTKZ
	 y9eMebgv3pOR3vzaYqOAb4wWqwEjeXz4PGlwfZyScvEHtCj2LqmnK34H1nCHyEEby6QCl
	 W55haJvuMTSsYmFmdM8G+uGxWVtFVL1c/G8aAKPBrafK23u0HWINEYzs23MLnba0mXhIV
	 ZYco4aI6jkpnc7HZod/gwntEdOoJC1Dol4EYgajBdyINMd5rQbKIR9lyf6c7vdc/l4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VUzzRT1P;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526A606A31C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3526A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VUzzRT1P
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-567e742f481so1012601b6e.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795047944; x=1795652744; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yb3RT/dSHycHHUvHrQYfX0MzmZ7Zlc0xT6PVwRVG2IA=;
        b=VUzzRT1PmPN3kH/c5HD5qxg23YbKceVpVl7CPJfi+KdLeS+giLCoHmbo8TeKtLKScO
         4M+h/q27Mc1BJm+qXrZzLChZ7Jay16UY0fuOIPg0LSSY01/l6RPxGRyiO5Cf022TUr4f
         NqNygd6qVz76Q1ennc949Z/jfRVOM+uQc4kDStu6gb1KA1ibwjKEf5D6Xr9kxDP9hqM+
         84jm9VV38N9kQ5om6sreRHX4BiEQfYGGyUW8pxu/mj57il7NS2aTWOHjJo9YIv4yLiLi
         8ruKnViQKijKVdHUpz2Wp/g7k5CYbNIwKI93rKmrhMayqMFvwaNsAnxv9xRwBunbZQFZ
         aNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047944; x=1795652744;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yb3RT/dSHycHHUvHrQYfX0MzmZ7Zlc0xT6PVwRVG2IA=;
        b=bRceC9rIWYMJXHRKu/JhFYw/8YEVH0KkBss2gGdOyIZemwTg8DZ3ecXkBqd5XzgtUg
         cP1X/ftrYHBCcT5E7Bf6Uhv2Dmpb4R+WJl4CLrA0PV9W/xJG1lmrueQwShC0h+UrgAT3
         hHjq84+6L0YN3lnuqvacsCvXoEoMinYhwgiH5enigNpYB04th4IdM1LWjcCGvO4kFYJe
         pEamaPnTPByB9ENeZDF07XAoCTaSrsgeJ4SMO4TWIrlqdJPnhFIREYLjHBjAqMhr6yHw
         dxNAGek3YpB6eFx2KRJuBF3BRop75RqiBRjF/eoBn7jDbdbTqYQwsZOVJlUNmDiB6qek
         bc6A==
X-Forwarded-Encrypted: i=1; AL+hErG2pQ82YgEoGG5NYnQcctj7bKR3gkYvOHCp2eklxhEOINh2O0aE5v0SwVuwvIE0dzkzW/UtIzw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rGNa4viJnWlbv0qIxjuMODEbQc7za5XTfJdRDGjX/0CnvcU8d
	fdSJkh2WNc/RUlutHwlaHqe1Qh/Lc/FBa5oCK2PxjqMDrPEpGcbR1aXSDcbZwAcCvcNFdI8FwVa
	ttP4N+A==
X-Received: from ioru16.prod.google.com ([2002:a5d:83d0:0:b0:9e2:9e82:a2e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:250c:b0:53a:8c5:d7de
 with SMTP id 5614622812f47-5773db2428bmr4568078b6e.1.1795047943693; Wed, 18
 Nov 2026 16:25:43 -0800 (PST)
Date: Wed, 18 Nov 2026 16:25:42 -0800
In-Reply-To: <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117074428.7544-1-fuad.tabba@linux.dev> <20261117074428.7544-2-fuad.tabba@linux.dev>
 <avxfgWNePsGPK9mm@gremlin> <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>
Message-ID: <av5CBjbeidUUWiLq@seanjc-mac.roam.internal>
Subject: Re: [PATCH v2 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's
 dirty ring is full
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 17, 2026, Fuad Tabba wrote:
> > But the overflow bug only applies to x86 (see below), so is this something
> > we should worry about at all?
> 
> The ring overflows on arm64 too (below). As for exit_reason, I asked
> Sean about the arm64 MMIO case on v1, and his answer was that a VMM
> that pre-faults between a KVM_EXIT_MMIO return and the next KVM_RUN
> "gets to deal with the fallout" [1]. I think the same goes for riscv's
> exits.
> 
> [...]
> > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> [...]
> > >  The dirty ring can get full.  When it happens, the KVM_RUN of the
> > > -vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL.
> > > +vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL, and
> > > +KVM_PRE_FAULT_MEMORY on the vcpu will process no more pages until the
> > > +ring has been harvested and reset.
> >
> > Maybe worth mentioning the exit_reason thing if we keep this arch-generic?
> 
> Sure, I'll document that userspace should complete a pending exit with
> KVM_RUN before it pre-faults on that vCPU.

If we're going to do a documentation update, I vote to keep it vague and scary,
otherwise readers might think the exception proves the rule.  I.e. if we say
that KVM_PRE_FAULT_MEMORY isn't supported, then userspace might think all other
ioctls are safe, which is most definitely not the case.  E.g. something like

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e95c9cda085d..45dc1e3c0b03 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6971,10 +6971,13 @@ to the byte array.

       The pending state of the operation is not preserved in state which is
       visible to userspace, thus userspace should ensure that the operation is
-      completed before performing a live migration.  Userspace can re-enter the
-      guest with an unmasked signal pending or with the immediate_exit field set
-      to complete pending operations without allowing any further instructions
-      to be executed.
+      completed before performing a live migration.  In general, userspace should
+      exercise extreme caution when invoking ioctls other than KVM_RUN prior to
+      completing the original operation.
+
+      Userspace can re-enter the guest with an unmasked signal pending or with
+      the immediate_exit field set to complete pending operations without
+      allowing any further instructions to be executed.

 ::
