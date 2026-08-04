Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56B3AAF44
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811546; cv=pass; b=bKUWk1yA1mmpqZhwE+G+TMS7TAeW5sKcVpLblUkBYFS5VEZgu3EhaPeLJuVW56uwmLWGtCrYwKWq1IyjdUfHM364FVnsFaQYzBllovXkolCusSN29Z9NzUBJh6yFZmIcNkJd2ftO7oispxeoyMERp4kWdc4N45PzRL1NhEOzHfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811546; c=relaxed/simple;
	bh=AUHZK43CT/N++9FBcUl1JAIfA+cKuOObfqC5yDHgHUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBJ1jP/KV8/tX6ttglngJwRaU4y7sG6AbS8PjZM7VWSb8TKV4iB6wJbSk2JxJpB3Xa9qkvhiihNYvrlO3ql1SyFsq+TmuYZ4UP7AP4CCRyNRg1iu17da2GQvk+PQm8+ktz+tCfBf2vnKNB4OxSY5C8wMQ0JFwH/7oGdijee3mQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WgErTmhf; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WgErTmhf"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e9f7491ffso61192427b3.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 19:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785811544; cv=none;
        d=google.com; s=arc-20260327;
        b=Pv4+r3iALO66IWYNMgaOrFXB6P6eYl2FiDZK3LZ2CduI9qnVHiFt8fO87NHT9+UZnw
         V/pjVXPPuRlTN1kydK9S6kNXxL9/ifiIzrOwlbOQFpMYK8rVBz5+8VumFQ/G/luBVQoV
         mZyPuj2i7jXvt5s661dxvU4EgHKUqQuxQDYH0Z2xhxxQyn3s+pRfm5Oo+jxGwBq9a5I6
         DpGLI5skkvic6JbjwBCvcBr76ivXAo3gPNvfuO4bwHwcLYFuFQXUKnW+MkLB6o9DKCiM
         VoQ71lrEp87tu7PFIEImToiP0Xa/Sylz1dx/jjRLhM0XGbQvfwWTGHtHinDC7O5Wl5vj
         /pzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AUHZK43CT/N++9FBcUl1JAIfA+cKuOObfqC5yDHgHUM=;
        fh=2HKOanEaxex9Z7yg/NKEMwZg3DwHNPPO/lTOhr1yMG0=;
        b=Bbm3K/UQmSSB/KEgf/YOjyj4+d2fJpb+IoxzpKgK/33U1MZG9ohLjeknfxSYbyO5+v
         eFQpsSjQ6PMCiy6pvX+jbbGaSXuBTk2MxkbH8D/TjPgtQbq3nSq1Vm6eXwqwzjeOUczE
         dQY0+839U/YACMDb/J9puXQ8HeCFlvZfJmNa7pt9AqJ5STvN+USxeTik87gCunwUcBp4
         tNCP7usXPI8ByBLl/HsNAFEqyT9VwOGuq93GTev3GBT59O53+sRmFW8em4/YCG3YvYCA
         2TjhLefdJicEIrB5uhoTBR2CZuWhiuFX7X5mEC61VADnMFCfv09hsyj7Ahav8fAvmiQE
         ZrrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785811544; x=1786416344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AUHZK43CT/N++9FBcUl1JAIfA+cKuOObfqC5yDHgHUM=;
        b=WgErTmhfNRjNzhJhVn1FMcCJZc198tvCR2mywUwTerla7mLgodvReQHOaXBoMRh2Bk
         p8MDcwBiF5wgNmjRtmlukA3PGBxMXvSt5GJiP1wFZBfBNFTjBM+fYDauqE3vPQ5+4u0/
         w1Sc02oG6DtdJNiQG2ebax7JXtN8ewys652WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785811544; x=1786416344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUHZK43CT/N++9FBcUl1JAIfA+cKuOObfqC5yDHgHUM=;
        b=PyJ0PN/vvfX+yeeMd2Vl81OhSBHO6owZldkOZwPS01JFTCi7obLLW95Ig6tWTBjuIa
         nQLPAPLFJPtJMUGlTyaCwj3p+wBawAzislW/2OnN186IiCWFMytalQtW4jGRueQZp/z9
         X/p9HTltWLnCLzl516N2dubPUgtoXEpe0kMOxAv99qhhwJ05/fz+yzXAPDR3wzgYZXK6
         2d9+IhTTtEF4NEb6bFnchKpI/axkLfq0bn+CJoREnF09rLaJBsEsb+YEltOY6KYglSpQ
         liUsZQKMCLuiJEzbezfWZehdk+7AO13KMtF8tNI99Sr8bzAdHnwXq/22OO85dLFXzxY6
         TRfw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0IruSEqhaWDZx3bjbgvWdQhYsNOnreHE+v9YtG66y55DhtODNaq9HeFKLatkLLtE/gBLWg/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01eOZ/nrvqNunNC5vKmro1wyUae8V52JODC7tbl7FZkovCSC7
	yajLxF0nVfgN7H9M0bQJAFGx0Oye8VtqL0CZAOuSTTiNIP4w+lUh+kAthlXyxJeexUR3cCoEMQR
	yOJpjCh7tuo2VLydYNbSFUHY+xs25KAdzZggkyEkS
X-Gm-Gg: AR+sD10CpswVybUn61209T5xPLE6dC59R5hl+dkZuHuet8QXzH9pX2JdLh3GtI5EFid
	En+AJu0vcRsH1tfItyN1g+TxXcSM1dvCdof0Mwy3dndCQLUvl0CaRMGtaDVlUMOuNrswCzUgjUh
	GLaUxtg2V/CSrt/17nssam/OBbPbSlsoOwVXBnlx7Zl+v9PIish6Pb2MQdP0/1Wy8kpxnNtW/vt
	3cHYrcVs53aByZJ9vboTHJRrXe/rmp4lxYYh+IZdjvIlYII2pzPdmc6IpmpLKOgaxzvlSp01KSW
	7FiLW/RpACRjl/z1ajuWof7loE+NjtFvL7wLXNjRPRP4FC4=
X-Received: by 2002:a05:690c:6d07:b0:81f:27f8:2de4 with SMTP id
 00721157ae682-81fd4a04799mr160372987b3.8.1785811544182; Mon, 03 Aug 2026
 19:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803141659.559129-1-akkun11.open@gmail.com> <20260803141659.559129-14-akkun11.open@gmail.com>
In-Reply-To: <20260803141659.559129-14-akkun11.open@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 4 Aug 2026 10:45:33 +0800
X-Gm-Features: AUfX_mwLcNdgKSX0dY1YbYf9cwLK9DsvJWUXl-Ukek71RJiEJ4s-l_75YEo7Ku0
Message-ID: <CAGXv+5HRsFFhzSYPdk-zmipLTVwxPkHLbuFP=wn_f_D+3ejAMQ@mail.gmail.com>
Subject: Re: [PATCH 13/32] clk: mediatek: mt2701: Switch to common
 probe/remove helpers
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Takashi Sakamoto <o-takashi@sakamocchi.jp>, Haotian Zhang <vulab@iscas.ac.cn>, Kees Cook <kees@kernel.org>, 
	Miles Chen <miles.chen@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
	Sam Shih <sam.shih@mediatek.com>, 
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:18=E2=80=AFPM Akari Tsuyukusa <akkun11.open@gmail=
.com> wrote:
>
> The MT2701 clock drivers can use the MediaTek clock framework
> common initialization sequence. Reduce boilerplate code by creating
> struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

For all the subsequent conversion patches, please try to mention _what_
led to the converted driver being able to use the common helpers, i.e.
what prevented it from being used before. Was it the PLL, or PLLFH, or
something else?

Details matter.


ChenYu
