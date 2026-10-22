Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703504;
	b=xeQycsf61sSeBz3xVUwij0Ylb4u2uOph18mcP/+c5vU9GVOR/mp/ENbRa9d7lwW4nMdQ
	 XKYfeeGxV4bP2mQsJYy6JXOlhIQsgQP3xYpQSNM9v10TH400IKSRPjwhQgusV+zhYH4Gx
	 v433zQqN4ykokyfV5a2MV78RnooxVjDQa0kOpZ7CX26QlmgVgW9cPBDxg8l0oCFyL6FCG
	 Vmn83X3vBy0Rmsc6fHdIw2AonNPSpdSodJWQ58xjEVSOPiBhQQqTu6JehwnQdMP5CCDsS
	 NTkUX8gNvesZ6dsh1vPNLaRpdPu7zDWXr+pAPMbzWv0ouL82i3n0getTeDn39rpMu2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Mi3XzU0RNWFyJ4e7CUa62rc+wGnBh7UsoeyqdHtTKAc=;
	b=K4CBk6TlUQUF62HGG0nGa28SXgJjc/QPtEu2GhC3KiT0H6lr1jCMAvXCbjCjuFsj126w
	 WtNkVVkWP+jTQy1T/mRzuDgGaUj2yISecB0ln9dy7DwAq1k416we+yOix2BHJfaEnlCAK
	 EdL/ljcZRkequxEbKr4gpbTAF4eLIlAPw4/WkPrtQZ6W055YpVOn0kP9oulPBi2z0TvOx
	 FbC8l3QOCeJ5r/0I8sNfxEn5s8PZhLM+q91vV5q77+gFvvjAeA0229uVP6J/ZjVsIc94+
	 d0Xq3Ist6R12gjQ6BBsbm4joMfvmQhVen+O4zAlFjlVqWMczRTHz3/uyZzJbS0pMd+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=El094RDy;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B65606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 21:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=El094RDy
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-504ae5941faso180249b6e.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792703503; x=1793308303; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mi3XzU0RNWFyJ4e7CUa62rc+wGnBh7UsoeyqdHtTKAc=;
        b=El094RDyL1Lws/bHb3SBNKi/bky+9gn+9vrrLhK+j5PmnCrRD0pt998UqvPrlz+/uO
         fhyBhzAcLcZ6zZmoaFrIQE/GohnkTtsEsjx4mmsCrwPV4uEB5M44rnp/DgqARi7jyUC0
         QAY2nNhzpPe1uWC/0rEpKpPalW8IKXWXpa8KsFB9k1KsO7mDddstls0u7R2smgKPAlqV
         GBhMfi3Ot1lMK9Rc2CrbVLRkbU7jvXyuSthFq93XpKk0MIqK+kEEe8KruOit/NapzEqL
         /GNKBcRdia5qcLYfDWTTES7+HVr/jzSkDcw7QT6tq5OIH91t3noWu5dvX6SL0lsecDo+
         BSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703503; x=1793308303;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Mi3XzU0RNWFyJ4e7CUa62rc+wGnBh7UsoeyqdHtTKAc=;
        b=h1CpRvMBbPV16okC1nxCeSCLf1KqOO9EcDnEJBIbyZSl2gefa7dRliT4X5lsMRQ2fC
         mfcRGoG8Bj/tZ+y23JTXTxnWSps19VQ1lScB2VK6rH5m4Rl99AmG67CJtfefxAGJtmip
         ONG/WN35sDzjaIJQ6HXFJ4fcsVyz+5DSYFWzCbzcqJ8JnAnXWPLKcDK9oqA0BxOhxxQR
         cMTsnF6P1pLxqu5TOUCuDHrR30fPVHPQOEQT+lSuqb57zqXsd3iJzUwFuZplUjVFz5/Z
         qnMnzEJ97O6GtM3yeDIrucY4KAZenMjjmWZhXMys2/81+hKjkUDUou0NoAHcg7RtaiQ+
         n1HA==
X-Forwarded-Encrypted: i=1; AKwUvBwD2hXw+mDvp7GfIl4ECkxchJiYf4gnEARcAZqgyecXGCR6dB24C1hDbaJExnXCpQhvY1gQtLA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHBy71LaMjZRViMosNTpS22GBBPQ5eCc6ckTclS7idRXmWENne
	VzguqWKJPp1WhMAK3rEAmGtboYtFTuArMEcxe0RdQop3fqoA2CiBYxvL
X-Gm-Gg: AYBFou3IR2453aDokYHjWkgXDgIi/7ee+WMG1afZDRCiQRCoZ3yljj4Yh9agCRFqpWN
	EXsM4FSqtg2aBJrWBPOo1YDO1H4nq4pt0ZX2UgoYtikYdOuyCoHo8IHz4p4zXSlRZm43haAI59G
	l5iSC3j933oV6LqxIhjZ+UnK4sC7HSSWmk8l9SMC+GvjirXqGz/AI8ufSbXwDnbIy8arf13ruVY
	5LCBMTu+hqzHm+fzRpDP4GM5NGfIJwShpE8wqLJcHMp5rMhVLAwd7QUWdkvcUozF4w+0HxisuXN
	+npJI87HgVGlGumn0h3qWPpxhme4Xz13n8bxDEAA/0GV14MCh+P494YIuzhMWfGwWAEQOh6SMhi
	qADwKnjVz0gP+DIYbipmAm2Vm8GKIdVNGyvPki9TZJTzprSGSwK9Xydnm2pJY/F5pOnNABYiDiw
	abpFEw43i70NncTHgAcQQmiJE8378fao0h2Fq6io6hbizIM4loW6mi+feua1hl4Bp2dbPhX8Q+P
	IFrSjHqmQ41MYN4rr1YA377Bu2sYDiIEflcN6UaUuk3YDWuFSJm3NQOhh3XacpWMYG8VIdqj+nN
	ZbRi8p4wQiEKzNUnzYBm46qv78qQoMqC6UWyhqwzjypN5MEGclMe4dRwHh2h0eV+15EC/IK7Neu
	ShI1eEctUKSMgc3krK9XNK63yfIU3aNXCD3VLKz0I/Rn8S2cYJkEtS8yV1FnlQNvJTARrDakp4E
	zpfw==
X-Received: by 2002:a05:6808:1715:b0:4d6:92d4:c806 with SMTP id 5614622812f47-55be87540e8mr194875b6e.62.1792703503249;
        Thu, 22 Oct 2026 14:11:43 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55be934e467sm78324b6e.1.2026.10.22.14.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:11:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 15:11:41 -0600
Subject: [PATCH] dmaengine: mediatek: uart: clear the active descriptor on
 termination
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
Message-Id: <20261022-submit-mtk-uart-dma-retire-v1-v1-1-3f9b99a9d89a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBCF4auUrB1sIrXgVcRFmr60oyTKJC1C6
 d1N7PIf5n2bShBGUrdmU4KVE79jCX1qlJttnEA8llamNVfdGkNpGQJnCvlFi5VMY7AkyCygVZN
 Hr/vu4jrtvSrGR+D5+/fvj6ML8ITLFa0fg02gQWx0cz0VDnHiiPOx2/cfk+Fa1qMAAAA=
X-Change-ID: 20261022-submit-mtk-uart-dma-retire-v1-fe71753c51ff
To: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Guillaume Ranquet <granquet@baylibre.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

mtk_uart_apdma_issue_pending() keeps the active descriptor in desc_issued
and stores an alias in c->desc. Terminating the channel collects and frees
that list, but leaves c->desc pointing at the retired descriptor unless
the completion interrupt has already cleared it.

The next issue_pending() requires c->desc to be NULL before starting a
transfer. Canceling an active transfer can therefore leave the channel
unable to start subsequent transfers, even after synchronization.

Clear c->desc under the virtual-channel lock when collecting the terminated
descriptors, after the existing interrupt shutdown and synchronization.

Fixes: 2537b40b0a4f ("dmaengine: mediatek: do not issue a new desc if one is still current")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index f74e9a328588..d9427d56bc50 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -433,6 +433,7 @@ static int mtk_uart_apdma_terminate_all(struct dma_chan *chan)
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 	vchan_get_all_descriptors(&c->vc, &head);
+	c->desc = NULL;
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
 	vchan_dma_desc_free_list(&c->vc, &head);

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20261022-submit-mtk-uart-dma-retire-v1-fe71753c51ff

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

