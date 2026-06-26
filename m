Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68DB3B1017
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782501096; cv=none; b=FEAgjcM0AWtauIHzj6VTLtKBh6KYbdCS7QFxQL7NtPdKIe+AnPD9X/TJmMv0YDoJ3Y90ZYkZbwutOmUjse7zbcfX1M9ZAjb85DmCJmBy4gEPOyzJJrfdQWPYNQ8g2vAUiIh6GM5GL78LvH3hRwzoQVup0rPRHUzUo5eByUImI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782501096; c=relaxed/simple;
	bh=SYyGX7CRd59z7RJKo/wpZWXgbmtBMjXEDxJ0dGqicvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dKrtOTZ8+4Lh3JEsEQkSeYi47FdMScgswN3PiJpVvP5WP1LzmDasQ3wvNaXHQLvctPukvgqaweRJ5Efjg1QPOewuQxAMwi7NTSeZ8etMSBeU0SwGZ/dE+VyMhrB0KrH3YHIGWWyc6uPECEW05xlsxJmlRZ+nrMgFbcJ6tcITDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzJ9zf3e; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzJ9zf3e"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422ca754d8so719535b3a.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782501095; x=1783105895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2knDCK7pRXDoPdThYLEfyiz4oOOQn0caXBXu1bE1oGI=;
        b=fzJ9zf3eFbhRTnyxIjJgEEg2ykXbV/J3iV8a1rgYlkqK+TT3LxQgvaPqd8nTgRjBDc
         ZELZL4aSzTGxlV0AOjDYiqtFHd4TzGLJEkOljVgqW5r6GUX/ajvZJomlyRH8CYDQY/d8
         zIqpt5CTRTBs1gfIBw0lAPGnjmMMkH9R7LcYDR3gQqFUHR/FuEkfzfdhhqiM7UbyLNGG
         Q8fTg5tyUAAc6NZY/ceg5OYpzpYXPb8OA3yestJZwyCn1xk9ZTccaWhvwOzzeGvkk9bE
         LxqzbDOuzw4IURnAVgtmc/7FEOm/61s0cLqanR4IsQ0oIqA5eb85gM7HDC4Pe6go3Btq
         6VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782501095; x=1783105895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2knDCK7pRXDoPdThYLEfyiz4oOOQn0caXBXu1bE1oGI=;
        b=OjmSc1Ma4RGLy7B/2pi03DX9uBuQb3cTiSdsC8Jq6fFMd6e+6RW09QPVIOL/xboc3G
         q0NhuTMC1juv00y/QQikmJUUfnIJlVU8+ZxHzc+4UCmpgSe6ADN/Ouh78u1eshXohkNJ
         0d5aew9QquWx/wAvnKKsYdMpzEW6RyGADDi9/EnV97XibASlPc2a5lGFXq8n52CW32vZ
         TL6p3iywkiGBVLvDyGd/qMBe4tzP85t7h4Y2pnX8aPOBHDwE1bmqvP+NSBEbgxpbE9/i
         iNnjviOiU7jmWpQHgEBaZuqN+ccl+4+nPGhmsU+fOcN+Nk/CsrmtDWWL72xmcQg2ZdcP
         W5GQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GCvee9+zOLC0zT+4nKgapbr4tFcmod0xfHG18u/6NIQjs+QxcfIwTX7M5bdF8+zrZuJCFEyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxtM5NfkAeXqIzGwlMbf+SznGlX4/ouRLCPaGbC8s5sKrU1NU
	OMR9sBK1erATbOa7+KBx7PtMIUsLUiMeqiNQJy5AB4I0mqEarrZH6m63ATGFG7U0rfY3F9ZVnAL
	QhMeSrQ==
X-Received: from pfbit24.prod.google.com ([2002:a05:6a00:4598:b0:845:cb91:3911])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:84e:b0:845:b5c1:cf62
 with SMTP id d2e1a72fcca58-845d261fcd6mr1209650b3a.43.1782501094810; Fri, 26
 Jun 2026 12:11:34 -0700 (PDT)
Date: Fri, 26 Jun 2026 12:11:34 -0700
In-Reply-To: <stable-reply-item008-kvm-515-respfn-20260626@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626112606.1778248-9-pbonzini@redhat.com> <stable-reply-item008-kvm-515-respfn-20260626@kernel.org>
Message-ID: <aj7O5pjLMtgYDHNe@google.com>
Subject: Re: [PATCH 5.15.y 8/8] KVM: x86/mmu: Ensure hugepage is in by slot
 before checking max mapping level
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, 
	Alexander Bulekov <bkov@amazon.com>, Fred Griffoul <fgriffo@amazon.co.uk>, Alexander Graf <graf@amazon.de>, 
	David Woodhouse <dwmw@amazon.co.uk>, Filippo Sironi <sironi@amazon.de>, Ivan Orlov <iorlov@amazon.co.uk>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 26, 2026, Sasha Levin wrote:
> >  -	if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
> >  +	if (sp->role.direct && is_gfn_in_memslot(slot, sp->gfn) &&
> 
> This drops the !kvm_is_reserved_pfn(pfn) guard instead of adding
> is_gfn_in_memslot() alongside it. I think upstream could drop it only because
> a8ac499bb6ab ("KVM: x86/mmu: Don't require refcounted "struct page" to create
> huge SPTEs") rewrote host_pfn_mapping_level() to stop touching the struct page
> but that commit isn't in 5.15. Does it make sense?

Agreed, the kvm_is_reserved_pfn() should be kept for 5.15.
