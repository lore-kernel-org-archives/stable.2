Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65647C0E6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101276; cv=none; b=LQgSAFBqr+Fm6SIc7gD5O8il80MlJvV+g3+yo+CPzs27gIRnMXJVlheIaSB9EUa8yeCnz5y/lwd2s3lYKnweMj6owKd6naOcgNYocDjdw00Vl2+hfzSfD2wUErWvZdihYFxzd+NCc7wgHwHuQoTKaBUAKpxQtdolzSoRq6oLk/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101276; c=relaxed/simple;
	bh=0OwfDnFT9Wb6BLGQCwCop/k/W8dtNm/dMAVTKwTp0so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9lXnr5ZpBUtG2lGSeAY3Kc5vDnxxj4WLz/JMhrD5rWWFN6p0hlo6epIWwJoHodJXs+Cs72MttEl2PF2+prGyE26/dmBH1WQ7BTmR62nL53lPFbXvLOVu1uYRsJhssI91/TNuz3q4fFU1ZOmFsxuNVe/GmYgETFF+U70RW27Kvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJTv52kS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJTv52kS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F60C1F00898;
	Tue, 22 Sep 2026 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101274;
	bh=K6hKV3MnyGczckr/ToqkWSBn0GIkkLhfYI3md5x4ip0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DJTv52kS3oTv/+B32zpxuzeYYwE2tcGJFhqDVoet+jB5pfSsj+nCrnCw7RLr6O35d
	 GCJoxmcpuQkHgxm0i1pir7Q8nMvtxRm6ALF0NfHIFlHaEVyrSODauPm7ZrTiAXQxr0
	 j26KxFQCH2vXHwKasjKXVdRCel79ew4en50BsYtKhlm2diZJnEUbTqLUTmWMaHd7hy
	 NpcsZvkm87pACyOFCHy05tFtFdoMn5DBvijOqZ5fgTJemFP9pDf31wyysLxl8XqST1
	 LlnBs6ki1FUNIrs+ULgyctX6ctcvWDCkhL53dT+GQNVcGEDXc7cjse3o2yz24Tc/Q0
	 oiTQ37ac1bt/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] Input: adp5588-keys - cache GPIO state before registering the gpiochip
Date: Tue, 22 Sep 2026 14:21:10 -0400
Message-ID: <20260922182110.3568173-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922182110.3568173-1-sashal@kernel.org>
References: <2026092232-wanting-charbroil-6f57@gregkh>
 <20260922182110.3568173-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alvin Šipraga <alvin.sipraga@analog.com>

[ Upstream commit 21efadc62272cabee9bec27777ae75d84a9ca8a8 ]

So as not to clobber any pre-programmed GPIO state in the execution
of its gpiochip ops, the driver caches things during probe time.
However, since those ops can be called both during and immediately after
the call to devm_gpiochip_add_data(), it is imperative that things are
cached before that. That's not the case right now, so reorder the two
steps to prevent any clobbering.

In the concrete example which motivated this change, a bootloader was
preconfiguring an important GPIO output to HIGH before booting the
kernel. Linux would then inadvertently set that output to LOW while
configuring a GPIO hog on a discrete GPIO line within the same 8-bit
bank (because the cached value was 0=LOW).

Fixes: ba9f507a1bea ("Input: adp5588-keys - export unused GPIO pins")
Signed-off-by: Alvin Šipraga <alvin.sipraga@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/adp5588-keys.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 161dc6a7bf445..ee2054732c34c 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -225,12 +225,6 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 
 	mutex_init(&kpad->gpio_lock);
 
-	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
-	if (error) {
-		dev_err(dev, "gpiochip_add failed: %d\n", error);
-		return error;
-	}
-
 	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
 		kpad->dat_out[i] = adp5588_read(kpad->client,
 						GPIO_DAT_OUT1 + i);
@@ -252,6 +246,12 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 				 error);
 	}
 
+	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
+	if (error) {
+		dev_err(dev, "gpiochip_add failed: %d\n", error);
+		return error;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

