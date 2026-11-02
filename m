Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628841;
	b=MdG902aKtWEF6SNJ2v208xuJYvtkOAKlPjJKcSfVghFXR9M90c3HoeolZWQaGivgLelL
	 NeiCuidQn/TObz6e5yx68np5siE92wUyttc5fsunFVBPOcZS5X0MCrNZi6UG1HCb7XcaZ
	 FoPPVmDUwtFm7DCmyX+pDkmqXebVZotpwq8EJtOtCLf6fwnxpVZOj89w3EuNP9GuwhGEf
	 so+o8USFqd0J0nttXoi/cVB0P5UdwKqbTfIaWqy3t+IvRdpkrAlNjozImylTZEj9cEpMi
	 lbfUPYJfzuE/B0dzKV9yIvZWNhGOv0lP2i/g2bm6AFnQRrW/UbkK8xiQd1xdLJTZEIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dJnJAQ1J2840u9KECjcYuFBU8CaqLFZXy5w57Y9rz80=;
	b=pOQxg3swyWywoKoGlUR82WQnbGygf9V4J/G+wSu++K2ju9E8B666PzqTYSvcdzfoznse
	 jCqOpyzZfOxMQHxEPA90NJwrGs5vmmR5nlkPrJLgXsR2yKXD0pdzeKZ85MJ3uY0c8tVAT
	 Ulr56cRwL9vptvlO0wyV4s4/qp9O+teHklRq+08f4PXUvU8rS0qVIL7cdtvjTYVXOXC4L
	 hJ5/D0OahbKXT7Fr7/F9OoRIXsWs57CaY1orG+tg8Cj4KtPMLs8qExaT6mrN6fC5I4PD3
	 lzBxOQv/ee7DAzeuaCVHZMmSa4Mw0+tTj6VDo/3Qstyjo0EZEccAMEyHzqIvVfYaqww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wT+ioHL7;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5960A3814
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6B5960A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wT+ioHL7
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1807129a91.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 06:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793628840; x=1794233640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dJnJAQ1J2840u9KECjcYuFBU8CaqLFZXy5w57Y9rz80=;
        b=wT+ioHL7jvB95UEjyNlw/l3VHPZgzsFnqLUrb+YR3PyigCCQaCkCDKJgAi/wuRNbn3
         pzJmjRpOMqMjwOp+2t9kf/I4jxooQoX3VWWZ1/GflILlpYdprdsGE8YJR/iZ0sqieMxn
         OsQO+o1c2YWE+s8PrbRYNnJSLFaJinM69D1Ay9GLgorKfrBT91EqjL7DpC7AeJVCJfL5
         khFKZuoRvyIl/f0KBHBncIHDh3Gfp+NHDRK6y9WXqxZyfhta+yTbWEumsT3+NIDh6feH
         UKbKwSvC5yOAjk1XAhbCqd+pr8isb+KPc8GQjS5yGewAcwlok67aM4XZGvkrY28uXC0d
         bxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628840; x=1794233640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dJnJAQ1J2840u9KECjcYuFBU8CaqLFZXy5w57Y9rz80=;
        b=CXWyKPNYINtCNCsDE1ypbfw30gU4RQRqNHdmHhbfv8xGmBaaniPlVGuZJvB/sFnuF7
         26UD/DYIYyOict+K8QdhwAUqkTzhpQKfsNd1CLmmHwwGVVw3Pw1nDLpdlRHhKGyYNyXH
         2XljbmqBJFAW/F563c9AKWzXTcB0SbyoE+Nl9HalooVZ6x40nE0u5xTWz5f9sg2kspXL
         qzbbLXsv5F+RRVki0Y1RPYZ+32ZgzhHzbEAW51LgoJAeLq/SqnkKB47vRJVhXaXQiKQl
         TCnlpaG/P+iRdoEKhGphNVpq3zF29dZVsIyFxg12Xt+2rNKUM9+asi1gM7V8AcUhKO+t
         DrCw==
X-Gm-Message-State: APuU4Z8QY7L4HbKCCeXYAfuKxnuiwh+Y7khcMkwEwyoMh/bQLCdN5XDc
	3NCEn1u3Knhj1Cf8YEJJqME+c6vPDGvZM65qobo1cj1pApT09myoBe80
X-Gm-Gg: AYBFou1e/i8qikxe7dzNZkcc72cN41hBJGbskBvcmC9gGx1xkdIUBi4Ts6kkPNGx3lh
	TZ2sS/AyqUaUeFuM2/IK8/nIMqXPo/lUoazg57n+JmP2UEGfAJsY0y4hfaamEeOhZLQQ4OoFWzM
	xgs3T+eSH8itTXbtgF6in0Ec6Mrcht56+aV+rdQeF0Jmt2aOBfCeQkqBVvnFGUVVe/PYcDBPiQ3
	6PdH41GtBHeGQQpUr43Ta8HxbmpJz12nPdYu4Wza6/0jadUshh/1toyPfC/jD79oD/jnBp+w9XR
	6i6BIhWQHcDKNAgEMP+gwt8nUHtNgZ7u9z0wcGBoZ4epIfeYBYMjysr6eAx/5zpTzCNf72+Jc6v
	1JeY1ioQNKNf2pBsUDfuNuSyrlPCb4c2Dr9ar1cg4ZBAQ+4xOkigYxkBcf5ZjV4q7zbg/JWvgJC
	prCCyTd7RPp6d+mpCLdTZM3SAF6ZpCWSagA2IwG3CygvaEO7lohwgK8ddKaUS84//92K6KyRsiy
	Op8ruXpIKZAQuDeSf7IYeCp9bzlXYDoZi+xCdSAfahqR3fmIoCg6HUAl16E/Uq8pKCIlJ0bIvqw
	Qd404EmYB+Q0nGxr+Nes/dnptRld1Ht2vSyEwPfR3l4Q2pP5jvt8lSn9Tn7cHqGcaPlcGnb3j+S
	p4uglTSsCFvPUt/m/asTyb1xNzWaqFlLd6RIYsy954j3HcxiZEM3pIs11xcpCtNNElRRhttGK2O
	fU
X-Received: by 2002:a17:90b:57cb:b0:3a8:c0cd:57f9 with SMTP id 98e67ed59e1d1-3ae89744ca2mr8790937a91.25.1793628839841;
        Mon, 02 Nov 2026 06:13:59 -0800 (PST)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:9626:1a7c:c4cf:3e3b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ecaf5sm14390289a91.16.2026.11.02.06.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:13:59 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: kartikey406@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] media: mc: fix race in media_device_unregister_entity()
Date: Mon,  2 Nov 2026 19:43:39 +0530
Message-ID: <20261102141339.13476-3-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102141339.13476-1-kartikey406@gmail.com>
References: <20261102141339.13476-1-kartikey406@gmail.com>
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

media_device_unregister_entity() checks entity->graph_obj.mdev for NULL
before taking mdev->graph_mutex, but does not check again afterwards.
If media_device_unregister() runs concurrently (for example on USB
disconnect), it unregisters every entity and clears graph_obj.mdev while
this function waits for the mutex. The waiter then calls
__media_device_unregister_entity() with a NULL mdev and faults in
ida_free(&mdev->entity_internal_idx, ...):

  Oops: general protection fault, KASAN: null-ptr-deref in range
  [0x00000000000000c8-0x00000000000000cf]
   ida_free
   __media_device_unregister_entity
   media_device_unregister_entity
   v4l2_device_release
   v4l2_open

Re-check graph_obj.mdev under the lock and skip the unregister if the
entity is already gone.

Found while testing the fix for the syzbot report at
https://syzkaller.appspot.com/bug?extid=54648a6c1187a7ef46a6

Fixes: e2c91d4d78ee ("[media] media-device: get rid of the spinlock")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/media/mc/mc-device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index f8ea7cfe10b2..039ef7d04ac7 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -674,7 +674,8 @@ void media_device_unregister_entity(struct media_entity *entity)
 		return;
 
 	mutex_lock(&mdev->graph_mutex);
-	__media_device_unregister_entity(entity);
+	if (entity->graph_obj.mdev)
+		__media_device_unregister_entity(entity);
 	mutex_unlock(&mdev->graph_mutex);
 }
 EXPORT_SYMBOL_GPL(media_device_unregister_entity);
-- 
2.43.0

