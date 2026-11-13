Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575363;
	b=unS/i+R8nF3dK4vXru4418Tfv1prbh8BW8blAk+eyYjrxa1rau4RU+dCQ3PHhafxbpcR
	 tOTCeyqGRKqDEO0RL1Wka7TIy+NNO/FJ2+xZBzmlT+Vt6fdVTt++yhV1ODf/+PwUVqkbw
	 eFWsQrGVe+t3FD6aAD1f7sgSzQt/C9PKAzeqQL1yuAOrpHJtPga5wN+9uNgBllClNpiM5
	 wQA9T0V/rMRI/nP9EuO8nuKbMlJkwq4ViHr2QKbKdvcMwdwIYRD7PFof9oAG0to+Fg5y1
	 UcpTwFs479/YfJPG5hzDO4GlTqj/vrHiDTgCGQlFhctQ7oiYTT3jORRehsw8ZJrlhzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575363;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=Y7h+yCRAr82VOkhpTfQVqsVcVOgFIcVy2auuIa6V7sE=;
	b=JAsyxgXBHG+/YxMi7guOGMUYPDuPY48aBjNO5fvQsVqVwS+G7TixauM118oU4dHq/mdu
	 sE3Pxxizyg995c56r/qhjwvcCOWHEaq32a9fRZUmEUkY4hLvnwyNLt9Lhtav/4QvMY49X
	 kyD9MUJOTUYAFDCr38bIq73F4krZCJFU+oY/NnC/qhU5rXaAC4Dt27xu/Wt3RlkIbllfd
	 OxoWCwxAziyKGTeu6Vh9GoycjWaS6qr6PHkXgxCqoNhzVbTd72lpAxTdd+BSglJP3vbqy
	 M2lwwNhSpS9iyvrdkFbPZl8p+A92ZYjK2qHk9Zw0bQ0jr1xidXFNT//+Uiru9utH9ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBtH531r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC8606A330;
	Fri, 13 Nov 2026 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBtH531r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B9B1F000C5;
	Fri, 13 Nov 2026 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575363;
	bh=Y7h+yCRAr82VOkhpTfQVqsVcVOgFIcVy2auuIa6V7sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iBtH531rFbnt6bjGnqahjuymVPXkgFvztTPbCkaNxBvHpaM8d8uBKuMW6knCP1ZNo
	 4qzH/GX0s8KsZ7FV7hhT8h4lnRlR6FgSITFflLhUclyLSYQS03Lr81Tx7Btkv5hBeu
	 bx//Q2A4WpmPFgbrxy9FO7vpdizBKoF4ONjW/DwgPznue6vAo8K5NMYYG3MR7+tY2j
	 VqBHGYnu57rlbSnonnjRlHcIv15VcklN0gk8th78Sf8EH1cDWWroEdj6BpTXtqmvo7
	 bbM3mJ5bWYZnVdsmuaUoTzDtnNjsiDKMqCicuv2Gza5MdqtUCGP+WbaxKPGpnc6nWg
	 hXNUbRMyvYrjw==
Date: Fri, 13 Nov 2026 13:09:18 +0000
From: Lee Jones <lee@kernel.org>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mfd: palmas: Fix potential IRQ action leaks on
 removal
Message-ID: <179370041880.793788.14407997006744050474@kernel.org>
References: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
 <fe4ee2ff4b3ad6675a46a169d6de6410db32b652.1793377422.git.liguangshuo@mail.sdu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4ee2ff4b3ad6675a46a169d6de6410db32b652.1793377422.git.liguangshuo@mail.sdu.edu.cn>
X-AI-Review-Draft: <fe4ee2ff4b3ad6675a46a169d6de6410db32b652.1793377422.git.liguangshuo@mail.sdu.edu.cn>

On Sat, 31 Oct 2026, Guangshuo Li wrote:

> The remove callback deletes the IRQ chip before managed OF children
> are removed. Their later free_irq() calls cannot find the disposed IRQ
> descriptors, potentially leaking interrupt actions. Depopulate the
> children before deleting the IRQ chip and auxiliary I2C clients.
>
> This issue was found by our static analysis tool under development.
>
> Fixes: 124e9deb1c40 ("mfd: palmas: Use devm_of_platform_populate()")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI:gpt-6-astra
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> ---
> Build-tested the changed object with x86_64 defconfig plus COMPILE_TEST
> and the driver dependencies (W=1).
> No runtime or fault-injection testing was performed.
>
>  drivers/mfd/palmas.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index 7fc886f4f80e..8a0b7b1e89d7 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -677,6 +677,9 @@ static void palmas_i2c_remove(struct i2c_client *i2c)
>  	struct palmas *palmas = i2c_get_clientdata(i2c);
>  	int i;
>
> +	if (i2c->dev.of_node)
> +		devm_of_platform_depopulate(&i2c->dev);

I think it would be nice to devm_* regmap_add_irq_chip() instead.

If you also convert the auxiliary I2C clients and 'pm_power_off'
teardown to devm, you could drop palmas_i2c_remove() altogether.

> +
>  	regmap_del_irq_chip(palmas->irq, palmas->irq_data);
>
>  	for (i = 1; i < PALMAS_NUM_CLIENTS; i++) {

-- 
Lee Jones
