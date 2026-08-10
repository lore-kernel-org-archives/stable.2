Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82443F65FB
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371963; cv=none; b=r3PdIZWxi7qZTFlFJiHymesLxS7hHv+cVKdZlmxCBAih9KhI9RcxBVMG8A3KOW2icNZRX+/FRQ7QU5o2CM/8faCuR1zTldHQuEzKI1y5FZrZmYvu31uoEAT5DGIh9j7/q7ahgpBrWX6wPadPaP8dTsiPB5eF0miAZ/pPFnofZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371963; c=relaxed/simple;
	bh=y0J+0ZyftE6P5Fjptu4SbAryEPH6TuLoCOfn+OZ0s+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fiaAtGsusLWZTZRzlIYXrb2MsSPJTqSPQwsASkiycraQwQIGWs8A/6FrimFXHXmO2LlToBwen3/jcwn+Vz0vPFmUMU8/8ZxwogvZ03Si2bQwd3laH2libPBn+NCFhxjMxA7f7O/FbaeZqepX47SrwRmBlDuPOGdF55eZKxIrzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0Hv6b62v; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0Hv6b62v"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3FA151A153E;
	Mon, 10 Aug 2026 14:26:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 113176033B;
	Mon, 10 Aug 2026 14:26:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3546011C4A8B9;
	Mon, 10 Aug 2026 16:25:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786371955; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wO+cXkZt+topJfy8NdQFR79mWwPl4kfgdmUuuL3DDzA=;
	b=0Hv6b62vBOPQbozjljwug2VfT0fSg943Beu1OT2NhDbVVnhDhIkUY9PBI2m6S5t6cOg/pa
	WH97Ch6PZaAtdOwW5bS0xdGxazCL9apKC63/y3MysUwKJbyI6PhST+lF2db45YAyP3oubg
	pVDuwQzW4czhB8640hKUOmTL4lqckHMefpnSCoCOGi53qz4vgXi2LtQae2gxFlp5xj+6fC
	s07S9J0QepWqPDA1tSQs7N/LOq+6DSUEMPVAjwhmfWfQn9BdYcBt+DgUayegJa2isuFS+d
	KTGErDZ/axKgn1aLlixEADItLpzNVpiDNrlxr9o5uumfcDKvzdYi6tI+0l7ncw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260807-submit-sunxi-nand-h6-h616-timings-v3-0-91287b543f41@gmail.com>
References: <20260807-submit-sunxi-nand-h6-h616-timings-v3-0-91287b543f41@gmail.com>
Subject: Re: [PATCH v3 0/3] mtd: rawnand: sunxi: fix H6/H616 controller
 timings
Message-Id: <178637195198.1098769.15933415840493831349.b4-ty@bootlin.com>
Date: Mon, 10 Aug 2026 16:25:51 +0200
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

On Fri, 07 Aug 2026 09:38:58 -0600, James Hilliard wrote:
> The sunxi NAND timing solver currently applies the original A10 NDFC
> timing characteristics to every supported controller. The H6/H616 NDFC
> uses two internal cycles for several setup and hold intervals and has
> different delay-field encodings, so the resulting clock and timing
> register values do not match the hardware.
> 
> Prepare for per-controller timing data in two behaviorally focused
> patches, then add and select the H616 characteristics in the final fix.
> Legacy controllers retain their existing setup-cycle behavior and delay
> encodings.
> 
> [...]

Applied to nand/next, thanks!

[1/3] mtd: rawnand: sunxi: group controller delay tables
      commit: 9f2e033754c6c023150f184b4e72bbcc5d6eea13
[2/3] mtd: rawnand: sunxi: describe tADL and tWHR delays
      commit: 147f2a5743f8864bfc265654b1856af11c8c0031
[3/3] mtd: rawnand: sunxi: fix H6/H616 controller timings
      commit: 15a3cbce32994141252bb4ecfe3ff3a5d22d0b4f

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

