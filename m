Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63763B8922
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434730; cv=none; b=p6MD3bKm3d/rNcjafd/FdM8EfOMK8AgOYP9DHImSd1mzj8Vcq9hQhNfYKh2uFO2UMglht+H8/mOKyZMTLyswRqHGbT1m38RY1WEH4eNBIKRZxMox0KVUyaAn9QAlN19OM/uDX/4KJsnAQYeEZ892uWRRu6P4qq97FPiUz+3vJQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434730; c=relaxed/simple;
	bh=9m+69fxSpkmLtG1XURvJx7NNXdH6H9xc6VvQtA5327s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uOj4ed7kGM9rLTdkC2aznkDlFJtVoh+TQL/Q7q/b28qjc6t/a7fgma9Up8ISMa54mzZCaqH4Q53XS0hn/N9gIAYVeeDGNSQoYd/Cbkuio4vdzsSWM8PhOOLD0LJLczHTHbuXv32lpBQrn3QHGDRroR1FRSZIib/8igvs4OPnhN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=juMa5yew; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="juMa5yew"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BE53F4E411A7;
	Tue, 11 Aug 2026 07:52:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 79ABE6033C;
	Tue, 11 Aug 2026 07:52:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B394811C4BB84;
	Tue, 11 Aug 2026 09:51:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786434719; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9m+69fxSpkmLtG1XURvJx7NNXdH6H9xc6VvQtA5327s=;
	b=juMa5yewo0CY0D84o5QuEiBCVQbi5D93oMVwf/usMazHXYll8Ly6D/PnWXrn/Gc0Hr7Kdx
	TuRnmpHUT771AigGRxwUs6rnKcOumEjAlz4Dm8oTCC+rOif+82MMlncTHqZt90jPuc7LSY
	Cz8vO8CuplzK9qVfe9B0bZKJELzEqedMxMZxf+rcAKlO3+rRq8WnS3OZ+t32lGUhOQR+o5
	nuiv+7vrf+E+RvEhDsU4scZ12duK3IfYxVAHrJN2TxfVogs2boOWouZ6/EkoMBq2U9fkcg
	CJXh6f0D30eB5uJuUtVUf8CxJWw6LOop0qxhYaiBJvc6PGXmKgn6aKMt66r/sg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v2] mtd: spi-nor: scope the exclusive RWW lock
In-Reply-To: <20260811041349.333176-1-runyu.xiao@seu.edu.cn> (Runyu Xiao's
	message of "Tue, 11 Aug 2026 12:13:49 +0800")
References: <DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org>
	<20260811041349.333176-1-runyu.xiao@seu.edu.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 11 Aug 2026 09:51:52 +0200
Message-ID: <87tsp1p013.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 11/08/2026 at 12:13:49 +08, Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> spi_nor_rww_start_exclusive() is used as the wait_event_killable()
> condition for RWW access. When RWW is busy, it can return false while
> still holding nor->lock, which blocks spi_nor_rww_end_exclusive() from
> clearing the RWW state.
>
> Use guard(mutex) here so nor->lock is released before the condition
> returns, while the state flags still hand off ownership to the caller.
> This keeps the mutex scope aligned with the other RWW start helpers.

The diff is now correct, but the commit log is still missing the
point. There has been a translation from raw mutexes into scoped
helpers, this translation missed one spot. This should be the core of
your commit log.

Miqu=C3=A8l
