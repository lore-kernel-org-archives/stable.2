Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC64306776
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088826; cv=none; b=WXMt8+fpuldei6srbUW45wHqcjXmEPwul5ecJU2vdfMNUUEkW2/Hqk356OQ406zgzX9UU6UXo7t7RRe41JzSwX7WTpHPNWUlVTiiTBNFUCx+zOmqimocS/gRUuW2GNkaPFuYIFVWfFhAG2y3z/tajdEMA7wUsksxQ8tveTk0CLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088826; c=relaxed/simple;
	bh=hghF98NYK78YNHXX1dgieJtN7r6JRJ6pzIa0JQe6vbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfcgHZfsQgaJFsU5omxbTa1tOGSaQ5I1ByUUvcmsqVbAJ0LND985ulAhQm/jNcVNG203ptfgRXcLSFb7bVBWvT0gm0xDW41Hn7NAoCsL/0i9tY0u+Wcb7gpPNqaXKifVHBwvkbR0Bu8acQwkL2sNWAI9li7dMv7pHtavjllv51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=CwKohdlU; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="CwKohdlU"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so24168705e9.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790088821; x=1790693621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZdXUXs+Kfd08foCbufXmHwGq0BzwF/4pD5Iu/UeB7bk=;
        b=CwKohdlUD17rHg35WuwS78r95cJg4lU9oAXAGfUbvlyRzxxSbpq/dyvXNaGan62JtZ
         PT3/EuzzPEGnsEVmBc/bECCNU7e1qVB3BAMPEd6dA+jBiEcrX7dP8X4Jd6+quw8RiSb8
         J4VoQuVGZENc75ggYvnoqeB2+HeVHf3E/YUiSvgd+Vbl2sPhR5Qnj+g/4IMgzKIat0FJ
         FJ8LyJsulV8C8FllKniX5P41gwSR94e6tal4mIc51LeGZvsBMEtELIenNMzUDmsO5tMU
         ylgtRoMZwS2cSBw61whJA8/ZRdbE8i2OtmpIJa9FzvOtOHpciXqN5vLrVaQ9T7ulDVpQ
         8Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088821; x=1790693621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZdXUXs+Kfd08foCbufXmHwGq0BzwF/4pD5Iu/UeB7bk=;
        b=QAl1da+hKgnx0VXruyvxnQjOMPKXKuO3sSXm48uhVkDfwOeoBG4dyqFb+Kb6wUJaMy
         LBPewTQZ8rgDp85RL3t0RPISKUxqieVcIizB9nUDFPP10r7Lc6HD+gOckt6VKyEh7JhU
         jj98kPwZ94pnE5GNgZsDjR8zjJ/1aA6c/4gxiJt5Q1H3hL/ol2xzz2DWpaUAEwde+L7C
         bMcCDRhJPriAvuDxCXpKxSbG7DihA19yzOvrMrdiPiVGJrKPTW+gK6vy/Pid8JDHo9e6
         hSnP/X5gp7izJ4qD0HvRveQNf+LEdkZt7hTjQ5Julv4+m1iXPnK5LZmJUIl5+G3ZvAlo
         lEsA==
X-Forwarded-Encrypted: i=1; AKwUvByn8WtDy5KPxKU40/nKd786X+DEnzZF3VsQcEiwD4K9yHuEyl6y8qd3izxh1wbSBEjRr29K5Gw=@vger.kernel.org
X-Gm-Message-State: AFuF++kvD/KaNt8sHehAB32vyDso6jmBPCqxJIEpnvdfnOLZeZPHP6Ii
	7PGsxvXtChWPLF++BlwAy1iKc/Qbgi+SmKtcRDOeVIlyAmG56+o6LzFh+FF27TGVNWk=
X-Gm-Gg: AYBFou3Ltv1SEUorKik/IwJWG2xpfTZu5ebgo/pOU8BDtjqeOsIaoy3hORAF1ZKJyph
	HcO2EF9G/6yFKNqADnUKDfIXUZm31jBKcSizEnNK5tJbTb9ktl4uqCJWh46R+1FhZav0wyv7Ks9
	Nn0RClXqZ6axBMGUc4C2qFcCqrHpxPYqmQwYliekh/de1gZAzTMMm2pxYRQOUbB4I1gGiYsztJr
	lrK9K/htuFvSsSq6PAm4qGU4Odycag2l78LaCK7x/j85JreLmnzTBtu9jPwduwrnpCJl73SHYef
	6gp/uGQXIDw9bzwrg2URahF7C/fWjXa/jnr3yUcy3BnoXhYzimmm8a2S6KrYKR0Wq9ZboJ4BRxH
	vkAPO67sCMm5tdLiXEc7pjL1xW6LJc9JSuRXGMhAicNdHYQFPO1FLlcKUAsSsxbswSJi779UWhr
	fmqwyrzcPuxr0zyXQnGEChN1cJEtXqQxWvdyc/bD70/QiZwTrCT2jZwK4LgAcSYLQq/zrB/HsdX
	PdCOWlx
X-Received: by 2002:a05:600c:a415:b0:49f:ddc0:6e8f with SMTP id 5b1f17b1804b1-49fddc06f09mr4681645e9.5.1790088820973;
        Tue, 22 Sep 2026 07:53:40 -0700 (PDT)
Received: from localhost ([2a02:168:9d56:1:84ba:d001:a11c:487b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4886279298asm4771587f8f.34.2026.09.22.07.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 07:53:40 -0700 (PDT)
From: Bruno Produit <bruno.produit@trailofbits.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	stable@vger.kernel.org,
	Bruno Produit <bruno.produit@trailofbits.com>
Subject: [PATCH] xfrm: espintcp: build sk_msg locally before publishing
Date: Tue, 22 Sep 2026 16:53:35 +0200
Message-ID: <20260922145335.2016559-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

espintcp_sendmsg() builds a new message directly in ctx->partial. If
allocation fails, sk_stream_wait_memory() drops the socket lock while
the shared sk_msg remains unpublished with emsg->len equal to zero. A
concurrent sender can then reuse the same slot. If the first sender is
interrupted, its failure path frees state now owned by the second sender
while TCP may still be consuming it, causing a use-after-free.

Construct the message in a call-local sk_msg instead. After allocation
and any lock-dropping wait, recheck that the shared partial slot is still
free, then transfer the completed message into it. Failure cleanup
consequently releases only state owned by the current call. The recheck
also covers packets submitted through the common IPv4 and IPv6
espintcp_push_skb() path.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
---
 net/xfrm/espintcp.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 674aedc..1642b34 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -311,6 +311,7 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	struct espintcp_msg *emsg = &ctx->partial;
 	struct iov_iter pfx_iter;
 	struct kvec pfx_iov = {};
+	struct sk_msg *skmsg;
 	size_t msglen = size + 2;
 	char buf[2] = {0};
 	int err, end;
@@ -324,6 +325,11 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	if (msg->msg_controllen)
 		return -EOPNOTSUPP;
 
+	skmsg = kmalloc_obj(*skmsg);
+	if (!skmsg)
+		return -ENOMEM;
+	sk_msg_init(skmsg);
+
 	lock_sock(sk);
 
 	err = espintcp_push_msgs(sk, msg->msg_flags & MSG_DONTWAIT);
@@ -337,10 +343,9 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto unlock;
 	}
 
-	sk_msg_init(&emsg->skmsg);
 	while (1) {
 		/* only -ENOMEM is possible since we don't coalesce */
-		err = sk_msg_alloc(sk, &emsg->skmsg, msglen, 0);
+		err = sk_msg_alloc(sk, skmsg, msglen, 0);
 		if (!err)
 			break;
 
@@ -348,25 +353,30 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		if (err)
 			goto fail;
 	}
+	if (emsg->len) {
+		err = -ENOBUFS;
+		goto fail;
+	}
 
 	*((__be16 *)buf) = cpu_to_be16(msglen);
 	pfx_iov.iov_base = buf;
 	pfx_iov.iov_len = sizeof(buf);
 	iov_iter_kvec(&pfx_iter, ITER_SOURCE, &pfx_iov, 1, pfx_iov.iov_len);
 
-	err = sk_msg_memcopy_from_iter(sk, &pfx_iter, &emsg->skmsg,
+	err = sk_msg_memcopy_from_iter(sk, &pfx_iter, skmsg,
 				       pfx_iov.iov_len);
 	if (err < 0)
 		goto fail;
 
-	err = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, &emsg->skmsg, size);
+	err = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, skmsg, size);
 	if (err < 0)
 		goto fail;
 
-	end = emsg->skmsg.sg.end;
-	emsg->len = size;
+	end = skmsg->sg.end;
 	sk_msg_iter_var_prev(end);
-	sg_mark_end(sk_msg_elem(&emsg->skmsg, end));
+	sg_mark_end(sk_msg_elem(skmsg, end));
+	sk_msg_xfer_full(&emsg->skmsg, skmsg);
+	emsg->len = size;
 
 	tcp_rate_check_app_limited(sk);
 
@@ -374,14 +384,15 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	/* this message could be partially sent, keep it */
 
 	release_sock(sk);
+	kfree(skmsg);
 
 	return size;
 
 fail:
-	sk_msg_free(sk, &emsg->skmsg);
-	memset(emsg, 0, sizeof(*emsg));
+	sk_msg_free(sk, skmsg);
 unlock:
 	release_sock(sk);
+	kfree(skmsg);
 	return err;
 }
 
-- 
2.53.0

