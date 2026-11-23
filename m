Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438991;
	b=ckHLrx1YwQGN98CvdVQA24gjdGc/Vnk74hPs/LYQGN2llrfhnliNdZPxw+z7j7Al+0Jt
	 2vrTQbrMnH74go2TqBh1uBD6fgL1h8frbXP5eJ7MMz7OnHv0zD4VytJ9XcAtsx1Q6tI2Y
	 eFd7tmTf13zw+bG+HY23xGMesr6+eNKYpZn2x4dRcJdY0Z3rlJrJp+8sKGsKSdTK7KT0O
	 y10ysFmZ4w2o9XXHXRdIsrXr7+pYtO1ptKtyomZ+1kWHadd0tRDBmOFi0FYyGxanBl+FK
	 dmYEf7Lem4oIHyPTUcYZyhE31hOe3InOOlGXlbB9u6RSVva6pX7BCx8e+KdeFPWVkKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wg5SGmS6BijniY97uk+aTHYyvR1onjkeuDeP3BvWyrY=;
	b=AhrJhuIgiKqYsyeImQCnN1kYwMK+32cfUKR2OoIu2ZNrLhFYXrI35FEMzWfjY6O+biBb
	 B+QjygLSVGMJTHZ1Yc+kn6ffaT3TioVvvCfgzhY3Mfy35YXXOzSLb+sAIFwlimfmoifYv
	 eYRqTvcz+86Jp3OEk0vUTqyHDRMciP0Pbs9k2P3pdV471+QjCeFfl2ltT6SCPuoOdu+Kh
	 LDGVCKQ40JnihqBfz579wUXM+CrTmlIfGeNiNKiSPYNA8DjL3+1JWvYpaDXm42Bv1FjyL
	 qQLzhqn09ZZLGFcYIFQQLtntWYTYMcuFuJ6dVoTV0hDM9SV/nT9iexsOWP5XNY7z/EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VJ+PxWT7;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB140606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB140606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VJ+PxWT7
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c516a1623d0so197652466b.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795438989; x=1796043789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wg5SGmS6BijniY97uk+aTHYyvR1onjkeuDeP3BvWyrY=;
        b=VJ+PxWT73Yx+B8kg4YgXTs585xLPZlmPfsB4UYBcGzHTz06Aygo6qxG5pgZKPeFLFq
         SCZQV4rKhMpEOKfEbvxJEEbMd6N500skwzYs/1PrtAnMaU9g2Lz3t9jo863eW8nN4stW
         BOkgF+Tfr0Bi84OJq38Q8T7lbcIaPVB6+xz8CoxBwvXdoD+4b+UYjAT8sA0By8Nt6TxW
         0l0k7o5o1tDFV+1KUEdaCa1etgJxZCjAPWoGwCzPVG0UsowDITJ1Bkj2sR4EOn8rmLaD
         Dofzc2GUF4BX/hxcLP8Jqp1CIFAtXJdLHWrAds6k0BULxkAiJHaTv+uGGDpTm6YHNZIi
         kbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438989; x=1796043789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wg5SGmS6BijniY97uk+aTHYyvR1onjkeuDeP3BvWyrY=;
        b=b1RJWQyB5JTtMsjGwXTiE4z32nigIFfLGcoAF33mNTuHk/jI1142ZXbTqYdArRs+/V
         ryxcvHds1mSIfzvD0kOnNJjloQtLGoAdSfLucz1qMzGMS6RvYfsscyy9vyBzt176QbOz
         9mdAPX3kzATXZIsebSFjDAZ60cyYEI0TXYSaS6voNvjn0qAEhTFfsKpqV/2RwgLNVYlZ
         EN+t0yk3ENfNvOG6onbL+p2115qokdIpzM6sDSEpV/Qhsp/qgkf/97VhF7BoVq1L0iJ2
         UabmhMxGxdkWO4bq2Ob47new87Uz+RlQ+DyLVMqEaZMRmSs5mI/lG1tWu1v94vlwtIpx
         CrUA==
X-Forwarded-Encrypted: i=1; AL+hErHiIOaLqAbd7z5X42s5kuuXXIqI9AFfsWC2nw3Tm6+Up//njmt859+TgM5ESSTAbpErkbBzQlc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GVZrCa6kOk4BL/1ONcKTKaw+/c+MgvTx6FKfXirKjPWBzs6BY
	jPq9k4QKhOOX0yZe47VFRkfJnLxBAhfuPpzO/avb3+Uqpy4yauhMuDe80z97fB2bXVk=
X-Gm-Gg: AZFdTZe9jkZAnpz5lf8O0gXOJ7wxZ7znrFhSAYuZ6b8nXxkq0HAbZHjHNbxKZn5UBMX
	vBaI4Yd/QWNhfv3zF9cjhSFUJKtlfCdh/kcvRd91xt93yr0Wc2s/zCjj0rtX70goRTO+M0sgq66
	kiYLSXk8l1DZu4JSxTvRLf0xvoOFy+mAuREifLqLBr026dIOV0tW5l+MMEyoDoKjkGHVDOY2wX+
	yL2TgMT/UleuAngmmr38J2SZMgoJ6hSk0L4eHeJCMEPysfhCxnSu8CoWeD1aFi3mr4fMO+RSt3c
	O5yb+E4Py40AdPgt00mtrBXx0Y34ghL13ZTrzBYgZgLqEdLId6CZycnKU85JrJHz65o0ypLaF4f
	Ji3024P0RX+m7/UoBoVCjSnExs+7btBGz683vx1KsukeosHdYQY0rI3EYGHz3mM2Mrh2HXEnqA9
	D3VQfAclfiT3SgFf/qEbN9bdNz/aD8Ot6cUWs3c98Fi4WrpLYs9aHH78+j0O+7qkqoDv4xxlNCf
	eb6g53U9UHn972JdhQ4rzTtl9/z3cXS8r+4xhBtA6ozq887nS714X/GGV7yBOEyU2kX3Bg4NOz6
	LhUZ3QxSP36XqrCpIz8gYlz2rWUCZQfc2CAVAM8lPht6DC+0olmKWlEIIMTHoNsPv74IQo2GaNG
	+G67+SUioqhTKAuB8tw==
X-Received: by 2002:a17:907:a88f:b0:c46:d493:501a with SMTP id a640c23a62f3a-c513a8410d9mr998124466b.22.1795438988978;
        Mon, 23 Nov 2026 05:03:08 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85ecsm401379466b.70.2026.11.23.05.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:03:08 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 23 Nov 2026 13:03:06 +0000
Subject: [PATCH 1/2] usb: typec: tcpm/tcpci_maxim: fix invalid wait context
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
Message-Id: <20261123-max77759-wait-v1-1-6fa54a751bb7@linaro.org>
References: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
In-Reply-To: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
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
2.56.1.750.gf70dc682cf-goog

