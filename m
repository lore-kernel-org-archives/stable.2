Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315957;
	b=pXtXZ7XUssFjpnMDN+eA2D7Vti5WSxuDU+6Pji+oU4VlfikyvlAVECVgHvKssyhRrheq
	 ZnwlHXG0r5+itg03ojaApOODwvJCE3K56DtGpU0RMbqVazBwYOnHoAT2tRY3COFqPOT2y
	 jCNfLBPnIMlAgnkBTXQTSs2VFULgEyMgD+jOWPRDZDvSfOPkM3ntnqKBei8oj65qqLGbT
	 MPp1HBIJu/mQp6E+5akV/JoRpLZ988iRKQq98B7TddExM3X3GdvzZsoBl5JPHFwFhZGtW
	 kqvy4cQ8RXz1xtGykjPcbqkPCxhXO0LIJ6/M3wSTj1ECDfIFpt0hwqFQVg2admfVnEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315957;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NUX9Dxuq3AsTZihXlWnyp1hHbQ2C4Pf3AAumKufW6mo=;
	b=RjYE0+y1p21sLc1A6HOmI7l0myTWpqN6eRPPvyH+h/vGxC8wHlQ2xPiGYz4wALKeUjon
	 qNASzm7VfRxBwIBWuFcw3m96IxtE28invTxB/HB1im0S0izcpo1TJRiKFuQ3afxlRUubZ
	 1eNXK/WTm/UTrMS1PrWAs3/l/ORSeQhKbEjKoa8Lu9Ilp2HOu2mZtRp3cfSSBAncWS0r4
	 tgokaz2w6V9CiP2fmDtzpO1ulIVlVlW9hizw2QP9/hQONG37v3mcYAixtn0IgC1PQj7ir
	 TPY2FnTCEax8srDndCoPyW2k92DB8gh3SsWyWlujq8tg9kQaTyX0/oaKvDSIkYTBy0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnctXkhi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6208606A7D7
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnctXkhi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7411F0089F;
	Tue, 10 Nov 2026 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315956;
	bh=NUX9Dxuq3AsTZihXlWnyp1hHbQ2C4Pf3AAumKufW6mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SnctXkhi7DDVkDnjLvCuGs61KMHzOAoyWKnbxT2WZmfRV5kJelYmV8+Ded1+03RRC
	 lLYYXpbh0tP0EPKMdHckZK31up1WghihhkYN7/oES2Y16Y2n/rf0SKIC4oji/9Tp7o
	 zIq5fUiclAEOtiRs71VeE9C/KNFKGozqSEz+H5bO9QlOlB9xK8QlBlfKVsi68oJdpd
	 Htr/OyWfkwVn9RDEFnDDbC72BME3efp1afYaQFzPLGQgrRW6RbdBAF56otgRKnUMjm
	 23TX4jhJrMDhC3iqxzTLb6YG/OUYaN8UjTQ1TLqKKq5/y1/KFGWQStvSt94Bso8Wtd
	 8LQWxdodKWKBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: ene_ir: Ensure teardown is done in the correct order
Date: Tue, 10 Nov 2026 08:05:54 -0500
Message-ID: <20261110130524.1646863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052956-failed-6.6-ae6cfbad7ca3@kernel.org>
References: <20261107052956-failed-6.6-ae6cfbad7ca3@kernel.org>
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
[ sashal: adapted timer_delete_sync() removal to the existing del_timer_sync() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/ene_ir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
index 9140e4f28c995..f5fd6bd4d7363 100644
--- a/drivers/media/rc/ene_ir.c
+++ b/drivers/media/rc/ene_ir.c
@@ -1106,15 +1106,15 @@ static void ene_remove(struct pnp_dev *pnp_dev)
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

