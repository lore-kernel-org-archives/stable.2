Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808886;
	b=R+vCl+ik5IAffU4vUM4UwkDXvj5998PQhPOHrckdVVtzUE6P8H9VzOwnelORvgMNlpA0
	 bJ3/KdDHIt5qODPwyCroI2YGoaA9OXPuNxqpnXDExe1q92qz9IaabiqM1eyF1x6a9OcS8
	 mICd2wk8mVrmdAoEFh7+F1noTK24AIGrFeHkyMyBPQBh7ehX8kO6sKj17wAZdb0k3eRM0
	 Ds+pik2jQryeyX4rBedaE2x0qkHRXrE2CLqWBXZPE/DiQEHwl2CtsgOvqKnL8Asn8cgvn
	 jV5iwtJC+yMrFsaHoF+Owgl0JJ70IlCeIYqD1eGse+jnaKqXo2meJ9fHphI8Em4mWUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mZsB/3h0Hi2V5kBvRnVnvINwTmkVKxUCHl38ser2nf0=;
	b=kcA3Uy4avjQLVW6T3aIFzwgKdwMIVQ0sEb7+J3IpaA8ldTwMeGyQvBXvra0Sp8vIXtEK
	 I/V8/9vxhrvLnQO5cDfQ1A0KzcaeivFtS2kgSn4IA8IthhOPkLlIt/hBfw3WByp62NNQG
	 wpk9HqTVq8L2ZZ1yoCOqlIDTCEg8kMONbW1eP2he63sd0l8r+p0fACNlIWx+2/QpvIOk2
	 +DflInVY3rfiUGKxE2dG958Lgwe3wGdNXo0UnSlJOCyni+IwtKvCgSHF5OkorgDegPxCx
	 CD1fXJc+UVZ5IP/k5BeetNsHKM97vUiCRux8Fg/6jQFvYnj4i/DMJL8w6MWlg1uNIyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6XvqaeA;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40860A261B
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D40860A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6XvqaeA
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-844a8bf7e25so2852194a34.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 22:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808884; x=1795413684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mZsB/3h0Hi2V5kBvRnVnvINwTmkVKxUCHl38ser2nf0=;
        b=y6XvqaeAgMOxYv0v8BB7+Wu+UQNZFH/xHAgJzY6HQs5trUXn9HrQwoV6hmuyfNtHJX
         7SEKNSqCmxYdkuBRDBVVf/m2o0Qg3wCBHg2OLno3G76gF5Gidwichtd7mT7hur7dVMXc
         KsIH3mzgVeH2G+St3L+FgaDAjz7g7OPFSQoHfuawetr8ORMR7rLv7rfQE0FVo0ZiOtFX
         2fiK5ks4kztI9dPuyd0Mx1kPRsdV/mBi8CyygzmWhPIyzsbn63wHyvdwR6UP6ohWIS+y
         tafeS5MukjdHDPJJh3qMikD28yi5kQUWA2Hisc7/PdRDXsKIwG6OGkINMRIcmGM422UM
         KdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808884; x=1795413684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mZsB/3h0Hi2V5kBvRnVnvINwTmkVKxUCHl38ser2nf0=;
        b=05B4XnPmYgTYoIuVLiQ6mjKG0ja6Db82i3ocKl6wwv5M76SH8SwFxlX3grra0d6+ab
         U65T49E2NYDBNFRccewbOvluMfbC9gK+4dxcUUb5lL59sL0+zNzWH7yU8m8nlNv8mbNr
         rSVMFOWfgWz2M5Hrq3h3I3rRHeI8HZr+E3OrFI7bTF+1G6Di0w8k2iC/PZkDai+VmryS
         HSfggcAeU5awH/jiQrfPzi/rFLBMIUvvKGxYXQG1mtERW2xMbu/7jXjrTfsQeYV9u35p
         TDuCMvnNl9uzSZOec7FZsLXuBcwVOavaMTbrxl5nVXKPGrecZmwoQ/qs0F7ENHFftQRr
         KouQ==
X-Forwarded-Encrypted: i=1; AL+hErGmdSdwMw5dU/wPUrxXf8jf8ClxGwX1x3R6R/yXWK+pYPq8kKdPXOhsftQQvBD62QRRsjJGSjc=@vger.kernel.org
X-Gm-Message-State: APuU4Z98WW8Oahir/yCa+b0N8Wd1bFSOdktWv/8QxKYikDFCrgqh4abk
	+HTQi77KcnnoFfn1Q1NWd4duMgQYbZrcrCYzScGXc1qTis/X5Vu65370
X-Gm-Gg: AYBFou0fcL5X4pNDBAAHhqwSoeo48sdUAaYktJCE2YR+wcQ9+YWHdGwf0fMGgYHEgmw
	bUOTXLhoarlkDhiYjPiRodYXQyzbEXXpk4HQ4ZAGwCMqmddrYGwuAHrqUU4/KYmqJxLflmwV80E
	hfKN55eu/8rFjQF96rbanSVdvU2XPF1doBIG3AzRK/g/BpoBVPCktL5QbY8kBmiESIFBmsS4Y5N
	GMpHNINl8KB+Y65fkhEWIqgQApkS+cbMo5VHuoXds32otx8nvxDU2FIYC4/QI059z/dPdAt5ubT
	zZsafuVT9taNw4yUcgMNow5doeal5KB31YHBm6tSfqCoqny9PGXC0xfmcUzWf0w3vVSrX4YWHgI
	noP2y3tplYtpkwmYdTTaEHBHXEgmjuKQrDO9SZtXF04TAByU2gNs/6WL4uoLM9Y1ao+2ZbwiC63
	2C2JnuLXBQo8kUbdqSsJLuwm5oA5IMq3+jcqDc/p9/NuKXs+ck8iHlhmBlbyktyWPA6J9XxbhL2
	PTKwhL2PTA0eExhMjdfJU4WzE4KI1m/oYJDLTx07pIOpXOlIyKioM4WfUfR92zgETngoiHMfPYb
	wCNdPqqbKpdLd6yIeSB7VoAzUE3OQhwcUthEnioZFrZUlzXrWr1tIvrtfODFJfCzeL2UUlsXVv4
	W2CHoBaQD5pFpWB7+s7shOZ2DV3njTRq8dpnXg1+p2fvGoJ3DVhrQMa418Y1msvNk8U701zoYKZ
	rBRYNmJZCFy/RNgYsYPOqPwdf0vYoZ5hcD5aghSl3skX5B1SF9NKE=
X-Received: by 2002:a05:6830:2b29:b0:834:b015:ae9e with SMTP id 46e09a7af769-86289859955mr8776089a34.12.1794808884380;
        Sun, 15 Nov 2026 22:01:24 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm9375160a34.25.2026.11.15.22.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 22:01:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 23:00:47 -0700
Subject: [PATCH v6 6/7] dmaengine: dw-axi-dmac: retain descriptors until
 callbacks drain
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
Message-Id: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-6-bcb23d1e7029@gmail.com>
References: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
In-Reply-To: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 Wang YuWei <1973615295@qq.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

Termination frees every descriptor while a pending period callback can
still refer to one through vc->cyclic. An executing callback has already
cleared that pointer, but still receives a pointer to the descriptor's
tx_result and can use it after termination frees the descriptor.

An error interrupt can also move the cyclic descriptor to desc_completed
before termination. Looking only at the head of desc_issued therefore
does not cover every pending cyclic callback.

Use vchan_terminate_all() after stopping the channel to clear the pending
alias and move the collected descriptors to desc_terminated. The existing
synchronize callback drains the tasklet before reclaiming that list.
Descriptors already detached onto the tasklet's private completed list
remain owned by the tasklet. Repeated termination preserves the retired
list, including when called from a completion callback.

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Reported-by: Wang YuWei <1973615295@qq.com>
Link: https://lore.kernel.org/r/tencent_C00D995A9F70206DFD1330DCB1222EEBCB07@qq.com/
Reported-by: Mitch Barnett <mitch@accuratesound.ca>
Cc: Wang YuWei <1973615295@qq.com>
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index cd9a5b45d295..97098367535f 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1203,7 +1203,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	unsigned long flags;
 	bool enabled;
 	int ret;
-	LIST_HEAD(head);
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
@@ -1224,7 +1223,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	if (chan->direction == DMA_MEM_TO_DEV)
 		dw_axi_dma_set_byte_halfword(chan, false);
 
-	vchan_get_all_descriptors(&chan->vc, &head);
+	vchan_terminate_all(&chan->vc);
 
 	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
 	chan->desc = NULL;
@@ -1233,8 +1232,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	chan->cyclic_restart = false;
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-	vchan_dma_desc_free_list(&chan->vc, &head);
-
 	dev_vdbg(dmaengine_chan_dev(dchan), "terminated: %s\n", axi_chan_name(chan));
 
 	return 0;

-- 
2.53.0

