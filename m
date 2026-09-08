Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839456E063;
	Tue,  8 Sep 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882865; cv=none; b=Udq7kSOhls7Kg+RF1BrFY5t05DWo1OZIJ2qjgyuoMNyA5GpuSXVcbXpDEG7+IAfpBb77moI43/a5mP3SMdIkCQ1v2SotUAzPfThf5uUykUe3EjNEwnowXmGy9NgMVNSCz41/T9gti5hjwI496GfzraaAnnfmYLdeLe8RX4SVFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882865; c=relaxed/simple;
	bh=fXsuQ8eCwLBhwDjoV/twcSPRAx1PwMYVvy0BOLAfoqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gh7O6ijh3Z3CCcaKPZ/Tl/jgmw0i1tFZOxltWC32SOihtguBCMJ9UIk3Uv73FxlRMpZmc6ITo3OWK81eEHG2SpB+GG7Y2SEI/33bXtaqwRSzNYizClKm4nKbIelq1rqwnzyFnr4hdHl3hGN7bs10LPeR2DBeLebczvNBC8YZBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=MEVbQQAM; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=MEVbQQAM; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="MEVbQQAM";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="MEVbQQAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882857; bh=fXsuQ8eCwLBhwDjoV/twcSPRAx1PwMYVvy0BOLAfoqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEVbQQAMiwtvuYXaPTtEjRQKrBzJ3DXlelPnsdt+B8/hSFHKKrKnvTc10+4TewFab
	 1JzVO9ER+VmUL4eHi6TBZzx1ppCI3oTd42nAS7vFZqQ2bdOeYUHpj5oUjqZ8Q56KG7
	 LZiswL1TQqP8cSMn+rnW1DftB0DW7HnUSdoRbXYsPFcu+ChaBmMyPF7/07t986ybQi
	 CM9u5RcYpL3tEdaNrr5Z8gZYSowJoip0GNz1wTLzQ0LHSRC+4yP+yKMhducubNv9b7
	 qeCNzy31rcfwW4pv0BoUiQ6xyC7YAIE6A2oeS4/dvZp7kz1D0fRbBdSpW42hYGjudr
	 G8CleJUwuweEg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id D4F0341474; Tue, 08 Sep 2026 16:54:17 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882857; bh=fXsuQ8eCwLBhwDjoV/twcSPRAx1PwMYVvy0BOLAfoqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEVbQQAMiwtvuYXaPTtEjRQKrBzJ3DXlelPnsdt+B8/hSFHKKrKnvTc10+4TewFab
	 1JzVO9ER+VmUL4eHi6TBZzx1ppCI3oTd42nAS7vFZqQ2bdOeYUHpj5oUjqZ8Q56KG7
	 LZiswL1TQqP8cSMn+rnW1DftB0DW7HnUSdoRbXYsPFcu+ChaBmMyPF7/07t986ybQi
	 CM9u5RcYpL3tEdaNrr5Z8gZYSowJoip0GNz1wTLzQ0LHSRC+4yP+yKMhducubNv9b7
	 qeCNzy31rcfwW4pv0BoUiQ6xyC7YAIE6A2oeS4/dvZp7kz1D0fRbBdSpW42hYGjudr
	 G8CleJUwuweEg==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 1002B41446;
	Tue, 08 Sep 2026 16:54:17 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/19] media: rc: After rc_unregister_device() timers can be re-armed
Date: Tue,  8 Sep 2026 16:52:04 +0100
Message-ID: <26947cb1fc85361c748ffc6e8688f0ee6f48c472.1788882189.git.sean@mess.org>
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

If rc_keydown() is called after rc_register_device(), then the timers
can be re-armed.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 795ac0fe4858..088d935d8347 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -2065,8 +2065,8 @@ void rc_unregister_device(struct rc_dev *dev)
 	if (dev->driver_type == RC_DRIVER_IR_RAW)
 		ir_raw_event_unregister(dev);
 
-	timer_delete_sync(&dev->timer_keyup);
-	timer_delete_sync(&dev->timer_repeat);
+	timer_shutdown_sync(&dev->timer_keyup);
+	timer_shutdown_sync(&dev->timer_repeat);
 
 	rc_free_rx_device(dev);
 
-- 
2.55.0

