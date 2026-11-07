Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048240;
	b=OVMIP1QC7JmwxaRiQ7i8r6hVFrNC5OAA83HENsVEmnuI0sF5JBhJutQAy5k37wU40Lj0
	 eIFtz8gkiQRyZRTDQRPZrw/r7Xlls6AKav4LMlRF7EIjNlQHpB86OJXv2m+9ZfPNdigHW
	 v/XsrOMs8GY/4jwmiMtbL0lqSBdj3EVnqDYtifD+ZxD7NWE0lBkbbyUBnb5pRWE4UyX0k
	 1RA8k7JSg5+OIU+Q2dJxarJ0xob3Ogi1Az7OLgvHXDf1oarLrAs+GWHseNNhVZfOBdjlX
	 HikP6/lkF3NRE33FiUaPFnyuAHuKiAnMsJ5MO6FJPUpt0mQosUDmc1/PNRaHJ6oT/9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048240;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lVXFvc0F++pjk92OJlZUV/DSeIaeA3eZtkevaW2u5QI=;
	b=Z9cLwcpIJAmf/wRfkmMdTKX9Zs8WtVJlNUdFaZ0wGrpD0Y9mcjIGkGVbeqqwV8pFXoJN
	 V/G3y1wqq6qdoAynUGWMqES4zFGCu3tlBv3a7VCjg+PkdkmOoeIvsywRx5iobodOcg6a1
	 xQ/yYoDtB7VTqqZfjA6O2UKSA6ShBZ0aIZTEBoPFXg+qC0PXfsKKbaDI0IXT71NrdLNWc
	 aVK+kONyrxEhtPOF6vQfXeZUFTP0y8lRrYVf4OTMvox9DC1EdWA12H6jlGY4jKftgaBpv
	 R9+DIA0sQFKhIh1vfE56gRH3Y5uecxLMJw9Ko9gMox0t4LqXgPKck4Gl2wA5YCA2AQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXdwkDLS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E43606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXdwkDLS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5101F0089F;
	Sat,  7 Nov 2026 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048240;
	bh=lVXFvc0F++pjk92OJlZUV/DSeIaeA3eZtkevaW2u5QI=;
	h=From:To:Cc:Subject:Date;
	b=JXdwkDLSj2YOKpIFjobU6dkjkkA8eG3ocz5RSlC9JusFNXc+mqBdSbC7G4SOWp0gu
	 E8c8+AMotmGo0oiij2cDVo+Zwx9hsYtTY4bQMAz2zgPNYOyD43XcS90Jh1S1EqkjaK
	 4ptHtId6HWqe4ls2CltTXN3LI+9jDkenHIVKaBeS3MhPMxq5WwL873dc51gK+27sRV
	 dLYpFL2toWg2ESsFoNzipc1lxG2AVONsIWEb6mECxphzbJq6gWgdqKBHTAnE3DTGKf
	 9yB+qQUcK6xL5NLmOZ5cSb4eVTt0CGzFIjKxH/WjmW+pRLC4u4aHyBsoh7YG/QqrVq
	 vvEY9La6hrINw==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: rockchip: rga: quiesce IRQ before releasing m2m state" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:58 -0500
Message-ID: <20261107054358-failed-6.1-a875c43dd95e@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a875c43dd95ee4f9c4e3e5ae1cb8362cc6d7817d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054358-failed-6.1-a875c43dd95e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




