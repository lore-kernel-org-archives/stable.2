Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058093FD960
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304269; cv=none; b=M67MDerp9CqpgN2TZR++GY03Ap4wxCty1+A9EhbA0NxvV9yTkLKqIddY/iUoJCZEM4vMc4rzBhJ0G+1Gnx+7YH2lwcPL49E2tpEXes5OXs5KvgCS5wgIkzCDbcqsNWT/RFdP3fbHsfRf2L2biUAUGdibNP+wbqRCeyPm4Huvch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304269; c=relaxed/simple;
	bh=AA4CFCI/T0Ewszphaoo15ML6lrPZ6nLxKoibb0yiWds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN6fzQMSbEPYos1hXe5BS8BY7xWBkeg0v48Ui4F8fXoKXGHSuW1xyEokvPzhtaKSyu6jJq1OhjMzZ5iH56jjrJPcpi487yMqjtEdeuikub5bV7zGTy35zf6mNOT1SZuZ4EdQZL2CprtC8s+yxX09BOoeGC9x6i5XO8rjTYBznrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=Dtlfntjz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="Dtlfntjz"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1106087a91.3
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792304267; x=1792909067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yaonELdcVf4OUI2YJCgEvAYKPGQioZd6te9YEzY8XbI=;
        b=DtlfntjzLEdOCfUOgBuomjBZSoGFilba39LXPLFRJm8I29WHiwQbUmdE4K43K3vD9Q
         KWVUOyEcs7MtwE4e4Q63F9wRAxbjq+t33arNw+NWjw4N2ywegiK+AZ4tt0Ak3UibM/xI
         43tacmr5e061Jqy8Cq7nLVd8x0RSPpYreW78U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304267; x=1792909067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yaonELdcVf4OUI2YJCgEvAYKPGQioZd6te9YEzY8XbI=;
        b=wLCz9zpZvl4YfkPgiKFaOHYegkJCcw6e9n16iVLheBHW5bgwLvRhO9oFlX1JTVpj7p
         uToNQAKMxNaZSj5lxm9WnEQoWyAM057FQFJt52T12gVIFj2eJnr9k5HOi1lWq33J72cZ
         7JvNbaZqk/OMviJeOYFenoCQy8n0jNnBKrAYuigHVe+hwbkt/YxBCFdTes+Th4si2L2A
         oWSdARtbhLHNx6olnrRDZvYZQ+rc6s4wJlhDeMmNDZ9dm4SLz+hVt9G5pWbJXSSjKgJY
         WS6YSXDRM1JVGgxRmsYNhUOkRzZCHnV7+zkPMiJplC3Wqj6AY5l7JlkWrAscGXmo4GYb
         VPkA==
X-Forwarded-Encrypted: i=1; AKwUvBz0zB3YF1nYPrQPNjfu67Znzx16BAjhDX/GT5IwF/uQXwDoWJypTz/Y7T06t2oikEv+7PAVxnU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWGJ3WLc03mkMl7nafpBHCsPv2TnsFdd5oqDVFOikyGnM3Vrko
	a4PAKgfyrPlhe48WeDomabkJmlQBj8AV+AWXhVvhGr5kCSX9YzJZAbNgoAcCrXcAob0=
X-Gm-Gg: AYBFou0ShNvmGaRUSPvJOW0CYIxx4t2vJAimKx2pus3tq3Bnh30VcW6I/zzWBRKouR4
	36BVPPMfZYZDL38fxFnURA9yyjQ0ipHFAH41SyEJN8VyUgJeOs63po4pzbeKZcv5pIqWVhoe87A
	yPsFPOpPj4QKJOf7nrROs1hff6RZ4goR9/O526tuqZL0HP2uptTZUrQXEh2ttRpvQhi/yUfn7iH
	zmLE/nxMMUNsD+bTliHqV4RYgkmpMSxAduXu+zgTk9+asrSMK0c2SZPHpi0C8SJl391FKGWZjRA
	XA/uHSRoS8DPs2xSr2qnexUC5edVyIY/E0RqT3Jq7SujCQFQZACeZkR6USgdOBeAbXMZw8qkuYF
	1pJuR2l7Dx9I9CB9O3TVFFr1kX9jyX56HiG05kVYJDynTHIU7zC0vHhL6MKvsBtFP+/MeBF+tVD
	gB8vGtQf2IdnbQQ+xCv2BVbXSWqSOJtQMhUl1XwZuknHLwfepn/J8OC9Jhid1xRR7V8bUu2XHhZ
	Gy0BT7+++x8FpNWZscjeV9OW8xFbw0ff0QTE8d20mQMtxCHbKf/mQc=
X-Received: by 2002:a17:90b:4c49:b0:3a8:185:cf40 with SMTP id 98e67ed59e1d1-3aceeb95f82mr3978010a91.10.1792304267228;
        Sat, 17 Oct 2026 23:17:47 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ecd32sm11025963a91.3.2026.10.17.23.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:17:46 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: usb: lan78xx: do not update statistics after a failed read
Date: Sun, 18 Oct 2026 14:17:33 +0800
Message-ID: <20261018061734.19488-2-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018061734.19488-1-law.wei.jie@gt.tech.gov.sg>
References: <20261018061734.19488-1-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

lan78xx_update_stats() reads the hardware counters into an on-stack
struct lan78xx_statstage. If lan78xx_read_stats() fails, only the
rollover check is skipped: the counters are still recomputed from the
uninitialized stack buffer and stored in dev->stats.curr_stat, which is
then reported to user space by ethtool -S.

Keep the previous values when the read fails.

Found by code review with LLM assistance. Tested together with the next
patch, which makes short reads fail: with an emulated device, ethtool -S
then keeps reporting the previous counters.

Fixes: 20ff55655a93 ("lan78xx: handle statistics counter rollover")
Cc: stable@vger.kernel.org
Assisted-by: LLM
---
 drivers/net/usb/lan78xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..cb8204371f5c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -789,11 +789,13 @@ static void lan78xx_update_stats(struct lan78xx_net *dev)
 
 	mutex_lock(&dev->stats.access_lock);
 
-	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0)
+	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0) {
 		lan78xx_check_stat_rollover(dev, &lan78xx_stats);
 
-	for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
-		data[i] = (u64)p[i] + ((u64)count[i] * ((u64)max[i] + 1));
+		for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
+			data[i] = (u64)p[i] +
+				  ((u64)count[i] * ((u64)max[i] + 1));
+	}
 
 	mutex_unlock(&dev->stats.access_lock);
 
-- 
2.43.0

