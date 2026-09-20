Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA606261B71;
	Sun, 20 Sep 2026 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789912149; cv=none; b=FM1sQTO1NFGpbFGYwaqaYTFVN9p586H8auXPPLwnZJAXhPavpPL1VTisVr6nC+llSoA348aGO0dWQCPoBHtWq+nYsDgs/HSpUdsPTUIpBtmFIv/sewflZhUgfJc7AHsW5/QQBZqial91wSLQGlE6KdMtrucNzoQvv4wkQ+BNhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789912149; c=relaxed/simple;
	bh=8iTC9JPtz2vdRM9WQWi2dUzaX2OPQZPuYHgOoaoxIyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nBY/47U3n215reklspCrb54Ol841oi7cQDZ9YWMNC01GgfRjCwhxMMLxF5sATscvh1EmYmolfOhTzSc89qAvHX1jCVM9bp1qqz3ZP7E5DCRp0FF/hTyHkXuCTijnRYRtRjFSE9TNtTlR4FbSl3ValQSdRbWW9vILcKmkach0Mds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UTB/X/fS; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UTB/X/fS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A30ACC51468;
	Sun, 20 Sep 2026 13:49:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D7A426033F;
	Sun, 20 Sep 2026 13:49:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2997C103286A4;
	Sun, 20 Sep 2026 15:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789912143; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8iTC9JPtz2vdRM9WQWi2dUzaX2OPQZPuYHgOoaoxIyw=;
	b=UTB/X/fSimERrtJA+QubT29YWdvXZmjGdyjvuyFxudaWyR5aywLobj0LsBENQhH2qoPyYl
	J0o/ME8vsZ+/+EUEtH/IHtrR+WuS8ixESIB8gi4obLpH2irQ6HGGbTdJn7u6dH+phJxrAa
	lK5SVNuOPSsR7oyjeNhD70+3uZg8KVTHNAsmbeRmbDm2BDajhXNI4/zg+tppPdKFWBE18R
	LDwKYxM//w73mzK5g/sMo3XynVS7k7sjZfzOXbq5VEUwN1nRVsqt5/QHt7FyRg6m8/xTI+
	fDveY6ZfeF/L+F4kWKg2i3PxOzpj2IkLNPINDPLkEyT74atD8nzEal4HI+J6Wg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jacky Huang <ychuang570808@gmail.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>,  Shan-Chun Hung
 <schung@nuvoton.com>,  Michael Turquette <mturquette@baylibre.com>,
  Stephen Boyd <sboyd@kernel.org>,  Brian Masney <bmasney@redhat.com>,
  Richard Cochran <richardcochran@gmail.com>,  Arnd Bergmann
 <arnd@arndb.de>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,  Steam
 Lin <STLin2@winbond.com>,  linux-arm-kernel@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] clk: nuvoton: ma35d1: Use clk_hw pointers as mux parents
In-Reply-To: <b8a8a65b-e302-4747-bc90-4920fc48795a@gmail.com> (Jacky Huang's
	message of "Tue, 15 Sep 2026 13:26:39 +0800")
References: <20260813-perso-ma35d1-upstream-clk-v1-1-e78e5e6172ea@bootlin.com>
	<87o6e0nfe4.fsf@bootlin.com>
	<b8a8a65b-e302-4747-bc90-4920fc48795a@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 20 Sep 2026 15:48:55 +0200
Message-ID: <87o6ds8248.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Jacky,

> For example:
>
> =C2=A0 =C2=A0 static const struct clk_parent_data wdt1_sel_clks[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { .index =3D -1, },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { .fw_name =3D "lxt", },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { .fw_name =3D "pclk3_div4096",=
 },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { .fw_name =3D "lirc", },
> =C2=A0 =C2=A0 };
>
> The TRM lists PCLK3/4096 and PCLK4/4096 as valid selectable parent
> clocks for the WDT/WWDT blocks.
>
> However, the new conversion changes these entries to -1:
>
> =C2=A0 =C2=A0 static const int wdt1_parent_idx[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -1, LXT, -1, LIRC
> =C2=A0 =C2=A0 };

That's indeed correct. Thanks for the proposal below, I will include it
in the next iteration.

[...]

> I have also tested this version on an MA35D1 board, and the clock
> parent conversion appears to work correctly for the peripherals I
> tested.

Nice! If you're happy with v2, don't hesitate to send a formal
Tested-by!

Thanks,
Miqu=C3=A8l
