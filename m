Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23A13AF2
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784430033; cv=none; b=XDkJbQGeS/VDnHtRwe3S1iOZg2yjFp7B9wnl53d4U7GR9LzdxGFrqY8CCoFavo4W6JU9Fxz7ARDguX5PKzVY/dmUO6Tgloo78nl5PsYMSARX/0kEyJnZiUCd5if7M6316E6b0R/K/6U64T2ueiS/NY8RJPi4thXAgyxZOWDPZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784430033; c=relaxed/simple;
	bh=Jn33P+/6FTfvH5tB+4YcYehstSunwoyd5SiHVTVlZz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jkqf/IMeT7y/6A0r/3Xry61A/KRBR/OLANPalBEfBPrVek8tiUMEJ8CftPb5qVxjuXc2dTrV0uZgrvadExr/P1r5HQVnudBxcDYLi6tUqcqcl9bmJZoBIJ/HXLl9x+VsTWDnCX7pcinAIiR0swVPS/GswQ/W25kGuosVyEmRf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI8NQ+Rr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI8NQ+Rr"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c08df8513so38906611cf.3
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 20:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784430031; x=1785034831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8VKY6n6oODsytlm7jYrsNeF3Lue+neWZnZVfcsQNCPs=;
        b=lI8NQ+Rrnf8oYxMmCdApHmFEb48jlzs0LGnVeIjLNjlsDTJAa5bdBfkZ6QR6ZY5C8b
         pXto3JwD1OFkVOEc9DrNlMuM08uxAUDjJaQ8E6TvnMPDLOsdgLmUmOt5U09PUWlANSNs
         sFCjGuGPHLm7YkpwuYsUkN74Flnow14E4YaCyJVqM18a/9oELx9o4J25l8fDZCeYrz4Q
         98ZB6fGUJ2joROmVyIv+4gvJQMrYPkp5onykkeROLla5yeVCENZbxyF47eINYGksBaEb
         IESWxv6bIZnqcfVLMIUC6pXI0l0rgVaO1XIvPaFItnbuvI9YJmQjitWMx4HG1zmM2ICe
         5ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784430031; x=1785034831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8VKY6n6oODsytlm7jYrsNeF3Lue+neWZnZVfcsQNCPs=;
        b=HKPcYOrCrqDBtEQ0FlhAvCIPqBeLoVsRQmH0iQBvuHwLKrLUV9wCkDdvJq34pO9tf2
         K8/xflViH7QCqZuypt37UXnNb025yo9V1FxfCREMkkllTkMfYxafZgd+SGctzLWX0ZEU
         s7EnORuNCBRrb5PlLO3aJfKRdL0Pw9b2K1M9kQaESohjMXu1LvGDbNO8DnuEEn8tkRrz
         OstxKiPSCxqf+VzGYiMbfb1Asz0OTvcByNUkJMTur/M0+GHDYmrWrwXafZ0vuCvtBRpx
         vDMqhkVebmB5+8OuMIGfBcvT34AwEfJiLk/W8qGDvbC2GyFN/DWg1nBOfHcaEni6OptS
         +hyw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7wxe6mPt8NJEh2ruh3pE1lJaZ6a462kyS8o2knMegY6tL3glDNVx7Tud97P1yNzoqnF6dEE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnlwFiZWaUZud66hjzgcziQuwhNff5u4cR/jGicIKABL2N8bry
	uSIYhkMjSzd9yy6/BdS1BhdfV7ApFK2kOfQFJ/jVFtm76mgh9C88maqD
X-Gm-Gg: AfdE7cnacQcl43wyLK0M2lTMoUulnE4u6ro34rkmSKPJ78JEaZO+MAzAKUG7a/Ayt7q
	Oo3xbq/PRo/8i9P5mb1x6pJgZ92BiW9mOYBXqd5UNHTvI0SEAfhP/f7mDsNcUc3aMuH86+CZUFi
	ez8dd5+ZXyXnSkeL0lsKuy9kXxGNJpc2NA/Y9345ZfwQMMdtbiU4y6wq9ixVAz5oafofnubyirI
	bxf6yoI8+eKDeqS4Bt8xOR6x0B5zz5SJAsJIaq96Nj5+jvW6GWRGW1b1QzVy2v5amfwLNf5/LrX
	WT0/QNRIOI7OF7rNLhR15r/VpOZ2gKEt4SUHpqWI+gr4NFcGYuDjPNCAwyXN/xKqnzZZMq21ZIM
	ANs8LPh6wzKnMT/t9yUveqySm6v6HSuP6jmwyFhmmxWtqOJVqN4FnPU8IqNH6ffTuwJOzw0RujF
	QoT5HSKeS+bz3CEuT9e9LQUli3Yaa15mA=
X-Received: by 2002:ac8:5e49:0:b0:51c:7b12:1202 with SMTP id d75a77b69052e-5213f36fceamr85793061cf.80.1784430031320;
        Sat, 18 Jul 2026 20:00:31 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f01654fsm44853871cf.19.2026.07.18.20.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 20:00:30 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Celeste Liu <uwu@coelacanthus.name>,
	Kees Cook <kees@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH can v2] can: gs_usb: fix hardware timestamp state for mixed channels
Date: Sat, 18 Jul 2026 23:00:00 -0400
Message-ID: <20260719030000.3667449-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
References: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware timestamp state is shared by struct gs_usb, but gs_can_open()
and gs_can_close() tie its initialization and teardown to active_channels
and to the feature bits of the channel being opened or closed.

This is wrong for mixed-channel devices in both directions. If a
non-timestamp channel opens first, a later timestamp-capable channel does
not initialize the shared cyclecounter/timecounter because active_channels
is already non-zero. Timestamp RX then calls timecounter_cyc2time() with
parent->tc.cc unset.

Conversely, if a timestamp-capable channel opens first and starts the
shared delayed work, then closes while a non-timestamp channel remains
active, disconnect may close the non-timestamp channel last. The old
teardown check skips gs_usb_timestamp_stop() in that case and frees
struct gs_usb while the delayed work timer is still queued.

Count the number of active timestamp-capable channels. Start the shared
timestamp worker when the first such channel opens, stop it when the last
such channel closes, and unwind the count if open fails.

Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
Cc: stable@vger.kernel.org
Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
Changes in v2:
- Count active timestamp-capable channels instead of tracking only whether
  the shared timestamp worker has been started.
- Stop the shared timestamp worker when the last timestamp-capable channel
  closes, even if non-timestamp channels remain open.
- Unwind the timestamp-capable channel count on gs_can_open() failures.

 drivers/net/can/usb/gs_usb.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ec9a7cbbbc69..9cc197803e0d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -337,6 +337,7 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 active_timestamp_channels;
 	u8 channel_cnt;
 
 	unsigned int pipe_in;
@@ -980,10 +981,13 @@ static int gs_can_open(struct net_device *netdev)
 
 	can_rx_offload_enable(&dev->offload);
 
-	if (!parent->active_channels) {
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+		if (!parent->active_timestamp_channels)
 			gs_usb_timestamp_init(parent);
+		parent->active_timestamp_channels++;
+	}
 
+	if (!parent->active_channels) {
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			u8 *buf;
 
@@ -1094,13 +1098,15 @@ static int gs_can_open(struct net_device *netdev)
 out_usb_free_urb:
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
-	if (!parent->active_channels) {
-		usb_kill_anchored_urbs(&parent->rx_submitted);
-
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+		parent->active_timestamp_channels--;
+		if (!parent->active_timestamp_channels)
 			gs_usb_timestamp_stop(parent);
 	}
 
+	if (!parent->active_channels)
+		usb_kill_anchored_urbs(&parent->rx_submitted);
+
 	can_rx_offload_disable(&dev->offload);
 	close_candev(netdev);
 
@@ -1152,13 +1158,15 @@ static int gs_can_close(struct net_device *netdev)
 
 	/* Stop polling */
 	parent->active_channels--;
-	if (!parent->active_channels) {
-		usb_kill_anchored_urbs(&parent->rx_submitted);
-
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+		parent->active_timestamp_channels--;
+		if (!parent->active_timestamp_channels)
 			gs_usb_timestamp_stop(parent);
 	}
 
+	if (!parent->active_channels)
+		usb_kill_anchored_urbs(&parent->rx_submitted);
+
 	/* Stop sending URBs */
 	usb_kill_anchored_urbs(&dev->tx_submitted);
 	atomic_set(&dev->active_tx_urbs, 0);
-- 
2.43.0
