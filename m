Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795060985;
	b=RD7QvAMMbLqZacjGt7U8lsc22F4eZtlJwcG0voaHDMQ0IQRu/VzUT7V+hVqDD1a6jU9u
	 33qHvVQNyYjIRKBvI/BqrPJ9+tVMwyavJpckCdlIKyvRAjLtWKoIZOI2gnjOUyS50hS0m
	 +7WcL9t46h5drora91mHRxywUUNk/F255kdP98ZNUoVS841PkHbr0R70PG6o4trcNJ+qm
	 AqztpgzQW2JD/2FhgFGsTuOkRvQoTDQ8tGby9SH/7NMCFZh/HpD0FLzZySLKuYDDYI9C3
	 4LLnlq07/r6R3Q+tKwJQ/DOVK6gtTcA1BSe/7r/2/PQnLwHDNFlKvjFrXiOjUXF0zIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795060985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uJTeJR5eoOxAAfYNVIbKciM1+UPVngasXpXnnN+uSGo=;
	b=ZWm1l/E24EQ+FIVEPH19MTYBPJZ7G5dxpoC146znbdVPUtnm1ObtOxrQ8zIKMHMy0R0w
	 6GUtVyBiAf79/mh07s4Abf5OjLi2FSRP1pLPdXXC0wJvaZGpPzWM3F9gLKxrkPR+7fGzB
	 ZT7vFaik2NVfwmZcnkMTilj1J6Ics0JnnDuSsp+hnINxyR+Ooa20ONpobz7lGmGXl0pnG
	 PpY2PkuQNRL1mJ0FTT0AeFQ7Wy/zfN6SyTC3k+yOpN6CrdmAr3AUrYuMPDN4QxB++a9Ka
	 Y5w6Dq4KaShM/k8ZTfh9l8Et2qyI4n6edDxFeHC6KYgIj8hlSDUpEPWH3/UNwUnl8Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b="q5yBZsL/";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9FF606A331
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B9FF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=q5yBZsL/
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b3d4d3bba3so978704a91.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 20:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1795060984; x=1795665784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJTeJR5eoOxAAfYNVIbKciM1+UPVngasXpXnnN+uSGo=;
        b=q5yBZsL/8yJqOmoc/FcG5Jj/8qa8rEUK/0dN9HZn0wfTASOKJYgl5qB/7FCPvWwrsQ
         zmOWZoXqjAZdykBK8EODOOXC9wMrj+Z9QEK/67J8H3TLYCUtm6MspNiuVLrAJxDvhtDr
         xULCDb+PmbPs9+JqZ3rDVp7BwdThJsc4XoMqcHVj45AHX6XFN3QBzCG4E2gb6GKCd9IL
         TnItF5E+paR3hkiDw6CkqSlS9kJL3WCJFuv6NGGQGUmYGoQtb09asicA87rFe39tNPoP
         5SNHbsHtS+/fzdWhIqLD89grrj584OhZ/74xa3Q290fLPavvovay4KPTENP5emdM6u2D
         eAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795060984; x=1795665784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJTeJR5eoOxAAfYNVIbKciM1+UPVngasXpXnnN+uSGo=;
        b=0Lq6pGwhbBM6rd+F9y7oXTC5rPe7/Eqgafj7dt57QryerbuNyN+BGCmkW+Htvu2ciL
         OWxTsKE9PG2gsAaOU3x9PEI/w/YhpqNGFb3QPIpfdHArTO4mPzLiSY20qY5EKktEPGnd
         aBzUMi3YACYoDqInn5dqP/siZeUVzZE3kt+7w5LYHm4RO+FB2rkWKWdFewzXFB2EIZIF
         ZDrrXHYrvcxwTryLpozSeytvh8tYpI91gvCw5+O6tad7E01UJAeFT32JM/7W/WTd38eQ
         4FACSM4aBw1fd5uYjc/8SnU+GBbElvGHuQy445os0QEOdYsE0boHqWVNdSe32Igi3EFe
         2qdA==
X-Forwarded-Encrypted: i=1; AL+hErGI1ZifxfkLzaJmbNgUFdQRzNm7wBiUFHTt7Ue8Sd/YDMCkrqAA53rBfhsXnHL30PSkfMx4A60=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AkPfXlJfAWrSaHVzAlhYK7glfA+gmjOhkmdQ70DI9AL+nJwMF
	6vbQL1ev0ZY7AdzPR0NZGd9bFmCedwStBqWpiXUITNBHTfwLqs9R8Krd7N1bc4QAL0w=
X-Gm-Gg: AZFdTZf76sP0tTngMJvUUVSnu0NSTySaAJhTcnGb3tlGBicCtgC7rq9exlkNXSKtYyK
	+3spyBOYoo2BO/KmT8b4xjZiVc3oGCEx4Kno5Ulai4dtjfUHe3IKbfNLBwCY/pIwy38XD+0Foth
	JiNJbLLg7hUAxQaJp90asMtM3xhY46UByjZQGVcICzduX4ogl1e+BV929fxp3qsWLZkwV/0TLV+
	1c7DLB1xAraO4LVwfuqiGpyRf08oYYOjcZ81Ed+EJVPZH5rjiNTERtSEDJICi8865GmhaQYH+bH
	CERiX5hXsuH8xSnMfwoVMQOEMPj5aE5fAB1kCZ5EQUdQY4wvt0LUW9iCiIb3R4JJkGqXKS0NzhE
	gveo8MQha0Z3qa3VQfekTXptNe3lnGhFmdEjl2xPl+RSAq0J+i4cWleoIWeNIi4/6feC7ZhU73z
	vGKqGIG1M50CMhGHD8XZc3d9Ic1PCQV9WSmVeEZmMyBVY/KRj0VoajI+8oiZRwBvnVLT7mr1a7y
	MxDHQbk/5Fo1jNDEK4aBHSz4DC5P2GayfNCmXxahKyfU34C9KKAuA+lZvJP++iVBpq/JwQYg6UD
	vjTRZGTpmz6iqGTxCYUeEP5yXUvPLk0OKvsSGq0Nb/G8HNOX860WiocXG5Wrdf/h0R1p+sX0m6M
	xMv2qD2twiTD03A0pgY2z3tM1sj/rI9EtPWez0JZbNMqf/HE/gVM=
X-Received: by 2002:a17:90b:448b:b0:3b0:9782:8721 with SMTP id 98e67ed59e1d1-3b3d07b9f34mr4659096a91.36.1795060983787;
        Wed, 18 Nov 2026 20:03:03 -0800 (PST)
Received: from localhost.localdomain ([103.207.175.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4057af4e2sm406863a91.7.2026.11.18.20.03.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 20:03:03 -0800 (PST)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	david@ixit.cz,
	horms@kernel.org,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH net v8 2/4] nfc: reject overlapping firmware downloads
Date: Thu, 19 Nov 2026 09:32:51 +0530
Message-ID: <20261119040253.15986-3-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119040253.15986-1-shubham@octane.security>
References: <20261119040253.15986-1-shubham@octane.security>
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

nfc_fw_download() records an asynchronous download before calling the
driver, but does not reject another request while that download is active.
If the driver rejects the second request with -EBUSY, the core clears
fw_download_in_progress even though the first request is still running.
Firmware frames can then be routed through the normal receive path and the
device can be brought up before the original download completes.

Check the core state while holding the NFC device lock and reject an
overlapping request without changing that state.  Keep asynchronous
completion lockless because drivers can report completion while holding
their own locks, while the start path calls into those drivers with the NFC
device lock held.  Nesting the device lock in both directions would create
an inverse lock order.  Use one-copy accesses in the completion, receive,
and transmit callbacks, which cannot take the device lock, so all contexts
observe the state without a data race.

Discovered during an AI-assisted source audit using OpenAI Codex,
gpt-5.6-sol.  Patch development and test planning used the same assistant.
Confirmed using an unmodified kernel and a pty-backed user-space controller
which issued two NFC_CMD_FW_DOWNLOAD requests and checked that the second
returned -EBUSY without disrupting the first; no error injection was used.

With the final v8 fix applied, 105 first/overlapping request pairs
passed under KASAN, UBSAN, and lockdep, and 105 pairs passed under
strict-mode KCSAN.
No in-tree selftest covers the NFC firmware-download path.

Fixes: 9674da8759df ("NFC: Add firmware upload netlink command")
Cc: stable@vger.kernel.org
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/main.c |  2 +-
 drivers/nfc/nfcmrvl/uart.c |  4 ++--
 net/nfc/core.c             | 13 +++++++++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index 6efa83219..b9b66127f 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -205,7 +205,7 @@ int nfcmrvl_nci_recv_frame(struct nfcmrvl_private *priv, struct sk_buff *skb)
 		}
 	}
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress) {
+	if (READ_ONCE(priv->ndev->nfc_dev->fw_download_in_progress)) {
 		nfcmrvl_fw_dnld_recv_frame(priv, skb);
 		return 0;
 	}
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 9aedd1687..4b989fc4e 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -159,7 +159,7 @@ static void nfcmrvl_nci_uart_tx_start(struct nci_uart *nu)
 {
 	struct nfcmrvl_private *priv = (struct nfcmrvl_private *)nu->drv_data;
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress)
+	if (READ_ONCE(priv->ndev->nfc_dev->fw_download_in_progress))
 		return;
 
 	/* Remove BREAK to wake up the NFCC */
@@ -173,7 +173,7 @@ static void nfcmrvl_nci_uart_tx_done(struct nci_uart *nu)
 {
 	struct nfcmrvl_private *priv = (struct nfcmrvl_private *)nu->drv_data;
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress)
+	if (READ_ONCE(priv->ndev->nfc_dev->fw_download_in_progress))
 		return;
 
 	/*
diff --git a/net/nfc/core.c b/net/nfc/core.c
index f52166929..b03b34b40 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -48,15 +48,20 @@ int nfc_fw_download(struct nfc_dev *dev, const char *firmware_name)
 		goto error;
 	}
 
+	if (READ_ONCE(dev->fw_download_in_progress)) {
+		rc = -EBUSY;
+		goto error;
+	}
+
 	if (!dev->ops->fw_download) {
 		rc = -EOPNOTSUPP;
 		goto error;
 	}
 
-	dev->fw_download_in_progress = true;
+	WRITE_ONCE(dev->fw_download_in_progress, true);
 	rc = dev->ops->fw_download(dev, firmware_name);
 	if (rc)
-		dev->fw_download_in_progress = false;
+		WRITE_ONCE(dev->fw_download_in_progress, false);
 
 error:
 	device_unlock(&dev->dev);
@@ -73,7 +78,7 @@ int nfc_fw_download(struct nfc_dev *dev, const char *firmware_name)
 int nfc_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
 			 u32 result)
 {
-	dev->fw_download_in_progress = false;
+	WRITE_ONCE(dev->fw_download_in_progress, false);
 
 	return nfc_genl_fw_download_done(dev, firmware_name, result);
 }
@@ -104,7 +109,7 @@ int nfc_dev_up(struct nfc_dev *dev)
 		goto error;
 	}
 
-	if (dev->fw_download_in_progress) {
+	if (READ_ONCE(dev->fw_download_in_progress)) {
 		rc = -EBUSY;
 		goto error;
 	}
-- 
2.54.0

