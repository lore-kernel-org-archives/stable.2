Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448794;
	b=bHTSPoohKVafkqA7KIM5FkWKDsbY/j+Z/nR/C/zqDU0uhAn0MD/P1+Tlk6BzlKATKBqM
	 l+AQUohAnfCc0ctnc1sgy3rvm/jvrbW4AJmbNRphd3Eg73LLE5z1upEleNA3tTMvpFPDo
	 dwX/f7GfdNWAlq3tS8KfCTvbZr3ydhnRz7ShuAAGN1OqyFYMkEzXOaYSBaqExvLj6h4O9
	 YoDqIOBpkG7BC4lZ6ptZ46JjZYm8C0wot0hlVxYwVdeQv4wKelauPtwA6Yk4hgqxZ0VSU
	 WG/VHTyEutoaUB7UXqTrYqabflknKS+rEqM/wYzDa3SHy5PTmW3XlZB3EV0GFIQJUDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5CcGNBxA/7HKGEBtVuQ4LgJyCODKoj4rV1rvYEcwUQg=;
	b=3VSiR59VPSc3atCycSE73ymBZLdUXH3/Uchn6pTxPlOwKfPH83n+SpEEnqa9Pyx+RQ/l
	 OxxieDmrZRHjhiWR5jvyR//K7CBHQaAZ5ENvzoQuTgj8Rsaj7377Dj/DmOfKqGPsUR/YN
	 EiNjoEIUFLVFedWw2tZXmg0kkBk+7pbNS/u+Id5vff0SVR5qRzL+QJS69gNoXwol32aAG
	 tRtE06inU+2ufh6GzRrkd7xEYYKPBEjSoUk7UxfZUYsM/cjtCZXoJv7TZBcQCTVzYymBd
	 nzs3NDoMx8Vdh8NdekrZvGB0R2aFNOybVG2GZS+tuRV34r4AdBlDEEbhhchqGaV6Ukw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Up723cjw;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CDB606A320
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09CDB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Up723cjw
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2366877a91.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792448793; x=1793053593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5CcGNBxA/7HKGEBtVuQ4LgJyCODKoj4rV1rvYEcwUQg=;
        b=Up723cjw7ZF4uTaM7Sl+6te/khmC6ZgFQNI4UBPefoFRPrN5pfMwue6Jawlu7H2D+/
         rbgZ7vd5KvEKdiyJp3suT1HRrX971rXOiFJqTuJvCxvuJ+7WTQV6rqBz0fjKb1FEddcx
         RA9l7girlEbRQwlXJRNAy+lQJhKOVU2CnJjprDKehfBD+XY4mbX74Zn0sB548T6G7Qw/
         Iribcj7akDjzpDimcMbNRVlcrJnHBacqqrUgkXQORIey5ErbudcdG6dzoE1VY/khOEPt
         a4iDr+cwXqCfEZ4YugHUiJCKZpHmerwzEkvO9VBaNFHuJtN8TWrH+b02N7mRoDupMXjm
         +dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448793; x=1793053593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5CcGNBxA/7HKGEBtVuQ4LgJyCODKoj4rV1rvYEcwUQg=;
        b=dauUIQttgg3upzrfyL+FcCxN0ZhOKKet4OSuHae/ujCXYineCx8BX+RVHvUsJzvLGW
         rv9UWY/9Vbo9WsIE7wT6QGw5jutngmq28xQSyeTBnenGz8Ix6r+Tmz4S7DrZjfxUHjmy
         I9xuqxkvyz4AyuD/2WLk7nbSj2L9270GZ2kTN6puA9Xm4uinqPgwWyYQvVhqNQtCo/7s
         eBkFEDMCuPvkrOLvyfg5OFSCmz1vlp+nmOBh/w2nWTgtobLjlQdLbsrko+s6msQThKjk
         fQsAH03xY/vhFWplTcA/sSuy/XD8qJjvO/IdXkngoDKEIRBmV88sD+1qOrkhyGd2sgz5
         rVWA==
X-Forwarded-Encrypted: i=1; AKwUvBy7897Qn0BQKC+bbfKXPQ1pOr/EHA1EWCyHWkMuXKtRIEpUu+e9dZ/Yv4b4ZI8I2S1oABXBT04=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8/j6scb1SvywXfInXpyOHEU4snileXssWMMKd0RjnoYeOltYg
	EDGAasl66MnJZ1l6D5ie18KVAFL1JuRQAtZRy1vgptuCJCMm4Dl0CKC6qNpQmNns9d48zn0jgHy
	ZE46uuQAMueXXjL3hx76slg6ExCfPIUZXlggL
X-Gm-Gg: AYBFou3H2FBbrnvuM8EPRYhq2BgsSoUIQvb7Bl7JbO3/uDFEVmybkLY5VFzPj/26N+n
	vQV4mGJv6J6sV05r1F+E9IcdJet6cuITdAoanTS2klUguAxtuUry0r+PYKxYdP4+x9HpLw+kqtb
	j14KEI2JJuXXEy1AqSbAl+9GcSShuaa0H/C909BANeYlvtjJ98AG+twCBiQXqOBlIq/FVruesHw
	9DGhE1qu5Nr5nfJ4OfCrnavzkg3JGFUf5N/nsPoH7E3dHy8O0pn8+WbuqSZJwH6/yoP8BMhJT6e
	kHtMJzAEKBtzUlos9ckPv8OAJUHigrnZEmeZQV0mpB7d0uYDturDth1CvC16HHdwstIF66LRudk
	6itBclcPHUh6TuLe9kEvmkPOxx99d96i0CzI=
X-Received: by 2002:a17:90b:4c49:b0:3a8:185:cf40 with SMTP id 98e67ed59e1d1-3aceeb95f82mr8443199a91.10.1792448790997;
        Mon, 19 Oct 2026 15:26:30 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acd0dfe366sm3131066a91.3.2026.10.19.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 15:26:30 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 4AC7B401CC;
	Mon, 19 Oct 2026 16:26:30 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 44F77DC0D6A; Mon, 19 Oct 2026 16:26:30 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	wilfred.mallawa@wdc.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net] tls: check the right open record in TLS_TX_MAX_PAYLOAD_LEN
Date: Mon, 19 Oct 2026 16:26:25 -0600
Message-ID: <20261019222626.745408-1-rjethwani@purestorage.com>
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

do_tls_setsockopt_tx_payload_len() refuses to change the record size
limit while a record is open, because both TX paths size the record they
are filling against tx_max_payload_len. It looks for the open record
through tls_sw_ctx_tx(), a plain cast of priv_ctx_tx to
struct tls_sw_context_tx.

On a socket whose TX side is HW offloaded (tx_conf == TLS_HW),
priv_ctx_tx is a struct tls_offload_context_tx, so the load lands in an
unrelated field. In the tested x86_64 configuration, open_rec sits at
offset 144, which aliases sg_tx_data[2].dma_address. TLS never DMA-maps
that table, so the check reads zero even while a record is open. This
alias depends on the structure layouts: other configurations can read a
populated field instead and reject a legitimate call with EBUSY.

The missed check matters:

  setsockopt(SOL_TLS, TLS_TX, ...)          TX offloaded to the NIC
  send(fd, buf, N, MSG_MORE)                leaves an open_record of N
  setsockopt(SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, M), M < N, accepted
  send(fd, buf, len, 0)

tls_push_data() recomputes max_open_record_len from the new limit, so
max_open_record_len - record->len underflows. The next chunk is appended
to the open record regardless of the limit. The record on the wire
exceeds the record_size_limit the peer advertised, which the peer must
answer with a fatal record_overflow alert, exactly what the option exists
to prevent.

Dispatch on tx_conf and look at tls_offload_context_tx::open_record for
TLS_HW. TLS_BASE has no TX context and nothing to check.

Found during review of the TLS core.

Tested on two nodes using mlx5 TLS TX offload. Sending 256 bytes with
MSG_MORE and then lowering the limit returns EBUSY with this patch and is
silently accepted without it. The same sequence on a loopback TLS_SW
socket returns EBUSY either way. With the limit set to 512 before
sending, records carry at most 512 bytes of payload. Without this patch,
lowering the limit after a MSG_MORE send produces a record exceeding the
requested payload limit.

Fixes: 82cb5be6ad64 ("net/tls: support setting the maximum payload size")
Cc: stable@vger.kernel.org
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fbb274287aa5..8f11b8629492 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -837,12 +837,23 @@ static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
 					    unsigned int optlen)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
-	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
 	u16 value;
 	bool tls_13 = ctx->prot_info.version == TLS_1_3_VERSION;
 
-	if (sw_ctx && sw_ctx->open_rec)
-		return -EBUSY;
+	/* Both TX paths size the record they are filling against
+	 * tx_max_payload_len, so refuse to change it under an open record.
+	 * priv_ctx_tx is a different struct for each TX configuration.
+	 */
+	switch (ctx->tx_conf) {
+	case TLS_SW:
+		if (tls_sw_ctx_tx(ctx)->open_rec)
+			return -EBUSY;
+		break;
+	case TLS_HW:
+		if (tls_offload_ctx_tx(ctx)->open_record)
+			return -EBUSY;
+		break;
+	}
 
 	if (sockptr_is_null(optval) || optlen != sizeof(value))
 		return -EINVAL;
-- 
2.50.1

