Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187054;
	b=R/D0W/8yRL63Zt2rLODiUwOA7LhKhS2i4K4DAfEEzb80YWfZAPADW3OD/WuZ6K5D5Jhy
	 DlCq8ophBRV4U91YXzGuxAQOGtxMTm3aDO/uA1+F06X1yyPkATJ4gjaU9aUIgrwpeRUAX
	 YFNn5v1Iv1U72U0Z2iRIuCk+flVsnjnlm5Tll3cNBLZ+NWrQP3BfqvMbq7ciMajlTCYCV
	 MBtP/NAeyYsKW7yebQUtoH531MeQZSt0yyFDis2mynZ0unlaHRjtctug4suEXb6up9V5V
	 2lNL1Ss+H0eR9I9YnRvWufRoClVnzujHQPkwNT5gNJ1Nu/99UoruwVDrsveyTtb/XVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187054;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=Xl3+acC/CbSvOdpQbSY8pE0NAi03laC83yGZ5kvrp8k=;
	b=38eYEoEfrM9sm1WSojnKB8DZPOWhf1AjeOk9VD57pWQb2yPsc8KrMReeG6OYvRKk8iPq
	 g16wvJxWNX7cfygiEJLtrhE6tSF26NLBGpyZXtRRj1o/ex3fSvzBg9uABSCORgc1+BTeH
	 6mEBgCt1K2sDL5eZ40jCZm37ibcV4xzJHS8yed6mNoSFA8zLUU6sHN3Leh2NBBu0b9Nyi
	 77q6mbIvKfjrP/9XQok76dEuxoE1f2bosAcgHxgkhep/fAl47y0oj+5uY16+9ejSGdQq0
	 /F+SM3V2Pi63mIqyS05ueOciz1wdSMRZ3JDEm7Tpszb8wMhxgIf5lDi7PIeObPeT+5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FziOh9Vi;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D36606BC97;
	Fri, 20 Nov 2026 15:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15D36606BC97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FziOh9Vi
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BCDFC4E4168A;
	Fri, 20 Nov 2026 15:04:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90FC6601B9;
	Fri, 20 Nov 2026 15:04:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1E9B11BC030E;
	Fri, 20 Nov 2026 16:04:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795187048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Xl3+acC/CbSvOdpQbSY8pE0NAi03laC83yGZ5kvrp8k=;
	b=FziOh9ViqtOVei957IbUouu2vi2aGYbaLY5nOvmqrsJhB5jVNWJ5K7JKzKtdAtLJSlAdO6
	W5s1hEETLfr9ovfR1oyQiu8I2NSAjen8DV07m01snljV3fCtgaC4Bdy5ZXCo/t8gKptY/g
	6o4+kO2am/sVqkN/gxOgdtDxmf096xKnV0R67GRYGCyjzhTGq7F+TpQquStT8elHLC6gSZ
	W61eJD2cnN8MCWLzeLHR/psrkI/rmzXf4Gh/Jcs6ncDE7yju1+H/vJqp+ZdgYEUKkddH+G
	ylgDiwvfrTLXwHxONodagk9aR4lFpEaxzhcYLTynFlCmS+Wz+WkVx2tj7fyotQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Maxim Levitsky <maximlevitsky@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Woodhouse <dwmw2@infradead.org>, stable@vger.kernel.org
In-Reply-To: <20261108-submit-r852-shutdown-work-v1-v1-1-8e448ad7c54c@gmail.com>
References: <20261108-submit-r852-shutdown-work-v1-v1-1-8e448ad7c54c@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: r852: prevent card work from being
 requeued during shutdown
Message-Id: <179518704684.3404688.4251747340533260570.b4-ty@bootlin.com>
Date: Fri, 20 Nov 2026 16:04:06 +0100
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 08 Nov 2026 14:04:21 -0700, James Hilliard wrote:
> The card interrupt can queue card_detect_work after shutdown cancels it
> but before interrupts are disabled. The worker can then access the
> controller after pci_disable_device(), and can enable card interrupts
> again while processing the event.
> 
> Disable and drain the delayed work before turning off interrupts and the
> PCI device. Later queue attempts are rejected while the IRQ handler can
> still acknowledge events until interrupt teardown completes.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: r852: prevent card work from being requeued during shutdown
      commit: ec1e844b9486302a488abc03ea918db60709766e

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

