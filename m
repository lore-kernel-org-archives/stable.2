Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871246;
	b=B9TsxyZ6fbBBy/BccInZaD2AZdlVzApXvZtusABLSjt0/d4ERHAzhNmEe/p2/D6puuRC
	 Viz5Noo4nub/Yi9qOn7X4I8K+GegvVLf1hHp25Wi6dH64+y35lz4I0xGK0MVGWcypUi0h
	 tHa3yrCRm6RKOLFVlrbtG+Hij6G07HVK/zuN1BvcZvLMwX1yv83aN60YRkAffH/51Xvxp
	 +1krKFLSOAyfap0WmbRypKOjlPXPs+4VYSZ5OpjJF6/dlkCIImDEJi44MWP5cJTuczulH
	 jK20nIIDHlARz7ItBiOndVoy/GxuoDwPB6yxZGpcvlEo/+C3q4gnA6LCfX0BYW7h6BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871246;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iBOfy5O+0eohQ89wWM3JHoeRMFw720CvWts9Mtt94kg=;
	b=zJC5oiDLmOHQcA8niyuLOd4hgPIXk3bOGQ55TUlzPEKTyxU3iCTFPNgm6hWFayVbk79x
	 wJea4C8oe7+5cb/u7iP1jegB37qBf8rBAIojvFiw4l9hBrHQvDfC38yV/pAi3ojX1wiYj
	 Et+iGUJq+s34OVNVYL1UafDaZ5p5LLCA4IdMiGQslVwZkFzMO+4tR5wW8xbNqu32Wifow
	 DCy9C7hLQcrSSzUv6JCbkfWWi8k7VXGBf41W+oN6FPIQQ23bSApxlhcBOJB8gmZhji+b2
	 sGH0cPYS0JjMIdWhuLaWuoz5vkIZOBmsjOfMER2O3yVS7uBfzNnx3ohNxUo4GHN/ROw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kH2/2Thm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05139606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kH2/2Thm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CECE1F00A18
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871245;
	bh=iBOfy5O+0eohQ89wWM3JHoeRMFw720CvWts9Mtt94kg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kH2/2ThmSmTuYrAqoZWP06MhveGLpQ7yH69j1W0W9ppNRp+veQPUYmrYbLA36ZTcg
	 WMl3HawM8b5g2sErObcuoxuM8NQh815V9gVHjcRldAhHfoIbEe7KFWivmcSNEyeMM/
	 LKEFyiNriYRJkjHYFRraLKVcylAXHuGcEfOM6rX1q1kG2IV3MLva53Y9EFyufrRxSK
	 0jpgU/jBiVxYQ51Tq5ggzdG1uOS9V4Sjv2PJ8yseTBprRQOWFqwTyLG1m74YoaoEuM
	 qw4dBMz2DrF6UJzKbgzI/HYamSx7XtcwlATncpgEjIBq65UrIngq8Zhl9v3QRkHYVy
	 5UHyZyi6r9zjw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso1190697e87.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 01:34:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzwy5WT8Ikto+GMwq7l34umUVy+zX2ToiLb7cI3OClCbiKFYOxQ+tOfZ2WsgwlqL9ayBmBeRc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DoaWe0NoTkX5norL/FTg0EQIF48/4M324yLHoiFuQpdECfuNM
	U/oMjudx/kWxThHnHwyG+uDZSpGhFefZv45Ve4TXOIIlAg4rmGUbIq4x0cyF+KWFbloY1nHuDqv
	bmjLXr+i6GquGWFKdLCo02ZDyQk0/42c=
X-Received: by 2002:a05:6512:3c8e:b0:5bf:a5c1:d11 with SMTP id
 2adb3069b0e04-5bfd957cd9amr6465740e87.64.1793871244374; Thu, 05 Nov 2026
 01:34:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103213002.1673560-1-lee@kernel.org> <20261103213002.1673560-11-lee@kernel.org>
In-Reply-To: <20261103213002.1673560-11-lee@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 10:33:52 +0100
X-Gmail-Original-Message-ID: <CAD++jLmREn-duxqZyLmY97DR_TKiDLRgxiJiy=cno6rdosa8YQ@mail.gmail.com>
X-Gm-Features: AclHuK_c9EDZKaN1V7Dk_kEOYVVIT2evfGZYSvNiUvKlEjAfXzbR3MVATtMhYcI
Message-ID: <CAD++jLmREn-duxqZyLmY97DR_TKiDLRgxiJiy=cno6rdosa8YQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] pinctrl: qcom: Check qcom_scm_io_readl() return
 value in msm_gpio_irq_set_type()
To: Lee Jones <lee@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Ajay Kishore <akisho@codeaurora.org>, Christian Marangi <ansuelsmth@gmail.com>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:31=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> In msm_gpio_irq_set_type(), when pctrl->intr_target_use_scm is set, the
> return value of qcom_scm_io_readl(addr, &val) is ignored.  If the SCM rea=
d
> fails, val remains uninitialised and its stack contents are modified and
> written back to the hardware register via qcom_scm_io_writel().
>
> Check the return value of qcom_scm_io_readl() before modifying and writin=
g
> back val.
>
> Fixes: 13bec8d49bdf ("pinctrl: qcom: use scm_call to route GPIO irq to Ap=
ps")
> Closes: https://sashiko.dev/#/bug/linux-a5545ffd-48cc-4856-94cc-4b2dd7968=
f50
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

This patch 10/10 applied for fixes.

Yours,
Linus Walleij
