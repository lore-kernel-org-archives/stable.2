Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECE41B8CD
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924112; cv=none; b=ofHsZJy8f40icWzzSA8W2x25Fa8OyqlLgANCIcVXEgRAcyBi0j+uE/5VOao5PM7TyBtjsHSc7zk3TMvvOZEENwiyCGKNfrACb/MoU/TSEiF3VdqamMYM5dzGztr1KMZi3CMoBX30ALD4Ao4hAGydENA03/TnSFIzDoK3/N6kw+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924112; c=relaxed/simple;
	bh=RHsAW528LjpC1dNrxnr6Ql37IVBSqXQU/RP4Y8JOAjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgV3o4SwyeahvHH9beujXv/aIjXWmNzJ99+R6lu9CSNNH6qqmTL9sOpVEvWDSUwGzeJ47r+FDDzaOjNZR0hTC/Ti6BukCEe323Z1Bloz43YjCgrMmH2n0iJGLhWSsqas3uNgjHInJyI16S9AT0kHlnpdKkwoXXS6R3/QHzE4bqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEXgqCE5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEXgqCE5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495437bb891so7752215e9.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785924109; x=1786528909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AqXp8qEaN1k4mqWF2/Jz3f2LFKv7ypr2RsFpqq7JTX8=;
        b=tEXgqCE5tPnyYEUAgSvNfB4zdi+fsL64xl5tij+4/LcpKIBlQLAfu9P6bmPaNfVrKC
         P8ysxUaA98f+1geBbIQbTaWulZNw6YiR5CHIvuuqw1qHPLDAjWhTRGf9GebCjTpCMUGK
         gCKQ5koU915H1v6sunqQu3iwYjK2tpaEvLCcmIP9Z+besdZbh3ggQvHC3pmTOzDQuMBW
         7j7uPeysKiKbKDyrgf/5wN70QtfJaGzvHiZyejCo2n8wbTmb6XfRnCyRQx8f2MCFcPWS
         QJg5YimoxAkqH5Bfgr/urW0puI+VsuKtzLEDxjAoPxyEam1mRXBuCtudWEVy6VNFhCh0
         jkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785924109; x=1786528909;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AqXp8qEaN1k4mqWF2/Jz3f2LFKv7ypr2RsFpqq7JTX8=;
        b=CcZ1GAKBu2cvo9sRJiHRzgn5lPrBgm9rGCzhuFj/HjTpEydRh1sM76q6OAdm1/2zrg
         0InUMZz6fMYS4/S27ezbsa0d+WuwXKRJk6mUgPA8Wyf6pEY/uVpfzC4m35JepPLIupA1
         5A7QaoT2Kig33TDhv8V5RiVa+oxk+crrsfTJiacUmPJuYYbGxcwtJ1TylfC2cI4Nl46q
         6HUoGEHpDzCZl8sIObF7WrBXRHdonqUTtczta0uHVEG3DtJvUOVWpW4nC3Zvov2JW6Z1
         VEsZKkFkgDnSEamzyVJfVaX1NWAo594qtTFwjUUC7qhNVxeE1KsQsP7C9Hf2biGEpbVC
         tA2g==
X-Gm-Message-State: AOJu0Yzunjf9MhTUPhd0QvixV+NQPwQQ//cKG1mz4YHkqP1lj7C1yExQ
	mGbLF/W7TlERShtYOu3L5E3ytM3tJ8v8Lh3Sg/TUAwTy1Mo73LoCv/xBkd3gxccd
X-Gm-Gg: AR+sD1394LFEVntP9PrsnRGqKzSZRWSIjUgGGeUeEILGYzdMXrWD8nGhHJRiRyD/JfH
	UmLw08n5k/MrJWcEqgMbRCQKoKHsHA38uxWaYHAKaigzQSWLncTHD0RmgoR+hSw4rkqK/R8LLlI
	q4BIbFLMLSHla4/RtfmHKhCysv91tmNoJHfDM0O2HXQOxvuCetS/AUnPUBFEPVFB089KiBhbNSw
	tNyAv9S/ETvEmmnwSSaMTF/AaOhP2KRbFkydgHi14+4XwvEc1N8QMPM80YM37s+dR4Tllzg5xDu
	gR7qfuuv3TeKFtgXZ3hYMChcUamZiyhRTM+zq3O7IzH5uJlTRNViXzLCHCycNvsG0DqDPj9/8PV
	UQiNnh/xi7Ss4HyOdfaL45xigLya49ALDBK+UQS/3j2hyxLTuo9yAFFF8dJv33c+wuQCEoRWmTB
	rQvsC6Sn/EH2ub4nXHVel7sQYz/Ikvl9EJho0tQkz0NkJqO+FRbJ1ao1L0epzQ6VCUM1A8cyPjD
	H4h
X-Received: by 2002:a05:600c:8218:b0:493:e543:1dd9 with SMTP id 5b1f17b1804b1-4994a110c98mr224357065e9.9.1785924109111;
        Wed, 05 Aug 2026 03:01:49 -0700 (PDT)
Received: from arbab-X395.dbs.corp ([110.93.227.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec249a5fsm7344776f8f.33.2026.08.05.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:01:48 -0700 (PDT)
From: Arbab Haider <arbabhaider649@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 7.0.y 3/5] net: macb: drop in-flight Tx SKBs on close
Date: Wed,  5 Aug 2026 15:01:34 +0500
Message-ID: <20260805100136.59101-3-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805100136.59101-1-arbabhaider649@gmail.com>
References: <20260805100136.59101-1-arbabhaider649@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

The MACB driver has since forever leaked the outgoing SKBs that
have not yet been marked as completed. They live in queue->tx_skb
which gets freed without remorse nor checking.

macb_free_consistent() gets called in a few codepaths, but only close will
trigger the added expressions. In macb_open() and macb_alloc_consistent()
failure cases, queues' tx_skb just got allocated and are empty.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Cc: stable@vger.kernel.org
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://patch.msgid.link/20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Upstream commit 27f575836cfebbf872dec020428742b10650a955 ]

---
 drivers/net/ethernet/cadence/macb_main.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 99e7d5cf3786..68dae92205e0 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2551,8 +2551,25 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		if (queue->tx_skb) {
+			unsigned int dropped = 0, tail;
+
+			for (tail = queue->tx_tail; tail != queue->tx_head;
+			     tail++) {
+				if (macb_tx_skb(queue, tail)->skb)
+					dropped++;
+				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
+			}
+
+			queue->stats.tx_dropped += dropped;
+			bp->dev->stats.tx_dropped += dropped;
+
+			kfree(queue->tx_skb);
+			queue->tx_skb = NULL;
+		}
+
+		queue->tx_head = 0;
+		queue->tx_tail = 0;
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}
-- 
2.53.0

