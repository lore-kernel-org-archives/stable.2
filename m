Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450773CF021
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166984; cv=pass; b=SyI4oLbJZUsyW3fZKn7wXZfg4PRHt3MsRTP6ZnqPEG1TQmYuDwMeV/Wo67jCvs6V44iSM+90DkXSTGX2RO/VHAGRS2r442HoGCGCskQm0/eYJx/bDG+N3x/hILh32H8d5VZCTEq7jF7QzXNU1UhPa9jitgybKH9WKlmGFZhhebA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166984; c=relaxed/simple;
	bh=6Gdm/Jwa++tYCYBFL3h6ykFgGzgM/L/iYtKQijxE/DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpkBq36Y6pasy+PMegU57mKD7x/T2RK9LII/6L8Dn60lLfwb1fsjCNDFSf2bfx7q3Ru/1w1ia7Fx8TyAD3T+0swhlhBFL9nJFeK5dj2EmSLQyaH+w+QV8myunqWv/FXQzQItCjLcrkIE9KJ2bgap3pH5ihMYccxjhCvDQBSTXpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gxS25cX7; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gxS25cX7"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66e55430869so1669384d50.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 02:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788166981; cv=none;
        d=google.com; s=arc-20260327;
        b=Md7MizssSj8UuSJnYn36g0ERvMOveW9kDugj5GrUrQZ3XwQDUveYXeKXV0srKlBMwS
         IegLT36SlDmafBT3rO/shyPg44Rnm+YeWo1LbagFEBJPJLy3zETMppVzNyy0Ay/yATGq
         3qKk2SbDCZkpPcszGgDh3ZOUq+cT1ZCbF71NCT5Aoxm68kpokSnCbdfeSZxuPa9AQ9W9
         dIoPfZ4iH3QLuDwdyMvjc1fg6FJ+Jrp+5LD8gbuWLVJv6MlR3CSjQsog6BjghdlNqGwk
         wWYdqF1n3IIlm6/3/4/6l31/ezBzYnzRUG/bnl043LUqWppPTDZp3fgImMZMq/f3tAmF
         Wtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJC6+3Z9te5tWmjIrgAr6jz8Uxtgp4B6abtI+nY7s+0=;
        fh=Cs1w2RJseEyL+rXdc4+dHS+eEBymQwH5EcoH1ESU90A=;
        b=mndowThxT+VB6UCZKPw4kM+SfsWkb1qSd4NXpCRJ8JjQnjYq1OLO4ITFnGWD1/tmZF
         mTLptya6sKu9FYU7QT0QilwVn6E6ZS75Vd5j0OFxFMLw6WRPaq579lwYxg0xMpHd7nir
         zrjZJgwuHMwHNvnsbGd8tokaq2WFnZJiX6OZyppXS1z8WrrNmwtQ5bE9PEUuuww1TgLc
         fzoZKctBtUjNfcl8QVdjK0VTalChv5QAPTXvvDAf3iCuDc7VnWlVWlZCjO2Ve4yQHBmv
         aNwXmSg8kVWuZjBCWkU4xo0zcpxDKn1qBB8/e5UrPzZbRB9hlPl/x9VkXdxAteAG5CDp
         fMDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788166981; x=1788771781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJC6+3Z9te5tWmjIrgAr6jz8Uxtgp4B6abtI+nY7s+0=;
        b=gxS25cX7MAPuDkGYYMpRu/B0tb/U0Ofrw4GkY2KSp6/H5JP+q4J+jB55lgrTVepUf4
         /8A1RxtOvXnosSZHZiuH6cmmTbqvJf5Ohd5hYc0kMRscToOmolILKEWSELXv7u3e7NCL
         h3ogp9DXbBBPYOmhxmcFjxIPP/6tUW+Q/Izx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788166981; x=1788771781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJC6+3Z9te5tWmjIrgAr6jz8Uxtgp4B6abtI+nY7s+0=;
        b=O1KaycImr5PgE8IWclE6blHVLjVcAJIMardHQkGsAqIPBcRW8GsXtFbq53krB8zu66
         OVyZY/oFldVmmKUKnRQ+Jf+dQfubkZYuEbE50HJO+3ueiDM2LJyVAfiHw8/44Z+m2wOR
         AS4CEeF0I5qMXQVDvgDph2Y+okDLrXHDXuP18WR1l6Zm1kxnKUthE5A2vBGpFLTxFcdB
         OilE4EjyAgwrYenTI8NCLGieIIc/8Tyi+WYQ96zTSsqVCJmeU4y0+r3UM2L4OADBKlUZ
         mkZ1L0x/rtlxQIbpV9q3VhjIyo1dYET20D3Jx429ZkRzih9A0T4uFdoz0RHvu8Th2vZX
         nnXg==
X-Forwarded-Encrypted: i=1; AKwUvBxQJT1CZu/gAzpiEJihx31Cb9PVCKg857l2datuQjUNp/edNg2YUGqO6fbR39f9QYFQvr3cjBE=@vger.kernel.org
X-Gm-Message-State: AFuF++letoA9YXcShUKQutQPDHl6pc4l4bJxk3WbbWodNBEI3zg6bvz4
	uj3itQ8Wn4odvAvlsbUvJZzDAeN5B7nbie2E498NmnJMokGGlJcyYdz3zHOGzoOAmQg9Lp9X9Fi
	3I+cCbjyWpcCaLY6H2Pag1mA4lqKtTwTHgUX88gL0
X-Gm-Gg: AYBFou2+oTX5AlQhzfbr+p0Hy84fpMV90pBjXS/PyTczgYOomHoS1KOMNNN7BmaMcB5
	eycsCZKzRcvz4ok8vibouS8d9AxxU4J4r9H0Ylrc9zLAAdC/xkQjMUzpGi5+hwdWoNHdYDrt68p
	eeS5oV5GrmJNwRcjon8xNsHLjsbaFbDXjDwuo0/xB1/1NPD3gk67TuJtGr4r3Uwm9Z24Qz5mdMf
	zrxvQmn23oy30ARUpvtmSaNAbSDNxI34RpjIKnW0B5EcKIP/vbWeY4JiHUSh7hkuMiBwJEunG0Y
	FycPb9x/IubR6CuovOW3GBBR9ukw6oF86Ygfau4PxxlHQhlJuawF8ihDmo1Z5FtNnGcpWcO57w=
	=
X-Received: by 2002:a53:b9c9:0:b0:66d:289f:6498 with SMTP id
 956f58d0204a3-66f814d5729mr574191d50.36.1788166981090; Mon, 31 Aug 2026
 02:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-common_clk_mt8173-v1-1-2d7241f70379@chromium.org>
In-Reply-To: <20260831-common_clk_mt8173-v1-1-2d7241f70379@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 31 Aug 2026 17:02:49 +0800
X-Gm-Features: AcwNN1VqX8uTSrN71dAKaA8eOGbgkkf6CrhjupqKO6wVb7uBj_O5pF3ip4I9SqE
Message-ID: <CAGXv+5HaxFCfe4FkPih4z_kPKc_k9=uighfoxjpD1r+KJ=PZ6A@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: Add missing depend for COMMON_CLK_MT8173
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Brian Masney <bmasney@redhat.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:50=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> PM_GENERIC_DOMAINS_OF depends on OF, by adding a select to it without
> adding a depend on OF, the following warning is triggered:
>
> WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
>   Depends on [n]: PM_GENERIC_DOMAINS [=3Dy] && OF [=3Dn]
>   Selected by [y]:
>   - COMMON_CLK_MT8173_MFGTOP [=3Dy] && COMMON_CLK [=3Dy] && (ARCH_MEDIATE=
K || COMPILE_TEST [=3Dy]) && COMMON_CLK_MT8173 [=3Dy] && PM [=3Dy]

I guess this happens on COMPILE_TEST=3Dy with !OF architectures.

> This patch explicitly adds a dependency on OF to solve this issue.
>
> Cc: stable@vger.kernel.org
> Fixes: ebd0b73d2137 ("clk: mediatek: Add mt8173-mfgtop driver")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks!
