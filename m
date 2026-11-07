Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047485;
	b=jjY3KpCMiCqD8XJP4vwSFKSiYWDkuSHRFCpx6yeaNkZyQoEFXOenXO0Sz+ZP4ob9dKQV
	 usr1OAdUFGVyeg4+SN0ZWLQ+XJEQ2P9ckNXNjSVpltdRFPmS/iG9iTmO1noz+GGxn4E2x
	 y1ymhXz3WUj5fmJS6xe3Fth3L7BwCt5R+KRix67Aj+VtBzEiR7lKNvyimYwfwwI7YWRlI
	 npGTbfN4LU6JBsnKrFvW0QIhARPPLzJQa2MlNIeJXNpg7mbCqrOcUnb7aoCofx2bi2hjS
	 q+U04xjl81FjqYO3btCd2Ehksx2KOy3wkVS8e9Ofi354ORGJaCIaXAnKcKiahuHkDSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=h65DeLsJT0p8L24jCnzFyKnJq+U/vlSNPcNGZNiiaCI=;
	b=wiOywLjx3PhV2uDk9UMtEQuvcqzi0MyBJ6/+UlORYJ2s4PqMNZarIDsixVoHdCao9Kie
	 7yNugGmNKHaJ4tet7PtfFk7grB6puOqsoI8Kz/WnkBnzoE4I+bNMqGp9bxuSQ0PKZ6pzB
	 85+h8lSPl8MwQ3HhdPy+tW0Ei4naZb6r1hx2p5xduzyZt287o5VHxr7p3qDaAd1kKEbbY
	 j1l9SaOKWyaH8w48HZzW+u7paQKCOTx91zq+05aI3tjbkp7wf3OCMvZjPVy1wzwGqK5Jo
	 h0eSGGzgzX30CwaralS8z8fSKxb3p65afKHVeqDPKln9CxKJnI2KeMJJvWmKRtDWt4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gt0d2gBJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535FC606D81F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gt0d2gBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0A11F008A1;
	Sat,  7 Nov 2026 10:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047484;
	bh=h65DeLsJT0p8L24jCnzFyKnJq+U/vlSNPcNGZNiiaCI=;
	h=From:To:Cc:Subject:Date;
	b=Gt0d2gBJYZFTwsBy1bNdf/TtCIHhRZVIDZ9eHlKKqYlKqpF/ORQ9LtIYlrX+Pnaue
	 FeZmyoBK3hqc9m8oDG8Yn7Hb/1HyfcZxeXwdMVJb5e5vvKQblsIPVBu8A3wj+iHs1+
	 7wl/5xzZbC9tC097KIVbImwdyDQfplOQuMY0CLGoxiBFAYhXKYxXgR4BCviM+9zyMk
	 as8PwuLy9UXQyqJ5/yN2MQFxJDrWg7id1S33ctviu9ExnzC8Wkn9rC2jVEDAr5b3NX
	 xW5V9rTZZEx00kx3WZ1ixUxgIoA33bwe99ci0c9sBvsErG7p6cfQ3F4jnX+fHDLCPf
	 ++Os5IbfIm/ag==
From: Sasha Levin <sashal@kernel.org>
To: hnkz.64@gmail.com,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: mediatek: jpeg: Avoid context access after job finish" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:31:23 -0500
Message-ID: <20261107053123-failed-6.6-7c7f31405b76@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7c7f31405b76acd95a628c834ee8a2d6da439782
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053123-failed-6.6-7c7f31405b76@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




