Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8156634D4CE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422777; cv=none; b=DOEwAA3AiLNrP9krZqk33zzbDyScTOzUB6PewxLHo0TcBREBzlPgn/hrXTRT7vEKcI9UvV7aGF9d7VQAPK/nj/oSSqqEs7xejJt0wgT0HthwjFndVO2BoM5ZNF9WB77PxWklRua1B9fJQhi7L91+lc0XOtKd8wLceaRME6RePPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422777; c=relaxed/simple;
	bh=TfEMK0a33NS2jaUvlauAHM7l7SnnnIidRASqMeaGC3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WeDzMcPgGO/qepHe862BqtE0FLCdeIt4JAWcAvuTCTIpmO9Aeu4H9YyLYCSpfDpcMMQG31D5B4tjs3nGX+RLFqScA2O3Km7/U1ZwbdcsgENfNgEvl1Ssdu14xvMMKrAzFN1eNRSsniWw4ZpnNOywnp4moipn/g9DQsgIXeKAwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B3MGEt7o; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B3MGEt7o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C61B91A1983;
	Thu,  3 Sep 2026 08:06:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 97DCF602B8;
	Thu,  3 Sep 2026 08:06:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1907411C79B6F;
	Thu,  3 Sep 2026 10:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788422772; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TfEMK0a33NS2jaUvlauAHM7l7SnnnIidRASqMeaGC3E=;
	b=B3MGEt7o91rWgG+OB/jZ1KGIDkbGvXO5at21Ffhuhwy1BLzE7/eEvyCrcrZCz3B6PmJYwI
	c2Kbsow6FPwqH6sYJflF0L917opYPsrVJEsRKMdIc0/3e2Wv1Ze0laRume828yiEgzxFVN
	UBPjeyIziLfZJv7MggpfPWQIVKVKHgUxSlXqAL5vD2/yNgtNGXMvQ+IJJavF6S0cn4A6pT
	4xolGMxPMlR0m/S4/mpwcwUThfNmj1pykbu5gApMlog13rrejTdvNibxWewkwdVg/avr4Z
	mV9svE0JBMYT05Gj0Ay4yAPcbTPABP4VJyLxL8rZRhcelcHfjOubopJnlJClAA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Srinivas Kandagatla <srini@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Heiko Stuebner <heiko@sntech.de>,  Michael Walle
 <michael@walle.cc>,  Finley Xiao <finley.xiao@rock-chips.com>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-rockchip@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  stable@vger.kernel.org
Subject: Re: [PATCH 1/4] nvmem: rockchip-otp: Serialize reads
In-Reply-To: <CAKTNdwF_wY8JSoQs=auK_9YNGT+hwQ=dAhcRVsf1E1CVvFs-XA@mail.gmail.com>
	(Alexey Charkov's message of "Wed, 2 Sep 2026 16:40:16 +0400")
References: <20260901-rk3576-otp-cpuid-mac-v1-0-ea9135270fc2@flipper.net>
	<20260901-rk3576-otp-cpuid-mac-v1-1-ea9135270fc2@flipper.net>
	<87ecfc81e9.fsf@bootlin.com>
	<CAKTNdwH5S3MxgR=5s2LXPquCFRXE-61LTTsZoHP9+YmXo_P4Ag@mail.gmail.com>
	<87y0dk6jpn.fsf@bootlin.com>
	<CAKTNdwF_wY8JSoQs=auK_9YNGT+hwQ=dAhcRVsf1E1CVvFs-XA@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 03 Sep 2026 10:06:08 +0200
Message-ID: <87bjae7o9b.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Alexey,

>> I haven't seen Sashiko's answer but isn't the goal of guards to just be
>> released whatever the actual return path?
>
> I believe it's based on the guidance in [1]. In this particular case,
> gotos don't jump outside the scope where I put the guard, so the
> scope-based guard is still correct. However, stylistically, it is
> indeed uncommon to see scope-based guards in functions using gotos.
> Explicit lock/unlock is easy in this case, anyway.
>
> [1] https://elixir.bootlin.com/linux/v7.2.2/source/include/linux/cleanup.=
h#L148-L153

I never read that paragraph before, but okay, makes sense.

Thanks,
Miqu=C3=A8l
