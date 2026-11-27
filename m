Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790006;
	b=OzC3ImQqJAfaPaCzR0gL8NEUGOIjd9q7GUP+fs0yh25iQ5+tiRz7T80zsOAHZM6GOhmO
	 f7FJow/OX+awE4bbOl2857d/aMQg0jFK5+wqiT26s/dp53M5ru5SxBDBdXvlFNHG6pkeZ
	 ByY6G9L5IjQFFH1HCPvUi0tcVgAxMC+KHO11LNyqcAplx47ul6NR9weGP4CJKJQJ4xcvw
	 LnfdibQffnp9X2pC3D7TZi+Rpq/42g2Szln6A7S4N83Pntq69EXV/zOsd7iUXf1bkKlAd
	 HZUock4kDrNSAySrrY6nx49ZjF3TA9f7GFV7v7+aQchg0Qa5mNIH7xQZElXGmp9+EGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=4jk+eMtoNzyBPcbPSMP2jejnX5Q5wRK8gv8j2BTbshs=;
	b=e0k2Cl22nnMRtaLMkz7RBKTLgi+AsT8g12+WgRnf0sdVUSbnSa+F6516E8sFWNgrTHVo
	 AL+zCA1MQKqC+85sHbmvKaoEerT3ZtBcHz+cF2SVJj9zr4qpDc9Kc0Dd1ANJIXfWJIiUO
	 vn0RYlG1RT4Dr/DRS72X1pYB+aP4WE8HZ4OQfvaibx0sgti3/c8M8RU9+Bbo1RnmAO3cD
	 ADyBAw6p9LiZajPQNxWt3tFhBDHivd4OhOVFAjGmb2UxbKVW5e61rPqEr7kfu74KPDDAL
	 kYQOgPN88f6/D73FkzbhHLOKPvu90ohyozBT4yLVJ4VJqNm68e48hJgvviGyuh8XNbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Kh4yhHoy;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0236606A6BC
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0236606A6BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Kh4yhHoy
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6bb06dc1fd5so5854465a12.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795790004; x=1796394804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jk+eMtoNzyBPcbPSMP2jejnX5Q5wRK8gv8j2BTbshs=;
        b=Kh4yhHoyRLyamHP4c589eGt6mFYKg+T4DCFz2chTTM2iLS+5BJgzihuYm8dycaqj+I
         D+UKNRnLeHIZdIY/Y3uM0He11I7oK8XERH+Dd51NTF/1SOfYnGyaBxSQ2sgAauQrI3JJ
         zkqBx/uP/8Y/D2R735Kbyoa2uVQRT680ZyUSO6O/OoFkfSryNOU8TtTB1iSIeSuqdGsb
         WIw2Z3oRQJS2zsXHiwiQgEC3Dh9gGMUa+P3DS0GD9kfQZu3FTWYp18ijl0xwON/f85LU
         dKCDMPu7PDFm/gm7Xlal8NbeYYPaao0MhoOWVsFcssb0EU5O4EXz46Qp6dJys14hb/mQ
         kbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790004; x=1796394804;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4jk+eMtoNzyBPcbPSMP2jejnX5Q5wRK8gv8j2BTbshs=;
        b=guu8u0q0hD1shb28dx2OHArQsZ0Up3EfZnP+oJtTqmzeX7JqXfg1mxD/gGLGeHIx0X
         rmn9dhYU7WwKyeplFjUfc/ymQJzY82M/8CCsQPeEI5oacoDzqA8aLJ73+5eR4twn5RMg
         3hJmsyCS75J8/ROpWyQBEzNpbYfOT1CfnsHC2A+421ZXsUj5tG6J0u1RnxzXbMk/WQtD
         83/UGnRMeAXGHp+gjRUsMjNQr1KU1PcAmWJwGFtEUR9zUahwI6k+B22vM1xKAkWfYTmI
         0eHfTHzGHMbN6nOR2aOEKNo3+bsVvI9uNoBG6hNmnt0B7rW29KPoShmHGcM7ni0HLAqz
         JJJg==
X-Forwarded-Encrypted: i=1; AL+hErGFC6As7VTD/2PfhN3MDSFEW9Fx4nBYMy3fEDbKF+iXIaVZhB77GCLddwAMBaXf6pmtOwg+9cw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AXGkmZFqdvbFnBG6mU/eHmC2tEu+EoTaqclFzjRmx6ov3DNky
	pkYw2pX5E28YH1rlG0geqoDyK9By4W4hrZHvQKq3zzdgrlLQrQeMGuFIkMuuUfxAEmg=
X-Gm-Gg: AZFdTZfeo/hOgqKq20gPyZ96K0V2FibbxCimGBPjG/mlRMBDRbfiKq3Rps7Dk1Rjh/U
	sJUtzEM6u9GBScKGVPxDX52nQyQOoLkA5z2MGGxwiNd3zMzfVJHcih7+v5YE5jqFnvpfqtCGiN1
	KzbofYYJ6EpiVthTd0iGq4SrWNp4N8nZCB5aT02UmEp7wFswbHBcpZqi+6+WB0jpleniouk3TDc
	++9ejGVa5PMXTY6iLNMfzU/jQIa6cOFEqjzA4SGoLsHo71eZ/MW0Sx/voZtM69iWrVfdLNEElAQ
	TI1aUr8RqPi2rkQP879xX+J4Aq16y2O0HH/FHh7eOhR4Hmuqdi+O/oL3Peadsq9opwGQ1oqWkz9
	yeJmQGCrIBh02D58W1VMI7fPFHPGvnVM5bgaf31cqhszFrZXMVLcvDZfULzpKu6zD4p/4vQa66p
	tog2CPBGATBlkm2OdtfZt6eH0443nomOiINtkPNPmmSInsdR1q+ckcVxWpR4/xJ0hy9svtd9iMI
	hg4tsRD7Hpq8cjdpfRXEPTHtdDmilAabh16H7grldptahez1kcXr9kDQy1MzKQaccQVkPq4vScM
	O3r38Nt1nvh5Z9/hfVXvLol3oVivE5QkJ6/Uc/e01B4U/Dgp
X-Received: by 2002:aa7:c4d9:0:b0:6b5:9731:90fa with SMTP id 4fb4d7f45d1cf-6ba37cc0ad9mr13284812a12.6.1795790004077;
        Fri, 27 Nov 2026 06:33:24 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb9f8160ecsm72961a12.15.2026.11.27.06.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:33:23 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
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
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 openbmc@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261124-perso-ma35d1-upstream-clk-v13-0-c920f4a9f0ce@bootlin.com>
References: <20261124-perso-ma35d1-upstream-clk-v13-0-c920f4a9f0ce@bootlin.com>
Subject: Re: [PATCH v13 00/10] clk: nuvoton: ma35d1: Fix mux parenting and
 peripheral clock rates
Message-Id: <179578999837.3130490.1321256774164046797.b4-ty@b4>
Date: Fri, 27 Nov 2026 15:33:18 +0100
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=/kkh+STkW16bo61fnrALXUXLopXwJUn8icTeFUDyuzM=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNmcUzaJnLvllxStGv1dWD2t2zaPaXOLj2dHvMC8gu0yX
 moGSbc7SlkYxLgYZMUUWWq4q8XfSWp9mTVd5zbMHFYmkCEMXJwCMBGnfkaG06uzPxgxWazev9T8
 nBznBSb/J5mvX23n5H1avOdw6kn1AEaG219YnyTk+92QXLDoc8rr7wv2Lb6115HvlPH6mBXGqbP
 SmQE=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Applied to clk/linux.git (clk-nuvoton), thanks!

[01/10] dt-bindings: clock: ma35d1: Mark HXT and LXT legacy
        https://git.kernel.org/clk/linux/c/5cb3fcb3a35e
[02/10] clk: nuvoton: ma35d1: Use clk_hw pointers as mux parents
        https://git.kernel.org/clk/linux/c/4df94650b44a
[03/10] clk: nuvoton: ma35d1: Avoid possible error pointer dereferencing
        https://git.kernel.org/clk/linux/c/88997515be60
[04/10] clk: nuvoton: ma35d1: Retrieve HXT/LXT from DT when possible
        https://git.kernel.org/clk/linux/c/4154c8b3d3bc
[05/10] clk: nuvoton: ma35d1: Reparent the gates correctly
        https://git.kernel.org/clk/linux/c/1c2214475dce
[06/10] clk: nuvoton: ma35d1: Use device managed helpers for fixed rate clocks
        https://git.kernel.org/clk/linux/c/c31aa10b3ca6
[07/10] clk: Create devm_clk_hw_register_fixed_rate_parent_hw()
        https://git.kernel.org/clk/linux/c/5093f6f2543f
[08/10] clk: nuvoton: ma35d1: Reparent SYSPLL correctly
        https://git.kernel.org/clk/linux/c/107caca779a5
[09/10] clk: nuvoton: ma35d1: Fix CCAP muxes bus width
        https://git.kernel.org/clk/linux/c/6f6ef44a950a
[10/10] MAINTAINERS: Add myself as Nuvoton MA35D1 clock controller maintainer
        https://git.kernel.org/clk/linux/c/350f54ff5b92

Best regards,
--
Jerome

