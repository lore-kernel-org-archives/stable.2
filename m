Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331067;
	b=eKgrqDvrPleuWZDwA9bKvZAIDkEGBxuaGSel/GPBg3leF31rutHSXwo748u7Z5CTItQ3
	 HkTleC3tOX5gHVKam3KzN2cC4sKxW7toKtcN4Dowf7pPeMim57n9bat4oP3HJPZFJgkzw
	 xAqEtDzwWBDWtSkMVRFX03+MBmpSJzaIwSVQYgWAS0BWoF/rYOHXM3EaePF+xA4jav+SA
	 IhEevMoxABy7JGtawZ2QdRXDI+h/+4eGCJJAm40hEzo8jifRN7plFMYyCBR8YypjJ/NrF
	 vVLiPh1G9BkriTm2nhZUfyb+IZ1BLZIQK94ekMTDDSD5+qK0nyLS9gI27JEEKDEYqkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331067;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qgAXz82GHg7Ntd4Cu9dua/sTn+j4JC3TK2QoR/fkQq0=;
	b=0OONFnQbD5Pq/51eRRgf5WUDH2tVMWcWm4eb5r9vaOHyfiXywN5rqVuFE4bnh9yruhCQ
	 c5dEpjl2sCADAVRc/AXWK13ha9AKCt2ZvkCJ1ND4xAvCK+2frevMuzv7tOYlDu96xm30J
	 wAzKehBMLZ70jbvarUoclhoa0oOzkN+2ZsGGI4xIRPXceILlSf511MzigGTgRr3l8wARH
	 ZR4kpQFUgoLKK6NRVLIHudtqiVALzw7iD8WOaBF2DK/06zJP3bwFSq/7wkgBgqi9f9irr
	 Rb34oomJP37LvLkMiq13kD6fNGKS/o1xrgdILtNJBE0E/qEKVwlIzo1+rXb0/5KXzPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TppZLfHh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0660A2600
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TppZLfHh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CF91F0089F;
	Tue, 10 Nov 2026 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331067;
	bh=qgAXz82GHg7Ntd4Cu9dua/sTn+j4JC3TK2QoR/fkQq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TppZLfHhQmSqDIuGn1FRtZhPDJB3zMMhouBOaN7kl1DoyyPh4Eh5ezUA2bsPH3QsV
	 2aabHFkcD1VcwwgokXWYmqjGQ4k3DBaIN1gLD2RaF46WP2Z/M9bsinUi7Re1lwFfM0
	 D6BvNg2RvT7+CqcptZQNCJF3FpE9NwMtoltUGYWd+olf0IgbqAsuwYbcFtz7/4ZCmc
	 MKkKGiweaBmhC0sLcYxO3cZg9MBZGNlrhkaYXjr7x+nUH9DL+zSozJ9X5ePKhjhbOE
	 jRjwbWAjuYEhfG5EY8HE0jmLE+co++75K8zsCk01wBuhwIAQnxwtxKZKkzmo2MnugD
	 nHuM8ARVZEXgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] media: rockchip: rga: quiesce IRQ before releasing m2m state
Date: Tue, 10 Nov 2026 12:17:43 -0500
Message-ID: <20261110171735.2803139-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110171735.2803139-1-sashal@kernel.org>
References: <20261107061827-failed-5.10-a875c43dd95e@kernel.org>
 <20261110171735.2803139-1-sashal@kernel.org>
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
index f9da4ec3eb362..6787d82d457d8 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -776,6 +776,7 @@ static int rga_probe(struct platform_device *pdev)
 		ret = irq;
 		goto err_put_clk;
 	}
+	rga->irq = irq;
 
 	ret = devm_request_irq(rga->dev, irq, rga_isr, 0,
 			       dev_name(rga->dev), rga);
@@ -887,8 +888,9 @@ static int rga_remove(struct platform_device *pdev)
 
 	v4l2_info(&rga->v4l2_dev, "Removing\n");
 
-	v4l2_m2m_release(rga->m2m_dev);
 	video_unregister_device(rga->vfd);
+	devm_free_irq(rga->dev, rga->irq, rga);
+	v4l2_m2m_release(rga->m2m_dev);
 	v4l2_device_unregister(&rga->v4l2_dev);
 
 	pm_runtime_disable(rga->dev);
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index 0825622526c7b..a940919d4394a 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -69,6 +69,7 @@ struct rockchip_rga {
 	struct device *dev;
 	struct regmap *grf;
 	void __iomem *regs;
+	int irq;
 	struct clk_bulk_data *clks;
 	int num_clks;
 	struct rockchip_rga_version version;
-- 
2.53.0

