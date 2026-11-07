Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050322;
	b=CjbzcUkPbwnmiXDRXAiq3g40woq2EQMf5vBdMAZxVc0/L2OeSDACW/4ZlScXcW5eT4YO
	 80FqgbHUtxenmBpvXnYYE8MnpagIOwN9WHhXsoMP38Hnn9Uja66WmZJ1DN9IM/ra2ej+6
	 cdlCGBDPyQ1qnFR6IK5kOBYLRBxWYIeYSyNlZclrfvVceBKGtoxxPOj9WDISthrlT+aj/
	 rfWAo3i0eROBgfTnuzNYw+YO8OdyN1LIfQJOfhy4tCF9b9NJcPHktseBcOss1LzcJSWy4
	 4Xeze7/8PWbRzlQ6uEzJm4sTgoXCw6eIEuEVyV1P92XtqDZYsM0OSKJt72Xbnnaq8Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050322;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=taxQLUa3HEjOn2Mma71fttBqfSDEvFyU8ecdmzUwuc4=;
	b=nWtWwz4sLjkrIQY0MknE0kYIm+HFYbReuMHehjrnnbL9uisNMyOJVz4ZB1lAIl3GmLmn
	 YM+9umTOUS+gZmH1Ojp/tgMW4yBgAK4sdu6tpzVceAEkmHxJh7HPRlC2kYOAlnJT4ty7i
	 Qrb9YdMFilklQyU4KOFU1iEnrdQzzCuw6v/+uuzF7tZlICOpwI8lB04DE63eRsCgygckM
	 tCA7qIb8looc5/d94fp7mTCJsVFbvyuaDocXGhRxPs18sdcug1vXbxj1gqRTy2L1Jlc1Q
	 tAjle75zEuwxtlG0mtLq92sNh9+D8ZYmlU7O4gaNIiRO4Kvh1PTHKJmbGI5reKZjIzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMaN8uTe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F67606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMaN8uTe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493561F0089F;
	Sat,  7 Nov 2026 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050321;
	bh=taxQLUa3HEjOn2Mma71fttBqfSDEvFyU8ecdmzUwuc4=;
	h=From:To:Cc:Subject:Date;
	b=cMaN8uTe7YFIwol2vBA+dU5EgvrY864NUS/D8Cy7qD90SWDsJGDPS3g8wMs9FSJIJ
	 3BkJ1YVAvAm+ocO/X7obM7v9Oa+grjx+LGubow46Yhp8xRhgd88ljq8pelj2/SQ7Ed
	 fymzGb+aoBzF5/NAws0BuJ4f/IkR6zne4KIF3rFj7+vkE4gsAhlKfqoECIqw+ompA/
	 DBSwbx7w5uIAFQ6j0whFS/Nee5mEau0zZzh6L/pLY1ZdSp/trx+igNs585yZPAjY7Y
	 GTLscVZORel9ulpEdNUC63i6hxXqhA5iualL0A5eRVllwL8tu0U7f56W40v+GeF6Cl
	 PcS75q7RsKBeQ==
From: Sasha Levin <sashal@kernel.org>
To: tharitt97@gmail.com,
	frank.li@nxp.com,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: hantro: release runtime resources when device_run fails" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:40 -0500
Message-ID: <20261107061839-failed-5.10-556ab0b2741d@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 556ab0b2741d653455637ffdd453d65c0439914a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061839-failed-5.10-556ab0b2741d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 556ab0b2741d653455637ffdd453d65c0439914a Mon Sep 17 00:00:00 2001
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
Date: Wed, 29 Jul 2026 06:04:39 +0000
Subject: [PATCH] media: hantro: release runtime resources when device_run
 fails

device_run() acquires a runtime PM reference and enables the VPU clocks
before invoking the codec-specific run callback.

If clk_bulk_enable() fails, the runtime PM reference is left held. If
the codec-specific run callback fails, both the enabled clocks and the
runtime PM reference are left held.

Make the clocks part of the device's runtime PM state by enabling them
from the runtime-resume callback and disabling them from the
runtime-suspend callback.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../media/platform/verisilicon/hantro_drv.c   | 66 +++++++++++--------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index ad71c0402ef3b..43f67b9fcf273 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -59,8 +59,7 @@ static const struct v4l2_event hantro_eos_event = {
 	.type = V4L2_EVENT_EOS
 };
 
-static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
-				    struct hantro_ctx *ctx,
+static void hantro_job_finish_no_pm(struct hantro_ctx *ctx,
 				    enum vb2_buffer_state result)
 {
 	struct vb2_v4l2_buffer *src, *dst;
@@ -86,15 +85,13 @@ static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
 					 result);
 }
 
-static void hantro_job_finish(struct hantro_dev *vpu,
-			      struct hantro_ctx *ctx,
+static void hantro_job_finish(struct hantro_ctx *ctx,
 			      enum vb2_buffer_state result)
 {
-	pm_runtime_put_autosuspend(vpu->dev);
-
-	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
+	struct hantro_dev *vpu = ctx->dev;
 
-	hantro_job_finish_no_pm(vpu, ctx, result);
+	pm_runtime_put_autosuspend(vpu->dev);
+	hantro_job_finish_no_pm(ctx, result);
 }
 
 void hantro_irq_done(struct hantro_dev *vpu,
@@ -111,7 +108,7 @@ void hantro_irq_done(struct hantro_dev *vpu,
 	if (cancel_delayed_work(&vpu->watchdog_work)) {
 		if (result == VB2_BUF_STATE_DONE && ctx->codec_ops->done)
 			ctx->codec_ops->done(ctx);
-		hantro_job_finish(vpu, ctx, result);
+		hantro_job_finish(ctx, result);
 	}
 }
 
@@ -127,7 +124,7 @@ void hantro_watchdog(struct work_struct *work)
 		vpu_err("frame processing timed out!\n");
 		if (ctx->codec_ops->reset)
 			ctx->codec_ops->reset(ctx);
-		hantro_job_finish(vpu, ctx, VB2_BUF_STATE_ERROR);
+		hantro_job_finish(ctx, VB2_BUF_STATE_ERROR);
 	}
 }
 
@@ -170,29 +167,24 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
 static void device_run(void *priv)
 {
 	struct hantro_ctx *ctx = priv;
+	struct hantro_dev *vpu = ctx->dev;
 	struct vb2_v4l2_buffer *src, *dst;
 	int ret;
 
 	src = hantro_get_src_buf(ctx);
 	dst = hantro_get_dst_buf(ctx);
 
-	ret = pm_runtime_resume_and_get(ctx->dev->dev);
-	if (ret < 0)
-		goto err_cancel_job;
-
-	ret = clk_bulk_enable(ctx->dev->variant->num_clocks, ctx->dev->clocks);
-	if (ret)
-		goto err_cancel_job;
+	ret = pm_runtime_resume_and_get(vpu->dev);
+	if (ret < 0) {
+		hantro_job_finish_no_pm(ctx, VB2_BUF_STATE_ERROR);
+		return;
+	}
 
 	v4l2_m2m_buf_copy_metadata(src, dst);
 
-	if (ctx->codec_ops->run(ctx))
-		goto err_cancel_job;
-
-	return;
-
-err_cancel_job:
-	hantro_job_finish_no_pm(ctx->dev, ctx, VB2_BUF_STATE_ERROR);
+	ret = ctx->codec_ops->run(ctx);
+	if (ret)
+		hantro_job_finish(ctx, VB2_BUF_STATE_ERROR);
 }
 
 static const struct v4l2_m2m_ops vpu_m2m_ops = {
@@ -1302,10 +1294,30 @@ static void hantro_remove(struct platform_device *pdev)
 static int hantro_runtime_resume(struct device *dev)
 {
 	struct hantro_dev *vpu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_enable(vpu->variant->num_clocks, vpu->clocks);
+	if (ret)
+		return ret;
+
+	if (vpu->variant->runtime_resume) {
+		ret = vpu->variant->runtime_resume(vpu);
+		if (ret)
+			goto err_disable_clocks;
+	}
+
+	return 0;
 
-	if (vpu->variant->runtime_resume)
-		return vpu->variant->runtime_resume(vpu);
+err_disable_clocks:
+	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
+	return ret;
+}
 
+static int hantro_runtime_suspend(struct device *dev)
+{
+	struct hantro_dev *vpu = dev_get_drvdata(dev);
+
+	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
 	return 0;
 }
 #endif
@@ -1313,7 +1325,7 @@ static int hantro_runtime_resume(struct device *dev)
 static const struct dev_pm_ops hantro_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(NULL, hantro_runtime_resume, NULL)
+	SET_RUNTIME_PM_OPS(hantro_runtime_suspend, hantro_runtime_resume, NULL)
 };
 
 static struct platform_driver hantro_driver = {
-- 
2.53.0




