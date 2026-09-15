Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8E47F777;
	Tue, 15 Sep 2026 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461192; cv=none; b=H4HHySFwFE3Vaz4WQJlaC8zLUlHqu9zi8peaIJyqbVcUtjl1GW0C3syKhsiiISJfbUmv0Ew4ThDOE2nZxjtaz06FjfxnDrErOeS8f6OubrBe9lKdMZ5KxhqgjvoxSeCk9xVZ/V82707OORtbv+EwwPYmGEyfKZozUu80rZyeCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461192; c=relaxed/simple;
	bh=HF68j55DxHGSP2KQtDGRCV0ajrgKv4ytVDI+X4FKYxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lno6OFWvytcMKy1cjA5NFwoK+Klsg01MijmQSDM+MpJYo63po51rkrpNaWs25HiaA04w/yO6gZqD0OrmEdckzZG/TMqP0DwrVu4pJm++i4y5lxA+aycFX+z2Pu6BdcwEvD3Q3VqI3OC23Gb8yflVCKEqDCz9IqjbpoYlTFsaP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=iVw9BJd6; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Q1xt7Cdb; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="iVw9BJd6";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Q1xt7Cdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461188; bh=HF68j55DxHGSP2KQtDGRCV0ajrgKv4ytVDI+X4FKYxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVw9BJd6GAa7XjD6McujOpfVHVtGPLf+Q59K2HVCyXqMBjeeKhOAIZru0hqz5yI6L
	 VMUP5MQ3AtbAq7OMpc48MPLeugS/MqX9YSTdXV5O98vJtHMyA5vlbhJzRFmbNxPp7N
	 vaVs7iRIZ/FTlt5F99jREnRNjvq3ARqyF+/R9vyxxWtWzBHeXq5xEGJXuEva//CMZZ
	 frX+NHUxcZa6WL/w82sMYdfjrzE7TjtCVqimH+Y2Cmt2TymTCRUwzDgTZ6TzLMzc42
	 kwVo8CVa8pLZSKTlBCV3//hLYejlmnCEZXgm8/tjfDzMmcNjX2SnYYnpOHllpP3kOO
	 sGMffaK/RNQJQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id A5DA740BA4; Tue, 15 Sep 2026 09:33:08 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461187; bh=HF68j55DxHGSP2KQtDGRCV0ajrgKv4ytVDI+X4FKYxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1xt7CdbAA+4DzI0imYZ7k912PpWncJ1HUkhw+eNoXlbXry+negZ9RxJW9mkprOvD
	 J3DqmwiUfLfz3a3bnZ4eTGrLZ3LR4iEWaVo5cntLjPes8Jrp+3OH/ATMCKYa5sHbu0
	 frUQdqde5Q5kxXnM9HYl9WXjR9ipcMaJ53pOoX/gAungygbupN1rBPkX3j8lyT/ZLI
	 SbRx1ArKdC65aDuA/QPaOu6UgTVnbWETRQHkfKoevToKaPay1V25SkB66WsGJEIYGQ
	 TlSCqeaSOHLh/q908bCjCcJ9bUnc2x4VuhkLj1bcZ63jF21YJrCLV6LDPtSpZtWUJ0
	 /9WtOS/ttHQrA==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id D9C7440155;
	Tue, 15 Sep 2026 09:33:06 +0100 (BST)
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
Subject: [PATCH v5 08/20] media: ene_ir: Ensure teardown is done in the correct order
Date: Tue, 15 Sep 2026 09:32:18 +0100
Message-ID: <f497207cbb9f657a3af5837c6abb496d642a0b19.1789460680.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789460680.git.sean@mess.org>
References: <cover.1789460680.git.sean@mess.org>
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

