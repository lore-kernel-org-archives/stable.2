Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122929;
	b=s7S0ExAAaYq+2QAiv6rj0JJXX0WpdTqAHFT7Uc0F5AkuWelw8KIKCCoYpWhoy+fxTfXc
	 7n5PkndAZvnZWuKPmQj4tR81vogqUum0S6EsTmHhZIUeJENsSWTRLbH0lcYTCr1C4QD1V
	 SZ0HU9NAQGMPIGziuHx2chrFZDVvXEiBvMg1Arp5aKU05w4AgKFutw/DnZzV7yOCmHScy
	 KRDRZy6VTNsBrt5Zu3TlLj0qjEWPOn2C2BVtH2VBhkcs2s8wia4QBw2GgsuRZwWuvi58b
	 Gyvi1FVZIxaxYWjJxxQAFvUlOuynEpk/sMTAHM0KvwEkOUy6dwUEeMyu9ak/SP4nv0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122929;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=eqh6+RcHaqPW6YfQQNCdiEgM/JzpeEECUX3TznGuWSE=;
	b=y8ArVvaGhPV0VS0KcMJ+Cdvhz+nhcnWJC+xvYVvhez5MN0kfZXS5PKetT2pPjU0FzlGK
	 Jyp+fILI4HzhgCbUXFyIdkgD2/dC2dWOn3IYqM00TTYJBYMmlFVBJ2ayMeZ0m0wGy8U2r
	 gFeP7qle6HcGgD4elDUFIUcMRwATSbA3lmObN/frOwHXJ8Fa2YzlgDvdH+wploEB/H6/n
	 Y8mkrIF/BSzRVB5PgM2QjDTe2pMzIXHvIuYWS1lpl+vst1M7Idh+WlPr12mZRQJB35cJw
	 iE3eQgxObaSZcKHu8MM7s/9rCYCQLS7SHRNpcMvP43TyeOj5BJb4PI8Zeg+a6SOVXPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmbiPOFy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C546D606A31D;
	Tue, 27 Oct 2026 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmbiPOFy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9981F01825;
	Tue, 27 Oct 2026 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793122928;
	bh=eqh6+RcHaqPW6YfQQNCdiEgM/JzpeEECUX3TznGuWSE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=DmbiPOFy5hmBacNu5EIiK7Cf6J7QL+MDJ2KsZmwLwe0lnYlfOlR5F7w3X01dq9JPM
	 bNkKbvCszpF6vPujAInkOU47v9WuroQ8sryCasqMPeIg2ox0qo5oKL66w+Nzp4fkr9
	 VH8mYecGMhQzSjrl0Q1HYrGAu52V7PnSHBEIozgdblIs3tKSV4yCXR3ZoM9dxnffNU
	 C/WW21I6/Bs0KKUP+1zHoYqLMFZgYndnYdP2X6qNk6jOvMXvPLZORlxFdmpU+1VrCv
	 uagKXb4e+d4wn+7m41buUM/B7QpDXjbGdz3ohQEg9z2ElXSkE8Qk4ofMudstkoC0/y
	 DWKsL1faHBCtA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 95D631FB1A3C;
	Tue, 27 Oct 2026 17:42:03 +0000 (GMT)
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
Subject: Re: [PATCH] ASoC: hdac_hda: Keep runtime PM state in sync across
 codec remove/probe
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org, 
 kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 stable@vger.kernel.org, tiwai@suse.com, perex@perex.cz
In-Reply-To: <20261027144655.31988-1-peter.ujfalusi@linux.intel.com>
References: <20261027144655.31988-1-peter.ujfalusi@linux.intel.com>
Date: Tue, 27 Oct 2026 17:41:56 +0000
Message-Id: <179312291692.199157.15417382173460679457.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I1x1Mh3B0SBW2rPMkjvahD03kiCMwDc5iSrOkaNJ87I=;
 b=kA0DAAoWL+9zsLPQOIkByyZiAGrg4mbIYgydtmlV9rVxDjM45N1bGAhExjamm+Tc3Rz/uvSGa
 4h1BAAWCgAdFiEEXmoL6X9066wOwaGGL+9zsLPQOIkFAmrg4mYACgkQL+9zsLPQOIlK6gEA7vI6
 SlYLtC704OrGlSQQyKidIcp5NPF88dw6Bi7HX4cA/2jRWcQdSaNjE+O2Z3SPYdVbxpTd2Kdn1qS
 sIRaYS04L
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> After the codec has been removed, its runtime PM status is
> RPM_SUSPENDED while hdac_hda_codec_probe() powers the codec up via
> snd_hda_codec_device_new(). The pm_runtime_put()/snd_hda_power_down()
> calls on probe and registration then see an already suspended device,
> the codec suspend callback is not called and the codec, its HDA link and
> the codec_powered bit stay set, preventing the controller from runtime
> suspending.

> @@ -554,6 +557,12 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
>  		return;
>  	}
>  
> +	/*
> +	 * Resume the codec to have its link reference (dropped below) and
> +	 * codec_powered bit in the same state as after the probe.
> +	 */
> +	pm_runtime_get_sync(&hdev->dev);

What drops the reference that this takes?  The probe shouldn't have
exited with a runtime reference, AFAICT it doesn't.  There's separate
runtime PM managment for the CODEC in the HDA code...

> @@ -565,6 +574,9 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
>  
>  	/* Balances the disable above, cleanup_for_unbind keeps runtime PM disabled */
>  	pm_runtime_enable(&hdev->dev);
> +	pm_runtime_put_noidle(&hdev->dev);
> +	/* The codec is cleaned up, system suspend must skip it from now on */
> +	pm_runtime_set_suspended(&hdev->dev);

This updates the runtime PM reference tracking but doesn't affect the
hardware.  Is that what we want?

-- 
Mark Brown <broonie@kernel.org>
