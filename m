Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F51C5013CA;
	Tue,  8 Sep 2026 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861825; cv=none; b=itPDdYfI8H6TaUTZ34LTdkSBXkOHNLjm7Vjt+FFFDeHyc5i8nGrTBtp/fmwfONMw5sa7/RBmSiN7i7CTS2e/bQe9gQ+5z9aXXa1zfJ7VnTsmOuGAv9WC/5/H9BUFeAMYXvtN+NPOVYMv3OGiG1RfCmfOe3x1eASIzZW2o49yT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861825; c=relaxed/simple;
	bh=5vAQX4mLQwg3bgyjWIDegZmml35dIae71Cu53YVyKVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=STEeYWUuvwkFjsoQOckesNgxy4f2tCq3tGT8fOxgNnXNr+fx59mAd1uZUrHD+QkuQcvFMCNz8yzeL1CpMpxTM3PgfuPdoEDANKawo9r5NhNB2/A74cCTQFa5yommHGszcTMc7W4wRbJC1G4J5C8+MqQcJYJr7EPf42y4+G84HT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HJxw7a5n; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HJxw7a5n"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A1D9A1A1A56;
	Tue,  8 Sep 2026 10:03:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73C25603C4;
	Tue,  8 Sep 2026 10:03:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C87711C7AF5C;
	Tue,  8 Sep 2026 12:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788861816; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5vAQX4mLQwg3bgyjWIDegZmml35dIae71Cu53YVyKVc=;
	b=HJxw7a5n7JiOtutr1aQa1jZOAcwYz7vUl4NtBmXInV72w47M2bbpX/gqsgpboIQx2ttkkD
	uJhck1Odhe6MP98SkTQKScFMRfE+5rZvf2rZimWdm5MoC+P3Vt1g8SUjbHeVIGdvRCwoO3
	ZbuzkTmBrjV6OMhxCdmzmvHQ/A6D8ohLa4PtjAqD7VLGrwY+PRcX7UZ2YBzXC3FGJ0HrxZ
	wLeFInhRpblg7OiYJyNlVTfsWzs8Qv1eFkR+N9jQ8iDBUhTHmI+JplH6lx4pGdlSV5BA60
	hhUYLGMmQCeKzYfHZ5VZTkgd4in2hMlAyW681J1LPsot4e024AN+k71R7E96Ew==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Chen-Yu Tsai <wens@kernel.org>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Samuel Holland <samuel@sholland.org>,  Boris
 Brezillon <bbrezillon@kernel.org>,  linux-mtd@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  linux-sunxi@lists.linux.dev,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: sunxi: fit maximized ECC step to page
 size
In-Reply-To: <20260904-submit-sunxi-nand-ecc-step-validation-v2-1-6e3ba6200948@gmail.com>
	(James Hilliard's message of "Fri, 04 Sep 2026 16:39:27 -0600")
References: <20260904-submit-sunxi-nand-ecc-step-validation-v2-1-6e3ba6200948@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 08 Sep 2026 12:03:33 +0200
Message-ID: <87zexst5ze.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello James,

On 04/09/2026 at 16:39:27 -06, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> When nand-ecc-maximize is set, the driver unconditionally selects a
> 1024-byte ECC step. A NAND with a 512-byte page consequently produces
> zero ECC steps before the available OOB bytes are divided by the step
> count.
>
> The older sunxi NAND controllers support 512-byte ECC blocks. Select the
> smaller of the page size and the preferred 1024-byte step, using a
> 512-byte step for a 512-byte page while retaining 1024-byte steps for
> larger pages. Unsupported smaller steps and controllers without
> 512-byte support continue to be rejected by the existing checks.
>
> Fixes: 4796d8655915 ("mtd: nand: sunxi: Support ECC maximization")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

As reported by Sashiko, there is another use of 1024 down the road which
must be modified accordingly. Although, in practice, 512-byte page NANDs
have disappeared for quite some time, so this is a theoretical fix more
than a real problem.

Thanks,
Miqu=C3=A8l
