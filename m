Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22F572682;
	Tue,  8 Sep 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882861; cv=none; b=MVn3geGpDV42bg79iQA0B9jghmfMRGsnotJgWUyqN8nAjXNFflBhXKGQJ2NQpp8SMsH+Drn7Wiea6jiy1EfnIPEqRSHZ47N00cfdF/6uT3EXZz3uHDzwmNMVN1ybJSGDWLMM6aDYXJXyw/A607BGClYb8M26wN0qE7mRMatAqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882861; c=relaxed/simple;
	bh=HF68j55DxHGSP2KQtDGRCV0ajrgKv4ytVDI+X4FKYxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9Ko6/5xOyYbiRqonERdTWyvMQbnGpMBNjNhdlssqYOI0sfyKKOiqg16KzedQL1Tcpa6JZux8ztfjZ7r/bJVUaqolsS8daiZR33Y05zY0vzy6yenB67ANUC39UhS/lElX9T6mQ63K2uQH7Qj8NAh3EQNUVnCBjKNgd8WHbfKkw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=SW+5zW2W; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=EKJl/ZNx; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="SW+5zW2W";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="EKJl/ZNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882852; bh=HF68j55DxHGSP2KQtDGRCV0ajrgKv4ytVDI+X4FKYxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SW+5zW2WddnHVQcK4mWZp2lquVkOVqIwJvfkTK7SFChffF3lNwtUG5i6pf8B3bLun
	 HmcnCssfZaGTscrV3Wt+O9KkFaZM1zHZ5MBcql4TpBAlxJv/Curi6x9nlSeen2+Xio
	 ICUvSRasyCOLmalZU4O6NRxrpKen8L4Fak1XbJw34prkmAeP1M2N5unutzXlgsDzYK
	 Bue/zR0eapq6kplCO5peMMWoGe9tw1vmVGCHfavlH1fn10z1GyFl4aaGbHCgjOKngW
	 9vrid7o+wG5BEWFH7U6eHrfJ2f7LbqZVNTrGaq5LQZSXr02wUmio1e0Z5dGoAlgJ2M
	 TpmO62brE20ug==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 2642D41463; Tue, 08 Sep 2026 16:54:12 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882851; bh=HF68j55DxHGSP2KQtDGRCV0ajrgKv4ytVDI+X4FKYxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKJl/ZNxHgXLq3O99HxVqQmVhZA8AAVMFIv44GwZ8hztbhhmV2eT3QN9BQyZ3D/73
	 NfUHxOA4FxeGxxpqoE4/XZ/+uR2PUbNbXlAF8ci2fVGoR6+rc88LaLPbhKQNQm08IH
	 BTOrkQigQ9frWMeUiXsJ6UY4yzi+iJoDo19zafXS8v+N3zB70udcgP0JIjdYGHWQm3
	 Fk1gylg8T6IZhJe5rD0BnxOK55zoYmjiSHcCbBTebyWtsZnsulQuSDTzxfQO5XtSYs
	 T0c05jyuGCgrINkOaqduZS6LPe+1GAHl/AvoOVGbOuT2PnvpFZmYp1rZX50WRZDC1+
	 PrxP+D1VBwwoA==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 310DA4145C;
	Tue, 08 Sep 2026 16:54:11 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/19] media: ene_ir: Ensure teardown is done in the correct order
Date: Tue,  8 Sep 2026 16:51:55 +0100
Message-ID: <60f411be3abae2a65ba4335b6847a12f19e73b3a.1788882189.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788882189.git.sean@mess.org>
References: <cover.1788882189.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timer can be re-armed from the irq, so ensure that the timers are
deleted after the irq and that we only free the rc device once we are
sure that the irq has been silenced.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/ene_ir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
index 6f7dccc965e7..f98d76277b62 100644
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
2.55.0

