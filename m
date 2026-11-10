Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330809;
	b=0FQ2T7CRcmmUFH5CeTbsYTbi1sf/H4fYpTMGRWfNT5VMTTHjLb6uwkXZz+1LU10PuNFt
	 jV7VqSrYjyZQNwBpm9WzOSXd4L8gx0CGZgGS54pRaDYjbQEHV3z2ZEXib2ZbLI54p9VB8
	 DiJh0l3YLqMWAaNkxI++q0XiLu8D7mHa9Q/T+xAUFwn9QGcxrgDgfTkR8CbqEfgb4Bbur
	 em5sTxv5IKcO4V6O0QO+RnCfXElUxL6W/ZaFinzHJOVEz9ZuEL44LfB7XmyuL8AQicsZD
	 9Eha+rMwwTEV+Iuakipo3Wu33laYxkE9sCH3nYxVjdDuq4C4O8NGa2sos89l/P/K0jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330809;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qgAXz82GHg7Ntd4Cu9dua/sTn+j4JC3TK2QoR/fkQq0=;
	b=HEXQNBSIMfsRqCKA/gu2x1Rr/VTR4VM4hxtFvUKzY/IbdRbBdlMQKz7a7bFLTyqVs4eZ
	 OYGsA/HBHlu6+4qsKTOnxMz/cOA1YLUi6bLRsOTLv/SFoh/N3dwJY1O5EPPDXYMCIX3St
	 bU07RUroLrSsRme7UbYtQOp4wasWrkD6F4rV+9jdWVdrY/Wsx9+VL9wJ+dsAu5zNAsb1O
	 iP7KdtK0P5jMimwBYBs4Xm4JVV58EuBw+atPy0ct/GkbByr4D64WcPY2uv2M+dUtjYiQS
	 pUZZ4Uxa6RgtpchWUTVGo5hYJakbv8Suq+49cjbCXuVSPu4jr+Vw5e9Ihl7TKncaTbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjzA70aC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjzA70aC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2BD1F008A1;
	Tue, 10 Nov 2026 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330809;
	bh=qgAXz82GHg7Ntd4Cu9dua/sTn+j4JC3TK2QoR/fkQq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QjzA70aCvkGHqdF58sS7O8jd6O8/A8fJsV/wN/v2T/xHLP+czolcOXOhU7dWaSPcL
	 Yob7BXiFomRbxiM+ZAJDRZbc7qbqzRF/FVtRdX5AKviFOUqfG/QyS2L3rxqjE9hgr9
	 qkc7kNqSnsHOxahB+e3GwvdAsSTmxCWmFGGahCM+UUtTIA3mw3LdFUBbdyRCidpEQW
	 WrSPiQ0DkVaP9HFno7s5om/BBYJX6pEuMgirK3nI8KXuZKdeK5PGR9QYhnXzts9yrn
	 6mzKdQICAlxeVqJJ6Y2Y8OK1lq2SoK/M6ZBoz/9A8MUdX4HLYJHNIixIEibZIbkGaa
	 q+qj8j78WJjdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] media: rockchip: rga: quiesce IRQ before releasing m2m state
Date: Tue, 10 Nov 2026 12:13:24 -0500
Message-ID: <20261110171316.2718911-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110171316.2718911-1-sashal@kernel.org>
References: <20261107060145-failed-5.15-a875c43dd95e@kernel.org>
 <20261110171316.2718911-1-sashal@kernel.org>
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

