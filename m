Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221587;
	b=ZxirB4Q5pVGsOrCTPOZBxb16zTm+G7ZwlArgglL9jjeZhu1mZfyavWXeEFi4ifgtAKfr
	 NQKQnLZRSdCIQ1XQHDb/AH00x2B/JOHJcZ7s9F0z+m2sZJV3BKvHF0x+5/VacT0rqfw+Q
	 l9ndQfehV53DtvnyKZM8PQUrXNAA9y9drJWOOvUWO73Y7dRg/VANW2DMp+zRk15+IHHCW
	 /3G+t+knWxbDsQ86vwHJzpkqgxGGbF8Dgj4zpGGnieoxVl6t/3hy22ySyAZMSMtV++BLD
	 U2qptnZXJcCEL2BIEQ40NTvJKBwN7Yr7L13xOJ5YhlYoqkKDQPDAbku/+wJjvyIgNMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yRJunyFxJTxNbMZ/8F4LlLR5Z3XEUtdXwi3weUw7flA=;
	b=mzYgioDumrLLm945JlIRUHKWfrD/JcmC656+eJHl6PR58Ucaa8Sz/5wKtEcsEsEnDneu
	 U8MWdtglRknGLTGcwh4ggbAy1ztPjXPE6nnFIX2YjAnn8DKK1C5rIe4yvUm6sL6w2RQ+R
	 qvPOC3YFOL5eUAOrx9T/4VnKXZ6rScld4R6vEoxSEJphPIvgKWHXH8P1bte1O16DXZozo
	 C0SpHF/jO+tL1rBklhVgRi4QC5hLjkEt2Q1Yd0ZeItm7X7utrzRqLpDMJmSxbyWMThPSu
	 cnpuDURV4rYQ8Vqq+FaEK1SwHIrCiXuurT/1e+fZrTjGo2vFLNbA9jo0VoMvvyZ6Oqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b="WbYUcye/";
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE51606A33A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CE51606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=WbYUcye/
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso1097140c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221586; x=1794826386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yRJunyFxJTxNbMZ/8F4LlLR5Z3XEUtdXwi3weUw7flA=;
        b=WbYUcye/Wh3eUMwCeeB4zvCzv5J0SJTJ55IKpmHb6ll0m6Af03Q5QwAVIjMy/uOg9L
         vpqPrOeXXV5jdlOgEZuWTy7M0BjTKh3qmeuI72hr3S3wf+EZi7WirUd0KhQL7Uxv44O5
         O5UlLGn36bket41zt9POfOI1J8kaFMG4J1gxSvR/z6dMo/baR0Z42MDVqZoEiwb1JzW7
         tJTcjyuIRU8OOh/Bby3eLsvEkJwWfAb7R4oUuMfh75Cv2QqI8wCcDCCQmB5OlAuPNZ1h
         ClK1FM8uY6BJDJvHj5TFG9jjM/r5nBvLl5r63vk/dJImAQe7x2/Aj98FRE5z8RwzG6UM
         k3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221586; x=1794826386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yRJunyFxJTxNbMZ/8F4LlLR5Z3XEUtdXwi3weUw7flA=;
        b=vokGOSvg9OQLlwWvdhZdn9MRRa70aieCq/TVc2HxMPTjqDuqU+JDLZRBnz0ONjh1Cs
         Q9+Hlwdp7lRdHtad/BLEOA/dCrW/an47gdZRzMBEkf5f2hL65S49VPfBy4IkWUResPaW
         5YjRQORcnvTaPO2muX+v1RpasNqHR4wPm2R8QIA8ZKuSiPphdKEeFwdtLSAaqjCR7Fzq
         4YPcsJF/Cy5CURw445bc/cq2dZBTV6TJUzegTtdbHi1qDA5z9/c+BPS6b5A0mX7BhWKq
         XqOg/SPcdZTbBoTMFAKFyn//bXpyyak5rPUWrlptAy9uRe19EPCcQ0uUgbYDxtctz0tn
         veRA==
X-Forwarded-Encrypted: i=1; AL+hErGCLPiMzsc9sTJ4Lj2Yc+b+06qRHHwwoWDa1xWPYrVo20lN2uZbYBHqD81kWmrby4QLnsGBG1U=@vger.kernel.org
X-Gm-Message-State: APuU4Z92yxR/dR4EisOsTglGQWDy2RZlxYD9OLZm/8JqYfbCSlIJzau9
	ys7ZiMoSPzBxblcsW2CWSRYdfWQlGy7WfooG+w08TX7yjCcjpHkpVXuOflwCT6JG2Q==
X-Gm-Gg: AYBFou2WojP0VnuBATzHKZJot3a3s9wtwbCIX07xz3ie5kiiSFOTB8zyK75oUmDVQml
	qq71vpGZ5AMvYZ/ZPjdKXl8YLKxXWd9VsQU+gmSm/HXpIASRES76vHLxm1X8ZnNZ13DfplGYZHZ
	XFFofwn1J6etzc3Dfm0TRvXgVUdbEmTHUwz0f88EZnUSIUn75CE/TmnMdSDwGXV0YhpjUUa9iga
	7k68uU6VtEpHDJfnDyQCmzWvxDe6HOUd+CiSNrzKh8oMxaCZuCFN13Z78chNNDbhcQPgdN1gKzO
	JNQWX6yrFlwjZ7PUSvhSK6jhLziFoGbgbjnD5FXCMD6KEcfgGnJz5eGQ+90rFPDAYdsUJrqe+u6
	RbHtbKXmW9bUL2Wc5w+wKvcQ2Sg3VFdkpM0kcn7jHj9h8wwfQFEfzmqTgN985d8hDjP9aybx51g
	FYLK+lZJYQSMTbROqdN+2ZfO4TCAjNuUlqaLKYmsCoKpZSB8BvPr//SRUjoDKev49osNkSdkjDi
	m6KqNwlj9IKw2JMFiHZXTXd24EZXblBWknaaoCbAzldhTU3YKuZ+AfKx+sVVuiAnuqmxZjBH7ag
	2KrmGf2z3A0YUimi3EApYJmCdcbykUDxqyvkWQ==
X-Received: by 2002:a05:701b:2705:b0:189:d6bf:7ec7 with SMTP id a92af1059eb24-1b39fe946b5mr6255466c88.19.1794221586094;
        Mon, 09 Nov 2026 02:53:06 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:53:05 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	Chirantan Ekbote <chirantan@chromium.org>,
	Greg Kurz <groug@kaod.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] 9p/virtio: keep a request until the device returns it
Date: Mon,  9 Nov 2026 19:52:49 +0900
Message-ID: <20261109105251.2545764-4-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
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

When the RFLUSH of a pending request arrives, p9_virtio_cancelled()
drops the virtio transport's reference to it. However,
p9_virtio_zc_request() has already dropped that reference if a fatal
signal ended its wait for room in the ring, since the request then never
reached the device. Such a request is still flushed, so the reference is
dropped twice. This can happen when concurrent requests fill the ring
and a waiting process is killed:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:37 at refcount_warn_saturate+0x84/0xd0, CPU#3: dd/293
  Call Trace:
   p9_req_put+0xe5/0x190
   p9_client_zc_rpc+0x52e/0x970
   p9_client_read_once+0x237/0x6c0
   p9_client_read+0x9d/0x140

Additionally, a misbehaving device can return the request after the
RFLUSH, so req_done() writes into the freed request:

  BUG: KASAN: slab-use-after-free in req_done+0x1d9/0x280
  Write of size 4 at addr ffff88800392d758 by task swapper/1/0
  Call Trace:
   req_done+0x1d9/0x280
   vring_interrupt+0x32a/0x540
  The buggy address belongs to the object at ffff88800392d708
   which belongs to the cache p9_req_t of size 136
  The buggy address is located 80 bytes inside of
   freed 136-byte region [ffff88800392d708, ffff88800392d790)

Fix this by dropping the reference in req_done() for a buffer without a
reply as well, since the device can return a flushed request without
one. p9_virtio_cancelled() is no longer needed.

This patch is assisted by Claude Opus 5.5.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/trans_virtio.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 53046668c16b1..68c3457bec401 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -145,6 +145,9 @@ static void req_done(struct virtqueue *vq)
 		if (len) {
 			req->rc.size = len;
 			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
+		} else {
+			/* No reply, so put the ref that p9_client_cb() puts */
+			p9_req_put(chan->client, req);
 		}
 	}
 	spin_unlock_irqrestore(&chan->lock, flags);
@@ -195,13 +198,6 @@ static int p9_virtio_cancel(struct p9_client *client, struct p9_req_t *req)
 	return 1;
 }
 
-/* Reply won't come, so drop req ref */
-static int p9_virtio_cancelled(struct p9_client *client, struct p9_req_t *req)
-{
-	p9_req_put(client, req);
-	return 0;
-}
-
 /**
  * pack_sg_list_p - Just like pack_sg_list. Instead of taking a buffer,
  * this takes a list of pages.
@@ -806,7 +802,6 @@ static struct p9_trans_module p9_virtio_trans = {
 	.request = p9_virtio_request,
 	.zc_request = p9_virtio_zc_request,
 	.cancel = p9_virtio_cancel,
-	.cancelled = p9_virtio_cancelled,
 	/*
 	 * We leave one entry for input and one entry for response
 	 * headers. We also skip one more entry to accommodate, address
-- 
2.56.0

