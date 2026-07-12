Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E63367F4A
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783824253; cv=pass; b=LrPX6G9dmrr44W/h1I1KDnyPMKcN0AqtDwy/YF/5gjrBV0eCfhuCV2YihNmRFY0XE23Ji0ksThbVOk0hsiCYhTd3fa5n2yamponfvIWc2AdUW/0WPRiTTXmCUk2eMtUiHABAKnVCvsqaBU7VYDVaYDE6VHMiQDh5ScrPsxEnUPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783824253; c=relaxed/simple;
	bh=VpNyuXu6TnU4VubVPyoSf475P8tqAr0gyIf4yhpsNF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S79R3HO2JddYpe60sc4uRh7qRPFB+i5L0INOkZ8ghQXd5zzvrfm7Q7omT/bAB/5AIDxSTawRgmmJGVotb97WvPuMfGoKRUuD2QW7j+5oX8XkzVa4g2HAIuAdf1Tl2tZJ9+jn4GfuwG5U+it8bKCyX6UfMlesorWJq6gFGxirz5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfRWUlvg; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfRWUlvg"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8eefd4a8057so25081166d6.0
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 19:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783824251; cv=none;
        d=google.com; s=arc-20260327;
        b=IMaxQJrrEGEg0DRF9W3QWA1IXAXZ0hp3duTShvWMirP8blAY7/EG9wIjoYHgxbZtzA
         rtyUvnv8lXTO/12rWXQEjG5kif+Zzq0Z/Uca3fSK2CAa4yaNQOnhFpw0QszqrTnuSLtk
         uHOeS+0GFwerBG/2d2eay3mwwfkt0myhSQBgLPbw9IkFp6qY/iIuTk1yIcY27+T2dilC
         BNbpBoX1BIpDKqnJnyJg4mjZR4dIMgwf70PPc/gRWlbaxGTw/fAc5IJxOiIo5OSLxr1+
         WLdn5y9O4nPzDjhYDvXO41WsDC8BE9oWoPPXisIGseduNpxZEIqYaDcFfyU1qC7vmpD2
         9opA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uSPbXXuWQiFm+lkWUPjIwu/3EBZIFqc/5MozDdOJ2rc=;
        fh=VeyWvsWMW4UGVtkkMoC1CGb5j0bp/HvAYivj7MDkuVU=;
        b=mNpCB6xzAGoZO5nXFicYjUym7f3MwBqYvXlw6q2Y0eIvoIolXPx9GgTJZv/jGill9S
         Ukuw8i3D1+YAvi7HF0MPWlupo0XGabyB1TZFqLRtn8TUkm7ehB3O0RRVUKS1aoBkeThJ
         7swihrfaNGMKo0fLu1NdzwlrvNm5LmVSGfMqeYsgudMfTBF4a36l62w9IiaI7YzBSZmg
         ar7euj4b5AZB+zF0py+N5ad4Dp+oRTgJoT9Nmo8sHL9gukLz5attOIJqRs+Rv/aNVmaz
         0vsY+arH/RFuKPmZ2H34z5h3hPH3OWneFGf9Aoq9Z3iyrH5n6Gc7QaJdyUQODG+kKbO7
         gdlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783824251; x=1784429051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uSPbXXuWQiFm+lkWUPjIwu/3EBZIFqc/5MozDdOJ2rc=;
        b=hfRWUlvgWVxBd36vJCJ3nPy23IDhuPwZmv8saHCytcRj8gDHvG1RhAiZlrE4TyBFUv
         w5S4YzLQEJ/nbrrA05BjoK3bTLKfYyf8Wc7fhU0hJjKpjn4aqLaGUwZiyRqew0N6DGIy
         PeMBEdbbzDpG3871PtHZljpdNazbQrY1HMJnXWAKsTmmxm4qtd2YV3dkg+oR3qcAgLBT
         h3VSpRDWjMDfnuDBQ5NsOADkL0hT+LaNR4HE9hKEsLVlT4/WawUTFIlyViiYCDGGFHHr
         509ZQKZeIfOFs8EGujHecoylLykD1raEGtuRYnLrZxC2wSpKlDnPv8UnTSpekJwZOSxg
         MQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783824251; x=1784429051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uSPbXXuWQiFm+lkWUPjIwu/3EBZIFqc/5MozDdOJ2rc=;
        b=lbfVzrQsCwd36t0x63Y6vvgzdopJsJ8qFPzGxbWPcljh7vWv5e6RgaZ5FPt0V0ttiP
         gp3yuJacOE3GnY86txYnQ6bvl3xiCpgYlBaehEmBuWtnqe7GMQ75G+Tp2kDZ7cO8OGrc
         3qeoIbJwGgziDw++oZAqNSqe8q+Bd2vUdaUEvKWMMPkB+3ZAWiG/wpHD3j4qUrrgJhde
         nJJSOIaOhmIeRiiOZtaEo97Wh+bk4Yc7FLkPdd6IzO6n93YaZ/Jkk5xGqVOgTeipknTN
         rblCNEjm7fQPEZ6zNVI1dPDyt8MjwAqT/Qapo243gzMUD6LN0Fj6C+2gjGLKrfaTWyVb
         Exfw==
X-Forwarded-Encrypted: i=1; AHgh+RpWS6IHE9GZD9+U2sWLk/U08iPc26/+bOpzhbfdW+dWiyjX/aXWk2GOQtAHLxEWLnwRvedBmF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeoLrhtZFtVkM1F0YwtcXoF4CtHr8/ga5XLZLJAS4Q3XuB4j/
	z/7hs166s3p5cKADN/W53awJCh/jwG0V83AYSjkfOoBb2IRBigar0G/EzwR1ig9PHG8bC2mkOVr
	S5rAFkzqy1q+gEFLi7srOLu0sG3q7M+Y=
X-Gm-Gg: AfdE7ckYiK8ppOxNbNZCaX9Ufykcn7juYNXhTmgnblW+FEOLvFmPwUnE2JgH9cz/Sgj
	pIMCgo/9Nt3ae3e0Li+UfzapdRdLfgntqzhx6l1Ub0XQuYLpvDbVwi5qDZPfIQ2oDWir+ime1/O
	rfAhMpCayn9HbOOxAvKGoCDwmPkNCLzcaN7m238H6ZMCFMZmVOA/SYA7a7uS6WOcoPcqq05/7/F
	C2U9vD+Dvi3n2C79lmzlggGNflA6AJzmJ0NRy1P9gqj6EyAcEikOl21VwxSFzHF6YOt9/1pSQSQ
	Lsfb4w==
X-Received: by 2002:a05:6214:459f:b0:8ee:88fc:e0ba with SMTP id
 6a1803df08f44-90400b8395dmr63724626d6.6.1783824251374; Sat, 11 Jul 2026
 19:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705220112.2522-2-muhammetkaankilinc@gmail.com> <20260706135124.draft-0003@kernel.org>
In-Reply-To: <20260706135124.draft-0003@kernel.org>
From: =?UTF-8?B?TXVoYW1tZXQgS2FhbiBLxLFsxLFuw6c=?= <muhammetkaankilinc@gmail.com>
Date: Sun, 12 Jul 2026 05:43:59 +0300
X-Gm-Features: AUfX_mwsFjJKYmNHgJtNJGbvZnqB1zcgYKZqP7pXckm3QbfUyRNP4WT7_Ct4gZ8
Message-ID: <CAAGBmJG-bt2vrKKArWKbGAe7G9U4etkaKnUgV50UTVB-To0bXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] crypto: algif_skcipher - snapshot IV for async
 skcipher requests
To: Sasha Levin <sashal@kernel.org>
Cc: herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review, Sasha.

v2 addresses both points:

- The snapshot is now limited to the AIO branch; the sync path passes
  ctx->iv directly.

- On the writeback: I initially implemented it in the completion
  callback, but that requires lock_sock() there, and the callback can
  run in softirq/atomic context on hardware skcipher backends -- a
  sleeping-in-atomic bug. Rather than convert the ctx->iv serialization
  to a spinlock (too invasive for stable), v2 follows the aead sibling
  5aa58c3a572b and drops the writeback entirely. Implicit back-to-back
  AIO IV chaining is therefore not preserved; callers set the IV
  explicitly per request. MSG_MORE chaining is unaffected (carried by
  ctx->state, untouched).

v2: https://lore.kernel.org/linux-crypto/20260712022618.1665-2-muhammetkaan=
kilinc@gmail.com

Thanks,
Kaan


On Mon, Jul 6, 2026 at 5:08=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> > The AIO/async path in skcipher_recvmsg() passes the socket-wide
> > ctx->iv directly into the skcipher request. After io_submit() the
> > socket lock is dropped and the request is processed asynchronously
> > by a worker (e.g. cryptd), which dereferences ctx->iv only later.
>
> The race looks real, but the snapshot here is taken for synchronous
> requests too, and the updated IV is never written back to ctx->iv.
> That breaks implicit IV chaining across MSG_MORE fragments and
> back-to-back operations for cbc/ctr on a path that has no race to
> begin with.
>
> --
> Thanks,
> Sasha
