Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519913;
	b=QMK9b9Ad3kcE3GeI5Q8M8P8gq5X/qAgSfK+RBBfeJYuTFQ5WH63JpBeK3IiTFrkcdhly
	 ZWJPuIQX0g0J4lUYis/iNLwgeN74A1QvhoJeJ1a4sa5vbSo245O4WYNv+4IygU1c2oKkp
	 LQNEhjwySJkGYwCdzGqsLGXatK9SDqn0Wg7Zm75cPDANwPtaLpyw2nHjalJBSMoewdbaM
	 Isrtl5COd39hR3Bf+L+LtlnVlOgthrCa8t41JwZRIEIksP2eU6EcfLcqoR4zE9khavmiz
	 7IgwGYSMCADj+wff1/7rkZ4lxoR7pAqnGYPrUu5lpR1FjR6q7QI/+pPm5dd5vE7edjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BPbhhk5NK1NQUpR+D8C26PMm7Zm7rAAg7WS9+6YlYfo=;
	b=oJbmYcrYcfopqXvaQgt5IyGmwASM8tgrgg84xWJqeoTYxgT4wKHJRDQs4TLhcBGAZI+V
	 BK5ZJOUOJB+qXP77wWmR8DGDi27mmN4ErnzlTl8DQINrqUcwDTLojoKPdxU+wiqUvDPXY
	 0uCXoo/QFF9rd0Pq2NuW4CR9SinmXMv5eBZfM71aFZt3s1xSbONDDM9LcdRc+8Z0gMa3j
	 bt0CsLHSGKcITxvrNGTwizwRBCtspIz+XWy83GzyGAPiQabNH9LtZ81Y8fHt+8tzQKqVP
	 Xr/KVa9RSVJXnKgr/iLgrjUyAS6rcI5d5PB14zKc5+nOAh7xyWSHU2mD2nj2HPeRFWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=ZYZu1zIm;
	arc=none smtp.remote-ip=209.85.222.227
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD37606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 18:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BD37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=ZYZu1zIm
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93ead211f14so106526385a.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792519912; x=1793124712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BPbhhk5NK1NQUpR+D8C26PMm7Zm7rAAg7WS9+6YlYfo=;
        b=ZYZu1zImX9WMX/rFkuJxTpa4CpQD8olv3B6PFMVBfdaPft1oNebP3X9+MP2SAGGnXL
         Ot3cQmbbBEe1c5UegJlKl/3eOj7jax1tCP05sDGd+TrFA/N3KEzpNKJDchXD9fnSOF2J
         uZPv7BddQ8b9jZxQ1vgn8q0m6wuU7ZLn0es0lkRC+a00sG/M8Pog0dJrTy/vVXSx9V3U
         1RY4nFhKJ0p+eIQDM/yG9iKUy9LBiOncZX48EKBBvVAq9SvMgYF969VjyoF4Wtryq8El
         aS94R4Pal5Hf65gMCvBfitLyrO+qozNGlGEDyytBySpUSOdDlrdvKwntNckjGQAZAh9d
         KKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519912; x=1793124712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPbhhk5NK1NQUpR+D8C26PMm7Zm7rAAg7WS9+6YlYfo=;
        b=eGFhlVhk/pPHYSXAyargyoW9oR2sRmTmM7rWYoITnseMH03r/2OdlU68e+dy1/XYdS
         W2ocNXYUby+hm2SpxcRpmVyIyAdGjMn/ftCflFcv5RCPJ5NYefhiqMsci48F+Hlf7aMV
         meLg4bOBHEKMhiwpsEpczUW8qfCrMroEiPzz50QSAcxQY8OPJCSmEGviG+z1DNDpUw7P
         SqvZLHj9T0wqqcBcrcHHGGTUeAOiARomnCW4gOSMR9l/wgpp8hmEb5FBjf/ozcx3GSdl
         P05YEU9Gqssdh6gjdaJdc0phZ6A2iPq/2XFxMkvws3sJVxF9O5EOyuv5QGM8haa8UpF1
         Av0g==
X-Forwarded-Encrypted: i=1; AKwUvBwiER1zIDDPu8UUfOvIdVg/14wAxoP/IPR9AJ1CGEmpp4mhgpQpK8p//QDKzXa5GhXT0csfkD4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxI6n8T/5dMze1C4G78cafxpK9POPb4hWQx6HL/3SdidIW/KTU
	PvQtA2YnhvO1updCgW5kdyA7oiaHhp06oFVe/kAQc0MCYY9EpMAH5HPMEvaNKdTkvgk7mL6CRGr
	dWfNjSqE7oX2s8uoRhadCG8TpZzQvzdZ/rpaZZZB4bPSmGVniQqLD
X-Gm-Gg: AYBFou2z2tF/uu3ErNwUcaOAmpD/0huy5Yy6teetrdfrBjwLQSaieUYqM4X5miVhZdn
	oD8EqgRAKjFZytjlxBZiZz+BQpMbPS/ff79SLjFdZ93+ypIymWB1MyBAttmWE6oZ964Qq9LJGfn
	GFx+yCIDQDFl8Ej2de+tLjmMi3cSedfkmXv/v8WXtPeeVWg4Ls+yiMdysNGc3aWb1ZwTV+HchXn
	zBmgolBIz1zHlTZGgcAuGPGIqmpzBOp7ipxeqZ+tCrbsOXvdZt1eToUsUTclHF2dYu241gwTAVN
	ii6l8WxlHlcC7SVsjnzXPeQ3BEbXD9cIAfDc3KGe9OdafB6Gw828Jzvhlr9RrnLtethuC8gDy/e
	aR/dR+zhtQIWJpjve/kQ=
X-Received: by 2002:a05:620a:4441:b0:93e:7ec5:2cfe with SMTP id af79cd13be357-93f57f8fb91mr5540985a.28.1792519911865;
        Tue, 20 Oct 2026 11:11:51 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93f56e1d0ebsm7756285a.18.2026.10.20.11.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:11:51 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 3D9E2401E4;
	Tue, 20 Oct 2026 12:11:51 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 38884DC0D46; Tue, 20 Oct 2026 12:11:51 -0600 (MDT)
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
	Aviad Yehezkel <aviadye@mellanox.com>,
	Ilya Lesokhin <ilyal@mellanox.com>,
	Boris Pismenny <borisp@mellanox.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] tls: only install push_pending_record for a TX context
Date: Tue, 20 Oct 2026 12:11:44 -0600
Message-ID: <20261020181147.939575-1-rjethwani@purestorage.com>
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

