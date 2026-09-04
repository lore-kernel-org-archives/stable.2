Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB933372A;
	Fri,  4 Sep 2026 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527291; cv=none; b=kQIES8kzA0r59TnO7r2cCqzTHndqx3YpJxv7Zo5/OWKenoVY82Jjtd7zHKZBvJUut3vcYO7ZQfb8DoPS+iOhtD0d48V9kDe5aHf8LdlAR2Ga4EZs/xcgpysQC5K0YTPUyBq5Chv+5TmbUgnBa68YGJcCuRYlwVnwEQNmYxFxSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527291; c=relaxed/simple;
	bh=knl9K8P7DwwSxVkOS5n9sh72AjW62Q/s0/VL+riJqKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhYL/Pza3TDB5OnuIwe/WhlxQOvIqfzlrrl16OqB1SyBlimtZhJWkNyoS5amlyhrapeXr757WC2n8ox6c8IUohzLe1RcBHTbxzPTxjbbF0M9HLQQPofwfP4RoG2DG0NEz3Hu8lZUPdWgWRR3GLmQ63z+GRQkLTCBAbzRZo7aa1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Ib1VD09e; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=TwhvKyRz; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Ib1VD09e";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="TwhvKyRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527282; bh=knl9K8P7DwwSxVkOS5n9sh72AjW62Q/s0/VL+riJqKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ib1VD09ercYh9+PzxyWmNU6sH5I9MzmcTMjj93rCtCSwT+S4McaMNd+ZdUdBHaENl
	 EnJYPNB6JKCyROXubmzdBbCdXGqBdR1J6Y4lvfE3BO6I+vgLz9qcqSWL+AWfflDoQy
	 /irDmkczG0+yVSybswEsFfKedHIFjUdkbqbPSGhqZPmbKnoAdveWbJLA32UtifJwdv
	 g7NIVlOeID+8nAD4mgpVJJDE+qjLpBWfBb3kqar6cSu4dOkWqtJIEf3sOtUUdQzra/
	 4Sp6yYufwwNJw6fAZIvDAolcwnMs1de5UhQ8BHda1F098Olp0XEuxnpHLjd7l/pzL4
	 OOGx7FLh9IeFg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 36EE541460; Fri, 04 Sep 2026 14:08:02 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527279; bh=knl9K8P7DwwSxVkOS5n9sh72AjW62Q/s0/VL+riJqKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwhvKyRz30PHhCXK6u7vFt0FJcAh72RA1xRShtXkJ/f6Pa9Jx4BtXEylt9QcvB36+
	 PSloOwqYRDjGn6tljbeDCNkptZV5xgsLw8TgTGYNWqyLfGs8kcI/dAxGlEEccTZyIE
	 bGYQMpwbW2YUMuWFPcEfX/dCIsxRppGmdLgSHp9JnScXPeyCLzxqUK/1CSl9FsnYgT
	 m/k5eegodEMT3JBs0+YpjkbVepQXTtERCqI4XHwTLnw4Cfqmnz31dj7Ofi7KXNnFyl
	 Xevqc4ZJF5AKGb0nMnO1In84FYXyXb+q5EkyAoEEocTqf0fmqL9LVx8hUE6vRJ9emh
	 LqjZUhTsh1+YQ==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 5B11841453;
	Fri, 04 Sep 2026 14:07:59 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 05/17] media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
Date: Fri,  4 Sep 2026 14:07:33 +0100
Message-ID: <e981347f8de7e633d98bf2eacbea6cbd655331c8.1788526920.git.sean@mess.org>
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

Mark the device as unregistered before tearing down raw IR/bpf
state, so that racing bpf(BPF_PROG_{ATTACH,DETACH,QUERY}) calls
cannot slip in between ir_raw_event_unregister() completing and
dev->registered being cleared.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 04204559959f..924b13fff753 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -2050,18 +2050,18 @@ void rc_unregister_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
+	mutex_lock(&dev->lock);
+	dev->registered = false;
+	if (dev->users && dev->close)
+		dev->close(dev);
+	mutex_unlock(&dev->lock);
+
 	if (dev->driver_type == RC_DRIVER_IR_RAW)
 		ir_raw_event_unregister(dev);
 
 	timer_delete_sync(&dev->timer_keyup);
 	timer_delete_sync(&dev->timer_repeat);
 
-	mutex_lock(&dev->lock);
-	if (dev->users && dev->close)
-		dev->close(dev);
-	dev->registered = false;
-	mutex_unlock(&dev->lock);
-
 	rc_free_rx_device(dev);
 
 	/*
-- 
2.55.0

