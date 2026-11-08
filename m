Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141876;
	b=U029DUbwIF1v9Yr8xNQ0OB1wTlBzYZWdXbcMiAWyiwYJs4MGu3ezFzn3XvTab4UGzKy4
	 VcZb4LXJVuqWXaxk9dn42of4wdMSz47+RKwz5IXpnsgXqbsI5MnH/dVuudkQZdeHjeKg/
	 yUncMo2a0ULb2v6PcVEcf/MhGn/8OT8Hgo72iUHTEhCsNgsiGvS48bFJCvW7saDIOza8M
	 CQrihSsRPueH1UjxrWvcaCC2aO/elsfTnH0Bl7oUrqjiU8w8PZIb2IfxuKMGsD0g6fZ4m
	 NmvQGmW/GcwoSt+4DXkISACpa0h6QnkN5eICWOee0U0kQR2NRt/vBYGKHXT42FjKCKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FPR6QflJdzk9A4OElrBpNfOAyUbhBrgQgck52AktMEA=;
	b=UbJlK6oEkTo3TG8sDBA+Q9V6p/FUPRzW4zuWBgm7q7w2btivWN5J5w4G5J7/I78QQm3m
	 h0pctuhlKJWXx0dA6Woeqy+ivdFZTc65bwsPz76YGe2j9JJK5iK9wl/QRac+e5nDIy9Q9
	 vjyNDEMxW1UE+2vJkl3aTCnKUPnukMLUs2U1MIruS2aBsAKu+Ufa/mYDVIZQgXrEMzvrH
	 NVVtmGlmzyWaS36MXRbz/gWIwMtz96NdwIQDbCaW0NYhHDrf5KoB6BJuiltMyblLlBURC
	 h9lDmkDyZcknQC7vMVKohBeIYcnmWYq/gsf2S4U2GXWLAb9bEEki7YAYXPREuoIjX3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WDwJJdBT;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390C606A323
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0390C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WDwJJdBT
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3a142c6cfso5744c88.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 04:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794141875; x=1794746675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPR6QflJdzk9A4OElrBpNfOAyUbhBrgQgck52AktMEA=;
        b=WDwJJdBTPYKg98qWxYfac7bzLCpLUyhSHTjCQxbFA9Fwjh8nqD36wcCZgl0W5Jqj7w
         nodlErOPHpwHiAr+t2dwvUYHoLjm8q9rF5SYJ9L2NJRohIWX+emRaiQREDjGJf8v2Nl7
         tdh9KR4gHnmv6cpHuMENVjOouJ7TSTYkop8R/p3IVM8fdejdufKym5b0cyXdf2QbVOTr
         M6lI3kN5W+wT3/+DSRa7I6BJV3pv0sR1wisqlHA0QJmYWnA4iM54o3SLYZI9aIZKHREp
         HICBLtOoQywIeg4COEtoa7OV4jjC2iPBh4XmHMWopg3rCFzeDNWEaO7L1JOgLGk5XsRP
         3Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794141875; x=1794746675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPR6QflJdzk9A4OElrBpNfOAyUbhBrgQgck52AktMEA=;
        b=YzZ2eCOQW0LOfOAbHfyi/kMa4GogufyEbmiigvWtXzdzwavQXQvPcacZkGcG85b53L
         swJBs1VBl6MwKQ9AKbMXkcWRUwn0h+RD4EpMlK0uUBNOPpLz0Ska4sqlHlE8VnvkM9Hf
         D6M7JLDq+oBL9r4JHtvaT1/Txddhw+ISTisICvj1ztF/GeVD0Ng6qCcgWxAMLHLCc6qn
         oB3P+MPlYWYLKMOyfoZxO8BqHwKb/Rcp3B/v/Bfk8MpNLJdLm0KiKF1s8btuO01O6AKe
         GJyUmhBSxF7rtvOyk3wII+TiO6cg9HizKJtgiEWBtBsB3of+BJKH5C6+G3cn7EEzYlnS
         l5Og==
X-Forwarded-Encrypted: i=1; AL+hErHYsrICiHXLaFRpxjI5/Pj7ONGjhJaBDizL2BUn7RRt+/z/xhgV5op6j2sn3FemmA+/S5mym/0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ai/ojTMiW8sD7ptgfSQEP3JNf67g8N6gQR7ZCpgOaCSjlEAS5
	lSYk2m9tEKbEOXyg+GF0dTwtcSHGxAnziKaurbLGVepElQWHx3VqmaQZqDSSxk7RRU8=
X-Gm-Gg: AYBFou08pAT3EK4oF4NJAOd1pURS/SRUrGL4Kls8tzoIAnuJngo4fuiiOszvAERaE5J
	fKHpDkhew25SGkmdFrtGjXcyDaDYxmXXjcodg7u1IBu1Yud8UnC8O6+zXXFAQfUVEFVRkztShro
	yy/I+QtYyMQEwNF0GJRV/tWB5aMCXm3SKlkXWHukhxzapgGD/M9L+a2cQ9O7QvahDaxSt+zdIbw
	KCzBsTDRM+PkNgSakAjdAMg6UOc++ad9JarBDgOZinB0fzWDKy2yL4MYYv5HKy458RdE/qvRNom
	gnltqphkJqvfDxR/TK4DqvjqF0IjieATNdtPB9IhYTvClbP3/jqsbokFlVyp1WNk7o/yFrlx/U/
	hmvuIG48WujY6RgIauE6pcYWkW+7lUk2PxNmRbOza3UdAGil5uzYLF86YYRBnfDkQB4Vp9V4D47
	H1QL+/5Tmf2CPpyUpFo3cIocAFHjMiC2CGtfLG2MPeLH/KKcF+FVOX9XwiFf1OMT/twnfe291Dt
	4Q5pxBgLZPzo7/Lncg2eH5HY+uk85qQPh3E0ko58ZWfO6+oTvxV8b3j6Ybr6f0Xt3577h7/hx3S
	8Vc92hhEahZwlag6mLE4Wwuo0N1SSqvv8T33tmIV
X-Received: by 2002:a05:7022:c86:b0:165:be2f:c56e with SMTP id a92af1059eb24-1b39fe8709emr3227445c88.2.1794141874868;
        Sun, 08 Nov 2026 04:44:34 -0800 (PST)
Received: from localhost.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771e5728sm5138647c88.16.2026.11.08.04.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:44:34 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: jerome.pouiller@silabs.com,
	kvalo@kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wfx: reserve zeroed slack for the bus alignment padding on TX
Date: Sun,  8 Nov 2026 20:43:05 +0800
Message-Id: <20261108124305.5962-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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

tx_helper() rounds the transfer length up to the bus alignment (4
bytes for SPI, 64 bytes for SDIO) and passes the rounded length to
wfx_data_write(), which reads the padding from the supplied buffer.
However, none of the TX paths guarantees that this space is available
and zeroed. wfx_alloc_hif() allocates only
sizeof(struct wfx_hif_msg) + body_len, wfx_send_hif_msg_write() copies
exactly count bytes with memdup_user(), and data frames are sent
directly from the skb, whose tailroom is not guaranteed to be
sufficient or zeroed.

so the padding is an out-of-bounds read leaking heap data to the
device, the same defect class as the cw1200 fix "wifi: cw1200: fix TX
padding OOB read leaking heap data to device".

Reserve WFX_BUS_ALIGN_SLACK (64, the SDIO block size; SPI only needs
4) zeroed bytes at the end of every TX buffer: extend the two exact
allocations, and in wfx_tx_inner() ensure the skb tailroom and zero
it, re-deriving hdr since pskb_expand_head() may reallocate the
buffer.  Cloned skbs are uncloned as well, since the slack memset
must not modify shared data, following the same check used by
__skb_pad().

Found by static analysis.

Fixes: 4a5fb1bbcdf1 ("wfx: get out from the staging area")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/7982b4a7e64f74e2068790ec389ca680a081f730@linux.dev/
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/net/wireless/silabs/wfx/data_tx.c | 14 ++++++++++++++
 drivers/net/wireless/silabs/wfx/debug.c   | 11 ++++++++---
 drivers/net/wireless/silabs/wfx/hif_tx.c  |  4 +++-
 drivers/net/wireless/silabs/wfx/wfx.h     |  8 ++++++++
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/data_tx.c b/drivers/net/wireless/silabs/wfx/data_tx.c
index a44a7403ce..985eba3378 100644
--- a/drivers/net/wireless/silabs/wfx/data_tx.c
+++ b/drivers/net/wireless/silabs/wfx/data_tx.c
@@ -357,8 +357,22 @@ static int wfx_tx_inner(struct wfx_vif *wvif, struct ieee80211_sta *sta, struct
 	WARN(skb_headroom(skb) < wmsg_len, "not enough space in skb");
 	WARN(offset & 1, "attempt to transmit an unaligned frame");
 	skb_put(skb, tx_priv->icv_size);
+	/*
+	 * The bus layer pads the transfer up to the bus alignment and
+	 * the padding is transferred from the skb.  Guarantee tailroom
+	 * for the slack, uncloning the skb if needed: the memset below
+	 * must not write into a shared buffer.
+	 */
+	if (skb_cloned(skb) || skb_tailroom(skb) < WFX_BUS_ALIGN_SLACK) {
+		int ntail = WFX_BUS_ALIGN_SLACK - skb_tailroom(skb);
+
+		if (pskb_expand_head(skb, 0, max(ntail, 0), GFP_ATOMIC))
+			return -ENOMEM;
+	}
+	memset(skb_tail_pointer(skb), 0, WFX_BUS_ALIGN_SLACK);
 	skb_push(skb, wmsg_len);
 	memset(skb->data, 0, wmsg_len);
+	hdr = (struct ieee80211_hdr *)(skb->data + wmsg_len);
 	hif_msg = (struct wfx_hif_msg *)skb->data;
 	hif_msg->len = cpu_to_le16(skb->len);
 	hif_msg->id = HIF_REQ_ID_TX;
diff --git a/drivers/net/wireless/silabs/wfx/debug.c b/drivers/net/wireless/silabs/wfx/debug.c
index 454ec59fdc..f87f0e059c 100644
--- a/drivers/net/wireless/silabs/wfx/debug.c
+++ b/drivers/net/wireless/silabs/wfx/debug.c
@@ -255,9 +255,14 @@ static ssize_t wfx_send_hif_msg_write(struct file *file, const char __user *user
 	 * memory pattern may help user.
 	 */
 	memset(context->reply, 0xFF, sizeof(context->reply));
-	request = memdup_user(user_buf, count);
-	if (IS_ERR(request))
-		return PTR_ERR(request);
+	/* Reserve room for the bus alignment slack */
+	request = kzalloc(count + WFX_BUS_ALIGN_SLACK, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	if (copy_from_user(request, user_buf, count)) {
+		kfree(request);
+		return -EFAULT;
+	}
 	if (le16_to_cpu(request->len) != count) {
 		kfree(request);
 		return -EINVAL;
diff --git a/drivers/net/wireless/silabs/wfx/hif_tx.c b/drivers/net/wireless/silabs/wfx/hif_tx.c
index 9efb108bd8..45db1cf7f7 100644
--- a/drivers/net/wireless/silabs/wfx/hif_tx.c
+++ b/drivers/net/wireless/silabs/wfx/hif_tx.c
@@ -38,7 +38,9 @@ static void wfx_fill_header(struct wfx_hif_msg *hif, int if_id, unsigned int cmd
 
 static void *wfx_alloc_hif(size_t body_len, struct wfx_hif_msg **hif)
 {
-	*hif = kzalloc(sizeof(struct wfx_hif_msg) + body_len, GFP_KERNEL);
+	/* The kzalloc() also zeroes the bus alignment slack */
+	*hif = kzalloc(sizeof(struct wfx_hif_msg) + body_len +
+		       WFX_BUS_ALIGN_SLACK, GFP_KERNEL);
 	if (*hif)
 		return (*hif)->body;
 	else
diff --git a/drivers/net/wireless/silabs/wfx/wfx.h b/drivers/net/wireless/silabs/wfx/wfx.h
index bd0df2e1ea..6a6c8a47a8 100644
--- a/drivers/net/wireless/silabs/wfx/wfx.h
+++ b/drivers/net/wireless/silabs/wfx/wfx.h
@@ -25,6 +25,14 @@
 #define USEC_PER_TXOP 32 /* see struct ieee80211_tx_queue_params */
 #define USEC_PER_TU 1024
 
+/*
+ * The bus layer pads TX transfers up to the bus alignment and the
+ * padding is transferred from the message buffer, so every buffer
+ * handed to tx_helper() must carry this much zeroed slack (the SDIO
+ * block size is 64 bytes, SPI transfers are aligned to 4).
+ */
+#define WFX_BUS_ALIGN_SLACK 64
+
 struct wfx_hwbus_ops;
 
 struct wfx_dev {
-- 
2.25.1

