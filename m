Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808883;
	b=zXF6DJx8xW25A1w1ZOT8YBdd5MJTaT3v5boC1LI+nsnc05qOxIn3ZXo+8u0oU8rJ8Vhb
	 hrWiJ0FjoUgAg0rXp+yf36bC39TV0g6plt7npVwtFgW5vJ9lsLH4PiC3QdH0EglAU/jNH
	 cUEeUbi2/2uNoudSFYMXdOLiruGC0i363VUZzi5nI7N78KiSI/81DAPR+bNJre+aYShp4
	 o0z/6y9unO2OWZoMgmmuc0gED85seDQm/Cqq9e2g+eL+U6ObQVgKF9lxbhL5nybr+zq39
	 yCp2VGkeOH1lBK7fGneQg244wntiy2sI95i5jo4ewW0vgNxY5s5E8bcSV0OH1NY4+hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
	b=1A+bJ3XtpUUEiiuK2iDHBfBGOyZZORuJXgUC/XaU22E7Bjli5HzDHSSoYPjI+6BKqj/5
	 bGQl6/OA61khKzCLM4B/QUMN2ix4h8wX2/8YBgGGcPTVt9dLW0j47mYtSjtG6S0jGTvqh
	 wh0wYPATJWTxte3zf3cG2CIdiLkW6Le/1h6va9LBUOz6rzCSL2gr3SJjMkkPIr2gbwDc0
	 ReG3ZmiW6X22/wQLay7Ug0qmJu5nCf2l1RQP4W/seKxvy4kx32SxvsI4lOnCusm1x6/gi
	 QWpZ/yvJxree5TrmcAm9yGopJMG77SN8fzeOloTcQolPZBsOgZYiArhFSTsB4Rb6t1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xx56x4fZ;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF3606A89A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83CF3606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xx56x4fZ
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8629fc8ad64so1112200a34.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 22:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808881; x=1795413681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
        b=Xx56x4fZHENreaibOQJxd3BcFbCwzQM/QbbLPcvvbQHwFUJtXrD/LVH8ONfHv8yQ3t
         PbBGA+bbkNVy+7coQQFSg/akw05l59WvVDM2sSM48LZyb6VmWep/6ikll1KNtSSBFIiH
         SeP3BqZatpaDMuOEHrNb6IFKI0Gdmw4ZBrVeVzR0yAxljB3vhokVxTx23LhGOfr42Szo
         mFqqiUeGW1e6KhRMOq8lr+KkU3nZ1CT+LuZ0FB0EQQ4xmdb5QTiQailRQ3KFZlFVbh4I
         /LT9g+1IfwXpNgx/cW5ICCKBssPi88WYjS4yMXAw35D/N2Qr+Dzo3u7XekuiI6oRRkM9
         wtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808881; x=1795413681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JO4lonZbzonXjGudrUdKykQEm0Ub0u8cq6ZIlxF4Esc=;
        b=Fy8L6DkE9l90zYEgLqnlxrQSMOruQov6GumKigjXpZsGMhRvegUmwhx+Lm9Q3hB/86
         iAl+2XLS3x64tchPlMFtn+OQeC6qLKYfzXz8zchskFfvhUBQTouyIYwS0S8gh2XBcJod
         dXrwi2bjCjeV4LW/spWB8iqbuQW3SHhrLM6alUlZZgPpMdlUxkihhgQLLl0sHuYXO9+o
         SQGHUvNOp85c1tab8v7uWToV6LIQX3vBBkrJSZzaUxNU+aPJZRVloQ7iN/NB4dResrpU
         /qWNSQbPv/W8RPTeXnF1PSJXJb20asr+A+GK3+BXenwhQ25LQXnFi0dKrKFswzrrE9DW
         0y+w==
X-Forwarded-Encrypted: i=1; AL+hErFdRnMzgj81wHNu2UjTlQPqTTl4hPOx+eZ6Af9YJZn4tO+fa8LWWq8p89cjlHW5cejnZveHysI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Th9/klga3nStBlidOXosaY2SrmPMYPwfRw3dmYgiSRKgcLfOF
	reBcg8tC4P1bYw/pX2lboznvF7RjdcVKUDl014jhwc+FeD+rlmqdYw3+
X-Gm-Gg: AYBFou0rvr0vENOS+LtmAbN9elHqnLR/aK+8VXiA5gYyWVFErCnrT8awdBzAM0fRUCC
	qZtFhM2OElJyCWFJ1fjCC97GcWTpl7g/e9rgOYjdDATU/aLpeg17wdEpXx1u+PxSnixzrhzfYxe
	+KX+R0zJG531g870OGk+EAIDR4TvGAPTsqaOCDq5lrLG60gmOPbfKfhGS2MzXvklmUHmzI9dASp
	Z95m1NlAdi3uWoMEan4WpoE78J0M0kyzZFI8PyiA/IPzz+HWNk/fhq57CgYPYJLZbZtefpaC4Tn
	0dQ4mszIRbjV4KUhBNvucyoEGba3r+fbv8sqYiMG8P0Mby9LWQrHodbrzom/++HbjoMBxVI9pvR
	HSZzAvLIxXJF5PLqKyPuHTCc1fDEtc1XCmapFJpwDah+PTMCC4PVL/A5xMkIT6+yDVvKIGFSZII
	l3oI4sDIlHSQhuqOAnPnBccZAzdzv79IXxYkLrmYKX8UzECRf1Q/O3pWIOuSzHMsJ0m5Mv0wvcZ
	g10O0Oqc3zB7pkY2W7upm/yeKuXJ8KL6vIFOVE4Wq/5RlkNopsRuDKvi4Z/eXQCc22qiIhx4Aeq
	TY/ZctAtmrvZ+QTxlhXa6mc9j1FitAK8sK5IxreNyTyCu1Su8CCKmBYenwSgDuX7tc/8g0TJ3C4
	NJ4+6crCfum8TXLtpw7yp8ev9trKAVKFKatfdJDbFcx0Hz1Nnr3LPCVsh62yR7qfHIN+uweGwxb
	otLdVBj9gl0h73SKtyQaCr9CWSScrrZOlAK2dFD5RJj19hvZlTFho=
X-Received: by 2002:a05:6830:2e11:b0:81c:4784:a5e2 with SMTP id 46e09a7af769-8628980b3demr10326540a34.6.1794808881474;
        Sun, 15 Nov 2026 22:01:21 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm9375160a34.25.2026.11.15.22.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 22:01:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 23:00:44 -0700
Subject: [PATCH v6 3/7] dmaengine: dw-axi-dmac: retain descriptors when
 termination times out
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-3-bcb23d1e7029@gmail.com>
References: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
In-Reply-To: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

dma_chan_terminate_all() warns when the channel enable bit does not clear,
but then frees the descriptors and returns success. Its synchronize
callback only drains virtual-channel callbacks, so terminate_sync() can
also report success while hardware still accesses the transfer.

Return the polling error before detaching descriptors or changing the
peripheral routing. This keeps the transfer resources available while
the channel remains enabled and lets the caller retry termination without
treating the timeout as a successful stop.

Hold the channel lock across disabling, polling and descriptor detachment
so an interrupt handler cannot restart the channel between the stop check
and cleanup.

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 405ab9a78955..040c12d07db2 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1185,22 +1185,25 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	int ret;
 	LIST_HEAD(head);
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
 	axi_chan_disable(chan);
 
 	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan,
 					enabled, !enabled,
 					1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
-	if (ret)
+	if (ret) {
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
 		dev_warn(dmaengine_chan_dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
+		return ret;
+	}
 
 	if (chan->direction != DMA_MEM_TO_MEM)
 		dw_axi_dma_set_hw_channel(chan, false);
 	if (chan->direction == DMA_MEM_TO_DEV)
 		dw_axi_dma_set_byte_halfword(chan, false);
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
-
 	vchan_get_all_descriptors(&chan->vc, &head);
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);

-- 
2.53.0

