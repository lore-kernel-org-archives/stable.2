Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D562F7F01
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435620; cv=none; b=fhULNMUBRAWP0d+AeZNmjwDg2CaRNPnB7RMJ/ZKcDawinYdjP5qmGj5cTZWHWcO2WRWtxtPwKrvFJZOizZXLSkh9AEtnWzfdSQugY2xhDqv1r0qbjHhWe0ue+mAO8RkxCiWMjBwEjx+Qfo535ATWqcTVUCtN0vbjYpy2RZ4pa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435620; c=relaxed/simple;
	bh=dbEhWFYQcuKtmA70mOptSUK8mT123phz+xATTayPUfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVd2tI4PaOf1wLsC5iqh25GZCR9+4Stmq00BeSidDIpNTT4FNUnQby3Y4+FxcKuFOLSwH9D2cmoEOpSNR2t7t/xwlG40Rp/PYGyTCmySMHmatpXhJQwcmsKMZsLvflhw5veReHamNEYXrV17/z6D9MRhTzzsIth6rMIo/xv+LwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZFjjmUy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZFjjmUy"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6bbd0afffso90102395ad.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783435618; x=1784040418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HufNVYu34je8HZzz4w1ytu+7VhpoP+vTfH7cDlFEijc=;
        b=qZFjjmUynfjxrsqgu/khQ3Q8LO1qM1jBb8s8Gj+7Zb7nNqPrEc3UjrKRzEYuKqqi/R
         gjf5G+SobBeWYLbPGYZAEn4f0RleCZpzmxg8C6dSw0XQXZd87VoLxQiOaS+oZGctqzse
         QHp3g1zpUF/VBBzOB4HMpz2TWTzsxf48WsyQf5qKJSTUuKYk/7ZYMw2VrICVP+ASsZrz
         ii3VtxQPRDmJ+PdJnPOUt2Zp1EyY+IoyijYTMGIkQ8tCWsDcZL8eYei7hyFTW68x4pYv
         waiFKqdpcbkHcoQImYElEhbWxzvw4+p9jYOcoRlLxqTY6wCAuvScBUp2hOFgAnx04OZC
         g6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435618; x=1784040418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HufNVYu34je8HZzz4w1ytu+7VhpoP+vTfH7cDlFEijc=;
        b=MhqpbwvOig8Hr9Yz1EDPvGyXo1sWETEna0WO6RW/KDlqYejnYJmg1DwEKOFYkyrNqZ
         xDdEZKegh/4JPSLXXP+x5beMRe4pcCHDYahJGWQSzBO+P/gWmALy6ojhmhvhlmhtp58g
         gqxG5tMQeCZ+SRLt7fIwURtziNqiUTdBY5pjs0v4lbepMP4zBsBw5jZ6aV1LSer2x1vq
         gxx/TMh+WGSsKlDPHHx59PFSoqzEXNBK6eWishfpRmzQJ24YtMVuU2Q6aYdEW4Z7XxHi
         l5u7Hv3qsfY7Iu7+jAUAxKI48V5Y4XrT93qK4Skmm5/KF5vN0MZzJ88hWMR//Q+9p+Gs
         3MgA==
X-Forwarded-Encrypted: i=1; AHgh+RrOP1C1SYOrIBmwQooDjr+Qo0kPgOQiWHEIeoyyE1PJC9QdqgOxTqkrTtJuRikKBzv6MEpIr4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNJybojL1pkMpsGwKQU4IEMZFmFeXy4TpxYy8C53KGAHEwfh9
	4rnxXu0VlM4iCci/5t21FDHi6WtdwakSSfUIQpeR2nk0qkkrhMiENhX7Nfu7iQOntTCj1ypQ2LC
	54DneuA==
X-Received: from plse11.prod.google.com ([2002:a17:902:b78b:b0:2ca:d667:90e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eccb:b0:2c9:b396:1a55
 with SMTP id d9443c01a7336-2ccbe611f6amr53537385ad.12.1783435618181; Tue, 07
 Jul 2026 07:46:58 -0700 (PDT)
Date: Tue, 7 Jul 2026 07:46:57 -0700
In-Reply-To: <akaCzNRGVy5Xr-bG@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701110547.764083-1-kirill@shutemov.name> <20260701110547.764083-3-kirill@shutemov.name>
 <akUrORhAmRur-lHP@google.com> <20260701180033.6e9c07aa@pumpkin> <akaCzNRGVy5Xr-bG@thinkstation>
Message-ID: <ak0RYaft14ku6rEi@google.com>
Subject: Re: [PATCH v5 2/3] x86/insn-eval: Add insn_assign_reg() helper
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Laight <david.laight.linux@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Dan Williams <djbw@kernel.org>, 
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 02, 2026, Kiryl Shutsemau wrote:
> On Wed, Jul 01, 2026 at 06:00:33PM +0100, David Laight wrote:
> > Or be even more specific and use '& 0xffffffff' rather than a cast.
> > Particularly since the casts of the RHS in the byte/short cases aren't
> > needed at all.
> 
> I'd rather keep the body exactly as KVM has it today.

+1.  My main argument for casting in the 1-byte and 2-byte cases is consistency
above all else, using a mask for the 4-byte case defeats that goal.

> This is now a straight move + rename with no functional change, and the v4
> attempt to rewrite it with arithmetic is precisely what introduced the
> AH/CH/DH/BH clobber Sashiko flagged.  Tidying the casts turns it back into a
> rewrite and diverges from the form KVM has shipped for years.  Feel free to
> submit a separate cleanup on top if you feel strongly.
> 
> Updated patch below; I'll fold it into v6.
> 
> -- >8 --
> Subject: [PATCH] x86/insn-eval: Move assign_register() out of KVM as insn_assign_reg()
> 
> KVM's instruction emulator has a small helper, assign_register(), that
> writes a value into a register following the x86 rules for writes to
> general-purpose registers: an 8- or 16-bit write leaves the rest of the
> register untouched, a 32-bit write zero-extends the result to 64 bits,
> and a 64-bit write replaces the whole register.
> 
> The TDX guest #VE handler needs the same logic for port I/O emulation
> to get 32-bit zero-extension right.  Rather than add a third copy of
> the same switch, move the helper verbatim to <asm/insn-eval.h>, rename
> it to insn_assign_reg(), and route KVM's callers through it.
> 
> Add <asm/insn.h> to the header's includes so it builds standalone in
> callers that have not pulled it in transitively.
> 
> No functional change.
> 
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Cc: stable@vger.kernel.org # prerequisite for the following 32-bit port I/O zero-extension fix
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
