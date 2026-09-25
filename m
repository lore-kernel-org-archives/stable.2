Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA2E4A3847
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343354; cv=none; b=MX4iE5nmJLQ+SyT2nxTsEpT3FUvciRFCb7DHlrLuPrAz84qbAtfTlDbGsUg/MN3wPW1aSsuzHYd+/hr8OJQ3CQkroCotJwVUS48yVWkqkOo5U5DcimSBqcyaKIC0WI9tnmjSVp89faaETHrz5jxCWAJ9Afw3WDmdaiEMGLdj6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343354; c=relaxed/simple;
	bh=Zu3GYWdQb2Vh0cJDlbZ3kIWWiOBaQXw3I5UIff2Ka2M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WJfCP7Db+H9FnrLJhHs+SqVXMsU6xR4pxqNBkuhhnjgWQ/UNw12Cjcivkc6iFBTfLpunglvPnsMZk/4YyePTghoDBCT6mv+2qiuWKIjOpVIozF6RpG4xRZb/CFg6IIhGxVRLsPUOi4LuZsLuA4MKtH3+0cT1X2uBIElLGOQ+2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cw1Dm84v; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cw1Dm84v"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ED71AC653F3
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 13:36:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 152A26073B;
	Fri, 25 Sep 2026 13:35:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B70A810328856;
	Fri, 25 Sep 2026 15:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790343349; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WQZlysiv0d/2BjDEIe3tNwkeQrAxLfTelLLNUmuJ3W4=;
	b=cw1Dm84viQYCZx6ABoHnHL1Qp9oQfr5rKvoMMxb+r9sNGxE7HwsyCXIsK14za/yYulyUev
	ykqBIkwzXO23hvV/2Xu1UPId8vjaogYuO6EQ36ik2HxCFInJV0o4nFTvnXHrc5rCViVfXf
	TLs8WZJd9Wnsy5Bwcsy/DxOky5ivu2e3jrStr2kp88CG2xnkPKpETPzc/JDAAz4Ea0lpd0
	0lOwcLXS8u61ce7L9z5E3hzS67PiK4q0wTDXsbm1j4fmR4A4l7pov7Pl9Xtqol+bQJCF2g
	SBYbwhpFZD3QCd1IU3JEDouubYPDDsJo4Haj1EZ5XvXvPQJONj/pjKNU5DhhYg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: alexandre.belloni@bootlin.com, Wentao Liang <vulab@iscas.ac.cn>
Cc: bbrezillon@kernel.org, claudiu.beznea@tuxon.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, nicolas.ferre@microchip.com, richard@nod.at, 
 vigneshr@ti.com, stable@vger.kernel.org
In-Reply-To: <20260917102924.2146959-1-vulab@iscas.ac.cn>
References: <20260917102924.2146959-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: rawnand: atmel: Fix MCK clock leak in
 atmel_nand_controller_init()
Message-Id: <179034334517.1124555.16021884625975139988.b4-ty@bootlin.com>
Date: Fri, 25 Sep 2026 15:35:45 +0200
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

On Thu, 17 Sep 2026 10:29:24 +0000, Wentao Liang wrote:
> atmel_nand_controller_init() takes a reference to the MCK clock with
> of_clk_get() and keeps it in nc->mck for the lifetime of the
> controller.  If the "atmel,smc" phandle is missing or the SMC regmap
> cannot be obtained afterwards, the error path jumps to out_release_dma
> which only releases the DMA channel, so the clock reference is leaked.
> The callers return the error directly and never run
> atmel_nand_controller_cleanup(), where the clock is normally put.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: atmel: Fix MCK clock leak in atmel_nand_controller_init()
      commit: 94edcda45d888c3bb1310de11e10e4537c166f00

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

