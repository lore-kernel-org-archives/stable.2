Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E113AEB38
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794470; cv=none; b=pmeSaMb9OrV1zrZVU09SrDZxZiVkFkT6g4Hq7FACMS6m2Jk9DYdposkSkOJgzZDf9n4JL2I7+pNlca1URdpaG0tas3FsI2XnBInq4RZRjvMRJWrS0gbYQTFIfX51o1SGzt/X7a/Kh1ilUzoneL8QtJ5Zo9Q0r5BfepYA+NQYyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794470; c=relaxed/simple;
	bh=UCFeSMOs+Qi6rlEif4wp5NL4CT/HAxxrve974CVtz4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNg8gDI5O99Dvf2+H1Zd1XIpDbJqTGAIgko22a2reIXhI/5eljExQcd+dfWSd3A8K5bi7RiMqnGNlt+WF8ENfHbIgDnsqrU1zD0incAiZxXWXajAX1I9QTgZjw4WZjnDswX7bm/2XIvhAZtu6McdfcC/G3Em1xun8MQX5ny7zhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFaeoRf2; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFaeoRf2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso42456185e9.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790794466; x=1791399266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aIRe9J9nM9kojEK5e8In+q+vzA6ofCEVTiqwmV0m+zo=;
        b=TFaeoRf2YUJF4S8c0d5gRvToQSkRN7xpVFpxJ85wJjCyv7smv5eZPX2JbczHu7PofJ
         u5czZAzrmB5bnovhiEbNAlU9Sd90DLb0zjm0DaEKGOYiqfa1dVrxH66yOw/QoMPpETD5
         93SfSkN1qqWVE9F/YN7uMTzqTAqYeqEUckd7c48+4XTpm8pAXGJeuRmJevhLILcenLvN
         /rKnBoKvp8wtZLnU6bJp2riTNAv9PFR7sxTtp2z/hjsyk888DZ10y9sdyZGQEJtv0ZBt
         eKphJG2L8/X4YW1mMBBUMZG6Iw71Q87JyiSi12G0ljKb/ZSZLmnaP9aRC9sT48f9hVn8
         SSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790794466; x=1791399266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIRe9J9nM9kojEK5e8In+q+vzA6ofCEVTiqwmV0m+zo=;
        b=XDEUPDick9iuj+d1qMpN2o6WvstJuvIpCHvStJRSBqHDaJv3IB9ptn8sDVIongOEEe
         Tul6PWSpC/+LHkxqre7KyM7rDEFu4QWBlFdZDVXT//BoGOEKBZEWM/Cudsw3ReRetkux
         KZYaS1mN1b6s3tIRgQ1/1llXsunFYWkiemBEwosfvjy4i+j/1zEXxTumy+QlQS7PIr6e
         u0dClDElipuPr3EpDWwKH1BLm8JgD3yMT8Si+iIT8VDLLLzobGz/5fNiMTPXrg/I0ZeS
         vCUWnFgx9gdaSk7khyfJa4RCR0mGOkWn3JfXBR26nGXtOcGEO5Nup4XY5VGk+Kid51sz
         ejyA==
X-Forwarded-Encrypted: i=1; AKwUvByeGM6d03YRC8EB+VL+TW9KyxYwfI1ukvg7edPNG7Q7W0YFw8unpq8dNfqKQbx2EHh7sMjG4vo=@vger.kernel.org
X-Gm-Message-State: AFuF++nfXh4eDAPiIzRqLYefTgsmfZQ7Iu/4UlZM3qAX6c2Vzk9eJLA7
	6ok6DYF/cGBQYtsQpztcWt5PaXWTGPmlFdVbynuBJPZQrsRHWga7p05E
X-Gm-Gg: AYBFou2cavDvFqu5POilw8fdHWt+k/JYD9R5RlN32p4IwTUYpOnQVJHJgvi4gFtAaAW
	D2RZon1zMQ9A8j1TuQclR20Fr9YgZG+5lUOtzKk99g+hac9t/7fvsT7A7vTsHYG6OFqXMg+qbyk
	oiiej6s4a7r6B8V3NXAV14Ccm52E1u2G2E91KUtJoeZxzvjOys1+vDhdYuctOslfGU80RUg+NnS
	9NJv3/PI+gUxALlugXbDEaELtgzE2IhzlgwZT44x6zcbAeKcJS7V4osg+BAQuIJRKBdFVPnSp1S
	PMftkR/r+YQQj8szMtb+todrsKAZ4xGA3Ck1a5oOd2Q2xYHy0T7sTfk+tL0gTyLLUcCo09hfffN
	Fh/8A68iuz7hphKeqTROT3iNWhQx+Nomn6S421iadhe8kDLRZZDYPa0+0z8eDWAqkG2Ntnieur5
	9vYzRL0322BNPbGalzy1MSk33KM9jO4/Q/TYTquU1My03U1d53MHAUdCld0L/l0mkNgBe+ufnNs
	m69jxiBWOxpywnJCFfOlR8Ps/p5IXubLol8wclwfmqLWnyzV3zdqAyRe3VE1MF285gjeMQ0Kp9x
	qZ84E3a931kmOLyve4AyEWFZ/xfTD6+D7Hbx4I7Vn/9qalQQzP0CteRLIbF9cIOKuemNM82UktE
	o
X-Received: by 2002:a05:600c:3b99:b0:49d:1840:4fd2 with SMTP id 5b1f17b1804b1-4a01aff6a1bmr50678345e9.23.1790794466174;
        Wed, 30 Sep 2026 11:54:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2b3-0101-b51c-a607-3dcc-3979.310.pool.telefonica.de. [2a02:3100:b2b3:101:b51c:a607:3dcc:3979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01fa137basm1542095e9.1.2026.09.30.11.54.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 11:54:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll context
Date: Wed, 30 Sep 2026 20:54:17 +0200
Message-Id: <20260930185417.61865-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the default fcmode=0, netpoll calls ndo_start_xmit() with hard
interrupts disabled and reaches brcmf_sdio_bus_txdata() directly. The
function takes txq_lock with spin_lock_bh(), and the queue helper takes
the embedded sk_buff_head lock. These locks may sleep on PREEMPT_RT.
On non-RT, spin_unlock_bh() can run pending networking softirqs before
netpoll releases the transmit lock, causing a recursive transmit
deadlock.

Use spin_trylock() for IRQ-disabled calls and enqueue with the unlocked
skb helper while holding txq_lock. On PREEMPT_RT, reject hard IRQ and NMI
callers, where rt-spinlocks cannot be acquired. If the lock is busy or
the queue is full, return through the existing drop path. Do not evict an
older packet from this context. Suppress the queue-full printk because
netconsole can recursively enter this path.

The flow-control callback takes another spinlock, so defer it when an
IRQ-disabled enqueue reaches TXHI. The data worker rechecks the bus state
and queue length under txq_lock before stopping the queue. Existing TXLOW
handling wakes the queue after it drains.

This fixes the direct SDIO transmit path used by fcmode=0. Modes 1 and 2
take the FWS lock first and need a separate change.

Fixes: ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Testing:

- This revision passed W=1 sdio.o builds on x86_64 PREEMPT_RT and
  x86_64 PREEMPT kernels.
- This exact revision, together with the netpoll v2 fixes, passed 10/10
  counted physical boots across a Pi 400 and Pi 500+: three RT and two
  non-RT boots per board. The softirq trigger delivered 64/64 records on
  every boot with no driver drop. Every lock-contention run freed all 64
  skbs without timeout, and every TXHI queue stop subsequently woke.
- Each board and kernel flavor completed a 1,800-second numbered stream,
  ten repeated TXHI cycles and a Wi-Fi reconnect. No counted boot
  reported an atomic-sleep warning, new lockdep splat, stall or lockup.
- The exact revision passed combined RT and non-RT QEMU softirq,
  lock-contention and TXHI stop/drain/wake tests.
- An unpatched PREEMPT_RT Pi 400 reproduced the atomic-sleep report. An
  unpatched non-RT Pi 400 deadlocked and produced 32 RCU stall reports.
- An unpatched PREEMPT_RT Pi 500+ reproduced 21 atomic-sleep reports.
- All brcmfmac tests used the default fcmode=0.

 .../broadcom/brcm80211/brcmfmac/sdio.c        | 91 +++++++++++++++++--
 1 file changed, 85 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 381801af3a..170450306d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -516,6 +516,7 @@ struct brcmf_sdio {
 	bool dpc_running;
 
 	bool txoff;		/* Transmit flow-controlled */
+	bool txoff_pending;	/* Deferred transmit flow control */
 	struct brcmf_sdio_count sdcnt;
 	bool sr_enabled; /* SaveRestore enabled */
 	bool sleeping;
@@ -2796,8 +2797,53 @@ static bool brcmf_sdio_prec_enq(struct pktq *q, struct sk_buff *pkt, int prec)
 	return p != NULL;
 }
 
+/*
+ * The caller holds txq_lock with hard IRQs disabled. Avoid the skb queue
+ * lock, which may sleep on PREEMPT_RT.
+ */
+static bool brcmf_sdio_prec_enq_irqoff(struct pktq *q, struct sk_buff *pkt,
+				       int prec)
+{
+	struct sk_buff_head *list = &q->q[prec].skblist;
+
+	if (pktq_pfull(q, prec) || pktq_full(q))
+		return false;
+
+	__skb_queue_tail(list, pkt);
+	q->len++;
+	if (q->hi_prec < prec)
+		q->hi_prec = prec;
+
+	return true;
+}
+
+static bool brcmf_sdio_txq_lock(struct brcmf_sdio *bus, bool irq_off)
+		__cond_acquires(true, &bus->txq_lock)
+{
+	if (irq_off) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		    (in_hardirq() || in_nmi()))
+			return false;
+		return spin_trylock(&bus->txq_lock);
+	}
+
+	spin_lock_bh(&bus->txq_lock);
+	return true;
+}
+
+static void brcmf_sdio_txq_unlock(struct brcmf_sdio *bus, bool irq_off)
+		__releases(&bus->txq_lock)
+{
+	if (irq_off)
+		spin_unlock(&bus->txq_lock);
+	else
+		spin_unlock_bh(&bus->txq_lock);
+}
+
 static int brcmf_sdio_bus_txdata(struct device *dev, struct sk_buff *pkt)
 {
+	bool irq_off = irqs_disabled();
+	bool enqueued;
 	int ret = -EBADE;
 	uint prec;
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
@@ -2826,22 +2872,39 @@ static int brcmf_sdio_bus_txdata(struct device *dev, struct sk_buff *pkt)
 	bus->sdcnt.fcqueued++;
 
 	/* Priority based enq */
-	spin_lock_bh(&bus->txq_lock);
+	if (!brcmf_sdio_txq_lock(bus, irq_off)) {
+		skb_pull(pkt, bus->tx_hdrlen);
+		return -EBUSY;
+	}
+
 	/* reset bus_flags in packet cb */
 	*(u16 *)(pkt->cb) = 0;
-	if (!brcmf_sdio_prec_enq(&bus->txq, pkt, prec)) {
+	if (irq_off)
+		enqueued = brcmf_sdio_prec_enq_irqoff(&bus->txq, pkt, prec);
+	else
+		enqueued = brcmf_sdio_prec_enq(&bus->txq, pkt, prec);
+
+	if (!enqueued) {
 		skb_pull(pkt, bus->tx_hdrlen);
-		brcmf_err("out of bus->txq !!!\n");
+		/* Avoid netconsole recursion. */
+		if (!irq_off)
+			brcmf_err("out of bus->txq !!!\n");
 		ret = -ENOSR;
 	} else {
 		ret = 0;
 	}
 
 	if (pktq_len(&bus->txq) >= TXHI) {
-		bus->txoff = true;
-		brcmf_proto_bcdc_txflowblock(dev, true);
+		if (irq_off) {
+			WRITE_ONCE(bus->txoff_pending, true);
+		} else {
+			WRITE_ONCE(bus->txoff_pending, false);
+			bus->txoff = true;
+			brcmf_proto_bcdc_txflowblock(dev, true);
+		}
 	}
-	spin_unlock_bh(&bus->txq_lock);
+
+	brcmf_sdio_txq_unlock(bus, irq_off);
 
 #ifdef DEBUG
 	if (pktq_plen(&bus->txq, prec) > qcount[prec])
@@ -3754,6 +3817,21 @@ static void brcmf_sdio_bus_watchdog(struct brcmf_sdio *bus)
 	}
 }
 
+static void brcmf_sdio_deferred_txflowblock(struct brcmf_sdio *bus)
+{
+	if (!READ_ONCE(bus->txoff_pending))
+		return;
+
+	spin_lock_bh(&bus->txq_lock);
+	WRITE_ONCE(bus->txoff_pending, false);
+	if (bus->sdiodev->state == BRCMF_SDIOD_DATA && !bus->txoff &&
+	    pktq_len(&bus->txq) >= TXHI) {
+		bus->txoff = true;
+		brcmf_proto_bcdc_txflowblock(bus->sdiodev->dev, true);
+	}
+	spin_unlock_bh(&bus->txq_lock);
+}
+
 static void brcmf_sdio_dataworker(struct work_struct *work)
 {
 	struct brcmf_sdio *bus = container_of(work, struct brcmf_sdio,
@@ -3763,6 +3841,7 @@ static void brcmf_sdio_dataworker(struct work_struct *work)
 	wmb();
 	while (READ_ONCE(bus->dpc_triggered)) {
 		bus->dpc_triggered = false;
+		brcmf_sdio_deferred_txflowblock(bus);
 		brcmf_sdio_dpc(bus);
 		bus->idlecount = 0;
 	}

base-commit: 6f63e919fe1e335b8abcb3a28bfd4804a98d875a
-- 
2.53.0
