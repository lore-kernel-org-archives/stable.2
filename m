Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C0168BD
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635913; cv=none; b=EF24xK+0mxjL3JeNeZ89a+fc1wWwde6/BhR/HAiwiQ1F8RP3wF2YZ7ekhGq7g26eL5LdNRI5hL9fWpCJm4uTby8xGqgtA14DuePYPr7brELyeQ+P97WRG2koyoPCoSt+XZP2pSTESOlHYwQVuILqqckUl9CKAANHpGEjm50W/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635913; c=relaxed/simple;
	bh=0cAx5OVVaxm1B19LB6mVCJYySN/Wqh42M5HoVh9JnH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gv+8BTOcTuqJ/+lHoTE7H7na0ciMLg9tXVuzyRpGWIoeOoVQRaCluwt7d4eHEcygKGLQBie7qJg0OO9wBnSEDfrWM7KxUWpaN2vioPkqDBQGbQzcOHDyudr+QJ7MA1+gQSGFnnZt7mraAsQxQorTlZJp9bFgYkZZDKX+ZMPrRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uAEdUkc6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uAEdUkc6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 02C5A4E40760;
	Fri,  5 Jun 2026 05:05:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEBFB5FED1;
	Fri,  5 Jun 2026 05:05:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E780C106A1EA5;
	Fri,  5 Jun 2026 07:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780635908; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0cAx5OVVaxm1B19LB6mVCJYySN/Wqh42M5HoVh9JnH0=;
	b=uAEdUkc6KzLPxYbcAKBkInHdL3ovpa9JXFbH+bFZ0m9t9/ZNyytqF6LJku/QRMI9CwyBpa
	RHQKLHWKVVIdaNok9fvRwX2SnxgnCtPN8jkTrduOPsRxv5TUX+slN6eh+Yv2jwp1MUts+L
	ocjKqNdc/w9La4731yIn1YdVfT0Qw65y4UmQrgMuBniIgo6DL2XB2OQCVsPUfafPnVwJi8
	ZZfnCqG4wSV8OUeyLGDJTZc0PNOHZjff7KZr+3ZEHKA68nlDVtE/0/mhz8YKEiqKvII2+5
	ouNmjTMMNVStINsts8VrVjI6xv3TxV5GG8rJnnKEmJopNvoa3Mz6HBwBYH/liQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Takahiro Kuwano <takahiro.kuwano@infineon.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  alvinzhou@mxic.com.tw,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: macronix: Restore fallback
 parameters for MX25L12805D
In-Reply-To: <20260605005720.1857413-3-linchengming884@gmail.com> (Cheng Ming
	Lin's message of "Fri, 5 Jun 2026 08:57:20 +0800")
References: <20260605005720.1857413-1-linchengming884@gmail.com>
	<20260605005720.1857413-3-linchengming884@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 05 Jun 2026 07:05:04 +0200
Message-ID: <87pl25wpa7.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

> In a previous effort to drop flash_info fields and rely on SFDP, the
> static size and no_sfdp_flags were removed from the MX25L12805D entry
> (JEDEC ID 0xc22018).
>
> At that time, the legacy MX25L12805D was already EOL and unavailable
> for physical testing. Verification was inadvertently performed using
> the newer MX25L12833F, which shares the same JEDEC ID but supports
> SFDP. As a result, the probe succeeded during testing, leading to
> the mistaken removal of the fallback parameters.
>
> Since the actual MX25L12805D lacks SFDP support entirely, it strictly
> requires these static parameters.
>
> Restore .size =3D SZ_16M and .no_sfdp_flags =3D SECT_4K to this entry
> to fix the probe failure for the legacy part.
>
> Fixes: 947c86e481a0 ("mtd: spi-nor: macronix: Drop the redundant flash in=
fo fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
