Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862370836
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666389; cv=pass; b=C6e2lrjz4qoYPPRDRAaoQy1Ue8UIhXEacVP4goBzwY3NkLNwKE2D60h2n+A4AfsntqkJwEvDnb8wj4XT8JXKDUY1lZQhMtVJzmPbQBYRpMN1hjJVcQupD1Rrs0wW+YPlzA9vaEdGjhVoKoyt5lGhUGgwgO8MluqjS2AVc3+WMHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666389; c=relaxed/simple;
	bh=CRn3obYKuQ7TqQS5rgKofmsDVm88WEONY8vqkQA5Rzs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eNVt3PZdZ0R/mgNmXVFpafVTAO8Tp2kbaxiCbnKV9x6HQnalphOWjwF8z0v0pM7VN4LsydtNYhpTsx2gNTQ0sNAZB/NRoreJ0nKDeuG6Jv72wSdxigg4jODa2K/PH74f8ZDPF2ueLLqh6WNSdN1pkuDWlhSsK+0DuzcvdAfWkYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZN8rMWo6; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN8rMWo6"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52d56b08213so8822171cf.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 17:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786666387; cv=none;
        d=google.com; s=arc-20260327;
        b=SLQSxtOhzlRkE1aiKIh4RXKZ9E2MgnaO93x9K4SXt8L0z/D777XxP2CKobp2wG+dAl
         VR66obnA32GisCiqIHAv7hsHlrq62343gIW9nG3FEUSyaxJtY0P9e9jmhRwVy9IYya57
         HGot/Z0oGnbSKmUxHTZFWed6NfKRtRop/kIjmmp6rQ9/4S3zglCIm2eSzEf388rOSRW6
         +3q8GEMWdaNzytDEhfKkmaiC5wduKs5DXlkQZyA8tLXuFKcICjaksXuN7ymyzWvcVZ6a
         QQsMufCstGGsnUawtNtChZtEDuB73NtDgmxWMeOyG+lijtimfKKv1+H6RIa3zXkY9bv2
         /ERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=T3/VGRsOicBTcIUzbabnHRceFUkQOtrwwZA33wWGPK8=;
        fh=cYPJCo03q+hjCegKjT3ZMgZFYt/Sj1bJIWIswbqEUJ4=;
        b=L5pIGknRC3BLRB1zNhhPw56k7XAJeuMWeo9w4O9FE2UiD6Zzx74A2g0EqHLovgcmzd
         IaXoOPKLxs2scNzW15p+E7G3H3EnneBSPPPkey2TsKRHkA2CSyLo5y+v+5raYkSjP1lT
         rf2nIV4NdDo2toDPVJF8SOCOth5uJAs4dt7M4ZhTXgOt8B+yzXJy64YIiesLXe2V9laP
         ItP4XQWzozdPcDONwkkkTUd1ON7aPhLBk74yLD0yV12Z7kI8PN6Z0SIm5+cq9fosH2kK
         xH1TA1SXXq24F7QWFpgwNPjurS0Qc46/iJqROcAnCOndNQllu6tNGG/jOPdyBfhVYPZr
         96dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786666387; x=1787271187; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3/VGRsOicBTcIUzbabnHRceFUkQOtrwwZA33wWGPK8=;
        b=ZN8rMWo6AIML0KLpmlpHs2pbihYh7iCJ7pld/Tupewn7Tc1zVVwd8z/LmiNQEao45P
         B9z16bVjlCqJQ9RZPeGRgOu5I9Yq53Mk6grRPe5qCTIcyBds2hGHLXVjqKXOCxL2HUrG
         bsHNzqnhxcpd77MmPkeBI/DzHqUuGtpHXZ4F2o6q/IiPpqXWkO4tXJ7o/6q3IPhRCECa
         MzJIUQ8QdW9LsRT77CuhMhRu1jDnf6QfzVVg27UlM5DaPP30OKfvUC5MljtzVY4SlMOH
         raoL8yDFUMQOCy4bAphJIB9+EIB8cn0mqQFumLplt6TQeXifmQv3D6zC9Yn6Tvu5hmvh
         mthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786666387; x=1787271187;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T3/VGRsOicBTcIUzbabnHRceFUkQOtrwwZA33wWGPK8=;
        b=WhBtQib43NYt7A2UT1no6vae6+5rUz5zBcVXJPOvkvX9o8kIyedsafhk5Znzm51lOd
         cmp4bIGHpK94MAOLGJTswSesfplWF1aV1cKzTIHn6FksBJrH/wuZkTvQz5m3TtmenN3M
         UXuFY7IdU1gPslKDcMZnYeCroW/6ZZQhu8PAnVlTNRilphhpszhYZ3uU+5mw9f7gniId
         5NzxAyLfa9imIHcD6j/wgX5cocuVdQl4V3puidX+WeqvcWxPmh5hpqwidKSDha3ax0/Q
         rtjUiJnJizwQ12Q80SuwUZI0cqf4x83DV9KxGT2JCyiGt0wbpf523/FwYWHFl8BX2jBe
         OmMg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9HssKsvgVOUhMoisHeketn3KK+sj9gYDqu64Vizb6sw2C+DGaRaVOQdG0Yha628QhmuLLDw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjaV0sN1qxhp/HqZUubkkCeOZpIEBinXmspJPTDWQI5l6hI82f
	8mrfZim8EY6RJQnEYDsCd4NwIEVZL3I9X55rKQEi5Y/s0AduIFT19DjFWVgO7hrLNjoZG/dARi1
	ZR1Xdoj5+yGKG2v3jXWEsOY3BjVRr8RI=
X-Gm-Gg: AR+sD11y+aAxqsRqnEDT0o/MQlyrAV4tqBph7ZAIN1yeaPQ4QFG4/rRk0lo09cfSZ0+
	FHVNTB+kkERf6m7W9Neu3m8pqVpiQzV8JtzqQevex1yMOy932w0TOAsdvRLNtTGxVHGuVd6Mx/B
	4NCa7fLNnrOUoNcNQ1mI9E5KnGm64iHowAwf0ApgYaixuAJGXvekjjRzsjUio14aZ3hjNtvIsyG
	UH/d40H3MXLwe2gUoD3R5yVBlx/0vno9lz/z1mOGFXJiqPxqRYbpmG3STOCG9+ElmKd50rZEWda
	/MorofIher+n7Pq2yl1dQyk/60inPMugIZ2VTsizx/4=
X-Received: by 2002:ac8:5913:0:b0:527:69ad:fceb with SMTP id
 d75a77b69052e-52d84c3f2afmr25232171cf.0.1786666387214; Thu, 13 Aug 2026
 17:13:07 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Aug 2026 17:13:06 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Aug 2026 17:13:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: diegomancera.dev@gmail.com
Date: Thu, 13 Aug 2026 17:13:06 -0700
X-Gm-Features: AUfX_mx1q2Bzoj_9xMHM06Gm8slt5pFufWk96DaC48MKtpO2vQdGiVE2atQI8yI
Message-ID: <CALruWrXs490+d7tx82mLG3rmH_H-svkwA=zXggr0qOeEhG3GmA@mail.gmail.com>
Subject: [PATCH] net: txgbe: use vector 0 for misc interrupts without MSI-X
To: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In non-MSI-X mode, queue and miscellaneous interrupts share vector 0.
TXGBE_INTR_MISC(wx) instead selects the MSI-X-only miscellaneous vector,
leaving vector 0 masked after it is serviced. Use BIT(0) for the
non-MSI-X fallback at each miscellaneous interrupt unmask site.

Fixes: e37546ad1f9b ("net: wangxun: revert the adjustment of the IRQ
vector sequence")
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 8746318ad3bc..6b5542cb2161 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -31,7 +31,10 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
 	wr32(wx, WX_PX_MISC_IEN, misc_ien);

 	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	if (wx->pdev->msix_enabled)
+		wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	else
+		wx_intr_enable(wx, BIT(0));
 	if (queues)
 		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
 }
@@ -183,7 +186,10 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int
irq, void *data)
 		nhandled++;
 	}

-	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	if (wx->pdev->msix_enabled)
+		wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	else
+		wx_intr_enable(wx, BIT(0));
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
 }
-- 
2.54.0.windows.1
