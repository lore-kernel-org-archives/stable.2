Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046730;
	b=bpE096C4nXP0CLZ0J5dCPvXPOs3uTZ6kiRueqFsQKVhJp3MfaPANNNj7wXQLXAz6xU5y
	 RVlkdY4angowmSbhicNflbtdeAH3WFlV6hsgKVcR90J5PYj1MjI93sRT2xx98ArAxqUz3
	 ZZMOxxNgpP3U5/MVyhgeme2ycobqaM/1+KFahvnRxprhI6FfA1BteFrWDwqZvdCEYuIEn
	 5pTg4Lky3HuFldjez2ZZLa14W8v82v9L88Kd8rH/2DB3aljKiueiD5gFiUBcMTLIteY8l
	 o40UqGAYYjaHjo95GGp+ocL3Oyuskaq7gHBhC9QtPF8PlFZSq2u5viDcYhwuAd5M6Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qySmZUhtunQC5v6O12dQ7jQhgmiGndduRDMc+fD6hes=;
	b=AVlidRkBv/zNlir1XCcIC+9Etlw49bH17n2Iwa/LBLVDON7puEQCZm75rp8Hqu3itSnW
	 ZjCXl805W/qBD86Ltsx/wQCGlYu0EMc+NA8xsZ1CkrTfqf521FJdeL/mS0q8bt/F34/nE
	 U2r5qacsQ/YRhBhbAAr/WdunpPBt1Xm/76JyNOnqwo55uqjD0Z/VNBrsQBs7gJL6hf64S
	 hLqD3ovsi8EoBxVPO5GgNbM5eQjdNqjJeM0UOiy6zhgk057zX5/Pr/ONkG24d1xvG5E92
	 rJ+q8PFRMOpuQrJtqHFqwnRQnvokQDN6UZn3Cbgka3cGGNISOFgQb5pHprUp2GG5c4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kl9wDP6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7A606D816
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kl9wDP6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8C11F008A3;
	Sat,  7 Nov 2026 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046730;
	bh=qySmZUhtunQC5v6O12dQ7jQhgmiGndduRDMc+fD6hes=;
	h=From:To:Cc:Subject:Date;
	b=Kl9wDP6aO7BsS2Nm4/fUd8MjzJgtnxOEuNCe9TnPwFOLUY3oe4+rtCuZQT8r9ijGT
	 G5eHHGXbRsJAtVgXppl7t38++bVBC4S4l7MMbV07oSscGlZm6kSt/3LJimx3By0X0x
	 vpP36g6yHBJp7ciLDFE3fTH92tcK51FtO8ivG1AFUa7El1c016N+pMg5GMDGBwiGol
	 oDGFr6HVZNCffb6y/yh94738wzaaWW8eBv5QBsFFp/7tWh6OJxE1fF1B+hqR74B5aJ
	 0NxHuoKuqZbYO1SXhl/dPzGmrWS3roWGWy0G/TAzR0oI/KdcxpuIerkJgKpS/3XVUU
	 CBFXSXeR4oRXw==
From: Sasha Levin <sashal@kernel.org>
To: lilinmao@kylinos.cn,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: chips-media: wave5: Handle polling IRQ thread failure" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:48 -0500
Message-ID: <20261107051848-failed-6.12-1d563e3d718a@kernel.org>
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
git cherry-pick -x 1d563e3d718a1c7c16355843374fbdd4c798ac66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051848-failed-6.12-1d563e3d718a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1d563e3d718a1c7c16355843374fbdd4c798ac66 Mon Sep 17 00:00:00 2001
From: Linmao Li <lilinmao@kylinos.cn>
Date: Fri, 17 Jul 2026 15:13:15 +0800
Subject: [PATCH] media: chips-media: wave5: Handle polling IRQ thread failure

When falling back to polling mode, wave5_vpu_probe() does not check the
return value of kthread_run().  On failure, dev->irq_thread holds an
error pointer instead of a valid task pointer.

Both the probe error path and the remove path only check
dev->irq_thread against NULL before calling kthread_stop() on it, so an
error pointer passes the check and kthread_stop() crashes on it.

Check the kthread_run() result, clear dev->irq_thread and unwind the
probe on failure.

Fixes: e66ff2b08e4e ("media: chips-media: wave5: Fix Null reference while testing fluster")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 76d57c6b636a2..37df270b5f991 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -340,6 +340,13 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling\n");
 		sema_init(&dev->irq_sem, 1);
 		dev->irq_thread = kthread_run(irq_thread, dev, "irq thread");
+		if (IS_ERR(dev->irq_thread)) {
+			ret = PTR_ERR(dev->irq_thread);
+			dev_err(&pdev->dev, "failed to create irq thread\n");
+			dev->irq_thread = NULL;
+			goto err_vdi_release;
+		}
+
 		hrtimer_setup(&dev->hrtimer, &wave5_vpu_timer_callback, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_PINNED);
 		dev->worker = kthread_run_worker(0, "vpu_irq_thread");
-- 
2.53.0




