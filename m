Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795074960;
	b=UJ3ix93nznxB+FxFL+OqinV+5kriKtH1iNrvZKexbQq5v0a1xNKLYxue8SADaHsSAl92
	 J0Qce3Cq7YJsFTnf2roUH7ZBAr/KoaW4vadCRHqhdUsKX2DSiF9fHi3bvgYRGEwaL7MdW
	 ZVd/k7JQkWYNN+aNBoc2gFzsiUw7MOjrokSIxkE3CxPMXOeKsq3OoyS4Z0UL83sdG4/CW
	 qIDj6bfloNYnWdYZKPdu22AiJGnxA3p1of7wbqGI+Ti6PQ2r4++K3UWnLa+lnAAZcZXDE
	 u/kQqBdmyv4hPuHJSMebCMkVuHJBv87w9dk++eIC/zgIEeSrzdrjAh9UujqCa463SZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=glNQGelvD/kDLrH/fiSkPVz0Z5oOzNw/2XFScRnp138=;
	b=CBRnLzGtQdfOKAHoNX6Lzia+WUe1wfDF/UD9ItqC/NyiShEku995TSHIEdD04ZE6dc7U
	 xpwvszohq58Ezk/8CAN/hCgA6yWFEqzOnqYVeW7kQVC1ZvMrEqpmEi0EfOCRnMln6dCJL
	 OKLnjqwLqAo5CDnHNoPznYFLZDBwcDH9sTtZAU6P2PnuRPPRTqZYExGj86XEkCDlb/exu
	 mwrqSNYS0nm75uC4w5ntCzuTOk3/lOBNk0ZemlnSF+0N2RVF8TZHicZlq4kXFXzo4BHwq
	 cZHgd89rUUdceIe7n1dq6BZ2CwJ/P31tYKnVK6+NZV6Muz5ma8Qn3XdX3z+Bcz+RzuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PVYFBKnq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D3606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF7D3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PVYFBKnq
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67bee1f693bso1608969d50.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:55:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795074959; cv=none;
        d=google.com; s=arc-20260327;
        b=aFQv4i7LZitrloE2fLn2lSiABrjOBsbj2Jrc4abZerjizJw2aDuwCf+yGW0VlbzVC9
         0MU7HxnpdAoc7Zif1bB3cHmzCNS1kcXw9R7MQPJUD9RT+ve0mfUniThJQ6dstbDfNB1H
         TB6JUwX3tMfhU19bjRF6U0NchEwRAJzBkw9jjaPeu1oqz9k49eA+IQQxKolMtyLtWjTq
         e7gTtnrgn25KI+nJNDQsWpvZ2Dp5HVglu9yTvVJ9J2yH/uTKO6AxAgrUCCSxHTGjeTg3
         mmpQpHbKMz3ZQFpXqk4U1JSGARNl3fqE3QF6ZeBu1MjAYOCnDHwyEkyyIJhJC4d4gkPk
         qKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=glNQGelvD/kDLrH/fiSkPVz0Z5oOzNw/2XFScRnp138=;
        fh=LzzoAOfs1jXZwLG2Rb1RF1oK2ZYWmrbJfV91tSG6ZpM=;
        b=J5q/+Vl5fYE5A7rr95JM9nr1gouqs9q7e5yYZgEE6GrmGpiXwZCKRK7txWXiWPa+J3
         p2n89XiFYRT5pav3byJnFCu6WHqYCdWvLLoR0gne7Q9TRntMl6msO7FmG5SVrbxkyEnM
         f8TZTVbCQHYavMAUJI6s2N1/RJuxceNCAa2+o5dfaNsYPyfmGDy7hBW9oPFw8Lhtiyqd
         z5AgkdarQPOZM0coJPRHSc6ho4WOi6rvQkGlvLuPROs8XizE9oucYeU8MVw5WlneeOfF
         JGsFgylwim2FSUx6qiAjY4j5vT170a2RIEJdS4ausQHIKyUNEvg6CUOAYJ9bp2vBHIPr
         0oFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795074959; x=1795679759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=glNQGelvD/kDLrH/fiSkPVz0Z5oOzNw/2XFScRnp138=;
        b=PVYFBKnqIYi8G5pSLWwcT7zZHYcZEN1a6HlNWUl7FyInIBVHF0nAHNB2clR4xpKZzH
         xxMZGABs3emLJXMqzBtBvGDG69uW3bSbCCT4Ep0bD8mq32Jtv0YLIYY5098DzRjRUfYn
         C3bHdetInuTfQnx6zYaqGkm2PuHd8Cm2rpZAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795074959; x=1795679759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=glNQGelvD/kDLrH/fiSkPVz0Z5oOzNw/2XFScRnp138=;
        b=PlgIkyEyTeLu13k9EB57f6jAELLrCd3r8Xl+XxTQggP8tpcrLjzeYbjMck/AkqrZ1w
         l/b+Nu0EwWZGLX9G8DvzYVLA69AGPXrZe5IEl65PVFozKWewzcCks7712Q0Xp1h370k9
         HErp4aXRQ+TWiKHd1uUGmG92s/q6QdACr5OWgAP0IRLghMWymGJq0vw+oNfq/oU3eMV7
         L/SEn2v4u1nyTnU+4lyfa5oI0aFlF4erRrXT83SU8imGVFQG2EIIHq3jJ/EeCIos8Yf+
         /Bs+V86RV5KcKKiVHJho1/N0CC2Ijw2HNgJJ+Ez2J8rv6+08uG1lwfb8FNn0u1StIKuF
         zuiA==
X-Forwarded-Encrypted: i=1; AL+hErHX7zPQpNW2Xtm2I70Y+/lAIYluMCQs9raaiyZ8o+w06Ijbjzq1Ii3JwJiN/aWwHGbK1F4CmZc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gGiTV0MZ1sx+RqPQnbprFIJnF4BXI4MbLjj2wCJyB5AfoAOT1
	nbr6EyrSsUxVeH6gUqfdiNSnuTkT5zuYqiuEomz6qmmrS1+M/BH5uRiK32cSvTyp/PG+bbT/T0L
	0YrOv9O/tirhx6b45isJBY1j53QKnX8QOUrnMsHQ4
X-Gm-Gg: AZFdTZc+FGYsgW2VicGKRbGjSNa1PU2yKcYvKQMnTX/B/H1i7jgSSPqzqt9ZQilbatB
	EM8pj4WF93mzxlw2WgT8JNYp3wGPWnf4sGH2uuz/LylQ7b/ZOBldhsLUSp2xF7hlJFVqmATDmz4
	kbpA6viuMw4h6z7RjFydBEcluxhVbsyCKWH2KX7f253N+BflQkgY3/GZBzFCFjdP/wd7MMIzMOA
	aMUZYWlVIeYknsfjAG9QGIrS+FpKbcYcP9zx7BD5OkvVo0Vaew+iM4AJrbOlE4QcVrRhsxf0N45
	JlJs83dRiEPAjv+BtVXfGR01/l4xK/hukuQvPn8s/BmCkAiDZU9wDAWBaF8xQpSPpezIiIRV5Dc
	knVpN1Ki8FtlAh+HhYP6GNx5gdvUFCYG3+PlVfn3YgCpgXgJ8nkOeSz6kh3P91hP2xfY=
X-Received: by 2002:a05:690e:4853:b0:67d:a059:2f39 with SMTP id
 956f58d0204a3-67dd3f1b3efmr1369617d50.21.1795074958750; Wed, 18 Nov 2026
 23:55:58 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030103418.2355854-1-wenst@chromium.org> <179491350817.164578.3923681659802112857.b4-ty@b4>
In-Reply-To: <179491350817.164578.3923681659802112857.b4-ty@b4>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 19 Nov 2026 15:55:47 +0800
X-Gm-Features: AclHuK_NKKojwe2jAIh6fAUopYilD5lO7S60sKZvTblPy9cW1Wbrg51aFpv1c_s
Message-ID: <CAGXv+5FiRyp6MzTdOo3KygM1w20YPD+eCG=-K+VVbPZUYsQQnA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: mt8192-asurada: Add ramp-delay
 for MT6315 regulators
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 7:05=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On Fri, 30 Oct 2026 18:34:15 +0800, Chen-Yu Tsai wrote:
> > On Asurada, the MT6315 buck regulators (Vbcpu, Vlcpu, and Vgpu) are
> > missing the regulator-ramp-delay property. Without the slew rate
> > specified, voltage increases may not have settled before switching CPU
> > or GPU to higher operating points, risking undervoltage crashes.
> >
> > Add regulator-ramp-delay properties matching the slew rates configured
> > by firmware, with values provided by MediaTek: 8000 uV/us for Vbcpu, an=
d
> > 4500 uV/us for Vlcpu and Vgpu.
> >
> > [...]
>
> Applied to v7.4-next/dts64, thanks!
>
> [1/3] arm64: dts: mediatek: mt8192-asurada: Add ramp-delay for MT6315 reg=
ulators
>       commit: 9c9f83e3368d27d1e0ba55827a171ebf551c3d0c

It looks like commit 9c9f83e3368d27d1e0ba55827a171ebf551c3d0c ("arm64: dts:
mediatek: mt8192-asurada: Add ramp-delay for MT6315 regulators") ended up
with the regulator-ramp-delay values for Vbcpu and Vlcpu swapped:

- mt6315_6_vbuck1 (Vbcpu) got regulator-ramp-delay =3D <4500> (should be 80=
00)
- mt6315_6_vbuck3 (Vlcpu) got regulator-ramp-delay =3D <8000> (should be 45=
00)

Do you want me to send a followup patch to swap them around, or do you
want to handle it and fix it up directly in your tree?


Thanks,
ChenYu

> [2/3] arm64: dts: mediatek: mt8195-cherry: Fix ramp-delay for Vgpu
>       commit: 04560888cde5fd8adc325a6ce47466f80b8c668f
> [3/3] arm64: dts: mediatek: mt8186-corsola-voltorb: Add MT6319 ramp-delay
>       commit: 929638df9f3b36665efd60ac71f1eed4ba36a0a5
>
> Cheers,
> Angelo
>
>
