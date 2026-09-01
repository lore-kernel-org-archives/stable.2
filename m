Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115A384CF6;
	Tue,  1 Sep 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272729; cv=none; b=KOo2P2FKMr3ZylmvFvhuY37aQBu+b5rio7a7Oi0wr/H1LeevOzp3mSCRjLftgdGEnQz50/KdxPZ+ESkHCZfyjWVZnxkButrWtipdW6/gzo6rOCzoVF5ZqOjShq6avkChu3S0jT+0FJeyhDgZbDsW9vKSeh/z38AGx/oZUxGF4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272729; c=relaxed/simple;
	bh=Pr6VJYZ6fRxZ+pIKzkWZXcVFE6rXEN7AqyZXWurzQxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMibZcgw7N6v7k/DFJ5ji5e0p+A3BFLkyAfd+ZH+YX7j+6EHYHhaVyD3gt3ZkbQ8xMHFka2L93k2UKH5owf96sKn0a3PZjkaZN2rzDYyZKUdbdx0819fJDkDu35/l4bA9P+WlRNCqVTNKgwuI7YWuEosYFUXO2ToW4FWSF0zocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=LSGzJFGh; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=LSGzJFGh; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="LSGzJFGh";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="LSGzJFGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272726; bh=Pr6VJYZ6fRxZ+pIKzkWZXcVFE6rXEN7AqyZXWurzQxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSGzJFGhYZYEVp5pQXQB32yP/+WXGp+GccZSDrrKr+jUbppX2TjhPbiEumZkvcdtM
	 ULa92SivUlUTjiyYbt2u4Fm4ZAtrIbPEquo/taetx/3kXAa7fhdxdzuNnEfpEu/RDP
	 NqQkx837SMoxW0p6COIOVBGLBw18IWyZH7LH+d5wRrZIVO3HabL0Mes6hpvpCJquT4
	 QjZbdc4dTq2rsRxOPuqBcHVBNXwKcRBQjLbW/Co/lx8by/KPKJbQIR5o2EzYZcyYEr
	 ZnlRzOnF6gR8E5bdZlWGwlKP/Lb62PkDtmT+TJdsL1OOjCB1v/7XANL9M1BDfw5JRt
	 H1ko/wBaB9m0g==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 9C0A74144E; Tue, 01 Sep 2026 15:25:26 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272726; bh=Pr6VJYZ6fRxZ+pIKzkWZXcVFE6rXEN7AqyZXWurzQxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSGzJFGhYZYEVp5pQXQB32yP/+WXGp+GccZSDrrKr+jUbppX2TjhPbiEumZkvcdtM
	 ULa92SivUlUTjiyYbt2u4Fm4ZAtrIbPEquo/taetx/3kXAa7fhdxdzuNnEfpEu/RDP
	 NqQkx837SMoxW0p6COIOVBGLBw18IWyZH7LH+d5wRrZIVO3HabL0Mes6hpvpCJquT4
	 QjZbdc4dTq2rsRxOPuqBcHVBNXwKcRBQjLbW/Co/lx8by/KPKJbQIR5o2EzYZcyYEr
	 ZnlRzOnF6gR8E5bdZlWGwlKP/Lb62PkDtmT+TJdsL1OOjCB1v/7XANL9M1BDfw5JRt
	 H1ko/wBaB9m0g==
Received: from maru.home (host86-128-233-22.range86-128.btcentralplus.com [86.128.233.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id DFE014017A;
	Tue, 01 Sep 2026 15:25:25 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] media: rc: Ensure that rc_unregister_device() does not free input device
Date: Tue,  1 Sep 2026 15:24:52 +0100
Message-ID: <fc444d6e0e4822b30c72a39590618d860cfb8155.1788272198.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788272198.git.sean@mess.org>
References: <cover.1788272198.git.sean@mess.org>
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

