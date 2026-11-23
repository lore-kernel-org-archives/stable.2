Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449325;
	b=wRLYa/1t5tnbrb+bKoUwYpb2EekX2XO6YVXLUlFMOBhpBKGAkbvHjEowwltyyqHmcD7+
	 kI9dlQfwwrYRj5fQ0hsR1glvZ28gwnrvI7LFKD7dB6d3UQhfyQyPlPS4RM8kc9c41iPCK
	 lGuB0dWPedl6Okvkt3HEyB67W7WWONqXwl8SGcgaufPT4uOnOXwITmt34FTAMhupFu2qP
	 UIrQQAPqDQgR7tv9Y9natTF8UoqsuZVDIcFnWR4/zRmMgtuEOv1d2eBoTz01uHEu3CitI
	 WWnn9XMcBz7VJ4JsliiB+/ER6puShh/5JUj6CLMjTALoJsrqZFx76rZQIIIV0LDHPSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449325;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3G6I2HBy1UTihgVzffidRJ8qc0m2dAG1ryDyw90kJ+U=;
	b=QfGtJtcwHUSxexoxL9jIYwKXynw9HF+JZPyyMc+Y1eGLud5Jb6x4fXv8tXN2ecvISphe
	 XRGRr5Mm2Lsa8yCV5p4Ym18Ws48XxLWZZ+rLxsrXR1nUwhCDIv++f5GAY+1fiMtPKULqM
	 +ds6Csp+2kja2EYx9jMbtDRHHfRXlXqkwyEueVFXvmKIErgGdqwacMG8hnagdjSse764J
	 ahXh9mu6q0wiyOv6Q/fehRxGaPucOjxnZZwQcrM1q0xv8BAZ9/GArqQWqgT3/htvC6w5T
	 fdIpnyGliTmo6dnUQPu9hqDjiDgJ4bwmfUGrm1i1SkL0V7iVnR1GfOlLK4yO4+++xDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIPojpav;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF8606A339
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIPojpav
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786C61F00ADE
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449324;
	bh=3G6I2HBy1UTihgVzffidRJ8qc0m2dAG1ryDyw90kJ+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YIPojpav0O7GuwdQ8vBLY/e71DVXviFdsS44PLAZ6U3mzJmNA6TR2JMjsN8z5lxCr
	 DbkvMGQFYOuHHzjMf8u668uvyZWYP73Ki5QI4dd172ddRmjLFNCa1RTUNH56JBlA59
	 DWJcJyl8C/QXuR7xiGNwKc63hL3TIUzKnOEhWm6p/JSDwbCrHijVfhs4JXS77SRl23
	 /lEkfV1otEaHf0WCm2jhnwz3dRQVyDEuB/CgyXWuGu6IpZPRjTt1E7VOxNwDDZILJd
	 Wh0IWvZYsXb6pcvxsO9MTrZusQddlEn9jgt7S6z878feRaXG9PYA+wtFIkq7dSQc6L
	 qisckzr3Lptsw==
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33fb4680717so9461718eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:55:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH5tZrLd1MrcraqbJvI/fs2FMszC4IEMJZ6y62khk+cYfuB8AoSZo5e2zh1lCkVGt6xwGIXvuM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Qxp2f442V2aiYZJ2N21iRqKvBlrGVMYPFAWfM1HAfoY318PZj
	4nboUeXCeOSYSJhKk3NP3QX8kS5yXCFb2c82CPK07Za2cWx2TVW8Hrsetwky64rqORheUHovNMN
	bvYLVWl28FzxjvxxmkNHBuLEwxKI6tw==
X-Received: by 2002:a05:701b:4212:20b0:195:49ee:94c7 with SMTP id
 a92af1059eb24-1b556877b4bmr13673422c88.8.1795449323806; Mon, 23 Nov 2026
 07:55:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-mtk-dsi-long-read-v1-1-0b6d9b67c011@protonmail.ch>
In-Reply-To: <20261105-mtk-dsi-long-read-v1-1-0b6d9b67c011@protonmail.ch>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 15:55:09 +0000
X-Gmail-Original-Message-ID: <CAAOTY_86OXNzY1ZCM-TkRHJBL2D251TmMUAb7KciJ=J67zzpdA@mail.gmail.com>
X-Gm-Features: Aa3M54odlecVrJk7CoDKPAKnCFnRzxRnnufzNqT2mcMd-MnXgiezzVi7wDx4zUE
Message-ID: <CAAOTY_86OXNzY1ZCM-TkRHJBL2D251TmMUAb7KciJ=J67zzpdA@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/mediatek: dsi: Fix handling of long packet reads
To: bengris32@protonmail.ch
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	shaoming chen <shaoming.chen@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
=E6=96=BC 2026=E5=B9=B411=E6=9C=885=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=
=8D=882:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Ben Grisdale <bengris32@protonmail.ch>
>
> mtk_dsi_host_transfer() decides where the payload starts in the
> received data based on the byte count returned by mtk_dsi_recv_cnt(),
> treating anything longer than 2 bytes as a long packet.
>
> This breaks long read responses with a 1 or 2 byte payload: they are
> treated as short packets, so the word count from the packet header is
> copied into rx_buf instead of the payload.
>
> Fix this by checking the packet's data type instead of inferring it
> from the length.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 21898816831f ("drm/mediatek: add dsi transfer function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
> ---
