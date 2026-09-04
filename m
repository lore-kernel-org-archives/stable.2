Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C831AABF;
	Fri,  4 Sep 2026 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527299; cv=none; b=Gd4ZaRUhv+rD/f4NFQEg94/XHpmiS4ETuFnGnudzv/mVGFxCGuRtUNXJVuoGNy3uRg3DpHGJ6Caiej9DVc/SdOgflwQmakuxDF/79zrqGvOEmRAeCjDotcNoPn3B7lqs0ps0z0eer1cwlYISHv9xK/gLR24X4rRtIFyKvnOWUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527299; c=relaxed/simple;
	bh=rH9m2JKmI3CULoSEwyvXaIZDZIwju/5v+OFwPSGDjhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUGDhmZ72NTWD22QJ1SDyOrabqCRKn4sEak9dKNB7czyNlDoJJUNeQS9cfrl6Y438QtHcC3vk7NP0+NcSckOuqq+hmdmZNfcwZHR471Q5NFmFzkO4rejX5sh7LTyGiv+xW+IOMTmYvOVx4thH1tNtLc93/T//iZ21J4mCChMQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=rzBP5T8K; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=oPbKw0PA; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="rzBP5T8K";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="oPbKw0PA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527287; bh=rH9m2JKmI3CULoSEwyvXaIZDZIwju/5v+OFwPSGDjhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzBP5T8KLoJoqr4pkxxtD+4QwYcqcxJ6pznwae0VwHJzP4lPL/P+EAD6ebt/8X5zS
	 4/t+nnDChsNQb4VzRBPe8p1ieq1SEDRCVHaTFmb08CFK+nDbnxe4B6t5s1W+QtrZzg
	 ReM/ewaCDS9TeTMiTlkeVN7591AxM4e/ahz8m5XldQpKne6P7LoaKaMMjr0gg2Zfs7
	 6xUEPENGD1UQ8cIKH5PfBZnAH5AjTTJoIey1OVtH2Np//AggkwG989qxjLes3/eMZC
	 VGjArYBmjWe5yJB4I9M4Kc3YizmluaIhG/TPoSvmxB4ljP6lGOAfO81YKkZocKGGr2
	 aPNZ9mPbsltkQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 86D6141450; Fri, 04 Sep 2026 14:08:07 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527285; bh=rH9m2JKmI3CULoSEwyvXaIZDZIwju/5v+OFwPSGDjhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPbKw0PArsQIkM3yEhouU/J1T6usaFIQZ/OYINADgLz3b1mC+R9yZuiLYOYRw7m2g
	 OMTtITDSAdlxQXqp1X/s/fPJf88Kbkf42zUEMrsCDZ3M/k5nFxNtbPpzP1mJMQu3I/
	 11cO8gaRI9JSDSO2qFTYB8XkkrOcBX9sdY7RB90H38Lqx6A44Nc8qh9ts9zZHZfIUR
	 pkykreUWIFtB+lGgXIq6JwRlMjIRMFb8KUvpqcyUtgfUbhnxzt9QtzMfQRPJl7iQzo
	 cgVABMpmv7oWhj8thn5OqjEmN4l1SmH9bmEhRNx2OwDrnD7+ekpoRQ/b1zMugOwyD/
	 tWl6MzsGkIKUQ==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 5273541471;
	Fri, 04 Sep 2026 14:08:05 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/17] media: rc: After rc_unregister_device() timers can be re-armed
Date: Fri,  4 Sep 2026 14:07:44 +0100
Message-ID: <9a0007543dea39b08f2c6124e005ddc90afa10a2.1788526920.git.sean@mess.org>
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

If rc_keydown() is called after rc_register_device(), then the timers
can be re-armed. Delete them again for a final time.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 795ac0fe4858..a40d1bb75822 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1785,6 +1785,11 @@ void rc_free_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
+	if (dev->input_dev) {
+		timer_delete_sync(&dev->timer_keyup);
+		timer_delete_sync(&dev->timer_repeat);
+	}
+
 	input_put_device(dev->input_dev);
 
 	put_device(&dev->dev);
-- 
2.55.0

