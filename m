Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272114;
	b=uvky7kEY4UMsYUE6zSdY/KpQQUfnJBbMZc48/qKwACVgdlNFELTdxkn6Qjgl9w9fBwqK
	 eToHlLR7U7TcMymc4WuGfpPcWsTTUygA5k1a96c8I2RjSMzOAxCP5rt89TkPFwkqASkaK
	 /250r1P0EqAouKpmJWYIiiuNlTL0Midj9j+qvq1MR7LJ3ibct06Kt0Pfxzltq+H+mMRNB
	 4RRMQenlsPdb905fZK6JBLSYNB55ZPnIzoCZ7DQV8rN++wnrpra6HPddZUaqfx6gGp6KQ
	 f7wFwGjhGt/eu1oI5q1s6Z7jhcUQT6jencr+ANGqzOFxL7RTptN5i4WoTOiug994RMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H0tYkJYy3C880yk6BHBia02WiTzz3Y2QDCRFZ+JDpxw=;
	b=Nk751bDECfXTeXAUq28dmpg+eZvPE2PCVDrPD2gKPQJfZx7qlHeM+lF/GBEIkhzkg14W
	 fFq/3aYMAA4qAu0kxcnJY/RPAde9aFxP1qHlhVizt7SZO73sd5RjH2EOIRPtah2qcbPyn
	 5tSS8QYnX2NFgh2xJ03chAbQBjDG82ywsVxZu332buh9EkmaZNU+W9wI3gTJmfVgxT4M7
	 aLBNIjrVhxkKscYSusOwroyCFo46yZM7pDJYgBxqTSBfdxYgwPqIJRQMpE8ZosHPdVZEJ
	 ndQ/A4E4zxvxHLK6No+hFy4Xu+wYZOerDBM48DcZ+PB/HaUOBuVeyx70xqUAP6ZesIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vtMbs72i;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F92606A329
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F92606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vtMbs72i
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4677aad67bso226531266b.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272113; x=1793876913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H0tYkJYy3C880yk6BHBia02WiTzz3Y2QDCRFZ+JDpxw=;
        b=vtMbs72i5Bwdg+EQEg0LQ54+jb1t7DAQtNOEGkP82cMcmWhR72Yob+mezasr9+t7/4
         mw6CFywSWfKjify4A2dxToGllevETEqsU6CtEtZkw1viIo7kinb0f/b4YWwPCFIvN/XE
         Z4Th2VBIja6JR8q6bxYsuWRHUZi/wGDYy5Y/PitS/sraMLvF4CsrSgSOOHMTicJvDbh9
         QoU+ETHa3SxSeoXWtHIVYs5G7UpijQ9HuNkuqfLcvTudhPgS6Xwxe5PIKA0BfVpK8x3E
         HiMvV/sC8KnW8UYPJdOl0ZUS1ahob76GAtia8Y0ESQKSnZ9XL0dtikB7AEoB60LOqFwa
         nycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272113; x=1793876913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0tYkJYy3C880yk6BHBia02WiTzz3Y2QDCRFZ+JDpxw=;
        b=F/ot3KiWIZoNWtsRkem6Hx8VIDeRd0uPH/zLzHHM/yr20cYNff6fKFla1rApFUFneo
         H9dbWA3uAx094ikOs6Z+5E5BOg+rIlbzgbK3+kZ0fY13QuXnAX7ZreVEJSvNPAhCxnwQ
         ntzWfUggBY/fhip4tJJmZRl4d/+ZrIIqI4OTnzwegYez06lDgImho+4PP8J0r0XjiJSb
         put98BHB6zGDZi8/zt1ZqADSsRcINx/QsbdVyOcP9+bDIFtsV+mfOKvZnHkGKyo0MnXz
         LXFtbgsUaLJYzqWV0Ga/me/l30NOfUnY/Rt22tLkyG+u9WR99JZ8ubHDrnd6c2zhunFI
         2pzw==
X-Forwarded-Encrypted: i=1; AKwUvBx+hE0ZoK17s3duPqZT5EIN8RSY54Vw3AZrRr1afK9/9S8obmi6X9LaVNdRTnfD5o/bNxxZqzA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfddCKBWahReVYRqC3q6kCiw9W9CKZLMTHGO0IoJrp8NbVWWBC
	OEUeUAeBEBoOVLZBgk8ro7TYZfnnf/TexBNG8s4EWk7gyGrqV8ft8YY=
X-Gm-Gg: AYBFou318mFn1oPpMfwWSzTRBGS2PbEdExi7OBkZgpLdabuO4zx8Rl5BZUdGHHUohns
	LSD9Y/gu3+lk0Si5tP6LcKkJdNwwkcaPFLjaX55QC/sk0sm5VgCqDqpcgisfinT6Wb7++sE/HH+
	fCXCm+z3vWm+3wEb5hRRL8miPxqnqrPbUfqSOTidz1Sxxo3/M3CG20MKY9lfOFwYBsPMAx0CXJ9
	/197xAxV4k6STJy/JVxl+0onAuXiXyznyX21Da9O08wEtNIlaDGxxqDqScRCJywpV28QaOcsTVG
	DtftCdrnKKPSfTnRiis6L+fzSS6QfDetCSD/6jNe/rZD5GJt1v0zL7iumpSMR79FYZYGNXnS8Wl
	jxbtNmLRW10eJwmvSX2GFJc7Yjkvk6618/Y2PAxSZXeOtzD5pIH1bmdBi5Bp0halKvTjRaToYpt
	wHf1U0umAf1vDYzjRYorY3n3mry+OWxnC+vQZJvxjmdea7gBG54b9slOsZ3sA1kqd49Rdupttd6
	t9tOvE4K4ARImVzG0lQv9ncFbYD5ratWEUfWyKR7ExijmY3oA50ylpxbLOux3Ops8BqW/ekGA==
X-Received: by 2002:a17:907:72c3:b0:c31:e958:408c with SMTP id a640c23a62f3a-c49be046b2bmr424030766b.38.1793272112734;
        Thu, 29 Oct 2026 04:08:32 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm33716448f8f.54.2026.10.29.04.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:08:30 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/2] iio: validate ACPI return types in sensor drivers
Date: Thu, 29 Oct 2026 11:08:27 +0000
Message-ID: <20261029110829.1086835-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026142040.62383-1-tristmd@gmail.com>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Two IIO drivers access ACPI package members without type validation.
Use acpi_evaluate_object_typed() for the outer object and add inner
element type checks where needed.

Changes in v3:
- Fix alignment of acpi_evaluate_object_typed() continuation line to
  match the opening parenthesis, per Jonathan Cameron

Changes in v2:
- Switch from post-hoc type check to acpi_evaluate_object_typed()
- Replace kfree() with ACPI_FREE() for ACPI-allocated buffers

Tristan Madani (2):
  iio: light: cm32181: validate ACPI object type in
    cm32181_acpi_get_cpm()
  iio: imu: inv_mpu6050: validate ACPI object types in
    asus_acpi_get_sensor_info()

 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 7 +++++--
 drivers/iio/light/cm32181.c                | 5 +++--
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.47.3

