Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A5483BD6;
	Tue, 15 Sep 2026 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461202; cv=none; b=LYDBDpCJ+x0hQNM0wGEKo4En+bjURpAHGt3RhUhpRdcdTCAQRQ2vjxqU1aAJZCXvvPJSmSsDUd8+eY8hLyp2d0vdq5qcu9MRcvyUuPO8WqRfjH7bCKpwaeuIltMx9BoD4V4cbirEigh0G+KP8Vtuw5Q81TrUH2FQ9uT34TGYNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461202; c=relaxed/simple;
	bh=WLZF4ujfdR+E7R4JQmpFaDaz0BbpV+afU5uwMPHuUuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlAx6sYVSZg/mrhsaipsgRyqllUBGiXMpljeulIZdrKfCskZslCKEr4DHwRWiVpkFI7pjUVx0yNqNLYoYnKkbgn61Yym6dDG2UjuJT3aLLtdN6CBji0iXRBFIeur7Lk7xJUMVvrk1+l3VsHROS4EcdgeSoZqWTS0zJC15bvmqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=rkCfo9cR; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=rkCfo9cR; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="rkCfo9cR";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="rkCfo9cR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461199; bh=WLZF4ujfdR+E7R4JQmpFaDaz0BbpV+afU5uwMPHuUuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkCfo9cRTkREGAv4YL4or9G+fuK2dP/9Rtnc3Ajt1AtzJC6WWX0DEn3HaAd7q10GS
	 4KlOLH2GGPdCvY+4TI6nagyWZSesZhFawsfkdxLtg9ygZrFNCsMZe6WIWUoy1h8PvQ
	 tiKziYuHfYwYqS5DllHLubWuNPrj3kMYbKctgO+3hwBe+MemQfbywEMMS6/yY8KzUN
	 XlsdzsJlyCU1xlcrCfdo3L5slOHy4H0LSU24tbprqOzP2HyVY9lOrvqsDdyih3N92K
	 UKJXtIMmP10Us8gGNAP+OtNnmjIpEzDp8BXWLmIzcm6LM1yIif8V22jvlqBzTQ7NW0
	 JMrxCbRr8rr2Q==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id CA74940B72; Tue, 15 Sep 2026 09:33:19 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461199; bh=WLZF4ujfdR+E7R4JQmpFaDaz0BbpV+afU5uwMPHuUuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkCfo9cRTkREGAv4YL4or9G+fuK2dP/9Rtnc3Ajt1AtzJC6WWX0DEn3HaAd7q10GS
	 4KlOLH2GGPdCvY+4TI6nagyWZSesZhFawsfkdxLtg9ygZrFNCsMZe6WIWUoy1h8PvQ
	 tiKziYuHfYwYqS5DllHLubWuNPrj3kMYbKctgO+3hwBe+MemQfbywEMMS6/yY8KzUN
	 XlsdzsJlyCU1xlcrCfdo3L5slOHy4H0LSU24tbprqOzP2HyVY9lOrvqsDdyih3N92K
	 UKJXtIMmP10Us8gGNAP+OtNnmjIpEzDp8BXWLmIzcm6LM1yIif8V22jvlqBzTQ7NW0
	 JMrxCbRr8rr2Q==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 33AC640BA4;
	Tue, 15 Sep 2026 09:33:19 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/20] media: serial_ir: Fix race condition where timer can be re-armed
Date: Tue, 15 Sep 2026 09:32:26 +0100
Message-ID: <ae2a989858a97e969d901db8be15017e0c8609a1.1789460680.git.sean@mess.org>
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

Ensure the timer cannot be re-armed.

Fixes: 2940c7e49775 ("[media] serial_ir: generate timeout")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/serial_ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index 992fff82b524..f6702b3df9a0 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -798,7 +798,7 @@ static int __init serial_ir_init_module(void)
 
 static void __exit serial_ir_exit_module(void)
 {
-	timer_delete_sync(&serial_ir.timeout_timer);
+	timer_shutdown_sync(&serial_ir.timeout_timer);
 	serial_ir_exit();
 }
 
-- 
2.55.0

