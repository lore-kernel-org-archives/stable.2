Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312186;
	b=buz3puzQow0GbeJscv8Ne2r9pMSKHKmSP73LQdirCA/aQIYLJBHl8I4aXlnamONof8m2
	 x2GWKdOt/Gp2QG54dxRo4ehjpXUfKDUsxhOY1Pa4h1XsBAHWUilUu7Gjp8x769AadOCiJ
	 G8ng0ZFiGS0DarJpwdO3tNUFcZWxFW4XnAmgXoShEimIBVRb+/OxcXWNK74VxpIj1Hn7n
	 +5yDkzfiXQC312+eMVbl/y/Oge7tVUrWeN2fX1pxJSVv/IWpeknY1Cw1v8llaxFEB9zm4
	 HFV+otT9JyF44nJYXKB4cZovRWrZgJ0oZrT8wKC3QKKgXcHX/aGuPruBhqtxqpSul3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312186;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iqat1RzbCX/EISZfJk0sbZIP+7OjFD51MHbhlqYX2lQ=;
	b=IXlIN9wMpaC1+NOGLK3uM7G6eidriEVb5SktV/AADZ48ExkqqswE64YHLzyZtNikIHFW
	 lgBEIdAD3SchQB3xkkgRxqfy8Meb4/jmmlf3SMClza5nrcTIC1mLU0kxFCKVHLMS4fccr
	 pwL60zDkkn8nJsfntDs9BuJHo0ON8WWH5yzgQAsOdTbxdm0Pbnamj/3hF/075btYUNUBv
	 ZZpxWDLVAFF5gqoVel8E+xJTznnCZ3tCbNkKyZE1Wjdt5zAR1RN4ihMW+jl2kd2C4VFMt
	 61FzMCBTDmOd2jTYG11d8KICoMARBBp46Zt1bjDWl8iNsW32DUeevBiwShcNVS4mdHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/QD0MfV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E196606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/QD0MfV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A643B1F008A1;
	Tue, 10 Nov 2026 12:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312186;
	bh=iqat1RzbCX/EISZfJk0sbZIP+7OjFD51MHbhlqYX2lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/QD0MfVWPhcjzf4hLjNttKhc7YG70VsIKoErVDk9JcS7NsfVN0WutuJl2t8NM6hV
	 dc7EDyd+DPNISm9IBAJniyhoa4Qov14HW+uBjUBF0Q1FgfU20BZoAS7pVTMWUOm3hh
	 qHAAMI+b5RIXPZq7qPjuC/msJdfFPTSuVV1MpUx2EmvVzZ+0Buxyidyy6Bocffi+6J
	 D0SkIwJ4NWgsEPK/hDTRc3u7KWO8jZckwovvBrHU6SSNT01C36gPmWNLxvjHWJtjYN
	 Dn7RhHpHz/5fr4AkR/fdRTBM4xkBQ3C87rbIf9Dku+hg7sYRlENuZXrqkGxXgmtGJ8
	 I6yVWa8k0RXoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Punnay Sharma <punnaysharma805@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] staging: media: av7110: fix sp8870 initialization failure state
Date: Tue, 10 Nov 2026 07:03:04 -0500
Message-ID: <20261110120248.960088-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055756-failed-5.15-30684fa98394@kernel.org>
References: <20261107055756-failed-5.15-30684fa98394@kernel.org>
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
[ sashal: adjusted context for older sp8870_init() formatting and debug output ]
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

