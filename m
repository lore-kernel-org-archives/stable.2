Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EF4A6CF6
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820286; cv=pass; b=ajSdTl5ziB7KfJepKh2ASp0WFG1V6QZQe/uMLFUv12oyV90Pqqk7pEL2sY+xRrabu8la6yAZLXfIe5SKllF+zVhsDbOyL6C86pnM7iO/FluFf93/9ppD5m6WaxVmAgGSte92QkhYX0aTmW1/Iz1NyneStvAvCDza5x5wWnpqUfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820286; c=relaxed/simple;
	bh=DEeSQvEkomQ/MBdzK/pDxXiK6gmTTDo4JaLAlQyDmec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3vUkkVBdeLYzbTIg5Jtn+1tIHYCaufvUB2Tmdcdm/FQVOAQ+2J+fjxE1+WHJ9fND/YuuM40YUlwTfqs3XZE7yvHSRbTrR5MRXOfc1jqWrnfu6LWWrz4x8EfcF2PypfQqiPoK7AzKeKHDlPXsUroi8e7GPg1b7axl5ZKvP4QpoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=QnOPgTcF; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="QnOPgTcF"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2a4e013a44so298676166b.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791820283; cv=none;
        d=google.com; s=arc-20260327;
        b=QlUeE8adReTwj+tUzig2sx3GNKrRRPwX54ebECREiMUTSZvAzQPGmNeC0Q8MWyu5ja
         tgv7kOd3ORZluTbKCTm6Emgh0giXMO+vHzgV6YZNMz20zr/kfC2qRBvTSOjQ18YGrlHq
         ZpoiTZGGRaP7dq0ZwLKgxWo9EpVPS2o49fel9jM5tVeO4CJPusEuusLLfZfCIF2aDz9P
         sT8plD4pPexN+mWWaw8TO6Y/I1WazCqnrKeMaK3SbSfq3AiOhyB7ZTOOLW0eiQWS1wm4
         XIqwndEQCf61bBqhMpEAFJ3uHEGWkUYkWIOJBMVcwQP+1Hsp3MMGsFU9YYbEeFoRBm+u
         l9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DEeSQvEkomQ/MBdzK/pDxXiK6gmTTDo4JaLAlQyDmec=;
        fh=e7PMGmudR9EDYb12CgnUL3tnu/myIQXDKmnVQNbboBM=;
        b=iwP0WOePU3xzCWEw7Mk73i3h5xV83lyOQ5FD5N0mqgQUr2ngN/p6713WKt+rNAl3yq
         O44WcYQ5xqfQ5tslKDZN4rxJjRk4SscfR9GBT0fEU6HDh2i7L7S+pgR83qf1XPxehE3y
         +mwq6McQ4J72EEy2G9thsaYHfnYh5dm0dG0phQ1xJOy/8NNkXpGAP4FI9IqfgpJArwEp
         dnapDB8FVUxqUuiZ+9jyG2WSz6qTY3cUsBAHU8cxKe9ohrveqWuCSWkjBeefEvvidHLJ
         bLJ9A4lMiqU8ZMzZ/jJmblxiSfH/UmWWM+PNt2FHGAw2ZcChtiPGFEVOivnkke0pZNfx
         +rjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1791820283; x=1792425083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DEeSQvEkomQ/MBdzK/pDxXiK6gmTTDo4JaLAlQyDmec=;
        b=QnOPgTcF147f5T4+7UTWv22YAJhQYypy+U+VPkF+og4CiK13IGMYpCgpDYvtS9GsAr
         bIDyjrd1ybb+UWujVOqvO9MxCdTRkfNlOS9bA90lPd701dnbj64gaT0VqN2tbdspPfjP
         Y3+tE08/m4aBwEbOF8bKhe5x4gMwth7zCveJvAB8yx+nrHr8shEAdLSuERvfwrK21YBQ
         CorPN75qVDhuWRar0RUJwMX4RTibzo8u1odO0Z1VUIOr0+lZgM3PgXWrqur8ppp+J39S
         ju4rzc0OyX6ighPsBPdz/jRISWZQctqosWiesNmn2nm5Fe37C7PZpWD+C9thd3qjrU8R
         HESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820283; x=1792425083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DEeSQvEkomQ/MBdzK/pDxXiK6gmTTDo4JaLAlQyDmec=;
        b=u/svh0CU93qfqQbbGtnqwRKn2fJX4saa27+BkMervTvrxvl79RUzS/EBTQwEbqV994
         o6oUIf4SnqPIaVjfKwYG3Xf8sPZf8oI2rfQff1ESz5c0JyWfSUPQntFLH8nUFVyQBRXC
         OYiLvOPwK8fgMGMiES/j96jWevAbv+we1RtUd8G2ZrpPGZ46W7sTIGc4xbHvn8nENZKM
         PNvSMMN9sJ3C07jxJDY/VIAzZqG99h+H8lcnhotLzQu0i23cDX8IZMFIkXEg+zuE2rIR
         maRZScVi/jssAu4t7UDE/tznPRA/XiXdtjDZytOCUgCBwBhk3oRDq7IAVb9PdT1MGmft
         7eRw==
X-Forwarded-Encrypted: i=1; AKwUvByBkkh5Ma/y16wPUzywSaayv4kFBYPH6Kj8S+MeHTkMY7dKucFBUQY1IP6V2LEFyajlkFjdE/c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNQ4BuygfpOnXcz7+lXxw1X9DrllCcpWOdJg6OXoCiE3em0Ydm
	ZiHEhbrbF+yk0Ve8CmCYDvbcbm3Bo7SLw9Mhyc2t9GMp6JzM632s2Q2vvPJbYBcEUusFPF92h5y
	3TjVAC1Ek2KTs6p8R2h6OSVkCpT6cpJXUwRiRY+L4NGolFL8/PMMMf5u0vA==
X-Gm-Gg: AYBFou23cGYTgAi0UOLDdn1JyT/Pb9YTxt8iZ01DSAadsxFRXvK4gZiX7q/G1kyzJlP
	GW95Uezs00eiIKh2wMmzfRDTKC4ZT6/2e0Uhzox98tM/rSS3MqUtfBoaiRAhf+rJ/7IdEgAa0UO
	96Vmz5WcvYXNPtyr0+ub1KV7J4efRnO0r8Fjrb+9NZtMPG0FN5LrlJXCkobC9yGZMGtiPdgmgCX
	ccogPtRE1Z07GNo9r0KFM6+tjNKQeLvp4gmG31saded96Y13MaB1KlwWsqFJ/pcXrL4qZTi3Cz2
	Z5lVsEgBTZ8JjlPm8g9sOlg/qW0YKymmlNgabCLduYDCWqMY0Tz9xjjJfsQmT5aKlrGpiK0K2ZU
	OfvvlgwddUZ0=
X-Received: by 2002:a17:907:8d8d:b0:c25:5d2:acf0 with SMTP id
 a640c23a62f3a-c31a9b0b0a2mr873362366b.8.1791820283004; Mon, 12 Oct 2026
 08:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026101215-matador-pointed-25c3@gregkh>
In-Reply-To: <2026101215-matador-pointed-25c3@gregkh>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 12 Oct 2026 19:51:12 +0400
X-Gm-Features: AclHuK_6LgMcHLj5tnAe-AOipTc0wmerT55WIKe1cyQ9CpubW2z1XvD75ilMU3c
Message-ID: <CAKTNdwFzi+Xk4ZwH+s9uqR_SJMKwVnytzOWSirZ7mFU4y3U5VA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] regulator: of: fill in supply names in"
 failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org, sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:58=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I've checked, and there don't seem to be any in-tree callers of
of_regulator_bulk_get_all() in v6.1. So I suggest dropping it there.

Best regards,
Alexey
