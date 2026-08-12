Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8A418346
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528947; cv=none; b=G4vRqYkSaD7WwQqTR3tDAeVbG8Reh6lPy6oaJvrcyt83ynYDjODNP3kQP1hAoSDjYuz/e5lAJ53+H/5NbaVI9bA4/g5dJzx6zMDOON1QG8sSQwGs03ny9Jhns26H+PgHwwxsacTLyu7PyxtgvT/q7fSt76vJjW/4ccepfAIK93k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528947; c=relaxed/simple;
	bh=cNiBZHt9kBQLY9Pvle7ghRA8gmUmPsgLNZWvyn6d4Fs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iEdzbtFTUI98z0uJyVJW+TckTXVk1V9bScM4KoG+E1vbe59tEaqkw7jit+diA+dJpu/g6b8dZhrRTwrvZfYhaQkaS+lzeYQdgEt3XwE1A5PnPsPuDPYC2SAFviJDNFja4xCc32lEAps/Oc7akCvGxj4RN0T1LX6zAuEeO9mfEGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QXeQ/l3r; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QXeQ/l3r"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 29B5F4E411D1;
	Wed, 12 Aug 2026 10:02:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EADC86045E;
	Wed, 12 Aug 2026 10:02:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A96911C4CBBE;
	Wed, 12 Aug 2026 12:02:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786528941; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cNiBZHt9kBQLY9Pvle7ghRA8gmUmPsgLNZWvyn6d4Fs=;
	b=QXeQ/l3rqQbZPi2SFx690Mf7wrlgCIPYcIzVTdm3x3N+LR0BunqRKE5/PkPJn5ah3iZTSz
	dqOG8NFj3QbWExuVHA2nzkfO7+3lgsePMv+oUldVz6Coj/eeFerkg19VbYVbYvAQNj1MxP
	f5/jwsokmbtVEgABox4TNTWbVVJfQO7RgI4K7HspEFuC0ZIEh4q9JamTqkpfbWwsg3Q0Lp
	MnIpt/ypg+eN+otJRt5TgYjcxJvsvMa93PQCH3OFjuqjzKOBBowHoe+u0/MDZWZCPMX95F
	9A07l+e1mhP3RAKuB385fyN50g/1YvVoiruTKBiCf6RAC61GAxU8i1wLhN2wBA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Takahiro Kuwano <takahiro.kuwano@infineon.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Unprepare legacy controllers upon RWW
 wait interruption
In-Reply-To: <e0d2710a-2a67-40e0-aacb-5d18742cea76@linaro.org> (Tudor
	Ambarus's message of "Wed, 12 Aug 2026 12:52:48 +0300")
References: <20260811-perso-rww-fixes-v1-1-5866a70e5d1c@bootlin.com>
	<e0d2710a-2a67-40e0-aacb-5d18742cea76@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 12 Aug 2026 12:02:17 +0200
Message-ID: <87o6f7mzbq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 12/08/2026 at 12:52:48 +03, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 8/11/26 6:56 PM, Miquel Raynal wrote:
>> All the parallel locking helpers (spi_nor_prep_and_lock(),
>> spi_nor_prep_and_lock_pe() and spi_nor_prep_and_lock_rd()) call
>> spi_nor_prep() then wait with a killable sleep. If the sleep gets
>> killed, we leave the controller in its prepared state.
>>=20
>> Call ->unprepare() in these cases.
>
>
> We don't even care about SPI NOR controllers. I stopped adding/accepting
> new support for them few years ago, so that we encourage people to update
> the drivers to use SPI MEM.

Yeah, totally agreed.

> The alternative is to drop prep unprep entirely.

That's indeed what we aim for, but in order to "fix" that report, the
current solution is to call ->unprepare(). Hopefully we can remove them
at some point.

>
> Anyway, all good, regardless the path chosen:
>
> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks,
Miqu=C3=A8l
