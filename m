Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312693;
	b=YAIqVVuVmQQQmJHwhKmq8jv6cal6aZh7h8VVQM2HxOpe71FFELD7XICxqcWQtItuPKSn
	 DJlPTLphBjgdvGYjejJOewZfdbVfeXHscW2zCvIhtvyIO8hE1umpxGJGMkTPxyBDFsPZa
	 JhVe+D+I3+U+w+IDpy6G1G3cvoz6/8rtQobQIsFhp49jH1aggLwIVZQq2RcWvdE643kv/
	 67vb9IGMFpX1DqofQj/VfxokW8CqgettIkvVmFeELSRU14ZOyA+8cRkMJoY/uYxrZSYoa
	 LiD8avUQ3jCUFafjpBaXBRyAiEqOCV+ycz2Ax+bdgyJgVzlp9Nhb3bFxd+9C5khvEyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jJ1rPix6G8cC+kqkIZroHB0ZW7atIcOYmK51fZjLgO8=;
	b=v3/IVMzwyDydJmwHUvCTwvHxgLhvEvs8VibOoG/5eVOLcEkqTj3xzAUSFZuNyy/dfCB6
	 HW5cgFKp9msmwQcq5fWE7FUbXywO4yXhwZMPcd3lJeCJW/ccGRXBDYgPAleoITB3zAuH/
	 U3teA3hdx36CLLXq8TJvrGp/5sQOSV5GMnDWpKOvOTT/sGpjsa/KaClAtYybsD5eOu6uw
	 /+YcqacD/z9Gi514lBcEygj+pcn1f0xayddUz6AXCXN6pPa3klSw1rmKMlXhGxukYsavQ
	 uMvfGR2JkR0MT1ELqsB6tOqO/aK8PjMuMmy3axio5Fy5KSEMoAbuvWPcQw9Pe63/Bjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdzMrV2k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76AC606A507
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdzMrV2k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185821F0089F;
	Tue, 10 Nov 2026 12:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312692;
	bh=jJ1rPix6G8cC+kqkIZroHB0ZW7atIcOYmK51fZjLgO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GdzMrV2kRCxJvJ3TZtAbg2IO8tHAB6oNHb+9LGFn4DRJoukhhRmoQQErSUv2G8+rI
	 /YF4bqHWa+XuozdFxz2n59lirl6LExjpO1IQWZfXLSrKlUmLNWmYO/oki7oXTFoorU
	 DGHa021swh82oFVD/tcJ7EQlsQ/OBwjKtOYkjoOB9rT1DVz+jw4aliBS2lVT4Fik6j
	 Wl2bCb7mjMujMb2w3e016dk6PpcZI8PNSa5QQzHbRPbjAXldTNvOg9nWZh6Od+NITy
	 qKBmt3otom20KUt6394hZL3StBlGe13NGupgtKV9zoCNkyzXarOUBMoltXEqgDA9m8
	 YAdcDwCfdnIAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Punnay Sharma <punnaysharma805@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] staging: media: av7110: fix sp8870 initialization failure state
Date: Tue, 10 Nov 2026 07:11:30 -0500
Message-ID: <20261110121056.971270-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061452-failed-5.10-30684fa98394@kernel.org>
References: <20261107061452-failed-5.10-30684fa98394@kernel.org>
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

From: Punnay Sharma <punnaysharma805@gmail.com>

[ Upstream commit 30684fa98394bc0eb4362282908612aab7d4dad9 ]

The SP8870 DVB frontend driver prematurely flags the device as
initialized at the very beginning of the sp8870_init() routine, prior
to requesting the firmware (dvb-fe-sp8870.fw) and executing the I2C
upload sequence.

If request_firmware() times out or sp8870_firmware_upload() encounters
an I2C bus error, the function aborts and returns -EIO. However,
because `state->initialised` is already set to 1, all subsequent
invocations of `fe->ops.init()` by the DVB core will immediately return
0 (success) without attempting to load the firmware again. This leaves
the demodulator microcontroller halted and the frontend permanently dead
until the module is forcibly reloaded.

Relocate the `state->initialised = 1` assignment to the end of
sp8870_init(), ensuring the flag is only set after the firmware is
successfully uploaded and the system controller is actually restarted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Punnay Sharma <punnaysharma805@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: Adjusted the patch for the driver's older location and surrounding source context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/sp8870.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/sp8870.c b/drivers/media/dvb-frontends/sp8870.c
index f68479e75e462..3e05ef983fafb 100644
--- a/drivers/media/dvb-frontends/sp8870.c
+++ b/drivers/media/dvb-frontends/sp8870.c
@@ -297,7 +297,6 @@ static int sp8870_init (struct dvb_frontend* fe)
 
 	sp8870_wake_up(state);
 	if (state->initialised) return 0;
-	state->initialised = 1;
 
 	dprintk ("%s\n", __func__);
 
@@ -336,6 +335,8 @@ static int sp8870_init (struct dvb_frontend* fe)
 	sp8870_writereg(state, 0x0D00, 0x010);
 	sp8870_writereg(state, 0x0D01, 0x000);
 
+	state->initialised = 1;
+
 	return 0;
 }
 
-- 
2.53.0

