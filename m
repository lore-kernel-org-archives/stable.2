Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440655;
	b=h3p5dHjiZnlclRUnFl1m/DSKXYkU9N/mshvXkIxR3nVgfKJbQfH29+z/3Wa7tqTlcdKP
	 34/Wrt/vOc2wRji4r6oRpBiSEyBXkBEoZTTXKYUY6QhpAQrjLKCiy5EpcUyUIk/6QjVMt
	 TmF/9NfOhwRUy768P6pzKtCgVcaYqzMRlsRlWBpNqt8n+I56ZoAd2v4+QRxD/XRigKgx4
	 jbm6cmLFMbUnkaRUPjcKHiyu1jxIz6Hfo4bfIKKbUugNZK1FmJv7KZaUtEh8DH9qt0Uow
	 NbvaRVPBTY5FHBeol81fyV8Wp2RjDV6eKtK3bB9KvPFwWBX86HkdESAbqEOB+p/+A3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440655;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=fDn/k7hpvMCdeXjRyAYzAoy0wAxqkiDt4fpprxKuVcc=;
	b=IdMErOhkV1c8SnaG5s3I15DVyk8gMFoS0Tws0NPGFPWsv71bFFhKOteIMzHxfcKtk7Xc
	 sBn0MpQlMdWZBG9/ISsQIAhgIHFq1I21WmbxbP8ZZwnp6rjbfKztptTPmK9rcc7claVAv
	 wN5zO0wP0iIIKBO6RdxcygM3RB16DgLknAi26PkxomUyK3IeQKx2CJ/lDxojdZ7kCFNYK
	 4ls2bRDulX7D4voHN6g3yafGpHtmKwR9ADyVYBP7Bs3+aZCrpQSqs33G0bjlohOohkui4
	 U1RFQFFZaOag4Xmy1R5tMw0iY9GnLTyxIDeL+o6T9LGwMjnaQQVg3vpkeLmMdRGd88w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="k/n2b7BW";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF060606A31A;
	Mon, 19 Oct 2026 20:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF060606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=k/n2b7BW
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5D308C5CD5C;
	Mon, 19 Oct 2026 20:11:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23A3860582;
	Mon, 19 Oct 2026 20:10:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51DDD10328C22;
	Mon, 19 Oct 2026 22:10:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792440651; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fDn/k7hpvMCdeXjRyAYzAoy0wAxqkiDt4fpprxKuVcc=;
	b=k/n2b7BWnoC2ybI0vGNW/AqPLKHjVCtNSnGkB4M8Wi4tkLjrY22NH37BxtA5Va4gfEGHbm
	FmlEXnAapypfZiOMEktiHjiKwteEihj07lJ5LAtPu83PRpqIVE32gTL/QT0K9ZFKrcxzfX
	Kw+9sA27+vvwMhGi3Tzjxw2dVaOg7Jhkeq6GneCg0nlpWiJSWessTCTy+StgiWbJRvQ3wk
	9Tv66nhBpktneNwQcOPLcVP0c2Xgefdb/3jGq+5lOkWububAJpcthy+6hCHtuBhzm5EOx3
	iqBgZPQ/cuLQaZ9txp9LcnyrPPrxEKasZMfhFreh4M46ige8Ljfs3jt5Bu6SdA==
Date: Mon, 19 Oct 2026 22:10:49 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Igor Velkov <iav@iav.lv>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf8563: pass the driver data to the alarm
 interrupt handler
Message-ID: <179244056631.104236.1622190236820625826.b4-ty@b4>
References: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
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
In-Reply-To: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 04 Oct 2026 23:56:53 +0000, Igor Velkov wrote:
> pcf8563_irq() takes its dev_id as struct pcf8563, but probe still
> registers the interrupt with the i2c client. The handler then takes the
> regmap pointer from the wrong structure: the first alarm oopses, the
> level-low INT is never acknowledged, and the interrupt gets disabled as
> spurious.
> 
> Only an RTC that has an interrupt (client->irq > 0) reaches this path.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf8563: pass the driver data to the alarm interrupt handler
      https://git.kernel.org/abelloni/c/5831f5fef100

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
