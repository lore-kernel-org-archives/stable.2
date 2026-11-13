Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562605;
	b=qxZRucQOiZ/XOZx+63ch1gIV5P+GDxkixhTozQnvLzxLc0uheRhrYArZMh4LoYaHJDE5
	 9viUXh4PFsctyf9MWidfNDS1pZGMkw3A6F6IptCnPGAm3ciyjhYzsK2Ij4Kr6Y3i2VTXZ
	 8aQH+qfycGGgYoHJxUfVRdUNUZQUqWHEnTXwtLGlabKvPSujzwXraIhDiINq4ybjy2K6P
	 o9ZQuAHqvkiLOjAEuVSjc4Vm+jadd5u5Nn0jyyk/pTKPWaskeaYSDJAhjg6ACddC1VUKG
	 jMDT2M6n1BxKUmfE/5znUjP1Ltc7MEMj5x3t969biFLuQb7/wtczizXIyncwYcA4ZTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
	b=3PZMUbvq+Xs7klmgFzOr/Y90a6e4ZUNY+bLxlA48VOJrWV2XinFTun0KEHbJfseaidzp
	 5A+JeC3QAH0smQNmmxCKsaSjoioJ+9W74IQrgDb6eXVKYT3L2ZcehN4KfcxNJ+mMZmbr0
	 ytLP33nm+4B6gtDwSbWigBz0CabJjr7tKYhpPJ0zseYLpHKgvNdYrlxDtrQfjoVX5PDH8
	 BQE5yMehs+m5ITCgj4Ktt1CHit+85BWyYjuND16xj7ZRVTm5W8r/p7VTEgkyRMcyp6fhz
	 aR6V9iQKEuxvzGC4u0M7t1iRtRG3tl5P0NxigY2qZUAzfJyET1RrV//yGb6bRyQQX4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wBGbxXzE;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF160A2618
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DAF160A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wBGbxXzE
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4adae187d94so919645fac.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562604; x=1795167404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
        b=wBGbxXzE04sjmZWmBOamp1sP2/bnvrpmUJxEQhd4poKnqPWXnGr5oxTsQ8j5b2+Rlw
         efDtVYPZqbQRQHV317K6I/pwUEbqn81VLAgPkcUazleN+r5jEBy/9P1qp5gEfUgeylux
         G2jwD+QHqBcZDva13cnVqG+xKOLamw/0uAv8hXI6mRAjVDwWfeygIfhsRYs38addGBfu
         N1XhKlv6IWDdEtgJKLppw5Wxn+9QG/pPRcH5dMqkaQOQgvqEJ79oAfixCAOUXzilIbdR
         d5PfZXQqv7FJXXqRRqoX8mJK5q9DGbUjceQb0SEDSK7rRK7OSPoSBfLIe83b5myJLqzd
         6M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562604; x=1795167404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2k4jFluLeaP0eKylJ7J9HI4auhBjQtbrBm24Guvwz8=;
        b=paVtkErJntG95v8H3O8SMl9IviSdG1DQsRtp/KkTebh6t/BItUi1DYlQeXx2e1iSPs
         1xROvZlbRczwj9aumldw0btymIEJ/hl3kYIpoGOqVZMYTyQ0w4FARaHtsv/UMpYkMGXJ
         o3okiZpLzsDvl1qyTnbo7CjYeCqgvod7CK+n1/cpzFY0NV4kr4vMKFxi+fokc3u64MsZ
         cQ/SJp2Cyj9oVjx6vYrnf0MVnZX4bJH2dVhPAuJDMVuH3NU8MGRgZOl9SsqQmLujXWv+
         i03zp1TF/OBCI5KlWfN3aRrykUcIhwg5KPTQSWfq7RDVz9QvTomjB0Z1Eg4TBuNUYFyl
         c8qw==
X-Forwarded-Encrypted: i=1; AL+hErGe0L6MoQsLuOeSE/MDozuYLCtVVQN+zbeNz7IslGQK+Fpy6LtOiLC5xUQE3HlNX40MDF6gNSg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kKari4yV3b/EbcLIp49j0JPUFN9NsaYZxxVeEjogqKPdl9RVX
	rnWwxkxfKjM0ZtsLoRHXBPj56AdHZIPMa+9YPqGVGh1/6W8687nOtBAsntFSZQ==
X-Gm-Gg: AYBFou0MZw3ij67wiZ7y3Xt96ck09AHP/0SvBtlt7HqYvJz50V/vayVY69YsFiwQrf+
	ds1YTUYsiznE9LsovfV4N4SYvTUQq3iapWpuGplS0m2XrH8Q7XohvpdqUxafHxZkOTAoNX51NZq
	JFfjTn4put7refkCgv75IORG0YOE5GHOOZNGUgopA9hPpgQs8eCG+mgJAh1UJ9VgS/gMHE9kKdz
	UP+hg/teH5WisFornqPQx4X8PWHptTAIWDUqziyLvlT3TVSohkH/n1ibt3gSuX+gnK55UJVd0Fa
	HjWGkGigfys99wBMs7I2eESyKIYIrIWZkXrqnC59Xr4S56OtQVgK77BVJ3GU7iZ8ZQcyjRNB9KZ
	AW2m9B437T7uciqrywaDftiiN/2mxUFvke1it8yR6nlSN9Hi4aKF58AVLBOBVjUUGruQABTkvaN
	DsOL1upaoankJDIQFVbVNFwXYtxDr2Qiv3KDzWOjUL08teFWVcer4ZrvNP1xRqiDcBtFQmP98fD
	urFoByrcUIBIADiQ8gGcoPZF0w7DHXOS6+JJJLRzlTs8e44LnyJ0on7xD9qW5uEx6QymVEkKdFb
	bt1sffWs9ItG7YpNkgwuMIjxJXrS7nLEKBQnNKnAqv0XrnEiKyOMBkz/NTYbdcT91AoT0qQ8Yai
	5BoeyBGWhGX5GD9h2RELa3dY5f9aKx9hx9P10ArfNLDVCsXKDAvtit/WvdoyehTKXViV0HWVdFQ
	hmSgc0x0EB54lGJVrEQ5uz72ElRj3vv+pngYqCZt6IrBBv+xgH8WIa
X-Received: by 2002:a05:6808:10cf:b0:563:e8b6:c5d5 with SMTP id 5614622812f47-56e64cf4cb6mr1678912b6e.44.1794562604104;
        Fri, 13 Nov 2026 01:36:44 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e6fc42a8asm1627607b6e.3.2026.11.13.01.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:36:43 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:36:37 -0700
Subject: [PATCH v5 4/5] dmaengine: dw-axi-dmac: use atomic polling for
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
Message-Id: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-4-8523a27b5788@gmail.com>
References: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com>
In-Reply-To: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com>
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

