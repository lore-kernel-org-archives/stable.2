Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046651;
	b=RLb4fhm89qz0u4Ez9iJV3AS1v5Hh10uq1vZjaajqUa2hCeIVDUR9EsG6yYLGRt0fKA0g
	 c/ZjCbT7gpORbZqo2MtdG3HNf+0F3lM3+0VOkCCJeI2ZCNWWZKmUYq9pAOEHmj/BijJ9z
	 Qx0BJ5NgV5QsEgsXuHdr1UzT1+1fqROqThl+F+QdmW6bsgn8YH5hgTKlhDBIIU+Ynn6I1
	 FHCBzfYSf7MHIoiOWMZwvwH/WlPFCpcLIWw2fQE2yBrnxDzuToNGlsbS2luxivbqx6j/3
	 QH2Uv1yTw8+eHpH1tOXRJEJASWjZpaGVBU+7VBoAxE0HBJ6LXVJ2YL5ZMnVJMgJv8Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046651;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m2i8tGAkpghAwZYvvOLDF4QCjbYUrqCmcfVCI69gzHw=;
	b=xGEwqPHXN9wiw0Fd7AaTc8wruFEbmXvTe4oXru/IYZ7cigll+3yM0uRUGEuvWpXKk+Q4
	 HSavvnm5/uDYaGZaNKeYnhXW+zJohP4Hp5MevshxWaEag4ndxNQFG526AEDTFzJrP9K27
	 0U62dP+WffupGdbmn9YOPTGg5hgr/K79B63CSj0m30UXEZNIHICQvQYg+PrAUI86jNMNk
	 I7ca5LYr/mQ+IESFw39jR3bHxFF+mroZ1tL1QzLZC8Ego8w65fglMeoM/+kekLLR3iDtC
	 nTyl5ZVYYAZcYZoN3aiCn/J8dFXnIgAcl+AT35Lc1Vob9aMvKdhAlbnE+Rbenj7KUYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B//iIx0u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B0606D824
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B//iIx0u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E629E1F008A5;
	Sat,  7 Nov 2026 10:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046651;
	bh=m2i8tGAkpghAwZYvvOLDF4QCjbYUrqCmcfVCI69gzHw=;
	h=From:To:Cc:Subject:Date;
	b=B//iIx0uag8Y7iMlMZvOvYkhy0L+WnfnbvXaw4DwMI++5jZl9JGqkCi4jcohfBCWI
	 YPeY/+40z4oZBEgASR0GjrtDLUbPvsQc1mkbYYYdOlZjWCqTdTd1d8n7u7J0ZVNfyS
	 81/npIsNjYA2m5WhbKUMkD4oSeuntrFMNcSrrJqgIX6/GbhKmlhP1xbMCFwhKcTzA+
	 2EtEq/Vxfy9rUCcFWV6LDju7l7AlfIVFUVeJYnRXfLFWVH55m4QfIC0kkw7Ooq1lbK
	 fZRbpUMjFSMZ3olBcFm1jAdtblleASeUKpRzW2Mj/kxois74Pcoi6gkbkPvdPm7Ft5
	 vAtzsvnf8nNFw==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: ene_ir: Ensure teardown is done in the correct order" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:29 -0500
Message-ID: <20261107051729-failed-6.12-ae6cfbad7ca3@kernel.org>
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
git cherry-pick -x ae6cfbad7ca346b78f4cdac38438bbfaed8c18a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051729-failed-6.12-ae6cfbad7ca3@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




