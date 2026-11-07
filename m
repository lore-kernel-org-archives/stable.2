Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050319;
	b=awU7pIHdRoSuzByVPKRosJYKe024+WruGDBu6NoVBhimreGn2PCXakQ8wQIgYT6Bevkz
	 9KjFZlaDZQYCemftjvvusV5SJtQNeKeBayWFCnyUhf3mccS6Ve203bNE9X2RyHRLHqafP
	 o0hzrd8AS3yJ9hbJdR5ym9UobGNyRUIi37nhf1hRJhC2t4/CyNYrsSs9XNSW3TMIFBVbO
	 WxsOJZQkIYqBFGjNvoSA6bt9O668nUAsExW/EopxdR0nYJFfXQ69pgHRW+CYUsC/0awwn
	 QiCJSdaAeAow232EueRvfW+76sHCVbqQ0FWXnWI5uvcwgKIp3gLZ0qEQO8Gb/oNz89g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050319;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/Z3IEnDJELhEqKJfmAlUso+agFi13Z7poh6KIlpnLGs=;
	b=ESDsDgvVXGEPGAwhKMLkD9aG+UzNwWPJl1XGW0JjZrYVjfgDUBthDX0+VeP0BUXcKYlX
	 8pG1qo7h/w43j0Q6Wl8wPtwNIxSgjIXpzBKGmzUmZCbx8S2VL2ypYW5+DWRgb4L5RZXyO
	 goWWCYvnRh/vEwqPt0Y9/OccmRtAgZhWBSznG+QqN/GSwAmCxE0AcFY83iNKknPzEuDLN
	 WZlNpLsPQnHxjvy8TmmBcHr4mqT8gleNwANjK9faP1o5Uv2skF/I+4UnurT86Q4Vldhxe
	 1COarN+Dvwcj4UT8PBppFuhmmw9+cQPUBol2d4EZ7PtnUacKNHSzDAwrhh4+EWqtAdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWTADK4S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E14606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWTADK4S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C801F0089F;
	Sat,  7 Nov 2026 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050318;
	bh=/Z3IEnDJELhEqKJfmAlUso+agFi13Z7poh6KIlpnLGs=;
	h=From:To:Cc:Subject:Date;
	b=hWTADK4S9w6jEtyKTbKLkxgJ8L4nvapqXN4A/fXED7RCB5dKEC0PV9aEDjmNAlVq/
	 SCDVUPoMAvSwwk5Yn8Qp5B8S1hZ4TKDVJkd1YMWjB3leSIKGq7U2gjztxRJB6NjNfs
	 TTA8tHbZz5WWnLraSErGHkbOEeE+EUNdk/NiMFeDvjutWzkVVnw4jL8GgJRYQJfuRu
	 QHkvcUPQF38SDTUMmak0COcUzAEv8CqfiMuybnY1hqO6GQyqK0xfSyrVxFlmxwYDz2
	 NqdCdIBNYnHEiAHavFJO/xrqWywvyKXGQ+IEvIPEpVqW63KIS3ICyC3mGM8ncifo5A
	 X0obO9m85aEZg==
From: Sasha Levin <sashal@kernel.org>
To: hnkz.64@gmail.com,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: mediatek: jpeg: Avoid context access after job finish" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:36 -0500
Message-ID: <20261107061836-failed-5.10-7c7f31405b76@kernel.org>
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
git cherry-pick -x 7c7f31405b76acd95a628c834ee8a2d6da439782
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061836-failed-5.10-7c7f31405b76@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




