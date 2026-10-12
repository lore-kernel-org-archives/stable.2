Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BCE4B8262
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825035; cv=none; b=qAf8kCLFuBMo6VfgVgN5i960Kxcm53a+dZmY6EhOTaJ8YBvoQP8E6aJwhl8gBHZlp8IE4N9at7h7hSvY6Ok5H03XAR6kW2WwiEmocqtuKGOZf+liL39GqQvmVWZXXgDxP2g1Tql5+ybhcZSQ+FbYGnA2B4ZOyR80vCdeDlw6/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825035; c=relaxed/simple;
	bh=0goFEkFMT8A6LRstNuowUAwlXncYf/uJY91bP8oFKbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IWBFpo05uvyHZFJu53F0Bq2yUmLfVcCM7ZMVHxGhGE4b68qskRKgNyj5/Z9QHBHBq10xDnfudLz0pFErUaaq+vAHOX2o1tFDV2qQ+SBagECG96LGbLERWMEv9u90lxZfLuF8ZvfvckZySNx78seiefbuaYdzUArHencu4IPdSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5ceWiNE; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5ceWiNE"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39deda201bcso3024485a91.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 10:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791825033; x=1792429833; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8jxcOSYXGm6WJMdLKwFLj7sj5ewHITlBbP4X70Y5pRY=;
        b=F5ceWiNEtvnK3bV+5VPRI84ZhxaHZovggkud4Ea4N/iRH2ogi3KTfM1g/QcbF48qtG
         FO/wMGhX50a97QOn0AhnoK7cNotBTT4ZxnZRffTR05ZaQ8AxuR1Gzt2VWebKbzTcxWI0
         U9HJnBKqjFzZg5dW0S+9QjnytZVI0X/3qwC1l0sy32BY9GQALpT582/PIcpjE8LEfnEZ
         r+kaEVBjh6wVsuKobaz/ckLn+zlayCgs05M1s1uJdBXrj8EIunj/HIBteGhl/8k6LCyA
         iFs6S5q452Ws6FA8dRz1ogoiblfIpBrzpDu3K5FOB4t2GjcWHFcOzy+rq4zuflyPiYIS
         1ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791825033; x=1792429833;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8jxcOSYXGm6WJMdLKwFLj7sj5ewHITlBbP4X70Y5pRY=;
        b=Z9rJfzWtn4o8UTNlZNxk5zMohT6U2/z4YEHm5Mq8GkCE12MGrv5AtYAIJq+ytJuBU/
         sRL/JdhgmwxEHkLB/DNM6ZUoBA+JMeFET0l/whg2A7OhWNJ6FtMU+eGtpsVFHrpK1G+b
         x8tAO2hYqOHMPZHTRLe0U+2SpunfD+xTYvCeWLuh6emWhjWA9fe9RBnCpjkh8Fq3/aGo
         TpjsfiXDUowrtw+Ljtd7xof5ex5CpZT+1r3itgVgJn3rrzsmjfaIic2ztPGNfEd8fqDM
         6fl3/o/TxJ4ynQ7n7pHCO6MaAG+5R+M2SIgANYjwdKYs2zjTr+EWdCMCWr9a0hZZ5hrh
         ktIg==
X-Forwarded-Encrypted: i=1; AKwUvBwslsVvQfp8azn5ZyVpznSJG46yCOXdBA8K0ELVmh4XeHwzxkLE+zFtdip79cBdSLaSplI8/DY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7BuAZ1CDybq7Mspj8hqwJEPmQJ3cdpdFR14VdlSqP3nXdoDHD
	nOWllUU0hW+GBIj8HXc/g4/wxcmQEQxcZI7n+4ZBO1Ekw+stYxF5lkGeUUfollC8vkgTgyTr4Du
	d/1RkFA==
X-Received: from pjbci19.prod.google.com ([2002:a17:90a:fc93:b0:3ab:2200:5d9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3143:b0:3a6:e99b:bbdb
 with SMTP id 98e67ed59e1d1-3ab3ac718f2mr9455854a91.50.1791825033190; Mon, 12
 Oct 2026 10:10:33 -0700 (PDT)
Date: Mon, 12 Oct 2026 10:10:32 -0700
In-Reply-To: <20261012165651.130826-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012165651.130826-1-pbonzini@redhat.com>
Message-ID: <as0UiAF45D83w2ph@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Cope with the SS bit being set in #NPF
 exit codes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	SimonP <simonp.git@mailbox.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 12, 2026, Paolo Bonzini wrote:
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

Can you add a Closes when applying/pushing?  It really does help archeologists
piece things together.

Closes: https://lore.kernel.org/all/asUqYEisPp9MJ8mQ@rika.bernkas.tel
