Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F078B23B63E
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786313732; cv=none; b=uoLVbpKPN++fvD79VKI+hJkwUYCh2U/S6kZ7XmtzqGCs/cqdvFxotxpIKbL9XBeG3yZfLuOPYLkBGt/ZGoH/vbyL/CX9NLXxN5Z1ogPxQ2IBAd+7uvSieONgF4NSlVW9jtTq4BO4NWOLicX1+8MaP3KKMM5nrV+qjKzDWLuV0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786313732; c=relaxed/simple;
	bh=S9BX78DlPHt8S8INWN4bId3HyR/nFnQd4eQA2gbdEJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lq7SrKxKXNoyAAutsWqVG4VKHkNrL/zQbIqc0Vfj2KtK27TcqI6f1eUikMb6YFPGUsoDtYoKuNdZlRJ7K29iPX5T0Y3SwC/PoZ2+dV0NBWEu4ASC6FYxyjqh9R4SNniRAHztqKcCOZNX8qtIeD4oD9TtJKhLCHkrzie/1Kg7eWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alJpLY4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alJpLY4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9F81F00ACA
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 22:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786313729;
	bh=S9BX78DlPHt8S8INWN4bId3HyR/nFnQd4eQA2gbdEJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=alJpLY4vqBtVvsJ20rrROXR1V2lNUYYMAd/pt4XYILZKuMrQDIKpT0/lh3yypHeRw
	 6IXRP9qzg+iDmho06W3EvNbSOsYhi4g6cYvxBn621aDFqNLSuTbxq247uEKT7atRos
	 G9fmrH3DMUyhlvQqNOrjcC+bqeDbFPeevy4UAKICv5rAQloavQpHQr2Vu1cz8czyf8
	 yonPW3+GfjCo0cAQivRa/wkH7Z1WqCwFovG0C/vrof01C5NnpydYFkUgJEv2SmOdPQ
	 2NBw7O8hvw9xkPSiQPqaYDKjo2n7+QY6KjBygeG8NyPjhZsF5Xe61XQomabpivnCjJ
	 OU74rSF9XKxeg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b159850b16so1037275e87.3
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 15:15:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqqlv8KLYIxfGjh919INfm3tIDQKdMFZxuC1cmtDIbYyN/ZPhbITuYRHXf/PXBajgC3ZZ24+4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAErdYl/CuasA+XrGUkKoKxuTKsqZT+kRQnnACu+kzDzWp1+o
	EDiKEDvs1lXfrm6jf3tdI/3zsY0Qhi5c8/E1yItQAHFpWIuT6vkA542tF23FwfFPeCz1g5Rg5v9
	wzjagftmLmW56c403cbGmaTtTnNnkyfw=
X-Received: by 2002:a05:6512:3257:b0:5b0:165f:17fd with SMTP id
 2adb3069b0e04-5b2f4b885d3mr3739706e87.14.1786313728379; Sun, 09 Aug 2026
 15:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808092634.2734292-1-lgs201920130244@gmail.com>
In-Reply-To: <20260808092634.2734292-1-lgs201920130244@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 10 Aug 2026 00:15:16 +0200
X-Gmail-Original-Message-ID: <CAD++jLkcpHW-YKscKfMYRdD_T483jcUBYjz4gbP3EbV0fVLATg@mail.gmail.com>
X-Gm-Features: AUfX_mxLzMOnoTQp5mJwejOlPlhyNTugg8h4U8BlsHNCbaahLgre1Sqq4KSyD6U
Message-ID: <CAD++jLkcpHW-YKscKfMYRdD_T483jcUBYjz4gbP3EbV0fVLATg@mail.gmail.com>
Subject: Re: [PATCH] crypto: sl3516: fix autosuspend cleanup during teardown
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Corentin Labbe <clabbe@baylibre.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 11:26=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:

> sl3516_ce_pm_init() calls pm_runtime_use_autosuspend(), but the
> autosuspend setting is not undone if pm_runtime_set_suspended() fails
> or when runtime PM is later torn down by sl3516_ce_pm_exit().
>
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during cleanup, this reference is not dropped and usage_count remains
> unbalanced.
>
> Undo the autosuspend setting when pm_runtime_set_suspended() fails and
> in sl3516_ce_pm_exit() before disabling runtime PM.
>
> This issue was found by manual code inspection.
>
> Fixes: 46c5338db7bd ("crypto: sl3516 - Add sl3516 crypto engine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Looks right to me!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
