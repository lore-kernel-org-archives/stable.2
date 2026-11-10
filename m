Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330551;
	b=3u6L3t2rQ7JM+nEwCQ8D1r6/VxCTZjWoQWZL1x1+owxLHeOvXF14E8lfAcfdRXC7G3fQ
	 832eg8HwtTn2vKzBxIF9lD4FYdyEbYQTBCKo8VchmM0QCG9Azzio+yasva3sEn5OyZ8rN
	 IbJmufLQMfAp3AJv9dTVblhR4iACiHeSrICwYkvptL6goo/HY/Pl7bEdTyewjnOZvPjHq
	 4lyR3ND6GWH1ktY/GjH2vuuaCyfv25gp1FNpQqCAlQy6Hekup4rcQdRYmoS24ZT/dGuPA
	 W41kwzQcf+IcDC8KjEOsKgDu44yfn6KfEuPf/HWYC+HB0sdK+ZeuLQd//GobHJfHeYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yDGaZSh0J6IT34tg/eXiB2xftD69QcDu3baQCcB+ci0=;
	b=iwQQx3VgeOTItSYFWZawyN3TdQFA5Q9QCFnQB1xSZA/NQ1eeiMDwe21vYhpEIoKVvwR5
	 mgKqE3pFmbpMk+CgE+ZTA2yxGB0wPQNkipgGuILNd+36GOR4HbnNZCezrz/SJeewAwXwE
	 OjceH/9vZ5iZrfgTyoNp21JORT4s3ZxCJW1tFdXy7V/cn1SNBeR2kfjeSNxxejSdCoiI1
	 93dMBYDdt0WVtguoc7lAAvNGpJkIAbAPaubvIVebEpckih5rduAUY2UBd6XYj3cutlyRU
	 GGlMwwg+6MfgBa+W5NDBa8GpOv3akz1Q7vdA3EvMiYSXxiO6y0PtpOIvxKPmqK95CrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ei4cf8+c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ei4cf8+c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7A21F008A1;
	Tue, 10 Nov 2026 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330551;
	bh=yDGaZSh0J6IT34tg/eXiB2xftD69QcDu3baQCcB+ci0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ei4cf8+cChIF5OqF8cSrJJH/sfPZdqn9/WGeCwgd4AarKL9jMVlJe0e9ekGUg+dCN
	 W66qvfNq9c+ISgoIzaC4feuzxNwcGno6a7EFIMw4Ej++/s6bYl5jl9xSjrVtvsB+Ew
	 hRQN4irTg78DD7NJ2pbJs4fKwJ+wWdlm0iU5RnuNdoAmFR8Ts5ums42vJI5gVW/i24
	 SlF5SB5m0iQCOlqbDqKCotki6hjq3poZzSWxtnz9IAeHwCez616IN/Sq+6w/UEk1X8
	 jf/cSMeq++XTDr/kv8u2zxbId6lTPVx4x9SH2fTaF8si5jk7AsT2NWvnXnYgyB9NsK
	 pqyd1/0I3o/nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] media: rockchip: rga: quiesce IRQ before releasing m2m state
Date: Tue, 10 Nov 2026 12:09:07 -0500
Message-ID: <20261110170859.2632294-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110170859.2632294-1-sashal@kernel.org>
References: <20261107054358-failed-6.1-a875c43dd95e@kernel.org>
 <20261110170859.2632294-1-sashal@kernel.org>
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
index 7cc80e11d9d00..595873bbf0137 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -773,6 +773,7 @@ static int rga_probe(struct platform_device *pdev)
 		ret = irq;
 		goto err_put_clk;
 	}
+	rga->irq = irq;
 
 	ret = devm_request_irq(rga->dev, irq, rga_isr, 0,
 			       dev_name(rga->dev), rga);
@@ -884,8 +885,9 @@ static int rga_remove(struct platform_device *pdev)
 
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

