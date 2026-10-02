Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F82F0661
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975262; cv=none; b=KgLIygTQHMORncxiacd1obOKkIPhEY5OMwn/kMLJL1Nu2DNRuzVWjm2PIDS6cM7+/rcKUAw3Ak/jOW9srCaRB1gqhc6gTCFa0XX+TRQ54ihA9jPWFTXI33MCC7M9qOe5uxEeDHVQBJAcv7uMZLWBHe2DCM0s+9n5Obkscs8ofgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975262; c=relaxed/simple;
	bh=EqpEersHzVmhGGlAhMrKzkJXBJBwTDZDlcGNEDIR6MY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oOGdO8Vwe+oyLqX/gGT/MI9nR2BpYFuvGQQO47lpe54bjI6c2v7WBzXHjB7HU6qjKkpW1SkT101OJsxIcuDbXIPk/OcyRnzd1NYIssD2hZCvxId6BGwL1sT7Ux0dR5ewhHSlmHhlJhqGDCd1OorZ2vEr1CKhrLv/8VJTlUEOF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zswd1NUI; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zswd1NUI"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1492893a12.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975261; x=1791580061; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tV4Wg/BuvZALzM0AR+fUyVgqIVY7pfN6zmYWgustXFo=;
        b=Zswd1NUIEt+zT3r2ZQfSZMHIQz24MNxH5LtPK4aIkjzk7RZ03sndWhHQxoQXYVVKA3
         vOXg+qBHmKhaevkbx3BYX+Rltax6x0kJ7mnfQAp+Ogirw699yxOCxbVcVlFlX5eVfzR1
         V6qO0NsYncRaJFt7DS3QviSDd/xjHdQqY3H5Tpk3zfKD+FO0BScbjUrCnkAdYhbWgGce
         eX/y9sYHWV5DOe6JO8kMOOlnklq3aG0Uw7bHdnuN6bgir3e+LaA22N9WmE2Lw/j7s7xr
         pFU/QeN6Hq+SYjrl/6RcOv46i+uRNJwkBrQ0H8nC2oBkA5zB925T9dDNjVAIdfQg+o10
         p6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975261; x=1791580061;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tV4Wg/BuvZALzM0AR+fUyVgqIVY7pfN6zmYWgustXFo=;
        b=wN627OsiZkPNFTDNsGIAhT49ArFFcYAEbZD9rONwgxC9pcDfzndTDZcz/Pf9HC0CNJ
         G80ZVPwczQkrMQAz1Zef7GFCx4FsBjpcgKGgcBfSNkCx4Qnp6MQ4We2+WxIPCY0tVJzx
         lXJDgzwn7lQf3xlz5CMaul7sirWLnLmPPbp/xlIssdnz4F12/qW6fIBYgruVLlNqG2G/
         1ixbS1TLnrfvrWjOR3myk3bZn3jzXDOEEHe1PuWgHrBhvgcXPl7B5tm6HCEE28YyeSIq
         Gy2B0Da1Ur0ztYmStWFMfE91EDVei/AFzcd0AyFhDte/YO53KOxpD0hXeOxfHbQCjuqV
         2ENA==
X-Forwarded-Encrypted: i=1; AKwUvBwTH3McL6xH4AVyJ3QzoPyjNBMwRF6kb0Gg9CwiDbPLo9So52tkikWKDCtyC/1nH88+/yxndB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIw2masj92PR1PJ9YnMPiAhOanBDhsJT7e2XPHJYAf0OpGoO5sJ
	nE4+xkSxUaIbnn1v9P3o6BRYG1CsN5wdomsxiLEuzziaRU+J2WBK/DZBnVzwPsJkWZxPr1wgfcp
	tkh8JSQ==
X-Received: from plbz6.prod.google.com ([2002:a17:902:ee06:b0:2e2:c674:f3d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:9302:b0:2e3:2c8:66c6
 with SMTP id d9443c01a7336-2e302c8695fmr32396405ad.32.1790975260586; Fri, 02
 Oct 2026 14:07:40 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:06:48 -0700
In-Reply-To: <20260807112818.958190-1-kimjw04271234@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807112818.958190-1-kimjw04271234@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097486001.4077423.1581712364999125991.b4-ty@b4>
Subject: Re: [PATCH] KVM: x86: Use active memslots for the per-vCPU MMIO cache
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jinu Kim <kimjw04271234@gmail.com>
Cc: kvm@vger.kernel.org, security@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 07 Aug 2026 20:28:18 +0900, Jinu Kim wrote:
> KVM tags the per-vCPU MMIO cache with a memslot generation so that a
> memslot update invalidates cached MMIO information.  Both the fill and
> validation paths use kvm_memslots(), which unconditionally selects address
> space 0, even when the vCPU is running in SMM and using address space 1.
> 
> Commit 56f17dd3fbc4 ("kvm: x86: fix stale mmio cache bug") added the
> memslot generation to the cache key so that a memslot update could not
> leave a stale entry valid.  When commit 699023e23965 ("KVM: x86: add SMM
> to the MMU role, support SMRAM address space") added the SMM address space,
> these helpers were not converted to use the active memslots.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86: Use active memslots for the per-vCPU MMIO cache
      https://github.com/kvm-x86/linux/commit/b3e6212dea2e

--
https://github.com/kvm-x86/linux/tree/next
