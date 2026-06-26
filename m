Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA331AF3B
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451090; cv=none; b=dQn9cHhZHNqdyVvmfpDwOw6DXS1tCW1GmjUmvVp3f/2B8xkW6nWBZ7IkMXT4fp1aYX+hMJ4Dzt8oZkOXYknJVqf9sLI6yVM/CevLbpr0IfVbbL4IAOH7CtDsMgr+gdrw4OlogZ3S86IwvE4hVSaJPHoIT4AqrUHirZ1DH2ychXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451090; c=relaxed/simple;
	bh=I6ywcvU0qgxYw4mz0/EU2EY3eWlSEgHBFxkPAYQzJuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azQrdEEOsVXVJXAIhZwk4cGlLUyQYmE3jRs7UiuQK9dzE2S/92h/510UsHchA4Ww7UsI0XMvlfeEyDdMymDjdF+ZvoJfcUTOzJ2sKMprAc0qI5gJANkKQQkhjOIuOeMHg/9p5DL85TTC2S0k5ySIuM/OJTlVbOhIx5FOwT2Rbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8DEIoNh; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8DEIoNh"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30ca1b4b278so268515eec.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 22:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451087; x=1783055887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cLX/dU3BOyjaBvtaeDIxgiaeXykFIfqTUE3z5v9c3w=;
        b=J8DEIoNhxzGKe9/2W0f6zlX2Y1PN59vqKRDBf1+doV2JvLuH9zYlgxuPkz6AyuKff/
         gLC2pUfcLXanfWXCwu5XMv1NPYy4xwg1Ad+/xVfAJqm7NjDYqIoJgTCX24Rbya/TTGaA
         C/aO8RPGJpjuV8elVwg2hqnCR2wNtKf4PRcHT8pyqOGTLqi1Z4hSKvHSprxfEAWsXoKb
         fkP4rOY88Jgjd5ZfL7Gc3EIkoBtIIBQO+9FECqKGCEJ22EHWZKWjQ3Q39jnSWqZgccPS
         Pa+V3QzTo3n4L4uY7rnbnhW3CueMR5DVoY2/izNLVD4XhxDBN477hdWAiwUZ3Csu0w5T
         Ua0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451087; x=1783055887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cLX/dU3BOyjaBvtaeDIxgiaeXykFIfqTUE3z5v9c3w=;
        b=RHPaFz4oYwH68ts6c9/Pgx7UrmoXmQYPfbhWsUwtwiiFq8aNDV9vXvypGKuHkbUMAX
         Itw8+NqURg9j4wsxg46sxD1+uTfwxXZ5HbH2qYOkIwfR8Lm6UlmR+8YszHwALvKhn8yL
         Q3yS/6W0TIRmj1w6i/bQYS9vWEwLL/fEt/ORq7eXrE8hoE/o2Qi2W4un/hJaPvJM0cQB
         WmV9/XtXezMyYB/jidIcxfn6LGJxYtBHUqOGA82zfC3ivlW4RoQ378ik2XynL04nTN3Y
         z6cRFsCH//G6+C4XCpRFCof9n2qHf9IbFlLnMc1Csl8n/9CoMf1CGkB9sx4oLPaZa6RI
         lLGw==
X-Forwarded-Encrypted: i=1; AHgh+RrcBnSTsNml65qlXkQsS62ANrIQIPf5sjMmmt+3MoGfYdHzFZmRc04KgvMla2fOzxmup++Ayus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf313yPj4+U4ab2cEKhdxHas47OYI+MQsdg1pFWXT50q6v5p/Q
	6sKOGWANBFMc92WFXYGmP4o/OmOsEWXTRgqDt0OqtamEtohwEDCvIF+V
X-Gm-Gg: AfdE7ckl232ic0E0U31BQPxyKWOyvpKfuGvPydU39SEbEedWph6b3XRehTOwtB4PoUi
	MVjX3Jmhl579roVNRIJeR65yI9f4l0L1JNakbx5q8E9LR1D//yLKTQfo/su3508PAHSLnA7iVTJ
	jAhAy8k2J/BwoKTetiMinKwDFvkv73SwyJaohUejFJdhQ0TOuKVOMIf0Wj9K0fSJalWzyuC1n6f
	lofooujrPwY5CHMoFD48F6zyvFoF/tZ5J7RbO1hHbTbALo4lZDLhQM87AVjBJvOSUKyAaeKocfv
	MBQFSu+uL7nYyUM0lmWoIQN7SHsok59sbPybIP6boFxsTd9jPEBO9gFOPaXuQjsXRDBYJ+hidQR
	J/vJxntORRwinPmPFYCSv0NIWctAWZCEzMtCDcsylfjya9LbNQB4AQ+FV45kEz4pZDLCISwOY0E
	fb4kJxI/4QjqF4t3fNkCPK77RIakxB6AV+ECoyFe/pGPX3hQs5b6Fc70FQCkX2Th4YZT9O2LTHg
	sJngnn0vhN5ygQ=
X-Received: by 2002:a05:693c:3945:b0:304:e566:e000 with SMTP id 5a478bee46e88-30c850a8f7cmr5878370eec.31.1782451086712;
        Thu, 25 Jun 2026 22:18:06 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:05 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 01/10] Input: synaptics-rmi4 - fix F55 transmitter electrode count typo
Date: Thu, 25 Jun 2026 22:17:50 -0700
Message-ID: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During F55 sensor detection, the transmitter (TX) electrode count was
incorrectly assigned the value of the receiver (RX) electrode count
due to copy-paste typos.

This incorrect value was then propagated to the driver data and used
by F54 to determine the diagnostics report size. On devices with more
RX than TX electrodes, this inflated the perceived TX count, leading
to incorrect report size calculations and potential out-of-bounds
buffer accesses.

Fix the typos by correctly assigning the TX electrode counts.

Fixes: 6adba43fd222 ("Input: synaptics-rmi4 - add support for F55 sensor tuning")
Fixes: c762cc68b6a1 ("Input: synaptics-rmi4 - propagate correct number of rx and tx electrodes to F54")
Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f55.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f55.c b/drivers/input/rmi4/rmi_f55.c
index 488adaca4dd0..a0877d32a914 100644
--- a/drivers/input/rmi4/rmi_f55.c
+++ b/drivers/input/rmi4/rmi_f55.c
@@ -54,10 +54,10 @@ static int rmi_f55_detect(struct rmi_function *fn)
 	f55->num_tx_electrodes = f55->qry[F55_NUM_TX_OFFSET];
 
 	f55->cfg_num_rx_electrodes = f55->num_rx_electrodes;
-	f55->cfg_num_tx_electrodes = f55->num_rx_electrodes;
+	f55->cfg_num_tx_electrodes = f55->num_tx_electrodes;
 
 	drv_data->num_rx_electrodes = f55->cfg_num_rx_electrodes;
-	drv_data->num_tx_electrodes = f55->cfg_num_rx_electrodes;
+	drv_data->num_tx_electrodes = f55->cfg_num_tx_electrodes;
 
 	if (f55->qry[F55_PHYS_CHAR_OFFSET] & F55_CAP_SENSOR_ASSIGN) {
 		int i, total;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

