Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553101;
	b=C47iFtVzSibVOSYkfHNg1b+MpyEcg8uihQKZHcS+jjiDasY6G+sh3kqD9ejVJb6j3Yus
	 ZtePVcvcXjUECB+R2GoB6LpoI7kAYr+xB0Ij1dBAvc3u+V5qCNHxVe+L7R/DPcSzr3SRg
	 qvZgCddASExtO18n9cKaT65xbBhFDB486AvdnmayEdmFlnrrhlB9FOv+hkiL+AlUP2T5J
	 jCQaSzzrcy4vjj1fAWt978FV5vS4qrX25mXNZBjRXHxTVQAhUEh+L6SzILuoAMyKf+ODe
	 kaz1uFRF1tYgBZL+X0kAfZs41UDJcZP0v2e26E8awvLBPx8NLUliogEDybA0Si+QHtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VCfGQX5Enxz7dxwKYko3XxUHVAAWfi+FllLcCi4k6eA=;
	b=wna31iPZdN6S7gFBOImGLzGsrrwnaR5Cd0XOaOiaFNCCU+n5krlkLgiiPStBMc0Q3S/C
	 hO+uKW+MaRJEPX6saU2ye632MZCt/XraDkoJ5AYHWLF44fMc/F7E3T8akVymisVY2076O
	 F+MRpqXpI8dZLBl4KD2Yh+gYIR02NBrbc+s3HMdlmCtpCrqRqcN9ApIOe6zAQZIKt0ayr
	 YkCQolQP3FKN7dm8Z51ROglXCejQHzS0r73LjletvNiA50L+Svr4IVWHllH5K8Q5cZKJW
	 Hewa0KP9YXU/XdaR2EQLVKDp1ogbw1N0WhFTqFobS2wKHx51CuxlFoBMfKb2nTJLqdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=WUujsKjv;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC53606E850
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC53606E850
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=WUujsKjv
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so175172a91.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792553100; x=1793157900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VCfGQX5Enxz7dxwKYko3XxUHVAAWfi+FllLcCi4k6eA=;
        b=WUujsKjv5ZQy/rL3LjAakUr26Y2xzhqQBXYREgAVPuPS+p2eL1rDVV25Qr9szKKlSE
         CUoos+1xWwjWfnGet9cgVTYuD7tIopXMFLYkfV2EIvnmkn2gEZJy41CBowrUpSLJAAgG
         2C4n2CdRF9cMHI4X+m+xQFHe6fIMeEfXsfsci5nFa9uyAnq42GdgwaNJwGaE+UQvy9l+
         WGh3mhswoLQJnCTshifjbfzdukLcc9nfSlD30l2zKNcpkz6W3rew36HR9/8zPyA+jMMH
         lUo0MF88914b+mwCN9Aao6iWuTytEZ45gDUngGqaJYKyOiHewti09EW12UEu4Om6G09N
         3sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553100; x=1793157900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VCfGQX5Enxz7dxwKYko3XxUHVAAWfi+FllLcCi4k6eA=;
        b=p3hqQy1jymmM9/zd6wuMIplDIB3wXyVxoJX+3eRYllP3Gaxzz8AE4qSEOBFp13LITP
         XZwRv+YJfHpt1mEvK/LjFBm2zLfvMzckfB+FwHxEvTrpI+Wq9A73A37lHv4ECOEitvfv
         u4GD+yMyc0ENrh7UmE0JYuHZEOiufNFnfQ4Oq/h2r4azQWsr8R4DBwV4CWmQCsuBR7im
         8NtEDHpYO9XHgoOE3uo/U8RY4TaKoxDOrCTvaNWW5+PxKis3Ab4punn4l00PBuokXjIF
         gSD7SoRFuW0ebsO19Fp65R1ywrracELTi618xhflCdH14RbGwqPZE1a/chh6TflLYcX9
         OnGw==
X-Forwarded-Encrypted: i=1; AKwUvBz7lJMTw7bMcUoY0T1gMiTzU3mp+EQU2s8AuovAOmlM+EBY+ogsCtpbKsRm0q46/VK3DwEtLv0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+gvsN/uDoWP9Xn6Qk1zHG2oe76fnINjZwon3ku7wgVSuOlzPw
	97x9yKaK+vra9sNwLdghcyYFvSPyHVuIwEy4D1MVm/skoPO9fdX1GODsJKThNyp13arTN17kMOP
	Y3DX+
X-Gm-Gg: AYBFou3NwvUBkykTP24Om2UHNb2FQ4680DhltRLjSMgoKuHDq2nlehtI62pfEUSQjyg
	0qoHuFphmU4mNSkbubFfzn9pDEiZLqy7ZOKelzujuDagHzBRbLbetq7avHmP2vUmYTn4GU8n+UM
	tS1RsYmuGPj/p7ApRSxJvE+gkSZ307MhXwsm44c6eWx75aRZ0a2Mn7hqwcjAD+P9VNra77ypTZh
	bWfg7dlU3uLYfR1/lzUc+AwEo8TgSa/oNTxTXgQknRht7uZUDK38cy5+XmAQz6EuPoPM8hMuHh/
	aZS//+iWVsUIPfA85gtnfe3SDVS3ITgZ4jQUcJDm+h+SYhj5sY/MDZVgl9uNltry8HXwJuTBkiY
	nzLp6+CoEgEpPbE4diftRk6QM9p5L7R4UWh3evhEvvsDuxKNa6glPC63Uj/Zxd3yM71EjnDA/HK
	vm14t8G7hvJ/2lmT9l9VATKePNfPz3paaGJUvJHGjEBtMfkbfzXnnNAivlXn+q0oZUU4k+hQbS/
	UaAI72H9VYBpiPPW9t8rERdNlJZ1cLZMlICOU1tlGIQEljxG16RnTr8zBNGNTjxtmEco05s9EG5
	VvRrm9Ga1RWEwTm8FCbNA+5NGyHEggbC+oag8tg+eUXBbhTfYG4Y5TDzSUpkmbUg5v6z2m5V3zD
	NypHvCgOMwei1QggI1wosqQ==
X-Received: by 2002:a17:90b:1b0e:b0:3ac:9a54:e3ce with SMTP id 98e67ed59e1d1-3ad86ddec88mr739902a91.63.1792553100121;
        Tue, 20 Oct 2026 20:25:00 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm2155285a91.12.2026.10.20.20.24.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:24:59 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH net v6 4/6] nfc: nfcmrvl: publish UART state before registration
Date: Wed, 21 Oct 2026 08:54:41 +0530
Message-ID: <20261021032443.44412-5-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021032443.44412-1-shubham@octane.security>
References: <20261021032443.44412-1-shubham@octane.security>
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

nfcmrvl_nci_uart_open() does not publish the UART back-pointers until
nfcmrvl_nci_register_dev() returns.  The registration call exposes the NCI
device first, so an early open can reach the transmit path while those
pointers are unset.  Its response is also dropped because the TTY receive
path is not enabled yet.

Add a transport callback which publishes the Marvell UART state and
enables its TTY callbacks before nci_register_device().  Halt the
controller before that publication.  The existing quiesce callback rolls
the state back if registration fails and withdraws it during normal
teardown.

The generic UART layer still marks the transport ready after ->open()
returns.  For Marvell, repeating the publication is idempotent.  It also
retains the fallback for transports without an early publication hook.

Found during a source audit assisted by OpenAI Codex, gpt-5.6-sol, and
reproduced with a pty-backed controller that returned CORE_RESET_RSP during
device registration.

Fixes: e097dc624f78 ("NFC: nfcmrvl: add UART driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM KASAN
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/main.c    |  9 ++++++---
 drivers/nfc/nfcmrvl/nfcmrvl.h |  1 +
 drivers/nfc/nfcmrvl/uart.c    | 16 +++++++++++-----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index baf4c781ee6b..b6f47cce0f1f 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -154,15 +154,18 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 
 	nci_set_drvdata(priv->ndev, priv);
 
+	/* Ensure that the controller is powered off before exposing it. */
+	nfcmrvl_chip_halt(priv);
+
+	if (priv->if_ops->nci_ready)
+		priv->if_ops->nci_ready(priv);
+
 	rc = nci_register_device(priv->ndev);
 	if (rc) {
 		nfc_err(dev, "nci_register_device failed %d\n", rc);
 		goto error_fw_dnld_deinit;
 	}
 
-	/* Ensure that controller is powered off */
-	nfcmrvl_chip_halt(priv);
-
 	nfc_info(dev, "registered with nci successfully\n");
 	return priv;
 
diff --git a/drivers/nfc/nfcmrvl/nfcmrvl.h b/drivers/nfc/nfcmrvl/nfcmrvl.h
index 61b3f4a4f096..5c2a5382c280 100644
--- a/drivers/nfc/nfcmrvl/nfcmrvl.h
+++ b/drivers/nfc/nfcmrvl/nfcmrvl.h
@@ -112,6 +112,7 @@ struct nfcmrvl_if_ops {
 	int (*nci_open) (struct nfcmrvl_private *priv);
 	int (*nci_close) (struct nfcmrvl_private *priv);
 	int (*nci_send) (struct nfcmrvl_private *priv, struct sk_buff *skb);
+	void (*nci_ready)(struct nfcmrvl_private *priv);
 	void (*nci_quiesce)(struct nfcmrvl_private *priv);
 	void (*nci_update_config)(struct nfcmrvl_private *priv,
 				  const void *param);
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 66803f1c6fd3..95223c20d50f 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -44,6 +44,16 @@ static int nfcmrvl_uart_nci_send(struct nfcmrvl_private *priv,
 	return nu->ops.send(nu, skb);
 }
 
+static void nfcmrvl_uart_nci_ready(struct nfcmrvl_private *priv)
+{
+	struct nci_uart *nu = priv->drv_data;
+
+	priv->support_fw_dnld = true;
+	nu->drv_data = priv;
+	nu->ndev = priv->ndev;
+	nci_uart_set_ready(nu);
+}
+
 static void nfcmrvl_uart_nci_quiesce(struct nfcmrvl_private *priv)
 {
 	struct nci_uart *nu = priv->drv_data;
@@ -68,6 +78,7 @@ static const struct nfcmrvl_if_ops uart_ops = {
 	.nci_open = nfcmrvl_uart_nci_open,
 	.nci_close = nfcmrvl_uart_nci_close,
 	.nci_send = nfcmrvl_uart_nci_send,
+	.nci_ready = nfcmrvl_uart_nci_ready,
 	.nci_quiesce = nfcmrvl_uart_nci_quiesce,
 	.nci_update_config = nfcmrvl_uart_nci_update_config
 };
@@ -147,11 +158,6 @@ static int nfcmrvl_nci_uart_open(struct nci_uart *nu)
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
-	priv->support_fw_dnld = true;
-
-	nu->drv_data = priv;
-	nu->ndev = priv->ndev;
-
 	return 0;
 }
 
-- 
2.43.0

