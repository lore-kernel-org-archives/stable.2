Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804962222A9;
	Tue,  8 Sep 2026 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882857; cv=none; b=Bd8siz8k6vXA0TLMihEc2hRr6dc/vi+2kjYoymioYRC+nsM3fuSsnjNS0mJQrwfol0eHtRmPnLWjnBBwt7uSa8NEXRABIRL9rx89/MtLaOW8nO7KwF9gQikyyhZCzE+AH3aqVKLJpKqxDv3eEfjwpnSwd55R5Jvy4ucJNReUR+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882857; c=relaxed/simple;
	bh=Pr6VJYZ6fRxZ+pIKzkWZXcVFE6rXEN7AqyZXWurzQxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NijBLMWehFLOYdsQ6CmNNH8jnBF/02th6YQVWtB+t8WHY6TR3Td6Fr20h2rXsTkSQvmuw7NgENzpJUnAsR3RQIaA4IQDC7cq6m9jmOCOKru6w0tuseMs7RhUy+CQkDaOE3DwyzBGiN6ibwWtjndVykDFXkfJe9dpLeYPvuxnn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=RGfpoz/s; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=ZjNmo8Si; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="RGfpoz/s";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ZjNmo8Si"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882848; bh=Pr6VJYZ6fRxZ+pIKzkWZXcVFE6rXEN7AqyZXWurzQxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGfpoz/sui5iGEQp3cH4JwfcxNybp+4Fz9NGRSGZNAgKhrkNuOnBGQ7KaUpzLL1GP
	 t2r5J6zkuvWo4Lzb6RARibK1R+S/PgHB5Lic9yCN3GZG9x8dOPgt6HfiyPbH2NlU+a
	 kE5ieX7UExuaYhy61GX1bxAFmRy7wlIareZ7z9cyzoovf0JspmWbHw0X7CWCIMxeje
	 f0Qpm8XbzkgIy9MjUzTveQ46ZXYnq5OVVHfFhyywfHsbcSEKfLSlapBt0WVubGD5Sj
	 iLsZkfinn35dAV16wtJyQ0ILsr55L3PeRxqd5qwsEIT6xZ5pil7bU66YWeX6W/nURp
	 Dy+GyZ2L8j50w==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 38A6E4144B; Tue, 08 Sep 2026 16:54:08 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882847; bh=Pr6VJYZ6fRxZ+pIKzkWZXcVFE6rXEN7AqyZXWurzQxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjNmo8Si9Mr/yO4py96HLb+1FHL2jY4e6pwuX+NaDzdFcrSL6bZIa1ZKDtEDA1RCS
	 /7NzOWDPNTDIGEP1FPCv7Z6YmG1x2QUeQaalhhs9PVHELgQPzJf7XN1WrUZVIKjO8f
	 3kM8J32LJwabveFg6Jc3i7H+Yb6cuCcayKSqM8QdUZl5MiD2Nzo8mF+24XmqXHdtRg
	 Tv/MoA9k+cYyZMznF0Dc07ergqm3DGvcAE0cfcnn7b+QpDOAOoFcueCFPqsavpUrqq
	 7cc2iMHsL3fb5IVJIGxwPzrpVGl7kHgwJ4nCoC5FsPFH9TBNCwyrdHR1ZvdrwPuwQx
	 syXFixW8WbcYA==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 3DC414144D;
	Tue, 08 Sep 2026 16:54:07 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/19] media: rc: Ensure that rc_unregister_device() does not free input device
Date: Tue,  8 Sep 2026 16:51:50 +0100
Message-ID: <05338e96f5b6364029840dfb133126d6a6c2172d.1788882189.git.sean@mess.org>
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
index 1f99540456f1..88d8f7d4aab3 100644
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

