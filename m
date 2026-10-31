Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451956;
	b=p5wYh1bC1SJ0SazBEJp96toccBbT7oBe1eFW2rJSrBwix1q2gkBzCm+y74qg5aPUjEKL
	 O9VGoYcRSwcSiTRyjAu40n8I03Wme7PfanLNZfOIVtXHgt4JD6UVM/q10yU2ddPlqvnwb
	 kWAN6Aou5j+2OAgp6o+f7QVFr0CHS7kTeWm0YFxpQVBZuJ2wLqhhmeQApsWe6p6vLUGEC
	 rrwPIb/uK52ZU/OmB59fRA/1tp/LrMYqvOjWNFCDa6fex+LniR3H/pM6WsyLb2mexVtqm
	 QtBj45Z2NfNX9TWCUtZzOovE+smB0iR++nbGhcwdx0z0nFh48UtWGMxO2/kzRZI6u0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451956;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=0G1FYbn97ZpskU4kXqlNgRJ9OjsqiMFMjdyQhOyqtCI=;
	b=L2lzQ2bV9rdla0e42vu5lFoL+jfck0yQWxdMpoqrkbRqOya5T09IuaZx+DNQfUw/vm9R
	 OjTZBogdUyRFm1aBtJOzGqCOLEj2NtIuKtm8FXUICir6CZ+yrUUL/co48JCvfyAwraFxt
	 1zny+YdBUGLJim0nfD3Kdu78JgjEKcWEVfLNyzAkZ3eFPhDoFpBuc9lZvsRhRA5YYvQwO
	 Qjh2JlRedrkauHdlA+La1BTQGS4W5GFLWrK/aSjaqvzlX99oBzh6CLl9TLnf2da49QvOp
	 TlTiLNopH6fs90Kq+QCujbOcRrJ68GNjqtt9VM1sVK7/eR3Ss7tiDA0ppucSMzEXW7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=EW8HNwyx;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA886606A326;
	Sat, 31 Oct 2026 13:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA886606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=EW8HNwyx
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 530655124;
	Sat, 31 Oct 2026 21:05:44 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: tda1997x: Fix potential use-after-free on probe failure
Date: Sat, 31 Oct 2026 21:05:43 +0800
Message-ID: <7c26d0753bb5a45f4abdec2ae12f2cba20dbd0c7.1793451813.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa19210e9cd03a1kunm3ff2cb8183bf1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUNOVkhPGhpNSUgaGh4ZHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=EW8HNwyxbhgn3VQFjKKPl+AY+t6wmioZvSqh8KHKOKoQB+luLIaCoApxe/7oLTPO7hNysyAZ3puvqpTzWDBSaPocfiqkYYc/soxpXZGAfT/j7PV/OYTL4yw2XCCqYxNkhrWh4hew8AvfW32U21MA5l+WOQbdKhyIAmBpXnXTDcs=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=0G1FYbn97ZpskU4kXqlNgRJ9OjsqiMFMjdyQhOyqtCI=;
	h=date:mime-version:subject:message-id:from;

If audio component registration or IRQ setup fails after the subdevice
has been registered, probe frees state without unregistering it. A bound
notifier can then retain a pointer into freed state and dereference it
during teardown.

Unregister the subdevice on these late probe failures before cleaning up
the media entity and freeing state.

This issue was found by our static analysis tool under development.

Fixes: 9ac0038db9a7 ("media: i2c: Add TDA1997x HDMI receiver driver")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:gpt-6-astra
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested drivers/media/i2c/tda1997x.o with x86_64 allmodconfig
(GCC 13.3, W=1). Rechecked the probe unwind paths in source.
No hardware runtime or fault-injection testing was performed.

 drivers/media/i2c/tda1997x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
index 30dfd8a7b42b..4ff9acbc005e 100644
--- a/drivers/media/i2c/tda1997x.c
+++ b/drivers/media/i2c/tda1997x.c
@@ -2776,7 +2776,7 @@ static int tda1997x_probe(struct i2c_client *client)
 					     &tda1997x_audio_dai, 1);
 		if (ret) {
 			dev_err(&client->dev, "register audio codec failed\n");
-			goto err_free_media;
+			goto err_unreg_subdev;
 		}
 		v4l_info(state->client, "registered audio codec\n");
 	}
@@ -2788,11 +2788,13 @@ static int tda1997x_probe(struct i2c_client *client)
 					KBUILD_MODNAME, state);
 	if (ret) {
 		v4l_err(client, "irq%d reg failed: %d\n", client->irq, ret);
-		goto err_free_media;
+		goto err_unreg_subdev;
 	}
 
 	return 0;
 
+err_unreg_subdev:
+	v4l2_async_unregister_subdev(sd);
 err_free_media:
 	media_entity_cleanup(&sd->entity);
 err_free_handler:

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
