Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438990;
	b=FrBwOo2kPU0pmmjlcdghtff+V/Eu+dOzPFwzlTkiloqCsJIMxb/tK/UngZVNtLPAkcA6
	 VZ3EGFDZsYlzA7m5VUv4EzfschQreBRub8jFQzU7qIP+P4OfETyfHRRXHkurkv0jIys3w
	 ehoB5OMw1xjGSGPDWfUldPIUNUJfMe64DPR9cXxCX/gERdqxJI8xH+iQI+gaQvMWB7QNi
	 m+hvnwKrOrnseS0YGI3ZBrylpbhwVqEzd3r2y9ZWvOeU1p7kAWBwHAZaFUSdX5V6tysYH
	 TfaWaWJJXz60yqAeXOywZvMoEM+pcrFfZsVkhYwCvJOfMjrsPVG2geXvxDw4zdnekuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=DXYfjHMF7j6k0mtN3BH/w8d4nc907qjO+zSnG7azIAw=;
	b=k+Y8lcseAf3aiBUNnv9mMsgWkiJL1kG8a/0CbtlMyXs4nP091vCtatSzvFmYEL2VsvKw
	 NBZn97yQtVRiUD7NUHTXgQL+xU2VvbT0M8pCERVNhsaAaTX8wFzY7mDBKKjrnmcIYnpPN
	 wKxTrhpYlgTU2528sDSCqfc/+DmaJaLm59ASBPXhJhr/HQkLD5WFZqmZ/nba/t4TGc+jo
	 uaH6IHpszbCuVaCMc5Ri5PkV8ykpI1LwIcrn9nlmwPTOBwTRdWprYhVprGqhQNf/r8YvR
	 2wmaprZvrBALtQhIErzYVB2TWASE5/7jVwtrS/KEH0CJyRqdY0q8EDThoyMlFI5PspA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g7LmM0Va;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E081606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E081606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g7LmM0Va
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c51373ae637so489897066b.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795438988; x=1796043788; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DXYfjHMF7j6k0mtN3BH/w8d4nc907qjO+zSnG7azIAw=;
        b=g7LmM0Va224jdPXvZ7OgKVReUJxGW4wGuat6pFgfas11bKklJS589Gl0afZW6bgnVt
         3L3Bgd2FzCzoABQmxavg3puZLkdVshFb52dX95Cyi1Tz9GE0RdkTw/hYyUT8jPFCpg/5
         4vHPmAGz9rO4Sp7flV/z8Tg/Knwl/nDB8roJJTjSiUhwAJutUacw5D5150ri3+vRYDNU
         3dW6SwTt2E7GUz0K4yPB/J/VnQMxOHluLnGkR5Up+Nnd2UkT9yzCds1QtGfr4HLHkclw
         s4F9eMmncTojn/KNH5IVHH9hmv870SwcDSBNAiauoYTNAP7cq6r3c4KCH3u46nn5rZNh
         UZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438988; x=1796043788;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DXYfjHMF7j6k0mtN3BH/w8d4nc907qjO+zSnG7azIAw=;
        b=Pql+w/gEh4OIdukn9mbUhOEWOTW7AlCeTih5P0zfo+Nksx6eEmDefbEdItAj4ahz2z
         87wQ4EVjeWZ3SC8aqLY4mb83iJ7usunoXJYiqNc7JvlL0JPwLOP01C3zv37/TSQXMn2+
         82g7l+z3XD7qqH8q8h28liyfxJPe0ZSsLfFNIX8T1NwvRHlv8BfTgqZ5t67DA71aP6Eh
         48qCM4/4jf2XngH1v1vWGFQdI3EBwrQrT/JTXzjcgte9TbR9jXP+xURr3PTH4M0yrQ4L
         opyVfCBkXbSjLK1G2/B2iELNF0IJhCn4pKGOb5+hc1Kx1TVqF3ddYAeBYnIHnh1rLqds
         HlSQ==
X-Forwarded-Encrypted: i=1; AL+hErFS2dJmMo7xR6Zl6TxPbUVIS5KTAFRKgHXUdMCU1Ej2SxB1qAI2bitwFrQY1CX7ZRrsKMVdUwI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AP2r56BF+nxPgrbMV2bq0lJSQc8RtlcKMy/6KJBlgf7TjrO3y
	5PvZRnpMOmpgH6FbfasGfgRI0us8WHKjOIpAZfwqXm1a6DcIlW7Aczyr8hNusMKpJrc=
X-Gm-Gg: AZFdTZfMnDsECAOoWv5fKlT8ew7FL2LtpCE5Ehiohr/3MRvspycmp45yhO0OtfaTkb7
	kmgNPwAx/oNAun6zYzRPB+NCxhFTPIxoA7EC/8I6o7seLmnwVdiyLxU094t1IpAxrjKw0CxSl1T
	tO8VP+Z5mxbKWNZ9gtf9EFCYr/ho2xA3v7slIlZC9gDi8P4Xmz296HoLvmtc+14Mb9h6kOjHTbf
	8zC+Zbu9LX7NwCjXEStxbDE0BNORUvbaMLyl2vAdXoRD/ZmDqVmd8wmibJnSR+L4zNUh7WZgB65
	N3S4I6FTusqIcHRPTnRxZMAU7YLbS9p9xZ9oq+V7Zvx5ld8lZjf6ghJJbg7NIyzJGgZzANkfjGP
	UmUTsExXaTfTv7A9lOsInvAYVwyhRmnJujyHnB2rcOfCJtInxnkOIe2BKmLrYlwR4rLbTebb7Gn
	sfx/gZ4qlnKVGGD9cah9atO/riOJ8f+kHne+PdRNxksPNExawOepPmaT0qUqbw4MTOgR9Q2lEvv
	T+A74qhy2TppyZeuYd8fwq8YcQq5m1no36J4fC6sqnkphOsCUCLd63Jm4Zh1bfsGf2Z7el59cal
	YjVcQiv9JgzlzwsV//En8gTeWOYDR3w40ifP2mfsbDjPHKf0mNGGoIaJnpUMZKSWtD518B27BHM
	0BBeJFwkbu+D/of6EqNA5C/t2bVGCTVTw4xk1OUk=
X-Received: by 2002:a17:907:a890:b0:c41:55b4:d88b with SMTP id a640c23a62f3a-c513ab14402mr997167466b.43.1795438988469;
        Mon, 23 Nov 2026 05:03:08 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85ecsm401379466b.70.2026.11.23.05.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:03:08 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/2] usb: typec: tcpm/tcpci_maxim: lockdep and PM wakeup
 fixes
Date: Mon, 23 Nov 2026 13:03:05 +0000
Message-Id: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAIk5BGsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNj3dzECnNzc1NL3fLEzBJdQwNLc5M0k2RjQ6MUJaCegqLUtMwKsHn
 RsbW1AKjieAtfAAAA
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

These two patches fix a lockdep invalid wait context splat and a
probe/unbind wakeup-event race in the Maxim 77759 TCPCI driver:

- Call pm_wakeup_event() from the threaded IRQ handler instead of the
  hard IRQ handler (the driver uses IRQF_ONESHOT, so the primary handler
  runs in hard IRQ context even on PREEMPT_RT).
- Initialise device wakeup before requesting the IRQ, so a pending alert
  or an interrupt during unbind cannot miss recording a wakeup event.

Tested on Pixel 6 (Oriole) with CONFIG_PROVE_RAW_LOCK_NESTING=y enabled.

Cheers
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (2):
      usb: typec: tcpm/tcpci_maxim: fix invalid wait context
      usb: typec: tcpm/tcpci_maxim: init wakeup before irq

 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)
---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261123-max77759-wait-10974f4c312d

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

