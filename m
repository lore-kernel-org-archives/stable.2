Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091353;
	b=TFHNlnCdJP31A+OvFvRtxkAivtkb+MhrzuB27UrZtxeO9XNACSKiaMH8E4QKKEU+Q6U9
	 2ydidFTnqIGIlGejBzn4Xhi3kjByAO9g0E4MA1wSty6qPfNSErx1WAP6Kd5VlVjZyF+n+
	 WPPhDE2GEiHqg3A6C/rNhgh+VCsxEY/HvcYJF3+t+TV3DG959mSkYXxKAUOi+2sL8T1s0
	 L52jj62/gzssQvMD9Fam2a4hzD6adftARq3H8J1BBP9nnZ3iC28RX9svW0ZKNnpb8C7IF
	 shuXj99+0dfNOGzxL41b2BGyIiWwScAfWV1WkZ0mSbgUEIxGZWjrRlt8vWpRjUZ5TNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091353;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=N+roS2hjC/wcKqOTe3oUy3DxdOVJ6Kmbylk65hYNNtk=;
	b=h3EcYBFEpbHN50Cw9dKDcSCxMQuywgkk0wemxidM7VeVmjdQo2f3Mul3FMiMq0ZsNzMG
	 Fjxl1t8WsAotnkTsyivLsShofWcuCbeunRHuGQ9jDnzXLm7hRnbS2NSeN8AfC+K0yY6V8
	 mO53Xlf8mLjB/DuyMAPXHh4L+bdQ8m1PUGSSAUCgT35wvDK1cyR/055qUrRDHI9rMq5iA
	 HSAEEWzWLCCVNMfJIJjsSIof0WdxCwZER3+v+MOcOe6o31uJNn7iN3K2QdC2UTFzK45J4
	 gq5Zf+VS+h8pQDIA8UZCiKW3CwfiYA0FrmsQSIJuG1fRHWqVnOpOw9c95sphD+Dm2SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X37gobev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32354606A320
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X37gobev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE311F031E1
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091352;
	bh=N+roS2hjC/wcKqOTe3oUy3DxdOVJ6Kmbylk65hYNNtk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X37gobevIHgsMWSMYDxBeNnPo5a57h+FI8Gu2W/EisrKRqyvPj5y089nAShzkr4Se
	 fTCv2Me9O0hWiOIYCwp5knFJKrY9A806+37t/WKQ4KGNLNtN08oFhrNH8/CojLQGGb
	 ygJqjTkshmkxz7U1EgGHtwSkRVqbEc+76ei/qmgCktrhaOTjFGJRjqrQ31HHZys3N4
	 35hWdiceB5b0NPpuerTYaP679FuQD6lIEo1thGQci0I+wRAykucHVaxv6Hq/codD7A
	 4H0/enzB8NJAG6EDmgG6v9f19yzowMM9PT6tmJUHUTi970bkgicGXZp6QO6JxmMD4z
	 RhhiCmpJWTRvw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so537318566b.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 01:55:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwVAyRE8/2QrhoF9EWmlEPlyHptUf/seyP/26Jm721ECauuv72zZcBT5cPZcYOxQNUoCRLybWM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzun9qWG3IEv0h8QgHqEh6aqY1x4/ZePNSApvzegxP+p/g2E3H
	e0ztdVYFMHHvj5v9QqbglK6Xz0nViE62tKde788ZwwCwjDimEuETb57Bu90qt0Wbi4F3Lq+++g9
	hDzp10Gfd/yZL1bjCWyfR5AUHoFZA9o8=
X-Received: by 2002:a17:906:c10b:b0:c46:5973:2a1c with SMTP id
 a640c23a62f3a-c46bde8d652mr999291166b.37.1793091351751; Tue, 27 Oct 2026
 01:55:51 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027065012.191348-1-chunyuzhiqiang@yinhe.ht>
In-Reply-To: <20261027065012.191348-1-chunyuzhiqiang@yinhe.ht>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 27 Oct 2026 09:55:40 +0100
X-Gmail-Original-Message-ID: <CAMZ6RqJwMyaz_qO9grYU6JQcMQEr0vBJUngNHAqBuZP=Apk1nw@mail.gmail.com>
X-Gm-Features: AclHuK_J4bDR70cIab0Sgh5kSlTN88NyIziCXhnpSwYOehbkWFZr8tbpcbD0YAc
Message-ID: <CAMZ6RqJwMyaz_qO9grYU6JQcMQEr0vBJUngNHAqBuZP=Apk1nw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] can: dev: can_fill_info(): don't wake up
 controller if interface is down
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org, mkl@pengutronix.de, kernel@pengutronix.de, 
	haibo.chen@oss.nxp.com, shawnguo@kernel.org, imx@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue. 27 Oct. 2026 at 07:54, ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht> wrote:
> If the interface is down, the CAN controller might be powered down and
> its clocks gated. Don't call do_get_berr_counter() to read the bus error
> counters if the interface is down, and adjust can_get_size() to match.
>
> This removes one trigger for a synchronous external abort seen on
> i.MX8QXP when "ip link show" is run on a flexcan interface that was
> never brought up. The underlying cause is platform-specific: on i.MX8QXP
> the CAN clocks are gated through the SCU LPCG and the subsystem shares
> the IMX_SC_R_CAN_0 power domain, and there is a window after
> pm_runtime_resume_and_get() returns where the clock has not reached the
> module yet. This patch avoids the netlink query path while the interface
> is down, but does not root-cause the LPCG window itself.
>
> As a result, IFLA_CAN_BERR_COUNTER is no longer reported for down
> interfaces. Userspace must treat the attribute as optional.
>
> The issue was triggered on an i.MX8QXP board by running "ip link show"
> without ever bringing the interface up:
>
>     Internal error: synchronous external abort: 0000000096000210
>
>     pc : flexcan_read_le+0x0/0x18
>     lr : flexcan_get_berr_counter+0x4c/0x8c
>     Call trace:
>      flexcan_read_le+0x0/0x18
>      flexcan_get_berr_counter+0x4c/0x8c
>      can_fill_info+0x1f8/0x434
>      rtnl_fill_ifinfo+0x8fc/0xbb4
>      rtnl_dump_ifinfo+0x364/0x448
>
> This is the same class of problem fixed for m_can in
> commit 91a55c72a821 ("can: m_can: m_can_get_berr_counter(): don't
> wake up controller if interface is down").
>
> Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch on clocks before accessing ecr register")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
