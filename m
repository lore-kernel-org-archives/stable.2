Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202051;
	b=MlZB9Hz22Nmx8R0tkV9f6aoxj0q9XpYoJ8WdYEgWvUHwpQoNfUfqkYHzoJAkSaR2VoLU
	 ASYZ8MAMSjIYuFyRboA4mFdwLJG+Cb5sY+icp091ahPf6z7ZqFzbdLEVDP8hk6Wr03pQE
	 DKORUMhnMVME6jJlh3BNtFxARFvv9cB6jx/vJsydaqJPdOMVHdVc24iKfXrbBsc/zg59n
	 R+nWMSb4+E142xd2BTOZ4/eV/8FHRDGX59G6ziVib3uSUL0S1CVTMPDLq8LxyqTA2wfen
	 BtwUBNz1eqp5EnNZDiTzv7AzGb8yYUqNVwTj3H37eOP6Kqw2cw1fSTB+ZgpqqXz38GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=U3pz11HTx3wEJXUIblUFMnPhV1TcN7plqKmtgqFKa5A=;
	b=LFuHnqlf5A1HeXcqcXW+YbpL/DxC8DZyo4lw9vbUaiuz546EcaD1ZDMmCJdAgjOWS6rk
	 eVTZVtWC7bIJny161zliC5zW+YDaUvbrQ0qvBILl2HR+rcFUYyPiLzS2TURf7x3O4gNfp
	 XN5ArsUuL6xfvQV3BAhRThyOkq3rmVaRJdmQCd+dhD0VYIcHU3T/pYj9Ihil7/7xuI9+I
	 ModcSa7UzWK2+5T6ZbVSCJmbIgoxa68ZXN6runQO3tOH6uy5ouTX0y51a+PoVk2tJgUJh
	 Y13vldJyIOYZo5ZLfnTykt9hFv7KAUIjlxBG1XL7Fav80W1Zd043TQc/hKSDpYcKTHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LElRle4I;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2137606A32C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2137606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LElRle4I
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f84a55e31aso851124a34.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202043; x=1795806843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U3pz11HTx3wEJXUIblUFMnPhV1TcN7plqKmtgqFKa5A=;
        b=LElRle4IhO0HGc55HrSqtEHcvQCwYE2NHQGfCXGz+MY370KAJ8SELoCUXp9t7dB2E5
         4+YXTrgtKHQv2pwoKpNJGIKPTCrN4JCazFE8LIehS4ElBJC/NTbiDXiirpfdk4FnC3FS
         sa0cVxCcNtSSBsI5zHqCR+/GNB3GF8x6NayhYxSBK8ISYY0U4AIzxN41nn3DqeS2TG8L
         n9wkH/laAyVMT0FgMkrpnSJ/2R1epbnKjeziIS3abS62vpyPBv8thCG1bgOycD1BfprY
         A5Q6BYHEcbIUwSlP/qKueL6Zv1Tysjg8BDOf457Mp/BhyOhFrWERVJds+GHB2mnAgN+c
         4PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202043; x=1795806843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U3pz11HTx3wEJXUIblUFMnPhV1TcN7plqKmtgqFKa5A=;
        b=GJ5PLkW+y/N9IKXlGESPSmuVYSzGpvxUlHY6jinpZZ938UQmmb6OcTKW39gRIBdMRP
         iPAsh1QFGTPnZMKUZ36RDM/pIPgAknVXk/xge5YQPyheVn/hpRWnbyyfIq9cfwtHXXzs
         shhHXa74fiy+sP8dXHAcj1oqrLuNoZxaR84lFrCziv8eFUZ5NmPhUPJrRZO0mXjs5YX1
         JfuNgoOfLmQ1MwtHJLqsVX3BcjM8PM5/D3YQVPI363uWTRMeGwB30tQDL9AbikGoiDEK
         IiFx0XkGTv70peHGhGSHl1bdZ1vq902iNzcQwS72H2A9raSPj77vOqS9jHxLanhPARkH
         CByA==
X-Forwarded-Encrypted: i=1; AL+hErEXonxMpYcYwiXVyjZHibeEoSempNgLZddcYI6rWFxV3MZCtX/zDFC5JSVFR5zCmQdBxpvjDNo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ro1VpdMeRm6b+lXZg6kpoX4jKHMoEJg5x/+/0qXYchH+7zaEX
	zWphsZdO1wCZAipSA2B2qY++bXuE2svFGGyRYTRr2K662xvns3cfn3dy
X-Gm-Gg: AYBFou1KZmLjnzV8x1FhTkN88f0sDtUgqmR7o1GJ9nror3Hsnm9iQE+MBtOwLj0zkFl
	67FUlvZTmVwzEPvM/H4SebedhWmAk5W92tDcApvM8K6jYe+e2NATnhyIJJPmT0ApeS0WLp9sZSR
	+HETcThP+scmpYuvbmISloOf/hnyJwMGKM6Ak9zRLzzLlVwTRmInOOfMVIgKurCKNwau6552+X+
	REajXyc/M05RkS+1//kFm30sTRRFLFanpP3bvZmivCPfTQtkh5rLKj7M83JrcF634ji87dCJr/y
	W5QVW0eMMOX7QxbaHQYh0tBk3HQ+1QkDms4/pDjLPC1wql9NLTMxTaJvk5LY5+Ts5rrbGWPZ79S
	2cIId0qXu8OLKg/XepQVFFOxBR/woFbBJet3UcQxFkOzktyxpGbqtMK0qvSPkAb8vbZ0fY/DUT1
	ccIklrGDtgffQKYNV+0qs8K1wFQG0t/LMVFR+zf+w69UnnTad8va6rYU1wmbDEw5wbrsqzgxwH9
	ttZq6l9J9cFuirVXGHYUjCz/SSMwaTX7KoWcAFUwXB0E4q6Lyvw/tmNyCTzUw5mauhjBMVKMp6i
	Q3D2Mb8ORDpUrEDeRvf6dZPZKojb0xO+Qq/zyCNmO33BO90p2eiX/yM7OW+xhrvb8IEBaoTL2zo
	tqiJqF7/BBQjefAU8C/AGIZWrnag3oo3xXykGliNzizM7haaP+plVajd97URcLkNeaYFFXh9NWn
	pSpPp6z1+EU4IFTvuglQTj6kP39MW6FQi2g++xGSKy+l8r7mZLd9zM
X-Received: by 2002:a05:6830:640e:b0:862:c172:769c with SMTP id 46e09a7af769-86315ab1b56mr5230953a34.29.1795202042690;
        Fri, 20 Nov 2026 11:14:02 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f3964sm2654782a34.14.2026.11.20.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:14:02 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:13:53 -0700
Subject: [PATCH v9 3/9] dmaengine: dw-axi-dmac: retain descriptors when
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
Message-Id: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-3-48ab58961d6e@gmail.com>
References: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
In-Reply-To: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 37 ++++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index f17a71183050..def591fc75ce 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmaengine.h>
@@ -1180,30 +1181,32 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
-	unsigned long flags;
-	bool enabled;
 	int ret;
 	LIST_HEAD(head);
 
-	axi_chan_disable(chan);
-
-	ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
-				       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
-				       false, chan);
-	if (ret)
-		dev_warn(dmaengine_chan_dev(dchan),
-			 "%s failed to stop\n", axi_chan_name(chan));
+	scoped_guard(spinlock_irqsave, &chan->vc.lock) {
+		bool enabled;
 
-	if (chan->direction != DMA_MEM_TO_MEM)
-		dw_axi_dma_set_hw_channel(chan, false);
-	if (chan->direction == DMA_MEM_TO_DEV)
-		dw_axi_dma_set_byte_halfword(chan, false);
+		axi_chan_disable(chan);
+		ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
+					       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
+					       false, chan);
+		if (ret)
+			break;
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
+		if (chan->direction != DMA_MEM_TO_MEM)
+			dw_axi_dma_set_hw_channel(chan, false);
+		if (chan->direction == DMA_MEM_TO_DEV)
+			dw_axi_dma_set_byte_halfword(chan, false);
 
-	vchan_get_all_descriptors(&chan->vc, &head);
+		vchan_get_all_descriptors(&chan->vc, &head);
+	}
 
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	if (ret) {
+		dev_warn(dmaengine_chan_dev(dchan),
+			 "%s failed to stop\n", axi_chan_name(chan));
+		return ret;
+	}
 
 	vchan_dma_desc_free_list(&chan->vc, &head);
 

-- 
2.53.0

