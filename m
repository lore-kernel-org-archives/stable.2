Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8B3803D3
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753876; cv=none; b=OOLIuWxAJ6E+gM3h0Dl0q8XzyIqpZqJY/d7gFpYvXzZhgQCup08q9PbtxAsoNCMYDfvpWZ7/GURkV7F6T2TxH6UL+9Q+arB7rn3S9MqlL+9v1ZG/l+7OJdgAjEGY3MaLe4p3X7j1ulgvA6CExdFVyP/tBoRrC3acr6Q9auTHnwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753876; c=relaxed/simple;
	bh=tMpC1xzdo63lqopHFPlw01oLOuykRATWAu2nX08wIec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qr/+2SO7Gbcl/38SUi/JShylmIOfgWNdDLqcknVBQO0IlKBEHdl//8SZ1cs9KY9a8t59Px6qhVuXEe0gIHnjlZa8B4TzSYWb4zJLLlsnp792MJiRi2DsxCodo8dr08wmzjjpeM6SsYC5UVtjMBWFzFQb25AEKzlyKHsAfYdg/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0pZr/Ey; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0pZr/Ey"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47df6a5655aso402715f8f.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785753873; x=1786358673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fe47mFnGJrnj7q96fsdIDjsBMpDbZQXw/JGM6RT1ooQ=;
        b=f0pZr/Ey3JhQIvvRc3kq+T+IZnZkjDMWwHayn1NA5CcFslDkyEBcC1SAX/jW8Rbsw4
         iAXW4hyxhC9d6tLRIaGCFy/7kWhKZtinAOC5t5eY2ZhrH1SdK+86yxjq0VPcqbs+apeL
         usn5yfbROiiTiQz3xp5nFcb54wBW/ndRkxxTVYsuEkm5oY4QcqWWMTsuTlKv3LgTIe19
         GwH0HZl3n7D93iYiCsTD2ptoZZR9+/mxejKXFDQYjWryAq/F3cdcn3DwC94AmFkd7LQR
         1VP57f9Otq6SkvP6mlSTx7x8yfHnZ0TiaMhCutTfr9tlOE43DKtGSojgnWGb40+KyKSF
         66NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785753873; x=1786358673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fe47mFnGJrnj7q96fsdIDjsBMpDbZQXw/JGM6RT1ooQ=;
        b=YXBuwi5GOlYIHGahW8qGdudG+qQrbmz3i5W6bfdmbQz6dFGcWq6aFwupuewcyG9Hwh
         jiRFapSWwoofE+kOUaB0biR2yDU6hooZbaRv/dl8a8BmfUdTGt8LkT6g5ai1C4sEJ13W
         QqxZK2jC++iVwG4stVm1B52IJX5udyhXULsS44ftp+HX3oEB523py2bWAk7UY8Nlt2HG
         FigyuK/TnErzg/ckVCitWG5kJPZK+BeLhHvm+zDKXKKXrKGXronLdoFwie2XwsnfI1Z3
         qbP/HnDv1MDXJQmeQko9VxhSdYQ8IMBfz8DHMlAzS7fxxXaicrvVm1uKceak1RhyGO9M
         Lpyw==
X-Forwarded-Encrypted: i=1; AHgh+RrH/8dZpRtDcs7f/IFGOYvaz1cEzvDJQussTsXvXEleDa0YYX/k6+gMudrtMS6vyu+nAoCH4Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4dqPlZrsL+7m3vT/eBVaf3v9S9WBldIfJZdahV7wCpOuM0Jac
	8MA9WVPudLO+vgWijeEeo6z9xraMP6wkvwGaCb5McIrBTUJe3LQe/nr4
X-Gm-Gg: AR+sD110QoSQPNUulx1RX23xgLEwyb1D93jF/pA8juZCueUGiK4J2cdxp9oFA5J7VZi
	yJPxH+JPaxFXWQQlyAIepDTnOP1wcr7REyxLypOoYsnQhRkpqmkHEHTl2/lDY6dhl6SKqlHbS8m
	zLQEV56p5he7SHAVytP+662rgCrYo+QfkmfIczlvdRkUPGmHemyrixrZIDHKEh9+AltYARuOS38
	qJMENAzIcLMnIiy71FcBPooc39U/zO7YdnLeMXR+28BUsFHY4LJyr5+rh7QNpz40bV+QYWeX5YN
	VaEJdTCNVX0m1ddPXb838eTHRNzG+HUQYwt+BDksHKEVS1knmzi4uTkhMqoYGk+fiFzumkDhDDb
	zwc4bv8OR7ES5yiGzFNubEXzfykr0aPpYaSWnJEKjf4IiWIG3riZRQfrShCh9WyM60vc9LzMWQD
	QPHgQnZasASKs7UsfzDmlvQqt3QvXPqI4cXg0jWiXDa9pZYj50Mld1UBF6fPhWchZ9fxwB+UJ7b
	fxuGbfB7mgL6Kugll5vZ/I=
X-Received: by 2002:a05:600c:4687:b0:495:650b:4c61 with SMTP id 5b1f17b1804b1-4980c68e3f1mr104460385e9.3.1785753872457;
        Mon, 03 Aug 2026 03:44:32 -0700 (PDT)
Received: from thomas-precision3591.. ([2a04:cec0:101e:c128:347c:a6c3:e6c1:747])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49807b5f0c3sm199352955e9.5.2026.08.03.03.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:44:32 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <kvalo@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-wireless@vger.kernel.org (open list:QUALCOMM ATHEROS ATH9K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] ath9k_htc: fix possibly missing barrier in ath9k_htc_rxep()
Date: Mon,  3 Aug 2026 12:44:22 +0200
Message-ID: <20260803104424.25880-1-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath9k_rx_init() initialises the rx buffer and its lock then calls a
memory barrier and then sets the priv->rx.initialized flag. However,
ath9k_htc_rxep() reads that flag and imidiatly takes the lock. This may
cause the lock to be taken while not fully initialized.

Add a barrier to prevent speculative read of the lock before checking
the initized flag.

Fixes: b0ec7e55fce6 ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_rxep()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index bed7ea2425a0..97d61f3f0aad 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -1145,6 +1145,12 @@ void ath9k_htc_rxep(void *drv_priv, struct sk_buff *skb,
 	if (!data_race(priv->rx.initialized))
 		goto err;
 
+	/*
+	 * Make sure all the ath9k_rx_init() memory writes are visible before
+	 * proceeding.
+	 */
+	smp_rmb();
+
 	spin_lock_irqsave(&priv->rx.rxbuflock, flags);
 	list_for_each_entry(tmp_buf, &priv->rx.rxbuf, list) {
 		if (!tmp_buf->in_process) {
-- 
2.43.0

