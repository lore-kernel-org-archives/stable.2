Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB11E7C02;
	Fri,  4 Sep 2026 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539397; cv=none; b=BAtrpweIJE6GQLv6oyjG6u3j+cORw6ynVNJTXlX1lN8dh4ZMzWMM48C/va30voxmB6TMckyzcS6/X+7nrWYPC8XUNvutNWAJrbUVBp7jnUemebxLd/VgV3jdDZ4CjdwshZtQvmPfQA4jOQmbHhSaIiDLUPJ6e/6c9Tc12cUQRhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539397; c=relaxed/simple;
	bh=kNwmH73VN/KLnq5GP1jIEEERq85oS6f+kg0FA6mt9io=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Ac2E179e2Ugzhj1XT/9km7lnFWPrJlQjhxipD1zo7Z/aDzh7D6+scvQyiEJA7At0DERX3qrV57iD1Hczj6KIpJ+kjIFtuUBSfXfipxETUE8gzDeoTDG0QSAcyXkcXC83GIRgCmGsxM3MhZ5dXiORS6ywuK6UC4IWwf+De86AiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tli4roSQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tli4roSQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C2FBA1A19AE;
	Fri,  4 Sep 2026 16:29:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 95D4D6057F;
	Fri,  4 Sep 2026 16:29:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51C3D11C783E9;
	Fri,  4 Sep 2026 18:29:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788539388; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kNwmH73VN/KLnq5GP1jIEEERq85oS6f+kg0FA6mt9io=;
	b=tli4roSQ824Du4r3VYXVsVfLicDno0qyN3Ha47gRUwqcrOoVKzbPWYIMm/A+QD3MjDbzW9
	Q6Z795H5I6MmB5FRVqRP/yJXZZY6HIQborVlbQGZjDsU+MGrWZfBMZnTHudwKXuU00952e
	dRZcyemVgbzo/7lyoJpUnDohmP/lWTkUjmvPDjDFxu+jyhydNW7eBbDBu2g00Muyt26L37
	pnRnCx8+P7X3OlfajEno4Tcj1VOpkEwGxNfMCqvnpM2qmRxF9gEoqQBZ7TxXM/kg/KkjB4
	Qtz2GsGm/WAz/zTyt7AAxCWRF7DafahMpwAE7cCoJFWU7GpUc1nIDTRy+BU9WA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 18:29:41 +0200
Message-Id: <DL6OAOW07VTV.3T0UVU3HUJJF5@bootlin.com>
Subject: Re: [PATCH net v2] net: macb: initialize PTP state before
 registering clock
Cc: "Richard Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Jianhao Xu"
 <jianhao.xu@seu.edu.cn>
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@microchip.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260830153520.2710520-1-runyu.xiao@seu.edu.cn>
 <20260904030439.3994047-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260904030439.3994047-1-runyu.xiao@seu.edu.cn>
X-Last-TLS-Session-Version: TLSv1.3

Hello Runyu,

Your To/Cc list is incorrect. Have you checked out a recent kernel and
used b4 or get_maintainer.pl?

That is documented in Documentation/process/submitting-patches.rst

And your clanker even has its own version nowadays that mentions it as
well: Documentation/process/coding-assistants.rst

On Fri Sep 4, 2026 at 5:04 AM CEST, Runyu Xiao wrote:
> gem_ptp_init() registers the PTP clock before initializing
> bp->tsu_clk_lock and the TSU hardware. Since ptp_clock_register()
> publishes the PTP character device, userspace may invoke PTP callbacks
> before the lock and hardware are ready.
>
> In addition, gem_ptp_init() is called from both the interface open and
> resume paths. Reinitializing tsu_clk_lock there can reset the lock while
> timestamp processing is using it.
>
> Initialize tsu_clk_lock once during probe and initialize the TSU before
> registering the PTP clock.
>
> Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260830153520.2710520-1-runyu.xiao@seu=
.edu.cn/
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

This is technically correct, though I'm pretty sure the window is tiny.
I always prefer when such commits indicate if the issue was faced in
real life *or not*. So here the commit would be better off mentioning
that this is a theoretical bug never encountered in the wild.

Seeing your patches sent my guess is not.
https://lore.kernel.org/netdev/?q=3Df%3Arunyu.xiao%40seu.edu.cn

Also you forgot the Reviewed-by trailer sent to you on V1.

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

