Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AED44682E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292962; cv=pass; b=SMZlOE0BqYuU5WiFdsrC0QWVlLhFWSVmtrNU5YSyGFiGoTp/Aaek6+Y5xsJZ4VNfyZmtVo1eggNlZSEWYe0OknNE+erAyKVa6IpR18JpNe/L1SXmL9L9Q5as3jfZvD80MVzVKeL/BcntfUUgGLQhjZGTgWq2coK9G6CIWhBnW2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292962; c=relaxed/simple;
	bh=2/kY6gI5Yk1xMI1SVYXumnXuSjxWIMRSCwqdkzoU3Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO34CgLmffrdWtMCUobhVp/BOL/IIbpNbzmA7xliUiXrg3e5MWKzlzN+2HPEkBZkb0DuHIW06ghupKSjkSp5lLaM+sq85mn8swJ/MbJ2xHkXhWyiSIbb6eo/r1C+pevFl1Aorcr6x4Lr6V7i3x0mhkeWV4Wa2cvH5G46z5vlj/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=C3bDStSH; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="C3bDStSH"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2039852a91.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 06:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791292960; cv=none;
        d=google.com; s=arc-20260327;
        b=LZk+031CCKd2KzJUPWF8TOZDQlqgA2Nh1hcyJkQRbK0/MbqCtlJr1jigsTKveKKRQB
         2WCTmAH7Bt2N7UCdZZaWxkGik3VooRMT/kDZLry5eYMRobD+k7uq3iurXie9TQeM7HGo
         F9Mh3LA21d5HFUm+oYZxKSOCQU3u4L4AAtkXmjDkiIa0i4Q9nYu3XXKkE5y7soJ/EN/f
         SwXHAPtkb8EYKzU44YoizsWqw+wY03USSHuVK9E7nZhbEPhPIGl3MKp2qtHDM8PpKmrn
         Kswh7VgmaJaI/49gC1aQByygdgyvpPnW1tcLtTsklQOgkezi9FG2gI3qC7LYiUySP2kP
         7SUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2/kY6gI5Yk1xMI1SVYXumnXuSjxWIMRSCwqdkzoU3Bw=;
        fh=QpPNEh1YHD7okwsc9qfdeLxG3gboQK6EzlzXDeOCMOM=;
        b=Xywobvlr/j3L5PkKY9MrMpMBHMsOfRNgw7t7P2njd9KwQIaLjH7DbcKtsa7sTEmw+b
         hkath1OdyAP3zlo+WOcfH7W4h5Dk9rTM1wB5sTvKRm6rE0z8qsvvlsXU88HusJttWagI
         J7ryVVHeeCHdab2uhitPWxH7b+YxDa0oO7HQxd4ZlephBgOl3jaoBO02QrIyaf1XCbHs
         /XcZpjQdGdB8SWolnFEDFAd0S6jKxWo+H+fo8MT8HgTSYULnEJJeSKeO3UHQbpHW3XJH
         ygQe6YcFnFxfF/5xdGXRRl1UVWjq8jFNeX/cDxyRB+3j6t6STl5i9fQXwzg6BgzaX5xK
         3mkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791292960; x=1791897760; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2/kY6gI5Yk1xMI1SVYXumnXuSjxWIMRSCwqdkzoU3Bw=;
        b=C3bDStSHSi2Y6QN93laDi+Neb114peOI4Gf37k/3xVquAGQWUuu1LITVaWeZZz5epA
         1KFsY2ZW22wvgUBcj0Di8WlDviGLUZiS69CMxJyrenYLkpGm9EkV9UX6u3XnmQWzdbi+
         uNmAXurX0Qk2Vkz4vashdlrNduQHM9qUROVC+6yvHK4ZlqccQAnThuW8JgzvnGnprgG6
         /q8xnRtoXvGPshdrceNsVp0whdSd23n64p+h7bD4eXSnt6AiGScl7yZkCQbAjIe4wt2L
         UEDecubxger8g9RoI+/qMxsB4VGUguI161bSL//FzmdtesNL/ZpKYYzv/vWjYjHvbSGK
         ytTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791292960; x=1791897760;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2/kY6gI5Yk1xMI1SVYXumnXuSjxWIMRSCwqdkzoU3Bw=;
        b=tIUEL6+UWXQ7Ewe9/yIm46KwOCyeqk9e/sXMGMDIT3hSrTA2ux1yjMbjGAVYtULfON
         7JjRKoNknZShYueUhbiNe4SzyG3UysnVhVmf5sWlUbLYpWbJuuTgoNY7hhzzmOsuTEKd
         5comXuVYwgDLzAHEwIWnRrWbjRvBpXqf5aAdmC+RUyzWtvnS3wGBI24Xz46V0/k6DhJO
         vN2B6H8WARsr2cU05WXiNgmo9uZfRBqE7XgK6YF8YbTuLA0IrUVzWFlvSlVmnWsGPzAI
         nZ4JmfLWi9q8qovW9dg08ldqU25FCs6KdHjZED8lejV0L9zFEwWYkSKtMtXikiGOnIEU
         kUJA==
X-Forwarded-Encrypted: i=1; AKwUvBwFpl7IrosNv1/loR0PDA5UYlHNWt4fMSaf/8wir1UNG0Dc29x5ZFw7/q4Fuy5S9rY/oiIyVi8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIahQg7EAt8vXiB4BJzsFgi2l5pUxIqtAm2AD8F5z5tkKXTXOF3
	CQOPpiLjpvTZDI1xJO9ggeLiUWrbQbQQwkpJJ6Y8YpX1Nzo5WX5XY7JeOHyGwDID3Hs6ls5ayYC
	k/TmXld20tnOFgYZkVpWPl6xm8u0HBQ6CDD99V7F9NA==
X-Gm-Gg: AYBFou3rQjk8SAJjHp4n90BwS4OqaPVPPv8VkMT5TB6EY1+3lQXXXj6EseFBOZWoV/n
	VN+pUAB3n3OynlaLnUt106bj9xDr6BsnB1V4DGBFePN/tu5ctI3/rnBIATbAazjzB/6I3iIUSKk
	khOESdHi1fzC6kXDIftDZRBQOjPGLCRfY+YbNPKHeqXlv4oY0RKNCHpmOcNuAb/X9X0beLMoGp/
	K66wVtTy7YIgzs2XU6CzoJIV7uhOrp8sYYoIkRHvcdvTdCtxhfqGLEnSRlkw4gk0idnMZpiuenq
	lbkPWPm1qPzpYZqRGcz4kra7Zi7i/8jO5D65Np9Zrx7uGHytvARvvWCMhxekWsHYHRQPGfh4AIs
	QQSifd0VujoL1vjS6wM/uM3HpR32nNR6XWv2jgWV4u2iWQEWf592JGacQfLEtg3fmqAn6MQhgrE
	I=
X-Received: by 2002:a17:90b:3ccd:b0:3a8:878:ebab with SMTP id
 98e67ed59e1d1-3a80879621cmr5255577a91.35.1791292960306; Tue, 06 Oct 2026
 06:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
 <f73ca71a-8a22-495c-91a9-12d89968ac2c@leemhuis.info>
In-Reply-To: <f73ca71a-8a22-495c-91a9-12d89968ac2c@leemhuis.info>
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Tue, 6 Oct 2026 15:22:13 +0200
X-Gm-Features: AclHuK-K9pG_NO9KBdAk3iESUwUuT_Z21z8xG2zR0qRYXTeutTuoi2M9aya7o-A
Message-ID: <CAPa5EdAxXiHKrdrUk2nrbxJzgh_B3jwkTP00+rV0-xk=2vmiiw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, nic_swsd@realtek.com, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Thorsten,

On Tue, 6 Oct 2026 at 15:10, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
> Not my area of expertise, so take the following carefully, as it might
> send you in the wrong direction:
>
> There is another issue known for 447cbe95ebb9:
> Commit 447cbe95ebb9 causes IOMMU DMA faults on macvlan/vlan with bnxt_en
> https://lore.kernel.org/all/20261004122616.56714cbd@nargothrond/
>
> A fix for it is under review:
> bnxt_en: fix DMA mapping length for padded small packets
> https://lore.kernel.org/all/20261006042153.199444-1-edumazet@kernel.org/
>
> Is that maybe related?

I hesitate to tell it's completely unrelated, as I don't fully
understand what breaks in our case, however, I'm quite sure that the
fix under review won't help in case of this regression, as it's a
breakage in a completely different ethernet driver from a different
vendor - bnxt_en doesn't play any role on the affected systems from my
report. But _maybe_ there will be some clues what should be fixed in
r8169 in the discussion for the other regression.

Thanks,
Jan
