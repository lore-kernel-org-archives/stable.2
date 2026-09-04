Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD74B1B3D;
	Fri,  4 Sep 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531674; cv=none; b=E7LbVM8jww2x6INXGB1nsVka4zhx2WzBN9LGr+yR+/UsWGA7sOEfUfi7xZ9lMUfvpLNyR1Qxr4i0+/QP0jiWz+eTaEhmORANU01+O8Rrv5CLXWgpU+qj+r6QVvwoUYpkBRiwkZUVnt26HTc01I8QDWSE2uJuQ7F+oEQ00ADNbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531674; c=relaxed/simple;
	bh=ynSkEEn2AayaVItGbc0pik8ORE0zJfA+LwEibXbCBjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J4Q2wIAp9OVj931C6YELXB6N8rTQWJQLPSZY5akP7DsRjpr2vXnNYmE0Rmr2bloCrdQD7bKS1gjNar0bWUXSka/jWsiH0NU13+d2FxsfOXa+Fze5fyjN1rV1uK77o1Xvr1enAqAHd2P8CBmILeiYpKyoQKaF7hG3/VX1WlJSfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tHBUi/AG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tHBUi/AG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 003384E41510;
	Fri,  4 Sep 2026 14:21:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE0176057F;
	Fri,  4 Sep 2026 14:21:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76F4511C7ADF4;
	Fri,  4 Sep 2026 16:21:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788531667; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ynSkEEn2AayaVItGbc0pik8ORE0zJfA+LwEibXbCBjk=;
	b=tHBUi/AGMm8DW2aVTEPEjh48i2U9lZ+F9u0U7awvVM3b9eUzHau8rUOJDEyO7kXM/woCVk
	PrgTmCiux/8t5NnxUeDY//FeilfLK5UjQsU8u3QI7m+QMgDvqWQh5hJLWSsL9E/x3XpyVt
	E/wph6bV7nqz/KLHj6NxHgBcdbEOas6kYHBWi/lmH3nYSK1gXc8Uz/4NTNV6pNJ8nuJ8Xc
	y3myPHp6pUCithVWKI+haBsrYyergxoSzlvQbElztJ0CxSXWy0gOaQkN9IIj5azx3rCnZd
	2B55e+VKFzjR5LzIFyYT4Sri/8hSDBq3m6Sotyb1w811kihV5CUo8NvzgrQ7gA==
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
Date: Fri, 04 Sep 2026 16:21:01 +0200
Message-ID: <874ig52j3m.fsf@bootlin.com>
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

> Instead of declaring the parents in the clk_parent_data structure, use
> the actual HW clocks to lookup the parents directly: parents are
> described by an array of indices into the controller's main clock table
> (like in other clock controller drivers), which the "new" mux helper now
> resolves.

Sashiko complained about this:

```
[Severity: High]
Could this lead to a kernel panic if a parent clock registration fails?

Looking deeper, from my point of view the issue is purely
theoretical. The only possibility is one of the early registration
returning -ENOMEM. Despite the fact that this is quite hard to actually
reach, if someone gets this kind of issue early at boot, they will
likely have bigger concerns than their peripheral clocks not being
reachable.
```

Brian, Shan-Chun, Stephen, what do you think? Is this worth another
version?

I can send a v2, or make a follow-up, or just ignore
it. ma35d1_reg_clk_pll() and ma35d1_reg_adc_clkdiv() are equally
"affected".

Thanks for the feedback,
Miqu=C3=A8l
