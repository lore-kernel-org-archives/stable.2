Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C7393DFB
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782559337; cv=none; b=CLAyme4UAothNwf8rbVzCA170Mxw0QvED//1BoHKlfzYT/wJDQxF1ioF5+HfSbX8gMWebkXUWZsYiY+cib8pjRjofuPPD4WYSdKEjdTJjwYwz1Bl561n5n3JxukDbYGAJnRaawHSuNEPKYrVSfl4DuwfteF+gmvs+jME1yxwsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782559337; c=relaxed/simple;
	bh=ZT/PZtgzdYRy73XPl/aMR13wYjd5GdwxwhY+llB5HPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sN23WWMkiO2aOEH1NwHEuPnfpfNqH1a+eBUf9aJ7RLTJSf3D284tCMDtv4Y+swkAt0RuTYBKhXz9hkQxOQ3my1ILb7ZdtKFhwVb2ZLVHt+VKAVemihhRwBcE3gOjo5PkQc6sN2vm7XGhZYjiBZMN/+aWlfsofPCKCpST4nwXChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcQrRhMw; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcQrRhMw"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30c965eab27so2148330eec.0
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782559336; x=1783164136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMRgtKqlNRIjgH8R3D1T5Dz4r8PEuj4RA5dDt7dU0ek=;
        b=HcQrRhMwvSYam7mQCwcSzigvBaMw9j20dVZ/FuWSu6avhFjD6Iav0cXWor1ZqucbAQ
         6wGTDDSs9grIKwX/6b/9IRbabo6oiTEdvKq8KJiAPLtgxMG9FtCZnXF59AFAq3Ayd04/
         lMuydaIMWkV7gpjMSJLjJ1hwA68BtQbEfcDRWM7LpLtmNDPf1nlebr5TK0iiwOOrOi66
         kfzQcOdeWqUegxCfcKUXmu3eSOVqGFpdL/sjNmMqwRfgJhEnJIufu5c+MkDnZrWtwwvw
         O+rM5kNQk8zXylfVDrVvHy+bvz9jyfHBFcCPu7ECw5RhFNw7VydG7HQ0kDGTFA3V74zM
         Rv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782559336; x=1783164136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMRgtKqlNRIjgH8R3D1T5Dz4r8PEuj4RA5dDt7dU0ek=;
        b=bSqdzGZ09knT45TBLa3/CIXj4nGlhla3D0NhGp0dbuoKx+GgqLrCzRh44LbeoJytjm
         PZSJFfG2YBFdgdHcg8Y7okvqUifyz5z4KsG1wV1yoUOQqPvSbgeTn33xu9hdE3wdaICw
         T2pqWx0N+xGG3MtNTYzoqet/mATWiV9WDsgnnmKSjdkdTV3nCXhX12UuUOCz73sRWnPH
         d6MKW2GpSmaplHRlpfH7cipmcZQL+sJAbaCPhGAFx0Pbb3U2uWJ0yNZZXdFbPLLdzBz/
         cqFvSTEeEkwpkSh6cxctt4Yf9E44/Oqa4AknDMf7yzsoDNTlZ0x5POG76RmT23bjvN8M
         Tl/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqkuERMLLCG4Ox1MFGmuOLnm07GnTsq/p496IOWHfFyApgGGUQzM7YuIk8tbsXC3abgDsjVRd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9GJieztbCAYxIpACi+fyKCGZC0Yx2jVHGXTQPRC80lueUL1p
	tT8JbVWDbwiGAlqPF3DzQoS59nidCRymSST7rA6n8jKJ+mFlUZ9GxEtD
X-Gm-Gg: AfdE7cmizBg3+NzA4kvjV6EW7bG2lvZKJGLksByo/uQ1uRgHQIy37dQWAVhFyzJP26s
	GirudcHyY5+wSr4LovEXVIgYwsEi4WdH2ROEWbjg3VuAZTOZ/yTgYysJ/DCpmevmNx8S2pynFX7
	AMR3klb17FY+BpWvQl9izw9gBWTS00+BPbStM0skjRxdWJJ5LIU8NCX4eEg2wY9c5DLF9XgHoCF
	7ts/Pg57P08nNS/jiM/Dtf5/5Q5oqxRmm8XVB/wxk2d3syUDtcWlZAPG0w9tWJ/ILDgFR1bP1GB
	qWUxo0174IS7sTbH+YRnbOQhWB2urQn9QexPmrcqOQuWC1Cf8uywN8ldehrv/FxD37ZRoqo1e7K
	XauSKMuXjGamrP9azvH39Xouot9jBX4+NOapEI3EYWEQ47K502a28MfOhHJFUBnIEOk7i9HWTJc
	6NlCAlvSiFIG8N6/GiJgZlVhNVdNsRZTpYuOmFXVaf97s4CgcRO4y9qWFyWUz/3SuNtT+jWyhRf
	ItM
X-Received: by 2002:a05:7300:6dac:b0:30c:9f31:b631 with SMTP id 5a478bee46e88-30c9f31c2f3mr5761269eec.33.1782559335623;
        Sat, 27 Jun 2026 04:22:15 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([45.118.104.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c58831asm29719037eec.13.2026.06.27.04.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 04:22:14 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH] iio: adc: ad7779: Initialize completion before requesting IRQ
Date: Sat, 27 Jun 2026 11:22:05 +0000
Message-Id: <20260627112205.31409-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_completion() is called after devm_request_irq() in
ad7779_setup_trigger(). If the IRQ fires before init_completion()
runs, the completion is in an undefined state.

Move init_completion() before devm_request_irq() to ensure the
completion is ready before the IRQ handler can signal it.

Fixes: c9a3f8c7bfcb ("drivers: iio: adc: add support for ad777x family")
Cc: stable@vger.kernel.org
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/adc/ad7779.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 695cc79e78da..db8f5f4c6d6a 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -838,6 +838,8 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 	st->trig->ops = &ad7779_trigger_ops;
 
 	iio_trigger_set_drvdata(st->trig, st);
+	init_completion(&st->completion);
+
 
 	ret = devm_request_irq(dev, st->spi->irq, iio_trigger_generic_data_rdy_poll,
 			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,
@@ -852,8 +854,6 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 
 	indio_dev->trig = iio_trigger_get(st->trig);
 
-	init_completion(&st->completion);
-
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
 					      &ad7779_trigger_handler,
-- 
2.34.1

