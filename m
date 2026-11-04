Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799936;
	b=K9oAreFgFtI1Xemm1CwNcYrzOqZ2lkW1NPxioW/oCOxEs/rn0bFRdqmx1vdUKIH1xDQS
	 D1cKdoTLUtnECcuk+bmon45QeFG9FNt960yo6IZESrDxMiIL5JqaKvQbO6veZb418bAw+
	 b9+SYDprTil7xRdGX7vtCubzefN6aUWvLaHzYjy8PahWym0akF3lfsrB5uYM5UlMcdfeZ
	 Z74ePBVNhDIMT8n0pmUFbGx2qXicpmEnwXN3kCBi2HR8iloLn883OP+u7YGv+ip71xjGo
	 GLeR+KRMjnU0hmi2bWQKlLYcIsrEggz41WH8diUOj4bR+EtDRgovjBtHBU0q7gPgFIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799936;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pZa1DyQ5dhNm7IcWztDUNPVGU8LXVDzTyG5czYuorX4=;
	b=Em1JONR1pZ9I2Mdy70XXpLMtl83cyRfrBnwQpLirTlkl+FTyKvYfJ9D0PbU0PHVZmSaH
	 HaWl1EF75zqWjdCKZxXQq3z3ghcvN05KX5xD5NjSORyG5n64XAsQNys1TBBrzksMBsRaL
	 /NsL3S+I5XmfLOxH9EUnyuYfOedppd5CdqgAElGj8QUHYJCuSlG/x2Ydij0kws6HKzl5X
	 eTUcft1VJcVb+qIVYqDCiTjPdTHDXXPGop2r3cDFF8bcC24pve4YOOISsjMCe7y5egvlv
	 4tgFZ+70bBJ1iohYfAcyANyWUcoFXkjVzY+yYonDpsT2a9EQQZFKe6wCjyzJkLHyd0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Lu+/V23W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D1606A333
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lu+/V23W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEA91F00A24
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793799935;
	bh=pZa1DyQ5dhNm7IcWztDUNPVGU8LXVDzTyG5czYuorX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Lu+/V23WSycXM249y8TFrnUl6pnNNAczyEkfJCPCcFSEDGnHvAN7R47uN0Rm5YOlb
	 ksG0DWFJDoGQ+XKsxZoHcJhImNa1vUI5mxCJtznQwwm/t4wIw5e0tI3Yg9k/G5Q2L4
	 fFOeO1onHFqwKzLY6BOr+KyXDJBhmwRRPEGZsgexcP7HEkhp7/CMW3ntJanVhf1YZo
	 5WyloPwOjAsMwCQDPkAohS4CsCRQgv2FQ37+rA546fb0XUaQ/t5gQkWVarjo16xSYG
	 5NARaUAeW/UeaP+rLZbakxwAbDsZ/H+MwVTMzvs+TyERdbiaZITZCeOw5ej/Jq7sIA
	 PvV9EmRDWCvEw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a9a1ed66b9so5785541fa.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 05:45:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwRE3aD5FLLqN0a0scA+0jgKd0bHEJ+R3fj6CkkKLg11vaIRW7UnNzSa4T/Lb2+0UgymFp7Q9s=@vger.kernel.org
X-Gm-Message-State: APuU4Z89Ps3erDVyQ+bpFYSxGKTolXUi7Ef1XkgyZyTvnMOw6cf/w2KY
	NPoBZuEnOr14Ypu1+pfCuQKuewUV6LNSqxYmxJe+vrCTNIL3Gpmh/BUWQw5C0czOUSs4r1Ddv9r
	8JS7Jb/xBk8mOA/PpyzlWwmzG4hxgjTI=
X-Received: by 2002:a05:6512:3089:b0:5bf:f559:2d10 with SMTP id
 2adb3069b0e04-5bff5592d49mr943044e87.63.1793799934435; Wed, 04 Nov 2026
 05:45:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026040230.22338-1-xiaoleiwangxiaolei@gmail.com>
In-Reply-To: <20261026040230.22338-1-xiaoleiwangxiaolei@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Nov 2026 14:45:22 +0100
X-Gmail-Original-Message-ID: <CAD++jLk9BUeA6KEiER16ZEemBkV_k_EdUDmbEf=DLjbSsyO=5Q@mail.gmail.com>
X-Gm-Features: AclHuK9G39re6JxrJ1z-ZGqu808jbf6f0YNR9rG3WzY_Xw8qXMct9UAID3GD4J8
Message-ID: <CAD++jLk9BUeA6KEiER16ZEemBkV_k_EdUDmbEf=DLjbSsyO=5Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: imx: scmi: replace custom dt_free_map with pinctrl_utils_free_map
To: Xiaolei Wang <xiaoleiwangxiaolei@gmail.com>
Cc: aisheng.dong@nxp.com, festevam@gmail.com, Frank.Li@nxp.com, 
	ping.bai@nxp.com, kernel@pengutronix.de, s32@nxp.com, s.hauer@pengutronix.de, 
	sudeep.holla@kernel.org, cristian.marussi@arm.com, peng.fan@nxp.com, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:02=E2=80=AFAM Xiaolei Wang
<xiaoleiwangxiaolei@gmail.com> wrote:

> From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
>
> pinctrl_scmi_imx_dt_node_to_map() kmemdup_array()s the pinctrl configs
> of every pin into map[i].data.configs.configs, but the driver's own
> pinctrl_scmi_imx_dt_free_map() only frees the map array itself. The
> pinctrl core releases maps through pinctrl_dt_free_maps(), which calls
> dt_free_map(); the duplicated configs are therefore never freed and leak
> every time the DT node is parsed, e.g. on each (deferred) probe attempt.
>
> Replace the custom dt_free_map with the core helper
> pinctrl_utils_free_map(), which frees the configs of each
> PIN_MAP_TYPE_CONFIGS_* map before freeing the map itself. Its
> signature matches pinctrl_ops.dt_free_map(), so the driver-specific
> implementation can be dropped entirely.
>
> Detected with kmemleak on an i.MX95 board (FRDM-IMX95).
>
> Fixes: b755521fd6eb ("pinctrl: imx: support SCMI pinctrl protocol for i.M=
X95")
> Cc: stable@vger.kernel.org

No way I'm sending that to stable, it's no regression.

> Signed-off-by: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>

Patch applied as a nonurgent fix.

Yours,
Linus Walleij
