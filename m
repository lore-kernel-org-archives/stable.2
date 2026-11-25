Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609031;
	b=pUvKCWQOZ6+gGF9m5C7wUDB57oner0PgfNnNudDQ4pMnkoiDjKHev85K8ZUB+Q5lzYsu
	 YrJrn5LhaK9IQl+VwmKzbMaGGQS4feD/CjQ8CYR18F0bJ2wdz6tTr0/RdK3sFpkBW2aUP
	 jpIS12QbD9bLC324dI6DeRPAVpTar6oazc5MsFKuqgG6LuHHSdYM6U+c62J68ixiJqXSd
	 xOdIi4WmSH9+dS54uVNDhJWd28b3/1KU+2DsC7BeE4AL/x10r4ok16/RTe1Z7My1WTd3y
	 A3oGVaBS8tMr6yPJs9tLbvQ2++oHqII+dFQdB9bKKH7v5KMwn1kVZMjgp6lxjIlLDHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Rulwleyh8bhvWAVb0QvlMS6II3FShQUJjsRscedmHGw=;
	b=B73BatCNCXMd2T0gjZpE30VCK20jLKX9mt1ICIFciRh0aAdQCJbE8hg+LkcgV/kkz9L+
	 z1Uri5sMt6FvSdr7je9iX2t9gxMJwn5N+BL+it8ggBS9yyTOyj/chXIN89oOBZhsr0E3R
	 VCegps76kZFhMVffzxsZ3+B2pHzWPyKpxg02bfo9DydMFf0V+6xsZUsGRUf70S3JqVyKH
	 IgmVfLVf6jBP1Yq3x3rEKem/albWlToMXrqaufeGlnFun4uIZrfc2Cc4hLa1eB0RtT1Y7
	 KxkPbRZ23/bgaPXnkltPyG0hjznvqu4S3lcuVz1j10RMDfAhL/I3kaaGkhPA9vVok6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=O5r7GYiS;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC2606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEBC2606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=O5r7GYiS
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c5133831027so809563466b.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795609029; x=1796213829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rulwleyh8bhvWAVb0QvlMS6II3FShQUJjsRscedmHGw=;
        b=O5r7GYiSdiZ4ezUF5CMM0dsFvXvFdK4+E20x//x2UQMWvSRp0b9zkxupjfY+NYoVil
         cVYIAWsXkQQ1PfzaXDcvtSx3/mRUFTEyvD76zT/6iOypE5vYa4p7WsH+tSq/H83BLFSg
         TqWS36RHVS3UXn2R4CXOVcKPNu0b9/xcUV7hrp0xy/newLmtP8NzQaEZycTYyth7Gv/+
         oFbHIR7yGGhhY0bUcu1PC01U/agNylKrJ0uFIy5o7C/0heJM+l0E2GsBNavEwCAlLbwN
         9SipVLNjdsyFoU1k3v0LgRKewgTbUUjD5WwR+vwY/85Fr6dXrOX4RRmpVT6xGjs2zOFp
         UrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609029; x=1796213829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rulwleyh8bhvWAVb0QvlMS6II3FShQUJjsRscedmHGw=;
        b=BqAmeh8BGuQSfRdXNxoy4pb7pU3BG6jOlCH/8RO3gLDYYZfmKD6P2STmBfNH2+VOz6
         QCxNg6tEAIWseMSQOW7lMl437gLiv52oYHxFlbckgBxiL0O+W5jndyqNxWNhaX5r2JFp
         lPj/oSBvDcJEcfAoZq8GFCF8xWd1el8o8mG44ybbjsDk/3va0z7sPY62Wt8LmIWrpnSd
         ijkDiUbb8AXRH+Xyb+ldqXnNARQU4CnEl7elOol8T8qra4WMuQCP3ote9ziR0+WTsgTZ
         bQtI4df1guaYqjx2mZSVj4Qo1tS5dDWo+iw5cS3mR8VHB/DHig4iQFvY+MvurgydDaEw
         Lz+w==
X-Forwarded-Encrypted: i=1; AL+hErHVNWKu3A6DMB3rc1hZOSwstlouEWdRgdGaQdtGbNJMejulId4YREa6PD9MlppS9QJv++/yuJ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z93cd/lka7OA9+pqL25SpEBWwlATHLxWjcpHN/YYo6e3YiH3Y/d
	bE2P2uS1yMmr3GsZaj3IPqmc3MOSlCrCEbsaB91fnQ+vkDhsfPFmca1wWpV3L2Sk7lg=
X-Gm-Gg: AZFdTZd+E8iMgbRGfoqt1sJOd2BMmbqDDmD3VLzovuiqYOQH2qLGqJrSFb19/HboZNC
	9xhg48qAIKBMgrrdBhDJeNove54Vs23V1BoqaDrVaXWFBmeHSNUidYHDKdqJYlNmyZ79obm51/M
	JLJN1RbFbu+7LQOEQdXsDMFcubtZgXVLtLv1QTpNKT8DK9O/EVMWa7/Iawtwyifl8/M1zaLHeKC
	zge3GqJXD6N2UOYxquK727owrPi3WkeMYTREn1Cd2qEYhSxzVGzmLHw7HWU7ePcCKAprupoY6ay
	5AGRK802TCd47HW43m4azZF/5PDbtvIFcuWfp7yfXHRECcijeFOzctdGq/bz1wGtt5NrjEe0/cL
	YFh/5RNahTbfTmuWXYXvRvZ4mamZS6VudATXCdFoI8fnJnqLsi27+p4XQDFbJatpA2A5h4BHZFn
	AfaxMWHP+aKedzMTf1kPO8S56jPT5CjvWPlJpEaQwPzeRfuj1JsaN8oukQNw9OE7kje16TWyBm+
	3ssrFUSMSU1R5O6Y2NmsL90lj9JHFDaWp9otX44tKVlxaA2mpjpyFLcVktN9IttR2/NSlxh8gvG
	Yi25un4R1AAbQ+942h9lNA/a0l0IHkp/dw8Hp9DOMqcb7bgzPmgf9lRCRqKrPFk+72WOcsDraoA
	akzWMNyG+KtZYuSw5bA==
X-Received: by 2002:a17:906:a11a:b0:c4c:d96e:80de with SMTP id a640c23a62f3a-c513a5dabbdmr1120945766b.8.1795609029062;
        Wed, 25 Nov 2026 04:17:09 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00d2asm650611966b.3.2026.11.25.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:17:08 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 25 Nov 2026 12:16:56 +0000
Subject: [PATCH v2 2/4] usb: typec: tcpm/tcpci_maxim: init wakeup before
 irq
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
Message-Id: <20261125-max77759-wait-v2-2-9914b985c00b@linaro.org>
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

max_tcpci_probe() requests the TCPC interrupt before it initialises
the wakeup source of the device. Since the interrupt is level
triggered, an already asserted alert can trigger the interrupt handler
before devm_device_init_wakeup() is called. Its pm_wakeup_event() does
nothing while the device has no wakeup source, so the wakeup event of
such an early interrupt is not recorded, meaning the system is then not
prevented from suspending for PD_ACTIVITY_TIMEOUT_MS while handling
that alert.

When the driver unbinds, devres works in reverse order and in this case
removes the wakeup source before it frees the interrupt, which leaves a
similar window.

Call devm_device_init_wakeup() before devm_request_threaded_irq(), so
that the wakeup source exists for as long as the interrupt handler can
run.

Fixes: 6f413b559f86 ("usb: typec: tcpci_maxim: Chip level TCPC driver")
Cc: stable@vger.kernel.org
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 6e202171f57a..2bb306b6b1f9 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -528,16 +528,16 @@ static int max_tcpci_probe(struct i2c_client *client)
 
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
 
+	ret = devm_device_init_wakeup(chip->dev);
+	if (ret)
+		return dev_err_probe(chip->dev, ret, "Failed to init wakeup\n");
+
 	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL, max_tcpci_irq,
 					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
 					chip);
 	if (ret < 0)
 		return ret;
 
-	ret = devm_device_init_wakeup(chip->dev);
-	if (ret)
-		return dev_err_probe(chip->dev, ret, "Failed to init wakeup\n");
-
 	return 0;
 }
 

-- 
2.56.1.831.g720f3f5937-goog

