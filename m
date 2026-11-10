Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329152;
	b=S9aN/39GwTLI9xx+pJzER1CMVCPkrGTGhHsDVn2LTQ+S3ZAk0PLV3lBG/bMqZUgqeXRd
	 lYGWrIFNoI4XQlyEXa4DIpwcY36fCgE/1DHVSJ9X5xyiV81GaACW0XTmigUaLwYjrlBHs
	 7PPJDiCkCe12bE4ZL1JARbNBIjaJNcSmFKw4lzVQGxgYDTT9pek2wYrPABUnXd55uI2hV
	 ssVBZx3sWfrwDbQtWin7pB6rKu3C9u69h5DvRBJwzLYsGyPD0zAWhLgRBSo/ALmD/6hB4
	 sHtYYa3/8Qtq7NQo3a6xOWllHtVSrIxuKD4UQrjhybXB/uSD70bfK23inPKTddx4xHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329152;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eVp+VS6B637ImbyMjqn51fWAjxJZnE6Rl0XGLiEyUmM=;
	b=gE56iNkZ6GsJFVqQwnXwfbtUgkr3C+RMixoEy2pLWayoHNVKfPmFMNBGdnL6LKKmyQmP
	 RLP580OPE1CSpaug+dlFFBhAt/fGJMUrsDorwUY3Ytgs3HBoaiHKlRC/o3B+7zcjqKdgn
	 n2SXri1SMnRLOf4nn7ZfeWbF2IaKN/q9JsejY1gQFyQ4kK9JH7PzoiUUIwP+kfP14Nk4X
	 X+xh9aL3TeA9UiIoMXtuyP8K7/Xct1FtyiaFaoLXjDjBAKo5cvgApYUVe8842EL/GcLWx
	 e6/uxOH7OlLN0HN6C6b3r6gaY/OFnN7RJniAxK6sZ2CBlMiQG4MeU1roiK7qxslo3bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0BHklso;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7188A606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0BHklso
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E031F008A1;
	Tue, 10 Nov 2026 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329152;
	bh=eVp+VS6B637ImbyMjqn51fWAjxJZnE6Rl0XGLiEyUmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0BHklsoHc6+7nCad22+0NSxQ12wge9T2FBkQ9k6Oc2L2hWhDmrFMLbJfYw+xQ2bp
	 OafnqLHnmyn5Q3Mrji2kftPwSbOkRsD/0rlRX0O6wckpi2V6vVDvpT4x0mD06SmM86
	 cit2UtxAxAr/QieDEW1T4aANzuWltRgDHb/fRR9NOEmkGKdCHeZIwmMBLQKWpkk6Em
	 24R6HZyAtOgdCIACdIgxU4zdyIWgPpFthnpZMJBhY/Wr5hdQKEjLh5NN5IrKPs6zPT
	 3wxzoI+n8SboOXiMAa7FR/51IDQ/W7PxQ6EkLzIE3W/nll1L23nMC0iPe0c8wTuWmd
	 sDN/faYzOMeZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] media: rockchip: rga: quiesce IRQ before releasing m2m state
Date: Tue, 10 Nov 2026 11:45:49 -0500
Message-ID: <20261110164539.2563202-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110164539.2563202-1-sashal@kernel.org>
References: <20261107051846-failed-6.12-a875c43dd95e@kernel.org>
 <20261110164539.2563202-1-sashal@kernel.org>
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
index 7b2842d959255..dd512785649a9 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -784,6 +784,7 @@ static int rga_probe(struct platform_device *pdev)
 		ret = irq;
 		goto err_put_clk;
 	}
+	rga->irq = irq;
 
 	ret = devm_request_irq(rga->dev, irq, rga_isr, 0,
 			       dev_name(rga->dev), rga);
@@ -881,8 +882,9 @@ static void rga_remove(struct platform_device *pdev)
 
 	v4l2_info(&rga->v4l2_dev, "Removing\n");
 
-	v4l2_m2m_release(rga->m2m_dev);
 	video_unregister_device(rga->vfd);
+	devm_free_irq(rga->dev, rga->irq, rga);
+	v4l2_m2m_release(rga->m2m_dev);
 	v4l2_device_unregister(&rga->v4l2_dev);
 
 	pm_runtime_disable(rga->dev);
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index 6c3c9f3f71584..8f0185d592104 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -77,6 +77,7 @@ struct rockchip_rga {
 	struct device *dev;
 	struct regmap *grf;
 	void __iomem *regs;
+	int irq;
 	struct clk_bulk_data *clks;
 	int num_clks;
 	struct rockchip_rga_version version;
-- 
2.53.0

