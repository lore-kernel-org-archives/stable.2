Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941109;
	b=Mh4fEWVV6MeCjJJhAQkyhnbrO5iNyjjQ5tVhg5B1mtTLgBiLK+0Ew4K14jlRuR6kKKbG
	 pWnkrMDBAPUEcrGNXFBYmaSGKudtchXH4DOBFT5YVCKu0Vszn1a2D33iL8x5X6r39/BcM
	 fXN7CP6QitLdPzy1udObyxOS7d1sFTXcFWOGDUIHqSAID13nyI3HDxATgzL2uP04aFmVe
	 0E9JSBjfeyk4MXu44c1/Ezy7qqKgVinIZlG3eghvWh0o7j4h7k6AzJooB377cxkhL5jBB
	 ytAD7ZNZkjEP0KIK+c1Tup6O4B3ZA52TwqxNFbbwALLbb9YWy64BVGYgOykHYkcGD4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941109;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uPOBkM8XHvjxf6D69jNgl5qPdmKhqGLkdSlcUC+YtjE=;
	b=veYlCOlATFFDnCh/KJeRxs6rCJoOF8MOTKqPLzm7hSofeYdlmwmjFZYW1UVGkqIaCLPk
	 cw8pTA2o1YU7GtgbSogk8guvgi+LQSbZ4KIpOR9I+KLBDrnluWh9R6DEUuXZvu5MpwYwK
	 EPvjZAvWz6JWIlntJGZBT/n133SSq3fHbuIPevNL/iirnApNdn4028wkAtXqHiqMb7U6v
	 X8X4GW7nrLePgcjacWY486OaPzL0CW1WdxvqwNUnzdjDOrIR43sVyng0XTO2glwGwqrTS
	 hpCVsCf8so16wGvw0DwLLhmx4ansQjUmShL+31aZx4BthYU0ygb/yG30oTn7gguhowA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpWnjZFe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AF606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpWnjZFe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB271F000C8
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941109;
	bh=uPOBkM8XHvjxf6D69jNgl5qPdmKhqGLkdSlcUC+YtjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VpWnjZFev7hqxJNnHkW9IJkptijODim3FLkLoIuM/cpV//MAbRRyFtQTgh6BtszJ3
	 Nl6vWsnBsbYlwR7miREdM74QZDlKxovSmfh6OtgJnirjOxq4LFS1IH8E6SCl6QD9Sv
	 xw73a7mUXpDkP7ylyKktSlUssuQSxXFdx3F8wOjfXRfK0OdNR7/KT96Jyr2BKhjH+0
	 pO37BJEEh3ePXtwPkMhiizGdy9+W5+W9+Xj+yLwIboVfdbDax4wL7TtdUimt7SFy5a
	 I1HRvPoSDgif7TdE+GVsKlNLHMVKwb+wbu5zMXoJWXx046lzUcTzfL7ae+smC+9T0O
	 zwMCV7rpGILrw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be47aa555cso80990e87.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:45:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHpI+DbC5unInHxgXoqllaSODwqX4ln4wEsuuFR4BIAw+Lj4hcHwsZvYluMyceHyRy97xRnWUE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Si0PUIU/YN/k04wqk3tmxq2lYJUtWFmFasnoJgvUWxCbSb2gN
	fwuNf/vCHCZjnr1Wn0Kdr0DRc6RdO8GshWw4XnT4juzdzVUYks2dU0/pceUMknbocAGbwfu1k8g
	9W5N6nSYBKJMKscWHEYVCVkGEKg8dmMU=
X-Received: by 2002:a05:6512:1192:b0:5c0:d7c:7a1 with SMTP id
 2adb3069b0e04-5c1aa08118bmr1807e87.25.1794941108077; Tue, 17 Nov 2026
 10:45:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117163809.622249-1-lee@kernel.org> <20261117163809.622249-2-lee@kernel.org>
In-Reply-To: <20261117163809.622249-2-lee@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Nov 2026 19:44:56 +0100
X-Gmail-Original-Message-ID: <CAD++jLny1FRt8v7NwX8FHYAOC_mdygcV3FtscFwzfxHEUgBDGw@mail.gmail.com>
X-Gm-Features: Aa3M54omOtNfN5qw5Jdx7qnLkJd6KWvB55VIdOj8gYh_ahd_56SSbUwGQ5J1bxM
Message-ID: <CAD++jLny1FRt8v7NwX8FHYAOC_mdygcV3FtscFwzfxHEUgBDGw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dmaengine: pl08x: Defer OF DMA controller
 registration until slave setup
To: Lee Jones <lee@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Peter Pearse <peter.pearse@arm.com>, Joachim Eastwood <manabian@gmail.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 5:38=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> pl08x_of_probe() registers the controller with
> of_dma_controller_register() before pl08x_dma_init_virtual_channels()
> initialises the slave channels list and before
> dma_async_device_register() registers the slave DMA device, and
> pl08x_probe() does not unregister the OF DMA controller if subsequent
> initialisation fails.
>
> Move of_dma_controller_register() after dma_async_device_register() for
> the slave device and unwind slave device registration if OF controller
> registration fails.
>
> Fixes: aa4734da6674 ("dmaengine: pl08x: support dt channel assignment")
> Closes: https://sashiko.dev/#/bug/linux-4e233fb9-3b0c-4442-b601-c6706c9f5=
aba
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Fair enough,
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
