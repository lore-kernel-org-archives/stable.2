Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AA43E073
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291965; cv=pass; b=BXMP58/dnh9MfR5n7yI8LPp9eFzq3Aa/e3koY2RwQtKc7Cpia1pufRmk0U0rRKJfLyKh9E2zpQbJykZLVSmbLS9g1j8qIFrKSmaOYsoVYXDfOsToGNAYH5v0nGLq2aaGyrbxcFu2m7fIrES8t54d54X6m5O+OnC5DPU2kyshP/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291965; c=relaxed/simple;
	bh=EwRdv3H15Lg46ZE4qMWBFPfgUbPXiZ0nu+f7bpsc9EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvI/YGQqVEsEqIcGbFOvioJvGgAWufu8bBDHAWs6I8APejIggqDh7+1gYxhJ7Q3ZLNrFAGJsyUSJJWGqzCjmBACNDteNAWpqb0ElluCz0tlB+4+2KCeFckgGRhDrsQ/3oSI9ZxIEmtPeIkfZaDCz7p4Sye0nEK7iW0cImDXObpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sk3/037p; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sk3/037p"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-499add6348fso495e9.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 12:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788291959; cv=none;
        d=google.com; s=arc-20260327;
        b=syQmzLdI59r3e3YLekLirSKdyZZFYjewt7j+0ZzHcFRxFvJYePyniEVjx1XI+4Kzq4
         7iTPMHVW9o1LLDmB5W7VVkFGpGTHguMz4suNJC8pExi66NPd/18DiOnfvkHtg7zsDe+s
         fDb93Au+Goef7CNyOmwbtCjHxN0LgglCPFqHNv8voZ5l1iXu4OQ0lCN9mmJQe3cl8ikH
         yyV+n7HRyWgJX9NB5nWQkgnEdN3mpH1owlDuzf0JEYb8dqx/wfTxfsnkwz0SIUxs3Hni
         QxwanGmf6wtoK0sq2b+YMcgYwU4479ecxCjxzDbiYzIjtFhBAtwA9z3K4wpvaVcT/zM4
         WWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EwRdv3H15Lg46ZE4qMWBFPfgUbPXiZ0nu+f7bpsc9EY=;
        fh=xb1hf/XkadcTZieeMk2noGzUbLl3Inwwi5gbx0clKns=;
        b=noxm6J5EhtN34fvVdtRQjgjNOdM4LjqPa2nH3p2H1yYQtQtWEjb1O8+cjLTJ7VqqQY
         f2mXlR722LVDNwdy8FyC6QkuKgpZ+1Di5e7vqNQfOQs8223XiuCI1Xw12e5HUJqY/Rlp
         Lg+SoXUF0+eJ1NvSIb1ze53d1ICT9mexOB21T0VYXsR9087RWS7DQkd3hjYZ7XBO7qHK
         quE6d8nsmHyCsNDA2N+vEEq2JXq7FSspFlmhQHDi7FBm88IbqR4Rs2GR7OSi2Khs7DVt
         oBH+/2i/+f8CHZ/eHaS0Z/66/+1gxT4wfPOnflgMiQpi+U/u9HNQHPQB6zGrUBVa0Z5+
         tWTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788291959; x=1788896759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EwRdv3H15Lg46ZE4qMWBFPfgUbPXiZ0nu+f7bpsc9EY=;
        b=sk3/037p1xVFHg27ePnJ4nbrMaH5KBBjVZag9Z5bfDGOpqeqJNhP5JbdVeR7Ipd6mE
         2avpRWJkiDgixErhnZScLzS24YHGzW/cODShGFUVNYBrP4nP95VvOqF6XL+uCVGlMGVM
         Lw27jJr9Le3xEkys/pjileijhD/reyFRyA4uBJQrarrO803TicIh8uPc2plsEeOdiOd3
         FKLAqnlgjyW1+HKO9TZP1s7BuWgSdzwTbpwmHKZj69fhOkKKEWaK6tEl4sl/u9vwfiDR
         FDO/Wea8ff4mwHdQJzKwOsdtnDqmrj4QJAqzBOucMVE0BN0KXZFmN+liSaiMtVwDbpai
         qcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788291959; x=1788896759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwRdv3H15Lg46ZE4qMWBFPfgUbPXiZ0nu+f7bpsc9EY=;
        b=Ju1kWVKBYR6iEz271bnr6pkTAKkBjKosgGkzC1LSoBIdPQsNfamiLjcVb1La1bSrO1
         dboKB3Oz4mkvHsrVxTlh0DmvS4ZMWUpF4h61thP2+4d/kwo3YiCfy2J3mtQHEb22OaUC
         B+HVf2KKLZncvRYJrEG2wbQEY3Xk48i5Enkh1FOZhdvYIhU7JopWtpd8ZO3vGzx7SPYB
         3mIOKGOjuywdzrQOfSL+N/TFRZ9HjrY7XJU8npiRJQau3SYyzvImb1fbdlbtLFpvLz6C
         qTN26um9iET+hXMGdDAE9PjDSdMwglarTzQcHeNeilSYHx1obFJom7sNetz2bDpJS1kM
         ZO7g==
X-Forwarded-Encrypted: i=1; AHgh+RoL+lAkr8kzJTJG5QFMonbZ25wEjR3LQHW7GMnBw4eRfPgJUWNguSLg8SdESRdPKnCsMLuzfN8=@vger.kernel.org
X-Gm-Message-State: AFuF++ncDpebn8zgJwRcSCwWfBpvXjWPxpcQzzcf3ovwgVdcgddoUi1/
	0hhq8rMfyYVDa/mLymCPXj0mv5SVbkI/uDLF6SYYHiAZQQvNlCVsp2VUca6EFw3AXiiKw9DEDNw
	lcVxI+tHI+YGwQbeJOFwptjNSqXPMsZ3S2XUMRStM
X-Gm-Gg: AR+sD10+iTAQFw6Qz+60lwqi1Rt1nf1hBPJVlW70tmMWJCcSoyoXX6bOOprf4rRtp63
	POYIF2DSIaNgyX8AcTNtEv9LX78BsAwGZGUxPRV3tAfLWw9Y/1MZ37ZFgDBbZTgb9amMQ0ZKYu4
	6zKUSvWxQdpYBl8pO641z1vFOeLm7y0D7cOU9qi04R6NTPvsgegZPAjF7kT9h1jlJkumlGg/lUQ
	iLmNWGAkWk4+7Ei5VB9ulKyyU2umijZg0Ky+yX+a3k0hBUwUFXWaxIWmZA51ZiQTryQrx3wyDlH
	H6p3M8ttHNHeYY3+5gJwasOk9T5BJ+VMri9CBclxzzoc+9pJInAOX3OMhjD1A/5sfGoq0RHZtPw
	qFjoqPyKFAqU=
X-Received: by 2002:a05:600c:6050:b0:495:7a0b:3b4a with SMTP id
 5b1f17b1804b1-49ce47dbac0mr115925e9.7.1788291958768; Tue, 01 Sep 2026
 12:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <20260827194508.446733-1-linux@yoavmoshe.com>
 <CAKwvOdkSZBbq=e916=efx8G-CTzZ5b31AhyUytO6eJjjkEdMow@mail.gmail.com>
 <CABCJKuc0cWWdkA7zrCcuze4AE-qTSETuUi-eRewPnn_ivHEADQ@mail.gmail.com>
 <CAKwvOdnA7Ej_uppSL7U2xwxyUQoDMvO+RArj4HCUSOziH0rCqA@mail.gmail.com>
 <CABCJKuezb0HtOcMBsObczS=HBaRvMszagkOZGHyOVbXBqtJi5g@mail.gmail.com> <2bd0c842-d0cb-4ad7-b3a3-fed2000dea83@yoavmoshe.com>
In-Reply-To: <2bd0c842-d0cb-4ad7-b3a3-fed2000dea83@yoavmoshe.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 1 Sep 2026 12:45:21 -0700
X-Gm-Features: AcwNN1Vx40LeKlkhxLn2rqkujAMnERf5APsKIrQ9ivuoQyg-T7s82dgNrM0lw9I
Message-ID: <CABCJKudb5RegHcNPkXG5p1TcCFAe5_8+hqBP-2GyHVK19oB94g@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 9:24=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com> w=
rote:
>
> The sashiko-bot's comment on v5 indeed pointed out that imx5, at91 and
> omap1 might suffer from the same bug: their suspend routines are also
> fncpy()'d into SRAM without a type hash and called indirectly. They're
> all ARM, so asm/linkage.h still seems like the right place for the
> macro.
>
> Do you think these need to be fixed as part of this patch, or as
> follow-ups? I only have my one imx6 device (a Kobo Clara HD), so I'm not
> sure how to test the fixes for the others.

I think separate patches for the others should be fine.

Sami
