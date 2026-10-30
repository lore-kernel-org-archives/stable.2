Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359243;
	b=Q8tQD3wLKyqHuspDglwnfwd2NwSuUpLrqEXeIRALyiAjuvqo3o0kEE995e9qjKK+d9WN
	 vJUjFnh3tM8GMQqxWVNWSZiQALrac1lDGrIhMLiTZk9nXPyqdbc9wi1nCTWpudbx7Cm/z
	 NbuB6eN4RC06krUyrLQSmTtxH34tkRw7txTSS5yycCGQRgwZ8HpSGKKfJdr5OMZODfpQR
	 Izql6jusJAAWr2FmjXfSYqwg8TMTbcqcLuHEQS2RSPRl0PNftnasy9i2xSICwpY4f4vbx
	 Cu9iMEMFzE/rCgVo0XSid9/lcDZ4/6gYQlNwvUq+nED+/hcS1WhCa/g44lQLczXefTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kA022g7KQybNzRUEnZcuUM/LgZ6Doe/PgmD0oq3A7Qk=;
	b=zyy4QHvzBtGrrlQl2SJy66JCOL9x6JHgQLpB+2h7sCegqauz+TlbcLdoC76qMcVd7cs9
	 eAGepIMV3Hb2/GWtOaKY2mxXYVRTyJpb5p3MNnkw8z6nqS4kvcg2C2IiElkQquouxEkW8
	 22VKiK4A0X4EYDZkvbgK0dulBGgOnv6ckEULvGgQPDH8yFqr0yH5OLgriFvIDIaWJF6by
	 ZlFLjCkoc9np+0oc35ObHvAW22iuOCEsJA2vrlzFb3ua0zlP+KQ9PzyEvzNeuCbwMzr5H
	 oCrhAKya6ssQrNi4N6OSC2InV0s59TCrEdtt/3dSN6Pxee7vMDqzV/RvpXPCrKrQy7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=euBpbDHI;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E5606A32A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 492E5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=euBpbDHI
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e47347279so352941f8f.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793359242; x=1793964042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kA022g7KQybNzRUEnZcuUM/LgZ6Doe/PgmD0oq3A7Qk=;
        b=euBpbDHI8MidfO+H5M32k8tnJOgC6l6To+qZeBqfakmyjEHPb+Jm6N6yMm/tURZ7WL
         OI30/aCjFv8YdrXR4fAOjii2q1S8fqduBIB+VDyMT8+HWnFXYtfCISvWTipUBqZXXEyQ
         +N1gByyS32lXXUdy4MRJfNsTaeih/mppPVaNphVQWfHdlv1QXyZoxx4PZo/kipr0SyPR
         5TazH/GTZuOZY7d03NO4sb9Yg6Zv5yGb4mbso44InCRdRsHNJKEIBGZdLOdaMnlMMM1k
         WFrzv7tP7AbS8PGjHJIaLMWZOzEMmaKg2WS/OLg3pbjThU7ukQNpB/HF3yrFRUq8m7Mn
         klrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359242; x=1793964042;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kA022g7KQybNzRUEnZcuUM/LgZ6Doe/PgmD0oq3A7Qk=;
        b=0AHrtyZBUGrfqIA8Wr1NLLchlnb/nc9QCOVUhQuwTS0VCuZyb1Y5C9GR6iiXF/YTuz
         sfpzbp9aGDHjf8KsQQ1kU/240D+oUvGMAjwJsB9n6NIrq/4TMvcIxF5/Y5uWAaslkl1j
         Na2OaGmwN4ySx4syC721NFthFcs93QK0hp+6ldeXmzoxlMNtgbcT/o394Ps2iqdwcHhV
         Cl2vc4koHBsrqGAVXoKImxOtOJJUd67CkfGKg6KGnTNuVdzMZCDTEY+IHlwIQTrolqXg
         wKyMeI0Y/Ar/lV2JhHPx0EPVhiItxnag4BJUaj0VlQSoLTdVcpLDte3JSWMsYvQqN0fk
         v33A==
X-Forwarded-Encrypted: i=1; AKwUvBy7g66pQFlTZ5BvF1t9qloWt2xZCR8a5QwycpLwy1hT7dnAyABZQH40Vshjmuu1HQteLVBb2GQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8iFYkukw12f9FehCNFJxeTCs879DOwM/wOtbwfWj2j68Gp5l7
	WG1AygpYqi95wTiZcMgfxdukUC6WjCRi7t4cqSQEmkXx8wS9IyIbXQWI8iGR
X-Gm-Gg: AYBFou2kCSIqQ4NaUo/0KgWj4qgIQ1+bCp8BVzNB+Rr+Mk4194dNfxSEXP8UpBLh5OS
	8Q+PJsmV86GjybhK9hpj6YGKeJ/lpSltNC+3+f6ikMkyDt2S+GQyK0nAo4ArR2MwWqoD2j+TPGW
	PdSdrYsmlk+JiMHeswDUGBDPFNXVSe85ert6nDLFG+VAB7ks0D6hWu3Edb1fI9FHfkexsn/9E9u
	6hB/yQpaju5GYaI5E2f0Z8qyoccirNMmbW+NXEkdAX7coaqtWNueCucUBy6qKHPXNR+VLF+0FVz
	FeQdkKfvnz1LHOyeKLqLjWVhxUnIHP+Uf3SPWOwqcdSF+4HslD5Cw706Vs/4j0jPp0fiE2L47Fh
	8ElT7qip83eUMXVct4d7XqksYopNCc9vWtB+KeWHMsDZmsjJzyqrerhJZv/uIzY0mZ5fPXORGZf
	ObCIWHJthjx4WRxPQAMYCDQWwDcUuBbZapOaKFU8JO7xCajt2M8HKJCMKzVQxJjzz30fhz+M38U
	Y/agdmpkXCPz9wm+fWwteas2+fPHBOU5X7mW4VZy6dHu3kGNpwGqk7Z5zTqVblXvpBlTdZXsQ==
X-Received: by 2002:a05:6000:490f:b0:48d:ed96:e995 with SMTP id ffacd0b85a97d-48e74871c39mr807789f8f.28.1793359241515;
        Fri, 30 Oct 2026 04:20:41 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm2889544f8f.6.2026.10.30.04.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:20:40 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 net] can: peak_usb: fix use-after-free on PCAN-USB disconnect
Date: Fri, 30 Oct 2026 11:20:39 +0000
Message-ID: <20261030112039.422849-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The PCAN-USB adapter uses a restart_timer for bus error recovery
but does not define a dev_free callback.  When the device is
unplugged, peak_usb_disconnect() frees the candev without cancelling
the timer.  If the restart URB completion handler
pcan_usb_restart_pending() has armed the timer and USB disconnect
races with the timer callback, the timer fires on freed memory.

Add a pcan_usb_free() callback that calls timer_shutdown_sync() on
the restart_timer and register it as the adapter dev_free handler so
that peak_usb_disconnect() drains the timer before freeing the
device.

Found by code review.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Reviewed-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
- Restrict fix to disconnect path per Stéphane Grosjean (init-failure
  path is addressed by his peak_usb series [1])
- Fix container_of to fit on one line
- Add discovery method per netdev-bot request

[1] https://lore.kernel.org/r/20261022-canfd_check_channel_idx-v6-9-197704231551@peak-system.fr

Changes in v2:
- Use timer_shutdown_sync() instead of del_timer_sync() to prevent
  rearming
 drivers/net/can/usb/peak_usb/pcan_usb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c328564..0926e9affa95a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,13 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static void pcan_usb_free(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
+
+	timer_shutdown_sync(&pdev->restart_timer);
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -1051,6 +1058,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_free = pcan_usb_free,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.47.3

