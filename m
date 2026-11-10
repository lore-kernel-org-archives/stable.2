Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315682;
	b=CKoyAsck7NPndoSJezSZ6dAGh4d67uRDKKX0sinakdZSHo/qLX8bDkWZ1un7kDNtL9Xc
	 bibLMCluyE5kOGJs7Yiq4Xl2ILrcidRfllGNSlwr2mqHLDRYvfWISKxhfLYB2A+6yiHzc
	 chaUY1aK5TjuM2ICFhFw2Dji7/epLEh64MezjcBAvjR4m1rOzJLs3tACYaZeQdJsywPcQ
	 0OrU5+eMkf760AFyiL/xyIeFXVbH7PYEvFwUEo21XqG4qpBZ8AX0sgg5A7IpetpiCxpxD
	 Awvgntz4cQsJUch+nnlb0ks4SY6L+6e9L736k589B+AGdqDTVV53jfx+It72MwNILYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315682;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qC7XEzhxcf1Bed5jftZCW48CSjeaMJ9VxyFJ+Vl30Z0=;
	b=JdabDAaIdwoqlVDDR0U0xoFIlRdOfPAHQeaEyLuiVAg/RrHuaHR09kt60btcwCq5JvOm
	 /oBiIlRTBFwSNXn2dmvJsRcM8Qtnc0Qo6lHPciVWWCNss3pOuPyO9jvAzU9UbbEIZG4Yo
	 twt9yTAJK6fGTYAuYMuQ2Hp44qi469DKWuBdMRV8L4yej/7iFwDkAjn8gEJxvvub4aXzW
	 Hq0srixOODU+GQ9n2OCEAoTdddMs02d5JnF9Ug/nq9uEVycrKfPhyMS06JBBZkzYuu/n3
	 isp2uhfmIfeab/JtOilWeD5J7ZdsP6p/REi8rmBHaIPDMyS5edOnVWu5plcIliw1+1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXeyGYdL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CC606A7C0
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXeyGYdL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB971F008A3;
	Tue, 10 Nov 2026 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315682;
	bh=qC7XEzhxcf1Bed5jftZCW48CSjeaMJ9VxyFJ+Vl30Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AXeyGYdL3zMZ7TJ4yiir1dW3ORUE38H7cV1BXC4+eidmosVN8U6YELcfUwGoLFP7D
	 68IReBxTJvXHQR+U9pLBxO8QcS03Dna9miYuXRRfCb++U3xViBxHRv4SXjKYZdlOfv
	 ESL0I6xDnAPQbru8bL0o7bJ1Ol7RSS0GzmfhvqBr619B0L5NyhL2iOcX4AaOmgCWoy
	 ZGvrHxcT2CCI9rCWjdmA0rRI/aTVuKm/30rBBGkrgZc3id0+4KUVzpR8houbWJwJJD
	 oVj8kEhskOnwquEXlaqnl0gP6YI6OuJK1IYMP1+kmBGi+j/NjYMv6/R0fuG23aQaPJ
	 ht+uANAVoGUdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: ene_ir: Ensure teardown is done in the correct order
Date: Tue, 10 Nov 2026 08:01:20 -0500
Message-ID: <20261110130057.1564818-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051729-failed-6.12-ae6cfbad7ca3@kernel.org>
References: <20261107051729-failed-6.12-ae6cfbad7ca3@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Young <sean@mess.org>

[ Upstream commit ae6cfbad7ca346b78f4cdac38438bbfaed8c18a0 ]

The timer can be re-armed from the irq, so ensure that the timers are
deleted after the irq and that we only free the rc device once we are
sure that the irq has been silenced.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: Adjusted the removal hunk to match del_timer_sync() instead of timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/ene_ir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
index 3fd51a41c3b2b..70e28bd4bdb93 100644
--- a/drivers/media/rc/ene_ir.c
+++ b/drivers/media/rc/ene_ir.c
@@ -1103,15 +1103,15 @@ static void ene_remove(struct pnp_dev *pnp_dev)
 	unsigned long flags;
 
 	rc_unregister_device(dev->rdev);
-	del_timer_sync(&dev->tx_sim_timer);
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

