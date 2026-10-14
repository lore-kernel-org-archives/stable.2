Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F38C568533
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001066; cv=pass; b=S1vQw1ESQvw5LN+vBM0cMBzv7PoUmENiLDVQ/Byo7w/KGr6miYFhspiqYW93MxTrfWeym+Iv7VkTTQwsQORRCZq05TlDSj9XkhHZEWP4Bf0y6pMsH/AHEmieTMFCSaZKZJsVuuadZT70Sj3x98ozD0ymFoAIzDHcB/tO8aRWT7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001066; c=relaxed/simple;
	bh=J+h7YdXElMiQCzhKnhtIRfCdNxjHv6XhdIMjoVUG7O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Td9GdZAe0+vbvz0qEHt7S4L22l2JKMbZvwPeGK76QzFaKeJcgUaikn/vdJksKo5JWocWTKZJt3s+aK+W+ZkyeC0hzwr2xN7VoyB+1U5xXfXvMs29SNFrjFHiqTK4MapVhosga0qPyp26+3JGSZ5I4tqyla1ahTuuIlLvHIY2DNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io6KRGbR; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io6KRGbR"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2e4a61f4f7so52126366b.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 11:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792001063; cv=none;
        d=google.com; s=arc-20260327;
        b=cBIc0m9ZzaSFdCKWOkAgB3BCbZ1mujBverFnUp657d0LgbRiAQcBIRsQDj7xhN7z7C
         GdVdzOTTSLvqhPFtz5jSXAUi4iOorNyZX0ZiTyFI/zm2s82P/7ZPLUU1C5+lq2HjVO3p
         ekF/UK4lSfhcG4+kOfZTHAeXCRm5Jd5P4+Uqv1XE3IYkAb5DeaSrPf7D6HVNF+LQ+GGD
         /0XpIXS7rh7/ZZGYIlCgFrEzOOHGKZAJ+9TUvXsleTvCxYavNH+9heo+yXcV2FgXbgel
         L7hv0htrmcBGz9yLaI+klbnT+x8yoEpe7LyxYKU62rqaoe18kS4G59fxhfUCX1JU55Tc
         Q6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fEJjmdOa9f9AfG0wvokXtnQ9GBV6EH86X//DmL/plOI=;
        fh=oy9CHqymW/bY3xX0WoyNPHtKmvlc10A1M1Tuf+8RNug=;
        b=A13gcaa+Z1fN0QAZixfnOVFgBhf2qI5pPFMSeFJiilA50H+/THZ+Nf/PJNE4JCT8u+
         6WwY274MJaGT8zStJQeW0WOJgjrMwyxZHE7qY2O7r9VsrlTGvEBan+iQ2MRPWthsqQmm
         CBsXTY0R3vWQlG9OMHdH2GhCFa08tgWHqeec+/tbDtTYBeHbJuKzv/ABGIQ5GG+vMooY
         DJ43kApDFpNcJJ/aK4xnIgkOSp41PqWfCBELRZKqdXGwvAWdtJNCN6QfmlZ82QQe/NAa
         +nV1nrTjAWTPs1KR+OHOMRfaioXxYTZFsxNLlvp7XcTHZ6stQ5VauXjAKNITGcfsJC72
         EBDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792001063; x=1792605863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fEJjmdOa9f9AfG0wvokXtnQ9GBV6EH86X//DmL/plOI=;
        b=io6KRGbRqryTPXxUULFruYi3qjlA3Yh1FG+eCsD4nJwwGXDLL+Zc20XvdOXT2AyQV5
         E+irR1wuMn5uZ3OzEBxwMSHVFe6mo3kyhj0gqSCu0Q7OW7J3VH2w03AKei1N61mMihB4
         BisMGU//2Rf1SmpxFo38/aKQf89ekpE4VBL0Cor4qG7igucLNSDfuOL5bZLLfw5wXrho
         U0nU1r5/bbSFLYaqT+r36/qsRmDm5YF3e6vhDDgYNlBdL5/pZdWdnvvqMGOsTMuEfnXP
         HQVqk34YudBmKF0YSw8rL5yXYeHjtkx+LXZMxLK3zlqmKsBFe4hkmMVzqeN9c7DXh7lx
         /onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001063; x=1792605863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fEJjmdOa9f9AfG0wvokXtnQ9GBV6EH86X//DmL/plOI=;
        b=abO1bMPsuLp13TPojGSxGvQm1bT68EdURMoo/1tEu0SOdGwG4wewVN+2K4tgeJaiOj
         Tk0ase9jVbsOKKQt0DeANNEcP4yeG5/fjrYOSjM4fI4nbPMRl3s3PFoYSGijGfsyBes/
         3Nt3oDKURNi+HFTFSYjpuWmY4iMprPLdn3VoSG5ZOx0XKP6Lc+T8ZjOxE7RPEiPpAOzz
         oMuo6aQT4SgDmu0tj4VQF+i+tLcg0z+ZKuNfZOISwYmfFATvWuA+GHmSDYwG95hf+3sr
         cHzGNEYD30KoGrARqvHrZAq5VQ7ZQfhNLbr/PXw+44p2zggVUW7EYbZTAmliHLvju4l7
         6G0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwx2SamJbN7sP7O7BtFR7vmY9YyCu4yokpLcfMh3CaHQjeJseNKgFGEgTjN4X5+nt5ZF3WLAzU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZyZvgYabe2DqSKtJFLp86PJWHTpX8wz8HqjnbhknhqtJZSl9D
	/noUhes3riO3kAzmbZF6Me53KFgS1jFvVOWMhpVF1fmudQBK8/TmYy+PqEyagkYZ0jedrE5+B9V
	C5vsD0sN3sQn2dGKrycxTZU4mSo28Qj8=
X-Gm-Gg: AYBFou1U2CqqMTwpFr+CVgWchguIi4NJrJbzIhUReQue+tiKW3m0ZS8QN7DjT1yAJT4
	gZlJBAtXqlOCbuST4LVHQN/31BCezY4eIOZDAoveTiyHQunDlMfa0s354VZv4RJ8OTotdVqZnqp
	s0oyBDcugZcev3qx7AvhvkJn2fvt0KPJGtYTi7OVyV4AMJkepEXKU32yaejtjgejVPD2WksGuVh
	EdvVaN04ROJ1dD/Zf45OxpISMA4s9jamHgmrUwugjhdsthkW2cuhM8qOd723dl3h0h1L2iVZxP5
	VME7FkZxJO1mLsZLqSI0TDDjl9E2gLqvcFPiTecvTkIJvOvtOYm2qYQSck8MvRFpnYhtj6U6dQH
	hIJtbk+U79g34Syzqk8Y=
X-Received: by 2002:a17:907:9720:b0:c2e:e3c:ddf3 with SMTP id
 a640c23a62f3a-c31a9a2d73dmr1892027666b.1.1792001063289; Wed, 14 Oct 2026
 11:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-2-nicoyip.dev@gmail.com> <as9pUYoOmLI2l5oB@kernel.org>
 <as9rFtolVVn0NVD1@kernel.org>
In-Reply-To: <as9rFtolVVn0NVD1@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 15 Oct 2026 02:04:12 +0800
X-Gm-Features: AclHuK-SQplAHNwQy93oHnQprXs6MEsIoHX8-ERaJcQyBiXLt0uOAaw9EhmmAzA
Message-ID: <CAAo+4rVHykh4cvw=wvcZ+6MqehsOi-Foq6f+DjN536pbjj_P0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] keys: Serialize ownership transfers with key accounting
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 7:44=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Oct 14, 2026 at 02:36:53PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Oct 13, 2026 at 05:03:58PM +0800, Chengfeng Ye wrote:
> > > Protecting individual accesses to key->user does not make ownership
> > > transfers atomic with accounting updates. keyctl_chown_key() holds
> > > key->sem, but instantiation is serialized by key_construction_mutex a=
nd
> > > need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown o=
f
> > > an uninstantiated key.
> > >
> > > The instantiated-key count can therefore be charged to the wrong owne=
r:
> > >
> > >   instantiate                       keyctl_chown_key()
> > >   increment old->nikeys
> > >                                     observe KEY_IS_UNINSTANTIATED
> > >                                     skip the nikeys transfer
> > >                                     replace key->user
> > >   mark key instantiated
> >
> >
> > Same here there's another below.
>
> This was also asked last time. Actually last time (since I missed the
> spurious comment), this was the only thing that wask from you.
>
> Br, Jarkko

I'll also try to address the same changelog clarity problem in 2/2 (so
as the spurious comment). Apologies again for the messy changelog.

Best regards,
Chengfeng
