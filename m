Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311279;
	b=0+6BnZgCV94a9Mtm3DH0vMq24+smou/B1mjzykBvgqr5+WFSLTVZmoVZL6uqLaK91st3
	 ckFlMt29eM+aAc1dVNI27uau4iqt6+7ciUwy7WUUKIPaaElumJjagD+hW+1V6vt0UaRtW
	 FI99PrqKVMglbbFmN5kUI/hwQcCJNZH3o2iWjrANo9jG7Pe9/SgGRPyEs4UYBpBSe5qPi
	 KtzC44goyM0gsSizpJdLELWlpcz8MpbI/WmFuSfOpeZGN4Ph1+IuUhPDpe2Az25ytdPj5
	 2mDoULjs8CwEwbjWeanEZpL8cr0tteZoWOsXhVE0aUrs5mAv2Qgt9VI9OiewGZcFTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311279;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pPsQyyBPzEAQkVDIawVo6OWX0ms5Q0EED4Pj4wwqfP0=;
	b=QvLSOX4rOpsfg5A+TZ9ICYmbcc340cqmEAKdSAXobmy8X9teSnNaYJXH8PKkqvZEiURL
	 Rm2UmZMRF1fvZ4xnuKUHnar+RE4ajK3dPhNyKnR5fGUGv6vpvWC6IDlVeBkwv6crn0CSk
	 g39qcXcTk/DK5apSfUZ7DBwN7kzxNBI79YfCOhfEUxb1yRyWK3QsVpwFSwqXfh2hWoSGk
	 hMEyEzs7729TOQWnJFV7LDkWQEnHuiuN80txgChW6vtlBabG9gmZ1/wEaxGwXgvOkAEY0
	 wfOAoqH6osuQa6/3kmSvPYMbWOkg2YcyD2kTyekMXcEGT8T177NkDmaQcCiYwLbloaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2NnjnIL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7560A260B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2NnjnIL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496CB1F0089F;
	Tue, 10 Nov 2026 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311279;
	bh=pPsQyyBPzEAQkVDIawVo6OWX0ms5Q0EED4Pj4wwqfP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2NnjnIL0YPWHI8dt1Wp6gvMJA1MnJLdpSyr7F2hYn3Ae8Yc1hri2M/QvQ02RkoWc
	 GnyMb4vHSkw/FijVW3WkKgJKNGaYgeo4PzPtm0MUly2JdjHFGpXpQa0Wld9abR1Q+M
	 deXpa8LD5326MY/RnYDMrQLhLt+NmR1do+NYX3fFJgu0ekkHUUI80WZS4oOf9GJIRc
	 CgQmfsIN+hgwAKHzV2UN2PByotDRg+WZ5kd//e92qNldqW+qYKCAJemlVjOGaFkTmk
	 Sc/29mVw05EiSsGLkCOJBR7wricN/FFu4lIbdKBjq9ScuuXVWgL6RNG7KLZwBEKvxM
	 7V0LiCU3DtCrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Punnay Sharma <punnaysharma805@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] staging: media: av7110: fix sp8870 initialization failure state
Date: Tue, 10 Nov 2026 06:47:57 -0500
Message-ID: <20261110114747.615326-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052847-failed-6.6-30684fa98394@kernel.org>
References: <20261107052847-failed-6.6-30684fa98394@kernel.org>
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
[ sashal: Preserved the one-line initialization guard in sp8870_init() instead of upstream's two-line formatting. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/av7110/sp8870.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index 3a9fbfc5adf03..de70953014114 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
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

