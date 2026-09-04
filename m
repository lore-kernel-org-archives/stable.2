Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5902F8BC3;
	Fri,  4 Sep 2026 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527293; cv=none; b=qOfRjWQWA2hyta4p83LEA9cE1NTEqG/DWMg97paqklsBXdIYK/blzb/tNXPtyDQvnhretJWkcPsr6GQx/0NMeYlwytPkB03dnGIIHOX+SNV0vIDnXISKeQ9nc0FkGWbCm17+QlbTDpGQzEq5hKPTmpL/LiqWgoya0kZw7eedYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527293; c=relaxed/simple;
	bh=HF68j55DxHGSP2KQtDGRCV0ajrgKv4ytVDI+X4FKYxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQQv0kjlbrHQMyCk9+lqIQ2YhFJQudAGTHvXQEz9TEG7DGqQ8Y7t3ByNkq90GO8/7zIJRRrJziDKVTHd77+b1yJglP+nFSo5UTL2bmFPThycDUlxjERXzXxY5nNpils3TCtWzIB0jSqcBdDnlTjoSlh1eN/iQGd3XMuGUmPFCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=qAeGOO4f; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=B0FSyDdx; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="qAeGOO4f";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="B0FSyDdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527283; bh=HF68j55DxHGSP2KQtDGRCV0ajrgKv4ytVDI+X4FKYxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAeGOO4fIVfxiDXvqTeNkd0qPKxFwG8r0+ZWgaR//UD1O0Sn6ylBZUd8suxAfUtq3
	 gJdCZJIhHKTWUDUrqarnrZI5kPV7Xll13b9b//2WGYQlbmjmE2lcjKr4w/AQ52BSkh
	 +gyWAQliWFtoUiYfQv6z4tifbqWdTkYz+2cIik9kXK+1CiA9ag75mdmNusRabb2NVk
	 t3RMoMOz7KRogZ5jZVuaMp0yyNMYRCdc/1lDhdaWXwiNEdzrMY80IMlvJsxbx6p1k2
	 YYCfEO+dmW5u7DcvGK6xNTncBbWhi0I9Z2hu8Fks5509nvxiyQ31iDnDu0NCAiEhjn
	 D8lbMTvAhEWlA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id BBBF041467; Fri, 04 Sep 2026 14:08:03 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527280; bh=HF68j55DxHGSP2KQtDGRCV0ajrgKv4ytVDI+X4FKYxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0FSyDdxFIkwkj10dV+uvMoS7Sg3uV5k4UxbNOTmHaGJ+X478yBJAVtEHlhi5Xig9
	 dn3j+zo2Wg9m8z3obtO2IKbrcKB+Zwi/uyeMU50IjuhIieb6IURSfKX8BfMj+NaL6u
	 AGkMeC+6xB+IHeKUp+yo5tL8wxgfxtVwtfCrlKaURTga5bmN2ZYjBQv7EigQIwN0QT
	 GI0Dcrp4GAf6oxG6QctXnWRyatCvxsRzvSW/k0Xt5CXCiJeOMeuR8IAZ5HGvyGamHy
	 KEFApEJ8yfBDNLGhuXlvSfX+ckUvyh5tpZMIUYV+T0S4T/0vc3ukQEEIWrLEfOWcsS
	 VYsuMRuAA53DA==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 810F141456;
	Fri, 04 Sep 2026 14:08:00 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/17] media: ene_ir: Ensure teardown is done in the correct order
Date: Fri,  4 Sep 2026 14:07:35 +0100
Message-ID: <ffef5207d1a83e79c6500ce9bba1b027b54f59c3.1788526920.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788526920.git.sean@mess.org>
References: <cover.1788526920.git.sean@mess.org>
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

