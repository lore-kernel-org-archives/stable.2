Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864F47F2ED
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156211; cv=none; b=AhJI5uMvpC7gbaFT3vn99NznFeSZk3NlKFYnW4TYeaFgl7F1d049gSzcvU3XXHwbWbA5WgIS+42BDm8Wq+VJ4FQqaOXUsi1XpLyaLPW0P847agf3gSFb1aIXkBpLZ1c4St5IGzvdLAo0p1ym+piZWZ2bED6GW6H46CiBBgAoEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156211; c=relaxed/simple;
	bh=FQ09vxMYGYd2ttuL80Iy/iCi50C6RG5783hdiIeKPfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwuGxJToORlyX5XGKlfNwPrHOYCd0jxYFsuFA69X1qcQM6xS6jvJc4bNpPPuL7vTegQoykOGdvnZsZXrxLWCoIoAVTnZ2vMJ1imiYNDdZRs5ZP6sX9FcWW+Qw7/PkTlQAF+3tw+RyEpkqPzG2xjgEfdkAKpBtT7Y0+ZlokJuT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhMldEGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhMldEGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DA81F000C8
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792156209;
	bh=FQ09vxMYGYd2ttuL80Iy/iCi50C6RG5783hdiIeKPfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mhMldEGA7EhiUccr7UAZn5PK3OtVgO0G1hNm9D9L6Iv8ER6VbsDILFgWeskcZ9xon
	 RvhUMJ5Th8FMhwsnGPE3Q9/MT6thD6suVT3G3C9Ws9QF7GV9KjGK7KVcghIpEmeeTK
	 Q4YckOA4mn5lWRlQWAxj/ULQYZud4DdDM2f+hGLLlNaJMt6DGTDWj0tGqSIA4M07aS
	 Sb8oyt2V28DFL1BCf0PsK5AvMmrFc8kYMM+L+RdduEmsxLaFmG8KQRORbrle3RWUcy
	 +JilpFeaoIdLWqFz28ocSG70P3iGPQgDkX0NDLpydBLV6kzOXs7X1koFp/BN7/OhYd
	 C3TG3okocaSdw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a75f960be3so36000261fa.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:10:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByuVL6PdE4P87vFMJL2S6z40dvO5DsvcpPIuS6fUsis4pk1ODAGnB4TUXtjAmLFAnw0BgovsiY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcAQMih5mbh6of+39yeKKzZfdtvvegcCvCkPCcYgdn7WXPnz+V
	wj3YBkdZGOy7v0jzkWGvo3ED20PqHA3pi4HZm1Gds7Ced0QQzs3x1K9H0arRD7NApcHrCDiPEba
	Bsh9jzyeNji8ycSElsvIywCyhYasSF0M=
X-Received: by 2002:ac2:4c56:0:b0:5be:494a:f966 with SMTP id
 2adb3069b0e04-5be494afb99mr795645e87.44.1792156208704; Fri, 16 Oct 2026
 06:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014-gpio-shared-fwnode-lookup-v4-0-2253ad645fd6@oss.qualcomm.com>
 <20261014-gpio-shared-fwnode-lookup-v4-1-2253ad645fd6@oss.qualcomm.com>
In-Reply-To: <20261014-gpio-shared-fwnode-lookup-v4-1-2253ad645fd6@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 15:09:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLnNLryFVBvxwTrw0N9JoHorP0E_SUJcBEQz50i9QnRUuw@mail.gmail.com>
X-Gm-Features: AclHuK9TuCFmvkGVc_qKE21bFcDzH5CIbWg6ZWuK5Fbj6e2kEGf1TDNPflTSDE4
Message-ID: <CAD++jLnNLryFVBvxwTrw0N9JoHorP0E_SUJcBEQz50i9QnRUuw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] gpio: shared: fix use-after-free bug when adding
 shared proxies
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:38=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> The GPIO lookup table can stay alive for longer than the kobject whose
> name string's address we're assigning to lookup->dev_id. Fix a potential
> UAF by duplicating the string.
>
> Cc: stable@vger.kernel.org
> Fixes: a060b8c511ab ("gpiolib: implement low-level, shared GPIO support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

LGTM
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
