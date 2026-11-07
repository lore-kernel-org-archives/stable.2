Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049317;
	b=QLz5RFOy7rELhoZwa9y2KfX/ouH+gNT/D5CGGGUpt74kZYBadIBBa3oEMoqhQqyAEflm
	 0NsigAOTgBg9vejL7SpEPBqCOOzVVU89L7iKFs4GgFv87NmuEBreaY/4fM01k9mulBYWb
	 GNGe50kn9fvITWhJDrwsV7OS/3F6Xpglz//ElKLcSFkVYdHqyGoqFrb8xB9GHCbczcw6+
	 PlZdezVNA/rbUrDY+n48kgO4T30qjIRQbHcCqtKwKD7x/wYVoji4FboL3uMOhCElmsbNm
	 RUbCagUG1Q59c6necjtW5scQEZyOgLEnZmZ5tgXMdsuPsliN030N/Ep2Bwnpl/mJXEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049317;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ASkN+PIDDHq+hhXMAOZJMIkv2uBKiq6qU53dkhagYwA=;
	b=MCqDY4ujWbYD+zbjMwE9+fwhie+COGPGgNJ2n6q+I1ZxDRDWf8Q7BIn5ZENv5geiHfER
	 forb7Qo64hySpng8mTOGq9x3vKldjUXFzUn+xqvHrAa1xSy5d0LSuKZ42lQR+yIvzaASj
	 UaDh1IFP6wVPKYcr4JuyKgphk9/mZ7Vr2dxIQK3ofh1F7Y6phi/Xw1+zgbEjDVjRXVUcR
	 yoNiQNnmRTzDfyik65kVEy9OZxADcTvfqfYZzkxhOhPYsGBItSdBiLLAkgxzKwFeulxXL
	 c6BpCSzLTIdsJT2qXyS1tZJlJWciblCppVD3AcOSF0z+LpkzxstMu+TRgOgZnl9DA1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hd/uV8Cz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84E606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hd/uV8Cz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD3D1F0089F;
	Sat,  7 Nov 2026 11:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049317;
	bh=ASkN+PIDDHq+hhXMAOZJMIkv2uBKiq6qU53dkhagYwA=;
	h=From:To:Cc:Subject:Date;
	b=Hd/uV8Czodl81tyxhOjJwAU41ZVwUb/hl76I1Fls1pLa8ptyb2WROY0Czz4jDLM5W
	 MxHdWgvBERssvUhPsYkoRwvkJsxDptVl+fmRNz9Ezf3lep3U+b0jd96cILt14uz2iM
	 TDMst5VNTqj6ffDXO22MgV1Q+TDLn7h+KQUqR4EafWi3Ww2w//5xLSbb4dB0LNMcLO
	 UKub8wXoHhumkG1ZDyQkeRPKWtE/ns1t1Lwxc5gix3lSpK7hMGoj70/tqw9x7KG+Xc
	 4LAYfdqWGFIDJLg/CJQpNbGm3qBgwoBC4C/tPyzss2rFj1R/RtGwAyUMgrDQYfnEhF
	 2Kmp/rs832Nvw==
From: Sasha Levin <sashal@kernel.org>
To: hnkz.64@gmail.com,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: mediatek: jpeg: Avoid context access after job finish" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:01:55 -0500
Message-ID: <20261107060155-failed-5.15-7c7f31405b76@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7c7f31405b76acd95a628c834ee8a2d6da439782
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060155-failed-5.15-7c7f31405b76@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




