Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620155;
	b=fb+EvQNoflhUWwRSTV0KrbxGvbOUbJ0c77sesOQkzgfvZyCYWgpmuOrsXoOs/fJ50bq1
	 OfPFMXIUQ5QFJPWcxMKseYMA9xsUCuF/aOJFh5FpCHiyada9z9kcl5C931Z5VkDxS3NSg
	 JsN3qwNLS/F3zhyMnw1XkAYHPsvQNMbbi2Xvt3gKfM9TFEXxce7bvhbiDoQAJdWVotgYE
	 KFwKh3HPOhba9TlegVO0HravCUTe5EE7iMax+PQRWtUXtGDD+24vkMdxKGKD1z7XLyeIb
	 +qtg2D0VGCAPiHCpO2o8A5tiEgfTsEpaOHe3fkk1xYPGRfQmN5872VMkmnaF9S0Qm2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m/P+s8e9LEiFl0Qu09s+H0T52nV18YVsV7Iu8lShA6E=;
	b=MZT2T5VulZrrU6p3hQCWeoBQ9g67arXy5JVGigbeKVaBjcIxMq0VOSYFIKTrdtEl7bZs
	 wbMPwRWHcqNla/Aw57irNROmRz+AHiL0OF0/YpcGEVX/TxYK7ZLyvi0ulZ/+9NHFsYewU
	 Eb8bR3Db+O8SN1bphWm47wr5lZJ8sBnBoOa32E0XHscTxrD/jjppTdk5i0h6lkb1B0g4L
	 2iDwhZfiD0iA8BgEULN6MzD8UZD1EofdyQrK85Ygnxy2c8eML+FHLyTNwfi3UOWPRx0mT
	 vqZrmVyRfO6mlk6lcNKPwOHwW+m66n6T1JMTGSDlZUBYFk3UZfGzVM/LOfayGY1Cx0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oK11i/6G";
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F5606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F1F5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oK11i/6G
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a05b210703so2823925b3a.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620154; x=1796224954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/P+s8e9LEiFl0Qu09s+H0T52nV18YVsV7Iu8lShA6E=;
        b=oK11i/6GApnRKdA/Ui/DZGKRVTnYi1Zt4xvqNPvWKzZs/8Ee2w8INiN14d7atKsL0c
         xzDu4pv2ZJInhd9mE0DuA90UhSHXmP/329jlbZs8ywz87+6Tpej015n99C6altAA9Brc
         kLshRsz+OZROLRaH7pfDc7nILS9aTAuFknbRoHlm2XQytevlcZZoErtyhDd6kWfZQww6
         74ZDvFHW0zpgZtZTeF4l7nD4NDMZb0VLfEYxSWh3LM4u2lzAd7t4P07gL2oS4qfbI2kl
         1vqJbtzuLQ5YEFRd7zQbHzlvOCFvIUsu1JvFyr9P9ay1yiLEgyo0c4i01vtQQb3AXOMg
         oSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620154; x=1796224954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m/P+s8e9LEiFl0Qu09s+H0T52nV18YVsV7Iu8lShA6E=;
        b=QHgUddBsQZ7Z1tDPql1syiMe6p5mLtzboltBEBuJVwNJoTDMmHkI3G7rDR3MPLhOPN
         6d21IuDNdmMvbAW1HhM81a8ZGwyi92bOcJ2emciPTbdWGKTOg0SgS0Rr3kwZRRDHGLpV
         DfpewFh7vJHtxxrsyrOYMs+i7zN0eeMA6wKEgO7iGvpycx9pdmhqzONJJrcjaoA04yoa
         m4qiDe+K1f5Uv77w6hW45581Rld6dliwio4eqiih15cnb9KfmuNSlgeeRt7gfOz8NK3Z
         8KlYNsAyK5wdkTkL9EzW0RsRPQTX5DxStSW9dTyKlViTwJ7KZ+aMqwnjosncmpXI/9NG
         X8GQ==
X-Forwarded-Encrypted: i=1; AL+hErGDsFIU43ApqjHrX07Bz/PoBIGyb7xqgtIiQl7iCiGica2bn1w1GNnw7Nm4joARlWzNdR5BJLQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uBvjvGcQl1fd0wP4KlmgIdLQIWDiJmPiV/JzD+dTuZOeQps+H
	Uk90i6GatkcACHUw2eTpQ/jSIbj2WLSKaftUr9P/tXLkJoQmcttsCEVUfO5QB7NiBe0=
X-Gm-Gg: AZFdTZfyXFAqeKxeb5gvkpHVKVho4J5ObAxh0beDmWgh+BXthyHt7Ziyfa6Dn5Zz6Gu
	vqpHdMie5yF9A5u9Q7PO3Z2vhwY9xC19p03kDCP6leR/UaE1tahvsjituLYqd+e9oKTPMQKoSxI
	3KQ5zBXdo0nH+5U7uK1djL4ES5BFbqly9tz5+Dfvr2CmTn9kl6KZ40ESZS1qyBW26pp40Txrttz
	fSlrBMHrSddCaGIjmechjNC8DzPUdcumqp2omfWGRyM25e4CBmQiRnO9OII+OjukQ4xtdFPwIDm
	cic9OcBhoNVDgcjb9+l250gIq2BDjl6Ss1J34vTaKFvldw+j2PwSWR1ks/HKomSO4SUcGZEo0V+
	lrqGnwNqpA/IKTvMK5AbB0MRJToZmoYVL0dGjqYuczottIDf7al4c04x9RqbPiPW6FxafVKs9lT
	Q/hLAj8VJpCV27CYuxutUJkaqmtNhxzOEb8i927UYLDBN935w1umywvekzuf5r71/pbLg9Fw6A0
	/00DZDJmkaSsbI1MNFnozEsuk9U2rAI2Xn+hDzZOG0O0Qvi+lOhn5qozoe6AO19K9+KtpKHBrVF
	/N6LhOwg9ERmYdWfefJWkq9p
X-Received: by 2002:a05:6a00:a01:b0:893:4980:630e with SMTP id d2e1a72fcca58-8c87c38b5d7mr14799436b3a.31.1795620153916;
        Wed, 25 Nov 2026 07:22:33 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm9221775b3a.8.2026.11.25.07.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:22:33 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/2] Bluetooth: RFCOMM: Reject listen after socket shutdown
Date: Wed, 25 Nov 2026 23:22:17 +0800
Message-Id: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-0@gmail.com>
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

RFCOMM drains a listener's accept queue on its first shutdown. A bound
socket can retain BT_BOUND after shutdown, however, and the listen
state check can admit it as a listener. Release then skips the accept
queue cleanup because sk_shutdown is already set. Queued children can
retain a pointer to the listener after it is freed.

Check sk_shutdown before entering BT_LISTEN. The socket lock serializes
this check with rfcomm_sock_shutdown() setting the flag.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lkml.iu.edu/hypermail/linux/kernel/2611.2/24606.html
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/rfcomm/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 889e45dd5d04e..86a43dc0ab5e3 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -448,7 +448,7 @@ static int rfcomm_sock_listen(struct socket *sock, int backlog)
 
 	lock_sock(sk);
 
-	if (sk->sk_state != BT_BOUND) {
+	if (sk->sk_state != BT_BOUND || sk->sk_shutdown) {
 		err = -EBADFD;
 		goto done;
 	}

