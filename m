Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329745;
	b=n1CPzmFBdq0CJZllEwzbncBlJi09evYsLQ21NWpjeVwT5H5JjJdbDj852SDdVEVWCn7L
	 UwrgenD4YTN2S36NJWSB4PxJFu+p/TrGmTiyfdSNygKlKnABJQUSdI5gmObBUYDlUKKIw
	 TOts4ksOH/VHMz2ikPTF5CWKQgGtl7yCHSxXZluJSzllD2liepKbP7i9v2ZtgvNNTWj1F
	 FaVKBHtXOQipSr05y5ijilGBcBPqBv7u3iuHR4I5QiBPEoz1mQgT9sFzf2KzFCmLspVkY
	 7gHgtlye7lCIMiCBooFXmB5p3qX8TKr6uZ4tyB44WfSR2+LK64IZ4PCSzeCNh+P73UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329745;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t3UotqL8ZeXSkQUZMP0FMsGSlqUB2oGdtiovd9TLErs=;
	b=e72rlYTwugasdbUURKqEAu4yx8sf+tXq1TE8H8ESywoBA1BiJ/Zf3/XaDbLU2tNRH1Ro
	 J9a6TcG/2XBcf42JZXGejnw4FnQpSDosP7MH5XXitIpQrpoS5gD/ty1/gpX7EXHAfoFve
	 +/t2JdwriCgn79smKKOJqo0lMygKegH1AWN2jzsjPf/T0LAYgoFMNGWdl+jBbivwjHUDc
	 fmfK8AWY8DUxp2P8IcCtG6DqT4yJivcJxpxo8pvOu/KAxUBu/likcJaYosfuxlYsXHxXZ
	 rhzjWYVkrrqT1gQ17gyUFIz0+D/SJTqfo3T7G3QcyVE3kVRzlVJIvfsWhxTzNMHmEwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuboUHly;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51A606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuboUHly
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD631F008A2;
	Tue, 10 Nov 2026 16:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329744;
	bh=t3UotqL8ZeXSkQUZMP0FMsGSlqUB2oGdtiovd9TLErs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HuboUHlyprscL4mgl+enjRM8RrUhrNjBUSkM3oxhuNZWLsDUV0KXKc+fVhn3xnErV
	 8W0770e9br2TFE7mJoFrl3JEdJsczL5cvaljFZlHmo/wZyTjkIKdx4QP/pJL9GfQq/
	 Lx59qsfTi5I2n+bXe0gbusPdh921iB4BJgSFwJMEAdylTW5TNS/UX3s4/FYn/t9tCI
	 ABKwI2jrbjt2hO/pYiwDihyDPXKeYbNvXRujVhR/4Njoc1tjGSs+01QkKllBRpoXNp
	 WZ/08Y7dgjEgzN67kwKJmfSQ84aumyACX7aTyt9Yy8wx21mEeagv5JHa14W41N/2FK
	 97xo/I/n08KFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] media: rockchip: rga: quiesce IRQ before releasing m2m state
Date: Tue, 10 Nov 2026 11:55:41 -0500
Message-ID: <20261110165529.2604741-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110165529.2604741-1-sashal@kernel.org>
References: <20261107053116-failed-6.6-a875c43dd95e@kernel.org>
 <20261110165529.2604741-1-sashal@kernel.org>
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
index 85c9eb6027c32..be5b3c7c54b33 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -770,6 +770,7 @@ static int rga_probe(struct platform_device *pdev)
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

