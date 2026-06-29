Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A5D3F9F38
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725615; cv=none; b=nOyDrRCwHi730zKXGYbaWY+e8pNsdcZQo7EpAWmpBmQnTFf7n+BtRZR8NL95DRZSwE//qzsADtfJpjaVcA94mMlgrIgLPuQ5B03PmdI53j1F4K2WYyX8bVpwFSNcyYJwpoFyxcRoq8w9enA8kx14LlVLEMNw211+xxmNieqJsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725615; c=relaxed/simple;
	bh=/R88zq7r2VvYaiOH9CDJymccIC+wfi5JMSmk3Vidz8I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gfiu23veHJFeErKw3R3P0tr+ZS+N3c/isJgZS4ZXQ8egZnz2K2BT5s21YF1klmtn0jd3yZg847OdkFsfG6cPnPd9bdJwD32rQ4PeVTi11WtbNuwLuzYb9zlUi2lpRN6N1/1qREopoHa0iMlfsP06ZRqWj8QXNX2pVYXBqJBWJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=N53vB51q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="N53vB51q"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-474303f3c72so322814f8f.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 02:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782725610; x=1783330410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv3/bI7mQQBzw4o7vxFb5GrHgzhC/QfD51paBaJ+fHA=;
        b=N53vB51qKc6+02HN2GjHNwAPUdNAob0eLR3CX/pnY26gfvBDCN/SNjptmu0G/EWNYD
         ME6WPGoiag6l2zu8nrLfs/vZ0CS/rioTsyH1nsNP987YT1kgwf4XyBaFjkhkltMef9lr
         p8LFvRyyDsMZ0fSzg/efjKse0xvk5lDL1CLhtX7jSsQMwj0El8ktjaudoCc3sl2iL2YZ
         2124sWN1Dfln1yk1zwzXDJIb+/ynTHqZI5WMyPujgeju7qHAwkjCSXIZQsm/UdHaVWUd
         Dm+CMbfD56ENROT82VZ7zktHpiPR528fGfsMDnFi1idGvKq2sg3gK7QHaRJtw3+o4bHs
         ToSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782725610; x=1783330410;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vv3/bI7mQQBzw4o7vxFb5GrHgzhC/QfD51paBaJ+fHA=;
        b=oBoMhIopoG3mcn2eESsyH6B+eBLZDlJC9OHPZinsU/Gb6/LHy3uwzRuo6f2knE30wz
         x6MyFVoaIW36BI8i7YkGW/OXDG78nMkRYs+3U7p9xqrBsZwGWDUy1FC/RhF5B2c0sCYI
         1gjTVgXxoqbE7xuDq/4fOzaPvGVZixFvBfqzStWiIGPKJCHq89iTQJkfS1pxem4/l9Rd
         MCturLuz4NotaoIJHY/KIoTtfVXnPNc3desnbyqnosBqVZbQPFB0UiJWRvFYf0KsWD3Y
         NGrxelZDHdSZpT/ysP7VBsv8KHhYvcoPFeOQXZ0uAMcUFkcjYctirxmFkmYB7Vdz515R
         /KMw==
X-Forwarded-Encrypted: i=1; AHgh+RqyPjp1pDco2+Bz+JM9qUhIjKBUYyFKWihpVkPA0948s9odXXKlNV/gQdq0S0F26YHK3BJf6rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpWUf14e93BVrkYstF7UAu9dds9r0c41240Tfyq2Er9vD18b3
	K/P2OG7psgGpcR6I/WM/cVS+mS9VCntO8mBKieOnGvoEZ1tDpc0h0z1X1QUivJcasWI=
X-Gm-Gg: AfdE7ckDWGi/Sf3EHPtGQQdYvsEEQgYxEjkoVYJQwcAoQqiD2TSZugHBqfJgzXeYF3W
	9Z6PCYuXN/gP1yF6+m5uODyOo9NjRSQ++DM/3h15BD0cy50UW5gWbsNYdCzDnDJuuTJ4qunsGoh
	TRJ5gjxlWDQeR+KU+SR+MWanN9x6Z0+GkEwLGuSaXrjHQb7DL4A5S+nxQj/NVsFcBxBabsiFx58
	AEZ2hdCRe3mGdkX/W20i3tQljvpmal3wxbi9ygDH6tJiVQY+I/1ygJZxWWZkaV/Oh4A90zxNSEN
	K+h19e51DS1xL/9LeFOcqzeCSxz9dqyjS3carxbHFW3oTMzK9Ldly9RT/oc9+hAmqPzXr2nvnE9
	JLpjmAJ7H1K7Wr8snY675GQKJq20bOlJmeIM+b4+dmllh/53A6LshJs/8o/dLZn2QZqpNwgB9Jm
	QlmCjej2ZH1l4=
X-Received: by 2002:a05:6000:46c7:b0:46e:5c5d:b2cc with SMTP id ffacd0b85a97d-46e5c5db779mr19780582f8f.23.1782725609875;
        Mon, 29 Jun 2026 02:33:29 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1d21:f5d5:2d3c:23a7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46cf775a4f0sm39251229f8f.17.2026.06.29.02.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:33:29 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: linux-amlogic@lists.infradead.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, bmasney@redhat.com, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Christian Hewitt <christianshewitt@gmail.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260623201956.1324992-1-martin.blumenstingl@googlemail.com>
References: <20260623201956.1324992-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2] clk: meson: align gxbb_32k_clk_sel number of
 parents with actual count
Message-Id: <178272560746.2490611.124390800107278004.b4-ty@b4>
Date: Mon, 29 Jun 2026 11:33:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

Applied to clk-meson (clk-meson-next), thanks!

[1/1] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
      https://github.com/BayLibre/clk-meson/commit/628b6fee9fca

Best regards,
--
Jerome

