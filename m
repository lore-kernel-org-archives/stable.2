Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FB3DB311
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371282; cv=none; b=ggJBzy8JzQIvatlDX6rOIonOhVV/ZuEwbsWDc+CZ0D5FWyF7P/X5CAptvyGwqJ8cN6Ei8c+tf4hxyxD2FhfkJj7owGnx0E1/8AWd5yc2reb+YjaFbsje0NultJ4etMqFjVx/eRxbdSPeNuDmDadL3TZRcox7NOLfhPAafV0jWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371282; c=relaxed/simple;
	bh=9C+hFacNwZLvnISMeK73Fc5lVhuaZky39s3GFGDIx7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSWPYuYXb+dVx3Ci6AT0H2TVcrStWui0wGmpvoLnxpXF/b2qzGS2qNuu8j1i/jfCz/v4j8O4G2erK3X7DBDDDrvJJiq5r49ZgDcc+JONdHD5YJOBrdPCKxWxutL2a0u9qabh2uCe0OSU3oCsBDfEN/4mVM3dY6kz7ArV5MJ+PF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvS0ok9z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvS0ok9z"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fecbb7000so949791f8f.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786371279; x=1786976079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=za0i0XUEXRkUjzBa8+DfiNoHd/qp+XXAbyHUlY7SpcA=;
        b=kvS0ok9zTtvZPoOxXFRQVhBF3j9DvKIBZYW78fHh721En+QqUtOQEaIaxW7z6MmDKT
         UVvMbVrRMTFBZv6cNNeLmi8kppHuaZ1rY111/d4vkFGbm1kfMjCA+98tK4bLyNeEcq06
         SHMeBoRLDWceT4bxVgk0nZ4hGq2+NbSRkbI0q3x/GzXN77YAfpsWAJLJwWK9hZn1b52C
         hK+YEDAnci1KWUGAxJ2mVZOPGIpTChihw3n5QSpVNGZTlLEUd17a2EvILxEPdURmRrwh
         n3fn2AEDnADWDmN5j7xjGhgxlTkq0aGp0Y5wXqvVoAzpDwNXsnyReEnMsYbZAlWZ1LSt
         6fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371279; x=1786976079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=za0i0XUEXRkUjzBa8+DfiNoHd/qp+XXAbyHUlY7SpcA=;
        b=qByZAheAcohDsBQTWy10etihzs2AuniVjtrYk8irXT1Q3jBDg9j9WzUJWto+n8gU+g
         jgv1O2tz/LtGCSt+9CXdMwDbrOg2E1/yQPBFr9LIlamYyZPQmjQJM7FevQ0RJ64BzFlB
         pv2hj4eCN++8gVa32Hl1IeUbjqBP6D8TDxNw23uw1zv7jB5J52ULcD4VsUQ32um/HBR9
         nUMRqCKUSh538RVZNRv3HJRodmi0jaz50IETaK/ShCAdRCrbW78hcdiOfFAJ/lrU6xyW
         A3uM+kasKQLepJDr3uSJSpnILi1Eg2BY771NJpcOOtPqEm7Sqr2sXxwLU3YObOqgNozZ
         lfLQ==
X-Gm-Message-State: AOJu0YzNS/Gx9DAf0PySLXrq65Off7DEs0oifQDNS4/dCw2oyJKVz3x0
	XKP2xhvh9tVgdBuQgJpPWCjqn5b/zbuAwVN0S+nDjIvnQDJT9f2WLo0Jqdhx00ne
X-Gm-Gg: AR+sD13+12HqMkiDcFT6eWu/OtMxYh7PGmm0kllerk5vaezpY9bVnFDijctjVkixDPx
	soc7GgfuMXEdncbp6MqIf+t6Vv2OrdGsd/IWH0NCri+kLOzeUtxHTBuOv6vvz25GDwHNovVITKS
	uTmkfBIyfN9j9JYt0DKZM7cvVPB8rbiqPdIqsT2P0/zYU8rIUQNcv8Y5XVkatpK9jyCnUw9NWRl
	WBwKbvGrYyosLSNk6a+ofxPg85ZzcVTg7rAw/1eTh/SS58IwDck0gV/vSE7TV7OKzynx1zL6tsY
	df9ucJMzC9XPewDiomy6F5MoqCF/4ErmPvzzvp3BfQOQ2C3Rx7deRtdN2FGCx+yXsdp9ujGUlO5
	HjEiakvhOktYmaFAsc1zgnIgJiNnDtT90yd7SXcp2COd5GUFBocJVGPiDJVjhSW5hvL+Gs+9I2D
	QMdwxQjdrHDCuscyNFoeQVmg0SvvyIfsTRivveHOCLgICxCeX3S+0UoizRMun8kTnG3APw
X-Received: by 2002:a05:6000:41ed:b0:47f:8d71:210a with SMTP id ffacd0b85a97d-48130ed871emr30408214f8f.15.1786371279186;
        Mon, 10 Aug 2026 07:14:39 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021509a5sm32680580f8f.16.2026.08.10.07.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:14:38 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	James Clark <james.clark@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
Date: Mon, 10 Aug 2026 16:14:37 +0200
Message-ID: <20260810141437.2805389-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please consider commit cac7e5054115 ("spi: spi-fsl-dspi: Avoid setup_accel
logic for DMA transfers") for 6.12.y. It is in mainline since v6.17 and
applies cleanly to 6.12.y.

It went in as a cleanup, so it carries neither a Fixes: tag nor a stable
tag, but on vf610 the logic it removes corrupts data in DMA mode, in two
ways:

1. For an odd number of bytes the accel logic packs into 16 bit frames and
   computes the word count as len / 2, so a 5 byte transfer puts 4 bytes in
   the first DMA transfer and leaves the last byte to a second one with
   different timing.

2. With SPI_LSB_FIRST the accel helpers byte swap through cpu_to_be16(),
   which combines with the hardware LSBFE bit and puts multi byte transfers
   on the wire in the wrong byte order.

Both are visible on a Colibri VF50 (vf610, DSPI in DMA mode), and both go
away with this commit, which is what we have been carrying locally against
6.12 to get correct transfers. Every stable tree older than 6.17 is
affected in the same way.

Thanks,
Mehmet
