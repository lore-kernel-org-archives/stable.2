Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D23B5847;
	Tue, 15 Sep 2026 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461185; cv=none; b=lyN3rwxP1A5I1z92IY8BBgspxf/GlwN5OSqWQy32MvCsFA6o9+gu0q7cMl6WmZTBjoYQCyzhfWr5i+SVeZXA8656L/3C/Z27pDTNZEAKn+HRRg/ZZar/t7OJTguuYNouTt79LJEsLpxOgEchUtCU/vLBeN5xGAzJQ/nZ3L0vFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461185; c=relaxed/simple;
	bh=IV0F/ZsBMLGaivPyKxE7H+GRnEb/wEfIq68wwpyW9iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUB2j0bue7XR8oW8os8dyPFpLeungzaM/mF5h1izn2+kT5aeIv/YgTT0DvmdE/q2XBWibADkoiHULgd9tTAwYUjKCB+OjxCvrWmA4IDPgmw+t63Y6UCUQdnGMm09mF8xXCbbVvrUT0kmrqmSIYKwedgmaQHg3NWN35PgoyF4nMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=exaVWxMU; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=LndwBNVH; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="exaVWxMU";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="LndwBNVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461177; bh=IV0F/ZsBMLGaivPyKxE7H+GRnEb/wEfIq68wwpyW9iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exaVWxMUyzNhekp+iovdQCfR7P3ZKoJ5j5DW6KW3yTV6qMa5coKg1KWcq+vP+dt1N
	 3KVlA21nFqRbeD8b8SC0bDaYVG63x3kxancLYdkJeFzjcp847NiIudL/QkoR0vs2cR
	 PUIlkcKRCFfGYVOZTvqwFnqaaKWEIbuSHhg79t/AuY4GKBStfjedNwCTQAAy6BtYdp
	 a26lG5YR9mE4OpsvdAlE6ybqJjYg278tgQyV/0aHsWPBeqaJuHVohAjwbD3UUOooJv
	 7qjK0q3QzKspt6P75Dbczmo9AWzTa9wlpECUy52svLtx8o9duZsMRnTIb6ePG7qeKU
	 WPb3sareczzVw==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 2525E40BA7; Tue, 15 Sep 2026 09:32:57 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461176; bh=IV0F/ZsBMLGaivPyKxE7H+GRnEb/wEfIq68wwpyW9iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LndwBNVHWyXjEf/c98o1Pbs7LKpYbEDkSQbsxINLhHPnWtL46x0h6W19eH3j2GhPF
	 j1cINVK74Cqk8H5URSaDAxZzprhWK9ardVHUJgm9cZh+3T2hCAgj/Y9guZIYV5LuMt
	 8otVs65MZbMvWL+HPuJIBl0eesZyAReinEtqML1mkGVybF9//hFZPpDgg73crpVpv3
	 J/ScGJpp54JhIttapFhEhAjaOOoyp4BxOKoIbx+sSOYFiIYlI599mgvCCHlx7IIVo4
	 urQQZx2T8negccrVsyDg+/tSp6asaot7P9xp1AySnUuZaZBj12sh8bbklxodB9b6/Q
	 xsODUFX4NQH8A==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id B4B0E40155;
	Tue, 15 Sep 2026 09:32:56 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/20] media: rc: Ensure that rc_unregister_device() does not free input device
Date: Tue, 15 Sep 2026 09:32:12 +0100
Message-ID: <21f237a3987b33ff532a23b14b6aa6ac60d0d0f3.1789460680.git.sean@mess.org>
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

During or after rc_unregister_device(), IR may still be reported which
results in a input event being reported. This could result in a null
pointer deref in rc_keydown() or a use-after-free of the input device if
the pointer was read before it is set to NULL.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 930d45517229..d4baaae3a834 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1753,7 +1753,7 @@ void rc_free_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
-	input_free_device(dev->input_dev);
+	input_put_device(dev->input_dev);
 
 	put_device(&dev->dev);
 
@@ -1865,6 +1865,8 @@ static int rc_setup_rx_device(struct rc_dev *dev)
 	if (rc)
 		return rc;
 
+	input_get_device(dev->input_dev);
+
 	/*
 	 * Default delay of 250ms is too short for some protocols, especially
 	 * since the timeout is currently set to 250ms. Increase it to 500ms,
@@ -1891,10 +1893,8 @@ static void rc_free_rx_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
-	if (dev->input_dev) {
+	if (dev->input_dev)
 		input_unregister_device(dev->input_dev);
-		dev->input_dev = NULL;
-	}
 
 	ir_free_table(&dev->rc_map);
 }
-- 
2.55.0

