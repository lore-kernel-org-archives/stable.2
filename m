Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF1451071
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717672; cv=none; b=WSkcVvDjv5Ym6q26XvnQX5MVAPuTai02W9MxMs9j68dTNEkeodCLzDQ4ekRj/rd3rGY645h8m++WLuUdVwLzGsyE6XljrmOjqjQ+guU8bg5qWsXULw5DV/y+TOOZbEdT6sy/JUQJufNw7z5dIzSBSBlan7DGjD908OPU1BhI7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717672; c=relaxed/simple;
	bh=k0KzLk/Py5MfNs6v0LG2pawI7nCHX5oUhShrr2VzixE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=estUJ97H9ne6zGc5g7tBSGexeXk+c40GpQXqVe4uhKaZFTtRt6qB38Uk9BegYIUlsEQOl8HahBoqqchuZ+2Sd/XU/Q1s+bMIwxR5pcVERKn3jbbOr49wa/42luGa9hOL9X1NP/QGQE+knsuYKxq1x5tJj37LS6at5Sk4DDF42Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=soundtrack.io; spf=pass smtp.mailfrom=soundtrack.io; dkim=pass (2048-bit key) header.d=soundtrack.io header.i=@soundtrack.io header.b=Abk8hbO3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=soundtrack.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soundtrack.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soundtrack.io header.i=@soundtrack.io header.b="Abk8hbO3"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a18ef236ecso205923a12.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soundtrack.io; s=google; t=1786717660; x=1787322460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8f5UJCABHvmBw6dzoHdGzw6KbaLnhVEoCCS6jqmRT4=;
        b=Abk8hbO3uhyHVYxm90lWMY7m0s1iBE3oGJKs2XJgQJ09dUKp5u+hpy8pMULNG3S4N0
         e9pukQFGcMYrj866rPOzzYuIRgTQHxq+VgrHhKSqHqIV4NL2KQwI4Z0BD8Mp1sTvz3LM
         1Ugb3Rn3Np/3gUXKg/NOKV7OmW7VFrLGUsUcLUxd8plGza8ue3UV3u23tsXSj4kYYawL
         J7kC1N/xMNaSSysLroGs/baRvrSRAS7FQHZwZLnkac4pqIUoF3KegUu+PaJm01xPISTf
         vwVFJoGrz90CFCe49XxKrtsGC/cUUE0svJth8QhQWh6/8afjYQ7ikvKEydsyEdCZOV/0
         g3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786717660; x=1787322460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t8f5UJCABHvmBw6dzoHdGzw6KbaLnhVEoCCS6jqmRT4=;
        b=jPhDp52XBibAWH7Up/jAQgNvhUI6x17wLBbQCsj1GN3xAX/FTa3qATaEzN9yG0YgPh
         AHNdRY347feGHUhfiPAp24IhpPrj0eprmLs+VIjZRO1FnkmSiUE9xWIwkTIG6X0+ipGa
         IlqG2tBGkbWEerWWvLeaeN7XzJIdRGjiL+EvcDeKBH43/MhEzLRpqsdWKao0LI4IGcJK
         iJvTON3rIOfZQT3EFwGLqDGRweaxziodRkCoccbyedE7PFVPHiEqu9T5kKVQtypGQqSx
         uuNpXvg31sFEmVQsd7Z5SsEKJYxf06weXw+LfkVnSp9pL3RpbR4dPzUU2J4JYYlh99VC
         HakQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCu9hdrZHde00brzQWUYK4pcgxo3Uu/WT5jbsNv8PRW3bSqOLBW25e8kCDej/pWDcyQJ+x9kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytAmPYZCAFKYmz41Ug6yv1JgI+w55H69ixykrtJiUvipLFx7im
	JVypakbK3xMRvaW3Igj4QTtaaEL8Ff8dAa6yEWPh3qJGZAIlmiDf0tqNG6fjRoQYYb0=
X-Gm-Gg: AR+sD133sqaGbVjbN8/13K1O4QuIEVuD0SjN6Ji7V1drbsn2xOFWhHFP8tcyDilK9BP
	XD5iblx6pYsDTedUDBcy7tLW0uwNRZX5EBphVRQtzfTacGil/EpV2R7cOKCiL791Jz9xYnrHkX+
	ACx3kKqCmCqka31s020eTenr00W18K8OgBaw6Ai2uk6UDlSVI+X6lBbrJGTCi/UodKnqJG521mR
	nboRH/9ztqXfUs3g4mwvGzRyMOUwVqeCJDOhntLKcoYH2L9kpAwAaYwW8X5/eh7/WT6Bmtri5gx
	gO4/5AQNorYQXf/qHZgmh0VMJyXo2/O++Ca3+2smKk/c0H+LMCDvM1jYzP7Knnd+WwW2u9eDHxr
	PIJ93VBgFsfjA1l3uc5UTbfHTBtXYA2FUMUZr2nuBmszkJ0e9fd2eHnNaGSGMsX6ERgGCA2dpHh
	qwl9/XsD8q83q45ZATV3nSSbaK1qFKGFFM3hW1cDu+qI+kRWKin4VAfmB1Ci32AzMU+Bb2kMD6X
	2Jvxn1w6L/suW3y8JhJFHExqJNt9X2Glfgmuiy8G14UUlp3A8j5WXd34A==
X-Received: by 2002:a17:907:9403:b0:c1c:4ae9:b935 with SMTP id a640c23a62f3a-c212a22e029mr175852366b.3.1786717659858;
        Fri, 14 Aug 2026 07:27:39 -0700 (PDT)
Received: from Christians-MBP (31-209-40-223.cust.bredband2.com. [31.209.40.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21234c45ffsm106308866b.19.2026.08.14.07.27.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 07:27:39 -0700 (PDT)
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
Subject: [PATCH v2 2/2] dmaengine: sun6i: fix undefined behaviour in sun6i_dma_tx_status
Date: Fri, 14 Aug 2026 16:21:11 +0200
Message-ID: <20260814142708.79120-3-christian.lugnberg@soundtrack.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814142708.79120-1-christian.lugnberg@soundtrack.io>
References: <20260814142708.79120-1-christian.lugnberg@soundtrack.io>
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

