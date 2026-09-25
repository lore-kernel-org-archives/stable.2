Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4248BD46
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331536; cv=none; b=NF6pZbU3iKFqcsPSSLuoDQXVBeROn7UuNumrSsRvypo4DR/GHuqJykCBdP60w3C2MlyB8xMSnOq01BRxlQPEM9lfUz30R/WkjattFixGhuOyHQt4M+VKbbIGL440KGsHd16okEjgydZEjIFUGhw6HxVU7z1+1E6reCeS89CyNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331536; c=relaxed/simple;
	bh=S/utM3sdImddBhCWP9nOtG9Myaz0h7gbm/vUzk5NP0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fK2SuKxSkWy626iPOMx/KLOC//6TpR7vrCx/K5tKMbMYlVx5YcbFxbHasFkyizL1MTs+zLNUw2uTwsYZ2Jw7S3/lo9Upr+Pic6ZDw6/0wv8zYBGO039pUKbw+ZovsuBZ6fEVbSCGRxbmilRrRdNT3wLSiGmitiBc4luXD1XEeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KGze+7yT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KGze+7yT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 71AB14E4106E;
	Fri, 25 Sep 2026 10:18:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C7F26073B;
	Fri, 25 Sep 2026 10:18:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 312DC1032950D;
	Fri, 25 Sep 2026 12:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790331530; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mApBpQp0os5vr24PicEoNzJZQZry7H/S7laJ5tY3XaU=;
	b=KGze+7yTzC2ZY6N6yVIJmusuIUu9hSelV4KsMoKlaBqEOlEOreXhY2p7qEN1BkL8VHpo5L
	o1HLNKcMUT+4pHbbpdDlUsZpLZp91+Xxdb77RZHBwwoLmL1OA7Oyw+ATkmPVBBsuRfwXWa
	/0eMo98+rjfyTMsCRZT+JbeuDwvAbqgOzECFNND5GEt5dwNOUDi+i1TUKgnknt02vuXVh+
	fFnwhZn7cOOuFHy7c0tKcoSVyuRrEoR7YJlEWHgm30n1YB8wlCUdmBSCtCGtdGAJ/uPFex
	MFCav7TCGV/ullelpzYMZMn9939pRMMtKSV/eIBs3g6oAd6X62UO5mF90xzNgw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,  Shan-Chun Hung
 <schung@nuvoton.com>,  Michael Turquette <mturquette@baylibre.com>,
  Stephen Boyd <sboyd@kernel.org>,  Richard Cochran
 <richardcochran@gmail.com>,  Arnd Bergmann <arnd@arndb.de>,  Brian Masney
 <bmasney+clk@redhat.com>,  Jerome Brunet <jbrunet+clk@baylibre.com>,  Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,
  linux-arm-kernel@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org,  Jacky Huang
 <ychuang570808@gmail.com>,  stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] clk: nuvoton: ma35d1: Add missing WDT/WWDT
 parent clocks
In-Reply-To: <20260924-bald-awesome-griffin-7d1d5b@quoll> (Krzysztof
	Kozlowski's message of "Thu, 24 Sep 2026 15:25:16 +0200")
References: <20260921-perso-ma35d1-upstream-clk-v2-0-209fd32a8b00@bootlin.com>
	<20260921-perso-ma35d1-upstream-clk-v2-1-209fd32a8b00@bootlin.com>
	<20260924-bald-awesome-griffin-7d1d5b@quoll>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 25 Sep 2026 12:18:43 +0200
Message-ID: <87jyo9ljlo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Krzysztof,

>> Reported-by: Jacky Huang <ychuang570808@gmail.com>
>> Closes: https://lore.kernel.org/linux-clk/b8a8a65b-e302-4747-bc90-4920fc=
48795a@gmail.com/
>> Suggested-by: Jacky Huang <ychuang570808@gmail.com>
>> Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock co=
ntroller")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/clk/nuvoton/clk-ma35d1.c               | 2 ++
>>  include/dt-bindings/clock/nuvoton,ma35d1-clk.h | 4 +++-
>
> Please do not combine patches.

I thought splitting these changes would not make sense in this (=3D a fix)
case, but fine.

[...]

>> @@ -248,6 +248,8 @@
>>  #define ADC_GATE	233
>>  #define EADC_DIV	234
>>  #define EADC_GATE	235
>> -#define	CLK_MAX_IDX	236
>> +#define PCLK3_DIV4096	236
>> +#define PCLK4_DIV4096	237
>> +#define	CLK_MAX_IDX	238
>
> This cannot be updated. If it has to, then not a binding and should be
> first dropped from the bindings like we did for most of the platforms
> having similar issue.

When you say "This cannot be updated", do we agree that you mean
"CLK_MAX_IDX cannot be updated"?

I'm not sure I fully understand the reasoning behind, because the whole
point of defining this CLK_MAX_IDX value is to let drivers know the
number of clocks, so it must obviously follow the updates in this
file. I cannot just drop it, the driver does not work without it. If we
enlarge that number, what is the problem as long as we keep the other
numbers identical?

Maybe one way to fix that mess is to:
1- Add the 2 new values (238 and 239) + a new define:
   NUVOTON_MA35D1_MAX_IDX 240
   238 would then have two definitions for a short period of time.
2- Replace CLK_MAX_IDX by NUVOTON_MA35D1_MAX_IDX in the driver
3- Drop CLK_MAX_IDX in the bindings.
or
3bis- Keep CLK_MAX_IDX in the bindings, but add a comment stating that
      it is a stale definition in step 2. This solution looks horrible
      :-)

Let me know what is the best way forward here, the goal being to merge
the big fix that I do care about (currently PATCH 2/3). Fixing the
missing watchdog clock definition has been asked by Jacky in v1, but I
will drop this part and keep v1 if it turns out to be too much churn.

Thanks,
Miqu=C3=A8l
