Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CC47CC80
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628722; cv=none; b=Bk3n57yU7S5wgaMjObEAaCfAc6OQOPbfhyI7lx8gxN1KgqP7rhFLAWv3ZAnQiqgnU8Bhxhrfxa60FYJL1lzHeU4D2nr94dYXg5gGmBRIc/VtsPwKVhIIdLQpab3XI+2aA/wWtb1MMmUBMh6R1f3bfPdW55DTYe8vXxuyoxadVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628722; c=relaxed/simple;
	bh=NBWxDMgX1ntQ8itk3D8CiEXlI/bvH+OxmmfTTWKn8Mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=osiMeip7nmot0E0+g+wLNmCi6Su/eREs6c7GimLjHKQvlxptObErr5mGxFmmbk7vOivwQTj6AtEwTinpdML4UwGFJGs4Ft3byn9OBFkCVxktC9haWs4LexM5IfRtNNxUn9+0Jpm8623nOKLwvoOxPt6wJ4zdsl6PSzq0XUhKgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bq2Pb4MJ; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bq2Pb4MJ"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484f26852dso2254572b3a.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786628720; x=1787233520; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fl6HuvcqJhrZa9ThhaR07J0ykt0HktDxO4pMG4WTz+A=;
        b=Bq2Pb4MJUuc/f6ON76Sk+UykEDGCaxmAs6yMz/X5aY1WcU43HNj6iJEgdo4IqbM+QK
         EK9XG5tP2wcaP+xRALKpqq4NeoeiQR6j5r1cf4aZkUREvGFrxjVzL4BEDq72/pnO31B6
         WukFMckau5mS7DiSWWzld6+05Szc4MXAl4WvUmtfX8CCBga+sctMK4X2bYA6euLYm8BX
         nyWNCUTQtV1MWxySfEs3OAPMqcrX+Sx1wIaNFbOKw2e1ta/F3LGOn540qWd9uJT3cLfu
         TgeyBe+LeFcC096Pqi1s1vh4aQwGRbOT0Af7vcnUUzt05OViA0hLF+jklualVnKpMp6U
         VxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628720; x=1787233520;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fl6HuvcqJhrZa9ThhaR07J0ykt0HktDxO4pMG4WTz+A=;
        b=tW7/FWh1QpHnlMhDQozaowMxhyG9eWd87OjyUUVXIzPp2+noVEZ8/hmbNMwVb+o6LE
         BkSOHx+9CRtCMtqf/AgFuzza71PeAUuOtz9cG4rEREPyiy6Gxxa0pKT/oLnbFzS6/vG5
         5HMRVNvkta1AN7g5mXMnSDmlO7Kr7iDwB2BuHnm+kQFEHS7WUyuA5HqYgpPXwM0xM80L
         LjjFJORmrbAibRi9+tvgzIWyALKbX7UHCzE1VPV9BNA4Xa4+3WA9eEToEt8FbRZ2yvNx
         yPZ8/qCdOJs9jeTrR4XqB7tUR+p/CLVbfep/7uPL7fw0Ks7DrtUNvsrYB3qy9JQnxYIj
         RhbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rps6fWX02i6lmrsniq+WCC/Jh1Zf5VVnpSQEyfHos54yjKlPjGFFQ2Li9KdNGU0kXjD11tSkVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRe9LMm+UoJeFTQD8detN0iAlaesbHAXuqRWJcbjcLrMH8N8m
	afodq1+ngS6Vmfx8TamfmhSdRLWahLVmaJEB5ub5XX1nWXas/1mgAvx4TrO/JeVvsBSy1lcq1zX
	gzO4GlQ==
X-Received: from pfblb8.prod.google.com ([2002:a05:6a00:4f08:b0:845:4da8:56a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c8a:b0:848:8445:6956
 with SMTP id d2e1a72fcca58-84fc6e03a04mr6167423b3a.18.1786628720300; Thu, 13
 Aug 2026 06:45:20 -0700 (PDT)
Date: Thu, 13 Aug 2026 06:45:18 -0700
In-Reply-To: <CALz4YMQa4h0oHxrpsiFsPd2qWZO1Q-pE2mbDwvT2wV1b+ukZdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813043932.3214460-1-rkskek9254@gmail.com>
 <20260813045727.903981F000E9@smtp.kernel.org> <CALz4YMQa4h0oHxrpsiFsPd2qWZO1Q-pE2mbDwvT2wV1b+ukZdg@mail.gmail.com>
Message-ID: <an3Kbl3zTaOLmaa4@google.com>
Subject: Re: [PATCH] KVM: nVMX: Re-arm the vmcs12 pages request if mapping the
 pages fails
From: Sean Christopherson <seanjc@google.com>
To: Jinwoo Lee <rkskek9254@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 13, 2026, Jinwoo Lee wrote:
> However, I do not currently see evidence that the SVM failures have the
> same unpinned-HPA/UAF mechanism as the nVMX APIC-backed VMCS02 fields.

Eh, doesn't really matter.  It's still ugly/flawed code that we should fix,
especially since fixing this in a common location should be a net reduction in
code.

> In particular, nested_vmcb02_prepare_control() initially copies
> vmcb01's KVM-owned MSRPM address into vmcb02, and
> nested_svm_merge_msrpm() switches vmcb02 to the KVM-owned merged MSRPM
> only after the merge completes successfully.  Losing the request after
> a failed merge can therefore allow L2 to run without L1's complete MSR
> intercept state, but it does not appear to leave hardware pointing at an
> unpinned guest page.  I will describe and test the SVM impact separately
> instead of treating it as the same UAF without supporting evidence.
> 
> > Does this allow L2 to resume with unpinned HPAs and lead to a
> > use-after-free?
> 
> Not uniformly across these paths.  The unpinned-HPA mechanism is the
> concern for the nVMX VMCS02 address fields described in the patch, but I
> have not yet reproduced host-page reuse or an actual use-after-free end
> to end.  For eVMCS and SVM, the current evidence establishes that the
> deferred setup request can be lost; it does not yet establish the same
> unpinned-HPA mechanism.
> 
> I will also correct the commit message.  Not every failure reports
> KVM_EXIT_INTERNAL_ERROR: the load_pdptrs() failure used by my RSM
> reproducer returns with exit_reason unchanged, which is
> KVM_EXIT_UNKNOWN in the test.

Heh, which as I pointed out in my other reply, is a bug, not intentional.
