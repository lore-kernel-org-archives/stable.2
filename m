Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683454AA3F9;
	Fri, 25 Sep 2026 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346522; cv=none; b=nx8wQK8QlwYZ/xjoWEQWvtjY3Mq8DQPTTFfD8rFkdhJD8210g5Byg870Jt66yD7LJAKnoLRLplTMcFCPMCnZ4I7jzNnvvz+iWuAv1CTF7zUFmXIth0gr2sg/hVM0NaRNYDMWowRg7AdVIpPBic9Ak2YhCzJ8mbWDT/Qq++5EpNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346522; c=relaxed/simple;
	bh=e+IEvfQQNLyDg334ue/uJkR+TQVfOVB/ZrhNwYn46Hs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OybGVX2O5QbcYDLE6zgWhGwPf1EP608uyuShCbkMUTsOg+XaW5lYQhrlUhbBTTwY8kYC+6sfI2zKqbUyx50tF5+VbUiBaJsiofZ7RyU/8xaSc/NdBKTMVN/275IsJRI1oAlM5zgTINfs08sVeigbTjMA3flhtKo1rByqpI/kgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=at6GKfc4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="at6GKfc4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B371C1A0FF7;
	Fri, 25 Sep 2026 14:28:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 864C76073B;
	Fri, 25 Sep 2026 14:28:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96832102F1E07;
	Fri, 25 Sep 2026 16:28:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790346510; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/Szyux9DyHheIDnsjqi+HSqLOWfZhUZQhMC3M9IhzG4=;
	b=at6GKfc491Zf19q6ai9lcmvvmxHpbTSOHcrdNW201op1kfQgITsZemaHFXgjhN76jIQIqW
	lWIX3wxP+QjVHWJhniuDn29jP61lV5PO2bbaKU5Zvh2grnjjnPobEOE22MSJfcu573AJOq
	jvNzBzzVHJaZ/ECjTT5WZVFJuiOH7bRpD1L6OGh5DXcnepL88dEbNf4/dw3yTV0wHuk13l
	9ltCc1ewLGtPWJq13NMawijCavACFXqHPgNwmhW7O03ghnY09mJ3ITL3zmAhuS7KICTMvW
	TAsMBJtG1wPtpGoyIROmApgY5A1M5cxTVrsCpk4TamX98E5kKNo2UhzxQftUHA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260915010647.54099-1-mhun512@gmail.com>
References: <20260915010647.54099-1-mhun512@gmail.com>
Subject: Re: [PATCH] mtd: maps: pci: balance PCI enable on cleanup
Message-Id: <179034650740.1166139.2004199297491159166.b4-ty@bootlin.com>
Date: Fri, 25 Sep 2026 16:28:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 14 Sep 2026 21:06:47 -0400, Myeonghun Pak wrote:
> mtd_pci_probe() leaves the PCI device enabled on later probe failure and
> mtd_pci_remove() does not disable it either. Use pcim_enable_device() to
> release the enable reference after the existing map and region cleanup.
> 
> The imbalance is already present in the initial Git import.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: maps: pci: balance PCI enable on cleanup
      commit: 3be16e5d4990bf96309ac5ba35cb369c6015bce7

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

