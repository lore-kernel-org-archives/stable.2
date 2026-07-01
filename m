Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0A38E8DD
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879047; cv=pass; b=TKdr1rV1CL0G4wHVWrI9OHQWeModgiWJVvX8pVKAujxc0zq0V9Zf9WhJnzJucS7XxmwNsBrQahgLttqFrGRVAYRzhy/XFg6iNe7Vi7muDrqfwp1AC+NZAB7yZvCVGgoU3gRsLmYEYZETULJeVsRzXuoAv1wJtYWX9IgHde90IiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879047; c=relaxed/simple;
	bh=K7AVw6CRSSWo+kyGW3qEC1y7imXJUOHCQ/AKr1te56M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf7t8Hj7ixf5s7N6LTswUd28YyvEfH6SiEDgahgQ/VjRjZN7jPZHN9Gxa/anFH10I8Qjpj7Ck4ymeZLpVxE6vWW/bwMJpuKGE5mAvbsaNb9R6JORJkPL67zcS2IeTnOHFM8k32RVMpt+x/0CLvfoZClBSJ/I10q5JxIR71fB23k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cKHC7ore; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cKHC7ore"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6984520d66cso35857a12.3
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 21:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782879037; cv=none;
        d=google.com; s=arc-20260327;
        b=WFoSJ9P6Qekw+M1xqZ10tgdhehL4gY7pBG5wbzV/m3X4Ks75ZwCyk1I6confcXrK31
         eVVXfevwNre2xsrIXZt0W0n6AiXBj1aC41wof02enqC5Krjd4mtfaappwv1rfyxMW7KW
         b07cAiFKb0yd56Jnm1Bf48utN63gg/f8qouMFxdC1EHnVgmv7AtPnKbkzquGlEjT31EE
         Q8kNaszymsS0dUQ0pjHfoK28Qq23Pc6CsUGN39ea4L8UAt4v927iuzPIYx1rW2Hnz6uf
         xim2sCysv+7KIz8Ru9Ya83zLyk0u/fR0f8iFcNgnD/kbi6LCF+6meW9HmH/S5Oj1eowE
         5hpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hBCDeVV/7tAlQd383hqO0MciRsgWHKYXszEcpKPT18M=;
        fh=Yjx/IQ6tjDsySxdzkcfBZIxim8I4kYoVNuo7jAf2v+o=;
        b=EdWhTGlMECabFCWA7Dr3Hl/NzzA0Hdiz9YWXIBPGQbr4LXMW3qahOa514cRJnUAXvE
         QzcrO8Bo+T+VrR25I27D8wgGQ1eFkHPlpSFuSdIqoEuIhyDem6xdAaGvokI8Vy2l00hF
         pnzxJXpJGObHEP4sDm8EVw6+V+Mi9rYXfs+hURlgR8+szOcIEv5fDks9bLWze6LgTspS
         GOW2lnTRONf4oTz5r7ApTxv0IICXM6TBu6VzjzmPix5Kd/nFYmFPnTEwviF7w1tNni4+
         HLFIj/nMNjQVonfTgEGUIWiJ83S4psLuTdigorCp68xIy2JWCQIs4Im4c7CEeCcK+u4F
         eWzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782879037; x=1783483837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hBCDeVV/7tAlQd383hqO0MciRsgWHKYXszEcpKPT18M=;
        b=cKHC7oreHaf4894k7wGqMw0JyR7AyzkOICp/82q7ShUPZOnR/WfCVjK2fyqdVAeunG
         q1bS463Za4gKpWpwFp/XaYT61/ufzdpvsQE4tF1o04A3g0OUFeC97czS8BRHsdIFzZ0X
         IFVThOpZ9HtMj1S/D13L1ko406Ao4JAYgUr54VweZw8VtnMkUWeCm/dpE1K+8TeyOWM9
         OexkMyybRr5pIbsH1CBKHWgX8dVb4IiA7VRhY4E0bMD7vsMsTyyiIMMUZ6YbsGst+P8S
         jiKk6sRyvbfU1txId69ZuXv8CJU6K7jy0ZRsL1MVZUEpd0QvcMoudhORhBIeHsJqjZIP
         4CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782879037; x=1783483837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hBCDeVV/7tAlQd383hqO0MciRsgWHKYXszEcpKPT18M=;
        b=VVBaSo8/6iK0lx+EDBcQOvt38slGzRU9/DC/DfFn8H4KwAOJL20v0aNIPu1nldwzmY
         R4D0fmkkRCGo/Qvwjqy2E+lLkhpw1GSy1S+hGIz+HEsueQIZ1+TMC96IkRRyc96TjRr4
         uVKfh1Gd0XQaFXPSOOsdnImNGawoKdflYKy8SVKF0yxxkYxc1gVMKlbXtb9pZCgioKDa
         LtoiDoy84mcAAJfPlSRB9h3o33vGTrX8FOZeZKXLNHLNpsQAGXxA/RhQe4C9E62r4RCC
         fpwDrL4d2tSJd2GSVQWJajYlyUMTiQq/4IZxYBnMy+s6LPbHnRJpz/4t0M5I6/W4E/v3
         xmlw==
X-Forwarded-Encrypted: i=1; AHgh+RrAKK0Wcfdff3Uo8tw7f43pBgbrAZdF65nDbPxRLW4+xzG3vOnlPQHSGieljS5P8i4s6zDyCFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIWmH/kIUTVDBSCDB7jcyZUoHJRGEBaJ19P6lB+Uluw3ik66kx
	wPgHjy/WrlpUfTkXHuiDQwS57Z+LMXVqz/qpvaj1MmCFFJcLUnJCqLUjsrW1s8seoZKc5GrvLpH
	HrMJ+NMb2jUj1U/vP3jwRbyEr2Q2b1tv+gACeSrt0pQ==
X-Gm-Gg: AfdE7clLYAyPP+rKxD0lKoj11f1RThNjyRLfjafkuM7d5IES3vtji+5WDYvw79YlJJT
	Otq7MedhTv4B7Lzeo6wHMMZ8FIc8FSASRU0xQok82A07syYTu2GcgdPuRoWo97in8JwvOGPmkvi
	tvo+riwCXY+QNkO+gupD9NZuBl47xgGgjVsMVpbnsZjLvFCWTFqXteIyTMTyaT3D1aayDgmRqBW
	egIoFCfjuhMZ0AvdYvYeBfEKDi9LY+0AbCbOTVHGqgsl422lkg0e+duCHTMdfHX32IXJ3vLA7YA
	pXz/zqH2VGBGH942TBRNfDvOeAAMpA==
X-Received: by 2002:a17:906:fe02:b0:be4:e8ee:47ab with SMTP id
 a640c23a62f3a-c12870fcef7mr179380166b.2.1782879036731; Tue, 30 Jun 2026
 21:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626193343.256956-1-jinpu.wang@ionos.com> <20260626193343.256956-2-jinpu.wang@ionos.com>
 <akPVwJgnBuCcc4Hm@google.com>
In-Reply-To: <akPVwJgnBuCcc4Hm@google.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 1 Jul 2026 06:10:24 +0200
X-Gm-Features: AVVi8Ce_j1qILkL-WgLOd6TFbvSdQtyWq09vPh9MxwCvfuXtW2jXU1ACSPz5zP0
Message-ID: <CAMGffE=+cFDU27Uy7WmjXuYWLEZOH28oWMtSXydR=vxwS0WjUQ@mail.gmail.com>
Subject: Re: [stable-6.12 v2 1/3] KVM: SEV: Ignore MMIO requests of length '0'
To: Sean Christopherson <seanjc@google.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 4:42=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jun 26, 2026, Jack Wang wrote:
> > From: Sean Christopherson <seanjc@google.com>
> >
> > commit 1aa8a6dc7dac8b83234b53518311bf78231f4fa5 upstream.
> >
> > Explicitly ignore MMIO requests of length '0', so that setting up the
> > software scratch area (and other code) doesn't have to worry about
> > underflowing the length, and to allow for special casing '0' in the
> > future.
> >
> > Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Message-ID: <20260501202250.2115252-3-seanjc@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> When sending backports, please document what was changed.  Doing so saves
> maintainer time and is very helpful in case there's a problem with the ba=
ckport.
>
> [Jack: Duplicate the fix to the split READ/WRITE paths]
>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
>
> Acked-by: Sean Christopherson <seanjc@google.com>
Hi Sean,

Understood, I'll make sure to document changes in future backports.
Thanks for the heads up.

Thx!
