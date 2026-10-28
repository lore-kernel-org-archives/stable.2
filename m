Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197262;
	b=SGB3pMlmw+C9uh6QJYBw1FpzgR8TmsmIQ6822ljG5lAkLhS7TqXq6J5fHQ4KlJ3q56Pa
	 fUzRmsg88jto81r6sDQgU2zYNSVr4Qr5B2/0kzICwvFwtaswbHviy01Zv1Oem2KmqWi/2
	 83SdAQmf9jnxSFJV4krV3Ka+UuNJBgyHsLggtHAyhxuqV554ffafgFKEmcC3mTiQ8PNkm
	 CRLqHZFG74NDt/jloh8bNrMIsm7ERdoww51+H4acJP6pnjrEugJ0rmOoQxRYs1n4ODlmL
	 xdMxehEIzS4AI7JuCeRoyT2u0toUJ9xLAYCndqReGrpWBNtD7ieV+kwb7UkW7ZGGMtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qwRMYLppqpZ4JvHW9o9Mj3PLiFTrNWGk39CZa3Pb7gs=;
	b=d2VdEvqhLQqXQzvtv5WzPKWDuStTRqQX8qao1iOru+oeJKYlCFLjoBFR5AmMZ8Dj5Evy
	 ZoVi6H1fErHUa9HTqv2Wh2b/c365OCRa/xINWxj/bL03g5BQ/Y9fTZf5aLH9xRm3sPNtV
	 OqnzCg1rjTaC5WUQg48D9QBEHxVUYgwEGVY9qGMNN36hp3tbGl4YCnd9BVDQxHQM45vyI
	 j/m+jjrzKJo8xOk3TLfnClonQI+NPxaVAHbBqPhbyRtyOMmAWUswRZv4pQHQ0aXc3tEIf
	 G9wMRsa3XzTngkSndpA89rLtZ1V5lI80tCAUDSq9OSqEfwoOAyIkFN6XISo99I/Cz+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k1mg7UO0;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1145606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1145606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k1mg7UO0
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so514120a91.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197261; x=1793802061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qwRMYLppqpZ4JvHW9o9Mj3PLiFTrNWGk39CZa3Pb7gs=;
        b=k1mg7UO0O2KR5JkYyKQFxUPs5xS+KdpIt/bw8zhkPJY6wyXXch/BqY7ozlkBOmGasR
         RQD5NeiKBPGYHz0XHnSxdh31gVpzRtXmR3OivKFZZluuq/Jj8dokLIQADH8U2AjYG9P8
         1mxy46QI6WptBzkrKjkOB9kE/KIYOEL28mkfxCEk4cu1KLsR6Q2c8mg5H8jELOWxpH5I
         RE/0idxG9UKk34+fsXVIMAcD5Ynv8UaFO9KPawtWWDgqmaJDr7vZ00yaeDM5pcgQ6PdU
         gSqhUyrIsSd3KXLujbotu8wsXwveiZWloOzrIbnxCRHqv4oJy8zpQrgg6myxzTjrfcDZ
         diOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197261; x=1793802061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qwRMYLppqpZ4JvHW9o9Mj3PLiFTrNWGk39CZa3Pb7gs=;
        b=XWjMcB6o9NliD+ZDDoZezA3In/33lOF0ERspSAiiK6B5cRiXY8rf2kP57gApkaNeAX
         ChZ3siaoNWIh1bHhdWSUqcTg6CUSChY+nA4Be0mU7+ddVF79qT2G5SRmKk6d/POEH44u
         8+dCOGKEkX3QPGtQgeudSs01bq/XWMq5X5VMUIUzb1i4xrn29k3TpxPeGOf/Pfwfkczq
         yk3Yuu4ICO5ppBEuVm7Q0ePxfQ7NSR/MS1mlajPQmCFqq5poE6/8AuUZ0YNJe0q+0Pbm
         BPE+c2dS6ho+Xc/Z+ueTa7goAf0KcJ98xBAtb4G6g9fCTR6dtGz3BmtYMRH3GC16UIQ3
         EEHw==
X-Forwarded-Encrypted: i=1; AKwUvBwh/W8aDHZHrKb+Jj0Vo+FHfrb6JJKSBwqnNuiAGjfQBIY6uD63N2/xUhdLFu0+rqCAnegFMMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhdXYUBUZbn/ec0d91mZjkd9m1MYyX+fxn4wpwDSFqivVbh4Xp
	rD4cCSK89prKW4Q7U2N2xsWTxpndgpQm/oyON4N8pRlAv/wscc4dllET
X-Gm-Gg: AYBFou14qDZdd3Nn3tMAw1lXlUhPLIsMEa+dA4qbPehRzLhgD5UplbzvNtyiipxO/xX
	o0+AueyeWjxnX9O18KWKrMASMlBvvliCxp3ICJhMdqtFzEQfbVAO8Vtk8er6aA5rsWV9SYXrdMf
	2+dAMNRUyRINNF5f5o2gssmobKB19nMlZe8Feouztm/UVZBho61rAI6+9v/fnBypl7OIYQPlRGT
	o0Guedkbm0/9wTIffs5QbmPYiCWMR2sxaq+yARWFMMSYn2tedPRLv9GYPC/Vnp9lWde/BXPv4ua
	5jp54fcgYLdrbe15zf990zO4v6J7OtiS8MfXgJxJYyc+sxKWVmO+EKYV4ibptBcbJ89v30Prsq6
	CD+/E7zKAyRWxG9WwLF1/35jhuvdPJB87jBUZvn9/yjniiETR7uucUc6Q6DGbSbccCFmuZwV0f9
	3pOGFOR/vOTrkrrAJJj4iAvfNmU+WUnULvqQTzcEQ7A0+qu3XoQJPDtz8aTZnALx/3kx6Jxb4aD
	zOw06ErnvRFLsTnaH28Kmuu9LoqaC2hl5zQ/jxafR9XqalCVnoxYHEeWJ1QqvEb2jnysjN2799j
	GYGzRazxk+UTHZyrXGtuSDSJdYFpQG7y1H45y7ZKU2Kz+eek9NB2rAeTQOjGWRN5OpeY
X-Received: by 2002:a17:90b:4c49:b0:3a0:516d:9f88 with SMTP id 98e67ed59e1d1-3ae580cd137mr1917344a91.26.1793197261055;
        Wed, 28 Oct 2026 07:21:01 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a501083sm3765987a91.8.2026.10.28.07.20.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:21:00 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Stefan Hansson <newbyte@postmarketos.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ville Nummela <ville.nummela@kempower.com>,
	Jeongjun Park <aha310510@gmail.com>,
	Fariya Fatima <fariyaf@gmail.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Amitkumar Karwar <amit.karwar@redpinesignals.com>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: rsi: stop coexistence TX before bus teardown
Date: Wed, 28 Oct 2026 22:20:15 +0800
Message-ID: <20261028142015.10717-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028142015.10717-1-enderaoelyther@gmail.com>
References: <20261028142015.10717-1-enderaoelyther@gmail.com>
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

The coexistence TX thread can continue using an RSI bus after disconnect
resets or disables it. On USB, interface cleanup can also free the shared
TX buffer before the final core cleanup stops the thread.

rsi_coex_detach() only stops the thread from rsi_91x_deinit(), after the
bus has been reset or disabled. Its stop wakeup first drains any queued
Bluetooth packets through that unavailable bus.

Check the stop request before each queued packet. Stop coexistence TX
once HCI unregister has completed and before USB reset. Also stop it in
interface cleanup before freeing the TX buffer so probe unwind is
covered. On SDIO, stop it before chip reset and function disable on
disconnect, and before function disable during probe unwind.

rsi_coex_detach() still purges and frees the queues. The repeated stops
are harmless after the previous patch.

LLM assistance was used to find the bug and review.

Fixes: 716b840c7641 ("rsi: handle BT traffic in driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: W=1 module builds with MODPOST passed for every prefix with
CONFIG_RSI_COEX enabled and disabled. The series applies to v7.3.
Not reproduced; RS9113/RS9116 hardware was unavailable.
Sparse C=2 passed. Smatch across all configured translation units under
drivers/net/wireless/rsi introduced no new diagnostics.

 drivers/net/wireless/rsi/rsi_91x_coex.c |  3 +++
 drivers/net/wireless/rsi/rsi_91x_sdio.c |  3 +++
 drivers/net/wireless/rsi/rsi_91x_usb.c  |  2 ++
 drivers/net/wireless/rsi/rsi_coex.h     | 12 ++++++++++++
 4 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_coex.c b/drivers/net/wireless/rsi/rsi_91x_coex.c
index 023c539fc384..de2a973873ef 100644
--- a/drivers/net/wireless/rsi/rsi_91x_coex.c
+++ b/drivers/net/wireless/rsi/rsi_91x_coex.c
@@ -40,6 +40,9 @@ static void rsi_coex_sched_tx_pkts(struct rsi_coex_ctrl_block *coex_cb)
 	struct sk_buff *skb;
 
 	do {
+		if (atomic_read(&coex_cb->coex_tx_thread.thread_done))
+			break;
+
 		coex_q = rsi_coex_determine_coex_q(coex_cb);
 		rsi_dbg(INFO_ZONE, "queue = %d\n", coex_q);
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index c5619a34940d..87108f4a4326 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1080,6 +1080,7 @@ static int rsi_probe(struct sdio_func *pfunction,
 	rsi_kill_thread(&sdev->rx_thread);
 fail_kill_thread:
 	rsi_kill_thread(&adapter->priv->tx_thread);
+	rsi_coex_stop_thread(adapter->priv);
 	sdio_claim_host(pfunction);
 	sdio_disable_func(pfunction);
 	sdio_release_host(pfunction);
@@ -1231,6 +1232,8 @@ static void rsi_disconnect(struct sdio_func *pfunction)
 		adapter->priv->bt_adapter = NULL;
 	}
 
+	rsi_coex_stop_thread(adapter->priv);
+
 	/* Reset Chip */
 	rsi_reset_chip(adapter);
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index 99e029e66407..f8b5c264a8a9 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -563,6 +563,7 @@ static void rsi_deinit_usb_interface(struct rsi_hw *adapter)
 
 	rsi_kill_thread(&dev->rx_thread);
 	rsi_kill_thread(&adapter->priv->tx_thread);
+	rsi_coex_stop_thread(adapter->priv);
 
 	usb_free_urb(dev->rx_cb[0].rx_urb);
 	if (adapter->priv->coex_mode > 1)
@@ -896,6 +897,7 @@ static void rsi_disconnect(struct usb_interface *pfunction)
 		adapter->priv->bt_adapter = NULL;
 	}
 
+	rsi_coex_stop_thread(adapter->priv);
 	rsi_reset_card(adapter);
 	rsi_deinit_usb_interface(adapter);
 	rsi_91x_deinit(adapter);
diff --git a/drivers/net/wireless/rsi/rsi_coex.h b/drivers/net/wireless/rsi/rsi_coex.h
index 2c14e4c651b9..cdd83650c5f1 100644
--- a/drivers/net/wireless/rsi/rsi_coex.h
+++ b/drivers/net/wireless/rsi/rsi_coex.h
@@ -29,9 +29,21 @@ struct rsi_coex_ctrl_block {
 	struct rsi_thread coex_tx_thread;
 };
 
+static inline void rsi_coex_stop_thread(struct rsi_common *common)
+{
+	struct rsi_coex_ctrl_block *coex_cb = common->coex_cb;
+
+	if (common->coex_mode > 1)
+		rsi_kill_thread(&coex_cb->coex_tx_thread);
+}
+
 int rsi_coex_attach(struct rsi_common *common);
 void rsi_coex_detach(struct rsi_common *common);
 int rsi_coex_send_pkt(void *priv, struct sk_buff *skb, u8 proto_type);
 int rsi_coex_recv_pkt(struct rsi_common *common, u8 *msg);
+#else
+static inline void rsi_coex_stop_thread(struct rsi_common *common)
+{
+}
 #endif
 #endif
-- 
2.56.0

