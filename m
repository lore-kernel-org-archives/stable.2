Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294587;
	b=m6J3JIU5y+sIZaUG0EF1wiUxCeyBNmgblk6MdNNYpoffUZRRRN28zCVjz+XdilHV9+21
	 jR8n1rSN4SLREE1Co4I+B7XZ1QziqHnaiymB21f/oXlGFsVoUV8CMywWVqq8fg39TL5XH
	 CGAjVXRxYQuYmGn5C3+tm8d8QdoKuDZq3pgKNO5KipKTf3aqXprCTKFeK9r7+d3XSeglB
	 p/sUW8893ZQfDxRnNztfpQioN9fGZSpbjAU+x5GxjfuNcD68upKNjECn/9p5ZOn88J+2c
	 vZthwOw+VDKx0jyLaKc3a4TKYTLepuD5xloxkCyHl+lVvFf5G9WZalmsg8hALBXQMLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2q8aiyZNu7WsOVILgK8CuohQb1g9BJN+Pm1TJ57mfvo=;
	b=u2t1gbJMqRQZkQ+/oqPYAtAd8bo6VHO01+dsxNKRWpLQvEuaNtYMTOPbLACclFWTOZJ4
	 lju5FAqd+b6ArmN2ew7ruTIhq0WIPPI7Oa4vfn6kvgkwjiTnV+ZAQSLdAVQBA+MfY5w/H
	 IrHNG++BIyYjYXQ+m54SzzstvBIDzNWX074yqmRo2qFCLwevwMZSpxqC6b+AwQEPKtlAC
	 30scHLECsHcR76/uE4tAKL8Zptsi4ElF5xmnmS6i+3NgghPpMPQsEdwMjjNwLgzv1MriK
	 SczEn3ucCPyTewrhT06CVF16g8Iz0ysQNiwIMK3ztdXEFnQTSHSwtqHRmk5+abPqgvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=KWf1cPuI;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D41606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7D41606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=KWf1cPuI
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1503625a12.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793294586; x=1793899386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2q8aiyZNu7WsOVILgK8CuohQb1g9BJN+Pm1TJ57mfvo=;
        b=KWf1cPuIggkZn92EwTkl/KvJ6hwWix4GVHBZ+DLMKXfuTvxLl70DB/JYAxMQ0/ScnM
         FTs5qopv8mGr2ohtYJu1dvBeEqsP+8CWgutFKJuKcj+KkfFzP1rh6GLmEUZjLJaBuTKT
         2DX2hw69+zlhM46HvRseXsqq6bzUMpLmLAOhYE++1G5Qs+0ACJ6ZiYACTI1jWL/RQLMb
         wCXNU4GgMkXQ5J6eyO2kcwYAVA5gU7o6exSV+kcU2OzwI7NmDuWiEtEoqK94jElMUgtB
         SER1e+WkA3Os3koIdvKdLyqJGojOmORnPTe2L5bknuryOY2yRt03/7Lz6EwgbI0RBdgq
         4Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294586; x=1793899386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2q8aiyZNu7WsOVILgK8CuohQb1g9BJN+Pm1TJ57mfvo=;
        b=SKFLYI+mvJRUeI6m/XDvHwe5z1ZCrTrb+6MI8kOIjbXAbPfp3U3vkOnJ8bqga3X9V1
         mvkQ9K2/lNwZbfK4Z1270wh0tyswikWqqbr3BZkhnB4YNoJYisTy429A50cWkGr1k2pY
         +6u2CJuDQ2YzCy7Nf6FFjfieUjEpg4yauuqjjnj4mbB0MqPVETmSNV563lK9ccyo2PXM
         XJUz0Um8DTzt6M9+NKMoQ2n9g9+ctJ2Yji8LW511n9Y7hshf/UGsG7a3JCH73+yJbdFF
         Mpw74t8m0BD0ENvtrZfURrExmm+yBpLpcd+KuhgIM2/uzHdU2ysgL3nftu6knbyBaxnr
         7x0w==
X-Forwarded-Encrypted: i=1; AKwUvBxp2EZW2i/1WP7olNbA0VIgVAe34WCe23kyZVa0Z5xIKhoOIhUcsxbOPVAqnTCQsr1M6fZkTlw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUPnTv6PLMIukEsJ70jrAaiXvH6g9H+2OQZu7fYbKmXvqoa5SV
	QNGM9nTH/MV9WUaXYXHsd/qnD7JiI4GbfLZ5OZTcWM5KAXwci23byI7tr5WW1sCKImtbg1KvhKc
	jvPJ5XmTIGnnkNZiC2AvYNKuXR06nUOesfqmO
X-Gm-Gg: AYBFou2R4MNgDADdAHgjYp9XbrJ0fz4twnvL7BeKaR1TTlJj60H8V4/Vfv0T0I2aHBK
	berHUZ0RZ+QqTTsjETuGKTXF0CmsCzUP21lWJxW8J3J1iFHVXH9SDLDQfiYuOztESseMtxziHc1
	pLI5pI1OSgHT6gSLNL6lbK3nvsiGsPsAVnVPPEwKhUQDJGW9VfNZ3kb621VKPsy2DCtV/tnAHWT
	+du7CZHDVW5rI0QdmHqrK980hdZfQBMV+G776jg66zdKc19KIGMvgPB//j1VPGPmcBVhB+o9Irh
	iuc1pXyL0Bicpxt2diEshfOxuJ6mBrS9C6rfktWbfaYRqp9iMIY6GJwlOOeO5nArX+w65BooMUZ
	wAfHZO2Ap7zGQ6iOKrmvOUKGnCtw2JBezzdM=
X-Received: by 2002:a17:90b:3811:b0:3ad:ce34:f63c with SMTP id 98e67ed59e1d1-3ae582279a3mr5438437a91.30.1793294585949;
        Thu, 29 Oct 2026 10:23:05 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae85f56a85sm24253a91.1.2026.10.29.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:23:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 32BA743622;
	Thu, 29 Oct 2026 11:23:05 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 2D28ADCE139; Thu, 29 Oct 2026 11:23:05 -0600 (MDT)
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
	Ilya Lesokhin <ilyal@mellanox.com>,
	Boris Pismenny <borisp@mellanox.com>,
	Aviad Yehezkel <aviadye@mellanox.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/2] tls: only install push_pending_record for a TX context
Date: Thu, 29 Oct 2026 11:23:00 -0600
Message-ID: <20261029172302.2944955-1-rjethwani@purestorage.com>
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
index 771e02bff519..23eb94d9da6e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2594,7 +2594,8 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 		}
 	}
 
-	ctx->push_pending_record = tls_sw_push_pending_record;
+	if (tx)
+		ctx->push_pending_record = tls_sw_push_pending_record;
 
 	/* setkey is the last operation that could fail during a
 	 * rekey. if it succeeds, we can start modifying the
-- 
2.50.1

