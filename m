Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86D137EFF8;
	Fri,  7 Aug 2026 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786080306; cv=none; b=ULvraDJhUNgdArZFls90Fu1EW0iuAHrlRSNdpJQrN1IuEmBgQywkA6KqCLEbnSQxtnQFWox0Xb8eVRZW7UjndoqBXe94/KUly6u+oeJctRTeBHilQQsz3IRLIq0wzJ+ibpy6rWXm2iFrSySSqNWfvgFGLOUiGUiKb9stYJv2nDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786080306; c=relaxed/simple;
	bh=UCPPa0M1nBQrqutfvKs9QKDkUq7cUuqPgXGCoK1GKYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j0V+Da+2tnOMCI2T8yWJwhOlV/27REFN9F5OZhvIYAmLCtU+g7RAgXSvvJuf9uqlYoS4dbMOMOjJCgjHQWHvrffGjl7PCWrhdUExRd0oJqBCWwgH7BZFE7bYO3xleBPn8t9mEw+tRsyaCcmZS5nqufwiKVJsJpZxFXZk+mOKtq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBnQX4bbHVqYldxAA--.1314S3;
	Fri, 07 Aug 2026 13:24:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCXgncabHVqURIOBA--.51109S2;
	Fri, 07 Aug 2026 13:24:42 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Pascal Giard <pascal.giard@etsmtl.ca>
Subject: [PATCH] HID: sony: fix use-after-free when removing GHL devices
Date: Fri,  7 Aug 2026 05:23:28 +0000
Message-Id: <20260807052328.11404-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCXgncabHVqURIOBA--.51109S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?Ce+Y2AXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNdqH/uLH5WfyK0WVr6WicCUSwDHfwhYn+Nx/FPKYE5orky
	efaELHOLEhIUz0Kwmkyp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7tr4DGFy5Ww1ftF4DCr45Arc_yoW8Ar18pa
	97G3sxKryUXr4Ik3WagFn7WFy5A393JrW7uFyxC3y5ZwsxAr17Jay5tr17WFW7Jayqv39x
	AF40q3y3GF9akacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The GHL poke timer and its control URB re-arm each other: the timer
callback submits the URB, and the URB completion re-arms the timer.

sony_remove() only called timer_delete_sync(), which waits for a running
callback but does not stop a URB the callback already submitted and does
not stop the completion from re-arming the timer.  The sony_sc structure
is devm-allocated and freed after sony_remove() returns, so on removal
the completion or the re-armed timer can run on freed memory.

Use timer_shutdown_sync() instead, which also detaches the callback so
the completion can no longer re-arm the timer, and add usb_kill_urb()
before usb_free_urb() to drain any URB the callback submitted.  The URB
is driver-private and not anchored, so hid_hw_stop() does not touch it.

Found by a static analysis tool.

Fixes: fb1a79a6b6e1 ("HID: sony: fix freeze when inserting ghlive ps3/wii dongles")
Cc: stable@vger.kernel.org
Cc: Pascal Giard <pascal.giard@etsmtl.ca>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/hid/hid-sony.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b966e4044238..bbd95adfbed6 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2164,7 +2164,8 @@ static void sony_remove(struct hid_device *hdev)
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
-		timer_delete_sync(&sc->ghl_poke_timer);
+		timer_shutdown_sync(&sc->ghl_poke_timer);
+		usb_kill_urb(sc->ghl_urb);
 		usb_free_urb(sc->ghl_urb);
 	}
 
-- 
2.34.1

