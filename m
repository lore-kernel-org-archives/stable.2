Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795338709;
	b=AxHyHjhyqZhP0DiryEK3Wjz2HCJFkgeiUoPsPM3Qi/Hxe2JNpwi+F2G/llgOulZice2W
	 tIZuNzNWpZam0SseVE/HoxCpgmcdBc8H8JPezGVyOrrjEruIr+koQrD2RUXmXHc+xj8AU
	 HsftbhXC4kiYozpeQ/kuGB/aXKpLno5CP6LdEmp/Fpqtp6AHsxrAZEVG9ZAyx8zG6ABIo
	 32otpMfLOT8hGUlZa+MWUgQGE+uSYdqOCOGEbUNeatPI8bR50x/ktzxLnTxZrFhNhSiCX
	 MBg8gMaTVNHEnDHJ05D2Iv1nzYMmuWhBdFq/VOwdo4W/I8IaUmabvxk7dw7WMGghv8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795338709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lYEphzy4ZTo14yzeEAHhxhKUuleMHJNSxpY9AD/9Z4s=;
	b=hhSf/yC3pWyAB5N0SbgTXHlzik/aMYTkudQTnnsV8Yyk/gfWqQ0nAvoX3CqvBfizLgdi
	 4EN6mZrQHWEOJJQI2EPTZSz50KoA7gvG8yLqquw4Gct6Y7BPs8CX9y/uvv2dCKNaB2Y71
	 0AadUzT81FdQPo7ixYuvSFF7GnP1y1XxrHegcMk2q2wgLsZjc53v1QrjWNMUnniSO4gbA
	 1xegLqTUoNR5TER/TLueLMoxV1KyCmA63sltLsaOmVm0bCnpKPi59lG2nyGMDrhd3fqDZ
	 fQcYdz8rcGQ/lJpvVEcXY69XskE3gvv6TqZ1uXhJDiAASOI13K3+//epiiTH06R6G1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uIx3yc/i";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E64606A32C
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43E64606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uIx3yc/i
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab1bb9666aso1689871fa.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 01:11:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795338707; cv=none;
        d=google.com; s=arc-20260327;
        b=KrO0Ql6kslo8LVLnlNPLl15EiONxrKPEPJzZu4UIavC3qd2vzEqW6w4z92Og2HQUCI
         Byw9+cmHmUoVFRL3Z7HY55Mhl1IFLd1qUZOaHyzoPjKX5/bbkylK6/zFiUKb0LC31Ioi
         uQQZ4cxjqdQLfAps6GI2bTFFLIbFCs4JvjM4gd0RPw2ZaS6G0SJWoRziAT3JgUcyiph8
         1H+A75lX/ueDZ0h27w7LVSCxMN66nIWWlAkMvmEB/ieDTR7/3kzCSfcbqMxslYc+DzxF
         w3FG/r4bIjAGXnb9v3+5j2FyVYio1/MDAh7WuDT/chPt7InRHnKcIBv0CLrfyFbat1Xa
         FAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lYEphzy4ZTo14yzeEAHhxhKUuleMHJNSxpY9AD/9Z4s=;
        fh=YAQKmcpBZRvqe+7GBZaBA1hqRKSf59U8A+OLA5oIZOQ=;
        b=LumHSKk3DVaJRGi/nF22SqGxAgDBDq3tBrok3feL0Z6JRRROrML32OmuzLSn2XG6sS
         lNs9hXqbWjyzchNXPmwNwRZ50gQmnJydhaGTv1NXj9T8rJ07P7SiHkaGXu6ynAfyM0Rm
         SWk2ybeTCWMK32UoujkrXAZee4jJ8hd73JTsxHkVYW4gp0KmRjQXgkypHfhsyxoLnn+M
         iQUSpp2Hgz/JlAIAEPVUe8MN5zKS3tFegD93z6zNeRgeb5z4cjw1qCVZ36VnhFOXysZb
         jEaup0IAyHNZRnUIwJslHjLe+6Q60vsVzkSEJOJRY+2UNAQdIJMEHASp021yRzK/cDGP
         Kd4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795338707; x=1795943507; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lYEphzy4ZTo14yzeEAHhxhKUuleMHJNSxpY9AD/9Z4s=;
        b=uIx3yc/iG2W0ZwLaYU4W3A4EJj6GSTn3YJ+PruVOjxG387fRjg+o7faziluMLrMIVO
         vUxVPMTC8bZF43qLDT7lGIny4AzKbI3TSi3zpqm+u7sHn87y/Ji7tbvKA2tl756B6dau
         y/KHufJ4wPsjhCvQpVXrZriNNqGL+7YOQ1Ea/+EkpMvcvEwC6FbxjI0M6eFnf4E5G+lP
         nKhvGK6pznIqsf6LlJufQaF4zUY5PVLrb/MQIRUyQiTB+p1XOvNPF3vxsIBzDAuOOuaK
         ueQvuSsorKvv0M/+whXuBx4MU5k+J3nWigyE1B8Hl2hB7ChY1Li4WCyj3bHmMunhErko
         n0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795338707; x=1795943507;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lYEphzy4ZTo14yzeEAHhxhKUuleMHJNSxpY9AD/9Z4s=;
        b=CM997ie3gyCE9sKSGVIlIevsmhS30FixERm/73hQvCxFWmjQUKd1D2jrQ6AOdPCbzF
         22EgX5FdbX+LqYFNx2SleP6WjZ4lqt0Kneiv0SE8aVIE+gWRTIi9okVOwcuHgy8z5Tq4
         yrA9rqDQsF0J/jg7wifbsyOoBohZHFM46X+IYyoIGVcuVxW9ZnCIsLMYiA+zDmt0zSIj
         lflLIEwkuCsy7hOhIucSNAgu5rnuwf252cotHBmboz9z2jWKZkHc6BUEEy+v1sO4JgBu
         7GJvj3LPr7DDdXw/DwoEYIB3Cz73P6j31bXZcQlE0Oh09vB6pynEG8La89KVKN/e8pUY
         F7iA==
X-Forwarded-Encrypted: i=1; AL+hErHgdzrtrUTwvO/4Kqp8aIT8odDWIcqbcCnjsYsBDu/MByfFa0yr+K7/dyQ5axUUF5FdE3lHTPs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Zk/+AU25kgvrU7okece+gkTaIazSoiHUtQBJDpAUAEMhN1WWD
	HPwznZFMaGcCPjJwnSIn/xF4159KfufhiIELcafzXmlcP4c1QjMprd5UqUivYsr0GnMBCKZAh6Q
	m8L2ric2kxWWgsSnfkuVqwItLpIMFtqY=
X-Gm-Gg: AZFdTZd6eQCMS4p/0taVgOoABap3rLqXuV54IDM08RujFRlpx7h4i4Di5iEtE8y2ihd
	rGx9eektKHTomMBJe5O3UV++OTz1GROARn90dFzPylZWgDv6bnP1psJzF1U6XlZgnSR+nJ7qEyj
	v4Q9XAkIO95eyS+J7zcaOUTVVJFL5qFq08WndiidsiewSzCRFQsnZW3URtaUlaVPHItCU1qZv66
	BJBVPqR6DicqumeRH2GTpxRRonGiQTZPNPwE8DbG52e8pYzx29hvi5B1Ql0FSqBEQI+XvgMbt3k
	PqqD5MRptpVo570PmCgn863TG7FReSpo4fdORNa719sKzUiH7J1QI7N3IjegZIzpxoSzifkczbv
	ccXND8yDAZLYWbY7F1q5h4naOqDfOLuiiJ30qGpa4tRhJJOE4IbQ4p6zfQ+H2ZAztNNpEtkWu
X-Received: by 2002:a05:6512:4382:b0:5c1:57ce:d4b4 with SMTP id
 2adb3069b0e04-5c1bc75212cmr2114507e87.2.1795338707138; Sun, 22 Nov 2026
 01:11:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-sun8i-emac-mtu-limit-v1-1-22492842d318@gmail.com> <CAGb2v65w3cVgxb_G38UgKEa4ErKLN4qiF05N3nmdJbmPeRRNBg@mail.gmail.com>
In-Reply-To: <CAGb2v65w3cVgxb_G38UgKEa4ErKLN4qiF05N3nmdJbmPeRRNBg@mail.gmail.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Sun, 22 Nov 2026 01:11:34 -0800
X-Gm-Features: Aa3M54rEVKMx6Ef6xvJSXV2IbIddu5RGXUJDnGgXRbNUM1fhz_Gu6V3X74W1H_Y
Message-ID: <CAEy9hNVJ5NzKQ95gxN6UWxsgy6HFMMFxGYZ_sutmdb0gL3qRbA@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-sun8i: Limit the MTU to one
 descriptor buffer
To: wens@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	LABBE Corentin <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Russell King <rmk+kernel@armlinux.org.uk>, Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, Nov 22, 2026 at 3:26 PM Chen-Yu Tsai <wens@kernel.org> wrote:
> So what's the overall plan? Limit it first to make things work, get the
> fix backported, and then fix jumbo frame (>2K) handling so it works
> for any MTU value?

Yes. v2 for net limits normal descriptors to one buffer in the stmmac
core, with the lower sun8i limit on top, for stable. The jumbo series
then goes to net-next on top of it and lifts the limit for sun8i:
https://lore.kernel.org/r/20261112-sun8i-emac-jumbo-v2-2-aca0cf23cf17@gmail.com
