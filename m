Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D83CA4A8;
	Wed, 12 Aug 2026 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527885; cv=none; b=fNE0BaX78+ogVzf5lC+jDP9D0QegyO1DllxJ5ymiH6JNE2waYyDiBCa5/F4YvhLC6ebR1CwhrQXPPwQXk7Z5SuzpfqKjy42l2lDD2CGMbXYM/hVJBFwguYA00BWC9SIYL+W6Ut1+pXti6Lyd/JH0NLvONmhN0XsulCO0yTTOcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527885; c=relaxed/simple;
	bh=EWQTMus7u1FJk0rQiKwJNCYvqzC3EQL45MuU1dLOwnY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=jqcVFoPyjFwdLT7UNGHM8qW/zylxIifzd3SOQ0CQKEz4l13+kiiYAOgedQfamDjK17lBdnZ8T/skxDgmDiFZIAK17ieHmGhci9z1uzuUdGV3fPNfHO7sRnQP3ueNmj38br10Fm+moLmlISh+F0dkYs3DTQvXORTFtEZrbIhBTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 971BF116;
	Wed, 12 Aug 2026 11:44:41 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 11:44:41 +0200
Message-Id: <DKMVA2HIPB2Z.J0W6OM4H3ARL@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Takahiro Kuwano" <takahiro.kuwano@infineon.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Tudor Ambarus" <tudor.ambarus@linaro.org>
Subject: Re: [PATCH] mtd: spi-nor: Unprepare legacy controllers upon RWW
 wait interruption
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260811-perso-rww-fixes-v1-1-5866a70e5d1c@bootlin.com>
In-Reply-To: <20260811-perso-rww-fixes-v1-1-5866a70e5d1c@bootlin.com>

On Tue Aug 11, 2026 at 5:56 PM CEST, Miquel Raynal wrote:
> All the parallel locking helpers (spi_nor_prep_and_lock(),
> spi_nor_prep_and_lock_pe() and spi_nor_prep_and_lock_rd()) call
> spi_nor_prep() then wait with a killable sleep. If the sleep gets
> killed, we leave the controller in its prepared state.
>

Why does this only affect legacy controllers?

> Call ->unprepare() in these cases.
>
> Fixes: 74df43b3f626 ("mtd: spi-nor: Enhance locking to support reads whil=
e writes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael
