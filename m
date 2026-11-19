Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104113;
	b=QBX5Ln7uSKXzflQ8vQcalVfrVJLgs+63ip0pP6TVHoHa29XxGdLbDOiikBSXu0Nb5zEe
	 MlYa9/a4nimpqoBTrwgohx+c/bGqSaM+XgeBrKAuR7i1qpmqTqI8fTwMAVh+aXyI+LOrT
	 wCcLwPBTIaq7VrDoQDW0RJPzxRkm+iQLcPkwMBRC099kLXEMTFMxWzz8hhJyiVpJa15X+
	 l8EjcvcM+XgXItGp3sqEpRbLDbXviPN61rnXMkXCXk9OYqfd3yXsi8fyU4iNVdPN/7mKx
	 b6xMg2vne+Iy8jgS0wRO1xIPI8xc9ZxlNu4FYMCdvZAwAWNzCzq6qvYKNTBmFV4LPNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=euvHppXysFAeHymgmyGNBpfWO5+extXbAkR04f6pvro=;
	b=A9B9OU02mTOKL6DBckbPVZWGRgEj9oJ1K8300cG/60waeB+nDFIkdQhxAk8B+juJz0wl
	 jLMW7cy9NIKLC/ouxzYUMIv3PvTBzZ5F+xJfRoAhWNGwhtcMbkKPpc2xh/a9vZw2RKvJS
	 d/eoEedgcxaQCMP0FAjLyTMTaQ8iXtTFfRamIMaERsz+Wm1o833Kk7xZRG6OG64djMesD
	 u60K7Td7p2B8QPWuP06W1yiXD4bn3oGZA9/W3eG9Gh43AOK05R4b/gCGJZ3X9irHtHw3e
	 tOGnid9b3u3RYNJBAYaELTAcTerz0axwcCKbxYitEBSYjSrLbuF7mumHA4ZldhQ0CNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wGGCd2Ez;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4F60A262B
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B4F60A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wGGCd2Ez
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b4b9ba815bso15865557b3.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795104112; x=1795708912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=euvHppXysFAeHymgmyGNBpfWO5+extXbAkR04f6pvro=;
        b=wGGCd2Ezptp6rVA3z5qs/3fWDsqW4j4+oLPC3dAsD7hPn4cCzRq/EeiC0pV4Njb/3N
         Mse44Gw9BhKCfppcVj+8Brl/wgbxhJCzEkb7VH6wa0gE8JEU3QWrVNkMk1uNDX+kvPQU
         LbcNymDnne8iPNHsIkk4qGvsLOQ0LLbeZXsHSPhEP9B8hgd/QhpwBm1tjUDpNlnXPZeY
         pp3XkIQYbAW7zKbqQRmClC7UdzxmfBSGH0ZnwisIlquPSCwBVwA4tOlsl5Qu8r7SuGUJ
         8dg2R+NG666Q618FSy3JvNORiC7Qw1G8x4Oe1+UDXFjCmyrWIzAsWdMvXDCx0gcpFyfe
         FTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795104112; x=1795708912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=euvHppXysFAeHymgmyGNBpfWO5+extXbAkR04f6pvro=;
        b=em2eAHHbg8FJNkoiSZHl4Vr8bXnABWzBilgsmL+aPumiTS7oijzJfxTJpWngvKb0NJ
         vX1+bgYOTp6k2yxkX706Szm1CcbWESJTTd39rxpAhH0HX6TuSqQhNgA+9A8bbiuYw5nZ
         wNJ0PCRmT/PEvvkufhrR9b0kavLgC8Viisy2toKObuQZXFgNmKuwjRPDs7QikZn+cYG0
         YpFJZFToyi2416yeubL/+/xvwzzUJ8vbX2hM1ZeNTOos1PTUcQx21CS17qiv3rQEhykk
         4bKX90sPk/NM84mCdawlA/Zy66he8bMDcRk2woy/sGZINyUSKquXGdw7EpF057gxNVEZ
         AkBA==
X-Forwarded-Encrypted: i=1; AL+hErFRH66tnuyVK7xnTxRz+EuJ0n4JJPOw1EHBtq3NlRvj7QJf2OkvZ5mf5qxYWQ6KsI4QklKSZig=@vger.kernel.org
X-Gm-Message-State: APuU4Z+B+yNZ1loJ7zHoHHWGs0mN9pDphyQxH1MjPNAi9k7b84SO77ZX
	/v86sr4IZqY23hCnxOmGYOBywUL/Q5IkLAJ6y7NRfJoPNijvmly8bMQT
X-Gm-Gg: AZFdTZejaOCB67guRp8BMbM8cbF5f1i2N+FHWuJjtH+NWBlDYaN9xcIJYwygnyJwOsa
	6UJxfk9CmPpPwGC7jHUIsS0G06u4DJ0wPKE5DQSB8fjRx5x1ylkwupv3KNKyIgNmAGAf6yA2Ftd
	jv7ZUH9RVEpW306zTCXFlgedP75/N8ypv8mx0KlEv8QJ4obbxi6S4tZ5baqRSvbYLurMrgenVAf
	br2mL0DXEVkv8GgVVXiC/0NEvTVx3GIBnIxzCaQNc2L9RqBiE/UKd1+f3EG5MEYSvgFiGHU6fra
	3odebFy7kbtUCFj/X6FAQyrmcH1Z9Rk03LHLr/TNqzBCGd+slnXCA79WJvFbF8LhbaH98r0YxjY
	rAwMoYwMSY8Fo7s0sDXfs0aUlxDiderrnYdsS5BAgm35QJhjwitjkQXBEKN75PTEKO8FgijgTi2
	YZ4F6bg8p3vTO5ByFuUg/S0uq9pyvfe+yDNRroM/HhqWmwQIlyn5lkG3ZEfTQtuigsSwr4+dv4j
	UchuLCTs88I/DqgDsVCFtWJjSmqbcWxdc5VmeXRFMLkzMlH8GgaC1r3RpQ8gXzEXRdfx5xHxKcU
	+q0zIX4UcP+UFo9DqXUdLmhypz3W2hd7PyPCAb5VvYOTSUqEkYq8c9XXA9hljfgaXpHplsLQvxJ
	F2uWABkI33UHdsWKRMFG5isEUZ6xE4PBVzirqzCBsKNer77GVTe7640MpUmGc+ECDoA12xJZpVw
	gC+8OyGXtSi+cKfd5eB9H3N9/yh7s864AubvdYdKPlryu8qFN/nZU=
X-Received: by 2002:a05:690c:31e:b0:8b1:7072:a61b with SMTP id 00721157ae682-8b520496861mr836737b3.22.1795104111812;
        Thu, 19 Nov 2026 08:01:51 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52031aa4bsm623267b3.34.2026.11.19.08.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:01:51 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 09:00:59 -0700
Subject: [PATCH v8 4/9] dmaengine: dw-axi-dmac: use atomic polling for
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
Message-Id: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-4-f8e7fe60594c@gmail.com>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

The pause loop delays after its final status read, so an acknowledgment
that arrives during that delay is cleared without being observed and
the caller receives -EAGAIN.

Use read_poll_timeout_atomic() to check the status after the final delay.
Keep the two-microsecond polling interval, 40-microsecond timeout and
-EAGAIN return value when suspension is not acknowledged.

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index def591fc75ce..8c115d20728b 100644
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
+	ret = read_poll_timeout_atomic(axi_chan_irq_read, status,
+				       status & DWAXIDMAC_IRQ_SUSPENDED,
+				       2, 40, false, chan);
 
 	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
 
@@ -1263,7 +1261,7 @@ static int dma_chan_pause(struct dma_chan *dchan)
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-	return timeout ? 0 : -EAGAIN;
+	return ret ? -EAGAIN : 0;
 }
 
 /* Called in chan locked context */

-- 
2.53.0

