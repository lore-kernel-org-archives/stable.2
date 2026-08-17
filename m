Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852E442393
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975060; cv=none; b=s3ed5mux2fL2Y/V/AveMNmOzZ19G/7fPpZROAc1Ks0N8vbSr4LnwWy8EPn2/2oj9oSlkeeATTGaR0AKN6IJ4CpahuClBrvnmom4VKQXOFBb6ZmB9WBQjw1dO4RJ8smGibOUSaQUR8Mj0+mFbwJp/sDScMPdAlnXQfb41jBlei+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975060; c=relaxed/simple;
	bh=k0KzLk/Py5MfNs6v0LG2pawI7nCHX5oUhShrr2VzixE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kD77DZH9k5UtbQjpgQUI41kp6jvidAO52BUKiSoPWYy5LB+qrdpfAO1hMQK4bAusfuJ2nVp6sqXZQBed3s5+GO/oGRx5WHPbmX29qDOIAuTI/Je/RWlIEZhaGYOZnUxM5soS4GW/CqG6Cr3sOro9eIF5bo/1JApKQSaXDAS/0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=soundtrack.io; spf=pass smtp.mailfrom=soundtrack.io; dkim=pass (2048-bit key) header.d=soundtrack.io header.i=@soundtrack.io header.b=hdJx5niR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=soundtrack.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soundtrack.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soundtrack.io header.i=@soundtrack.io header.b="hdJx5niR"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a1f56768baso587045a12.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soundtrack.io; s=google; t=1786975057; x=1787579857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8f5UJCABHvmBw6dzoHdGzw6KbaLnhVEoCCS6jqmRT4=;
        b=hdJx5niR0E94H+nb8qraeXqUsnG1zW9Iefn8aVEaWVoNUVi73xHl4faMuaxtHbGUVv
         1+iCpJGw85dX1UB/Utz6R5p81h0HWeAgBnKulOzx46iLMMVclrPROTxuCJjwVZbQlJEj
         BsFKfCFzXNP15fGR7XUuOv2fbOj2V83Mb3824LpUbW5w/4wBhAdlzeSMKPDZ1Xtd4clT
         ggRJT6JrvD+zzX0n9vfH26bOkZZ1GSbFewlYrx6QCgvgjWK1K5vrVFE7fV99XilpOOK1
         NJU4h+agtuSxVBcROd5IQ7P/hSI8GGLF5sAQs1lXVHhcS7XZHv+aldPuC9d162N8hFq8
         fXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786975057; x=1787579857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t8f5UJCABHvmBw6dzoHdGzw6KbaLnhVEoCCS6jqmRT4=;
        b=V2nPhoXxV+y6ypD9nhB2pBH0oB+8MWeCnff8D+A3U05IbxyPeLhqJgzn83YLz9ac5b
         h42fglLFlwgRSYTinUHG6Dq8cFAcBg08HuoB8AkOqwLZha8eNENml7HGavnysuT1HrM9
         CIwEp6rq1VDkvs3DatChEZ1jOidbSzVmoBiXLTRCKaHG6fKKwXKeMrTRm90yBGy3iOdw
         u43Qdp6/rg0saWmcMEwuKWCyHZC8yEB+/VfUEdLZqenf9n+u0vmhV7KSX/Josb2aHVWu
         St1C2Hixp8NdH6/bfMCrO60k5xf97/uETv1/kTJfo1MxOWZJ6a67jvBdFe6Oe+ZX5NbO
         ZKxA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9YhGObJbywlE1up/AsRQcjqMIJcWDAsAo+L7BJ51HAy2bvkRPIcp36ji9Tq+K56lpI7/D43Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcGfXK3HDbYl/VP7K2DqaUJzlINdcTiYWRN24ap6b1BPJxmnfq
	41g0Z1Ld5dmnxcpFhnDfn6cvj+kRBBlz6BevENwzjbndQXVBuSc2L9dw5BGsBAu12jw=
X-Gm-Gg: AR+sD117ysk4lWY1Lixznh/77wmvAPTyMwAA/pnvKQkyUJtG5hE05XkrXnTRYSeT1T7
	eNOXYGwzwnKMIqstCe4o/nJFbHo+Z+6CVcxvqk+MnJOI+uglrBDzOFLpS6e7oGoi73ag+G8SUhO
	hnx/Dh/sSKQeG7FiFcaOJ54zC88+9dYx5Klx7vbcVp0S4/HNizjry7a0WBkSkr1Tfscxf2TqxWk
	BuVN6EI+LKY2QRyPXH3orBE+VqCzQN1A+3ePuoKqb2+t3R83iAaAEg8NNeCNCkblFH5lYoZ5347
	VDGfltc5WQFaVqLmsnbj6J7OrEYOfT3PxUFPH95bgh7nC+L00U3V2xmPKhIHOkTEUmFRjqllQal
	3C0pRlC3YQ71AM7rCH2wEO/W++CME1khgOD5xG30pBCA5MHT/ONep1Zb9TzPEMp/DN33LGOJDPE
	jd9lRDBrUQYwydmy+5LGHMFCva/8T03WEuMoEoocOlEJPI4Erber1LtTcfjPCPekOHYhH7VSmzA
	9F0H5kU6TkN8gZEUyT59WfFMiE8HoyuCIRM+kXsvjVY7kcNd/q9Vn08uLk=
X-Received: by 2002:a05:6402:2812:b0:6a3:8446:c56b with SMTP id 4fb4d7f45d1cf-6a38a8bf430mr6474052a12.1.1786975056608;
        Mon, 17 Aug 2026 06:57:36 -0700 (PDT)
Received: from Mac.localdomain (31-209-40-223.cust.bredband2.com. [31.209.40.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d85319b1sm810238a12.13.2026.08.17.06.57.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 06:57:36 -0700 (PDT)
From: Christian Lugnberg <christian.lugnberg@soundtrack.io>
To: vkoul@kernel.org
Cc: Frank.Li@kernel.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christian Lugnberg <christian.lugnberg@soundtrack.io>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] dmaengine: sun6i: fix undefined behaviour in sun6i_dma_tx_status
Date: Mon, 17 Aug 2026 15:51:23 +0200
Message-ID: <20260817135723.12807-3-christian.lugnberg@soundtrack.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817135723.12807-1-christian.lugnberg@soundtrack.io>
References: <20260817135723.12807-1-christian.lugnberg@soundtrack.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun6i_dma_tx_status() calls vchan_find_desc() to look up the virtual
descriptor for a given cookie, before checking whether the pointer
vd is NULL:

    vd = vchan_find_desc(&vchan->vc, cookie);
    txd = to_sun6i_desc(&vd->tx);   /* vd may be NULL here */

    if (vd) {
        for (lli = txd->v_lli; ...)

vchan_find_desc() returns NULL when the descriptor has already been
completed or is in-flight on a physical channel and no longer present
in the virtual channel's descriptor list. When vd is NULL,
to_sun6i_desc() is called unconditionally on &vd->tx before the NULL
check, which is undefined behaviour. Move the call inside the if (vd)
guard to ensure it is only reached with a valid pointer.

    vd = vchan_find_desc(&vchan->vc, cookie);
    if (vd) {
        struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
        for (lli = txd->v_lli; ...)

Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Christian Lugnberg <christian.lugnberg@soundtrack.io>
---
 drivers/dma/sun6i-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 04fe1f5042e9..7704b016aed8 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -981,7 +981,6 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
 	struct sun6i_pchan *pchan = vchan->phy;
 	struct sun6i_dma_lli *lli;
 	struct virt_dma_desc *vd;
-	struct sun6i_desc *txd;
 	enum dma_status ret;
 	unsigned long flags;
 	size_t bytes = 0;
@@ -993,9 +992,9 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
 	vd = vchan_find_desc(&vchan->vc, cookie);
-	txd = to_sun6i_desc(&vd->tx);
 
 	if (vd) {
+		struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
 		for (lli = txd->v_lli; lli != NULL; lli = lli->v_lli_next)
 			bytes += lli->len;
 	} else if (!pchan || !pchan->desc) {
-- 
2.54.0 (Apple Git-156)

