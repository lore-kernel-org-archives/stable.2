Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015018;
	b=TggsgB+i6ASTKB1Sc7us7q6H5WJhD0uewpvVG3ClnNswTpoel7xRJLzzFhwJNRAfaKjh
	 Ng3Cw1Dp+6tAKkjYced+tKp5H/8JTC0Oo8JaTadO/Xpc3Z5CjBPSdNOmjTxu54dvhWq2v
	 1j+T6fTIvNRX/jsi6U3UHY0iRu/VaPfzhWhrLTX0RzAOAEn2Dmw0+VofgXHFggqdiA6oP
	 gIAsS4FnMwpNeKPvTiufAkTUUhR1pOaSG9FA1HmjCAnObYx1bkQIdRj8juC2t6WCep1/O
	 l4/h6nkJeCw2W1zuITyzMJ604iNKTD+8cK23+qAnSHAu2TiTTEvJgVyghASD+ED/R1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=rOY+wdV3n8VmzgrzAHcUOOBb9IyWYRHS3lQymwFtS30=;
	b=wLukCxufiBLdgxG66nUDHuWVbKvLslILxrsJS2aaTmIVZieA34RD4UvruVQ+pGhIIH+7
	 JLIniRUoncETwYfIkTwarOCiNpCOOk6I8ISHwJ8+NKvAXJnExhQdzqszVAa4NyY4VD30B
	 oIxWlBdFQmq2SbTES6eO4XdvqiyLhxZGv0InB676afSW4z0qXOBdkFWcCloPHwqImAeEf
	 imwkCM6RlZg5KVanPCqSXfXrXprHrJjyGjPh69kmxgVut1UYqIDPaDU8kgFsUsVs47d46
	 GzfEGM1WI3LxSHQJaK/imj3RprGXM1vKE21TkP8zJ1UOIYiZXmabxRbuOhXJMjNkNbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iEWjEnyL;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BC606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 989BC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iEWjEnyL
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-491971ac844so1091538f8f.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795015016; x=1795619816; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rOY+wdV3n8VmzgrzAHcUOOBb9IyWYRHS3lQymwFtS30=;
        b=iEWjEnyLaCvEhk5M1AC5NQQlDysiyvVk+m/XObmo5r4yFRVJsV74x/mhSkir4B7qMz
         KtA2S2cd1SPHmCasNEl3YXtyCltDHfHkQAUr4PM2xp4ys0o+luBMLN1PJAT04ec0CfEO
         J1ue4dlADD98xco42qsvWjY8TeUYJ91pJNlpG2HzLaUzHGgigZ7K7BJVsf/iRHcd3/ze
         1p2ldMgEy8WXbZamZrds69/CExGXM4jkrb8GBZFPllc+UCMfN/cuXZkZBwwee6elg9GH
         /8ejWlKpm3hSAazBTMqC5VZicJkOW+eBUWv6KXgh3TTCLik9m+6JsizSQzNiQapg+xCt
         6jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015016; x=1795619816;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOY+wdV3n8VmzgrzAHcUOOBb9IyWYRHS3lQymwFtS30=;
        b=oZyPOFMg8qr3FiR2ARGywTrSXKQfRg16sVW2MLjN4ai1LoqTdc3UTOYSNj9L7tJCj3
         nrDViFNTmGJgTPXCyxqyHRQm9y71cmrXA0C6BgmwCAk4ykBEzUECNalEy1h9KTranwmk
         +lQPOMpHaEiS6rEAPotldlWdDXLRISugeUxdmIhMEZ9tfhzNwG5zNmcAf5jz/M2JnGL8
         p2hY0+DVCdz1OUKmxjKYo/WEWnGiWWDk/ZvOGwdGnit1dXHqJ7QRKbTOhZ5+3faloNYs
         YJR7WZGZTkElZv2H13Rmg9grO1BE0DnW11xNE93/WgZAjrGi2dq84Hwa4KzoUBmUUyUG
         ciaQ==
X-Forwarded-Encrypted: i=1; AL+hErHw0GtS/lGSqk5ppnY+0WVqt0XvZhXzihvlkyvZZL5Ww4DNuV9ZJaOj7/0uJVvxaFPgcJPMckU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0i9Y0ysrYhf95ePzvcdEhaCjf4Im6MTKhJvJ3TXUQJkWkfwFD
	A2GSwVMNJdGgUxlTjC9Uh3v/s6XAJBV2u/vgg3llDI9jD0OXiezD+uP/rPFfrv+q4NY=
X-Gm-Gg: AZFdTZdqUb4cbo4WLYsRSNS1QQLxpW8pFo1Rt06XcwNkIduce10E4wyb+ppXtm7pevD
	D5RQ0nimtl87waxMYiUGsil69Sss+atnDDN8chgHzvO+DadGIwUGBqZ46WIjINJX2TCVAv1sUhA
	InV3c64hFyyy2GBVUgF1L5xBUhD8KwiptqjR3zYXxCC/zD1RR1klWS5XmcQU4Gmk0krX2AcCgwi
	tq3qSuprZuTX/ry3GPNFNcsQ2ljSTBDgItWzhLquD+OakDbN/kF0RlgLyhWEZ8r2qHgwfIz7H+G
	pkDIuKHvqJl8+vhFsjEZcCYscIdd+1P8Kkmg6A5SAn02PoTlxjJ0Q3MzMtC6HkTcHiuDcWp9Tpb
	QPICBo8ZTJ+348pCqkWnRlmq3GXZ4W628/1FOckcpIVIVhag6JtjOEsTBkT0JiMi/cp12gJqL/a
	wFHGwysKbw8Kput/nwK/TOrKhXab/FxJX8HDjdlh1vga62msMdeYjflHv0Bzb3BImBcVjJ9UGbd
	7O4pdRKVYAHzRaQiOG9QOfUL2vc6ONBmdqsOyInLvxLr69/onEiN5nIgwc5LsIbz3hO/ArdcUUp
	Yt+oj+Foc8SbYaQ51e5QqcVM8ZS9OKxjTJ84T8g7q/0IQ15N
X-Received: by 2002:a05:6000:22c5:b0:4a6:ed6f:7a6d with SMTP id ffacd0b85a97d-4a6ed6f7c2dmr4688498f8f.28.1795015015881;
        Wed, 18 Nov 2026 07:16:55 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a650d2f682sm5148396f8f.6.2026.11.18.07.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:16:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 00/10] clk: nuvoton: ma35d1: Fix mux parenting and
 peripheral clock rates
From: Jerome Brunet <jbrunet@baylibre.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 openbmc@lists.ozlabs.org, stable@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20261118-perso-ma35d1-upstream-clk-v11-0-bd1d1e060926@bootlin.com>
References: <20261118-perso-ma35d1-upstream-clk-v11-0-bd1d1e060926@bootlin.com>
Date: Wed, 18 Nov 2026 16:16:50 +0100
Message-Id: <179501501070.639563.9357303541273366380.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=Ze/lWMxenuMFFinRWmaSX0IcexmH1tvXM9t0DvMowcU=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFl/D6bpy/0tV5+lWL51RkjKPQXn58FtMoH+f5SuWOVVn
 Q0z+7iko5SFQYyLQVZMkaWGu1r8naTWl1nTdW7DzGFlAhnCwMUpABM5Z8bwP3716cfT9okus2OZ
 8K++LlbF6Pn25IUzVn3Zf0aba1HEyhhGhjdSSyMeLDnMVr/5vvLSWKM/unu682QdT776tVq3cnv
 vJwYA
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

> I am in possession of an MA35D1 NuMaker board. The SPI controller has
> been contributed, but at this stage it does not work with the current
> clock driver.
> 
> The clock controller registers its muxes with .fw_name parent data,
> which requires every internal clock name to be declared in the DT. As
> the DT does not declare them, all parent lookups fail: muxes end up
> registered as root clocks and most peripherals read a zero rate.
> 
> This conversion exposed a first issue with the WDT/WWDT parents which
> were actually missing in the clock driver. I am not using these clocks
> myself but it is worth fixing.
> 
> The second round of reviews raised another problem with the
> crystals. HXT and LXT are external crystal oscillators wired on the
> board, while HIRC and LIRC are on-chip RC oscillators. HXT was described
> whereas LXT was not. The series now also takes the two crystal inputs
> from the DT: they get documented in the bindings, described in the
> boards and looked up by the driver (with a fallback for backward
> compatibility).

Hi Miquel,

We've had to base clk-next on v7.4-rc2 because it carries a treewide change
around devm_kzalloc. This was triggering a lot of conflict in linux-next.

I did not look at your series yet but it does not apply cleanly on patch 3
(maybe others too) because of the same change. Would you mind rebasing on -rc2
or clk-next please ?

https://sashingci-clk.liltaz.com/builds/555/steps/3

-- 
Jerome

