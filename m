Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33A4A5EC4;
	Tue, 15 Sep 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461204; cv=none; b=kVpcdHzeYzNAli6aK7RxWKG86o3tJ04oK90WbNyGThZs9gX/FMZex0FDx/sO05J61LWnWxv98mSfCfWyI/r+uNU5jzBmmzgtvZlypP99Hav1uEkD2LNBuEVSQE/Bw2gMOJ5MnKjnPgNcHXzrGZy22eCzUjzz1DWN++iywWZZvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461204; c=relaxed/simple;
	bh=xlnQfEOZkNIp/JgJ1FbYgNLE9q7zLrOssHRudvgdWdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUUrO9iRQLI+TZL872YNZX6ZzN1ZofveeQ90SrdUvNMZZZVl6R29tux5kMHYKOTlOKeneCpTWqAy92Hr0V8CMZni76EXN+9tGasssUt0S6jLZJQ4sPup8HQMrzoTAvEPZrw7LtuIV6H4PtyPv8vf/AAgbrJ2KhWugy/I3Clxyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=OkFKmpdg; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=LT5xdK+F; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="OkFKmpdg";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="LT5xdK+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461201; bh=xlnQfEOZkNIp/JgJ1FbYgNLE9q7zLrOssHRudvgdWdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OkFKmpdgaSx34fqwaYN+A+NJs8qgO6OFnM3dO2TeL4meMmrI5b5h4+BsCqoNBR3vm
	 o4Ykjjt3anC5TZ7U57Aoy3JxwQoDIYoh9bwcY9ve7erZwZc8tZDHiAFFgKRg/KHEHg
	 TPpfLtPQVHuX1IXO36yOkfT8RcD8PxpMVKQ5/3fGgcpgmZzJMjynfIdEQ3W2t7tABD
	 5GaM205GfpXOq/Z065yOKgMMMU/dAuEppPov3Z95jyLVlzLDRI0L1BCKhF0lhe1a6K
	 ps31TJzmYbPzCTVeO1EpdnrfnrKwPb6HYLFCRmImjSNtDdqUPZ8WZTNHFrWJmtFntw
	 BJV+eVDYruz+Q==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 3DFB040BA9; Tue, 15 Sep 2026 09:33:21 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461200; bh=xlnQfEOZkNIp/JgJ1FbYgNLE9q7zLrOssHRudvgdWdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LT5xdK+FTvociTc+Zsr5CsnVjboy6FR1ZS5Axqv5U5J1wmELyGGkHTYSIceJPU59k
	 bUp4JSU58rx91uE3DmlmeHkTEO7ETClpYr3v84Vob+oZCL+Y7dqb3oXrMtroh5Oz0e
	 qd2Ap+FrFdJLKSH0Yd7KtdxzZOXCqJZYGyo/dx+7MhQJqbSShoMEUU2xboLyAv8zPU
	 uaVrZC+WmEFaat4hPQO+YYLpqqLPvVk83+lo3SwQewM/oHAY0tVeC92Q5oSIQsBir0
	 aWjL04xW4WMWUg58/7NIXXRmI9wpqOvN2A2AbS0ULRWTeS8hL8bJLypSlhsDPRFNZO
	 14S3c9LNdLUjA==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 7210140155;
	Tue, 15 Sep 2026 09:33:20 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/20] media: rc: After rc_unregister_device() timers can be re-armed
Date: Tue, 15 Sep 2026 09:32:27 +0100
Message-ID: <9c1099bbd2410b028e86b342b387776affb3fe94.1789460680.git.sean@mess.org>
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

If rc_keydown() is called after rc_register_device(), then the timers
can be re-armed. Delete them again for a final time.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index ed746255b0a2..1c07bdd3b42b 100644
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

