Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048A037A494
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255895; cv=pass; b=T1JNNx55g7VzGaEMFMWne6sa4bedhnDXTRGzcmGs3W/AUosyHTIWnPmJAmvrJLAwKLpXNMfApTCq7h0urbpSvmv1U/iQyS7bKecgQGYFYIWC1OCR4yI75oqn1k27xTY8/roCBR+oRi8Y2yn9gNja8U2e9fN1s4Rj7sQdHtUQwZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255895; c=relaxed/simple;
	bh=i1628fISlf4UMwG9ccW9rlvACehVA/JJrr0ofdO8/Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvMi79Eh6z3R9lOilwK8o3HC1nL8Cjn8gnhL8iXMD2LEtaS+SZ1RxUe0sni7jdR6qsnxUdOPRsdWFigeQNFa3+ZtpeE97Kfz94DtWREbCN0X8lWyUAYuh/USuAEM5rThWLA6xXDKXDIBjuL9ivPbDgGUVJ91KGjkmCAjv2fVj5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lct2g94N; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lct2g94N"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1c52d920b8so1559866b.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 09:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785255892; cv=none;
        d=google.com; s=arc-20260327;
        b=lX+D3DNtymWY76hfki3rEFxvxCRicKjayRU+BqZaf3ZYq6g6S5OsU94dEUqwG+n1Z0
         tk0+ogBmZFPSfmz2K1t58ixOSP7Di7Pvt+x+XmIYuagCEN47UVMXkIG/Osv/2rqqOtfJ
         DNHYFX1huD3/O5hqeuK9uMnQ7wiP+sU17/dY4U80aEYWzcp3Z5ymAZG2nbuwzIij7JCE
         XVsYw6kTipz0pWZnIhUQ6I4TQYcct4en6fhxcfwfQn5sllfGay/vhZQJmTs8XGjhEsv4
         /9uAJ11Gm0RLCTq4MOS20GoH6BELya5vKyTnxk0SXLwW/v+KJbfmMjHoDwyiVQ5aBiSa
         Kh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m2b1aa1x2EwEerBPXqJZ1QjoQVkz6jCcTGc7EVDlyNo=;
        fh=LOBP1p/KZVPJx6IWdfbL0MEpr93EpCtg0hzFFO2cn3k=;
        b=P/c5GUXnpu8ORfVXjUw+WGTw8PoFIMkCKTxGo/ah7zhu6XCblZJtAgaGL8EJu0TyZI
         JdbNEIpDGvqr7+qTP8F1JMzVxcpiXU9n8ZxXuYfc+FnVAvKNLUZtsM1BLRX+8lUS3G0M
         yb9oopVu4vNBTfvxbCfbUWgJ/o6+Lv4w7TLMTvvBoS93MFyLjdsjfdPY+wLCJp8iknk3
         iLVJLc56cQw35iphLUYAr48tcbmIlsKdXUrVOZ4Y8arN8dHcH40QZMPupl5FHS8FtlRb
         a5+ahTQ5STu4AXdiG7vLsJdjizBs9yYUtCqsXkDLFXDvIA8wiSt+YpMjBptAiX41W+fP
         sYQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785255892; x=1785860692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m2b1aa1x2EwEerBPXqJZ1QjoQVkz6jCcTGc7EVDlyNo=;
        b=lct2g94NA7Y78eYOuMwwwOD23muR4BCkZNRbsJICh+9hglpnHXOzXUql+nLU/P5tOK
         0d0TBL0pW22X21jbhCabGSMFnajlsSvGV9OScRanEJLdGwTi7hHCw0a8oOhOhHgSnNJ/
         XeHlIeq+bY+ne0zDcpy8Et3BbUl3VTAj0I33k+ARe/2krF0k7H/dHMDkAUTJOGMNpBLC
         d/BnenlAukzH7JQ59YVf11d86AL5VodBO8CWe2cqgfDTbrK5B4gCxaaYes85D/J95kvj
         RWXB+Djy9aFPf/lqI4ioHSn1BMI2+63edIw9TWw10DleSSBn8rO1NXcdhKmhsx04sgZv
         I+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255892; x=1785860692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2b1aa1x2EwEerBPXqJZ1QjoQVkz6jCcTGc7EVDlyNo=;
        b=YTLceZdTtET2elijUWO7IHURpV8RLJvl5JTkkwmJQFdJJ/nkXvlWMABHaesgPGTV8Z
         ElEDnDovrFCfOi03Y8pf0WS1VOM3yeoLMxtl0cbF/54PWYsiMVXktE1L3aWxz1O7K4rt
         lvVdg1WpguHHPt8GIiWoJB/7DbH7/P+5MqR9rQCfArcvSmetbO387/py/MwPbMRFMwhq
         vy8NjiHFVecyZY4Vyqhk+18Jshnj8DnUqI6NHnPQJufzzSugXkkS4oYx/EBkNXXeZus+
         tCdK7iYngs2nTzmVfMLRpfr5uYXJxwl/Q+qKHB61dXsBhrZMGbxnTnlCwluBT7/RJW6H
         keMw==
X-Forwarded-Encrypted: i=1; AHgh+RqJT7GaH7ICxaIy6cnAmkcRTe0sW7rum0qeTZj+lCCcLXca60w3mu7epZslDjiovoXeRIhAREU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCm4m+bMhHaaSChCbBgmaQWNMRnenW4m6EC90T3ky+ktYpJFrl
	MUQeYMi4luTRxGFH8YCKfqTQlToD8g9J44cMuxbchMXvfsswZtGNgOb1YbiuvHjKyswGkR2DEB2
	lYrFHzzPvfOtQhVU8hXSljWwSG1cUCw==
X-Gm-Gg: AR+sD12L7yTiYUIvgIWp1a+D116ND8huMmAYtsPxY8TymFEogLwvrjBMwEwnUOmHxWM
	bnC8dIhHXIHKB5wuys09lmER9FJ51xl+ZlS/yyTjtfvUj3G/QEjfKqiifsPSdIi5uFIQyM0csPw
	P17wXF82/kscQsoV2DCbzAk+EUPkYrC2mLokM2u0nCwt1Z/P1+z4uYTJT9B9gzaq7OdoQkad50R
	RrVLfIQtZGWMt8s5pENDO+I8dBXsdbGd/pkQHGLDHD2p/AsjhjApmliGEbWnNlDyXjwZGw/Q4P0
	chjy9XRcS3pyyyNvRhTOkwEMPZqtBJ9TbVlaxAI56saJpkPUyynB6b4f5gRp3SootERSunt/
X-Received: by 2002:a17:906:6a1e:b0:c1c:1e8d:f8e8 with SMTP id
 a640c23a62f3a-c1f727bc91dmr163943766b.56.1785255892096; Tue, 28 Jul 2026
 09:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGEsz8FbPu_DtOkTij0RvBriK1R0FspzEU6Oef0Gers-gS1d3w@mail.gmail.com>
 <aminBc88wFWw4NSC@google.com>
In-Reply-To: <aminBc88wFWw4NSC@google.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 29 Jul 2026 01:24:40 +0900
X-Gm-Features: AUfX_mx2EsPBF60M4yH0xLU5_gaBUJWDb4Dt0wO-jKFSO-reKfI0H-VlmOyPqeE
Message-ID: <CAGEsz8G8xWvnbtL-zCoGonFKFb8oL0TzmJQ77mPS_64CxrLdkQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Cancel IOAPIC EOI work before freeing vCPUs
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for confirming, Sean.

I had not found the pending fix or the earlier reports during my
search. I will drop my patch.

Thanks,
Myeonghun

2026=EB=85=84 7=EC=9B=94 28=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:56, S=
ean Christopherson <seanjc@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> On Tue, Jul 28, 2026, Myeonghun Pak wrote:
> > The IOAPIC delayed EOI injection worker dereferences local APIC pointer=
s
> > from the VM's APIC map.  Since commit 17bcd7144263 ("KVM: x86: Free
> > vCPUs before freeing VM state"), kvm_arch_destroy_vm() frees vCPUs and
> > their local APICs before kvm_ioapic_destroy() synchronously cancels the
> > worker.
> >
> > Consequently, if the delayed work is pending when VM teardown starts,
> > the worker can run after a local APIC has been freed.
>
> ...
>
> > Fixes: 17bcd7144263 ("KVM: x86: Free vCPUs before freeing VM state")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  arch/x86/kvm/ioapic.c | 12 +++++++++++-
> >  arch/x86/kvm/ioapic.h |  1 +
> >  arch/x86/kvm/x86.c    |  1 +
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > AI disclosure: I used AI assistance during the audit and am treating th=
e
> > issue as public as required by Documentation/process/security-bugs.rst.
> > The reproducer has not been posted publicly.
>
> Though that doesn't seem to matter much given you're the fourth person/gr=
oup to
> independently report this bug. :-)
>
> A fix is already pending:
> https://lore.kernel.org/all/20260727171718.543491-1-seanjc@google.com
>
> Thanks!
