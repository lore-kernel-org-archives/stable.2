Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA53B3883
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789803905; cv=none; b=ZLa3nSZ2CiV2Fz83qUeStDa5q6jBdYpzM/R4f8kK5ow68bt3A1m1Zny6/fnR7JDm2ojZVLPXreskqq4vC0ZFLjWFVfZOm0s55xprw3KwF3KfnoyjyjCR4NCLem7iMIrX20BkYhtxQbZtAx8+8L499gax8cRlIZnX7QpiyC3p2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789803905; c=relaxed/simple;
	bh=Q1nUjk9VuBCM7ULANZtpDZsdAc2C3fd8JSuzKbgnvQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=suIkpomWoEADibjaG1FnJPMMgdZhrCjKSiZ4A0fAhFDPy5IXUfYzxSi1J+TAu23lPJXpa4kWgEbe+pQDraNSyvIJx3sbunLzvhOnDax9Z+QXv0hioBL5PO4RQD5vQZ6EJgxTS4bgI+9KCGTEzEIQItvBuR/wqKYsvIllffPrpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jHPYmXIC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jHPYmXIC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 56AC71A09D6;
	Sat, 19 Sep 2026 07:45:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB066606CA;
	Sat, 19 Sep 2026 07:44:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA9C31032907B;
	Sat, 19 Sep 2026 09:44:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789803898; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Q1nUjk9VuBCM7ULANZtpDZsdAc2C3fd8JSuzKbgnvQ4=;
	b=jHPYmXICISt0CBNQjPTDTCC2qeZGvMsEMJrbnwLOm3YogxWf3b761RqRUgHk4k/qiSDy7e
	W/YLodLm8ONW3xTvS2dp3x/JSSjNy3k/Q9BQKZFU0WRIc7/gEPd3koACUfo2mPE6HKqVOb
	cPZMjC4/1pc4R+u/YZUQXVgi615GFpnT1TbLF/cbrIE9PftbtkKQTrQL0tidZO5ZvryMYE
	we+X/a+wBLsMrbDUD9Vaw9ZOeLPWg7gxzcA3DJ5VBlUFDUMPbtXyRUr/IEYmQPcRG5qsQu
	O0uSGkuHhtt8p51XvVvFo4mUEqAyuhWx2UDpVn4VdsiKCih4gqaTshLp7R82Ow==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: sashiko-bot@kernel.org
Cc: "Wentao Liang" <vulab@iscas.ac.cn>,  alexandre.belloni@bootlin.com,
  sashiko-reviews@lists.linux.dev,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  vigneshr@ti.com,
  claudiu.beznea@tuxon.dev,  stable@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  nicolas.ferre@microchip.com,
  bbrezillon@kernel.org,  richard@nod.at
Subject: Re: [PATCH] mtd: rawnand: atmel: Fix HSMC clock leak in legacy
 controller init
In-Reply-To: <20260917103855.934A81F000FF@smtp.kernel.org>
	(sashiko-bot@kernel.org's message of "Thu, 17 Sep 2026 10:38:55
	+0000")
References: <20260917102804.2146887-1-vulab@iscas.ac.cn>
	<20260917103855.934A81F000FF@smtp.kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 19 Sep 2026 09:44:51 +0200
Message-ID: <87se35elcc.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 17/09/2026 at 10:38:55 GMT, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] mtd: backward goto in error handling path violates kernel
> style

Yes, it is strange, can you please fix this?
