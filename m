Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92AA25A2DD
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783225658; cv=none; b=mGgvFeYsIzSXqcQCQz8R/ZhgfNsIEUkkieRTacQ336Bkwdds1qiDb7vxbaVRBIqwg6P1ViMlGN9jtSH1xUZAU9/8I98t4itOXSt8sQN37mM6hh/AjFLorfD4pCd2WuSmfrrwysEeDbuQB1j0NtTHF/GUbRhw853b2KZSInNIatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783225658; c=relaxed/simple;
	bh=xXbqEGBTHdI4gCh+pi+4bWPkKiEcKqIDR6p0WzuoYAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4ZUbvoz10kYtoowMi7D/S7jY6oWBwDhCBncn7zSMCTCCqjN7yiAWY/E2Kdhev2BSgNrP/BJYnC1+gWM0JsFPpnfQqxMqIoe7c935YLNT+uXoArm8XbwDbQzb0RGPKC4me7gG/ShkO3nwReu81xzEhvQ54imkNKh9MMbHI7kKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOzP8qP6; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOzP8qP6"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aebae2f310so1591399e87.3
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 21:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783225655; x=1783830455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJJ24iBX9cnCE8ZMUdPAOVzOCaT5jrfPS+x2jz5hwlw=;
        b=VOzP8qP6IVGH+UxEU0T1NumTvz2E71zhVGFur1hjxOA6zhk1Yjy0MQtOEbJKRUy2ch
         guIMOc2g6lOhjFXwyNoPYxBwxwnIsdKnDxJH38UHN48ogoDURjyJZ/FvL+LAaytdOt07
         7H3wWD79gPmMUtJzrXhps+gllr6pf+xtMdviDM3uhQtgRvHJCHCtYa6GQGlrGuGvp5IS
         u48F03esV8r5BfueU53p68pKjqS05x/fDqruWsE8mO0BQJXNveH/7VJumeSVZNTjthn9
         lAtHR4G61jXCvOXn1+wUesdMvzMGkV4oA/yop2AVCpVF1fXPtvHM2gXewYdbcfVjVSnG
         VyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783225655; x=1783830455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJJ24iBX9cnCE8ZMUdPAOVzOCaT5jrfPS+x2jz5hwlw=;
        b=Hli/PwB7Fn1KXsBZKVpmTuOyXaf5BQBvQdipu5dAflTVo9hmZ8ZB64l938NGVT+sZX
         GrEL003SuxrzXlyOxeyyIXOQUvRHgUQnqaW+0e4on2qpRsYxuYPX5N+uuqgZ+THYZ77m
         AHZTV/1D+i3dy8HL+8XLTMO3b/tBqmGuCA4SPGsbfU6JXl2HKeh6p3go22HVM46uy2gZ
         wATOHL2/VgHTit9rLosg+INglQa1jtwEw2PxV/b78PyegdczphU1DUj/a8ltmyP78b9K
         hRZlRh6DLNV6CUtAhoD3H8yoY88TuTZjorjMVshW/2ME+uXOxlCzwykZK180eQEcwRQ5
         ZwBw==
X-Forwarded-Encrypted: i=1; AHgh+RoZCCvI2wSVdXrpJRmJEKfAB0rKsrFkFhaYwUAji9980NHj6Ep0A9019s2+ezu57I3jeDr/IWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZxoFJxRYZgb46520WjvhYTWh7foXnzlHCYRw9UK/2KtgfqQS
	TMJ+Qkwlogq45fDU5FV6WNK/bs/bnzlQ0GyhkXHhPqZbf19x06hAg9MDb0pyfIPE
X-Gm-Gg: AfdE7cnqx/8Fo8fn4biTiLJW7N1kHhqRs/cVTis/soiQC/BjW+cGc2ZwBZgjyRuCDSO
	cPZJHPADY9J7xMQv2dwEyuJcRaoy3GGMIlMShzxvMnBAecDKUiu6S66+ymgFdTWbqhTrJim/rZr
	n7gm7scMoD7X5tWU3aw8L8fyP5uNaequbgWFlfjrbUkTjiOZGG9atdgS1M+89EtHSOHgbiX34Dk
	pnS0KdQbdzAu8DczNCb/+Yg8l0eaaehUrG3cuW5kpHUQsZTKSF4PoMYyh/pSlonstC7UO8x0LpF
	bWOZJuCCLCP1L4JF+C+NwoVvfzAE9VizgPqn+OdlUPYtnSoggWZi0/zpaeNkC8bkhNxTMOtS8aW
	7Xj4l+mqT61IULkLPtKayx4VXBkaPD5LofuMjMkWJWpuQwY0J8+WhH6iZQb3bzfykbEaGVHHmOE
	OVSBtuiqllv0nM+ywglFUbVDzPjLuaGLIAGXC3xFRisA==
X-Received: by 2002:a05:6512:3d87:b0:5ae:b7d4:7dda with SMTP id 2adb3069b0e04-5aed50b668bmr889740e87.32.1783225654553;
        Sat, 04 Jul 2026 21:27:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed1377068sm1798289e87.27.2026.07.04.21.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 21:27:32 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: accel: bmc150: free irq before teardown
Date: Sun,  5 Jul 2026 06:27:31 +0200
Message-Id: <20260705042731.388592-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bmc150_accel_core_probe() requests the interrupt with
devm_request_threaded_irq().  The managed IRQ is released only after the
driver remove callback has returned unless it is freed explicitly.

bmc150_accel_core_remove() currently unregisters the IIO device and
triggers, cleans up the triggered buffer, suspends the chip and disables
the regulators while the IRQ action is still registered.  A late
interrupt can therefore run the hard or threaded handler while the IIO
trigger state is being torn down or after the device has been put into
deep suspend.

Free the IRQ at the start of remove so that no handler is running while
the rest of the driver state and hardware resources are dismantled.

Fixes: 55637c38377a ("iio: bmc150: Split the driver into core and i2c")
Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 2398eb7e12cd..2adddc965650 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1766,6 +1766,9 @@ void bmc150_accel_core_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
+	if (data->irq > 0)
+		devm_free_irq(dev, data->irq, indio_dev);
+
 	iio_device_unregister(indio_dev);
 
 	pm_runtime_disable(dev);
-- 
2.39.5

