Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713B392C29
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465429; cv=none; b=ZBidRRFYnREV1s5GdPPUdRTACWDasSKpaKg3k+5BvZo/8QRddBIv8dAArjtOkhEim+7xmVszOXzz5H93Iqjg3I/ds7cpEs3DshvoD3I9YfiIFjAGQkNO5SlKftgJn343cyFU5AXFIg45gtP+RBERnAvfFu7w1ls49KRiXxaSaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465429; c=relaxed/simple;
	bh=Me6IAowX4M8wHmjJjNskR0nJ4VeLzdQqxATQJsNMGQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgCxbsvaJGUZis9RzXUvfR+BFsMyne7MMpM4SqfzYXCoVPBBIUilni+62X+hmCy7qAEvf/1NNhCe7bVuKyeZ/qTC7CUpvvlEG0MuQeyngF0AOd7UGkunplBHUyQO9dUIEWHjUyWw8n428lygFjbbaxVYP2JcFVA3svbPyqcsnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LPMGfxda; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LPMGfxda"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 532B71A1570;
	Tue, 11 Aug 2026 16:23:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17E7C6033C;
	Tue, 11 Aug 2026 16:23:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6242A11C48FEB;
	Tue, 11 Aug 2026 18:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786465420; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qa4t5IE4Xx3/BJY0CdbVYY/v7tG5SbryWMMHw3QjT28=;
	b=LPMGfxdaIU9CAefowriYT5sG8jnsx+5qhvKXO9lcP/Hv5pKbg4htUDec211rz07QpHx/Ud
	/7UTsHDlrrNaT1qZ5sYnuhZPa4JTT/D2y6YJI2K0ateIJzZz7E4rXWA7tSgnlM6jvQH1Pc
	8VWTzTqkxS5Ri6NWxqw92xCdU3E62Um4TeC/ebl+krKA1S9ORcly5FRr3/zd+70NWlPF5X
	9v4cnJq7+FgY+iGOYisdLnLIw+NlUF3Y9PskqCYXQrO/d4X5j2hUb7OjVtcUiDLuKCyily
	DAz1aw84smeHKrrnOD2SZF7yfL51VSevpWy3HUQsCZY6JvwSEmRpKfiiQFXsXw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Frieder Schrempf <frieder.schrempf@kontron.de>,  stable@vger.kernel.org,
  Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,  David LaPorte
 <dalaport@amazon.com>,  Gabor Juhos <j4g8y7@gmail.com>,  Mark Brown
 <broonie@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,  Sasha Levin
 <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 0/3] Backport fixes for SPI NAND on i.MX6UL
In-Reply-To: <20260811161342.533280-1-frieder@fris.de> (Frieder Schrempf's
	message of "Tue, 11 Aug 2026 18:13:35 +0200")
References: <20260811161342.533280-1-frieder@fris.de>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 11 Aug 2026 18:23:36 +0200
Message-ID: <87zeysmxrr.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


> This series contains these fixes picked from mainline, applying to stable=
 6.12
> cleanly.
>
> Cc: stable@vger.kernel.org
> Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: linux-mtd@lists.infradead.org
>
> Mikhail Kshevetskiy (3):
>   mtd: spinand: fix direct mapping creation sizes
>   mtd: spinand: try a regular dirmap if creating a dirmap for continuous
>     reading fails
>   mtd: spinand: repeat reading in regular mode if continuous reading
>     fails
>
>  drivers/mtd/nand/spi/core.c | 74 +++++++++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 15 deletions(-)

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for the backports,
Miqu=C3=A8l
