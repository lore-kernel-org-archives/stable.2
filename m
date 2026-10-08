Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC14AEBC7
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487784; cv=pass; b=k1PcMbno3x1YSn1zMLxvxpTusRiy6cqkftiHhUsTBmGMiETLmNQJjxF9NEwcQdkihXSBq2MDNui/Az1nCL4gTG/dCqRksCb6sw5a9ysweLSQreY+x3BmS5vnXvAjUanvtq2NjBdiXKnu+Sjn2G99CV46IPna1KhoYJ04cNdEByM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487784; c=relaxed/simple;
	bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4Gd7jR6lJDo0OZjdMX6BVjq5ehMZ9cx3IQcgCvL26xT/YdsOJojumS2CcERX/APLzYiulnKpdr2VxSYiX2rYb81GT6RSb0oS6qmbyqP/y+AFb4fJJmR0T9zsHLn7OI696AogIBfVuCvFIfj2z8aoT86+7vCqlMdx7C8MWgRpyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn6s8tb1; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn6s8tb1"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a1eb6fa0f4so34672561fa.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791487781; cv=none;
        d=google.com; s=arc-20260327;
        b=C8I/TZbRlkYlAQ9Q8ysBIORrjwZtZIM1sCWJPh0gfLx9lnj0GIIQWAeveSXSRXeuwG
         GPstK3ot+7WFwZ2yNQadbJ7GbghUnj3ATSJ2HAdV5k0tTjeCFw0fXHupOcwgM3pnZvxg
         3s6iklAgedxeRLiCi0E5pH0bstLkmchGmBjBy+RndVx/8dCiJBSe7+fPPHe4QHRsPnjZ
         Oa1NGs3l89re8EMr/isEnN5Xd7lsQhtjXw1CA6HqzDxEMFTmLDfmo07L4/Oz1ZJDAOnZ
         K91UpFoV1sBjuv0Q9mbsfreD8+2Gziuj5xP0yMSoljN+b6NuDvqXbuOR8qCcf92cJBFm
         oy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        fh=UrBOTQTS/4ukuXBQ7H047JiswT1u3hX9/oVcYBdB8vc=;
        b=PCjiZDTPowMYsrjksB9hsqK5CBoodt4PWz4fyLxAvjzRozuizDrAK1+w+2R03YCWfX
         9h+kpfLeXZKSDirtTqMkFlSz3ejPiyaoSryIvRkiR8FbVXg/VWUZRsTAttxmcWEXPSK0
         yx65FO3nF1WY7/mZ+cjHhHTSjFaH5s0O6ppOZVs0JVMc2IbIm8Gi50IsN3CWJszIjsuh
         qBsMfDo6yI5zzyQHGt4AOG+9O6qKqIJRB8TNZJre/ncI1wwiYD4Pem5rfEIbS8CJnY1x
         p+zyBVXfg88KGjfzIJ2S0dSZx5Xe7nwPPnrRpxjgGSp1G0oYgSoX0Q0f7LeyCYvFSSe0
         yi9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791487781; x=1792092581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        b=Wn6s8tb1eiVxlv5gZBq8iT3KJpGjQLvnTO/AHZIgEXjIZG+Lhz3cBxz9g6pMTSivp0
         wtTeLJOmaAiPJSlSQOd9Ej4zOx0wKZ4ym1gMaPC+5iNC/XwmE9do2x1yWrR0ZsT3WHTh
         w+VsM0qSr/2GWJx1SzOM6Eby6osj7AxkURxNuREKFU3Ova6vf++oZ9+etNFhyam1NALj
         Od2bQ1cx/eFsFP3UDnGod8REDTBpuxc5k3J6frNul3JoTNVqwgWMjVadxVY7lHJthEaH
         ilc/QMDjwZp2s7n7giziRaMUj+76BvUF4Ofor4aLNHTC8T1qC9C6ChFjGbX5KO1AgKQ0
         k8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487781; x=1792092581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        b=fZzTsOJU082PgGyllqlFQFFJDH7Wg4yUPbhlEGUYy8TYJbrfuLzozkfa0TMRDnUNCX
         qD9XX7kYv2k4C+S8ezQAotWgn7p/Wvv+fCQfKetf+ejQAgqeRbJtbpZAMkiz9Ue0GFfR
         hVtsq/KPECrBMFoNqBKfpUCNbw7iwHnvy20ovx3M40wz0z7O/gzK0XcbhT0CtqeBb2/J
         KP6GqjCLtZjwAt+H6PjVSzt++cke2D1FbllE+UPfz7T8dEZtXENZerCOrQ6N4gSnL0Ux
         Bgwd5uzAXphMPDTSzb8Sv39wvq5yD6CCVYtYMElsW99v7FSHN+WXeCJOJ5NyKcokhlYy
         KNRw==
X-Forwarded-Encrypted: i=1; AKwUvByeUPKARocNdioExmgY9hjN4/o2YuW/ZFuSTm0jejlUIhPKn/DfgtQyVQNnQxZc5e5bSQOD4fs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9yovlM3McmFuRC3bMiKOf+34OAPzUlAaQpnWaLE00NNgzoq03
	5NlRzdhzSmMHbjdfWDAVngCxwkgHdvkWA4ZsfK9hVO+kgnrfi6mbx+u4AeUIdVlG1DEEXg9lrh8
	q/RCuGhO0Zd511lJ7Xi4ZzgRUkcaFZAI=
X-Gm-Gg: AYBFou2+UlNOt/FZrFscbhc2hQhAMDgMlwYY5CNVacK5hOyLP7uiM0L3L03rim71uXO
	7+JQbyZ/iZyL9muZs1//VZw5dFrI263PxyLdOAMCSsSaGm2l+mPNLa1rfK44+4W5zImCMl/h+kw
	4kZJFAfVe2EbNkGes6tD/DjFOqxz/GmHJHTgUo4ZsKEgSCyLtNuAzJvhY5F0T1jCZgC7MH+b7yp
	Rv/Ihsp/WUf/aCUGFIJAlLU8xzWj0iEX/nTJVEkl4YXbpBm8J/OhZKyPGVNapXDpyY6v+KQ8hUg
	oBNWiz8lIpNPWfeESobk0PyObOXr4M3oRvHXeNFh012eq9Fwm7FOLKymB1nSGkq5yu0OkfISirP
	ba6RAz+yVmBVbUw==
X-Received: by 2002:a05:651c:15c4:20b0:3a6:58fb:8540 with SMTP id
 38308e7fff4ca-3a9c2a6f0d9mr491601fa.19.1791487780457; Thu, 08 Oct 2026
 12:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
 <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com>
 <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com> <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
In-Reply-To: <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 8 Oct 2026 15:29:27 -0400
X-Gm-Features: AclHuK-YAox1Xf7NjC5L8Z-SfaibsiX2e4acSu8a9kwaQSKw1rOePouwIqBhWL0
Message-ID: <CAEdQ38EM0FyqYZH6b30oxScZ481dGqnsqu23iePLdx2gCpqzxA@mail.gmail.com>
Subject: Re: [PATCH 3/3] alpha: determine tininess after rounding in the FP emulation
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 2:13=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi everyone,
>
> Adding Michael, Yoshinori, Rich and Adrian directly, although this
> is an alpha series, patch 3/3 also touches the shared soft-fp code in
> include/math-emu/ (op-common.h, soft-fp.h), which your architectures
> build against too (confirmed by grepping arch/{powerpc,sh,sparc} for
> includes of those headers; parisc/m68k/mips/x86 have their own
> separate math-emu and aren't touched).
> The new _FP_TININESS_AFTER_ROUNDING macro defaults to 0, so the
> intent is no behavioural change on your side. The new guard it adds
> in op-common.h is a regular runtime `if` rather than `#if` though, so
> it still gets compiled against your macro instantiations even if it
> should dead-code-eliminate at -O.
> No action needed if it builds fine for you, just flagging since it's
> tagged for stable. Let us know if it causes any problems, or feel
> free to ack if you're happy with it.
> I've reviewed and tested patch 3/3 on alpha already (Reviewed-by/
> Tested-by posted).
>
> Thanks,
> Magnus

Hello all,

Could a maintainer of this code find time to have a look?

We can take it through the alpha tree, but we'd certainly prefer some
review first.

Thanks,
Matt
