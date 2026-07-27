Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36941737F;
	Mon, 27 Jul 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158367; cv=none; b=N7jKGYAINRInzkN7gYfjYvxXkEkfV8Ljhbav/LyeqdWE0x53lB0V9HVgUaZFuF31QZL3NGnB6HW4mkFF4yurxDJixygT07FZliZSm9Xadw7yQVAH61QLbRwiGfd+4jfxB0PMHkY2/cGv7IAtPphkjXDhYhyEu+1Mz99ZYzlnMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158367; c=relaxed/simple;
	bh=ksjwRj9O5mj6SOLkHxcA5mgVVcUr5GHEVrdgXR4l6R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/HXeRhIYVz681JtHjHkIbbK2sB9cKPp4trznIcs4E7ITrOTHgzMRl+LW+idbuu6LN61QIupqugGsukGG9x9V5CFf/yZvYbzY1QSe6CqmY60XQXmDrLYx9VSthp2x5mixmvmMfkshBN78VQ02AFy9pUoUHqKT4KrvFu7EjuIuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=R0l8qY6/; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=aDTPzTA7; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="R0l8qY6/";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="aDTPzTA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158359; bh=ksjwRj9O5mj6SOLkHxcA5mgVVcUr5GHEVrdgXR4l6R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0l8qY6/Gh/W3Qc8KnCYZtgkQEK/yj82IbfwR60Sqc4bEdtedvz0kNmaSlqlXUPSF
	 08DXPvSbOk9Lo7nvT5OXcFKHhUPEDhg6Rf/KWsEVk3RhFlF4M73xNVheY1XroSGlr2
	 YpqgONqoWr/Mp8Khe9IDOZSQLnxHZhrtltzYLUlaEy9530kry54OK2HtLSzODKhaGz
	 XL8GZMhz18urxr1U1ZkwvJkJa0Z6IHcok9+m/2175lyZvp//Mecke0ShFpcjxz7YYZ
	 ZnmZ7ZYhWetMXYooYiSbE3oQW1DF2zNYmQMWrwQT6N3NukcmNFef7Gqzo/XfW+Zwjy
	 l66sBophg1UpA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id ABC454253E; Mon, 27 Jul 2026 14:19:19 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158358; bh=ksjwRj9O5mj6SOLkHxcA5mgVVcUr5GHEVrdgXR4l6R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDTPzTA7ahHTneUM6KbjO6Ws1u8WwNBDpao2TELEkbt1zMrI0DW9CzDS/y3IzdvAf
	 808FpKuWfOBIEx6fv44TSigfjUPTVlawqEDFEZ75hy/0tFypjzjtCSUq+a53y9SpIs
	 68PD0i2aV6otHcND5FH8KoF80rTEHaG1PAETIzXhPPFAwby0iak1TtqTjri+2X/ziV
	 Hczc5VIPHhWBJi/NgqzaZ8ffNEumFKzFTxZhNk/4X2tCKTcHXPToMjpHlO6neGLnCI
	 NUWx6kxHFDjwsHz9cc2lSwB24Xf1mq06PAYXOwsJpwEUC2TDzNk4fbc/vuV4+2y8Kh
	 MvT5CxWoPicSA==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 23CF74254E;
	Mon, 27 Jul 2026 14:19:18 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/15] media: rc: Use after free in ir_raw_event_handle()
Date: Mon, 27 Jul 2026 14:18:54 +0100
Message-ID: <3f498e032c1a5849dbb37eb016a82282ebc7fedf.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If rc_unregister_device() is called while IR is being processed, then
ir_raw_event_handle() could call wake_up_process(dev->raw->thread)
after kthread_stop(dev->raw->thread).

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-ir-raw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index ba24c2f22d39..96849faafde3 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -637,6 +637,7 @@ int ir_raw_event_register(struct rc_dev *dev)
 	if (IS_ERR(thread))
 		return PTR_ERR(thread);
 
+	get_task_struct(thread);
 	dev->raw->thread = thread;
 
 	mutex_lock(&ir_raw_handler_lock);
@@ -648,8 +649,13 @@ int ir_raw_event_register(struct rc_dev *dev)
 
 void ir_raw_event_free(struct rc_dev *dev)
 {
-	kfree(dev->raw);
-	dev->raw = NULL;
+	if (dev->raw) {
+		timer_delete_sync(&dev->raw->edge_handle);
+		if (dev->raw->thread)
+			put_task_struct(dev->raw->thread);
+		kfree(dev->raw);
+		dev->raw = NULL;
+	}
 }
 
 void ir_raw_event_unregister(struct rc_dev *dev)
-- 
2.55.0

