Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504745;
	b=go25BYLgVZTxN6xZYUM+4go4LXJWbKzzRa1/sZPG0deM57LbyoUX0d+h8Bm6y0huYN4T
	 o2aZyvZ7RXAgUfkD3gyoR0vWmC9l/BZMCYesiCguYb9r7ApZv6LLYAh3+orcSrMRaa5i4
	 cBhtyFWYgm1ix1soyhYeVAh0NCQrvQVBOWxWl9xq1H0gmxwDf/rbKfAixyRw9tqtuJblv
	 tL4qVdzihlpFKVq+n65vKh+Ed9rXpWT7T82IHnSDQBSw8yZ0sRG4i33wh2mQLtH0xHwui
	 1OIQpMS7ZEAxckI912BEuM/EWhWv3HdFe+Em7UZ+Exzl7gZiyPdtC08Isqw1S7Ds/vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504745;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=mqd/bQR1q3ufJ1VUmS/hoCYa+/lLgiY4VdTm7nb2aUA=;
	b=WjcA+x72b3H5nOz0zoxjhgYKAc1Rp81rIelYC7CThgX/myOpNsGKOB8Ay96ERB3aD/sp
	 XPWNt8GF1WxX59KUKpR95SSsGUTx1tXJ1YGyLhLVZR9qqKh8WW2cs1/AFmuv6um4XUbxQ
	 R8/zOTDAqvEizZKlExFNBDKEr05L9f2FvqyY4hqyPOvJDMS0v9zsKQ9C9q81WCtWP2Xmd
	 xgUZ/iUrJ5tQS+erxMW6n0/SUpixlVEPGu0aUi/5p8SXRpafGLRevjfM9wjVcgEjBEmFh
	 pJbDhvlTuxlUpkFLyfW3/DM+uL6Hh49grXOoYHOX2aRrBDBKQ/lxamC47Slpm4KbJ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VbKuJqoR;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CA0606A31B;
	Tue, 20 Oct 2026 13:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7CA0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VbKuJqoR
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4F3661A1291;
	Tue, 20 Oct 2026 13:59:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A1FE60393;
	Tue, 20 Oct 2026 13:59:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DFC7710328C52;
	Tue, 20 Oct 2026 15:58:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792504737; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mqd/bQR1q3ufJ1VUmS/hoCYa+/lLgiY4VdTm7nb2aUA=;
	b=VbKuJqoRJ3pULJxeFEOS68iDJzlgi4lEfLYK4c/4ylEEsBifG64bZoFd+m2bqnyYyOL3wG
	G9QA6/5QwO/Ttp4oMhWMe4UtkgNrD69t6dy1gd69yehSwsMGC16VaZKhNewq6msQmqwir6
	THtEkEeEsrFrxjU2Ndt6kwVW3q1HAGO2Z66siuw948x3ghQNfP2oWL0OY3X4mzf04ZWsxT
	E6GjvQYGCzsWOPIiDUXIdfkrx+nJRmxleeZv4DPSG5E3+XQSK+b5rkaqyHbC05xQTqSJ+I
	dB+Hht8ExDz0tMStpJSMMuB0pA/vTy/is+GldyCkZKWPuWLQExkD7xPvVTC6Yw==
Date: Tue, 20 Oct 2026 15:58:41 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li
 <Frank.li@oss.nxp.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Leonardo Costa <leonardo.costa@toradex.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/8] of: base: Fix stack overflow in
 of_parse_phandle_with_args_map()
Message-ID: <20261020155841.59037c99@bootlin.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-1-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
	<20261020-fw-devlink-nexus-ready-v3-1-fd6f1c17e16d@toradex.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ernest,

On Tue, 20 Oct 2026 15:00:12 +0200
Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> of_parse_phandle_with_args_map() reads the #<stem>-cells property of the
> provider referenced by the consumer into list_size. It then copies that
> many cells of the consumer's specifier from out_args->args[] into the
> on-stack initial_match_array[]. Both arrays hold MAX_PHANDLE_ARGS cells,
> but list_size is never checked against that limit. A malformed
> Devicetree with a larger cell count therefore makes the copy read past
> out_args->args[] and write past initial_match_array[].
> 
> The cell count of each provider selected by a <stem>-map entry is
> already rejected when it exceeds MAX_PHANDLE_ARGS. Apply the same limit
> to the provider referenced by the consumer.
> 
> A plain reference to such a provider, without a map, now also fails.
> Previously it succeeded with the specifier truncated to MAX_PHANDLE_ARGS
> cells by __of_parse_phandle_with_args().
> 
> Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Link: https://lore.kernel.org/all/aq1CSswlo57jZpMH@monoceros/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
> v3: New patch (Uwe)
> ---
>  drivers/of/base.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index f63a9486b130..5abadab22392 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1587,6 +1587,11 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
>  	if (ret < 0)
>  		goto put;
>  
> +	if (list_size > MAX_PHANDLE_ARGS) {
> +		ret = -EINVAL;
> +		goto put;
> +	}
> +

I would be stricter here and avoid the usage of MAX_PHANDLE_ARGS.

First I would check the arrays size to be sure that they are consistent and
then check list_size against the array size.

--- 8< ---
	BUILD_BUG_ON(ARRAY_SIZE(initial_match_array) != ARRAY_SIZE(out_args->args))
	if (list_size > ARRAY_SIZE(initial_match_array)) {
		ret = -EINVAL;
		goto put;
	}
--- 8< ---

IMHO, this is more robust against modification of the 'args' field
definition in struct of_phandle_args or modification of the MAX_PHANDLE_ARGS
value which could lead to some inconsistencies.

Best regards,
Hervé
