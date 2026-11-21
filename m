Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296689;
	b=aGINznranKrT9xiWzKfA9tzlJcjK7jThBDDk/W5Eg302ZeuGrPAQm41hzy9LFk2viDHm
	 rxalSs2+eNfM8uioDSf5o1W6b3synfPjTs+Ljiu50tioERQ9DVE6XL1RB3npPOG5xDy+R
	 J3Or+jlE314o+RShe+pGMzqK5sGQ89xumagS9kpNMmT0OD+4PriLNSnGSHIU8JQgC6Q0B
	 54BdfjPFsTyziVXPynDrraT7nlt6DfQnuS9iNbDKJzG97Kueaq0O3/ZQyI17tqbC8VOmA
	 MNStWdAfSGZHL8+IDLBxqvlGZ8pjGWQjirk9HVf4C9RRDMk3kkcq+9b7Gy1vq0Leqyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X4S2e9CjFKlM0TGwa7Hvfd4KZ9Cvqy/EC1mLja43EyI=;
	b=cuCBv1EXXlvUHK+fgJyqts5VYNv3hT6zcSUpgbhpeZjuaKcG41vF234wsydQKwx4AE9J
	 K1ULH1rqkPwyg9ADdYTtd/GXNJqPNxsd9+S/piT0McXhV7udCk29Tg+QWQT7GYmyV5spN
	 4mHEK2owjGxmPjz8LTnUxICyX3RAHEs99xfKVMFwUcTkFumvtVafcwiZk5uBdTS0KHjwf
	 82eFPi1iB+o+Gy7dbGaq2yRsQrk+NPtGJbmyHYpDTjiZj3hNC5M1Sx/W+caN85S5HILtK
	 ZXPHbMQVDRnMt71HYypZjfK+UAvrLwYceD5cDqZmXFUhCr/QPkK/h4A9v06uz3OE/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=vAATXk3V;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BC0606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52BC0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=vAATXk3V
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8629ef48703so1185048a34.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296688; x=1795901488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X4S2e9CjFKlM0TGwa7Hvfd4KZ9Cvqy/EC1mLja43EyI=;
        b=vAATXk3V6WG3wD4bVuL/gp0izfnDaLSPukWJ40XnPMEfVRsfBGmxvWbZzHCU+XV5NG
         sRn8uDqXlctJ2kckMrQO7Wld4X0y1LmW07f1fNTbAdooleii/i0a4OcKCoo38DLIRXmZ
         HA1/Nb2lxxXZVQpMb6HMWyfczLXzd8cVV7KJU8vBHfMVT5tgyhi4fN8v5qDhVYWf+SZj
         xlkC117sNRh3dsOujK3Q30LmIPCEnsHEx3+GvbkazG4rEvpQ30PlRYDHhQ/2VPLq4B6q
         0roFeYZRRNUcQoy3i5VuqoRKTMw1eM7ZS1cDxpBb52OyzQalxROYaN2eD+/vECfvklVM
         zIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296688; x=1795901488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X4S2e9CjFKlM0TGwa7Hvfd4KZ9Cvqy/EC1mLja43EyI=;
        b=MdPh37aARpixE1MuThjSTppF5JjRnksN+ZxXq5CSLD0TK1XNYqRl6sm+bN2p7RL4AF
         1vSbveM5aleV3wjCYApcsZBd/c5nNPjl4ZZ32HibxxjAwQtI/sM9iB/WjKkcTGUfsvQy
         /JN9VM1jA0aHZCaKKbxCtAATm4BiUcC51KbCwBOatdPHb+5abUgqpNcmKrETU2rAo1WO
         TaSAiSGSKkfvjEIlkBA+7WlXxlsWIEDN+qWXOhR8cXu36ejcftEJm44NwvB+9d+b+bTl
         LBKmKHveASyAtOZBV0DFOaEca/yvVzuop5mKYf80L3oXueEbSnlE60tE461hBlXBHuyF
         1+Og==
X-Gm-Message-State: APuU4Z+EaEEBlBpRrqQYeMG/NpOYE7kIdi919/xdME9qbL8tEtRETokA
	ffcwWnnOeKdMlVpKBoVBXvFjHgg2p3rcQ8yPEwwI8KAK1QkqSwsgF+waVuWAve8f42ys+ZUIaY1
	2XH/2ub8=
X-Gm-Gg: AZFdTZctK2ndmaKtKxDitXCNy+eAnaYT3MF5yxbjYEESlzGWWOu6yKy1+jUuiGt9PdC
	uaKuKOLXWftWCJx5LnNCi+ikVaKUWe0VWsgQi+ae04BZB0egO9XyMF5wz9zA0c9f6nEioI/0FoB
	KZmijXtukgQjuEgavZQuFwPEgfcvE7nZ2hityoMTPFRCTKH0k3LEs1r0UetzNLdc2g9NeXDOjXZ
	aahSiKltk3K2ENOlMpd5iov4xZKzkyDnBSsFx1Xpu62l6iNbtsozVZtlDTmLkFFQC9F/zARjbpi
	SYm0mjVX975DBq69bjlTU9tIhlQehr4VVXQE6tBDPqNdUpjAL34LOgVEO3wdMJoCXHbIQR9DIje
	hIIQg+mV4wIYd+X1AfR80GPBj2u23JUBd1s7nFQTSr4cnYAWJTb5ZFTwSpPxpvVby+yTYoz8vwL
	1Z1ZnqXfomHtofMHwauJkGkz/iL51RC5s7ElWMc/39uc/cynO+u1jFqpRNFa4fZ038lf6bXpT8D
	3n+o9HmJsQB9OyJy1Txz+AY2HyTvVIifNYyGaTdI/3URaJNVSMnoYjfqXfw1iQtAPzjeOMOqiqJ
	74NXezMikJRWnuaEyRJ5gD5Bts9LU4lZcRQ8q9VmxMGUZiLYjw+w8sg5WvnR599bq4claSWd/EO
	XM8oKj8+XhYUIcy183uWZ4Qt/rdQluEop9tt4
X-Received: by 2002:a05:6830:3150:b0:862:884e:b4a7 with SMTP id 46e09a7af769-8631549edc1mr10844028a34.7.1795296688355;
        Sat, 21 Nov 2026 13:31:28 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm4946113a34.18.2026.11.21.13.31.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 4/9] io_uring/futex: fail soft links when cancelling a wait
Date: Sat, 21 Nov 2026 21:31:16 +0000
Message-ID: <20261121213121.1789042-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213121.1789042-1-axboe@kernel.dk>
References: <20261121213121.1789042-1-axboe@kernel.dk>
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

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

Commit 9a7cbe50dd95594d6fb3c57b8454ace58d8d8d0a upstream.

__io_futex_cancel() completes the request with -ECANCELED but does
not call req_set_fail(). IOSQE_IO_LINK dependents then still run.

Fixes: 194bb58c6090 ("io_uring: add support for futex wake and wait")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20261114072246.741950-2-yangxiuwei@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/futex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/futex.c b/io_uring/futex.c
index 990568baf393..59b679e1e26f 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -108,6 +108,7 @@ static bool __io_futex_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	}
 
 	hlist_del_init(&req->hash_node);
+	req_set_fail(req);
 	io_req_set_res(req, -ECANCELED, 0);
 	io_req_task_work_add(req);
 	return true;
-- 
2.55.0

