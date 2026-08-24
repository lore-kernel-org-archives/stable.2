Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB26223702
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542462; cv=none; b=iLJAGHyO1UP8Z3nMK0JvQ+8RPJCPxl9LnISqd6C5OICjj6Iwf27xX3/skgY/MtQx/AOxqZ0HHP9nrfpV8K1yOGzimXgduk+d9WrwHImRhl7eq/ew+AzNzdS+mPist2dBhUZYDexuGwQTlt1xbx73GLSLt7jk1qQtcuoOLTKfv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542462; c=relaxed/simple;
	bh=+dKnbTgDxN+0z3CbVk5mqFazg2JoVWNbuUu/8qkYY/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8CeMGCDDqylTPaHr6HReCyYTOVHqEep+NY6B2oD8Yfo4AI1m5RkbGDhjilW/Qg6WtNqo7w87grTKsK+QyG84XU6CR6yzvYeWMkbzjzAQ4E8XYwv5RCdczZXj4cJ84qtN3zwUijC2xWF1wNcs2qKHr/DsoSe4pR1hV+KMnfOE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2vGIGxn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2vGIGxn"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc147d86bebso2416196a12.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 20:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542460; x=1788147260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDKSoho+eBexvjceZDtsEWeLiUwG16rb98ovhChMyds=;
        b=Q2vGIGxnK1/y4F3Fv7HrK/N/qqa7Pj1yY4g6xpp4b7eHhWDNoWPXXRlMW+1Nzsz7f+
         k26p5xOPS7gba0rJlvo7K5vINS2avB6LyagZUcHK9I+xZaKNhgiG12mAPr2mWH8BOpDH
         OS1rWIzPOgFNpHBhZW1XCVFwiDjwteJKZ3OZT3LlfwSkmcxgz0v8ixzsq7XJt3cY7B0s
         SGkG6FUM7jLA49qXYPMfcA+tgFDCyhxXh/8krj76lz1Szh81OFCF6iVMfCGnaD+QdTyy
         /8NIndMAuezY4SMGcm2UnEuQxiUqGcuLQgnXLIQ2acn7i5bCEygIFuVlnNCzDQ9Hu2sH
         WQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542460; x=1788147260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BDKSoho+eBexvjceZDtsEWeLiUwG16rb98ovhChMyds=;
        b=fXivu8O3u8KhWSU2px0l/ZWjxdbqG9DcOqNT4t+IW03KynvD5UPGNJDVAbPHekHjE0
         H/wJEGEQ6WuyMETZa1kCKtJ/jv4Xugx+mnTMynikx4QBQNqHkhizxKM6Y7y3dxYgibvv
         M/DacaonX71j7WRa7veKr1Ww3W2/eYBsKeBDjLZkM/vepPEMJIg5V/QVkibAwvrg0Ups
         cibVLbMTt/UejLYx+H+xF9eq0hiTtS0y30WTE/HO6+2PfX2ER4y+lY5KbNGu3V74anDB
         ACaPasU4tJk7W46tFsD81EqVbS1ylU6JIf894x36Y8DIofYf7fzKiPzGxati5Ry3131o
         g8+w==
X-Forwarded-Encrypted: i=1; AHgh+RqVzItAxaMA/E3DDzpA98GpF2JF3vPVy6fed4ncwgCULs45EIYEePGmGBOhZ5CN+KGZzRtnPzw=@vger.kernel.org
X-Gm-Message-State: AFuF++lWg5vvamfqU6U+you4r600ZTcRh3ucgptX5AEwOEU4bz5oEgU8
	/h6x4PCkGJ2Rh4tN1gsOBTyNEvXxpjCOlqyBkiF3TxerU3swXjsst6eD
X-Gm-Gg: AR+sD1261F7zIDuxlVyB5n3P9EgegM+d2CD2wxO9OwBk6ZdvbuDzNSnLK+70Yjng0HK
	P7IzNypguXHi1xud6jmoGkuMAb+WOv4p61Ax4zGRAmhvkLBe4tCGoG08ZccvN8njpI53KdKSnde
	wb0eZf0gRlyluHjjRtwVEYdU8tn5H88aiSgYAXJqf9FTZKCuouedt8nmYUrC1THnJNV4TiXW6u9
	zgUzD/iKrHSoZzviRvB9wcNceQwCX0iUQlWNojLVKvvoWO82W3ecDJNZQAU2qvrWDNNBQJ3kIej
	iDV5bWZtrnd4QCybRwIiBCCChbeSE9deATrQwxpdxl56bw63OqHAo/AnGFAhDLwKovw4DI1Yqp2
	iKrSWZT1y3JcgRXnNHsTUCn5G6gVHtH/owGameWJmxOsK2OxjrMa1v3IgdfUyvrWiHnl7Rzq9f0
	7Xr3POwHg39YQcRLPJSQ8hPbJxijc22S+tlHm2nY/y1PSzpbHFQocguo0nI6HieRXZOzYQikS/z
	0XrsyFHf8Q=
X-Received: by 2002:a17:90b:1dd2:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-395c4c98f17mr23004718a91.4.1787542460044;
        Sun, 23 Aug 2026 20:34:20 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm4227256a91.1.2026.08.23.20.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:34:19 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch,
	kees@kernel.org,
	jiayuan.chen@linux.dev
Cc: kerneljasonxing@gmail.com,
	ij@kernel.org,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/8] tcp: fix imbalanced icsk_accept_queue count in tcp_check_req()
Date: Mon, 24 Aug 2026 12:32:46 +0900
Message-ID: <20260824033331.1084971-3-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824033331.1084971-1-imv4bel@gmail.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When TCP socket migration happens, tcp_v4_rcv() and tcp_v6_rcv() pass the
new listener to tcp_check_req(). The listener that counted the request is
still the one stored in req->rsk_listener.

The embryonic reset path passes @sk to inet_csk_reqsk_queue_drop(). After
migration this decrements the count on the new listener, which never
counted the request, and the count on the original listener is never
removed. The cited commit already changed the
inet_csk_reqsk_queue_drop_and_put() call in the same function to
req->rsk_listener. Do the same here.

Fixes: d4f2c86b2b7e ("tcp: Migrate TCP_NEW_SYN_RECV requests at receiving the final ACK.")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/tcp_minisocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 12254e6eb2f343..0c3b35a381e327 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -974,7 +974,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		tcp_reset(sk, skb);
 	}
 	if (!fastopen) {
-		bool unlinked = inet_csk_reqsk_queue_drop(sk, req);
+		bool unlinked = inet_csk_reqsk_queue_drop(req->rsk_listener, req);
 
 		if (unlinked)
 			__NET_INC_STATS(sock_net(sk), LINUX_MIB_EMBRYONICRSTS);
-- 
2.43.0

