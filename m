Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792633226;
	b=AloI79fWGyH1nqjtGS+Z+EWZA4TrjbYBzpiU56EihpxiXIr5bEGCp5csM1mRDA/g5s4d
	 cafAPmcNgPt4bjgUpbQr+IDtpUkmNl6cOa9FKgLXKvUE3QfxLmkxdqDG8VUhdfcSs3t3B
	 onMmwegyXOSmZOEWoF1d3mR5s7DNMREDz+SAA2VXpFxWW6lMnZNx05DUjb1fZfMHJABhS
	 7PLqjOoIx5sfa1sW6fDv+PLkIWN7oJsmIo4jvGCRrX5r9b+2rG+yyqTXfutFJRhImX0ff
	 NA5US/31aASZL5NFgOG7p8bCaRZL+OSF/0ioZ6wYVM8nFfV+/M1xgVKybm/T6L9fBRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792633226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xIixaXqRDCVWj88A1Mwb4JFHqZIY4yK5rmdHsuGHdJc=;
	b=L1t/vUkiwMUZVr5aiNtfd4OhGktW6WhBg4XkiwdKJNr1eMIGyp7Puir0CLhNIALZyaNK
	 Zn759gCcWCFj+oRSTCyEKUNjnuEHtPyGLPjDvbNHWFhxl+I7cwgaUs8c/IRB9kgAZe/1F
	 tIwATe2rqDR6lKjv0X4h7759+w5y1FheBjpIKo10TsH+lkrFdbH1exl23Vz1aIL6yi99m
	 ahh9ge+QP9B6fnTaU3OZjKIKSm9TtWIwnhVgkMqi1idSbLwnnKk03QVSu2ja09qhgvQHt
	 ygo7cWh92yJhUD8ih3PsGD3Eovy7Ztl+aztjGJy1UA0bSm6GERpAi5HVgIziwcywkSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ggZiUQtM;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3E606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E3E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ggZiUQtM
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac76132001so1059557a91.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792633225; x=1793238025; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIixaXqRDCVWj88A1Mwb4JFHqZIY4yK5rmdHsuGHdJc=;
        b=ggZiUQtMQ8dbBMEplmZ0n7/F3+lIq5NvT+fP9CxVJPMLdQCn5V3vjSvedCSe1/L8lI
         pE1rLH96krWIqoCff0w3X0vpay4fSuTEfYf5EDP14lfyXUjSNQof9LZpEq2evRqiihci
         qIjO4Ne7wBC88eqYKQSCvnZNgjnPzgxHM5nIFu3OZ6wY7vXU6kbjWwhJ8xfw4C0xNCbW
         LNuc+O98rmqvpf2NWzQVUOWty5j0eOM8qoEtrh/AYdfxDa3pXjz44tEdgfH/g+YY6cfg
         FD/3204wuW2eqY/kMUpKkH/SmxceNhE9mNFKRzqbLwHQiFG1G2peHYI48j9X181rO9mw
         10Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792633225; x=1793238025;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xIixaXqRDCVWj88A1Mwb4JFHqZIY4yK5rmdHsuGHdJc=;
        b=INJe8cX4Z1irPHUfnuzyg9H1GBbLVPMkJo4ZfIJ7vDRbkOcAchz4o9tmcIFOWOgyg8
         EIrwHLA+8lHIg8CEg21ifaRWmzPRKPdR7XlSAPAZOO3P6+6bX5sI+eYSb36G6LJ4pkIF
         fMM7S8YFVlDdO7vZQj8IaByh+lRhMurG+FLzy9/MKsMeTaQqnFhMFG6+aAYktM9Bdt2r
         KUXFADAFteNQ4f5CpGqqtTpMyw0HJl4kFrVG58enL8rtdZzh3LFkw1akf9dfHVk9ZzyO
         8QHOuXKFwRgbJDSZ7vAUiv0AvuVyo0buTFRPNZLxUKvNxjcOU+CRVRDQxLPLtfuYXu9T
         c3Ew==
X-Gm-Message-State: AFq9FYKxz+4D7MMt4CCDIWOS8TvqpHXICH3R2k8bJ2iuTmJ2QsN02KK7
	e0Yw1EN2vEjdpnJ98f3Q3/2H9IgzGbqVg2TQrHe1aV5rGdMk9a3ejXR6ZYUEYpIAGk4Bu7vbgTj
	oVw1y4A==
X-Received: from pjboj12.prod.google.com ([2002:a17:90b:4d8c:b0:3a8:8d0:61eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c48:b0:3ac:af8b:6f3
 with SMTP id 98e67ed59e1d1-3ad86f12e4fmr3095046a91.52.1792633224753; Wed, 21
 Oct 2026 18:40:24 -0700 (PDT)
Date: Wed, 21 Oct 2026 18:40:23 -0700
In-Reply-To: <20261021152923.290681-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026102158-waffle-tactless-d396@gregkh> <20261021152923.290681-1-sashal@kernel.org>
Message-ID: <atlph4I9lFbPpzqe@google.com>
Subject: Re: [PATCH 7.2.y] KVM: x86/mmu: Cope with the SS bit being set in
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
> [ sashal: Adapted upstream w and fmt references to the existing mmu structure. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Sean Christopherson <seanjc@google.com>
