Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D44503FC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940491; cv=none; b=oNM1JjjWZDlacHpX0HmDM/pxBgnVptVAb/6NA8lvsmBW5nVI/dN/A7j+mpLZFXJ9T4pL966ba/cVFr0rrR0wUp4cRjQ1EU0weB7BE1FD7MKG0AvHR3mRH6GBS/5TO0BR1hhWW1HYgtffMdODuKSE6NpR4pBoVk8miVA0khQj+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940491; c=relaxed/simple;
	bh=eFRJdp2z+0teMYKHzLnfmiDFFc/g/AkJsPASFx3qRf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CvtzheWwjeRtrJev3YUtLqGAEAJn1Hii6bheEh4fPr8LEBZbdhwApFiBbwgJoaLy+R91My5/0Av5ZhR4hc1MlZXvVSTSAiFjXw4oXRv7UcQr9JAatvNbj+zrCJmB1x6i1xlMjobeIYUPn/QZqZ4zNw8Dwtux0CTnOqUNX9fli2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wLocEo5N; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wLocEo5N"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5E3EE4E415AD;
	Wed,  9 Sep 2026 07:54:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3218560448;
	Wed,  9 Sep 2026 07:54:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4341011C7AF61;
	Wed,  9 Sep 2026 09:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788940486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VCziTK7/ZlchWwHqmkXGXHZceo76YfKx9HLgZZV+t2Y=;
	b=wLocEo5NeGJxWZoMuHWNaoeWhaRnwV3YoqdXrF51kluEIHy3s9lRqOdyhklt96QunRLrWB
	OGEBxmAjUOBlOFWfu2mMpp56Z5G9vnJQjEDxkgln2AgIKjUosDnP3rPyOuE4cNxdop2q68
	oigEErkDma6koDhmK+/WNFPiDzQ6pVI4McsS2ko1Ux6dlyvGDJQ7XMPDmz9G8C3WhoITzc
	cruyy4aygAFPfAJ4EPTgKZkjbWg6mmptzb5+FkUxg/tsUa4d7A9cFtLjkcW9cyo5IO6KH5
	OlPFPplfjnzk4CK3Dckj4ea3aIKmgOAJ7oqN6wRIyTBSfiyPe+/liDR53g6zxg==
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
In-Reply-To: <20260904-submit-sunxi-nand-free-oob-offset-v1-1-cf389b9ac94c@gmail.com>
References: <20260904-submit-sunxi-nand-free-oob-offset-v1-1-cf389b9ac94c@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: sunxi: fix free OOB section offsets
Message-Id: <178894048508.2040467.13585862125514884362.b4-ty@bootlin.com>
Date: Wed, 09 Sep 2026 09:54:45 +0200
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

On Fri, 04 Sep 2026 16:17:58 -0600, James Hilliard wrote:
> The sunxi hardware ECC OOB layout places protected user data before the
> ECC bytes for every step. Since variable user-data lengths were
> introduced, free sections after the first use sunxi_get_ecc_offset(),
> which skips the protected user data and points at the ECC bytes instead.
> 
> As a result, the MTD free-OOB interface addresses ECC bytes rather than
> the protected user data for those sections. Use sunxi_get_oob_offset() to
> point each free section at the beginning of its protected user data. Keep
> the special two-byte offset for section zero to reserve the bad block
> marker.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: sunxi: fix free OOB section offsets
      commit: c56d52865624ca236c44838ef9366a8597b6af6c

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

