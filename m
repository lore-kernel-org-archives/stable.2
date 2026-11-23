Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450004;
	b=yeZ2Y9Trjp8iyi4rAwWFGq9USM4ToUybY7qQktGO3EfGv5lR5nmZ7TDWa5OVrjfzQ68B
	 5FL8cwLzuv/hPLmnkR6cDcHB2o9xmuHKnNu5PZNqXHhKEfVfY9iqgWHQ88N6+jmz2cESm
	 TvqS+flE34kyS+z6QwqaQyjqlQGAmzOSlbGgMPYFs9tLqkvdO4EHm/kt/rFVAAxQb8HWq
	 JOFXGga8x7pO09VD1MNs8Bh++uh+rbi3HJa1Ag6gQiE8cn+zJ9DtpFDWB6ty2QScy20mZ
	 277ms4CxVFXtMWKzHOIohhP0yLX7JikhbE0Z+5V12Z9GZ0pLq+1m5FhxYwINFWhdXrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450004;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l4IBb4xjYzTBoSi6YXuP+odsV5j50E3nqTxEjgiJFXU=;
	b=WujLB0jfKomGygZpv8ecPTFKmr3X9TVpKVoq5Rwrcdq0Qz+tGYZ2qOVYeqv2NtOswlJZ
	 sNXgg3px6oDyS0MESSg6KG8N8rf5h6vVlOZfX9mJuwiKpZlGSU4Q5tyBRapqS/x8oPsG/
	 6isK7sxh4/VW3Iwm7O/FkHx//L0+Kyf1eR4WHGjL5/FzNlpFIi454Qmao56snumYFZCyG
	 gzkbwSffnL1jJBVRLN7lOj7wRN/U33c89CbyX2WqV/Wf5/fXtDen4FuRzuMX1tkyCwheO
	 sSmK1uUhDOBJfvh9HLorFMNQGTSN8uKZDkUSXrc57pkdB1oWoUICE8TqThjWicXez+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ScMHru2V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4B606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ScMHru2V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939F21F000EE
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795450004;
	bh=l4IBb4xjYzTBoSi6YXuP+odsV5j50E3nqTxEjgiJFXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ScMHru2VIvuBRXLr3rU7S50QEYGVjq8CNRcZ90X1RmgFFmqUXmI3YULA3G4VvlSEq
	 6mWi0Mkcg2NuWySrlMfFaQ4/x2Y4L6H8elSGIcBStc29EiUNOuhieiTLqJpRHA7mWU
	 GR8SMyiofhxm+IP4nVcQwSQZzhs3MV1VXi+S/zSDs4xJP2J2jqOTFed7e+gIF0Ss+C
	 SHJj9cl6aFc/v7iLXUiIWzzKBMuJU8l0Mp/CyL1OHWbZXjGWWJt9D5TqcYLtSuWfeB
	 KnvoDyxvXa6KA+WRga2yvZfaxAnV3N2jlDdP+Cpzr6WRV6vy+ctOrPsqL/m7vH5am+
	 cXJXpWRXCxqUQ==
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso4376244c88.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:06:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEKm2NDAWainN9Ru5nUP+DJmzpXP0qwXNk26fQ3YQ6cIsSUE+zf/XFFq7zru8Rny9UOoOCsSHI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HKKf9mjbxPD3Zf1tl4t2Ah5ET+yTjUyhQjEVc16X7zxUq0SCj
	5KFZnr9015hH0uWu/c1f9ZAeqpAxbJtZOX/CGKp8SOTxgKPzjIRMXetpVOS5AAWsIL79hQvFZrU
	YvIFek0CD8P1tpOpSaYFU/IQn58yYew==
X-Received: by 2002:a05:7022:b056:20b0:1b3:ac53:da84 with SMTP id
 a92af1059eb24-1b5568e371bmr13106997c88.32.1795450004014; Mon, 23 Nov 2026
 08:06:44 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
In-Reply-To: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 16:06:30 +0000
X-Gmail-Original-Message-ID: <CAAOTY__tykvuoNWOD3ZMy1etCEwPPJrvY=y5xOO7h7DL=ErRdA@mail.gmail.com>
X-Gm-Features: Aa3M54q66gFGZx_hKSNABqOrF2C_XAAy0XYCXxVeneDbJLO5H6L8BwiOx2EzBXg
Message-ID: <CAAOTY__tykvuoNWOD3ZMy1etCEwPPJrvY=y5xOO7h7DL=ErRdA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: mtk_dsi: do not enable HS clock in
 pre-enable for LPM panels
To: rva333@protonmail.com
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	Gary Bisson <bisson.gary@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
=E6=96=BC 2026=E5=B9=B411=E6=9C=8817=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=
=E5=8D=886:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Roman Vivchar <rva333@protonmail.com>
>
> Commit 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during
> pre-enable") moved HS clock enablement from mtk_output_dsi_enable()
> to mtk_dsi_poweron(). Later, the commit 3e191eddbdcb ("drm/mediatek:
> mtk_dsi: Enable HS clock only at pre-enable") moved the call to the
> mtk_dsi_bridge_atomic_pre_enable().
>
> However, mtk_dsi_lane_ready() explicitly sets mtk_dsi_clk_hs_mode(dsi, 0)
> so that DSI panels with MIPI_DSI_MODE_LPM can transmit initialization
> commands in Low-Power mode during their prepare() callback. Enabling the
> HS clock unconditionally in mtk_dsi_bridge_atomic_pre_enable() overrides
> this before panel prepare() runs, causing command transmission to fail.
>
> Only enable the HS clock in mtk_dsi_bridge_atomic_pre_enable(), when
> MIPI_DSI_MODE_LPM is not set, and restore mtk_dsi_clk_hs_mode(dsi, 1) in
> mtk_output_dsi_enable(). This is a no-op for non-LPM bridges.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during pre-e=
nable")
> Fixes: 3e191eddbdcb ("drm/mediatek: mtk_dsi: Enable HS clock only at pre-=
enable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
