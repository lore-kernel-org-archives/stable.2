Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951652;
	b=PrLQt3GRqCkqfmbY8blX1xWwQH/YELq7FQkXZFQ4GVnG1V9/2saQNmsIO8DpMFE8vb0U
	 ssjEDxDnd2nCQlolNPLZo78W+7oqj8v8DdKihZ7zTeRUT891f7WwKRsnp4p9wHzkEYoQb
	 jg+Qt+Z59HbhaDTlTkJXobm0cbroh0+3fYcFo3D8UTw6mr2kkYWQnjunjdVuM4OAlz/pd
	 AQrfVt06i3T+xAn9VCgZ8gA74FcQOP884Ede44LmYOCUEYTHYv/+GFae/3pyMOEWhhk5Q
	 PM8CYadiyN5TbdgwraxIkOKX1x7yIgQaRkOL3CMzBvciZEc+26A6emj3ib8aXEcpVBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m0Ydq/j/RR3Dd8rFJdmc4BDtehwDcl6LEDUrs2GefBw=;
	b=hZpCZi+nCZXrmD7wRBWRzQVFjD87ktsPurfYqh0QzW0DIIC2AQO2UiDm7dpSlb0Nz/Vn
	 QgzxUSt2ttRQFClfWxeQkd0BqzN5wDHDxBSQ2jnK3/WHtNhid4KBVQNRh54xy2nV9fYAr
	 P5BrMwg3kAbRzmArw3anS6N7WF4pCmvVUhHDDThDtU89AC5TowAVvyuCPpuVBzcLujZPl
	 5hTs31EycPgoMtSxCMZ9r8vkbCjM4Vyq7jPHMfQiexdaPr2q46Y9Tuho4fI6sX+FeFW+a
	 clmbk46u6qt8PWKuYrZVBaQOzSwVLeN5wYt4R1wcWWpqBSQIJPwHmsncWaSietgX37Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YZENF7MF;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C8606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C62C8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YZENF7MF
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c45111bebso1040280f8f.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792951650; x=1793556450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0Ydq/j/RR3Dd8rFJdmc4BDtehwDcl6LEDUrs2GefBw=;
        b=YZENF7MFYp2iASoQnSKb6fMHyB+Ur17NlSLHLfambPG1WyYcjpD7Nv1gFbyFyXNvwr
         v8Bx9cG9Q/Sd8CKko9Eog/h5tkw2ArY9XeHTdf4RQU7mNXIM2yH3XbFXIEkGWCzN9IKY
         39XLZlyvqdxYPyn8uelhW9L6qDNgS9xaLZ7SkaDe4iQ2XpceC8XTpYtXZ+0HxzMZsliV
         Xziow0M5YIOYiXni0OlGZqcOdftfvWlQmjwHc1s+LqOeMOaSlM25b5lVycgjdYSI5Ew8
         ZHFyW5ss5Wa4TBKWaNhhz/3Yp8lOZUGN/MOighU1+8XSv1urwvnUoGdI2/ZvwIOKiU/S
         PElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792951650; x=1793556450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0Ydq/j/RR3Dd8rFJdmc4BDtehwDcl6LEDUrs2GefBw=;
        b=cjfgUnBSB8zStPqdyQRKY4xRR2+zc9cLtYrkuKPXDX5QPwgCunC29OeoagTHHpanL7
         Gxwi/L94rdM2fAW/bkIogrWxwWI4LRTyRW0d258zNuJnGu0UNngUi4qEW931KWH5yZc9
         8+hZodEFwsxs8K6I7fzdjibHXzb/gYJn4odCCNtIAuSDj9n+JFBoYJ5zwWQ1nPMkHoMT
         UBcd5K8DQgLpKiLE2mo+NweK3SsUtnLV7ywVbCN6xB+8JB3Quyv7ZyKo823qQwwntxyp
         njgQ98frvn/Ax0aLldxsyCnwTTFYdiW1G5DSI2j5ArfHmku/wkMq5RGZ+T3lczjFjxzl
         o8lw==
X-Forwarded-Encrypted: i=1; AKwUvBxHB4BdgVxpSawYV35giWgDf1m2M8RuI3n0RblabIFDzFtBeNXV6SGYGvtiI0sq/4uHUqRO/Ts=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1NLxkeM9QHs4DEM3MGNM5dTc4KzTehinEKAbmcQ/ho4pybkID
	+HJlWnWa6YkNdoPgk2AdEBgnqA57NB312a5yiRTtb7lh2bzG06oHXQY=
X-Gm-Gg: AYBFou1KRKKXEwasraxKziIGf2Sq4sFaB8qjQHGUKEmHkFz8nMNsWn3hDATeyIGAO6Q
	UH0LN5VRUpEP9X7csg6CaK2CQppAdaNcXFH8mrmWri29ef0QULmhIrQpJvDyjPG8CxLDTDIHSxU
	ueeK4EJuu7xUMz1fHbssoiuXh2mXvqFMIfVWTYokGq/iYeZoaQ1pVfR+JmUC0bYzCkWS2sypbY+
	v0Hle0B7MqlOkI2QpczY+qllMdjLVqKtzRin8E+1fZB6tl5MbJ6vmP5xKRF0vAQ2HMuZn0DXiRK
	Bw4EK7Qa30cOtt9mmxXf3S7/vhiiQ/E0po3l4bSFndr/ikubg+l7qpLQBFQkhlxRjarwoOjT2I+
	l0rJIJwpN3pjvSVfQlOlxj6m4ZfDqSf7waaMU9Zk0E63gudZI2LrZHF7usFLd6uwtrMjETkYM17
	r/51oCHkuv699rlad/o0JhgSlUe9HoZFWIQ29mhJfAaUHobzBOFt3KTiFmzbCIWO/cxQ2F1DzOy
	KLpSwKC5f/tCj4IlJQae/8xOaPEsLaaKlGZe00=
X-Received: by 2002:a5d:5e0a:0:b0:48d:f957:bca4 with SMTP id ffacd0b85a97d-48e3eba18bamr7432826f8f.44.1792951650070;
        Sun, 25 Oct 2026 11:07:30 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f37csm9333778f8f.8.2026.10.25.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:07:29 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	amitkumarjain0211@gmail.com,
	siva8118@gmail.com
Subject: [PATCH wireless] wifi: rsi: shut down roc_timer before freeing mac80211 hardware
Date: Sun, 25 Oct 2026 18:07:27 +0000
Message-ID: <20261025180728.3678113-1-tristan@talencesecurity.com>
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

rsi_mac80211_detach() calls ieee80211_free_hw() which destroys the
ieee80211_hw structure, but the ROC timer can still fire and call
ieee80211_remain_on_channel_expired() with the freed hw pointer.

Add timer_shutdown_sync() in rsi_mac80211_detach() before
ieee80211_stop_queues() so the timer cannot fire after the hardware
structure is freed. Also add a belt-and-suspenders shutdown in
rsi_91x_deinit() for the probe-error paths that call deinit directly
without going through rsi_mac80211_detach(). timer_shutdown_sync()
prevents the callback from rearming the timer.

Fixes: df771911914a ("rsi: add support for p2p listen")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 3 +++
 drivers/net/wireless/rsi/rsi_91x_main.c     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 3faf2235728be..90b0fb80d91f8 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -301,9 +301,12 @@ static void rsi_mac80211_cancel_hw_scan(struct ieee80211_hw *hw,
  */
 void rsi_mac80211_detach(struct rsi_hw *adapter)
 {
+	struct rsi_common *common = adapter->priv;
 	struct ieee80211_hw *hw = adapter->hw;
 	enum nl80211_band band;
 
+	timer_shutdown_sync(&common->roc_timer);
+
 	if (hw) {
 		ieee80211_stop_queues(hw);
 		ieee80211_unregister_hw(hw);
diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index 2ce5147666208..e893bba868b72 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -419,7 +419,7 @@ void rsi_91x_deinit(struct rsi_hw *adapter)
 #endif
 
 	common->init_done = false;
-
+	timer_shutdown_sync(&common->roc_timer);
 	kfree(common);
 	kfree(adapter->rsi_dev);
 	kfree(adapter);
-- 
2.47.3

