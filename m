Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670521;
	b=0H6uPb4PGXwGqVSkRAV1PKVIot9HBTwlhRJ7VNqDAVdOZvstpd2F8U9U593y73uXGH3T
	 Yo3YCvSFa+6HPjyal1xYqOV8rLRsUXExcys21cEEtU8HLHJr5VDJoUNznOr92rpl45rZz
	 TGixnOyIxyqFESVb2pkoKASRF5Ls6dsg0T2x/kRTk81f4OLXmN8Jnl6Iq+IUSjCZMXRwQ
	 pJ3rELd84gWkj1Qn9/2cHU1E5C3SBgHqlzR6d8Kkg55b20Ehk5mTopM+vWa39ebSfpSU+
	 i0ArWPyoS6egbLC0w+MwAt5i6gyIAZUQNLkjeKFJ1QZ7vwSvPcW+UW/QTSRJkb6ZjnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=onk+iKTNJvSLjSgmayiHFki7AAkKSNYYZ+ceWP4cnXQ=;
	b=CnfK3mNTdTk0Nrysgd1Fpi9sPELVXZMJvBHF+MljPAmnqAYPqBMWA7onIRgCkNMzr+M8
	 I8L+CbW8rxvVEH4mQpc+CTxdlQpVacYYdBEG4LtoomETha5HPJnaOBUQtrARnNKOijD4L
	 rMtwhZhvfWpFYnu6KVCMEszRX/Xpjotm2lkI6KyCvppHo8hfwIYAJpZqXtAo+D24JrWl6
	 JnKLx+CrvlQhC30RbjaPrp6nawgvn3HM38w/T6v1DU0qzTXinCKXb8oSXvzzDhzTztnsA
	 P8RTQUi+jNhdr0vK6htE84aNlaTxVsvhtLD6TQikd9XC6jH/1IDJgv8dspzv93BGEGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f8PbKIi1;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73D606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC73D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f8PbKIi1
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so2924778a12.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670520; x=1796275320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=onk+iKTNJvSLjSgmayiHFki7AAkKSNYYZ+ceWP4cnXQ=;
        b=f8PbKIi1CS5x5lIZiSjkTRACKg5FurJS/mPBBYSYZaIX8dTrczQ7LJ2qu+6LiGIh4p
         Xl/G/MeG05PpIydrx1aIFbqSuMO3ETiogNEdPKAbORlFhoV81bYdgdpjt4BVonHiBPNo
         WoavpEqaog7RTBG5jiqeCynsSXT0+HU7Yh/mWECo5NH88B+WvDpqnf+dHwVDLgUYaK9u
         BPQEz2GeMIS2CuM4jjRK8N6BxA26UbwU6kyO32ON8uhKbKQ7metU9ozuoyMBSzEmhhzU
         zFIfezvZnZW1Ek6PuUhwSY2CFoCE50Zz4XUNvqc3TX+QUYd6PKcV8TZi19oqrICNMLm4
         17lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670520; x=1796275320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onk+iKTNJvSLjSgmayiHFki7AAkKSNYYZ+ceWP4cnXQ=;
        b=PnDRpbyt4FhRXSmgaOoAAqFjknqDJlRgqx7/Mqn6C2NWgxFnBqwLRyQKaa8v1R72vd
         cWW/XbTdBR/DvmuEXlLAiwzXnIORDp/UfeuG49E7cjYf3b41l8l6DSMzzkZx6G9l9NeZ
         5ddLWoTXrrhG6OuiIND9fx/N6FpP6PtflB/uJSFs6OcLegkFmiFHJzmZTiNhRHKaThOY
         ovSCxrb6waCwSD6Ydf4pXJ6+H1Zs3dRD1HNwc4+y5esHprRjgPiwCt3dSpYFTZ8YFslH
         BtK2qnLuzRhcCSoSGhoYJFOyvAntPK5+C04oDq1NqZzAKYSxTGusNqX1DCotN9a8WC60
         iDxg==
X-Forwarded-Encrypted: i=1; AL+hErHiLz2g+LgnTp7DahbFkuXymVU3yqwg7OZkYsYRerw1V7htUSuwJ366TTrFix46/fcdl6F1bR0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9F2aN0h6ByLIUx7xxxZoPWaJRENM1UYMaQ7JUSnpSHegBSFMy0
	zI7JBAojaP2lNdX2Ha2W5nX+l+ELTMlieKF12d9dRYsC95PffKhUpmNzIXY9D4U=
X-Gm-Gg: AZFdTZcf2fx+lgraqdqlRpJtpUDH63lqBkW6YoTrby/K8pwboyjKU0qnPcL6Nna4nO3
	1G5Q4M15EvUc5+n//80b2JwMa7h9VXPGuSenPJcT9vcCaA0nI+J/cwq5gVgvW7I7QRJgqrf12QP
	fSSswlXdpTMOa+wkdt3iCdyeiKjpfX0yv7iwpHyEBbSrEAHwG4Pe7w5rLtT0coPW7C71Kf8ZumW
	NjlFfW7ICqE2fZGj2+FXQrQj3nP7yLXMW4+5+BlCBm9oXon4raGs2l+SFOmcC5Io2d5cQ9iuQgI
	a/jyHr/JEQs0LGYmK7u21sjiT6Qn6BVjdFZN/rZ+qtCwClIJovYRN9xHz4OZJQgc24Tpsw4BqF1
	D5QlBd+3uB7DtTt/lFtZY0Jkp23de7IrbiRqkevIMgsra/B94bgUeJPD+9wv/gPCUDWYDbHeWLy
	gsZ4ogQtJjWJ4J3f7xTmKGUaPs8M3r+EslQfbEAC6E0Z/MzxKsbS+cDJY7nguciTw+V+GNIZbo2
	9+wXFwpLGzWShah+VvJCQpqmy7G9nNI3HZZ5qDcDqvyhOxaBacCl9aJ1mzfDBDmb7p7W3LnC1+m
	vmK8caZcs+QWGuVxuTrChUj0pit/CZ0bcFW9XYhpxJGORJa7FieGvV4qp0CA8fe0K0sKA++rKVn
	V9Ufb8OBEQAp/
X-Received: by 2002:a17:90b:2f8f:b0:3b0:9bfa:72b1 with SMTP id 98e67ed59e1d1-3b41c942d13mr19705625a91.49.1795670520219;
        Wed, 25 Nov 2026 21:22:00 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm33748176a91.15.2026.11.25.21.21.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 21:21:59 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: coda: Release firmware if code buffer allocation fails
Date: Thu, 26 Nov 2026 13:21:54 +0800
Message-ID: <rc-b1-20261126-vc-161-779570fc1703@gmail.com>
X-Mailer: git-send-email 2.50.1
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

coda_fw_callback() owns the firmware passed to it by
request_firmware_nowait(). It normally releases the firmware after copying
it into the BIT processor's code buffer. If allocating that buffer fails,
the callback jumps to put_pm and skips release_firmware(), leaking the
firmware and its associated resources.

Release the firmware before jumping to put_pm, which drops the runtime PM
reference taken in coda_probe().

An AI coding assistant helped identify the leak during review of static
analysis results and helped draft the fix and commit message.

Fixes: 186b250a0725 ("[media] media: coda: Add driver for Coda video codec")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64 coda-common.o with GCC 14.2 and W=1,
CONFIG_COMPILE_TEST=y, CONFIG_ARCH_MXC=y and CONFIG_VIDEO_CODA=m.
The baseline and patched object builds both produced 0 warnings.
No hardware or runtime test was performed.
The path needs the coherent DMA allocation of the code buffer to fail in the async firmware callback (OOM or fault injection).

 drivers/media/platform/chips-media/coda/coda-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/coda/coda-common.c b/drivers/media/platform/chips-media/coda/coda-common.c
index 3fe33c4..ca8f953 100644
--- a/drivers/media/platform/chips-media/coda/coda-common.c
+++ b/drivers/media/platform/chips-media/coda/coda-common.c
@@ -3004,8 +3004,10 @@ static void coda_fw_callback(const struct firmware *fw, void *context)
 	/* allocate auxiliary per-device code buffer for the BIT processor */
 	ret = coda_alloc_aux_buf(dev, &dev->codebuf, fw->size, "codebuf",
 				 dev->debugfs_root);
-	if (ret < 0)
+	if (ret < 0) {
+		release_firmware(fw);
 		goto put_pm;
+	}
 
 	coda_copy_firmware(dev, fw->data, fw->size);
 	release_firmware(fw);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
