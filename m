Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FFD4DBD8E;
	Thu,  1 Oct 2026 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850516; cv=none; b=lVOwisFyIgBFY3eutmABxMXCIOjRnV7eitPTfimxc0Tr8trl+HNkd4ldPC3d0v4i+WoIGtSM9a2D9Urd5d0fiq2n+IDdSZrOktuC4kmCtwNGEjZ/tEMp/vhB2KrdGXS5meAXt99Y0uYyXje1o0OuwZBFCmP2WRA9ZLwIIMISl9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850516; c=relaxed/simple;
	bh=Q29obV8omClDmxn+f8l/iIlcowgBclhhgHspfu6yWmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bgeIRbtyoxA7/FKrd3y9urrWQjz3mZoK/vspnZaL3+ahR9blfEAhMo3SnNdtTaiXVl8vrwpCpmkCFNPK+aftJ7VxEh+uqwZRtXTnI3k3w35oykRY7LzuvOehkbctpTTZTl7KYpyM8Yc3pa1tyywrTv0vMdoY+rufDp5+pglmJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TM2zAZZ2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TM2zAZZ2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B524A1A1098;
	Thu,  1 Oct 2026 10:28:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7FA6960341;
	Thu,  1 Oct 2026 10:28:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6B16103297EB;
	Thu,  1 Oct 2026 12:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790850506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q29obV8omClDmxn+f8l/iIlcowgBclhhgHspfu6yWmw=;
	b=TM2zAZZ2CoKjlETXMGPxKLKo84nTN3todnDzcsvS1T4ywQ8Ex2wodInRWk2Ao9QxKtlsLD
	qySzhx293w081fVQPxJaYhJKF5/4gL5DGP7RxzXU1ePu5NByvvADVgT2CXR8FCuwPAeb1X
	ex67AocTshgW18Nq/chZ1H5D9ggahR5OrK3zOFYT8olyP9d2PjLAoYl6n5gnZQoOqCeXRu
	g6MNV/KGS7wEG/mnHybljnWAxyKcDoHYMfOAN+HjI6LBBr6++3OZP/M1+ma9jK3YNmxz/s
	3y3FOnih/6MDNxWywF7dea3icq5uoBpMEL6ChdD8tiWAYlEVu23oM+mlxAEn/Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>,  Shan-Chun Hung
 <schung@nuvoton.com>,  Michael Turquette <mturquette@baylibre.com>,
  Stephen Boyd <sboyd@kernel.org>,  Richard Cochran
 <richardcochran@gmail.com>,  Arnd Bergmann <arnd@arndb.de>,  Brian Masney
 <bmasney+clk@redhat.com>,  Jerome Brunet <jbrunet+clk@baylibre.com>,  Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,
  linux-arm-kernel@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Krzysztof Kozlowski <krzk@kernel.org>,
  devicetree@vger.kernel.org,  Jacky Huang <ychuang570808@gmail.com>,
  stable@vger.kernel.org
Subject: Re: [PATCH v6 05/12] clk: nuvoton: ma35d1: Add missing WDT/WWDT
 parent clocks
In-Reply-To: <1j4if53gcf.fsf@starbuckisacylon.baylibre.com> (Jerome Brunet's
	message of "Thu, 01 Oct 2026 11:44:32 +0200")
References: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
	<20260930-perso-ma35d1-upstream-clk-v6-5-48937ee6c9bb@bootlin.com>
	<1j4if53gcf.fsf@starbuckisacylon.baylibre.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 01 Oct 2026 12:28:18 +0200
Message-ID: <87bj9dogu5.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Jerome,

>> Reported-by: Jacky Huang <ychuang570808@gmail.com>
>> Closes: https://lore.kernel.org/linux-clk/b8a8a65b-e302-4747-bc90-4920fc=
48795a@gmail.com/
>> Suggested-by: Jacky Huang <ychuang570808@gmail.com>
>> Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock co=
ntroller")
>> Cc: stable@vger.kernel.org
>> Link: https://lore.kernel.org/linux-clk/b8a8a65b-e302-4747-bc90-4920fc48=
795a@gmail.com/
>
> Is this is a mistake ? We usually add this when applying

Yeah, I made a mistake and then b4-shaza'ed the patch to get it back. I
didn't notice the Link trailer but it probably got added there.

Thanks for taking the first half! I will try to fix the following
patches as you suggested.

Cheers,
Miqu=C3=A8l
