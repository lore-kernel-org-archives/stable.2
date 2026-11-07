Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048245;
	b=zkUeasP/opOaqTmCeT0+FEOD8TPLEg96Ci3U2A8XSQx5yaHMYHRk1qi2h6vhSK+Y3mDk
	 3RjtIC0cd0snfW0G8cF+XF764bwEK63Xn/0Subu5DvZF5ei1Roi9KEsD30IuwQ90DN42w
	 Vqhm6RLkAVv8YtdiDa3cSfdxSkrWsNuj6R76oRHqO4L0hheyuyce8qIMx+slr4cCZVhHd
	 N60VfhSE1pHwV08iGEaeHM1AySFJOUkpru9tRzw97RQljsXP9vdYOcxttqB4aMiaJxsk6
	 xkO2twMx0ZgUTPxgemJqicw14z5773K81v4XsQRr3UAK0yQKoR3EY3D2tQKW6yQx0mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048245;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qRVuTPj3l3jK1M8O66OTWI2790U6iEN9qrwB85yhoTY=;
	b=4N86Nv6+7Usj9K+NiAOnHrqktJ8MiR7uyM8DcavuQpkWg2BTBP8V5h4rl4f5kWmepBdB
	 IbWTOU1foe+u5KsIOp8SR3AKGhUP4KTOaT/gNh37I3mWR00WvcBw1ipVpexQ4oifIgtUz
	 k4F0koGFN4/w1NvLxCButAMeZq2pphU0cmLh6huzxnQRGzig1elJkPseC/ip0nPg6k5F+
	 fNjTWi9U0RKxZTpuXQAdKjUTGlhkX6OHT5LWghujpQye6a2fPi9jXeD0s7bvp3f7SQfnR
	 wj7wrV/HuPYwrMxA20Y6gul/ekzOY6IAo3D924GYnuqeJxTZkyhzfEXsBGeyBmo371Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgCsr7rB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04651606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgCsr7rB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4B91F0089F;
	Sat,  7 Nov 2026 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048244;
	bh=qRVuTPj3l3jK1M8O66OTWI2790U6iEN9qrwB85yhoTY=;
	h=From:To:Cc:Subject:Date;
	b=NgCsr7rBNCytMnPCBaCVZqEbKVLkegZrkRyPcnSfV3zg1H8OHsRGAhqRUZp8quHtf
	 oAai0GaouwstUiayE0hynLYo5emb2FnRxdnfyPUAw/Md1TvmuTTscSvFHoXqlQccxr
	 wrHUoOJqS9V7L+RkszOrSCLFh7Rfhol+L2eJU3GGQ/LK9TOA/lRQAMPcL6wiGpiFva
	 I3s0CfRY54Gm9VYqPigSkNYn4rR4zEBpugnGTghD7vWkRCZkOwZB1m3xTZsIqF/CNY
	 mdX1uFIbjMbRB97HXf1hT0kyTWpBQExh+Bx1vUp1p2jEmeigWVwMl2gVma/3xQR4sP
	 cinam+F4rg8xg==
From: Sasha Levin <sashal@kernel.org>
To: hnkz.64@gmail.com,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: mediatek: jpeg: Avoid context access after job finish" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:44:03 -0500
Message-ID: <20261107054403-failed-6.1-7c7f31405b76@kernel.org>
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
git cherry-pick -x 7c7f31405b76acd95a628c834ee8a2d6da439782
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054403-failed-6.1-7c7f31405b76@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7c7f31405b76acd95a628c834ee8a2d6da439782 Mon Sep 17 00:00:00 2001
From: Kazuki Hanai <hnkz.64@gmail.com>
Date: Wed, 2 Sep 2026 20:22:28 +0900
Subject: [PATCH] media: mediatek: jpeg: Avoid context access after job finish

v4l2_m2m_job_finish() publishes job completion and wakes waiters
before it returns. A concurrent file release can therefore finish
v4l2_m2m_ctx_release() and free the context while the single-core IRQ
handler continues with its tail.

Both handlers only need the device for the matching runtime PM put.
Use the IRQ-owned jpeg pointer instead of dereferencing ctx after
completion has been published. This preserves the get/put pairing and
removes the post-completion context access.

Fixes: 45f13a57d813 ("media: platform: Add jpeg enc feature")
Fixes: 5827e4b14ee7 ("media: platform: Improve power on and power off flow")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 515c216058749..640ae30736f91 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1574,7 +1574,7 @@ static irqreturn_t mtk_jpeg_enc_done(struct mtk_jpeg_dev *jpeg)
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-	pm_runtime_put(ctx->jpeg->dev);
+	pm_runtime_put(jpeg->dev);
 	return IRQ_HANDLED;
 }
 
@@ -1856,7 +1856,7 @@ static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-	pm_runtime_put(ctx->jpeg->dev);
+	pm_runtime_put(jpeg->dev);
 	return IRQ_HANDLED;
 }
 
-- 
2.53.0




