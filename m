Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366922;
	b=WgYqZ41lKoOjdqzWkLJfRRcH8thLQE57tdu0pIbZvTW02Yz/1wNXucuBsDjWq+6os7z4
	 pYuCOzEEw5etCrAUFuK9auTCdQCnUgVE1Y2XQfpAY5YU9u3FHkYOePTyjw0iGN1iiFsb7
	 5VpgOTtsLQXoOmB7CSl2LUJat8I8JypDY4JgOC9Q4LQWB2R7TyT95mrbGjdEQAaV+vLCc
	 CLaYrfz6pTPzUZDr3cK0nqzfVwkFV81RQ/IlNe4cPV9s0oKXqil81l/TXoxv3wbzmc+21
	 WeA4jzIzG7XuY1UOD2Vw53PBq7TZLl850ZkDLbWVr9Mw8sx+jlKfCfbOHNn6WXxPmBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8XcBdNuRMoaATT6u8r4a89AF/r4EjhS8wcxyVTrRvag=;
	b=te+ovokh4OqR1pSztu/lOwKGYjzcOfRZpB5twEZZxnQnsr8SxZZmgURX+DCwlWRKDafQ
	 sQnn1E3FsEn8WylQP57Uz9dwmqiaQTNqUrKAq0zv2TTi1fys52bbMInEfv0t2FPgiZ4Ku
	 FAT+MfQpOBAN3UdbYROv05JFNRiran25CaVRslfK4lrPIRxzpdRTEIRYQ7A/ldtUwG6eW
	 cC0W9ysLzq3tbQZ7XAXOjXegIR4soZ2xsD2dCJiHzuLD5/qBHswwKkUxHM0SHKeOztWPQ
	 e5iKsS1S6aA8WjRP4RbFLB7XUq34/C13x4aZ9tsO/NGyYufBj/yVr4u/UsrZoHXPpNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z5z5a6Ih;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488560A260D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A488560A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z5z5a6Ih
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-53656465d1dso1299047b6e.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794366920; x=1794971720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8XcBdNuRMoaATT6u8r4a89AF/r4EjhS8wcxyVTrRvag=;
        b=Z5z5a6IhtHWs0lSoIePVq1kSkSmClUqbm8oKEoa6pn4/nKodNgvJ2ufjUnu3DaLn6j
         Gb5B/fKhn5BOM3BM9T+JBYHQ2y0oRPvvPGUUHG7qwpXc2slSdG5070NT7yflE/TObnGS
         d4iQIUSmQzQyIiE5uYGt8KM06wkb1aTSjyCc61Ja0gZVGsHERbJWWaxDx04V7YN1g1Gt
         TOKikNbAmPIYmlC8BoLjwp48gQZ6QKL4uoxJj5rHABmZwFApWg/ijgBwd0jUDmZzQDtl
         rn9AZOaI6zjYtrENcRzj5GhRHf6LKwNNgckiBf09+YqM8nj7JGDrlMjNEOicLILn2qtH
         7j2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366920; x=1794971720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8XcBdNuRMoaATT6u8r4a89AF/r4EjhS8wcxyVTrRvag=;
        b=tFhrZjdmXuit5rg3Iu3ew/QLkORAE3tgIcogiKX3mQmMt2SQ8s1I/z95VlY7vvJ056
         RVV0HORYZud8dgES5LEHueV65fJHejK9WG20O47kEt0/YKZ82urlPXV2aD758O/pw7Az
         gdEIWenywcR6172MvX1Yeaxi11ascNhOCpuDPaa8kOlJwNQ93O5devTtPtoBrgOd9hsy
         ib1jR15wKdNXTfK0vIz5oiJGcO+ogbmNzYVKk8NGOXdqxbELqcSacI8A02HJdRuLxvFR
         tUJBYJ3AWqTpZj8hELaNTXgGCkHw346Mdrs7YjJetsH8MDw5NA/82fd6JLg5EVbkkIzG
         HKBw==
X-Forwarded-Encrypted: i=1; AL+hErEmISx8fUb0zcUte9Axh9hDuqP2Qfpwgx8Kf9dRgoJkYhB4SwoQGHRelwOEZ3ckqycCx8voEd8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XdJzU+j5zuq+XjRYsAWF+qv80lkd6z/0AVQGJN9QtGgs5Plno
	UVMOifIIN9Nkd7RE9Fly6yWNsXqPn2cVkUg1kvKVChe2dZNSZsRvBtu8
X-Gm-Gg: AYBFou3TDu0dl2cW7xUIz+TpMgDtzWNGo+y9K5DbdXTzK+Ai5uxuUgcZHDOyZQLmJH8
	gIqsNO1yqKm0DpA5+dCri6U86oNLJp+Bpe8JFSS25LIg4V/dmGW8VB8ocxhBGzJRhCnUz1b5Zik
	gMsWWADQ964B0/ChpxZseOXrsP/DnmA+QNISJAbiQv1K0L40+wYl+WhEkmqyIx5h58ZcOcUP4rZ
	wPEOzmKHP8+E5Xf+xmD2PUB4U0nW+9RxGHq3JOTc++dm9oEotXT17mqck08Yz80cAvkbMyHDeWb
	5enqlcJIaspf1gO6NcpX37tM9LxW/tJVvrHlEbg4WWe18mQF/bti78tqw40hRvZS63Are0kBASD
	1bOo5d/CJ9ljGKpFLwveNfAfyDST2nBvdTNJmORiL1OzfGM+QNBWSO7dLtPWp9kWzaQAmaW5Sj9
	5elQCk09I8mnZXqgYQc+M0yW5zaW5plIFi6XcsfjTvCkwC/oL/Ootaa1BSd5o8Ww0el3+inFZqx
	aAOAvnzR8ySxAE7vKdV7azh5goYD4RIO9K/M0P9L85ktmo2fAjcYNmU+jWbsyDws5nK4BeVXX/m
	aVc4LMIAThhuysdp2EpbYSmW8ZMU96wJiGksV0de3M46jo5Wwc3dsCaJvNudBJvncGsJgMXc7BA
	F1qZ78VZuWVQMwBl1RNmFbD9A4+ngPyYHPYO8zkoqEGM5BnwVpXF7oRYacLkkJSn+au8BbuuCh4
	A3eLcjpnczo4bu1zsp6nU1cc2N0u9ytZx86ZCgiDalMRWZ4zl/xZpzb7KuxjOus0x/lOk0rutB
X-Received: by 2002:a05:6808:191f:b0:4ed:7045:d3bc with SMTP id 5614622812f47-56b97507aebmr1037132b6e.32.1794366920529;
        Tue, 10 Nov 2026 19:15:20 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504fdb5sm3999345b6e.3.2026.11.10.19.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:15:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 10 Nov 2026 20:15:14 -0700
Subject: [PATCH v3 3/4] dmaengine: dw-axi-dmac: use atomic polling for
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
Message-Id: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-3-35fdfba8b61d@gmail.com>
References: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-0-35fdfba8b61d@gmail.com>
In-Reply-To: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-0-35fdfba8b61d@gmail.com>
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
index a9a87589324d..bb305ab94d02 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1222,7 +1222,8 @@ static int dma_chan_pause(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	unsigned long flags;
-	unsigned int timeout = 20; /* timeout iterations */
+	u32 status;
+	int ret;
 	u64 val;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
@@ -1253,12 +1254,9 @@ static int dma_chan_pause(struct dma_chan *dchan)
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
 
@@ -1266,7 +1264,7 @@ static int dma_chan_pause(struct dma_chan *dchan)
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-	return timeout ? 0 : -EAGAIN;
+	return ret ? -EAGAIN : 0;
 }
 
 /* Called in chan locked context */

-- 
2.53.0

