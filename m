Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609030;
	b=CzGtwKjlQdhHpinosXKLDoa+NaZQbSHYc6qGyCxBBQzG5X7z0MTuB6aknNT3Zvmmp3CR
	 WKKwBaFec0Fg4B5uVR1Hq8vVy9iah/TY7TNUGgL5xc35iFLwIXqungw22fDjsUMhcQJGz
	 e7zcv4ti6qAKFhvzzFxyi+6rtbfe7h/gSEi1u9OJk911nJe8GULHuBYfeLMzcE+5CBnlM
	 HpE2nFnaMGx38IpmfnTLmn1/DAf2WVnvC8MgcdT1UMQyvNRaQQB0T32kIKjbyXpJgmgPw
	 hOEeteh0Qioj9lKgA9+Rv3l4/vmf4xVKQu02uvs4RRZymKKHqUUx/3ZoHJckzuB9zSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=w8tUVNHS/D38ZjyQ5CWDOY/UFQrlls5f0YWk/lFXuJA=;
	b=IAxrtwd5V2zONPzo+bG6Xdfzpl/ZQ6acMe0OWlFv9EiqQoyt0tpAiTMXQJyV/Ko72kbP
	 aRtmIFlWVhcl4jjUex8tx76E4NYfl8irzfSiawTEJdaBo2FAlwD7TU+lQVPcuJE9f0QhX
	 aAbAas8CcgB5w3a2TZS9jPmgKx75dypXZLf2ph/OD8QYr+mAwxO1oSdURdTCpMU7Zeesp
	 qIcO5cg+9wxt5tMOD30Y63h3xVzkt/V42wicA+/UGGffWle4oTC/R+9uIGmZZfvWna3yg
	 73SWl3F/dRhkNbfEB27sHQ9XRZ6FKbaE5OzEu2zfrxuJdqt7/zlaF9j0G9joLkOHkXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p7Hgccfg;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9B606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A9B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p7Hgccfg
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c5133831027so809561566b.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795609028; x=1796213828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8tUVNHS/D38ZjyQ5CWDOY/UFQrlls5f0YWk/lFXuJA=;
        b=p7HgccfgldId0EFsZVtky/Yn1tZ+TXful4b/uTLUd3Uirf9ev2SvdKPgZk5QhA0Lt2
         1qkohPw+/agFjbbWnIjR8WS+b4pwrBVFMLKrd6rFnoSVmqOWjMeRdeiZflR455d37vmA
         aS5Dos4/2jRxZn/T8LGuudGN5NyJ9xj5d4vFV5gk0bhYygcymgiFmtdET3W51r6650UX
         Ac8yo1SNPbHqdJbdJFsQfbY6ey2meedmWfjHbJT0FUl3wOwVuR1XP9tAgYOHvJJ53JTF
         slJe0WZt2mhG3ZsRHBi4/xOQCcCGBmDA/XH7SZSeS8/ufvEVbJwqEUepD6XpOzwSdLz8
         tZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609028; x=1796213828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8tUVNHS/D38ZjyQ5CWDOY/UFQrlls5f0YWk/lFXuJA=;
        b=OLVGwRm1//4hxvPHFUGR9pAP81xfkSn7wmMbgBa9ylnjez64srUw4tyu31CNhZLAd0
         118JDaNIXEmKrnRWDQV62mf+tnplE92okiYLhcW8ruXcA2mSip00DWke8qbk5yi0k2lA
         Xiw0aImUmvbbgMNXEoQVoN7xG2a7+vDPmI5ZCRrQD9FgIj4JFWhZkcEA3mwtl8Mgd215
         P9bcyjxAsCSKpruGA6ccGrWzR7MRQXIzafdxc3kyRkWx2onJgjRSpEE7ls9Z39ZNnz1R
         sPusxlGu/vxufdddArA89SPyHFDjIlh2k4tkn5ztGeuQW9XWcyqVRq7NKorZXClUmTGS
         Yk5Q==
X-Forwarded-Encrypted: i=1; AL+hErG6sCqpz8vipb/LfnRBH/tYBXIpzHEpEYieezrLVOxjxi2s+rAwGRn15G5zuMV52FRChN6Kx40=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5/XTMsF2gGYIYQd+sTueypVFjJR1gWSR9kQcFl3PHtcArgEMM
	wx/k/P/bth4zOq/LJ+KTHaHuwm25jIUqVB482RghwNMy6avSjTTZ+j6Q3svLheI7nUA=
X-Gm-Gg: AZFdTZdA/HGcEEGAEkQzGNZWDE1niLJGQ9wJSopaPZ5WxMG7igauYU7WoZvo5GQVClN
	iRMdVx2sHcJ5toRTqFxTScb1SoxB0daTRP/h+WJUIf7tIZ50bMTmPd3MJxp0znO3WwwoehqgmzA
	OA33jt54RxYi5G+3XzIKvJPll3TGfYL+7y+HcMqPgvO9sgsgkXpqA3eYPNskt6MjIOnhSh3zKLS
	LxMALMEiMMzezRVbP/fNvkL6fKJcff64TGoc/hfdaeXm9PkVYmrgTOtkDof4+s2crVbQ4qkI6iE
	fdWOoVIv9hPfXlWS8hbQlfKodH1eNwexu80Is8aCCYar6sIT4K8j96f4l1pObJUYLug2zwD4bkT
	pC3NoZe6HlvidWZvP9SEIIs09Hlc6Mq0Ib1QQWBe/gwlHYI27yxNvBuc4uNxJHR/ab1FSNk0r+z
	xWW6Z9BxNMd2c9rf/Iks2xvk7e7vWz/gXo0+wDaWvttG898VPP3rnF2ehTehzJEP7gYtSAe1KUq
	64F/Z+ZGZdiKjM4P9Eyhr+NwLHK6NcFLAwRvOCFZRBGUqF3eL1vnB6CR65f2iNxWtssbeVy9Voz
	YDOcza1SdfoHWZuwWHAEBTP0dxPq1DFtPvZ6wiZf/g+QezpvfeT0yreUISM9upKnLGuyWIxqLGP
	i5O1Jny+j5bWFvpREWg==
X-Received: by 2002:a17:906:3948:b0:c50:b0f1:abc9 with SMTP id a640c23a62f3a-c513a60eab9mr967680766b.18.1795609028530;
        Wed, 25 Nov 2026 04:17:08 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00d2asm650611966b.3.2026.11.25.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:17:08 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 25 Nov 2026 12:16:55 +0000
Subject: [PATCH v2 1/4] usb: typec: tcpm/tcpci_maxim: fix invalid wait
 context
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-max77759-wait-v2-1-9914b985c00b@linaro.org>
References: <20261125-max77759-wait-v2-0-9914b985c00b@linaro.org>
In-Reply-To: <20261125-max77759-wait-v2-0-9914b985c00b@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Lockdep reports the following with CONFIG_PROVE_RAW_LOCK_NESTING=y:

    [ BUG: Invalid wait context ]
    swapper/0/0 is trying to lock:
    (&dev->power.lock){-...}-{3:3}, at: pm_wakeup_dev_event+0x38/0x80
    other info that might help us debug this:
    context-{2:2}
    locks held by swapper/0/0: 0, on CPU#0
    Call trace:
     _raw_spin_lock_irqsave+0x60/0x98
     pm_wakeup_dev_event+0x38/0x80
     max_tcpci_isr+0x2c/0x58 [tcpci_maxim]
     __handle_irq_event_percpu+0xc4/0x4d8
     handle_irq_event+0x4c/0x100
     handle_level_irq+0xe8/0x188

max_tcpci_isr() calls pm_wakeup_event(), which acquires two spinlocks
(spinlock_t): dev->power.lock and the lock of the device's wakeup
source. On PREEMPT_RT, spinlock_t turns into a sleeping lock. Since the
interrupt is requested with IRQF_ONESHOT, max_tcpci_isr() is never
force-threaded and runs in hard irq context even on PREEMPT_RT. Taking
a sleeping lock in hard irq context is invalid, triggering the lockdep
report above.

Move pm_wakeup_event() to the interrupt thread max_tcpci_irq() instead.
Drop max_tcpci_isr() altogether, since its chip->port check is already
duplicated in max_tcpci_irq(), and request the interrupt without a
primary handler.

Note: Moving pm_wakeup_event() to the interrupt thread doesn't allow
the system to suspend before the event is reported:
suspend_device_irqs() uses synchronize_irq() to wait for the interrupt
thread to finish, and pm_wakeup_pending() is checked after
suspend_device_irqs() returns. Once suspend_device_irqs() has armed the
wake interrupt, the interrupt core reports the wakeup itself and
doesn't call the driver's handlers.

Fixes: 6f413b559f86 ("usb: typec: tcpci_maxim: Chip level TCPC driver")
Cc: stable@vger.kernel.org
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index a19f52515429..6e202171f57a 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -411,6 +411,8 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
 	irqreturn_t irq_return = IRQ_HANDLED;
 	int ret;
 
+	pm_wakeup_event(chip->dev, PD_ACTIVITY_TIMEOUT_MS);
+
 	if (!chip->port)
 		return IRQ_HANDLED;
 
@@ -430,18 +432,6 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
 	return irq_return;
 }
 
-static irqreturn_t max_tcpci_isr(int irq, void *dev_id)
-{
-	struct max_tcpci_chip *chip = dev_id;
-
-	pm_wakeup_event(chip->dev, PD_ACTIVITY_TIMEOUT_MS);
-
-	if (!chip->port)
-		return IRQ_HANDLED;
-
-	return IRQ_WAKE_THREAD;
-}
-
 static int max_tcpci_start_toggling(struct tcpci *tcpci, struct tcpci_data *tdata,
 				    enum typec_cc_status cc)
 {
@@ -538,7 +528,7 @@ static int max_tcpci_probe(struct i2c_client *client)
 
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
 
-	ret = devm_request_threaded_irq(&client->dev, client->irq, max_tcpci_isr, max_tcpci_irq,
+	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL, max_tcpci_irq,
 					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
 					chip);
 	if (ret < 0)

-- 
2.56.1.831.g720f3f5937-goog

