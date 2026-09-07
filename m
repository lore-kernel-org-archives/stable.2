Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574683375C3
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766905; cv=pass; b=i95kYoxBGx6V74WsKBCNCs6ek2A0iLTNw9YsvUPLj139quziUumBmaZewjw+IfkdZgOvhQ6ESmiDuDoAZMujrEY5Kx7jt9XG6V9niBloKm/VxhRUk0uVzHMApwJk4AMSSmB9E4g0UBieE6CFLhfeh7SzAizhnd3juoCg7goGQGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766905; c=relaxed/simple;
	bh=QKjvgmeZzGEaOpz3gNTV5TQ4+j80gPA1r1+NsciZfkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIAOnX64UW/HhGZ57CZOdfTPcVHMO6yQGTyVWyxMTXiVK1LaSlagL3yO1BScqAxBMh3JKBDngmYignvvUVEhTpyb+I7BnH8gGfBtDPLaBVpSYYQXZD2i/Y84bPwImQzPGdlT0kGNb41FhxgzQ2EYA7E6AbvlsS33VM1uH8yRgQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=tE1VOsdn; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="tE1VOsdn"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a2e985245eso22332561fa.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 00:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788766901; cv=none;
        d=google.com; s=arc-20260327;
        b=GTQWo89ggUZ8sADClXkeO0nENdDSl3qorFXtIIec5XUbuZHrDMtt31Y5PSlonAtB9y
         Pvj+XsXNx3o8fI+dGLqEyVA26vSpP9rCuJ2loyycgmimMyfVDDwdKuMw3P3Tj2KAePUM
         qKXj+cDAFN+nEi51hVmPETjsBcqQs4n+YYApbhw3vA/O8VYnKcMVA6ycNsQs8HjDkb36
         ZszXjK21M4LHj1tYJk6NXOModZu6L+KB4bh8tsgN4v7nF0EKKi5YGlsVEcnyOW5DJMjD
         dpdgISFDcTKg01/rOEr3MEyCKsyEZDyKyeJYPaRfQSHCUeDfT9cm9A5rjn7GrhoTrgzA
         vwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BH9WMir8rF2hqn5Htua6dfyRLLaHMRp/CMdHgEBBKQA=;
        fh=zyE2rMJAQ/4ylgohWdbSD2b2hvxlr7tgIz7DAj8QgEw=;
        b=TNTj+MeCM/YFJkSPwhtRx+YP0sTF3VA/hPLWPHIWGjiHC+gXCcUknnmdISEp1FSYIB
         +OUIlpw0m+klHWJEZtYVhkHehkX2hwhr00H8jfvuxZBsuWNUaU/TdxvGZmuP01KXfhb1
         vVfzXrx7QVDf4Ua8PDj2JsSIIOpMF5RIqAG7CepUaF3l4vYYK1NW8SlEurNLHttpwvpQ
         6f2G6qEwImWxY1vZyK5WIyedWCnNhoHZZCy7KIniHAlyR4Zmzvq/G30CTMrA6B7WRsgc
         o7xRIu8IaN5hcGC3U5op01ZsznVmsajcIjqkfaoVdsUYeECnUBJFH3bqhwEL/s12j/aM
         VosQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788766901; x=1789371701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BH9WMir8rF2hqn5Htua6dfyRLLaHMRp/CMdHgEBBKQA=;
        b=tE1VOsdn0HBsn78ZbWEqbsgTuwQ3F1SMSe/52v0opUisM8ohTsP2QouD/nMe+q9U6B
         GTAtfx07P5cLiUH4o9Cb9Rj8D4kSvIxxWBvqFrEt2s+sQ//fQuaQueokxj8yK4J5iFJL
         2+4iZUo/7XZ2Eqvao+FuRRrEShLphXqC9w33yyweTMm0SoF9lNQUXW1/QU/BmfzCIfD+
         T4Bcta3UBDR1ELd3CARFsvVuc7DDZW2BwJ3Q5PHGsUbQYI/lhmGuZE6urcaKRkD4QMOo
         p9OxDdk5I300G/QQcUzGC649IEgk9t25h0behUz5PTiaqut1lZ4OSZCseTI05LEq8w0v
         xiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788766901; x=1789371701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BH9WMir8rF2hqn5Htua6dfyRLLaHMRp/CMdHgEBBKQA=;
        b=TjH7ZdccSOnFUJySTzuWAL5ZX/0fOwO5/OyYUdFk64tlRRAtibQsh0PgCK4qeqlhYu
         OCK3CnKvwo/5fZYpHMH48hpW4L4/AFJ+SgtdaRAKIPmrvS36lQfb2hBrSt9odd7O8kye
         mI+oinGF2j+4XjJOuvkmpOECorqmTnuENwBraqga4B9W6PqcixvjYW6ZG9jPpj67178+
         Qq5LzmRyCCAGSyngPUyqRoo9XKouCqDiU78PIHQfPNv3quuKTFP+g27QAEJvPgLe6Cad
         krKf4lzyacQvDZtmcQNs1X31rsjTg14oIABbQCk1OQhFvJb0oX61Ybd1J/wi7oDtdWE+
         d0tg==
X-Forwarded-Encrypted: i=1; AKwUvByoGo5+gg/SOzFYhCDY7jfs3GnvotMiBeTKAYDdqyGM03O0dpq3ZdWxQFNQSq5Ec7lsl1o3R0o=@vger.kernel.org
X-Gm-Message-State: AFuF++kzy5OqbOnjhxgmxkfc/YX0LZAD6vKRsHh8YsBsYXKSgND5/Hs8
	fBSpyHcNO5nTclunjuvrEqHN0tFHlvs1EtJXK6h2PK95m71dSoG3kzql3Iy2ARhBlGxCVb7tSUs
	EwOHOXwgUCkZXTiCaO7wySahR9HbzJYS4r/R6pvL059U=
X-Gm-Gg: AYBFou0DjNdAf57bHddV+yd4LFZkxBJjQo2GtzI9vydUmx8F1RjHfZuZIUgZaoB/Plf
	O8c1DVpvNoiD/54knHRECbgTaWmTODYaTf+FY6rV25k2mEfs4gzvxOy2XG4k5hLB/Q6T0+kB1oA
	rNZ6+eQds4PgU1mDMT0KIZ2/2adh0XPsVp3DoxH4ihGknScjAJq3cvIXk+1a7oSYEANXOJTz4xw
	G64Bn3uwNqYnm2BM7vm7tpmi1pdMcJCNTp2xIvg0hLYSEC5DrGyDvixQAa/iW01Fpv0MIuDcrdh
	NS1x1vUfmS8GcNGRtisJlJlkg79Q3dbNnHqXqkRqudUa8j6VRVdEsIHs8fleBFpfT/YHfIiyKoA
	=
X-Received: by 2002:a05:651c:15c1:20b0:3a2:fda9:34fd with SMTP id
 38308e7fff4ca-3a371bb4496mr14915881fa.9.1788766901322; Mon, 07 Sep 2026
 00:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
 <178875495405.219967.5594821749566554418@kernel.org> <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
 <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com> <CAANe3eR=sQeTRNuewiqo0ZFwS6fk=HtxvT6TMGhq8F5Pqdxovg@mail.gmail.com>
In-Reply-To: <CAANe3eR=sQeTRNuewiqo0ZFwS6fk=HtxvT6TMGhq8F5Pqdxovg@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 15:41:27 +0800
X-Gm-Features: AcwNN1VzGJxnqabKgTDT5QXQvwkk_pkpIGT7iWj3PbbALy5PgIuN8fmhJFOeJSY
Message-ID: <CAANe3eSbySUA=RreUvFxBaE4xFp5Ob1uapgFn86UYO4J8WuXzA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:15=E2=80=AFPM zihan xi <zihanx@nebusec.ai> wrote:
>
> On Mon, Sep 7, 2026 at 3:06=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > > - bind cursor UAF / dangling tb2: valid
> > > - unconditional sock_hold() on unpublished TIME_WAIT: valid
> > > - clearing s_num on cursor mismatch: valid
> > > - lockless cursor-membership checks: valid as a concern
> > > - commit message overstating bind/ehash fill-under-lock: valid
> > > - missing note that MPTCP needs the follow-up patch: valid as a
> > >   backport note
> > > - endless re-scan of the same bucket head: not valid as a
> > >   guaranteed livelock; duplicate output after a rejected cursor
> > >   is valid
> >
> > I just saw your patch today. This is absolutely insane.
> >
> > Please limit the complexity of a filter to something reasonable.
> > Absolutely no sane user is using a very complex filter.
> >
> > Same for UDP.
>
> Thanks for the feedback.
>
> We will drop the dump-cursor rewrite.
>
> A follow-up can cap inet_diag bytecode complexity in
> inet_diag_bc_audit() so TCP, UDP and MPTCP dumps share the same limit.
>
> Please let me know if that is the direction you want.

To be clear, this series is dropped. I will send the bytecode cap
as a new series.
