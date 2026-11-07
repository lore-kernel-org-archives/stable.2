Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047398;
	b=HU6KXMEXwxOUXYb2piQ7CZT8UsFeNWrEtPBrATnGKE3+WL/4tEOonhhWbqhUKJ9s2JYK
	 FQrIixi/75Fy26/kkMyTh/w7DA+6FoCO7+W/g50PLmWN/uiu711Z6L9cUfCIJ06KG1xDY
	 Akvmaz+6L9b/FdJGm3xaDsuQWlzEuquBwCuh/57WE4myxDvDjX2lZo1nVI1dLfFE7pdkO
	 072NgUrEKVXHWQhi8AEag8PSS/TTAti+/XV2M8GJaLEj362PA7eWjFEiJLS140ZDXtJUx
	 tnpah3s6CsMFrPOHVeFzLttemdpI1uvQh99nt3s1XDTLYyY4jZ3HXak0pj5sWKNJTrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047398;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EKBEzxLuUT58d0NKpUYCHMP6/3hUsqHr7DwViIEYIbo=;
	b=Vr1E9peOXNIlmxY+Rua2loYaCjPTCSwrbPPo1SPyoNjH8h0xFniAOs9iV0lKP5lnYLtj
	 JmTeNVRrEFffm+7JYhpgKVvX8GQedEf9dV3xiidw54rsq/A3a7rTOcmx4puehGp7dwk4b
	 1o1KYGChMfXjnFZl/biG5AZpYZQ/Zq89G3KOGlgQG3NN5I86xRZUD774v7bJA+RU2+C/0
	 GFa8U78dBKbmcCcYu2+ZLUmWrVgG48MQZTi8vect4GshMTPFzMweyWeg/N5Sb1OzioTBE
	 6W7UUZ9RC1GR8n84Dg/1Qui0qjU0s3fSWuTfTXhMPcp5Xel0+R5m7cnaQxtJuPJUwKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7nFRQHz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41001606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7nFRQHz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F9F1F0089F;
	Sat,  7 Nov 2026 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047398;
	bh=EKBEzxLuUT58d0NKpUYCHMP6/3hUsqHr7DwViIEYIbo=;
	h=From:To:Cc:Subject:Date;
	b=Q7nFRQHzaCpkaE/eIRKln5Qv0Fda0x3ow7Kx/XP70eTCvE60yu9M6L3KuKBHr8VEE
	 3ZBDwGuexXPyShglhSR3P+/eDdzPgobEQVxtSsGfifuMR8NG1sV6WeZVvB3iKEn0Sg
	 Hs8488VEyeD8t6G77rSZzlX/hK9lmpVQlyyTgPz+g4z/5ne2I2SBuREuRNh6D5GKQI
	 uC3TwBJsKG8xRs6Yt6bOEpMNnRJe1VQ7G81Qvqq6gj4Dy6DBRQTmlWlsH5bcY7To6w
	 spdZpgRf+eKnY7d0JqwR3IRL6g+Qxt+ClR8MTc+DLUghMd7Z0bALiDc1nBwXJSSX6V
	 jpui+XeUr+8/w==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: ene_ir: Ensure teardown is done in the correct order" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:56 -0500
Message-ID: <20261107052956-failed-6.6-ae6cfbad7ca3@kernel.org>
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
git cherry-pick -x ae6cfbad7ca346b78f4cdac38438bbfaed8c18a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052956-failed-6.6-ae6cfbad7ca3@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ae6cfbad7ca346b78f4cdac38438bbfaed8c18a0 Mon Sep 17 00:00:00 2001
From: Sean Young <sean@mess.org>
Date: Tue, 1 Sep 2026 11:29:02 +0100
Subject: [PATCH] media: ene_ir: Ensure teardown is done in the correct order

The timer can be re-armed from the irq, so ensure that the timers are
deleted after the irq and that we only free the rc device once we are
sure that the irq has been silenced.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/rc/ene_ir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
index 6f7dccc965e7f..f98d76277b62a 100644
--- a/drivers/media/rc/ene_ir.c
+++ b/drivers/media/rc/ene_ir.c
@@ -1103,15 +1103,15 @@ static void ene_remove(struct pnp_dev *pnp_dev)
 	unsigned long flags;
 
 	rc_unregister_device(dev->rdev);
-	timer_delete_sync(&dev->tx_sim_timer);
 	spin_lock_irqsave(&dev->hw_lock, flags);
 	ene_rx_disable(dev);
 	ene_rx_restore_hw_buffer(dev);
 	spin_unlock_irqrestore(&dev->hw_lock, flags);
 
-	rc_free_device(dev->rdev);
 	free_irq(dev->irq, dev);
+	timer_delete_sync(&dev->tx_sim_timer);
 	release_region(dev->hw_io, ENE_IO_SIZE);
+	rc_free_device(dev->rdev);
 	kfree(dev);
 }
 
-- 
2.53.0




