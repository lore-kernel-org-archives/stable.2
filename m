Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328641;
	b=d5OliT1WmwrtWsnPqH9q3xKVBHI0s2owymgqJH5gaYNvYXK+S7itF3vXqJRydjrSoxbY
	 LnMVgHWC2Zr18MxRIaRUWoLY6HkGf8bVNCWyb/X6YSaAmnMF5ElgcjZFymKmNtm86RAtp
	 vTGKM58KC1u0gQxThE2K90E3gQ/43EBRpJNNJ+ihgMCMb/z2Y5XfP1VLgTqmAKsV+0sNb
	 378zWTbD7NzNNkF8Hm9KnxvsnMuTpNckVi7aZ9xPPNFzsaCaIzWrQLb80gOviXDtvDWKW
	 miuNN35fWTs4Uaq3mqxrSStcugMKO6ZzmcP/zQYi7e7HDYf/lFrKXNZXnLa/fvaFq0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f2prddDhjdzQ3Gh2IzNhaMn+LbTJgyUOZ0mOZ7lEqMA=;
	b=NQd1/o6Onf9c/ga+dk6eP2JjPP+7LyVXRTU9fRht6OoxbON51EBNvSQuyMutx5mDvR/V
	 FfsiVnR3lfSYWuLi7uHXYvjN3NsBpfBlVCtbdaeijCk252zsL+sXWOFI8fW7wXpg/LEvr
	 /d4huF82vMbZRrRlzSvFDD/i13LpLBh69kBA3r758Agyahy4ZeV+FB5M8iQU8xyXEptq6
	 DWaKRvQh3yqpZYLX4J4BKonVxCDzvndd9OmcxySy6FPGsvvQQt9IuwYILJXerE7BcbxTH
	 fuh/c+JSQuibbwMPJHl7+DRuo1TSmUsLbaBGoiXaXxb4UVkL/LjuRAm2X4LT1Nv+dTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkGLKFDN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86235606A8A1
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkGLKFDN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5C91F008A3;
	Tue, 10 Nov 2026 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328641;
	bh=f2prddDhjdzQ3Gh2IzNhaMn+LbTJgyUOZ0mOZ7lEqMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LkGLKFDNrtatZxZZxLY1/PhZinCrbhkIJdCoPrKWyskWnfsYHV5UWcdGW85nuq6mX
	 pSubBmr4fxyv849S5Hd4FKwcppzbSG3K6tM0IKjn/0lo0vt5CgDZ2W9LAfg8vOlpEj
	 uVkrO44EEfh7DxCH4m5uUOoDPkmTbwOi4GDqJe6JyKopD0HNuPDYBsYsLsuApiYHBn
	 gCalEdGfejHJZyLbfZeAp+em8eVpBeI2Kn+wT8oAEF4wLnJi4T/VLXQI4xZkGfXcm8
	 JWvj0gPIELt/t3EfIdxsVhNGy8RDCyENNDdDjGciFqVt6DOSc0qcODDkgp0vWQ7Dl4
	 39wncicvjN1FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] media: rockchip: rga: quiesce IRQ before releasing m2m state
Date: Tue, 10 Nov 2026 11:37:18 -0500
Message-ID: <20261110163712.2515627-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110163712.2515627-1-sashal@kernel.org>
References: <20261107050811-failed-6.18-a875c43dd95e@kernel.org>
 <20261110163712.2515627-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit a875c43dd95ee4f9c4e3e5ae1cb8362cc6d7817d ]

rga_remove() releases the m2m state before the IRQ is freed. The IRQ is
devm-managed and is only released once rga_remove() returns, so rga_isr()
can still run while the m2m device state is being torn down.

Store the IRQ number in struct rockchip_rga, unregister the video device
first, and free the IRQ before releasing the m2m state so the handler
cannot run against the freed state.

Fixes: f7e7b48e6d79 ("[media] rockchip/rga: v4l2 m2m support")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rga/rga.c | 4 +++-
 drivers/media/platform/rockchip/rga/rga.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index f0bbd161fa92f..f956f2fb222a1 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -782,6 +782,7 @@ static int rga_probe(struct platform_device *pdev)
 		ret = irq;
 		goto err_put_clk;
 	}
+	rga->irq = irq;
 
 	ret = devm_request_irq(rga->dev, irq, rga_isr, 0,
 			       dev_name(rga->dev), rga);
@@ -879,8 +880,9 @@ static void rga_remove(struct platform_device *pdev)
 
 	v4l2_info(&rga->v4l2_dev, "Removing\n");
 
-	v4l2_m2m_release(rga->m2m_dev);
 	video_unregister_device(rga->vfd);
+	devm_free_irq(rga->dev, rga->irq, rga);
+	v4l2_m2m_release(rga->m2m_dev);
 	v4l2_device_unregister(&rga->v4l2_dev);
 
 	pm_runtime_disable(rga->dev);
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index 2db10acecb405..0a15ec9aa8aae 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -82,6 +82,7 @@ struct rockchip_rga {
 	struct device *dev;
 	struct regmap *grf;
 	void __iomem *regs;
+	int irq;
 	struct clk_bulk_data *clks;
 	int num_clks;
 	struct rockchip_rga_version version;
-- 
2.53.0

