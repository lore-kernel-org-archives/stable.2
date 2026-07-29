Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598432DECBA
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785300818; cv=pass; b=jO3pKapPoZiD87mUAwkqo1Od2XnTXLagQ6GfWcGi8mAsZXAd0N9mc2suhi0R3fHDGOooR5ITE+uCfonYFJUFJOhFA1ebGPe5k15PbdVHvnk8aWnjJ9TLQwWPB9lwhuGAc+9mXheBLuNG83wD+XFKWPgZE1wWsSMn4xVyFpUYe/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785300818; c=relaxed/simple;
	bh=sMFAAzwuME8O9Q4FkhBViLFDiCHSSEC3uT79oN/b0c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dv3NP2dtuNnSWReYqQkcX5dnRZZ085Nivk1jqYTsIbJmBHmb9k4F5ikQRv6AwnxZRx4WMB41w2J9VFNLiKs64UCqbpcUcMN8tKybZ1YpriH9m3eI8lHyvhH9ikCpePdzYDsbOUMIYO5NQ0pD/yc4Xmak+v/LqIViUxKxGAfTRR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZ1ukyLY; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZ1ukyLY"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso3970a12.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 21:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785300815; cv=none;
        d=google.com; s=arc-20260327;
        b=FYyK22L39Qt0El7EGl5DNCuwbf/4j8Kh6cEz+0V4S+ExU+q/ykBFkvjpqdrtxSvNhf
         TD5IRuEvtyoMpl4AcQQdKR6+Fjvu1mCfsdC74wivvVZoLdhsb95MfeEVt4Upqr9KA9Z8
         12Ei0v2+Qd/yXIqVBTylffqbm8UB4bcEr6CoNwVv5MdmyyI7t5E6/5LG2MGRuN2LEgwv
         dQBchglOoOZIMQlH5dPdLzEtm/dvspZhB7weIN8NzWYMxiUL2wnugGnn09iAyksYbaDf
         iI67YNWONii/znVKMOg4BWAeaw3otdVtHg4zN087gBIbPShsO0q29nksZLJZUeg7tEAo
         2Cqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sMFAAzwuME8O9Q4FkhBViLFDiCHSSEC3uT79oN/b0c0=;
        fh=0HrOzKIyUyvrXH8G6k1da1uuGd7zPMXaiA4Xi9+jpqI=;
        b=bEgYCl8Zy0EwPr8FyGUZ3EqHtwiXr5Y0jZHanMIL9Y9kPdViNZb1m0XTiQDFpcHO8Z
         Ppbf0N//hI2F+EG+u5iNksZIq5qSXsVluo3mbO+vRQ5hPlnx60BhyM9o0fLmswYxXIED
         9FL9/UE9WsJBoOuyfULbZZpetRCz5spT37sAcaVoOxRIX4p+UrU4Yb9tbMFZv8jWEYwl
         2ZQMCOplSfWBoPOnKF+GdHDkeIIzVVhP9gS41VwutqvYZWMksfFKRI2vRtVAodw1YvPm
         DfGah7zGOb67ckLBGyiDslmSYj5WgKwbTD9IjqQrKjhGsGEzDpUPpGpOSSq9WOn+zAH5
         KxlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785300815; x=1785905615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sMFAAzwuME8O9Q4FkhBViLFDiCHSSEC3uT79oN/b0c0=;
        b=wZ1ukyLYghLDCmYoTBv608CPQuSL12R7rR6np7Zq1eA5Gp4X6S8d+HwwRvgzGBuMTy
         syJbQYPJ0yJfTlihtpHN2U2NG30BpogbM5vZKE0VIun7ufKvXoOANQ16nMyzJgTbOHyr
         SMd56SYz2t2spiZka8Py9HL7lpR8/wrPvpXzswpoVZEmc9amRIZqq0n2vKnl9A7JFknQ
         o8qINA+TwD7MjX/EiVwoF15fC6upnPRS3VALFoBnSSM+itidseTWtS4kX8Mmo6+w2fcZ
         xocJz7uK8p/GECSgvZF070pa/kv3Xp/39jfVCctt6HTM8xY0evvyaav0aK54+2RQjCYo
         cVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785300815; x=1785905615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sMFAAzwuME8O9Q4FkhBViLFDiCHSSEC3uT79oN/b0c0=;
        b=flZ4yy20ymxcd6+Y5GxCwKbaS0t/bf/UyHzdqndBH8Cfu9QPDKkzvBeTng6jxIZaGN
         nqdRJcGm/Uu3HA+4SZEPnNpMe+B/ZOQJUNDz8Xvj6+9xc3hsdxZKoNLrVOgCPEdNVWJE
         P55e4FjnRVehdhj6cXerfDLlN08svgpHXDU+o74xgWSRMKolD0uRRlWdY+N6TV5zlZ8v
         Yxoiw6qr6k5RxlH/LGal2kDvMIu5r6tfxSjOa0jItBCRqQ04PrMsaMdY8KMyU9Fd98WB
         nEq1Z7cA/pfUSu7Zp73JuIut2uBuU71RZPk4LS2+N/qCjBVaEXgrLAsK6v8Gthi3/lsB
         TtSA==
X-Forwarded-Encrypted: i=1; AHgh+RqGhZy56fT8dHrwn2XFzBwUyQwRP1DDQty42O7xT2kntVJIkjpGPRK3kTYFE93tHPcpi6WCg7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6aNdqrtQl+qtNVtv/Z4oMLuX54Ug/f+o6Kxm79kmB5l4mJpid
	3Hw5Cc3I93UO0ROMkN2XGp5m93EADWiO3qbbF1HC1ZMVup2o4Snld95P2Aw4lfgq5zbQSOmQyt+
	XNYDmkfPn/RaD4TUmsz2RvzqLi3qyvCDJMkGRfUjZ
X-Gm-Gg: AR+sD10HJt/IeW+935684HCyexSPqEZO0aTFaJH8vJql1M8OKWshINtAUfmMizmGkOk
	rWLzp95l2GXcaYgq1xnNUdYo22fDLMzLycIlVc+dk5yVYjJA/5TUEjDTj1RPMvz0/4RRTEQcIQj
	voe0KyGhi/TDbqT8irenOPjZ8bcd+ujQbrLBbOSfB9b+O+QuklTfNJP/clOY+eMFLFLqArVNdOX
	HmQ73m9+2h0IiU3r0gCw9vBDuQcEYuebObv7INy5aNP0SeU8LP46WhiEUXeuOrvfHla/X36m4MM
	QCDil9WrLk4qMvn4oXSK/EluPoLSxfy4BtSexhGTMAMg
X-Received: by 2002:a05:6402:b2c:b0:696:b77c:ba9a with SMTP id
 4fb4d7f45d1cf-6a063d6224bmr2083a12.1.1785300815153; Tue, 28 Jul 2026 21:53:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org> <20260713180153.2728382-2-yosry@kernel.org>
In-Reply-To: <20260713180153.2728382-2-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 28 Jul 2026 21:53:22 -0700
X-Gm-Features: AUfX_mw5m8sb8VCglMRYjv50guo-4bXpkr1fp75evnF2-aR6x9YqPMGk2ozuZAs
Message-ID: <CALMp9eRhWq+MXj8zax8hS48eZVE031kctfa=SC1ngT31iBtC5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 11:04=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> When handling userspace SREGS writes, check the validity of EFER (i.e.
> allowed bits) before writing the new value of EFER through the
> per-vendor set_efer callbacks. This prevents userspace from writing
> bogus values (e.g. EFER.SVME=3D1 with nested=3D0).
>
> Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
> caps, not guest caps, so it is possible to set EFER bits that are
> supported by KVM but not by the guest CPUID. Potentially allowing
> userspace to set msrs before CPUID.
>
> However, for KVM_SET_SREGS*, check the validity of the set bits against
> both KVM and guest caps. This is consistent with other validity checks
> (e.g. for CR4) that check validity against guest caps, which already
> imposes the need to set CPUID before SREGS.

Where is the requirement to set CPUID before SREGS documented, aside
from this commit message?
