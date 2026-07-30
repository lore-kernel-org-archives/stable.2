Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9453590A9
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380816; cv=pass; b=ud9SmtFBLveluq4W5jKlCnVzQkzdsds50NpynOy90bEfiPAw97pVhZ3xGWeiFeROgNfK41uPeEajziXDsoAorVwCJqh9F+a9eHtlmiPFOgIOqv1uUob390ExKjAcoNUenYDxAtE7VD0/8BAGHwuI894zvaSnDcWoc71O3mPIPCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380816; c=relaxed/simple;
	bh=8j0nxrm1wXhCpLhXah6oFcNu4BvWHurBVnmFCHvzVYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGNVpRKn/DkH13atSrJwb7gRyn6hvg3QEUSenOzsgnN3DfGtrhK8M3eQPhaOBiog+2FqWDCYg22Woypam/h1TG+j/JDYoTurWibC5Qs1TRxyNwtAZf49nOUGNPgVv0quGpszxpAzFW8x1HO3R0v8i0x69awn7JXxBUtZzNWmkaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3KpGUTY; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3KpGUTY"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c9107baa7so12719981fa.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 20:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785380813; cv=none;
        d=google.com; s=arc-20260327;
        b=Sp39uTOTB/k7/+cggbz7i2G9sxFzGALqmFV0il7Px62tEgQk3UipivHWq8CxLTYhtH
         DdrniQNIq4RtBxg1zjTnp8eG8/aWA6OtkR1WniPUf8AhHIufUVl8wIAFAlHHdFY9/BOh
         qlZL0sWHJYLrq1CfLyD9DUyYHGEHVvmFuw9VG/+zg45HgD7j17umxYvROFZ0Ivy4017a
         Sgv2vC9Kp+KEhkoYvCNeerAQpU0BnfT2pKjOCUFmRlBhLXkRexEpOEpdTg0O/VoVCgLX
         3WjBZZ0WiHqJitDwS0C8MWx6LpuHd7zizwu2bZF3EO5YVM+kaIP1LivrP/CA3bWEPGx2
         pQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2y2fjND+qKE5aS0sv8qbFsMkpL4CRd054tvNPonoy6g=;
        fh=DvKUDNqevBTKeC/3MJj11SRBxW9db85071OG7nhbVMA=;
        b=IT6IUUj4cm4nPGY+7x9wTi70iJNHjdYpOS2+7UHVoqgi7IhkiPrVjQTJkLFwKsyoF0
         Pq7u/MR/+ptCA3jqIV6vkGdetuMCIJ0C9Y+8DEltrReZzXAaO9LLcUmJtPpQXXiWadJL
         GIqMLqU1cJXe+AoYtTBTSxKNu+6iHI50zC1DmBeNcDqyzUVWYLoUrGGAHTmwSCCa9bmN
         UYbR2gWOkt2VM+g4SF8d3jRxolvfDXWm5hxox9RCJUb3RiXmM8ON4SHn3YqnnJ6ARRN/
         betmCrAGjBsHGsj70sLqcSm6FIRgMjV2kDzLDHlhXSTxu+FdhUaVZGdNnE2rzWfTjcq6
         nI9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785380813; x=1785985613; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2y2fjND+qKE5aS0sv8qbFsMkpL4CRd054tvNPonoy6g=;
        b=j3KpGUTYL82Rc0ZS1P893qBdK0W5a3pI9iTImJFegdQYDHDNrf2VKtuyaHKgcs0wzG
         I/A6PZeLTLOFYsbbn0vzjxRckEYSsVKf/PZo8I8UyvAfQARxKjAo8eaWoMzILiHU/Y73
         g6bhXldKUInlNUoG7eDU6P/1bTdW9h9wDHyRQPC4ap5/L04XGTlaJCky6OayAqdq8bYI
         oyKa7E0mqvRaQyb38VROXTEaZ6AYU+/K0XJQB2u7waiZepPX8dLEkcGe7u+LcDAOTIYB
         AyRefQ/cixyOOZaDwsFmBSzlX4s5hBtUCQbbSEHof5WVJ95xkiv1/Pj8u+0KGqwE9RyX
         ILWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785380813; x=1785985613;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2y2fjND+qKE5aS0sv8qbFsMkpL4CRd054tvNPonoy6g=;
        b=EivvYOd6z99fN+fUbZzYwdS2kqOiKtfpQMsbQuPC1x1D+YPI45Z0IMLyqVlBEL3vvh
         HIrkk6bmub08mef9rNPiLqKpQHaKzqa3DwYktLydocQtu0IsI+ULfkarA08zKGAFN+ji
         I4Td1c5AiKpgqby6DewujdQHrfldfC8qJ/iOl3hlOm5AuPuDA0qFwC6EwzuVx22qyMJ7
         bxle1PkYHD75CL7NZ7pS0y2WWeHu17nYxE8IEFezvC9aESyVvRhcLK9P77PPnNtEQdHk
         mpLF/enRkIKHlY29VnE1OGHS/bsQHiSHPGd9KI6VXtQFvxsJG9Mhcxli4rQMyGgPaWsV
         pHqg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6T5WSxH0YgetYpgx9vD12siTvouP7R1fLEkVd1EOEdR9MwO6WA7gFmA6TR0Og8WTCERwU2Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjtkk+INiTffVl3i+lvOGhx/3ELEf69YlLoLU7BvD1eubTEeJt
	+08lemnDCF887yqrxs2vK9lfBCzpLLTBPqF4mPUam0HGKCF9aPnbsuo6Es4DyAFj2x/8kuco0dE
	qQvUkHNIZXDQeLCh3hx5BClKSXDbMzVI=
X-Gm-Gg: AR+sD10OSJjwPbW3an5B8wDyNK7se6XfbzrPnXRhVtSaGKh3ttF0Xr+A8lgW9aWNCoZ
	vZUPyZS7AyFAe3t+vDqJVtWSYj2oroCRyYe13TyxHkmUAt7GkpE0kv+HMtk+vVaIB6IXKx/63Ty
	joU64++TcBuQVQdmk3HQODZiu7/WIJsewwdgFzYTmIwDoteojkSUhn+3mxTOjQnRErnQi93Zcu3
	B38/i56pp85IiJC4Sa0URBuvppOxEe7fCU9DkLndknF9ZJ842/xaA+mhS3iOS1s0qcFX4a/7ikS
	4tZ9Yhmp7ATPs92bFwIt/xQB/5gtvdRBSwdTCA0ksFJdlRZdEqaTgIj415/3v/FUaJv7VD//ern
	/rh+quxgDqgvpSI9P7OsyAqFBtQ==
X-Received: by 2002:a05:6512:33d1:b0:5b2:a1fa:2525 with SMTP id
 2adb3069b0e04-5b2db387f17mr118957e87.31.1785380812454; Wed, 29 Jul 2026
 20:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728103536.25012-1-gvalkov@gmail.com> <amq0EnoZrBA+8W+J@nxpwireless-Inspiron-14-Plus-7440>
In-Reply-To: <amq0EnoZrBA+8W+J@nxpwireless-Inspiron-14-Plus-7440>
From: George Valkov <gvalkov@gmail.com>
Date: Thu, 30 Jul 2026 06:06:40 +0300
X-Gm-Features: AUfX_mxZC37-kHj-CFlIRf0oRg-uqaKRO8uXYARafF1KZoQhqyfIQJ0T5g7ho60
Message-ID: <CADOrJmZKdM0y6jeS7oOK0aKm7BaqcDB=BmXTSBrFTiTqXHhUhA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: ignore ROM regulatory hint on WRT3200ACM/WRT32x
To: Jeff Chen <chunfan.chen@gmail.com>
Cc: briannorris@chromium.org, francesco@dolcini.it, johannes.berg@intel.com, 
	kees@kernel.org, miriam.rachel.korenblit@intel.com, wenst@chromium.org, 
	rafael.beims@toradex.com, avraham.stern@intel.com, 
	peddolla.reddy@oss.qualcomm.com, error27@gmail.com, s.kerkmann@pengutronix.de, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jeff,
Initially I wanted to keep changes easy to read and as simple as possible,
hence my current patch is based on device names.

Indeed out openwrt-ai also caught this:
https://github.com/openwrt/openwrt/pull/24458#pullrequestreview-4803923901

I've been thinking about possible options:
1. Use board names "linksys,rango" and "linksys,venom", where
   rango is WRT3200ACM, and venom is WRT32x. But a venom dts
   is also not available in Linux. We do have it in OpenWrt:
   https://github.com/openwrt/openwrt/blob/main/target/linux/mvebu/files
   /arch/arm/boot/dts/marvell/armada-385-linksys-venom.dts
2. We could either ignore this or
3. Have another PR with venom board support files, but that will require
   much more research and work. I don't have WRT32x hardware, and I'm
   uncomfortable doing this without supervision.
4. We can also implement a dts flag, e.g. ignore_reg_hint, which can be
   set in the board dts. This might be the best and most flexible option.
   My experience with dts is almost zero and I will need help to implement
   it.

Georgi

On Thu, 30 Jul 2026 at 05:17, Jeff Chen <chunfan.chen@gmail.com> wrote:
>
> On Tue, Jul 28, 2026 at 01:35:36 PM +0300, Georgi Valkov wrote:
> > WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> > from the mwifiex ROM, which conflicts with the platform regulatory
> > configuration on units sold outside the US market. For example:
> > - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> > - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> > - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
>
> Hi Georgi,
>
> Thanks for the patch. I have a question about these compatible strings:
>
> >                               if (country_code &&
> > +                                 !of_machine_is_compatible("linksys,wrt3200acm") &&
> > +                                 !of_machine_is_compatible("linksys,wrt32x") &&
>
> I checked the mainline kernel source, but these names are not found
> in the DTS files under arch/arm/boot/dts/marvell/. Instead, mainline uses
> "linksys,rango" and "linksys,venom".
>
> As a result, this machine check will always fail on a pure mainline kernel,
> making the quirk ineffective.
>
> Jeff
