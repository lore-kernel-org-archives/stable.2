Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870617;
	b=bt0tlYen/aq99/3lUTTndrCvxLQW57CPEaJ2Xaj1IJB6eGQ5wABlVoc7ad1+qJ3+wESK
	 EodsL447r0EDaDf6a5dTu5lG4qEEvqBbNBz463g9cb150seGOEiTLIjfy+o7kcdGENY62
	 zqxOBDI2eNCjdP/E3XdaLWIfAk0H8hzhzn/RDBj1n4DiudeBIsfqiNM6Ac6+nbcaT8o2r
	 UHI6a1AEBVkW6SS1cpLAA9N9y5zCnkrzobnn1az1FA7A5CR75ukwkL/mERWlClCva2+Qm
	 hWdaikdNAlGmCZP63OUCxSgXv06O0N6twM7LnXooEuQce7ypXvEaH2Fw/g8KtdGYtew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870617;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CaE2mbFJFf4TOWhow4uSx7nxUZ40EeB+lDQEpmH/lWU=;
	b=R/5kceWard5kTiUlRSPWuWehQZlFyXzeeZxPmvRaPxN2f8s/XTELaB6CDX6UUZTE4L0q
	 DOm22G9xnyR+7wVYXgRYxiHafeWF3APmEgTNA0H0b9roTyzBUnyUH7OVYn5vkAKzF+HwA
	 ewcSHMtD+FCaiqw9f3146lC4fgY2my4ziPMbXP2f4dSPUzcPqC4G/oqUvl0xdpRWZFBwD
	 Yhb5GnLjm4InIZ9DZwVd+fIGPAr9FP5zQbpg/cOiRX8oOv9HKSyXYCYZpjQp1ccuMgX/d
	 UqOf+rQQcQHn6D9pi8KmwpFcEO0T1QTeLeBp5WBZI7yGKCFex3e2h8sMarE5r+56G/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoPNTswb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4DF606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoPNTswb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BB81F00A1C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 09:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793870616;
	bh=CaE2mbFJFf4TOWhow4uSx7nxUZ40EeB+lDQEpmH/lWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QoPNTswbHPNPpf4zeVgFUvtTHoQEKatEp/uqswizvYnP0CXc3ernxUdwm5dzS9oh7
	 UKKn3CE3YDjRjNcXffvCfJMD/8p86nUrbO+Wrk5QdJrWT4u7t213s0pv5Iad7QedZY
	 lGsPfOcLS7d3H5Dn8C9wD6/2yx45/sND3bAtOxbFWfREXtdx6UNxKQxUNvfkpEO0AX
	 1tzw8fHsl3br38ekbwPhQnHVYuskaccJcKVHZGDcowXd1rscGSlwg4DI6EJ2noOq7C
	 3f7v5jn7xkSA3p1avYdYOb/UY4/nJp38MZ2q9wYWyUqM1EE0AU1YP0HP25DHobaaXS
	 RdkMlklfVZXqQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso1393000e87.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 01:23:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByCE2nN7Fbuim5Un2Vk6BSVz73NAM7MxBYfW0Jm1gjH3Zgn5c427SdhwzO4GJcwLeM23P0FUws=@vger.kernel.org
X-Gm-Message-State: APuU4Z89YuxARTJ3hOb1bNfce4aQljxPxXMpckTM4F3lHaF0nzFGrXvI
	nIakYdKa9LLbKQJ2ZQ62KQaR/dABDylRu5YWvs/TQPhUKyiG3+kmIG6ULto9MWloRGmWD7UIFot
	mQ//S+TG0agiFLAmuaSMZydm2Lr9Kutg=
X-Received: by 2002:a05:6512:1318:b0:5be:516e:5728 with SMTP id
 2adb3069b0e04-5bfd958027fmr6146113e87.32.1793870615446; Thu, 05 Nov 2026
 01:23:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103213002.1673560-1-lee@kernel.org> <20261103213002.1673560-6-lee@kernel.org>
In-Reply-To: <20261103213002.1673560-6-lee@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 10:23:23 +0100
X-Gmail-Original-Message-ID: <CAD++jLmC9k6hpkZtcRUgJRj6rk_knjAQ9cOHitRDBn1FbAgZPQ@mail.gmail.com>
X-Gm-Features: AclHuK89aMeIOVygFGusGSM_QZnZVjoeLN0D3bDiQpEYrRyvGRiPkF-dM-Czu94
Message-ID: <CAD++jLmC9k6hpkZtcRUgJRj6rk_knjAQ9cOHitRDBn1FbAgZPQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] pinctrl: realtek: Prevent out-of-bounds access in rtd_pinctrl_find_config()
To: Lee Jones <lee@kernel.org>
Cc: James Tai <james.tai@realtek.com>, Yu-Chun Lin <eleanor.lin@realtek.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.com>, 
	Tzuyi Chang <tychang@realtek.com>, linux-arm-kernel@lists.infradead.org, 
	linux-realtek-soc@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:30=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> Several Realtek SoC pin configuration tables (such as rtd1319d_iso_config=
s,
> rtd1619b_iso_configs, and the rtd1625 config tables) omit trailing pins
> that do not support pin configuration, making data->info->num_configs
> smaller than data->info->num_pins.  Because rtd_pinctrl_find_config()
> indexes data->info->configs[pin] without checking data->info->num_configs=
,
> requesting pin configuration on a trailing pin reads out-of-bounds memory=
.
>
> Check that pin is less than data->info->num_configs before indexing
> data->info->configs[].
>
> Fixes: e99ce78030db ("pinctrl: realtek: Add common pinctrl driver for Rea=
ltek DHC RTD SoCs")
> Closes: https://sashiko.dev/#/bug/linux-60e13761-fd9e-4fd3-826a-47344f36d=
4fa
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

This patch 5/10 applied for fixes.

Yours,
Linus Walleij
