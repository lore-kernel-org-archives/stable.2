Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657419;
	b=LarwBbrl6sR/aw9VgtE4UmuCaOKZ431RJBRXYKeUJ3y3TClLt/hOO9hIfItqPJOX+QRg
	 qSV5ajpJ7/Rc7B0EYaQHX8hvfwYqGbMEkzyIdXPHLry8YxnXJS5UVml8ZBKDLqAJdgaCB
	 LD7/I3FCCEya2G9E2a/RFfj/Fn8W9Sko5ZUOq99BYZkwQ5SKRwMUcKB6y9+xcduhpR0n1
	 9ChCOv1PkbTSkqnb65hIkuvGNuTN6Fb1PioVw4sBJgjzWiMzoV33WVHRy7XsQJM09wXUn
	 WwZMVynQm8vfkwoLzyr7Z9H/iMUnsATVt0R9TJQ6jY52FRyf7Qo+8pXniNpCJpNsQgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8RBbCa63dwXOVAqsUPjoksqPUE7AWBjyhR2+RK9ZaCA=;
	b=Cbye0K0U8hnVdGI68m/gdfdSuLKyXHH2lrJT5mN6/yBnT+rqcHxga+4zcLaNv3/a+jRL
	 3hu6De+koHzfPC1kAjvb56iU8jbMJ5Jx2x66+ygsq7hKz/SPhNmI+ZpUSpKSn/PPFGdfE
	 6dW9ON7Sg25GcjrgfjNqrsaVBoYSznU1mRYL06kfCWrICIqNUQ0JyhKAmngX9e9U4AP+x
	 2OSFHnPpyWS23xwx8z4B2N8lJUzb2AVv4SqZYQF1DUh/Dv12sVlJDb88J+npRUGPcPzFr
	 nORvJN4X54uyWTUM+l0EudlQjelEqZNcaiWJ26994VPLAGkP9jwGGaESOvr3RujxCDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=COGCdQyM;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A2606A688
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 648A2606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=COGCdQyM
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b405d8f1cfso3272701a91.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795657419; x=1796262219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RBbCa63dwXOVAqsUPjoksqPUE7AWBjyhR2+RK9ZaCA=;
        b=COGCdQyMeeB9tUu0XWNC9pMW4X4g8s1wn1d9SERW1yVhQjrX5wSKT9a3TEaK4N6YBb
         QBP/eEq4rAp3e1V41Y4+JwpFi5f+AYJ5Zmf4IfttLnOTBmXGG2CXTbDJifGPuGaVijfT
         PgXxzj7A2EoDe0TU7dnIGWz/me1hwFH+fu2CsyFe2nkbMvhEDeHr7JjsfLUmgIyUHF+V
         ixvaAPXjM62IhH/+ERn9ORI5NkxroRAgC/F85zFJ48yIOagOX6P2rvZVk03B4Qb5KpDg
         kVJLqglIjHmlJB7leSkXN69vkfN72C+v4SMVNdezm8z6mliCZ3Lt5SlfQg5iAme6AWBx
         TERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795657419; x=1796262219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8RBbCa63dwXOVAqsUPjoksqPUE7AWBjyhR2+RK9ZaCA=;
        b=yHt7IF5ByZDWmyp7+p5GuosG0ze74jWu5aSSAgDty+N7pZrSYiStRfQMtOZzXuTkS7
         fB1bDq7AhZm4qAuKnCou829wOC5kiyDot2JK4lrp/g4XyvUkCbsy/GauIgeu7VaNeEjV
         RZil/Ih+7dWhR9U+dgDvQiGfnirZshcZZ9dTX1XAG3W+B7zMJbYpCrcl9JReTAVUUuzW
         VwMzcynE2F5AGIXp/KDFsdBq0x3vW7mN7oWxDdi/JBG6FIPBELFPgeP0+ruVHcF+P805
         VqrKuSfa1cXsD87Tz0L9c43ESTUi+fKNwSakOZj1XQuyYTv7lM/TyAv/Ly5SigmXpM3j
         gfnQ==
X-Forwarded-Encrypted: i=1; AL+hErEb1eFzB8b6GoonVRYmsHLuXmGTUTvYpDgli7Q3QLURHuuJg73Z8+8hlclzQezZ8vPZRozePo8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PRscHQuxGn/h1Ga2yXQWPh7Efdq02QSZqu++Yb47e/Zaiu/3s
	y1bBHFMWHD0QvfR1ZAzltxwaU8sZi+azFPS+kX9waUPBWlQ7Q5zlBw5YEY3qPEFIbkjP90wn07k
	QPALEZO/c0vVos/TS8TqZezs81jq4gekX9/a7
X-Gm-Gg: AZFdTZcQZ1QsXuNvSilrfK8vjWBMYkKUVE0AmIeuqgnGC6/+UqbjA5B6puN7Bv2aHO+
	+PnwF+0ASnUTJY5QF9c7OtnJQuQ9IK0p1282VN+PhEzRvNFaUIr+hdrUVQhkwqcTohI0lNgbkL0
	Dy05pHgwk1Aoc28WA3pwR8mbjKXEQciiBddtYgmAyaQQzTXqanf5mVrTVXO/xXL8yVxm3kDEa77
	ewKtFWDzHcqADYRp2n6qzQ1ZtDsSsCpYkIJ7k+1fplGH6CpqOTolc9xUesAOoRRGcIdT0uVMZI+
	GULmZmSo+Y7rrqbQYvuaJQsSh/aaq+esGUxMJNmJjI8KcClYuS8CwGPmChBoi6xGl+y6tpKEg4E
	D8QtEjoE3PvFOktrI5t46tAg7hJm4ef0OsEg=
X-Received: by 2002:a17:90b:35c2:b0:3b3:cf61:dc65 with SMTP id 98e67ed59e1d1-3b41c8debf5mr17818294a91.23.1795657418504;
        Wed, 25 Nov 2026 17:43:38 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b40625d683sm14763620a91.3.2026.11.25.17.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:43:38 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 943A5400B7;
	Wed, 25 Nov 2026 18:43:37 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 916BBDC0C28; Wed, 25 Nov 2026 18:43:37 -0700 (MST)
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
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Boris Pismenny <borisp@mellanox.com>
Subject: [PATCH net v7 3/3] tls: use TLS_RX_DEV_CLOSED to skip RX tls_dev_del in device-down
Date: Wed, 25 Nov 2026 18:42:44 -0700
Message-ID: <20261126014327.1638133-4-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126014327.1638133-1-rjethwani@purestorage.com>
References: <20261126014327.1638133-1-rjethwani@purestorage.com>
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

tls_device_down() calls the RX tls_dev_del only if rx_conf is TLS_HW and
TLS_RX_DEV_CLOSED is clear. do_tls_setsockopt_conf() sets rx_conf after
tls_set_device_offload_rx() has released device_offload_lock, so
tls_device_down() can see a context whose RX tls_dev_add() succeeded
with rx_conf not yet TLS_HW, skip the RX tls_dev_del and leak the driver
state. rx_conf also shares a byte with tx_conf, which is written without
device_offload_lock.

TLS_RX_DEV_CLOSED currently means that tls_device_offload_cleanup_rx()
has already released the RX driver state. Extend it to also cover RX
state that was never installed: set it in tls_ctx_create(), clear it in
tls_set_device_offload_rx() after a successful tls_device_attach(), while
still holding device_offload_lock, and set it after every RX
tls_dev_del, including in tls_device_down() and when
tls_device_offload_cleanup_rx() also drops the netdev. tls_device_down()
then checks only this bit and no longer reads rx_conf.

Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Cc: stable@vger.kernel.org
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    | 8 ++++----
 net/tls/tls_device.c | 9 +++++----
 net/tls/tls_main.c   | 1 +
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index f9540910b2e3..53768fe11917 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -188,10 +188,10 @@ enum tls_context_flags {
 	 * to be atomic.
 	 */
 	TLS_TX_SYNC_SCHED = 1,
-	/* tls_dev_del was called for the RX side, device state was released,
-	 * but tls_ctx->netdev might still be kept, because TX-side driver
-	 * resources might not be released yet. Used to prevent the second
-	 * tls_dev_del call in tls_device_down if it happens simultaneously.
+	/* No RX device state is installed. Set at context creation and after
+	 * RX tls_dev_del, cleared after a successful RX tls_dev_add. Prevents
+	 * deleting absent or already released RX state while ctx->netdev may
+	 * still be kept for TX.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
 	/* tls_device_down() replaced tls_validate_xmit_skb(). */
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 3473299b16de..3aac6a45188b 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1282,6 +1282,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto free_sw_resources;
 
 	tls_device_attach(ctx, sk, netdev);
+	clear_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
@@ -1314,12 +1315,11 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 
 	netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
 					TLS_OFFLOAD_CTX_DIR_RX);
+	set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
 
 	if (tls_ctx->tx_conf != TLS_HW) {
 		dev_put(netdev);
 		rcu_assign_pointer(tls_ctx->netdev, NULL);
-	} else {
-		set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
 	}
 out:
 	up_read(&device_offload_lock);
@@ -1380,10 +1380,11 @@ static int tls_device_down(struct net_device *netdev)
 		if (test_bit(TLS_TX_DEV_DOWN, &ctx->flags))
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_TX);
-		if (ctx->rx_conf == TLS_HW &&
-		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
+		if (!test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_RX);
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+		}
 
 		dev_put(netdev);
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fa71c75c2861..54d851df0c58 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -935,6 +935,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 		return NULL;
 
 	mutex_init(&ctx->tx_lock);
+	set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
-- 
2.50.1

