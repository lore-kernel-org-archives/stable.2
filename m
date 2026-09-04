Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73253955EC
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525733; cv=none; b=BN5pbV0DToQmRimdN7octZvZyCt8SAUJAubiLscJd4baMMY+wfRmsyDKQmvLFkbrm9d5t6qeNUiEeMohHp7zIifXlFWd4UOAeeReOfaudI687LYZyFUBgo1WblkyaAkILw9nQwMbmnPfilVJutEFFgteoLqWXB0PRsHvHDhQBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525733; c=relaxed/simple;
	bh=v0JD9QnS+O1C1mIX70Krfgrobq49KVwuNtB8eJuqwKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfBQdMpK8mGdSBNDqD5HBHkGpJMMjdf7zLmm9U6CzgY2Iy8fGcVBGCtNnij9TZPhvlccUTF92/3u2xf6fD3gBkDUSYXssax65WoLDVy+dEMiZxMzr/Qk8qvqI2PAFYP+mY6FYjKpzKCaIKCe1bPCP8Ues4gDIjPwdFWwy9PLQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQCuXQ1b; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQCuXQ1b"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c255c58156bso177959166b.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525729; x=1789130529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+GfpIcZOfBSRWB0S64d7KBcs9ltI3HwY4NYL2qubRE0=;
        b=jQCuXQ1bdK+exN+TNnnnaxp4ocrP3EXGSQhrMn5gmYDtmqoeNJHxQdiWKTseoeKhxL
         MYBHn08olZf1vxOU2N1eGw0ofvtclD6/9ZRrnmSiYI8iZZm+342VynfjkuI7RSZZQ8HZ
         Fk/vPF+glKmh67vv5u9Y5p3KBx+CN0ZaQbJ04X8jJ2NIE4DyvfMHpq220gIQv+V3PbTY
         XF4wjm3lgwZ4N9/mAnHjNO2fV5WxDw7QgPyPIlDeS23RZlz34Ge0YRtXP+z3W/AEAsB1
         8/95w2RjBmJaOup1muaaOLLPtFaolNvYzovEKuw8DWr5nZLYlhzY1Q3WhRZI2M0bXDS/
         HH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525729; x=1789130529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+GfpIcZOfBSRWB0S64d7KBcs9ltI3HwY4NYL2qubRE0=;
        b=N9B8aaIFo3sF0aiQwBx8s88r+ZNCK9qPM+SMLL4CgAnBigChGzSsOQPeFEC1fPrq9f
         3v/cJrag/wHpCwrtMKkzjsURMAN4PGs9fOoCycEVvYngUH42eF2F6K5et3FUIbTNvFE7
         2y10gNu9BEqse2d3LRP5S46S6NjBduUAToqsSZkbFtSLxRNbxju0nAqyKQx7gC8xJebN
         Bb94cTr2jXHrZBoz9hO3WrvnztnAG3Q1/xmtjlV3K4GmVmIssMKYYlUNmD8fH3/ZRR+s
         VAzVt/cgcSeckQYwmSb1EH9eC6XZWw2RXMJ6X5aEJy3nweqr/jon8PjCa99OdADZ4xRB
         uYMw==
X-Forwarded-Encrypted: i=1; AKwUvByOMJpyUPxk5SmfJCVFCzZlPHgT3hBhlVNAiDQt44Hv743PZPlpozhP5Hj6nKEPw9EnnscQCcA=@vger.kernel.org
X-Gm-Message-State: AFuF++mKdm8L2il9baznhY4wnu/BtglGeLRd9WyOv4Faw/1jC4nMFjBC
	yYi5cgMCKCWecAaydyaMvqu4phzB/Bqfedq8VF5ln4V3kG+rCsQPBRrT
X-Gm-Gg: AYBFou3xanIT/+pWJByL9ikLmLPIPu86pVGrBjUdPaoDMntQ06EQoWBk/JWfJywG3to
	uI9dOg7Xdp5YgV1XJ4m9L28gHIszgL7R2kopvVMWuALuQt2P9hNkt7phZFTmrwh6Tc+Yk75k4D8
	8EBI3rn45SMRIFCAu/HzupSDOsk9uBmDkX4r5sIkzcvDTjS6CV+sPhVLLv0zdVd+25UMS3JQHnt
	8SQitgxCEeECJoq7BZl/VeLV0KjfOG/fWB8TezUKgAQb6l7K4qCvE9GLeuYtvVbx2yxxVGs03bX
	1hF/gCfDg49rhhq4TxaqWWfy1mN/MXQ+QrkwxAsfmMMRafaN4GtC806vZE0eJ/kKCWAzLwEh9dE
	FweOkjyKCUFW5oLiCVhyvcYDQnxb52OZqkZhDvV+6Cxwz2Tudqy+PdfNVrgznwU/yUgMN4QWNNw
	vbVOw3Dnb/xamey8kgXz1ASwC6S5bElCufGFCkB0skxYtwbzPKGaPpJmX+J1JqPVrGkcsUF15D7
	DxDBkGdWGjMF/8I20VK8eI/dtqYkSQ=
X-Received: by 2002:a17:907:d206:b0:c26:19de:9ac6 with SMTP id a640c23a62f3a-c2619dea68emr107601266b.30.1788525728401;
        Fri, 04 Sep 2026 05:42:08 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d582304sm102558466b.43.2026.09.04.05.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:42:07 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: tulip: use mod_timer() in t21142_lnk_change()
Date: Fri,  4 Sep 2026 14:36:11 +0200
Message-ID: <20260904123843.375633-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t21142_lnk_change() is called from tulip_interrupt(), i.e. in hardirq
context. On a link-fail or NWay renegotiation event it calls
timer_delete_sync(&tp->timer) before rescheduling the timer, which is
exactly what

  WARN_ON(in_hardirq() && !(timer->flags & TIMER_IRQSAFE));

in __timer_delete_sync() exists to catch, since tp->timer is not
TIMER_IRQSAFE:

  WARNING: kernel/time/timer.c:1611 at __timer_delete_sync+0x13c/0x150
  ...
  [<...>] t21142_lnk_change+...
  [<...>] tulip_interrupt+...

This isn't teardown, it's just rescheduling the media timer, which is
exactly what mod_timer() is for. mod_timer(timer, expires) is
documented as equivalent to timer_delete(); timer->expires = expires;
add_timer(), and as the only safe way to change the timeout when a
timer has multiple unserialized concurrent users. That is the case
here: t21142_media_task(), scheduled by this same timer's callback,
already ends with its own mod_timer() call on tp->timer, with a
comment noting it synchronizes against add_timer() calls from
interrupts. Using mod_timer() in t21142_lnk_change() as well, instead
of an unprotected timer_delete()+add_timer() pair, matches that
existing concurrency model instead of racing against it.

Update the comment in tulip_interrupt() accordingly. pnic2_lnk_change()
still calls timer_delete_sync() from the same hardirq path, but its timer
callback re-arms the timer directly with mod_timer(), so fixing that path
requires separate consideration of the callback/reschedule race.

The warning was reproduced during a link-state change at boot on an
Alpha UP2000+ running v7.3-rc1 with:

  0001:02:08.0 Ethernet controller: Digital Equipment Corporation
  DECchip 21142/43 (rev 30)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 drivers/net/ethernet/dec/tulip/21142.c     | 8 ++------
 drivers/net/ethernet/dec/tulip/interrupt.c | 5 ++---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/21142.c b/drivers/net/ethernet/dec/tulip/21142.c
index 76767dec216d..da701f325783 100644
--- a/drivers/net/ethernet/dec/tulip/21142.c
+++ b/drivers/net/ethernet/dec/tulip/21142.c
@@ -216,20 +216,16 @@ void t21142_lnk_change(struct net_device *dev, int csr5)
 		    (csr12 & 2) == 2) ||
 		   (tp->nway && (csr5 & (TPLnkFail)))) {
 		/* Link blew? Maybe restart NWay. */
-		timer_delete_sync(&tp->timer);
 		t21142_start_nway(dev);
-		tp->timer.expires = RUN_AT(3*HZ);
-		add_timer(&tp->timer);
+		mod_timer(&tp->timer, RUN_AT(3 * HZ));
 	} else if (dev->if_port == 3  ||  dev->if_port == 5) {
 		if (tulip_debug > 1)
 			dev_info(&dev->dev, "21143 %s link beat %s\n",
 				 medianame[dev->if_port],
 				 (csr12 & 2) ? "failed" : "good");
 		if ((csr12 & 2)  &&  ! tp->medialock) {
-			timer_delete_sync(&tp->timer);
 			t21142_start_nway(dev);
-			tp->timer.expires = RUN_AT(3*HZ);
-			add_timer(&tp->timer);
+			mod_timer(&tp->timer, RUN_AT(3 * HZ));
 		} else if (dev->if_port == 5)
 			iowrite32(csr14 & ~0x080, ioaddr + CSR14);
 	} else if (dev->if_port == 0  ||  dev->if_port == 4) {
diff --git a/drivers/net/ethernet/dec/tulip/interrupt.c b/drivers/net/ethernet/dec/tulip/interrupt.c
index 0a12cb9b3ba7..6ed4b68ad86c 100644
--- a/drivers/net/ethernet/dec/tulip/interrupt.c
+++ b/drivers/net/ethernet/dec/tulip/interrupt.c
@@ -698,9 +698,8 @@ irqreturn_t tulip_interrupt(int irq, void *dev_instance)
 				dev->stats.rx_errors++;
 				tulip_start_rxtx(tp);
 			}
-			/*
-			 * NB: t21142_lnk_change() does a timer_delete_sync(), so be careful
-			 * if this call is ever done under the spinlock
+			/* NB: pnic2_lnk_change() does a timer_delete_sync(), so be careful
+			 * if this call is ever done under the spinlock.
 			 */
 			if (csr5 & (TPLnkPass | TPLnkFail | 0x08000000)) {
 				if (tp->link_change)
-- 
2.53.0

