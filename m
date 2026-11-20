Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202046;
	b=jAtvahoh3SG1vpIadi/r4aFhHHsyVJhIxRUq8TOomIHWWvVJ+W9r1HGB8hcPh8H7QG7V
	 3zqxYHzgwFnxjQi9uxvz1EPA2zAL/MkEEKwgjLdc6k7W3aq3uolvYpaB5frdl8pxyHhb7
	 +n0kwjf4vCbRevtkjWC4YlH3Wpc6MBVMv4Owa5RodCqKWzop1YY1Pentc1LOK+gDrIy5u
	 lr7eqvpeKiJTHK+F5+s74pXAKANPlh8enOlCC60SQTPj9TY6my74rvDK//3QukF3xkxr3
	 z05bdErzigHeaBPhGu9iT/nFvHrU814nktZAHE6bQSbaInCWzMQZOTj/PSRwi5/d/Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=kH04HZ+g7FuN8rIrCoSeymODfFw+CjKgbXOdba7zXjQ=;
	b=gyE1ZoLSB3/xhTLW9JI/YpbJoOeZKJQ6nS+eJlEBWYNTkCrlVmwIgcA/zSPK6SM0Q3TI
	 UB7YsysSNWGwND1GMOAEWKdd6pU+d5VuTXjmWIyktmY84W3FpxAuBnxeiUogdofkM349r
	 37HNPv2Ek32cs1WKHZUrKwe4q7VRZ1JqSDOCpxbU9csaEafR7yNi6KgkkisGfA5gk/Nvh
	 hdx+WvHQjsJqsje2wMm+jDdQKs3js2ViQZyoq8pI4iwLuMWp1dgZHb2x8ogH/IQ8KF9PB
	 CPRWzvEYs6GKuMVA0bLxxjxB8cXjwmcVNmpwmJ2w7uUyp6jUf5GQ7niUagEVDfXp1Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7vfW7+8;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8AB60A261F
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA8AB60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7vfW7+8
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-86210f31496so793878a34.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202044; x=1795806844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kH04HZ+g7FuN8rIrCoSeymODfFw+CjKgbXOdba7zXjQ=;
        b=C7vfW7+8ov6CR4LH5T798HdG63VmH7oZLjAxE8SMw6Hn7Whr1rXRIwFQsCEiXN2BDm
         pQ63JuuLR3D/sGewSyW7SB6MrEtkjNknnNvPjT3LsSQuGr1U5yJE2Ti5o3f+Sxo2Y1xb
         5vJjr1/k7ih/y+I30ute24tGbiUGOs2QElFq0PtFXwCmGPEyCTxz81tx9KIBScTRR4oj
         ES059hqxcOH8e7BiZjvImBWPOA2w1QJ0U02fC3zsUnTbrrlumg4k1JTCBvu+9K4ItOYc
         qw0A5lIv74B6fBzxG0LurIPVSeLuj6cYWJpd4yiH82q0k653qtWL95Zy/Zm6Q6ZNCCJJ
         BXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202044; x=1795806844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kH04HZ+g7FuN8rIrCoSeymODfFw+CjKgbXOdba7zXjQ=;
        b=uViO87K1ZU6FAnI11H/GrDFu9/dEXCDiVR3uBL0EtyyhhOs20CnurjQgwCvjyTCoUn
         eu9jfD3UiaZSCGAJriq2cZkE/7qG/3jPdmtoi3L/DvUFdGwnn1g4qNXFDtc09sKZWeYO
         D5Q/2Pg5h0TFisiQWO18AZbyXgntYwm3o9vPLofwE9dWPl4ncFtA3WUT3xsKMjNQxDW9
         W6Ug+C9pLsf5R9sxTfhv8gGWvhEwMOhDzIqRl2yjd0HahZR9j4JPwrzVCEpxmnHtz8n+
         ICVHY3OQv7ZrNZ/V0ykOuMTUs4hDCtb05E+q+09qI2xLV4oVwNa/lKb4DPi8Oz1ow/RJ
         InCA==
X-Forwarded-Encrypted: i=1; AL+hErGgc0q/el34Ra/hxNoDPOE4r99H9M5cozpbb2rV4CxouVCYz16Gm+RAs57cfaySw8hTASv+mwk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EH6W7KO3Lfp10FLEtrD4PHJRYs+Yb5F5xjH7Q7n8Myv2oKMQ6
	m/v+A6BEesu+Qzwq5qdv9UxVof+odXTqZKMkb1rd6HKXt5IGQ8e91WcO
X-Gm-Gg: AYBFou0jsA3QcIQ5H84csMkV1c23PS1tlNsS6tfVoFJ0hdpqpDkr30+0CicolTyjlg+
	MmZzCrROl4QfIMav/PeQxNj066K1ww4J17j29Csq3aoaoRSTi+Sx3LUG9X38b0lSijlYoTg0JVv
	oUWjHtUcYN+KDUQf6cBtFgOO9efacXB05kP9vBL7SuZNwCQuL+Oae2HYCVcWtDCPNa79Nsyx++h
	+yLnSDEOVgPbz5cxPY5Wau0qTSOEa/MFn/7bXz6DBVQqVzH6BeOMCnrsS5xTgA0cKYIkYbkSeQV
	Z6qoAG808yMyybS6qOZvPZnwLZcZJsCrd3fkJkIF5ymaK+vLfBjHkRHla7pqByyhpWswCKj+Czx
	zwXqeK5MkkLTs5jjWQeuwlBOfTle/P7vJIOL7IgG3JwyyvgC+PiVG0WWjW7cSVQtg9uMhrnndQd
	794dofv90k+gfZ4ESLWKkmXLp3o4eGwBbLIRUbfblD8fT9VnWP1N+NOZ1Sae45mbpv0sG3gwvr6
	Ca8FkjhomF4sO+8Iwrr9MpTUncEUlqClEJ8SxwyBSugQRjh2ULHeQ808fWx9puOjRFw26bDYfBU
	jBmbr5GWeJRoPZLxUT7atCd2kP8TvOpKroigdNd0OF10nhk4cH+lvB6pwbOkmCy2sAQfap880OU
	eY3MCbEd/H1RojSQyoB0zuVA3szDvF9nPcpIAjrFuK67R28uuWlYQxq9IphvdJt4x5eQ9BWP5U0
	vMJWhoZwkLHM3vOB0DALV3lReolIrqOnwdRj0XMX8acdHEjMUYmVU58g==
X-Received: by 2002:a05:6830:6816:b0:862:c3f1:634c with SMTP id 46e09a7af769-86315a059cbmr4898655a34.25.1795202043790;
        Fri, 20 Nov 2026 11:14:03 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f3964sm2654782a34.14.2026.11.20.11.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:14:03 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:13:54 -0700
Subject: [PATCH v9 4/9] dmaengine: dw-axi-dmac: use atomic polling for
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
Message-Id: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-4-48ab58961d6e@gmail.com>
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

The pause loop delays after its final status read, so an acknowledgment
that arrives during that delay is cleared without being observed and
the caller receives -EAGAIN.

Use read_poll_timeout_atomic() to check the status after the final delay.
Keep the two-microsecond polling interval, 40-microsecond timeout and
-EAGAIN return value when suspension is not acknowledged.

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

