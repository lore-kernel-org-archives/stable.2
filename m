Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201E48489A;
	Mon, 21 Sep 2026 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988949; cv=none; b=Ei9N3jKOO2Bn1JKp1A2s22Fc5B2iUFzDiJTa+DHe/j/kHbN3vC1vk0e5FvIW+Oi3jwSLnxQxmqtJJzDCXAr9h3NfrGnD0vJ39+/E0pwiRP50chdPg89Dxn7Z3Zy0TVhAhf0zOnsnhNO13da8fK4Hv8t1CUKcbTWFPY3BnSM1qGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988949; c=relaxed/simple;
	bh=XOJGD4DL8Hbs3UyGwmPcnrJLfVdnCt93POrbVDP8F9E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0S9zTOYDbrWvXUGEex6EMeSEYVjOLSjt3yrTHCSNGMaUvKPYsXHsBJZVDiBBJ4Vr+VWDZ3czas1vUdzGx1qb/E77Lg5G8hoRHv52ql7/e3g/f3/Y+NcrNa8kTqx7qv2fjzsBzA3SiIEKFzN45HZhj6weooVtFoMAMa+9wbX+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt/oH4nW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt/oH4nW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231AE1F000FF;
	Mon, 21 Sep 2026 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789988942;
	bh=U+4ki4AvYJsyBiciw5qYv2Bi6kejqav8LxCvURMHiqM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mt/oH4nWL8KMKMmB1OqIMjWjZ2OcfR3FCfq7pIh3jfA5AN/4w1xJebxZ6gD9kVL4v
	 DavnaaEGtJjrmbJQhVJADjNOs3asfA06EvMGLgbYRokhhMCnhX2RM93PyU8s+PJB0o
	 LpKtqS6NMZRyBqsxKouva7UgC0VbeHdoqgWaqHT199ia8V15MfHe59fhgi4IrTbA6k
	 UBLAJbebRboLAsTg3lR65ymjiO+L02TOd3ymR1VwU7DZrii8gjGqKBwfWZ7Rv1moa0
	 pqX2A/jxJLDxMk3oxLNPPd6Lu+0zTdDw9xfueLdfvMf7sX5aorm97QQTKgKDDY0zVk
	 b8xK7Tbh3YkUQ==
Subject: Re: [PATCH] net: dsa: vitesse-vsc73xx: Fix SPI device reference leak
 in vsc73xx_spi_probe()
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, olteanv@gmail.com,
 pabeni@redhat.com, paweldembicki@gmail.com, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 11:09:01 +0000
Message-ID: <178998894159.2160803.2533930909979691719@kernel.org>
In-Reply-To: <20260917104920.2147568-1-vulab@iscas.ac.cn>
References: <20260917104920.2147568-1-vulab@iscas.ac.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the newly added spi_dev_put() calls do not cover
  the shutdown()->remove() ordering, so the reference leak the commit…

--

net: dsa: vitesse-vsc73xx: Fix SPI device reference leak in vsc73xx_spi_probe()

This adds spi_dev_put() calls to balance the spi_dev_get() done in
vsc73xx_spi_probe(), covering the two probe error paths and
vsc73xx_spi_remove().

> diff --git a/drivers/net/dsa/vitesse-vsc73xx-spi.c b/drivers/net/dsa/vitesse-vsc73xx-spi.c
> index 85b9a0f51dd89..7b784320c41e7 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-spi.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-spi.c
> @@ -153,10 +153,15 @@ static int vsc73xx_spi_probe(struct spi_device *spi)
>  	ret = spi_setup(spi);
>  	if (ret < 0) {
>  		dev_err(dev, "spi setup failed.\n");
> +		spi_dev_put(vsc_spi->spi);
>  		return ret;
>  	}
>  
> -	return vsc73xx_probe(&vsc_spi->vsc);
> +	ret = vsc73xx_probe(&vsc_spi->vsc);
> +	if (ret)
> +		spi_dev_put(vsc_spi->spi);
> +
> +	return ret;
>  }
>  
>  static void vsc73xx_spi_remove(struct spi_device *spi)
> @@ -167,6 +172,8 @@ static void vsc73xx_spi_remove(struct spi_device *spi)
>  		return;
>  
>  	vsc73xx_remove(&vsc_spi->vsc);
> +
> +	spi_dev_put(vsc_spi->spi);
>  }
>  
>  static void vsc73xx_spi_shutdown(struct spi_device *spi)

[Severity: High]
Does this still leak the spi_device reference when shutdown() runs before
remove()?

The new spi_dev_put() sits after the NULL drvdata guard in
vsc73xx_spi_remove():

	struct vsc73xx_spi *vsc_spi = spi_get_drvdata(spi);

	if (!vsc_spi)
		return;

	vsc73xx_remove(&vsc_spi->vsc);

	spi_dev_put(vsc_spi->spi);

and vsc73xx_spi_shutdown() deliberately clears drvdata without dropping
the reference:

	vsc73xx_shutdown(&vsc_spi->vsc);

	spi_set_drvdata(spi, NULL);

Documentation/networking/dsa/dsa.rst describes this ordering as permitted:

  to be called even if ``shutdown()`` was already called. Therefore, drivers are
  expected to implement a mutual exclusion method between ``remove()`` and
  ``shutdown()`` by setting their drvdata to NULL after any of these has run

So on reboot followed by SPI controller teardown, for example
dspi_shutdown() -> dspi_remove() -> spi_unregister_controller() ->
spi_unregister_device() -> device_del() -> vsc73xx_spi_remove(), the
remove callback returns early at the !vsc_spi check and the extra
reference on the spi_device (and its per-CPU spi_statistics) is never
dropped. The commit message does not mention the shutdown path.

Would it be simpler to drop the reference entirely instead of adding
matching puts, i.e. in vsc73xx_spi_probe():

	vsc_spi->spi = spi;

vsc_spi is devm_kzalloc()'d on &spi->dev, and vsc_spi->spi is only
dereferenced from vsc73xx_spi_read()/vsc73xx_spi_write() while the driver
is bound, a window in which the driver core already keeps the spi_device
alive. This file is also the only user of spi_dev_get()/spi_dev_put()
outside drivers/spi and drivers/platform/x86; peer DSA SPI drivers just
store the pointer, see b53_spi_probe() in drivers/net/dsa/b53/b53_spi.c
and ksz_spi_probe() in drivers/net/dsa/microchip/ksz_spi.c. That would
make every path, including shutdown, symmetric without adding three call
sites to keep in sync.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917104920.2147568-1-vulab%40iscas.ac.cn
