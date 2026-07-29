Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771AA4D8D80;
	Wed, 29 Jul 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338598; cv=none; b=M3ErApCFe4Nz4bzXa9x0lkBXTFA/Z+oi6HDAFlUFFtL5ffRzZqI2Bcr11IXoNq7Khxb6VwF0vgsZP4cu6lOoCHtJxP2tW93uKno2sXZgSGU1MmiEI7lNjiG8dYlHm6LgoJd39/Yk0+pye6aCccOeTaQ/D4RABPuwtpDGBsawrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338598; c=relaxed/simple;
	bh=i5rBdAMlVMBlAr8vZzm6Vlt+SoQct5tYvtBfS4mCTQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxruHTqz8MvBXiIj24yiBJVgKpYUPwM3z9dmVMdSSjLPqPz1Rlr3k9iovRkSv0FmmGpleyiNxfjcB715tkTfo0W82exBXFWgIPkf7KmXymX1ZHjOznL55JWqVngJVaGUsktsojUirivxhvCD+ldH1qDAJ+1DIwU0MYQHyDEqf0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=jbbkjSrl; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=nXK94fBx; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="jbbkjSrl";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="nXK94fBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338592; bh=i5rBdAMlVMBlAr8vZzm6Vlt+SoQct5tYvtBfS4mCTQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbbkjSrlstqVmyvpBbKILIjCT5Zn4Mgbmk0pUGa0gpUjyO36eDNlgy80b/f06m+RH
	 8dkZeCTQ62PaJrT1dkK5YxVXToxI1H+us98fh7WCWjkLlOB2vmGFKWC0dI2JMP4egi
	 wP1kSAl55KUXrel/xqwHJSijq/cyxY+RqXsElmkNpaiT+V9A2tJ4bK74GduUTtExR5
	 VonxwZ3WCTFcnbImDZIUgJc4ELmUomijML4qXpvOXzNXbW77nD9Ky71aMN7ed9arqk
	 OZN9qbFP8mXXgUad9XwORFoeHuoodMuD4rVmnjpf8VkumK25kb+ifREGIx7nLyqMUg
	 +/Y76o9DGU56g==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 883344253E; Wed, 29 Jul 2026 16:23:12 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338591; bh=i5rBdAMlVMBlAr8vZzm6Vlt+SoQct5tYvtBfS4mCTQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXK94fBx4n0Mv0TIF5aAUfoYX9LMa6UD3DazbxCltPuBq4691+M7ZRiMLjnT9SsxR
	 2954v+gu9Hkzuml3WnLPhUHUTrfUoVzy4/M2NR/Qxg9+zyKXKLcMrW/BgS8M65t+BJ
	 LNuhGn7uciANYwaElB1bJG81A9Yymw1h2FsqyPy7PpHQe3QC2hEhxvP6SkJReVVdhu
	 dM3h+U5ovQK9ibmVMzl1LgQK9zlMRSEof5m5o7CS3KV6EENeOMekCrhcGFddVIFtvd
	 PA1pn+48Wf8WMLLrt/WRnVoFh9hW0obZwEDMasQnTFy1AUHuhudu6EzumcmhY2SNFW
	 4JogRmE0D4x1w==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id D1CBC4252C;
	Wed, 29 Jul 2026 16:23:11 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/15] media: redrat3: Error path leaves device in transmitting state
Date: Wed, 29 Jul 2026 16:22:43 +0100
Message-ID: <92bf1bf1bbdcac248de159a1670bb8bc1c7fab14.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the allocation failure error path, the transmitting boolean is not
cleared. If this error path is followed the transmitter cannot be
used again until the device is replugged or the module reloaded.

Fix the error path by moving the assignment statement.

Remove the check for the transmitting state in transmit, since rc-core
ensures there is never a reentrant call to the driver transmit function;
the transmit function is always called with dev->lock held.

The transmitting boolean is only used for interpretting firmware errors.

Fixes: fac59136bc22 ("[media] RedRat3: Return directly after a failed kcalloc() in redrat3_transmit_ir()")"
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/redrat3.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 994d4864520c..602b84dd628d 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -773,17 +773,9 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 	u8 curlencheck = 0;
 	unsigned i, sendbuf_len;
 
-	if (rr3->transmitting) {
-		dev_warn(dev, "%s: transmitter already in use\n", __func__);
-		return -EAGAIN;
-	}
-
 	if (count > RR3_MAX_SIG_SIZE - RR3_TX_TRAILER_LEN)
 		return -EINVAL;
 
-	/* rr3 will disable rc detector on transmit */
-	rr3->transmitting = true;
-
 	sample_lens = kzalloc_objs(*sample_lens, RR3_DRIVER_MAXLENS);
 	if (!sample_lens)
 		return -ENOMEM;
@@ -794,6 +786,9 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 		goto out;
 	}
 
+	/* rr3 will disable rc detector on transmit */
+	rr3->transmitting = true;
+
 	for (i = 0; i < count; i++) {
 		cur_sample_len = redrat3_us_to_len(txbuf[i]);
 		if (cur_sample_len > 0xffff) {
-- 
2.55.0

