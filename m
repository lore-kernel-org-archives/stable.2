Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB99371D08
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923423; cv=none; b=Vmxb/zWKm/HA3iow6l+2ZTV3LOHBO8EM+G/lLTkbPQI4Qa5g/irhf17+5bTRMLk5ZGGyoEbTwAUT/iZGuIKDcJ0vPCpLi/SMdZNNxztLN7l3RmboR3CWxfHIUNDph4D7sueLlhncSR7Ntcc4bkAbbuK1dDhxJU/EU8CuCC7U8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923423; c=relaxed/simple;
	bh=BntJeF67EJ/FhtFrjQ07iZV46hXBlWp3EEMp9VjRrfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UegSNcFOH4kasSm3DFLZLQsVq9YXWdkb+FFeauYXurgRRPuGEreMJic7qKMOGwSkCo57HLT+4NUc/Q+yUTY8WGtHsvtby637WAfTL3mnZ2VPNDKvMuegSmTLrODeZg4lrJ6/XFjbIMmhnfP30rp859ThERvZh5SG5Hr3aK7ZxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NmnMk4Mw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmnMk4Mw"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso1068757b3a.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782923422; x=1783528222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ShKiZb344TxyfswQ+jZSBX+kNOM96MzdNNYUtZBeP4E=;
        b=NmnMk4Mw/bYUzm3x5Jk5YmoAdQMAWivj+aVQAdvLFUiWmqox96KLfNTE+TlhfbAgUs
         W9BFDXiod9f5r5+FM6r97HqoBjkBOkZcaW/mwXIQRLn3Ushj5uJtuiAKdLXEsF+ry0g6
         IPsJ610UzmrtbyA1OitHBwe47jXX2zz77cu2Hpjqq1hxfVwPnMbeGbBIdJEiEOqsW5Vw
         fcdwR6DB40SqoCQf8jz/wPLppp/T+dLtp4/iLkFeFPQ07VWpatMv8QJVfDBSgA+Gsz/T
         pfzK1RYRyGiHqY1DPMcAjf3XNGdeicRqtMphYgmX3SHOrek0r20IF0U+ChmCNkynTVvd
         yODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923422; x=1783528222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShKiZb344TxyfswQ+jZSBX+kNOM96MzdNNYUtZBeP4E=;
        b=dReu8UvS2kw5O+yevBSuL6R0N4GrIyQT7d2CwDzAN9OtCvGaCNsKpwpLRsPW6JuFEY
         ncIuJTXQJZOJL4fYUXSbH86BOGwV4u3e1otp6Vg1dWvPtxxxuNGamYT+ZfNqP0MVAIAu
         Z69g/2D6NyLg9waxT2eFnxzgjKt8mHEuN2cfSah4tqqXEz3YcNPYwxGViKGj0Tz1wm3B
         B8+wZ/u5yIjo3I2f5B03WGeomXqKWtCI5CdVYi7XKVSShoGakbcQNbJnHFio1mfa2ftH
         XiwAqj0aw6aNZSdy21k3oJdx/nq21llKwiv45TCxuMBZoNocQeMBDqF0daUzLo3wvnbp
         OPew==
X-Forwarded-Encrypted: i=1; AHgh+RqJzDio92WKqEfAbBk7dFYNHJKUsKL3JwT3vo6BBCc7pTOEwxaHaa2izYqPuuAmSkvu2snf5ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxEhMC5AnjV15rNKex+hx+lQ2y5JljI8xrnx+m9aaW6dUOlRuN
	pn6sBtyweY6VYsYGe50Vp89rHm/SsYYYoUBH5yWPrmubQgDiu2jOmwica9Wt97Cr9o/3Ktb0meb
	KuqtDMg==
X-Received: from pfnn9.prod.google.com ([2002:a05:6a00:2b89:b0:847:7fb7:7370])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f95:b0:847:9745:2f91
 with SMTP id d2e1a72fcca58-847c5105275mr1361289b3a.28.1782923421185; Wed, 01
 Jul 2026 09:30:21 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:30:20 -0700
In-Reply-To: <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701144543.39582-1-pankaj.gupta@amd.com> <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
Message-ID: <akVAnGuiuJttE5-6@google.com>
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region registration
From: Sean Christopherson <seanjc@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta@amd.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org, 
	thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, David Hildenbrand (Arm) wrote:
> On 7/1/26 16:45, Pankaj Gupta wrote:
> > commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted memory regions")
> > added FOLL_LONGTERM to sev_mem_enc_register_region() so anonymous guest RAM is
> > migrated out of MIGRATE_CMA/ZONE_MOVABLE before a long term pin. This breaks
> > virtio-pmem which has file backed (MAP_SHARED) host mapping where GUP rejects
> > FOLL_WRITE | FOLL_LONGTERM since:
> > 
> > commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
> > commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").
> > 
> > Drop FOLL_LONGTERM when registering encrypted memory regions and restore
> > the previous behavior.
> 
> But that breaks the original issue of breaking ZONE_MOVABLE/CMA?

Ya.

> If it is a longterm pin, it must use FOLL_LONGTERM. :/

Heh, well, KVM showed that that's not entirely true for many years :-)

Assuming we can't solve this some other way, and that there are "real" use cases
that were broken by adding FOLL_LONGTERM, maybe this as a hack-a-fix?

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83..ea136d79c963 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2752,6 +2752,25 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 
        region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
                                       FOLL_WRITE | FOLL_LONGTERM);
+
+       /*
+        * On failure, attempt a "short"-term pin for backwards compatibility,
+        * in quotes because this isn't actually a short-term pin.  The kernel
+        * disallows long-term writable pins on file-backed memory as a partial
+        * defense against the fundamental problem that most filesystems don't
+        * play nice with kernel writes via GUP (true short-term pins are much
+        * less likely to be problematic).
+        *
+        * Unfortunately, KVM (incorrectly) used a short-term pin for years,
+        * and so can't *require* a long-term pin.  And for this use case, the
+        * potential filesystem crashes that occur with kernel writes are a
+        * non-issue, as KVM isn't using this pin to access guest memory, the
+        * pin is performed purely to prevent the memory from being migrated.
+        */
+       if (IS_ERR(region->pages))
+               region->pages = sev_pin_memory(kvm, range->addr, range->size,
+                                              &region->npages, FOLL_WRITE);
+
        if (IS_ERR(region->pages)) {
                ret = PTR_ERR(region->pages);
                goto e_free;

> I assume we fail in check_vma_flags()
> 
> 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
> 		return -EOPNOTSUPP;
> 
> IIRC, fsdax cannot tolerate unbounded pins. Is that the case we are running into?
> 
> How does vfio deal with that? (does it?)
> 
> -- 
> Cheers,
> 
> David
