Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046728;
	b=1RgNaXQiQG/21c9zRYZM2hu2ZT6X/YV5YfIBycBTYxsaMHuNB+6pRGpxb6ix7ylrYr9/
	 mEpdZOKPJuSrZXyIXcYDsyVe9xM4YHLAivi34Eh5AyZIuPeIojMw5mzKjakakZnc9wFUr
	 g45WUSd24oTw5mK236+2hGU0/48A6W2Cmhf4FF5h+A+AlWX0c9L2+HKIYizktlcTJ1CZk
	 lxIsevPDKxnAl1EoLuJeNJnqcz3Ow75qjMwsywwV2RDVUAthvhO0XNdpvDQMZDpv/PtZX
	 r40fIrMqSoAlre3ghj0YfENlZKfZhsldGXwUQTY5ccx64eqb5G8JdZ+kBU7qAEV4wIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046728;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C26Fc6hEquyslqnVTv9qw4+3PlxPN1H+EIRXpJcNcvw=;
	b=yjX0+UTGFgUFC0uDNL42JnJFaFy72TNeJohUfqRzTxuOy8lzs5pgcCuyhzwGuVztv5lo
	 SxPIIMyuOEsm9K0kf3kCQjevhBoV6jiFt3+fcZo9NbTAnMoTPZ7UaAhPfouLluh3fvVzF
	 7cwUQQ/VGwKbpcw1sVh1SDtcgRP9ozNyiJrYNhEZagWeuoBneUUJLf5D9i2CbQRzvvw3v
	 GNZlzAiDSYvhMxaMHgd0e7SC+G5xCeP1yq+DWkZI7CvWOcRZ8UYf+wNmFulmZe8XzG2Dl
	 W2d7GYI566ygLZZ9L1BuLfMJEo6+p/IW6F/U/lJVrGkr+0jRnAxg714lsywVr3Njw0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e1hFmO/v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A891606EE86
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1hFmO/v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B751F0089F;
	Sat,  7 Nov 2026 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046728;
	bh=C26Fc6hEquyslqnVTv9qw4+3PlxPN1H+EIRXpJcNcvw=;
	h=From:To:Cc:Subject:Date;
	b=e1hFmO/vkbVqFWsP7aEFpPDNyAEqu5QrXNxDgRuS9AOW4ACUkKdQwX7EPh3YIodSD
	 U274CCmVKrQhUlhN7T+ZzIwJDyX8UuJjoy9vn9M9ixXjM5Eg8MosySEc9eAnY1LO1i
	 99zTR7AuVRfi7J7pyXnOV5T4QmiTULjYF8wEWJ1b4TPuqQcuONrweF8pfCa0pUPEXA
	 Kp1wA2N8VKzKDzZ41VWVNN5iJTnAwJOm3hdWdxkG+U9g+xZFIjAZ+QdieLCy1DqEXM
	 +DsOXHzzjSxLgzxqtXxzyAHWVHl2InVBwPpGW6FrXzDboxbWzSVc3iPBWpqvweEPbu
	 lYU0sBn1+0VTg==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: rockchip: rga: quiesce IRQ before releasing m2m state" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:46 -0500
Message-ID: <20261107051846-failed-6.12-a875c43dd95e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a875c43dd95ee4f9c4e3e5ae1cb8362cc6d7817d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051846-failed-6.12-a875c43dd95e@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a875c43dd95ee4f9c4e3e5ae1cb8362cc6d7817d Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Sat, 4 Jul 2026 08:46:59 +0000
Subject: [PATCH] media: rockchip: rga: quiesce IRQ before releasing m2m state

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
---
 drivers/media/platform/rockchip/rga/rga.c | 4 +++-
 drivers/media/platform/rockchip/rga/rga.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index b3cb6bf8eb863..fbc99462dce28 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -797,6 +797,7 @@ static int rga_probe(struct platform_device *pdev)
 		ret = irq;
 		goto err_put_clk;
 	}
+	rga->irq = irq;
 
 	ret = devm_request_irq(rga->dev, irq, rga_isr,
 			       rga_has_internal_iommu(rga) ? 0 : IRQF_SHARED,
@@ -876,8 +877,9 @@ static void rga_remove(struct platform_device *pdev)
 
 	v4l2_info(&rga->v4l2_dev, "Removing\n");
 
-	v4l2_m2m_release(rga->m2m_dev);
 	video_unregister_device(rga->vfd);
+	devm_free_irq(rga->dev, rga->irq, rga);
+	v4l2_m2m_release(rga->m2m_dev);
 	v4l2_device_unregister(&rga->v4l2_dev);
 
 	pm_runtime_disable(rga->dev);
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index bd431534d0d39..7bcdf36c11b4d 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -73,6 +73,7 @@ struct rockchip_rga {
 	struct device *dev;
 	struct regmap *grf;
 	void __iomem *regs;
+	int irq;
 	struct clk_bulk_data *clks;
 	int num_clks;
 	struct rockchip_rga_version version;
-- 
2.53.0




