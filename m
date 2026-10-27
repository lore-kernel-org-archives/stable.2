Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121345;
	b=XxnNb9RmGyblfcO6ucIW44hmkojkGk04M0/bgcCG83VEPmnLVRbX5X7J9BQnrHo41HEu
	 vTWWu0DEb2x8MNZeVQcEuPbph6eZBS3ViE8AW1K6rXaOrIZIn8T53tyJKW0KN+vtrmxTS
	 4+xVcQjcOnpR/fVbUCf5TA2f8chkXp9ndZyvPxL/NyYGkThNxSRdXvnOHu28YhJ0RWJPe
	 pCPmjxbvi4VhwP+GV/D1TJD2IFdton/pNLdTGi9rAxDbgR42jz33oN1oeSh4kU8U4aEuG
	 nF+To/FrKVr4LIVyJXPBRJrfMEsDG90rwgyAJOEmdx3G0SFKQVFbBx+yemeTjw/ebtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BPbhhk5NK1NQUpR+D8C26PMm7Zm7rAAg7WS9+6YlYfo=;
	b=GmCnx5OsbAlY32bhMsRz6yMKnt6AILpKnHZG5eUDikeMzCE7scBT/N86dsM9M3Uiv577
	 2/SgkqklOq6Ra6fKoEvyzKiRusA2EJ1ruXaSmFBmAryONB8grqnHSFEKuD5wXdrMroDxb
	 maL/z1Pb3IWwCMqHkE0jkiQIkgpBhSuN6dqDiSWNY4HxPmjhOyyUa5PLOpZZ7HKfFxZW2
	 9101yzSSUTlxP14EBTNgMnhnoeawEyqC3eNBVkA9xxRBAXOGd2yfpjq3dfQJG55qepKbB
	 oiiMeNM4QLnfabKCf4jaSNhWOzPSoxy7eW9Uc0/jNDksDn1wm9SnK0GGfrzP9udG4Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b="M45/9I4w";
	arc=none smtp.remote-ip=209.85.128.98
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92510606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 17:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92510606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=M45/9I4w
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so7838505e9.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793121343; x=1793726143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BPbhhk5NK1NQUpR+D8C26PMm7Zm7rAAg7WS9+6YlYfo=;
        b=M45/9I4w0d9YCytxCe5LhgJSicqsUlutj91GfE6p1YPTCTfgOP0DAMAK6PJ+nZ1b2b
         fcN6vVeuK+cr0tadZRZ6LuxCZ7qkzFTR/nzfkp49leM6wRz1shtvOAOzAGy3Ixz8tsPv
         jfFjwbx23NRdpP9xtmoMw/15HAk979MDx5ZcoiO0mqA+nuzPnv5gIG2p/N/1JTLoNYvb
         V/yaZ4WY4hml+tKsUgw9P+G7yCpP7O+a5mYk4IlybbGDxw3UXAzjZ6AXD/djDZRLedOw
         ylFggX0xIMY1cVJRPULlVBNI/yk9LaPOE+POAi62Dzpen0poA9BCjej5+UBz+uwULMvx
         9DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121343; x=1793726143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPbhhk5NK1NQUpR+D8C26PMm7Zm7rAAg7WS9+6YlYfo=;
        b=r9Ovhj/pivlx0BeYJUJ79oiUkXd4V2GrI9t28azZCdXHswPBE0jgCk2WSigK4267+S
         6slr+xZrbUts53nG/CT2SDA4ahl6d4Huus9ToY1G1xM0kvPeX4EF8M0F/0fsYC/BYwjm
         AfY2zo6rh8HOvuIUxvQUkO+k0056dJ7FP6VjY38Qaor0qV9finvPAdcLUEdcegvYVOkZ
         T99FCBsGI/5I6VrJ2xX1LnQDopvVXiEkh4aeibb5fhoCcL3CtJsdQIwJKnUNCyf7PqHH
         gLbIx0HXoiaDJg2ObL+uv5rCTXmLr7qdwHzDxTgSxtT+P0JwtlVHtC0EWpps+UZkEA85
         nYTw==
X-Forwarded-Encrypted: i=1; AKwUvByu5hNA1BBW9ucw4vyJIk8LDb3RKKZoxiCjSGws6w2u9/6RxyS+tpS47pku+S8af2XEc7u4neo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIg5vPIjAKqmvpE2TrYkI35ijJHZPJrPpJuHERHVyd3g0P5xeXs
	FMa9J69CqCoF07o8ILSfXTliAW1gxdsmcyzAlJxvVfeys92s8TKWKLg5im8uGfSHoVLAE75Pa6r
	DOa8/Jbllg7mtSLhSlZjWJrz53cDi2vEQuohR
X-Gm-Gg: AYBFou0hCxG6nICuGppiYiaDP1AbpLv1mHLswKbUfMUiGLGGxLgKx4QAwnWz/5IJBs7
	jQP404H/+iqCbbf6pIDsMonBO/Ggg/s6dFliTsJLGd/9dksHFpKU1CXcK5RoNLb8SEa7/fcpEiC
	mAJ5po2ZYMiyjeGsS7267xKDbPcVk/r28qWPgq4J/FNgloV9wGqU0FuysyNCnv5b6I+qIjaKJTv
	Ult4W4R0IYCoLbZlaML5K+rgkOyoy18WVt/0htuLgbEQJjeAICboXVIFIFfPGV2MbqDwc2xehdY
	JgYpr1NbV1uu3QmLlXT3//NXyM6NHNWndADE/xKe1seWFmBxlKoYTW6cjiGNtVuSYnQM6iNaLYU
	pD8jk2OUvpZoCbjb3/cvtAD06ydE6TE2dJyU=
X-Received: by 2002:a05:600c:c049:b0:4a1:9c71:9f17 with SMTP id 5b1f17b1804b1-4a7c100b0c7mr52810595e9.9.1793121342804;
        Tue, 27 Oct 2026 10:15:42 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4a931902eb8sm212955e9.14.2026.10.27.10.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:15:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 2C3804013C;
	Tue, 27 Oct 2026 11:15:41 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 2667BDCE124; Tue, 27 Oct 2026 11:15:41 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	stable@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Boris Pismenny <borisp@mellanox.com>,
	Ilya Lesokhin <ilyal@mellanox.com>,
	Aviad Yehezkel <aviadye@mellanox.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] tls: only install push_pending_record for a TX context
Date: Tue, 27 Oct 2026 11:15:33 -0600
Message-ID: <20261027171537.2317025-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

tls_set_sw_offload() assigns ctx->push_pending_record for both
directions, but the hook is a TX-side dispatcher. On a socket whose TX
side is HW offloaded, tls_set_device_offload() installs
tls_device_push_pending_record(); any later TLS_RX setsockopt
overwrites it with tls_sw_push_pending_record(), because
tls_set_device_offload_rx() itself calls tls_set_sw_offload(sk, 0, NULL)
for the software half of a successful HW RX offload, and so does the
fallback when the RX offload is declined (NIC with TX-only offload,
tls_dev_add() failure).

From then on tls_handle_open_record() (a TLS_SET_RECORD_TYPE cmsg after
a MSG_MORE send, or the close path with a pending writer) runs
tls_sw_push_pending_record() against priv_ctx_tx, which is a
struct tls_offload_context_tx, not a struct tls_sw_context_tx, and
reads open_rec from inside the offload context. On x86_64 without lock
debugging that field overlays sg_tx_data[2].dma_address, which is never
set, so the push is silently skipped and the data buffered by the
MSG_MORE send is later sent under the cmsg's record type, e.g.
application data in a handshake or alert record. Enabling
CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_LOCK_ALLOC and CONFIG_LOCKDEP, but
not CONFIG_LOCK_STAT, in the tested x86_64 configuration moves open_rec
over sg_tx_data[5].page_link. Once populated, its page pointer and
scatterlist flags are interpreted as a tls_rec pointer and dereferenced
while reading msg_plaintext.sg.size.

Only set the hook when initialising the TX side.

Found by code review while developing TLS 1.3 HW offload rekey support.

Tested with HW TLS TX and RX offload on Mellanox ConnectX-6 Dx (Crypto
Enabled): after setting TLS_RX, send() "AAAA" with MSG_MORE, then
sendmsg() "BBBB" with a TLS_SET_RECORD_TYPE cmsg for a handshake
record. Without this patch the peer receives a single handshake record
"AAAABBBB"; with it, an application data record "AAAA" followed by a
handshake record "BBBB".

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_sw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1ad31986cf2..235b868facfa 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2591,7 +2591,8 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 		}
 	}
 
-	ctx->push_pending_record = tls_sw_push_pending_record;
+	if (tx)
+		ctx->push_pending_record = tls_sw_push_pending_record;
 
 	/* setkey is the last operation that could fail during a
 	 * rekey. if it succeeds, we can start modifying the
-- 
2.50.1

