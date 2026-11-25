Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609030;
	b=2EN4vEfPjghc3+rzbralptEti5TAdDCMjb/r2PniQcLR0q+roM/SqpB9th3D65tEvkAN
	 NqLgx/R6RwrSz58UJU4N/AtxfUPOwA12T5fsttUS2JuHGYGjsUpTGh2/l7s7S3q19h87T
	 J/WHPozd7kTXTIHj8u4yd2lN+MzRuoO9FvcUQ39NxjFQtd63qCAXMVXN48IEYnc2dEpVY
	 0F6gTHXMgXn8BQgjcvdBpNSmcN4S655b2KBFGCDir5liMow5RDsbwYywY0ChbAKQDoGiW
	 /+uHwHbXqqDbv4NG9jT2H3ap2G2hrcJbtA+TIIJVBBgHohnVOslEnLyVJ7nW7J8l2+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=0HU6I5cV1alAqBz4EUOEAXse6J/R1fjd0fGE1Ycjrz8=;
	b=WBhCpGe6vL+F9BOu0dWGkLb7CGcV/A/cKnSYHfhzDoTm8rWuN0AZ2JAWg6n4lWbU2BUg
	 g5IMljmkccqDSZReCI6viUIrZP5kcIQE0fYs907ETK5i2WuK0BIYEc7bo+BXqYA7AB46w
	 R3skvzKeYd3p9p7uanZKq2W2UvikTpJeoEBdGj7kzHSOhuCrswk7QksvAejiZiQxyHNad
	 YfdzdY7slwMocLZy3N/v1Fd8WWQA3cIY1m8WLMKZWzevaGWeVF2uJvUb/qNtTYw/lZCMu
	 9YpHW83cjVbxemlwULwjs/zBAVp43CLmqHBxDIvVCC3WCTYUTohHYdcDI8q4VYLzllQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OZNBaBDl;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA83606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA83606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OZNBaBDl
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso12002725a12.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795609028; x=1796213828; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0HU6I5cV1alAqBz4EUOEAXse6J/R1fjd0fGE1Ycjrz8=;
        b=OZNBaBDl77pnrud2wYW7YE3duGQ9qkFNHj/97b+3rn/VRTxh0R6zJu2JYjB0CASBz0
         doSMWT1d2HpwCvbVyJgSsvzzpRbTJJRaVom0kGwAVkbpisjUGTEbn1Rk+/8YntogF4P9
         rGOWB4cEGmu2/q7eUyM6f+aCOEGx2PY3pKGnWbaf3pKVIPghpsEI8NUAT/Eugh1On8BI
         TAzueZE9HEoDyuiNi85m2a0kUk7othdMg6kGCZg4lSOVBtQ8rr/odvHpqQXdodEPCOwW
         AHzqLcsovlgY5Qo2skyeh0BKAo5xSIOPR09ZT0jFLfZAMLQKki6ynkB0CibdPU93WFyR
         2CsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609028; x=1796213828;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0HU6I5cV1alAqBz4EUOEAXse6J/R1fjd0fGE1Ycjrz8=;
        b=o52w5ERvf7fPH+kklfiIqw8roNi5303mQWd3IipSyS1pFTZTQ/fLJJ9LiCajt+kVsY
         MXOBAcHl29SR/4hDcQanWLJ73E+Ltq2tONn0tAlKbAM1njAs/7EMddOkM5Rdr+OMjlDS
         fwDTqJ3gf3KFiWzdZ1w3f6xE7PVxCnZfRIY9IpEVtHiZdYtCJ6pW3+7ZIQfpGANMWV9D
         9XuxLghVGdLm36+swCuFcR9y2zHf7cJIp/2ld85wAqCBrmLrmFVM/QYPDE0Z9bHXJ9g4
         aOGWxN1LfxbhsmEVWHRvG18Mc1otsljq2XOU1OnN3vcT+Hp6NxYGc5lr65/bfNXb3FrD
         4EJA==
X-Forwarded-Encrypted: i=1; AL+hErGOEWMJ6kPGQ5LgmJeqB4j03YlQnfifKfJE5q+/VV+2Q/hpL31jvn59tFXDkojTct/+rVW3JPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e8PlVHoJfNQPk0qoKpN+1kjmf1uO1Kxg1xTiky1xCM+2Tj/Da
	Wnpd2VQEbjLMwPTz5KjQOhJM86xq75jaFaRvLQFVxszMBlLfSmUb6ypkeYmzW4ioXN0=
X-Gm-Gg: AZFdTZdr2X/TYaZGrrI+EEDjRK4/RucmYcFhw/sTg8/nIto77cpgRFltzhgfYLCsvmB
	tAT4wmdlpLQ84G+7O1Db1en5VB7FJocR2J3PeIfpI2Sw/VO7pX81I2KFBrAF9d6qBJBXeLD+DdM
	nDi/UnWsHtI9xrE+e7wv2kWLesrVlSWZKezdUXjk0EalprGSSPh531e0CYob0sKKjfYXN+3rm3F
	/k5yRNo/v+rSYNls5M/YvnSS9p81pE7UhdbdJVIuFyPwvED+tu6h4r3wgMGelKkPMTt+YqURoHQ
	Nnt9roJ5PcAtyH4CUyNK/G/eeMVGtEnCmLBaFLSXjOd1tRunTE5dt3S27vxNwcPhQ5OrJMHqDrs
	6i5WEbazmuoT8mePCNUGXBxRSBeGwUhRuWNcNnYGz1L3CtSeK29wjleIPBKHvBFUyW/D7jE7CJ6
	FYrySLbI+oxtGF/q7J+nHJfRUVG6jQvQYJEs5wDmhYKGjQMfyOiXTX/DAQT4SQNM33eVZgZDgr/
	u3H92osRhPYJpyZOsVN/F76E9JEj6U30jovbvnQbvfBxITFJ094/G9slcqwWezo3KKIshQ9pLKs
	4a1dggDNJX6r8Jv9SI5XRGWRczxeozOT6ux9Zi+lnQr+HWQEJ3R3NBDWZti6rLMqvpDw+fIQ3zC
	RyS6wHYEJddcmZmNOsw==
X-Received: by 2002:a17:907:ec09:b0:c2d:c6e7:9e9a with SMTP id a640c23a62f3a-c513a816ce5mr1420780966b.11.1795609027961;
        Wed, 25 Nov 2026 04:17:07 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00d2asm650611966b.3.2026.11.25.04.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:17:07 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/4] usb: typec: tcpm/tcpci_maxim: lockdep, wakeup and
 vbus regulator fixes
Date: Wed, 25 Nov 2026 12:16:54 +0000
Message-Id: <20261125-max77759-wait-v2-0-9914b985c00b@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIALbRBmsC/3XMQQ6DIBCF4auYWZeGQZDYVe/RuEAFnaQVA4baG
 O5e6r7L/yXvOyDaQDbCrTog2ESR/FJCXCoYZrNMltFYGgQXDaKo2cvsWmvVsrehjSFvtXRyqFG
 MUD5rsI7203t0pWeKmw+fk0/4W/9JCRlnjTNKGq2w7/X9SYsJ/urDBF3O+QuicADZqwAAAA==
X-Change-ID: 20261123-max77759-wait-10974f4c312d
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

Hi,

These four patches fix a lockdep invalid wait context splat, a
probe/unbind wakeup-event race, and two vbus regulator lifetime and
logging bugs in the Maxim 77759 TCPCI driver:

- Call pm_wakeup_event() from the threaded IRQ handler instead of the
  hard IRQ handler (the driver uses IRQF_ONESHOT, so the primary handler
  runs in hard IRQ context even on PREEMPT_RT).
- Initialise device wakeup before requesting the IRQ, so a pending alert
  or an interrupt during unbind cannot miss recording a wakeup event.
- Fix a vbus regulator use-after-free on driver unbind.
- Drop an irrelevant error message when VBUS sourcing is not requested.

Tested on Pixel 6 (Oriole) with CONFIG_PROVE_RAW_LOCK_NESTING=y enabled,
including tcpci_maxim module unload and reload cycles.

Cheers
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- add patches for two more issues, a UAF and a spurious irrelevant
  warning
- collect Heikki's Acked-by on patches 1 and 2.
- rebase onto next-20261123.
- Link to v1: https://lore.kernel.org/r/20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org

---
André Draszik (4):
      usb: typec: tcpm/tcpci_maxim: fix invalid wait context
      usb: typec: tcpm/tcpci_maxim: init wakeup before irq
      usb: typec: tcpm/tcpci_maxim: fix vbus regulator UAF on unbind
      usb: typec: tcpm/tcpci_maxim: only complain about vbus when sourcing

 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 62 +++++++++++++++++--------------
 1 file changed, 35 insertions(+), 27 deletions(-)
---
base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
change-id: 20261123-max77759-wait-10974f4c312d

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

