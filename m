Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792725300;
	b=YOC2jwEXjuVPSo7arfYA2uVHELmBRs9AueHlg9cS+/OBXoyBs2pKDf1RYPch9ZPxDMrh
	 7wxMH50gW1sScmsYsq1ljZirhmeKVbGPoN1iuAqQckaVx1Ak2XHxggTnHtk9tMIg57KcR
	 PG0Sws7yvuvf1Dg5+DVvzA0CBD+DldM33His9G76CHC8jMmS+JNPkvybjFB2joyjYWgQh
	 m5kNSDZkMnrBZ+d/jPy8zqMFQQtNHvqIYQrIqo2Or5gHl0SuMLT+5mE22hgZ4sYOdgUDD
	 qQbebxm4Jy7BCdC5Pe6tBHT3B8YBAECj9iB+gDuLX2t+cOl8olPb9SKFQrhm3jY1eTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Yi+Mby52IcSMxw6Bb+wKdKUkb+i4YW8eVg++kxowvr0=;
	b=WgIKva0gOja9+ZhAqdM7QyuG5wKmKWLBttc+/JAph3lhJC7UZLcV31kUAioECaGrlAI8
	 jrqW0xiShXsd9gjvSMQKlmnTPet55nYLjAIoCav5YY7cKPn4YqN+hVyRHJD5egqdJvu09
	 A8JeOcGKAHCWfBKh2WeA1jOa+06iEGkilCgpEjuGAa+GcjDow6+n6d9L7q1sn+GqTs8Jy
	 oNS32pGoTSGzLbCNdgKBoFFjduSXSWK7COOnv+oS4f+NkIwC+Q/sd95VkEPhmW5mj/wpO
	 8Qxv/HDUWfVR99FsmRbD6iNO08vAdoSKVIjLLm+CsZqnZLOglIWsognarzqFfB9NaeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FSyRO3Jm;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C1606A32D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 03:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE9C1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FSyRO3Jm
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-7037daaa820so173888eaf.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 20:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792725299; x=1793330099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yi+Mby52IcSMxw6Bb+wKdKUkb+i4YW8eVg++kxowvr0=;
        b=FSyRO3Jms3E9Jf5Dvp+KldFAHs19x0a+sFC/yWDyB3yn3kmGAue8c2MNODXgnd+1SE
         Kf9iKg2wgxcIyrj6joHsbP5FxKhYPs0dsVywMuUaVGjIbTR6kfXSBMgLc+kHGHgyEnwB
         T2LGDmzDdsJGUaue5PPUx/8Gqulcr5a9xlYQT18Q9MANOrkCrsjqzYIQqo1//UJ8h6Ue
         mQ21DclioF0qM1wDcIUIDmmDDrOMXIU6aE/TrK/b4pNfr+qORTJ+E7DJIigEcua2lpb1
         8as7S4Tn0my/DkJltl1xKcBAVAO4/owwBfpfV3wSpoXNR/SuIthpbwOdW0KVpGuhBwZ7
         DGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792725299; x=1793330099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yi+Mby52IcSMxw6Bb+wKdKUkb+i4YW8eVg++kxowvr0=;
        b=MBCjJrEw1gEJsE0ZF64iMfXgNrCt5LRfJql4MPGjoBjPNDsNoDgAx279Qh96aynLxN
         XV3i4LqN0ly3VmSz6dAddSLaK9hK4gfLMdSQ6LynYD2XNKiX5JXfOt15XGyPHPzC2J5D
         NSiUTZLUCrLcYZY9zE7uZpE8uxa83pjgxi2t8Gv7BBBgmXvuExUQGK8DT0zavVARoLAu
         IeY8UL8nDQfALngoGr5EByqFSAGYpq0WKXWGKsT+dEFIUs5pjOQj0AuYPZY6JhNNqrZq
         KjMEdFONCVPYLrXA29oVBJY2FSfUb8LdZf/rkVr80Io7yWcLr9su/ik1YfbeP9hmhOZK
         mopA==
X-Forwarded-Encrypted: i=1; AKwUvBzfXhnjTFQiT2ZlZyLIRdQWALB38nGafRaQOCGxKPsYk6kjKVtGVMnjqyrPJGa/ifz5fgChMy8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0416SjMyyRDDy3QX2SSBXPOasd1Tnm+c+FGJlwEkYVj9Y6z2N
	rKIHcOuXOmbN+vQSkR0myEF8FzSkvk6HcRYPiJyrttM0gWHXPBFUhTpy
X-Gm-Gg: AYBFou2UPrt9MHrEv0v5i3i/8zjqanM54njrMWKPEh5aMDQiM4J32d8d1wc08INAVEl
	LTk4M49ieIRRy84J5ozNRxsRs4wYl/i6vX5LOaeQa4RoZzzEZ3qbvGyAWRHcBwsMLNVxxAJyBGQ
	gMJKCUP+INTg6cB1KeW4L5Z/113a6vRrxfejUQV4C21KWVQK23VxF5DAnOfz/+lFkOhG6Sz4XUs
	lYL3uFHDErbwM6mx/C3vfWCkILBHY9ad7j/+pNpjcKgn1X2nhExC5q9+InK7cKsuTeSFOFIBXWx
	mYTtArz6u0nwfl7k7gO2skbBsMSdgqdRGZduCK1GquRNQLlr/Y/+ikq5OTuN2azLTLrHjQOvAFu
	AMus6WimOI/y9E+2Y4q2drhZppVTegxfiN464NEL91j5kcc8AagYIPpmFluYeQA6nTjGsufz528
	M6HheK/ES14/AofMQaWKRYSXj81t7qAJcBQlbNkViKfc/JalOo2m2ta7pamj2Lcfm+Ge3w/352I
	a/cojNuG2PjKL972XvLRujBufsGOhpCYo6Uzx+kHSTcvelW9XfEzqqBVveADS5793RYKwDLpvJu
	UbDOgT751G6IDLgaN5wrdxJL3fAmhZlRMICFW5SjItf5fNbDMMAUhp6vplG5Y1lhnyFlWbtkm1g
	9oG/m1hHgOgCS6mZVrEgCsCu9fQC3DU1gTL/rIXSi8ePr+OFlB/u/TWcmehpsZD2hnAReiDOEVg
	+qLds4
X-Received: by 2002:a05:6820:a013:b0:6c1:f38e:7053 with SMTP id 006d021491bc7-70b8880e70cmr711138eaf.3.1792725298780;
        Thu, 22 Oct 2026 20:14:58 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84fbda584d9sm938638a34.13.2026.10.22.20.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 20:14:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 21:14:52 -0600
Subject: [PATCH 1/6] dmaengine: sun6i: fix physical channel index in
 interrupt handler
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
Message-Id: <20261022-submit-sun6i-dma-lifetime-next-v1-v1-1-01085f684c9f@gmail.com>
References: <20261022-submit-sun6i-dma-lifetime-next-v1-v1-0-01085f684c9f@gmail.com>
In-Reply-To: <20261022-submit-sun6i-dma-lifetime-next-v1-v1-0-01085f684c9f@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>, 
 Maxime Ripard <mripard@kernel.org>, Jens Kuske <jenskuske@gmail.com>, 
 Jean-Francois Moine <moinejf@free.fr>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, 
 Chengfeng Ye <cyeaa@connect.ust.hk>, 
 Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

From: Hongling Zeng <zenghongling@kylinos.cn>

The interrupt handler iterates over register banks in the outer loop,
but the physical channel lookup uses only the inner loop index. It
therefore handles every bank as if it belonged to the first channels.

For controllers with eight channels per bank, interrupts from channels
8 and above are routed to channels 0-7. On A733, each bank covers one
channel, so every interrupt is routed to channel 0. This can falsely
complete descriptors for unrelated channels and corrupt their data.

Use the absolute channel index, calculated from the bank number and the
controller's configured number of channels per bank.

Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
[james: use the configured bank size and describe the A733 case]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/sun6i-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 8752969366ff..9d94a37fcf10 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -603,7 +603,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 		sun6i_write_irq_stat(sdev, i, status);
 
 		for (j = 0; (j < sdev->cfg->num_channels_per_reg) && status; j++) {
-			pchan = sdev->pchans + j;
+			pchan = sdev->pchans + i * sdev->cfg->num_channels_per_reg + j;
 			vchan = pchan->vchan;
 			if (vchan && (status & vchan->irq_type)) {
 				if (vchan->cyclic) {

-- 
2.53.0

