Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9EE35972;
	Sat, 18 Jul 2026 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784374223; cv=none; b=RWVplLxeX2QyHlMH2RKeOWO1YazX29mU2VUXN7F23yQfsg9L2IM7hRmUzpUekppjzp8Wd5ssHgOHLjCezZ3ANCbIyrjT+yDJz5gLu1uoYBY8kEkyT2PN6TklJEyMkodRmwWB/LpIa1w3rNO4U5/U1CpE2GkHQrTfg9ImOrHpUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784374223; c=relaxed/simple;
	bh=boFit2Hy/EG+JX1++7ZX5P/mBiURjKww6YJUqa1i2Kg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dvs1avSN8P65kAe+ObROMP2AO2Iwotrqw4qClRnPF2ySI1TFrddoZ5KlkZU/i5RLjRU1wdCMrv/Q9iRycDGLQXFDimH/mLTesZgjDv7m2JQABCeAvb+ZY3GOEuqgFc5qqRtpDeHYz6W8LAM6a3ui7Nl6D0JJIq4A53L1/QwAYMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=V5YQC7Ue; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="V5YQC7Ue"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4h2Phm5HFbzKnR5;
	Sat, 18 Jul 2026 13:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784374216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=impHDjenMIJErEGwDatH0w1SiMFR8u879Cjzsuf2iok=;
	b=V5YQC7UeDTEjbe402VoyHW+O4eByuzyQMKs562aNH1f1PTDQgWRyRhLG7k+62kPRjDGM4b
	HhtZReOzxd2itJtWIzsgc0sQoYwII8y83BsFEa0yQwL2dILam3EikOXSc6HU/5RHFcBZqe
	WcGgYa99X4UMr2OQqqLAccP3BS6Ajl3NHG70Nnm9IT/HazIaCA5AKhl7Q/rhBMJ9Q04yxE
	85kU88G6Svq95H+ISh4b/KSgjTLCR4ObGddNhGGJDOL99f08U+XtEQQ3hcddoMQfpyljbO
	5L/8bUmlTUdqGUYRPUyjH3pmg3CaWpquyzsYU16qvcrkigaa0PTs+iWMeFIesw==
Message-ID: <49ad090f48d0ad38a46642c2ddd019ae3cfebc82.camel@mailbox.org>
Subject: Re: [PATCH] USB: phy: fsl-usb: fix missing static keywords
From: Manuel Ebner <manuelebner@mailbox.org>
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: linux-next@vger.kernel.org, linux-usb@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
Date: Sat, 18 Jul 2026 13:30:11 +0200
In-Reply-To: <20260717154957.1853976-1-johan@kernel.org>
References: <20260717154957.1853976-1-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: defd08d209d5d9186f3
X-MBO-RS-META: qb4kafrytksnh784kfinnqhmnj564f6y

On Fri, 2026-07-17 at 17:49 +0200, Johan Hovold wrote:
> A recent change enabling compile testing of a Freescale dual-role
> controller indirectly enabled a USB PHY driver to be built. That driver
> in turn is missing a bunch of static keywords which results in warnings
> like:
>=20
> drivers/usb/phy/phy-fsl-usb.c:105:5: error: no previous prototype for 'wr=
ite_ulpi' [-
> Werror=3Dmissing-prototypes]
> =C2=A0 105 | int write_ulpi(u8 addr, u8 data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~=
~~~~~~
>=20
> which consequently breaks -Werror builds.
>=20
> Add the missing static keywords.
>=20
> Fixes: 0807c500a1a6 ("USB: add Freescale USB OTG Transceiver driver")
> Cc: stable@vger.kernel.org	# 3.0

Add linux-next@vger.kernel.org

> Reported-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/r/4f9f5ff9-8eaa-4bd5-9331-37119f78e13f@sire=
na.org.uk
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>

Thanks
 Manuel

> ---
> =C2=A0drivers/usb/phy/phy-fsl-usb.c | 52 +++++++++++++++++---------------=
---
> =C2=A0drivers/usb/phy/phy-fsl-usb.h |=C2=A0 6 ++--
> =C2=A02 files changed, 29 insertions(+), 29 deletions(-)
>=20
> [...]
