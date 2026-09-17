Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A023AAF64
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683747; cv=none; b=czVe4aJZ9rcYJxUVVZkYsP+HWCwwNr9oucbqDb4Wuol2CcapB15glO365mlzyBJnDzU6MDEgrpYb6suG0gwHF81gQfwm8Bb168MF8AxjoKYgLtuczgTAyUP71BphndvsEgeLq5tR0Dfvuy0WgjXnHBt0jXFoRX3KfpF3b0EVcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683747; c=relaxed/simple;
	bh=9o1EWy3p6EhXJfc74bTuOh3PFxjT8ee5exqwfJnsyOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7Gk0+6FMr/QhPmtbNhJCxPYVd+Q+zBiEDKXOo34K+/iLQCbnlHjE6hJbk2g37w1S8ZyEoZNAHL2PZx+BawOQGLcmjw56wuL2Y9GDjpNH3JZz1emByrZKv5c5wTiJ30XUUExSolXYzFXa2RmoSy1Lf79S7CDYo9k/6RNzOw23lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXldGrU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXldGrU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE71D1F0089D
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683745;
	bh=9o1EWy3p6EhXJfc74bTuOh3PFxjT8ee5exqwfJnsyOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kXldGrU9TIdlgTNX7r0CSqUt9F3GamdUXXmVbuomj6OkpzMxlKi8fu4zK7mOiHk5G
	 aMzrbdElZhWDj0CAXfLIXQmduKvvkSEdT28ncI0OCsY1Q3ONNLxVIkgHEByoepSlXF
	 XhtihDH4fbrlkKJQ9QoYePdClc71uzVRSwBETjRWiEd95yfWJtO7eXMof37IQuNReT
	 FnqsN+N/A/ApBMis50rTPzhK2QksqnjgzaTj2wvmB+s7IEHqQZ2+H5Lq3aErwQ35ef
	 13bCENnoX/g3YpCv5H3zmwYhy5M8pBjVfCHUl1e7nBaC6Dxc8xDjVYcvATmg3mNqAX
	 RZ/j5oUo0wfvQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b899413537so164300e87.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:22:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByBPEBI42EHk6CLqOnjLdyTaC6bhcX1T6aRL/nsRWgtWmv2fQEn3cBc6hdTl3khQt2y+sW+fRQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kzydrR7qlahTbLwURnRR7MAKo5dDFfYf1KolXMEQMOQ8eOzoL+
	HO1cwR5XjVJGWfs+N6SHmM8Ul32zQW6ZV4vaIThiTQr/az0kngKRrKsfEJTave20Q6vLGwrKbJX
	+vq8aJE2ByE6yvcwN83MdIAOManT4664=
X-Received: by 2002:a05:6512:3c94:b0:5b1:5a31:86b2 with SMTP id
 2adb3069b0e04-5b8c17ffccfmr103340e87.16.1789683744541; Thu, 17 Sep 2026
 15:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917104920.2147568-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917104920.2147568-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 18 Sep 2026 00:22:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLn8zuuBQKXTp_-Z9An2Qb-axBet5jwtyp+iecyUR_c0Og@mail.gmail.com>
X-Gm-Features: AcwNN1Vugsl6EYyA5YZR_TiINZ4OJKT5TpyjtLwdC1N8TlAJySegdEm3DnltlaY
Message-ID: <CAD++jLn8zuuBQKXTp_-Z9An2Qb-axBet5jwtyp+iecyUR_c0Og@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: vitesse-vsc73xx: Fix SPI device reference leak
 in vsc73xx_spi_probe()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	f.fainelli@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com, 
	paweldembicki@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 12:49=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> w=
rote:

> spi_dev_get() takes a reference on the SPI device, but neither the
> probe error paths nor vsc73xx_spi_remove() ever release it, so the
> spi_device can never be freed after the driver has been unbound.
>
> Release the reference on both probe error paths and in remove().
>
> Fixes: 95711cd5f0b4 ("net: dsa: vsc73xx: Split vsc73xx driver")
> Cc: stable@vger.kernel.org

I think we don't set this on networking patches, the network maintainer
decides himself what is stable material.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
