Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B894411F80
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766246; cv=pass; b=bHjCUMDwnXovIWrijQkbITpX1yPePrITlbD5WiAyy3pozp3UtbDVHQ+bF0SIiayv93gN9NJ6dV7bdsX6WsmE4TNHKx3fykJAmlbeeJVmOBM3+CyBFlaWuTO7MKYmGudm2fxfKB5XS+N+zi4Qp69P8EoiHLmlall0QLKAAtIBpTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766246; c=relaxed/simple;
	bh=ws1lt2A9wuTY0mZ//UjpSJvqUAKan2kCqa9w0DLo52c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K81fd7YQbNYgb5ec+6LjJ/XV/yx4uYJR4YJ7QPEJqMGSH0rCd+XipCx0BO27lj43fu6sAENvh44QMNrziw6gTmG5BlCkylkqUmXcpx7UJoMfePkAkJicU9HM2YMTG9Jvy5cDkvRgI1Xbizkrl7XUzI1P3dOo9PYn20crAflnPMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=r2xJc220; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="r2xJc220"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a1f628b0afso23110651fa.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 00:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788766242; cv=none;
        d=google.com; s=arc-20260327;
        b=T99v8Ktlqukm139BA6MjZvEULVUqwXsgPaC/aR1nhUL29x0R9l8uXWc0zF6aeQ7uxe
         VYM3l5ZVV6lG9+fQ1T/wnBVQaqs8T0DypgHJ3Oc/eFP34csWO7h7swmMomkU0V/sTdoq
         xxmUsYgH/2anqZv01Jmykpr/1/x9fu2JoMSm2GhaljT/FcQLPOqpMf3f5eYYFLPumdkB
         TJ2cF+TDE5bmcMsxQzEX0tdyOuyQbp3B04XofiKEwrKr2lTs5MXg9Sv+Lzn3lIAMT8r9
         OxCvYuXj8x1PZtGveuF5HfXbzLF7PrWZ+XnkV8UP6YVo1LaAbJZdbo2Usr3FlWqgSGAt
         J7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K8pzZlzdqRIT/RWxSl/nFSJH5gf6fu3+T1v+V4JsYz8=;
        fh=fXq3cXaGkzQ9jzwVrUZ8eLY+YupAYQJ0Ry62Hfjnky0=;
        b=IG3QZMDdZ621CkkhUJzooi8Gs4hZQc0Vk+COKkh2S5hbq62vHWr9OvfTm3sG2iBcgu
         /ztPME1wD8G3mJfFipp2CP6gE0EmaNE0dXDYPytcxMVkGc++kD5TUTsMELcBqtLoaNjP
         HAn1ckBlADaaP1D1ghxnK/PArR2h4XGH1q4761oqV8DjJoIIhHDmcsqGAbUYMmRuEYDe
         Q7xfWVVIZ86l9TKx3k0LhExp0m3n2tKZ1sIS8UZ9Io3Rvf6bM6k1cxYfI0uVtpdcTTRw
         LIRaukj71n4OPXU5Y593mPekFqWbO1+Ed0G8tYPifA2slfv4fEfNN3A8LUv/XIq0h6VS
         2ERQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788766242; x=1789371042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K8pzZlzdqRIT/RWxSl/nFSJH5gf6fu3+T1v+V4JsYz8=;
        b=r2xJc220Zc65Y7W2MaMaq3YAsTrjViOVCgIePlgRrEVuKOUCWhaobo2ZN7lFvrwJmH
         jwhgA2Ey/xrqrDsX0hTrSZArRxWNUbTJ1BBoXFDAuqPVGWS3uzGaKwJtrj/Q46uRMssS
         o1MQx7lWWvmkB+Y5OpNmQAepBU7XbVWnx3dk+9NRACPts7fAe4ufO3sOWgfakB6qSATi
         BRw1VEHwqp+x4iOmusvYYb8A47gpu6ssJcKBZyybXPBYZQ2Kj63vfBr+ZkF2Or4l2THO
         Q/7Q/eobjosfi0XLUIJxdEXDoTfrjgRLmSfIZn8te4/DI2fK1mfOnuavwXgBtxjZX36d
         suxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788766242; x=1789371042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8pzZlzdqRIT/RWxSl/nFSJH5gf6fu3+T1v+V4JsYz8=;
        b=JV5LmNfQuHdqaWS+aBda1MQzqYHV6JKI5RSgUCbc4IMBC+QC4t3Z7laZf4zOuQIt/T
         IIdJfJlcjBBSVX4gpswA18x6YZFY2qzhYp1SKAtziIxAulVnNhUDdOLQYkmZKHcAf3ph
         cztRcHtgNJqc5TjFURvuqpjr2R7uGwt1d76lB3zf8c877iA2kIZYyktx86Fla6RPw4gc
         23ZSNdDb9SeaeqHKXaqD2dJdtLq4N7M3NY67cat7hbwzwZlEzE1CnzSolsi26WA2RvCK
         XSz3JAnsGc/JupjBno+Gt6q3oH57tB0/j3PHqeah/RDEKtpPwjlX6ahSWw1nyoZ4/WeC
         nn5g==
X-Forwarded-Encrypted: i=1; AKwUvBwUn9kde9YDrtEeZb7/IvE349wwvUI5FvRRw4DXTnyTqP11S5Y7DN17CWCjdZOs066DicUZY9o=@vger.kernel.org
X-Gm-Message-State: AFuF++ndh5Y0vXHYNTCGEqA2mpSgsxk0xzOaq5FaIS1BNdZXljKeROz2
	2wWKIFZYkqcWRxcVUkMnE5+IKFlrkkKeRMbihNmoyIH+mRHENfCBDrB+Xk6kHmAzyl1aVlqqOJw
	Hk4Jh0ZDfIKdokdbqysKiLGawEr3X/Sb8TDyW1dU+aTg=
X-Gm-Gg: AYBFou0yJriVdyBAyuXAqZ8ayuXMFKCHsPoU3tvEuYU5oSDO9VW8vMKO2ZtaqWMEOMf
	oPqOLkK/2FHWAnQW4N9W6z1qS0oEB5NmoDSVZta/0ycOHVnAu6b3ayzeyo1D5+Cwbqp60hbblYP
	2kCvUOuD0ocy79gy/DHRBvPnD06cYWnPXJjk8dXo8WLMV/glfDimlFBXk+wIU5xpkrt8MrcgF7s
	THf/aHOtbmzUKBHiY2EB1j1EWflqxrwNzFWsH11r/AsGftIwzvevLXJ7tnLpUzyy1dAtqEOIeHq
	Tzm026WVwLI9olCmQ++gFAUvIfIbZoYG44ODNSqKxn8QmtDBp4U/pWBEWe3WszV7H/1qO/Py3Qs
	=
X-Received: by 2002:a2e:be1e:0:b0:3a3:314d:1169 with SMTP id
 38308e7fff4ca-3a371b39b13mr25408981fa.1.1788766242436; Mon, 07 Sep 2026
 00:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788668475.git.zihanx@nebusec.ai> <e8782427d0b3cd1854ab8d141eea224b53db55b9.1788668475.git.zihanx@nebusec.ai>
 <CANn89iKdX2-a+VhWa4CyDODSZByk=r5VRq38yQhLYBFRQ1Wy3A@mail.gmail.com>
In-Reply-To: <CANn89iKdX2-a+VhWa4CyDODSZByk=r5VRq38yQhLYBFRQ1Wy3A@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 15:30:30 +0800
X-Gm-Features: AcwNN1VDHzbFiSzp25pLBVGEmL8dzveakPy4WZ3YZpO1QfoeCh76H4bfuzwlclo
Message-ID: <CAANe3eQpztNQF_e0qHXxAr+GM39tUdU0FS=1kO0h5LY+v-iVGw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] udp: diag: bound bucket lock hold time
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Pavel Emelyanov <xemul@parallels.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:07=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Sun, Sep 6, 2026 at 12:35=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrot=
e:
> >
> > udp_diag_dump() currently keeps the UDP hash bucket spinlock held while
> > running the request's bytecode filter and filling a netlink response fo=
r
> > every socket in the bucket.  A large filter and a heavily populated buc=
ket
> > can therefore keep bottom halves disabled for an attacker-scaled amount=
 of
> > time.
> >
> > Collect at most SKARR_SZ matching sockets under the bucket lock, taking=
 a
> > reference for each socket, then run the filter and fill the response af=
ter
> > releasing the lock.  Resume with the existing (slot, s_num) dump state =
so
> > the next batch can skip already-walked sockets.  Leave bytecode filteri=
ng
> > until after unlock; unlike tcp_diag, a rejecting inet_diag bytecode pro=
gram
> > is the expensive part of this walk.
> >
> > Fixes: b6d640c2286d ("udp_diag: Implement the dump-all functionality")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> > changes in v2:
> >   - Drop the hash-list cursor, dump_done callback, extra module
> >     reference, and inet_diag core changes.  Dump state is only
> >     (slot, s_num), so the existing handler get/put around dump() is
> >     enough and udp_diag no longer manages its own module lifetime.
> >   - Batch at most SKARR_SZ matching sockets under the bucket lock
> >     like tcp_diag, and run bytecode filtering plus netlink fill after
> >     unlock.
> >   - v1 Link: https://lore.kernel.org/all/133b6aee9e2c908c9da37d5585b3d2=
cd016906cd.1788187473.git.zihanx@nebusec.ai
>
> pw-bot: rejected
>
> Please limit the complexity of filters.
>
> Anywone needing complex filters will implement them in user space.

Agreed.  v2 tried to make the dump walk tolerate large bytecode;
that was the wrong approach.

I will drop this patch and send a new series that rejects oversized
programs in inet_diag_bc_audit().  Richer matching can stay in
userspace.
