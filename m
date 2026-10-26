Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042216;
	b=UjdMf26w0E7iiTtviIRaLZ5qLy1UMj2XmcntjXazbn1RGLpAFknMCqjyH9VlT90MP6zB
	 6toLXCU4Vl8Y3RUqdjfigcv1atvi6PeQAzDJM8gFsLytdJXWTrwxQ7cWzgRYZ+OWUfHGH
	 Ge+er+k9mIlPAK2qeFZdFUpsBjV8/gwSi70JZyLep/pbaxyMB+dvGdjROX7rsJMrDDs4y
	 Rc9WTSdQiT56saJI/VoTsFa2tZgN8cFnhPDmF2MUdiW5Dp4gGwLu3qU6qzcCZXWzAoBuf
	 6M2PLz1oN7nJOJkbWRSG7ck88UsTIQuTrPQvj9ayvSWi6Vplz+0/+9nqyySrHcHQB5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042216;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=RnxgXT6Poel9Dt5EQBRodal3GDy2sNUU3sHe83tKdzw=;
	b=dodQpLFovNaCE6S2y0af8gES3lhD+IXha5WlBdjs1PrZxOzM7dRIZ1TiPT6snGJ9lyCU
	 R1tFfBsYHltst4WS1+psH4pcQ5Rjenjr1MVyxy5bHiafqoEaNWhDJqddVok7frDc16BYH
	 kjti9yqBRwTFF8K7LZxkgMbfFog6cIZGHPmi1ShjYUHy5lzQRVpJUAPnIZ7c9Uin5VqXU
	 s2cmfbPAzVJ4XrfR1ijXHv9XvIsceMuP/IEoS4k4Y8XrMelZes+Qz+H8KGKhDCXqjTMHu
	 F+cRftppw+ECQKkNC59Jhw9MCz/6aW9LoK3Jxrw9yMu0HO4yyOLhlvQEBzlEmcZzWpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eH6IR1ai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1A606A31A;
	Mon, 26 Oct 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eH6IR1ai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271761F031E0;
	Mon, 26 Oct 2026 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793042216;
	bh=RnxgXT6Poel9Dt5EQBRodal3GDy2sNUU3sHe83tKdzw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=eH6IR1aiA3w4X5afl94dkMVtQ2nRNEU3AxBruZlX8vl86wwugxpnWqRIZJON0OOUk
	 ZLNnXu3gaaL4usfF+aqqmj2tAE+sivfz7E068UFFD1NEClZepPzFaad0uQuqWFZNPc
	 prfBcE6WhCy6TAXhtNmW5cpbUs+xxiXR0aLaoD+ZMeSGLpyhMLehiJ2nHq/VTIr+vj
	 8R9Tqyj8rYzFXIdQvonak1JqEhWh/c3jpFUyMBb0V1AymCxQQXQBgZKqrM3jC0PDKz
	 /4qN0O0LvNZOtK0F39YnCNfxob7tiwDsjSEZnoRJ1pggyzvpOkuXvMz2qJOLGGVp8x
	 1UiuLC2aNJgjw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 106311E90F08;
	Mon, 26 Oct 2026 19:16:40 +0000 (GMT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/4] ASoC: rt5659: cancel jack_detect_work on component
 remove
From: Mark Brown <broonie@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
In-Reply-To: <20261026112212.2519775-3-tristmd@gmail.com>
References: <20261026112212.2519775-1-tristmd@gmail.com>
 <20261026112212.2519775-3-tristmd@gmail.com>
Date: Mon, 26 Oct 2026 19:16:35 +0000
Message-Id: <179304219594.199157.13097381941103109173.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8hI3Cn/uEFiGNUcolcJAWodGnQ2bg4SCU/Lm/ZgtQ+A=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLuLxcXt9VMXWzfPWXWhi97Jvq8/Pf7ayqTxLp2iwZj3
 WfOk3s9OkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRBZ8Z/gp911wj1v2xvC1m
 Y9DNgwpNb34ee3d8wap1bGl9J+f7pexhZFiwX3Pd3NO3uMK3ZhQs/Co/48zj1vU7H6sz+cqeVmt
 ++YsFAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Track successful IRQ acquisition with a flag so that disable_irq()
> only quiesces a line this driver actually owns.  On component remove,
> disable the IRQ to synchronize with any running handler and prevent
> new enqueues, then drain the residual jack_detect_work synchronously
> before resetting the hardware.  On the next component probe (card
> rebind), re-enable the IRQ to restore jack detection.

> @@ -3684,7 +3690,14 @@ static int rt5659_probe(struct snd_soc_component *component)
>  static void rt5659_remove(struct snd_soc_component *component)
>  {
>  	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
> +	struct i2c_client *i2c = to_i2c_client(component->dev);
> +
> +	if (rt5659->irq_acquired) {
> +		disable_irq(i2c->irq);
> +		rt5659->irq_disabled = true;
> +	}
>  
> +	cancel_delayed_work_sync(&rt5659->jack_detect_work);

This work isn't unconditionally initialised, cancelling something that
wasn't initialised is an error and will trigger warnings.  Either this
needs to be conditional or we should just always initialise.

-- 
Mark Brown <broonie@kernel.org>
