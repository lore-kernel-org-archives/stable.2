Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6B3C343C
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179177; cv=pass; b=pNf7yLT9f140beMf2FPlbRw9Doox1S33sWONW1CRoeS5NjMEN5S0dc9VCH/anwwY5y0aPmPdbyDFqWZtqV2J+ijWzI8CnVPllMXBNb+/9FKqwZq/MxMOfJnEpNaZsH48i0YPK5KoKJS1YkOLYHaxHPAQHwZGtrGG/CcwgmU32Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179177; c=relaxed/simple;
	bh=MEjqqJ8STGAiw1ShutZb1MiaJfQSi8GqlcBV0l3Jhd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9qrQIl4lXsPs4sCWiaS3Rm15XmF1fAZ20F+EaPQkG593fKBF5/nHgbqy2RsTzIciOAij8eXwRuEYS4P9mO6CrshgSVysUNDZ5+t6ipnIyzBeDfLnkwGCOhVnTntdFzW8MBbhqtKbLkZ4hEsylLXN0CElNtJ0a6ciq1ccxQKr6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQl5OsG9; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQl5OsG9"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337fa12431so601cf.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792179173; cv=none;
        d=google.com; s=arc-20260327;
        b=gj0vdsFVpTdfD9HTFzeTnJ+3NrToWV28LsP5YXNfdLaCaNIsLKLoc1o2d3hUdqNQ7K
         m/ioFXvj0kGkCsbPZ6kn5N/MG38bhOott4mzx6boSw9gi2m4zZW+PhbZD9XgsAu5Ohxc
         6AjOf7YTz8c6wyA1PCcy/QpcFIFkmacYQGH0EZSs5nHrcufjEkbCgkH7Jl57FK+tWgEN
         DsoT0lNqGCwvn1LnvJII+Q5MxRHseEDKfS2ipJH037svYiuOwEjLFu2C0bldOPvLqdB4
         rAi5SIxaSQ7TgM+KY1U9pJz21NHFjE/bZR6RasgF97SVhXI941WsNGgfcKorPHW/67Me
         kJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MEjqqJ8STGAiw1ShutZb1MiaJfQSi8GqlcBV0l3Jhd8=;
        fh=QHOdoZisBFWzKYGVtkO0iUASob687JsAepzceZyOlCM=;
        b=ZOHbZTRhnzps0rXWdjoW3BY3LoQGUro/rqn/HiGiML3zFOq1K/rL2RnMVXrvO5F6Lp
         LCVnKiEPXg9sigaE1sVJ7OFskHwtYdMhTSPf5zf7SF4cvhzvXIxYeyR4PCBFdKSFSDm9
         Gg2ogZwRmNDxJqyQDb51OMSEWyAHyeAcWZEivmuUUJHnRq18m9R4GGFU6Gigaa8ZBr+a
         oTFVQdP4wVKG8q+PW4f5YOa2vu/uLucE1W5zu+SlxbOIbb0OuS6uLEPY8unKwcU4nsvO
         rK1G2+EL72IIeUnrwOtouw34NyQOvvxHNu7sYAd7EPoCmOhhJWtXO+csW/m81fnw2wUu
         dbLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792179173; x=1792783973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEjqqJ8STGAiw1ShutZb1MiaJfQSi8GqlcBV0l3Jhd8=;
        b=LQl5OsG9PWIneV6xpRYFa1mAyNeLlWP0rTkUHj3//0xaDk8hz80SqYhbN5GjkVRqG6
         q4nhdJf4fHfhYmCCUIgcruTovBcWT0z0RQuzCWOQGlM3ko5GHfs5xqM9Cz6YbKOA/wY0
         EEDC3ilWd7X61FjmItfijY7g6K7/wJjZmZK0UTSK4qJucRt+hDSkpais/hLq0XSBm/8j
         W5m2d452aabY87kbMwygBbA/dUvx72BgiJbsviOS+BGNb6kCM+cVADUda9ecxznKyLtu
         j7EiNSltjk9SxxwvZP81IqnzrpXA0BIkwW/u3e1VAsKUMIBEwDYU2+ySE5vlu4c/Fwp+
         Ah0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179173; x=1792783973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEjqqJ8STGAiw1ShutZb1MiaJfQSi8GqlcBV0l3Jhd8=;
        b=zHArVHvH1wKqQCJ3MbZiSiSv0oz/pqmKsm7uTajbfrff57HQ1/fZYfdLsfFJrFJtdM
         2AtqtkW0EKNZqcD+FXjttaP5hTTp9hMthRGMfiNsnWIjvNRKWzw8aXFLm2sFV+h7Udz1
         0INv2+ui1LtsS5M1Eqw3+OpeOhrf1Fu3Tn8g8Pvx/+8jmDidSSOt9pMydwjhUtZ8fbis
         2yx0YleHxMqVAKwmZA/IwyHiRJA/ckHHzoOgodEkqioia5NrAbzvXMqQidRtzrXFSVyV
         KqcS8f7/J5jmA7Qp2E8BTejpNw8MpH9YruMcN9o+2ujzFnAilJ6jgxoWb7ibQFUMmSoM
         5A7A==
X-Forwarded-Encrypted: i=1; AKwUvBzAay0acXScvewwSPrOc94moFkzjntSQSokfPY7rf8bg1r+tjG7gL3DtXgjpQ4vScL6yoXKoCQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRNbjXvRnMTeBualJqfVYy85d9W/9r0q0znABA5vB6lHKgpquV
	7+wLn+9OQVBXlW+YV+E/DykDDXXlUgsvjIYFuQ69sKPzAf7trQB326q5JZucVdgWSMnzMRxkYew
	pWE6t2TgGcOgEgbKsbl5m8kRaXBbTcL1mC6SZWEiq
X-Gm-Gg: AYBFou17Ncqt8Si1O/flHUeSVNIMuwKk0i8H3uPiND+qVCYzgtf64zJAywaXGcZqmK1
	0oPEAvAAEYEwyl64pAzQmT0arscyUwW5juadM2xkGQyFMhwA1j/9derx5eVYcn5fwwCc8S8jpry
	UdpGSwly3abb5WYvSzadoFCe0TafumQyeqPbUsrykJkp6mJc2fLXTiEEcUqzrcYFe06Ji6Mk4c9
	r/p00SoidvXTvDRE2JqzQLZ/2VMWjYqvyNeIuGJKLE9zFaltIZl1i60FwT6jveFzompe3bZVKfT
	dWXnIGuacYXjU5b6kUPt23ZnTwo7S2hXXy3fTygXaylmXF1VWJbOxkw=
X-Received: by 2002:a05:622a:488d:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-536463584e4mr2454001cf.9.1792179172628; Fri, 16 Oct 2026
 12:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-2-yosry@kernel.org>
 <CALMp9eSoidVrzHqTrq09LB1SCwsf5DuwAcys_q7o0TyrKM1Ciw@mail.gmail.com> <CAO9r8zNcG=5SQK5QBC8QT2QR7K5AJtAOp16atDc5DYc0shD1Tg@mail.gmail.com>
In-Reply-To: <CAO9r8zNcG=5SQK5QBC8QT2QR7K5AJtAOp16atDc5DYc0shD1Tg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 16 Oct 2026 12:32:37 -0700
X-Gm-Features: AclHuK-ZQp-6TfXpSbf_CVQg-2-T-7CMHpUhbyrETIPAQMotQvMXWEMbF3I55Hw
Message-ID: <CALMp9eQCbU5onzrjnprFuP+AF01hpn27ioBs7Vtq1bOaWiFwvA@mail.gmail.com>
Subject: Re: [PATCH v3 01/27] KVM: nSVM: Flush the TLB after forcefully
 leaving nested
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 8:19=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Wed, Oct 14, 2026 at 8:02=E2=80=AFAM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > KVM flushes the TLB on nested VM-Enter and nested VM-Exit, but not wh=
en
> > > forcefully leaving nested. In this case, L2 TLB entries can leak into
> > > L1. Flush the TLB after forcefully exiting L2, similar to nested
> > > VM-Exits.
> > >
> > > Note that vmx_leave_nested() handles this correctly, as it reuses
> > > nested_vmx_vmexit(), which handles the necessary TLB flushes on an L2=
 ->
> > > L1 transition.
> >
> > Fixes: ???
>
> I figured it was too old to be meaningful (i.e. we'll backport to all
> active stable kernels anyway).
>
> But I think it should be:
>
> Fixes: c513f484c558 ("KVM: nSVM: leave guest mode when clearing EFER.SVME=
")

I concur.
