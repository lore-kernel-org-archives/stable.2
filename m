Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268106;
	b=Lzy+HASaW34Vg/PPlFnXgndgt/8Cx+MhgmhCZIzuVphxNX9mlUe1/l1to5TtnEN26o53
	 WLAAJpp4ByueyDYacBOHhFQhL234nzkCtvmsLa93dcB9LhXVHmCZEodNbpoWr8fmDwV/I
	 n8CXeygIGW0z/+juTjeTMQH9cHglhWV9+JxxddDEcJjL1fFvjcbA77tebJQ96f3skTLZF
	 SkOZsUoM7x7/1en7kYC5wb+2g5/UhVGdumoOiU0BB+ofRjxZAfdfPBroGus+76zwmL8An
	 haVtZY2zjADHWFwkrhgpVXCmKPxF05FXm5Zi4WeCHfB6OibrHhjisccqmXURVVZzoqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=mgC3aFnQzEkUSqr0EdV9/pvy4kdF1e+4cJ+OWTfkigE=;
	b=3D9S3/yxmiBUgDDLKPR0EGbUAKb5Tf4Whikc7bWjYCTXmkVuXI/baWbu7XLnfQ5dx9zB
	 /5g3Vl/k98750hiuWyCCfKfFsemo685LKnL00Bj1fLCaijLsUr+Vth5dN152po+nwofF0
	 yVFr9pV2K171ZSKH+nR8R29c28six9beMGy7cjpJACMhMH5wnCbJoJbDbxyO8R7IZYfGi
	 nQn6HxjiJfS9sbk3FeDX2fpdPyWUG5ry40u31cY3Dj50zlfXIy3Sg377gqwNWcFgFgFE+
	 hqYLYU8dGcHYy7PNnU1Qk/U7ccn2FOH6osEbQ4EM6eBlNTh1gt4YsKj12tJzLzGpnKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JCV1Ttpn;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE9606A33D
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 23:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CDE9606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JCV1Ttpn
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso928516a91.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 15:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794268105; x=1794872905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mgC3aFnQzEkUSqr0EdV9/pvy4kdF1e+4cJ+OWTfkigE=;
        b=JCV1TtpntEO2y+R3SwQjg0sprnLUZgcAIH+abSygcDUpyFJxTFDalHfw8MGnB9a0y5
         TRXJVvZZJLFxh3BwOs0WsTv53xhKY6lbuiT/Dc6u8M6mpIfPFHQ99/tpbqEjKR5bBtal
         UA/UzkXT3DyhoY0d+QxQ/GwFUvDMIthYPWvHv0PQopFgPe2HfzQXHo3rLg9kl27EoGi3
         EtqsUruCtPOXI4/gPYj+rW05dH2AYvQD666F6EXjBbXK7RPE795oRQ/e7D7ADvN+b2cW
         KDZXGaNiwpR7X0EEBRaIrGYDsR21J6VSiRz1J0r3ONfd1VxnPmuNRSkDefmnCUD9I5jG
         tcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268105; x=1794872905;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mgC3aFnQzEkUSqr0EdV9/pvy4kdF1e+4cJ+OWTfkigE=;
        b=HOSz9M8lu4qlRWqnpaXkLh1QYtPOlXX+dM0bz9KFuGkTWaOnJF9/WevalmCyjadAng
         cb7vZy8ZKY9GLbZTuEKO9oTmTTPXqZiCaJyGWuNJUjJRl1PwefP1yyV8YR8EAR5gMlph
         4pbqkCm1zciXtfLL1HIhIvBHvwPdFwR5DDv8UC9eZ5QC1TiQARDSu1sPaYWYzk/+zthl
         2YbTasGt31Zp5vzmmGCH8hEXJx1JQTEKM6BD5Aq9wMr1FkqX4i0ZYjHRU3rHajj8RCPC
         34u5bH4mFZk5JlVQsxqgn4zvpO3ycdwVhQgKkLL8YX2Bx8La9cyjTamAbJRrSapxd8zI
         srrA==
X-Forwarded-Encrypted: i=1; AL+hErF8W+49ueosDumxPvShMb2PvY1WREihyHobW2kOLnuqa+2w2F0Ya9eTA4swM3Lu5e6ZYpq+Ufg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rklH4dml/if9SfjAbb4yFsaUQAtTxKT6dlRgwQWrbOa87FZaF
	jl70WCHlePpa+g43bpiDrZJCaWlSqxKXEaG2yOcjpOFqjZNoIxt1ZmUyCM6IVdccAk8=
X-Gm-Gg: AYBFou3B9XrUSvTd7p/cwyi+vsb2jyf21S58zQy9RWMhIx3gvoxOd4Mn/VpklCiOv9E
	MUnRx4zwTh8oB2XrYMBZhz58WbAXBNAfXPk1+6n0NKvFf5rQ/bp80ZaAkmR7bQtO2OSwnrd+BiX
	BWO6LEnw7d4GEcojP+5DoIoSIUJx4nmL1u2DcRCk3f44aQbHUE/Om1iQ2IjIjUxTouZbdNLQoRr
	3PkTJJSedPmGV6MSQfhmv345302nYDI4D4wg0eGgzrvl4k62xuPpE/QZIXTXYsozyvEhYV0tFav
	UzQeFFe0PRrrScQsOVHshJYk/vXHdQ3q29H1dve3Edch81c8uFesEBfKCpAEWecYw1Fn6JR5zV6
	YU/WqK8qaLLi2Kut2vOoIAkW7jJ2Hgn1MxfzlD7JZFP+TRlzHHUXhchPDPu2DxzNWm2NsyCHF5V
	rMs2PCNDYjkAcCZ6a+zkcyTGwlY7lmsY5iXernBzEq/hUZlymgKN0IltrqHeLKs82dHyaGs9AFW
	jvR6wJCsetqAJu2oiw7gnYxyHtxEUjGjZ9EhExvo1KsyuTXbdXFqEVbudHECkfxZOkQ+cDJDciG
	3wtIVOW3wfrteRv0uG1uDsX/Gg==
X-Received: by 2002:a17:90b:3844:b0:3a7:a3c8:8f4a with SMTP id 98e67ed59e1d1-3b16797724fmr660791a91.18.1794268105529;
        Mon, 09 Nov 2026 15:48:25 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b16771705asm1371571a91.12.2026.11.09.15.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:48:25 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Matthias Schiffer <matthias.schiffer@tq-group.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org
In-Reply-To: <20261103-v7-3-topic-am335lpm-ti-sysc-v1-1-1b9a23b4a7c1@baylibre.com>
References: <20261103-v7-3-topic-am335lpm-ti-sysc-v1-1-1b9a23b4a7c1@baylibre.com>
Subject: Re: [PATCH] bus: ti-sysc: Don't reserve the system timers on
 AM33xx
Message-Id: <179426810432.2265990.13205445943569497614.b4-ty@b4>
Date: Mon, 09 Nov 2026 15:48:24 -0800
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


On Tue, 03 Nov 2026 14:24:03 +0100, Markus Schneider-Pargmann (TI) wrote:
> Commit
>     3f6178392050 ("ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx")
> introduced handling of am33 SoC timers that are already active as
> reserved. During probe this means the clocks are enabled and a reference
> is kept.
> 
> On AM33xx deep sleep is entered by the PM coprocessor which
> requires the PER power domain to be idle. The system timer driver
> disables the clock during suspend but the additional reference held by
> ti-sysc leads to the PER power domain not being idle:
> 
> [...]

Applied, thanks!

[1/1] bus: ti-sysc: Don't reserve the system timers on AM33xx
      commit: 196abf4dabe28fe7732732d0c79b84bf30994cee

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

