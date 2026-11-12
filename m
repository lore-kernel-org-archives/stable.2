Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471789;
	b=xxxWlj5exIrapUHBQPYCrdOcZ10ywy6Cc98H12la/49V0iX5RA2Kqd1JLq7Ai8F9nszV
	 08HoUuhLj9zNDrFScmuqIT6aJ5edJK1Y69Drk7P8/b4NohwRykGxdahq67b8TAWYjsgIi
	 4SRL5MJRB+nWx6ave1S462AZZ/1xDfuA5t3axBBV3xXrw+r7rhDpTTR+sf9sYT4MZ9K9q
	 g/ypeoPCkt77qu83I6ToM93l98Ea3YXJFYRxr/mtqgJLwmWSwopmfr0i+/mss+guVXWTd
	 XY3Dv5iCsMou7vvGoDc+MSGVYkTMixZGKBn0og6h2w02+v04fq7b32U92lcW1opUDyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
	b=JeFRyBh09oyAbQOQ+jyP7vtrSPh7dax0tdv7wYNuleov60s6n+AwMiMhT2feX/1Xd8kC
	 PWahggUaCm+TBmGRUJ9xwC/Tk+zM/EHvNA8WUwsz2JJ1ccS1Q1yfc8nZO24srS4FzObG0
	 yRj8WxT/uBIpePbTeDG7WCyVEw2Ns2inzWfm4JPN3ThOSjJLq4+LsIq6QAPoYO51cHQSn
	 rpqRUFABfkWJyszDpPfAv2SAUgJdlbV1+1PMtgswNqm5TaX3gKdSTsfuCMm3IrSkXysYM
	 RIWao7e8dX1O3xk06ajVHK/IN2WW4fqorrP5Qz77OFeYXeINno9cjwfGwWN8ZTgO2GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eBmUcZD7;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF1760A2603
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF1760A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eBmUcZD7
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4a76f63b243so530805fac.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471787; x=1795076587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
        b=eBmUcZD7RDwL6scvKv2mhhFTSaZm6ZyosW7GYAoaRF6RB1wdDUoM8cIgPfMg4TXV9S
         Ikytfuzn/unSJuXRhUdnuDgVisjz+bQonw1KKn8tGfpannc6xNuWpQTjLYP1X0II/Bo3
         pAAhGIC3lgZztPUOsCjDjTHVqMr0j2BhkcK+aqHT7i8GPyrj4gZ/Rl6fUOEF0gq4Ggtj
         mztuY3LAVavof1KCg+9+KksseKmDp34z2BfRHET0v6yndglB8oy7gvmHLfCoeIoiU0v8
         DU6H5jJ2FkPveORLLboDtJJqagJBBbjB+r6I51eVmstDw44J8pEr+QPGcC/N6pDH48Wo
         RSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471787; x=1795076587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
        b=kU3giA02cS5Vub51xsRQrtW23uWuVWQZ73BDsME6i59cTNjnOvPANTfGW4Ui0dYawJ
         0eo+lq4jY1l1L8LEDSeYXaNC7+9GSo5J8P2cW7amMV9JAM8CyXWOW0nDSjE4xN+hlfjc
         QVQdd460eV+SqvFH58JSeanZD1W5oF8uh1ESY+s0Tev6hOqTlCM+DFRqk67Nx9ffGvgM
         6EWdPzgowdrjEbDL/QyVeL4jBmC1ha8ek9A+9q4tohefHuu9/o2C4izcWV16QW5pT7j3
         KLNZo1dKkSc4OvRD1kXAwLdyek4dm3w6LkK2K9IZklEgOenUgPv3BKUl4ENXuj9m3NoV
         PxPw==
X-Forwarded-Encrypted: i=1; AL+hErE5R/F6z86zScAojZDcqv0ZxKzF4pD2IzeOTrjLDMKNvCeAbWF4+JTTRnmvTsrXNUEqbrQ05hg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iUxI4tv+1p+eyG3YmMWcU+MzRkLxUxI27l2tcXw62K2qi4JBU
	Zqx9pJ6Dizcvac5j5bbxsINuI/4wu0P31KzlXkZkMUJyyZvWMg9WH7Hz
X-Gm-Gg: AYBFou21lALdksQn48PL7iDLeXWn/yEcf8Eqnm9KdHLWrYnnVJthtg92PF27wfkPaNC
	J8/asCUkVi6ZWMqCQd8jFeBVDoSInhu16YlIa5grq2gG6suzm6crekeO//9/jEX+wrxbregHw5B
	EIwjJHJZaJW2w7GEmUDuZDZda584AY1e/YwOmYTkG4PcUKTKY96zaZYO1ChMdZNwLPmBZV2dpwO
	ojcEqRNM+Lx6v+V3Ru4NMqisCyUXYQ+8FPPlPPL6QxXHvc+I5Cba+3X7ILbTqyihCK0KYvxB8Mh
	8kNr9EIrERuEy+o9NHh5Q2POavp0KGzdIDtBWQJ/eYQ8/i1r6wI6R0ns5AQJZ1eUGtTFW0eOO1y
	fFiPlUSML9O8OMhH8EUeH05r+QLtSfF4Y0qmqNkb0lq22zVRdUvqtBdEd2yIpLBwh5ygshEg6wL
	pr/vnj+zD9qWeKeHNmfNYvzthKgRlfB60tkVC8Fn5zcSWPdRYgcrhut+e/4Mtpw8Tu4OUhrKT2g
	A/qmPUtGaBKFaeJT7oz5lSTpjx310nLZF3gv9rW6sYRgQ7n9W4zKZpsjauCTk/Uzs97WN+FXh3R
	IQr38BodvCMYS57GWLL0MpPbL5tWIe9e70aGpn/MyvixEwPKCwCWb1EMxiIwuVz4yN2da9ea0Oi
	t1sqO+3oRq8t7NkM3oRquN42fyiv35eYXFqUnjimkDDO5L072EeI1hZArovxoktI4YtMo79hV71
	8fr9wlXZyOJNgwUum+eSe/7nYvxLmNLf5tOq+zCsNwV3W6h32tjBgI
X-Received: by 2002:a05:6808:508f:b0:4d6:9133:cff1 with SMTP id 5614622812f47-56cd673ea55mr1534867b6e.24.1794471787562;
        Thu, 12 Nov 2026 00:23:07 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905d3bab2sm7411157b6e.12.2026.11.12.00.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:23:06 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 12 Nov 2026 01:22:53 -0700
Subject: [PATCH v4 4/5] dmaengine: dw-axi-dmac: use atomic polling for
 suspend acknowledgment
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
Message-Id: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-4-3ebc24b243db@gmail.com>
References: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
In-Reply-To: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The pause loop delays after its final status read, so an acknowledgment
that arrives during that delay is cleared without being observed and
the caller receives -EAGAIN.

Use readx_poll_timeout_atomic() to check the status after the final delay.
Keep the two-microsecond polling interval, 40-microsecond timeout and
-EAGAIN return value when suspension is not acknowledged.

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 040c12d07db2..1a53fbc951a9 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1219,7 +1219,8 @@ static int dma_chan_pause(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	unsigned long flags;
-	unsigned int timeout = 20; /* timeout iterations */
+	u32 status;
+	int ret;
 	u64 val;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
@@ -1250,12 +1251,9 @@ static int dma_chan_pause(struct dma_chan *dchan)
 		}
 	}
 
-	do  {
-		if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED)
-			break;
-
-		udelay(2);
-	} while (--timeout);
+	ret = readx_poll_timeout_atomic(axi_chan_irq_read, chan,
+					status, status & DWAXIDMAC_IRQ_SUSPENDED,
+					2, 40);
 
 	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
 
@@ -1263,7 +1261,7 @@ static int dma_chan_pause(struct dma_chan *dchan)
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-	return timeout ? 0 : -EAGAIN;
+	return ret ? -EAGAIN : 0;
 }
 
 /* Called in chan locked context */

-- 
2.53.0

