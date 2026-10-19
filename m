Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DA483BFA
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397606; cv=none; b=ZwtioQay9u1/yPwOOzmMwuiXTAB+sYHT6MiN1vFwVsCLhi5KcWMvWbYfmhf7iWj5ASwPoRp4BXh0mCgW9vvHQuYVRlj9joWDe5RyDB9jLLNJxf2ggsdvpQAhVF884Y7uXpzyD61Szb8McmzKfw2dBfQ902hc5aPufnv0+rpzAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397606; c=relaxed/simple;
	bh=XouZpUQ5YBG7lppUugLKluXBp9QpXs/PNN1AJMW6by4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rp6MvSK6XuJFgG1yULQMILbc+pHgmvVYUFadZTweH/tfvWtCuSO+wML9IRdeNX/6ChLg+tz7s3Jd70qy77MqR9RcY1tAsdkfkDO/+0z6QgKz1Gy2mvJOXxeNxTwikMXd/eV33oix/vyQM8Wnd++fYm174B43BtcK3oaYnHOjLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FvItgfkB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FvItgfkB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C341E1A1208;
	Mon, 19 Oct 2026 08:13:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9304F60582;
	Mon, 19 Oct 2026 08:13:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C06F010328429;
	Mon, 19 Oct 2026 10:13:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792397601; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=trNQO0U9XQLBOWcQGLIc+ci4GywnkatJEUe8E9u6r4I=;
	b=FvItgfkBI0uIwemxLOQyXNqDxWTC/p0cGmtkocphPeGleMMne9ZPgFH0wpCiMNJtFVpPKV
	+g1u7KYl2AJaktUp0fVPQLS+bEuvTbJB9e7RfonI4dpFbM29cq7QBf6xt9KPPehchHuHXd
	yL9QIyg4JYh8gCnBNPJ6z9OjGOcL6rHMvJ4pldB6QC7y0LtoBGTPEfyj1ez4iVYMO+ng/q
	JMi6xmyW+h7DjjhbvAai1Swrfgsi80X7i9etz4cbWXjgsNa1VDPhuykMnp5o6ABI+955Z9
	ZvqH8FrEy2lodwuX4g7n4uCq6sSiR9PjTSTaoKfSY+jmZdAOcgF6y18MWSRAig==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>,  Shan-Chun Hung
 <schung@nuvoton.com>,  Michael Turquette <mturquette@baylibre.com>,
  Stephen Boyd <sboyd@kernel.org>,  Richard Cochran
 <richardcochran@gmail.com>,  Arnd Bergmann <arnd@arndb.de>,  Brian Masney
 <bmasney+clk@redhat.com>,  Jerome Brunet <jbrunet+clk@baylibre.com>,  Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Avi Fishman <avifishman70@gmail.com>,
  Tomer Maimon <tmaimon77@gmail.com>,  Tali Perry <tali.perry1@gmail.com>,
  Patrick Venture <venture@google.com>,  Nancy Yuen <yuenn@google.com>,
  Benjamin Fair <benjaminfair@google.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,
  linux-arm-kernel@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Krzysztof Kozlowski <krzk@kernel.org>,
  devicetree@vger.kernel.org,  openbmc@lists.ozlabs.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v10 03/10] clk: nuvoton: ma35d1: Retrieve HXT/LXT from
 DT when possible
In-Reply-To: <179224882241.859276.15035084302735586039.b4-review@b4> (Jerome
	Brunet's message of "Sat, 17 Oct 2026 16:53:42 +0200")
References: <20261015-perso-ma35d1-upstream-clk-v10-0-47c97b54a809@bootlin.com>
	<20261015-perso-ma35d1-upstream-clk-v10-3-47c97b54a809@bootlin.com>
	<179224882241.859276.15035084302735586039.b4-review@b4>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 19 Oct 2026 10:13:08 +0200
Message-ID: <87zewayup7.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> +	/*
>> +	 * Old DTs do not describe the low-speed crystal. They may also expect
>> +	 * an HXT output from this driver. In practice, nobody should use these
>> +	 * clocks directly, but they must be kept for backward compatility
>> +	 * purposes.
>> +	 */
>> +	if (num_clks =3D=3D 1) {
>> +		hws[HXT] =3D ma35d1_clk_fixed("hxt", 24000000);
>> +		hws[LXT] =3D ma35d1_clk_fixed("lxt", 32768);
>> +	}
>
> The above is fine but the problem is those IDs still exist and something =
like
> <&clk HXT> is still valid in DT but now does not provide a clock
> anymore.

Yeah, it's hard to prevent, but people would immediately face errors
when developing anyway.

> This is why I asked if you about removing the ID. At the very least a com=
ment is
> needed next to the IDs saying those are obsolete and should not be used.

Ok, 'next to the IDs' may be relevant indeed, I'll add that.

Thanks,
Miqu=C3=A8l
