Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449569;
	b=Hr8EyC5VYd2gsVy6376ZbRPuQkTdapgztWhVVvecBQeD0IMuLvZG/SfYarPxHI704+qp
	 Leg7M2OreLMN0xot2aPVCe86sZaP9e5O1ifeCyUN3FDlZHyvvZnqemtRDNYnI12KctqjO
	 L5SE0x2wq1zF4JJ/kpB0FbLGYOWRMsNmDIcoMbnXIe5EZ7GfzBhNNxqCTZXSRm+SVcV5T
	 O7JaVNhKEaupjzAhUs3XDx7SGqbxeigiG4kIXRnAOmE5kqX4iNwEa6y0RFmqeiqJ/CrYI
	 aHlYq8l8Egm5SGCmtuM31I6+nGiJeAGEo3jF+iCBfFpPLra9opILMmHgGkrJ1XNHguQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449569;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=z1gOcE4sJDHdxNv2xjdQJHwE41dUt343uBhIQUVlSbo=;
	b=5Aup+e4nna9zdJXNH0QQ1rVeE/9dAx8lqT+hp9jmwXahPUibul7RHQadLnahPx6ugKq1
	 GJ0AEUkVliOWxKwAhC512e0lfteLwHQvuk1JFZFJyLkhjkJCPLkDLrhtO7S3W2HsxUeOp
	 WeDOPAaoEXZt118zNgrjgM0HgV8l3sq5hY2ZRysN27IdagR5oWl3qlqkT78uHaNNTpzFq
	 hT3HburmXZktPZJ1fD6hxla/XB9kYbOafipSvkto26FZHYREf0hOvT2K/vALYNFDEB4PP
	 /rY03t8hEVuUhLGNLiJUrwttesVtLl8GhOxt0s0tgnjhwL7E6RFe5+0uIid3GoZK10Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyE4WWr2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F543606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyE4WWr2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC311F000ED
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449569;
	bh=z1gOcE4sJDHdxNv2xjdQJHwE41dUt343uBhIQUVlSbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NyE4WWr2bYRyPrtQ0BjND99uXDUVHjV+msu5AQC0qgAw9hX/r+VNrMLcx9T7n81fe
	 KpKL0RkZox1E86XW7DiiT1SQPvuXfKfEN0AX2YJWgJL2HQHwyGXPfkAdDr3e0Sm1v7
	 CTL60zgorXfY0BW9Bs7JUIiB4+PkhBjmBbNpl7PHIchzibkMaGHvn7oFXGHm9tJi3Q
	 F09Dfj/3szF+1Af86s15Tzpu7ffaRvExTQBld/V4GjVbowyoPQojKTPKrCWYtq+y7s
	 0lTKmCxccJgZ15Hkq/OPevcuuZ5UDqD54fOWLadPibHRFirQpl6nSMXqwdJ6tdz2Ls
	 ldSfzOa1P1HHw==
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a2761c69fbso2342727c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:59:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHA6PjTFFUlBACA4Dug70zidUegjS7AplXhbYpFGhml7YfyasAWhDXGqczx62oMx7ofowQw0Js=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tcBFjevcuR6hZHXxfCiUUtS1UUI0KnSlsmhmEWCG9rAkqcwg+
	KRRobndTDc6vSnEMAT8TXKmvjQm8r8EBx+l0+LcxnAQSLy6tByBbb7MwfBWl4ddUPJ90oFC9X9u
	jCwRIVEsG7bKORyxC7pXxZWuIulre9w==
X-Received: by 2002:a05:7022:1587:b0:1b2:6d5b:36bc with SMTP id
 a92af1059eb24-1b5568efd35mr14176365c88.23.1795449568635; Mon, 23 Nov 2026
 07:59:28 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <confirmed-20261105-38-2e09963f1b23@gmail.com>
In-Reply-To: <confirmed-20261105-38-2e09963f1b23@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 15:59:15 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8cH0mYNqneRvrLnXoiYfDajs2mC1QDQNLFBbO_h6jzDg@mail.gmail.com>
X-Gm-Features: Aa3M54ouwi-KBChskOnrEwzeqY5DzbDhQkaCtvHg-m39Wxz8dX26BLU8Xe3rDyA
Message-ID: <CAAOTY_8cH0mYNqneRvrLnXoiYfDajs2mC1QDQNLFBbO_h6jzDg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Keep the mutex node reference across
 deferred binds
To: Yige Jiang <yigejiang86@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yige Jiang <yigejiang86@gmail.com> =E6=96=BC 2026=E5=B9=B411=E6=9C=886=E6=
=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:20=E5=AF=AB=E9=81=93=EF=BC=9A
>
> mtk_drm_probe() acquires private->mutex_node and releases that reference
> on probe failure or in mtk_drm_remove(). The component bind callback does
> not acquire another reference, so it must not put the node when the mutex
> platform device is not available.
>
> If this bind failure propagates through component_master_add_with_match()=
,
> the probe error path puts the same reference again. A bind attempted afte=
r
> probe has returned can also leave the stored node without its reference
> for a later bind or remove.
>
> Remove the bind-time put and leave the node reference with its probe/remo=
ve
> owner.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT817=
3.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
> ---
