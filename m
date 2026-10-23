Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785245;
	b=5Cuo5acr4uL4oFDgje19SsBocZvikYI33Gf4TC4eMiKs0ZIEYpQE7mXsbdj1ugdqWeQe
	 hk24cRktxIWvhoV9ixiE0JIhLODdGFc1i94Ho4qnzgrROqCtSjsG2wPJKHyeHP+bvtwNZ
	 7wJOWIK37UsvRKfyuGVkFmC27dCNxX3cWfbcSciPTCusFg+l6hte8UWjoalRx3sCbXihx
	 qsXD2dqi/nQ6LeUwW4c6gOUAph8BoXYfwMpLeJDJAMz1PMbThK1fgQl3HCKMTwXF3SWw0
	 939pC2XwqF+0u0GgHYG0JTxcwo9j0qb3wZMfyGGy6tzCK+8SvFVNH/oJZa38k9kt26Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y/sybD6YF8pEOR4iuvpSchqYgceX2IuNdq94snnQsys=;
	b=OMe6l6DvhdAEYDTYvtab9ao6Y+dXUdg85UM/POw8op6ar0PV3fhjQseW0lsyw9WNn9T2
	 Cqin277MawkLZ5zfa34R/DTul+YL2Ay3lRjVUp0elH7etdLi0diPzKKIJiQyjOBXYPkVs
	 cWYaiJR0NGjTG30KnGB5V1fc2Be0U+SU4RPGdRtu0PzCb2EaBWdgwp5iTdc73ZvCNVUE8
	 YGvJl1OO9Y29S+sKfUPMD3Esi/JnLO8rTOaI10ENJA0lCYiiX8qoiQ8jMtv4Nzj/66KMC
	 lFIfM34bGPV3X6N9PXrABrbswzdg62TLM5kV3oJJ7fyn/jAG6JvwVMTB39d9lEAtAdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kDO2j2Uw;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB969606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB969606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kDO2j2Uw
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso876527f8f.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785243; x=1793390043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y/sybD6YF8pEOR4iuvpSchqYgceX2IuNdq94snnQsys=;
        b=kDO2j2UwWFwvGWxii+D/B2dwST5vOkMFB6995qrsjTpInhR0p6cgLFf4Lf2aWKB/8X
         f+EKWq/GcAckmE/XvZ2gRMPLfLy1i6JWD8Jvp5GDw+SO4PRkMdymfp5W1J4iMwjoKCTA
         XHmuL6M7JJrIbNM6LD+GNe/+i81Lj0UuFBb74ghiyyYdlix8Hnb8Wv9Xh/GGp6ZWaxVX
         2p2eUhWIDjE1AeEUdNk2e2i2Cvm+fUdWgkJF2dinLCopnrFwe6X7vxwRlfw4NX7HPsjt
         ImP2VGg/vPvAJhmJaNrznreRs1+/6m/sXheKiTH8giYFD7Yf59FNO2bB7fbDqY2C1KFf
         1iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785243; x=1793390043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y/sybD6YF8pEOR4iuvpSchqYgceX2IuNdq94snnQsys=;
        b=cYWNRZTDBT9Gjq5FlpHPzSJULAqotE31OaMZ/pllffpL+VbO1sNWjBkyaNLPOKqNHH
         vIU0Qp0Ptlgoy+VxGL1AwM2RbMdPHskpUSXseUwB2AqIwqq1jOI2EylZyufJwCbuYk7K
         DTTRwKCD01RRtpXiY907AMErBRTTX6rDGcDsKm/hJ/aFNfKajAVJdWvHAzLp6BTsvFUz
         ppwsrHWacYdd6rxcGF9aUyrS7g1Fwk4jSLTISJCHTMryxgzXboFMFcpD7sJX3fuUlYiX
         UK/vFPEaigPJWCb0wjefEhFMUFU4NcFHhTHgPVMOb0a1SyvgTt9LPgAfGY/o4OynU/0Z
         dLnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzabOxwqudR6vn92nfaH0jrLKrC3OGp310Kuayx6N+vhy5VeBqWb3YcSkc9xFqnapdR2zGIpgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKizdzvcBrNVa5G/ef0JfNM1AN+Tq9ozDCbMrTenpZ0FMTdoour
	O00Rp/HAcJONrbvncYKfp7GL07yH855+D2yIglzIMfyN1xYuylYsVSs=
X-Gm-Gg: AYBFou1CljLkTTqGuZhhoiUOSwxsgcClbwW2bn2CTyc0FcqYLMMBJkG7Q3lD7uLkzxU
	TFCpqlK9qFk1TgsN+uZjYBVhxHIxdc083mHBb9q8gSuKPm21Y6ART11A8OvPJpkSZwwSjCAP3AH
	v9qpuLtW45ZC4O6T6htqgRGmAdNplECsTXLbhURV7VhSzSx4MQhzaZjf2D5DqkpO7Js5hMNFBSi
	GBnNYm39ItfJMyHdM/3XqoVMWNL15G9H+nqHAz32xV52O8F6kqxbTmT05zKg5OHXjBw37nYoLnK
	p0dOyTmdvGfqv3gvnH+hwYwHVhoXoXPu9orbNwXQlRbiNGlekAio8nqio1t/2qJIGPxcKJ0i0ni
	mwWV6ix705dWoK9p9iGVfGz1C5ZWqhttPNEt1CGBrInJliQBhPPr/5SvrcBtBL/pIVGomzZGofC
	fZNt0mAlZ7UKqN5cQ6oil28IXBUrv8pzbxVez1tqkt+XM3cPfVjyCkR5qI8gjBX1K5pnCUoIFHR
	toNrIZwbkDJaRy7Z9DwNDoF
X-Received: by 2002:a05:6000:4011:b0:48d:c29e:40c3 with SMTP id ffacd0b85a97d-48e3eba80b2mr57511f8f.33.1792785243224;
        Fri, 23 Oct 2026 12:54:03 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece13aasm32783f8f.58.2026.10.23.12.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:54:01 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] can: peak_usb: add missing dev_free callback to cancel restart_timer
Date: Fri, 23 Oct 2026 19:54:00 +0000
Message-ID: <20261023195400.3531721-1-tristmd@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The PCAN-USB adapter uses a restart_timer for bus error recovery
but does not define a dev_free callback.  When the device is
unplugged, peak_usb_disconnect() calls free_candev() without
cancelling the timer.  If a bus error armed the timer via
mod_timer() and USB disconnect races with it, the timer fires on
freed memory.

Add a pcan_usb_free() callback that cancels the restart_timer,
and register it as the adapter dev_free handler.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c328564..b0b3c76b2ccb8 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static void pcan_usb_free(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev =
+		container_of(dev, struct pcan_usb, dev);
+
+	timer_shutdown_sync(&pdev->restart_timer);
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -1051,6 +1059,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_free = pcan_usb_free,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.47.3

