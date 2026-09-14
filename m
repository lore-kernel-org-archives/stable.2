Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4322476CED;
	Mon, 14 Sep 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391713; cv=none; b=QJOHeUy4cqsv0VRYmhqVti9tehFXCfgigTc71X5dRI1OP1+sJIXL8cZQItl5H4pmlh5iGSL1JvZhCJzVjlJMyv3VHiU/z1t7PLGVfxyFCWbMwRpyvya4BKP4XZ+PZgjk36FLRy6GfTeYc83wNIJLRfbt6OvPMvL0xmjo5bt6ssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391713; c=relaxed/simple;
	bh=PF9u7DYv9qFIslukP9LwzISVHtIb3gYuRnqxZlxFypM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XUfvhzKXUIP0RIBGFEkAUoHC66j/j5lVeXk/7C3MasUv01n806jmcoGEHmX9aSYYafBlmyxXTQ21Kp77Rf83iqU+a+3187D+oOVB+fR02qWyA1lFif6+MVvAFA1RWZ+2BDaR8TNAaxjGR1dHEq+n/C8dwPCra/6n1HHeEHrdNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SxKPjlum; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SxKPjlum"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DA236C6220A;
	Mon, 14 Sep 2026 13:15:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9AC9960323;
	Mon, 14 Sep 2026 13:15:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C548511C7AFC3;
	Mon, 14 Sep 2026 15:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789391704; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PF9u7DYv9qFIslukP9LwzISVHtIb3gYuRnqxZlxFypM=;
	b=SxKPjlumrmLPx8G3OPdJHMCjg0uhorZ9JkemWkvjRbh/+4NYUgGLeeGxaJXWTAgXjj381l
	wN98FXQvXyHgS7I7CXFu4LgpgQBVEJ0ksOP37XPWW+oSLq4bP1+qGzbM1kAnIiY5cvjoy/
	4Psslo9bZ/mXq6obNaRJfY3P/dV6SuZmcRHDMcCaKajDrJR7gqLOpYFK5ifAg9dNSgGusi
	E8BAgOXPKZjkdkyTFgyZQ6745i8p5rXVMscORBPbJEQlatC9lO3IJsKryQ87Lv/VPNBOrQ
	svYncYsx6cis7MVfbq/gwgmw83VWLwBsbIlA5Jb8Vdv5IJKAD/YmVbqnn54eAQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>
Cc: Shan-Chun Hung <schung@nuvoton.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Brian Masney
 <bmasney@redhat.com>,  Richard Cochran <richardcochran@gmail.com>,  Arnd
 Bergmann <arnd@arndb.de>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,
  linux-arm-kernel@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] clk: nuvoton: ma35d1: Use clk_hw pointers as mux parents
In-Reply-To: <20260813-perso-ma35d1-upstream-clk-v1-1-e78e5e6172ea@bootlin.com>
	(Miquel Raynal's message of "Thu, 13 Aug 2026 09:28:10 +0200")
References: <20260813-perso-ma35d1-upstream-clk-v1-1-e78e5e6172ea@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 14 Sep 2026 15:14:59 +0200
Message-ID: <87o6e0nfe4.fsf@bootlin.com>
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

On 13/08/2026 at 09:28:10 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> The MA35D1 clock provider registers its muxes with parent data
> structures filling .fw_name. This is not the ideal approach since that
> would require a massive amount of internal clock names declaration in
> the DT. Since the DT does not play the game of exposing all these names,
> none of the parent lookups performed when instantiating the muxes
> succeed. As a result, these muxes get registered as root clocks, leading
> to a sadly flat clock tree and no frequency assigned to most of the
> peripheral clocks:

Jacky, this is an actual fix which is a month old now, the SPI
controller (and maybe other blocks as well) does not work without this
patch. Would you mind giving this a bit of feedback?

> Fixes: f50a000b4219 ("clk: nuvoton: Use clk_parent_data instead of string=
 for parent clock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
