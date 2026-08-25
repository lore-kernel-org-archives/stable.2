Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D342AFAA
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660957; cv=none; b=Kcsz/L6SgSjGIfDuJTpR1JM5UDXThME/mp+ItiDeBSTzSh8Akfzk3lt/EGYdG+x1om/Tda7cBOzFegQ80aX2ppENE5COXBfDITaKJ5KQ9wSpzIzc28IEEJsuwWK+JUBXYdkbZZ3BjGAQ4CEIGihwjHrNAu4dPGX/iXSh4dhc7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660957; c=relaxed/simple;
	bh=wHf1fJ30poCqInvCcBGy67pow8xMh78bP6vr2oMpdI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PB7lWsGF2MleNL3rME742C2Lt8iYJ7dayT6RO7C1wsJYk6f2Dn16yZ8csZCVJxLFUiQkJQbgHXNWKTPC1G5ePCgryafZOL2aaP5XfHjyNeKwEsMVkyeyjU+diRoNSd23jYMee7s6Ca6OLxYYkN7HsZHBlw2UZB1UX/DdfAIkk5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ynKddJNi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ynKddJNi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B33DB1A1807;
	Tue, 25 Aug 2026 12:29:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7EBD3604C4;
	Tue, 25 Aug 2026 12:29:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67A8A11C792BD;
	Tue, 25 Aug 2026 14:29:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787660945; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n3Fwjdl5LogwA6IhpLkAzwbAmHDA3YfxfDN/3cyvB18=;
	b=ynKddJNib9Zf1ElcBIqZfAxmVj0rHKV2ZuyRgEHwalYwG24xQl7u8nXgU5zzQ7N/a+mt/j
	BSeKyNzAtThXdjPNG4HZ+JtPpOHhcDuPs3poKg4Vqi9YAhdVrRW054iut2z9PlvXuv+ltk
	OSbzym+Kao/WqufdKrjyU+sFOIfVGRsQfFb5+NzlWZhJjqA/Glyj2TBPXvEKN3ss5r+G8Q
	CdsWflyVcUc81vQj+XGylqlR+c7bcEi+apTCG/BUCVa3+UN7WAA7wAgMwtN4FJuk94MjQe
	w9FeVkkfhkwZYhNSztZg6XsW+JiLpPWmEoUoHsTCeV3BDA62DpbWuMprkGlFDg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Takahiro
 Kuwano <takahiro.kuwano@infineon.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v4 1/2] mtd: spi-nor: core: Fix mutex leak in
 spi_nor_rww_start_exclusive()
In-Reply-To: <20260819140337.36775-2-runyu.xiao@seu.edu.cn> (Runyu Xiao's
	message of "Wed, 19 Aug 2026 22:03:36 +0800")
References: <0a15f6e8-f1ca-4945-9bd5-2b64a2802a58@linaro.org>
	<20260819140337.36775-1-runyu.xiao@seu.edu.cn>
	<20260819140337.36775-2-runyu.xiao@seu.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 25 Aug 2026 14:29:02 +0200
Message-ID: <87tsoigz8x.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 19/08/2026 at 22:03:36 +08, Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> The RWW wait helpers must not block while evaluating the condition.
> spi_nor_rww_start_exclusive() used mutex_lock() directly and could return
> with nor->lock still held.
>
> Switch the four RWW start helpers to conditional scoped mutex guards so
> the wait condition never sleeps and nor->lock is released before
> return.

What? Why?

Please.

Previous patch was right, why are you converting to scope guard?

You did not pick the Reviewed-by tags.
>
> Fixes: 74df43b3f626 ("mtd: spi-nor: Enhance locking to support reads
> while writes")

This Fixes is wrong, the original one was right, please check the entire
conversation.

> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
>
> Changes in v4:

Changelog should not be here but below the ---.

You miss changes from v2 and v3.

> - Use the original RWW locking commit in Fixes and update the subject.
> - Apply the locking fix to all RWW start helpers used as wait conditions.
> - Keep commit 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex
>   cleanup helpers") as a stable prerequisite because it adds
> cleanup.h.

Where did you do that?

If you want to fix the remaining Sashiko issue (the sleep issue) you
can, but please do it in another patch.

Thanks,
Miqu=C3=A8l
