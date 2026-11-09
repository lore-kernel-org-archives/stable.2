Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268113;
	b=Z58WfxYYHoy2AR6ZuyQVLlSIPfxZd5oGc7LNTiyqFV2Y5Q1leybpaTKO71tBS7ljnLZ9
	 2vvhGqX0nMaHKkLYpsIkbSiWSYFBlX/m5U3J939uNR59NsiV3np5H9pUyngYex3jjda+7
	 Ary11DUZGK5DeoaA8yJm3Nc3tJkb23ia38s37eRVbUqiWFDjlcN4qxAPhy09g6dPbXUGg
	 G1/QcK2wWvYo0nmvnJ0dDXVI1LWnSXPm9tnZbImoUeYmxEdkrS98wYEtOZTNnuW7i3YKm
	 NwS3OixUyESCpd/+/UOH8+lUgFDninIkBvPdSp58YsYtGsWipjkX8sVPZBWue1S1rcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=6QvI65ANWFLjHGTYP+BpY9IO0Q+Q4tp1M4hrdUa1hfU=;
	b=T3uDHDM1Ox4ngNw4QXFbdOK8C3zIOA9/Cpxqj9sNr9Un6ScW6JqyeYh6/HcH3k4M8fmc
	 dsEshOEZYSooGoUt3bJWOd1PBzp+5WOL1vjmoFAvF8JifnZ5+gBsyg9G8LOHKRfDQflQt
	 UFExHBIGCG0FIrTtSQjfLHJDfLMsXWIXSoiMerGv9TCViig00WKe5lueQ3BijdYpV9S7/
	 a4wjn2qfgQLw909puPpZgSzQYeHHq9x+wHk6nKhYS9fLw8e89gwxqnFbgiua8W4q7xAmv
	 Dt2ozt9KAZgqM2Pn74sHCocMBSkrN2Cl7fJIfP9LkKnYN7GZdSMOYfcMZhzd5c/Ek1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IaJnxcRe;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A660A2625
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 23:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 754A660A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IaJnxcRe
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso745947a91.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 15:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794268108; x=1794872908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6QvI65ANWFLjHGTYP+BpY9IO0Q+Q4tp1M4hrdUa1hfU=;
        b=IaJnxcReFcjgbLmRyjeMXGhrxzGN74eb4PUsd7TeEF4qhGuPX54MQ1RvR3Y2zlSAcR
         Bqs3BrDRIVjRzaL7NOmAoXjdP+97pne+H6IRbI8gRC1uXqOynbhDXoZoDYRcorIcMklz
         07VcOB6zx7//NaAfc0sCO8UE53sSnRa/AJjxLQhEE6sTwMW2PZzJ6YsOVB2NuybiA6i1
         BPUdWXlnFMNFL3sDgXArYIDsPMBu5YK2QmPKRKnkGR1YN3YjmSlF7PoQSzZK7bNj6Vd1
         XDPczPdNIBJ2vjhNM7o5eI/8zwNvid8O8caSdNg8BLRvW0I81Od0l0iCYPd4Zzxbx5+6
         5uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268108; x=1794872908;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6QvI65ANWFLjHGTYP+BpY9IO0Q+Q4tp1M4hrdUa1hfU=;
        b=x7rgalxUJ9VBkUo6HfoJO9c/yFvKxTw2ogKpfBhbwlY0FCzSWMSlcOkTF9keQ9RxV7
         XJrs22Vh5eYA1txqfpLQ4r3pq8nI2kHSwcuGk4OrmyD2tL7QGYLJmytIAFYgrdoW6T2V
         WvcbIUI8BoFq+GTs1bHOaA7fRu7kRmbspGAUrDPw9BVfRHvJ0WJfaGlOkv6Cd+ruE2FE
         d6gDvUia0fPIMYEDi4Qeo8T4qFxaAVnW72+2jn/iMo6QxtQk+beKzN5biT0tdbDk1qXt
         JYyjaohEBCRjykzADut6CWrhYmEETpmd08s9lnmqjMN9DT2i/C/cvHvLfoUFw7e32UOR
         6zbw==
X-Gm-Message-State: APuU4Z/AQHAFS8z7cbNx45jd7gwQZBFPOOQxNQBz7sG1fbo38Ed/5eDN
	aNcJMwqR/jGrWitvetBcW6MckG/lwUSH2utGYAuzepU0Vm+axBDeZEpJJCXHKRbE0C2WSJVmm+F
	mRHGKp1U=
X-Gm-Gg: AYBFou3vbhkP5CWb3QwYSE2vw8ZisSPsAsAE7oycNPnf8tPRSECWO75gGtm+fkNyeEX
	tma+J+NpikCDRUc27w6An1APUDBxwlcdR9F4imk7lxJyJFiPXQBTEjxyq2MZrGMph2v+MlUcJEL
	tVMQKzelpzIEFeqb2OKTy2diRL+kHJ4GYMT46S9UtTXHVCAGxwAuwfkF6jOKfxqdmii8TCwQJAm
	KI+HWm94G6QeFDLVzW0hnUviig7nfFOOwtFYvrXFqkfxaHbliMVk58Nzef5cLlFTsYQUZOJ0fNM
	6UvWk36agWbcqgJTj9Fl0uD1ZACnSQM8BDMqi214A6OcxCWuRq+JQtWzmhKNXfQcgy9joCuBLTn
	nGk/bCDhPZj7o8HBNRTE4F+eQsusZHKk4Ys3H+MvZGJiKiogVc24UuzpyDYZwvclqVPzPaT/ErZ
	RCF6Cyfq0EGnGFJm5o12Vo29HOQasuhfrUdDhejIh0cwhQgVZOQAIr6vkVy48Uq7c2GSi54DIls
	dXXrhuHFq8M+fg+YO2nkubiQbc8pXcdoRY09sTsYwGAFQnTY42qz8m8N0Rq0N+iW4OpQtLf1q6w
	bKmXf2vyHs2wj1ayuo9ihFPF
X-Received: by 2002:a17:90b:1fc8:b0:3ac:9a5e:9ce9 with SMTP id 98e67ed59e1d1-3b166ca430cmr1173151a91.29.1794268107865;
        Mon, 09 Nov 2026 15:48:27 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b1676e2974sm1411179a91.9.2026.11.09.15.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:48:27 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mithil Bavishi <bavishimithil@gmail.com>, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20261106073219.59785-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261106073219.59785-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] ARM: dts: ti: omap: espresso-common: Fix magnetometer
 interrupts
Message-Id: <179426810659.2265990.750430446710445234.b4-ty@b4>
Date: Mon, 09 Nov 2026 15:48:26 -0800
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
X-Mailer: b4 0.16.0


On Fri, 06 Nov 2026 08:32:20 +0100, Krzysztof Kozlowski wrote:
> Interrupts property takes a number, not a phandle.  Passing the gpio
> controller phandle made most likely the interrupt as broken, which could
> affect magnetometer driver operation.

Applied, thanks!

[1/1] ARM: dts: ti: omap: espresso-common: Fix magnetometer interrupts
      commit: b76bf201e56a9c7df1a64bb9388b654cb6a168f8

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

