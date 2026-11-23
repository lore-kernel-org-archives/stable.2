Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472992;
	b=rEtZf+X142UAfeGx6+21GI5opvN0Lqiz+P2XYySIzqhfQgZhcD+fJywM+zgLM7g9iKL2
	 YPDEYVwVq00Bgih7hPpWj9zdMhCnjBHkhuVg1YgxoxuQaylyiNBZELcvx4ranPK9saoL3
	 8DwGTMi7bshN55heB8pRg68hMhibvxP8QHjzItefMeWuofJCIDGTIF412cr8BHnkaW990
	 HvGNMQYCBZ6wnSSQLk8YC1FyJdxwAAj4zUu2LogQlYjuHF6hA78hrpDKFDAO7UEe5MvrO
	 d0T/f+twgGx7jFsD1rKFZ+uCLEN4r+mtZPYvqQcMdOmHxnUI95SasuSPg2WPW2MmS2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H2vxAWoYWHp6UyKnUQXbx7unIB0YZxuVIcKrameyVgM=;
	b=hC+qJXwxH+hVPHwrFxRYBtLYEDWgTHCWQ1sKawW51ErdKFfbMHNv7BJ5q6qnH+wKe8RG
	 wktkPQG/c9o1yO5YIHPMzFsjgY8W4mEqnI1S1Cw+36g4mLIl/ORW5B5o+PK/w79DZiH+W
	 HDtXCs1JXYuUF+s4fFkmIFDwQ17N1KXm0Pcm+P/elXOZuYXy2zRn74X+O/ttwwQ9C5yxh
	 z4Cob7vmqGYhJ/ZlGCtJgC1GHRcEbhJfWuDQtqoXfD6syGH1auBDdOGstm5yjOLGoGa7s
	 jhw9pY7ejZCaP/YzY+1gQq01jmvWHA55AkZ9z2zDVCRpdVbo6e1q84R52rjJPQDKPuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=EEauRH0X;
	arc=none smtp.remote-ip=209.85.217.98
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127B606A333
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2127B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=EEauRH0X
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-7d6a6776719so2332703137.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795472991; x=1796077791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H2vxAWoYWHp6UyKnUQXbx7unIB0YZxuVIcKrameyVgM=;
        b=EEauRH0XZJQvGZczsRF6XoVb37PsS0/4gNMc0EzE1MZMqIaE2kNv259tfgRNkN7jdH
         HnUKMimueeuQ7DX357m0LEvAO1ds7kUZleVD3svjXxcPaXcV3QMIWZpvDYvTJutQ5n8S
         wN+H/5xRu9IeL3xexuSUHvcHO+yR5qgYOWjnXbm52wKNmOSesMvWDW8ZzF+Ri6n6510t
         ncMUzOu+QG9KM+O0AggcU7TalZj1DRGSMpEljnvaSKAIueymHBpWYkS5nocbtbIlaKZ4
         ssf1ufIPfEtdHFubBp0Sd2FCmLauF5O+aMnRJvuPNa/KXxhek7DMwXPC0iIX9HEpXwdO
         X3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472991; x=1796077791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H2vxAWoYWHp6UyKnUQXbx7unIB0YZxuVIcKrameyVgM=;
        b=LW0ByCG3aI+3ceP0/C/lWLB2CsrtADCu054bZmV3nbdc5ckHCGWvBN6CMdxS10mfAZ
         XvSuJrkhPFPFmegSpo2UQCzjQvH7GhD4f7ouWHNS73hPkCsPUMrEWfscl7rFVil83Xwu
         Xprlxk3pSP5uNl8cAW4yhGYpqhHNv8JMFtYAUiMCB5tdb7rjQUjCu/2sCHNHkv9GTeL5
         cYiiBJmsw+e2vWArBjPevA+ZXdp4kXwfUJzo2FiF8OMM3aGqJvAQ7R6sUEJRd2VPf0xt
         eLULw8XMhB48Fz1FlIOd/cycLR/EiKmSgV5ni9edn58P8jLKjubhFKZR784RqN8HF48T
         t1iw==
X-Forwarded-Encrypted: i=1; AL+hErGpepLUztr+dzoUB8dK7BCoC+xtDCdUXP0fPIrxSFHQwFYr4hQJdLfANDv3tYfCv/nm8e+CGXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fMuPXThSxIidrY4P29FnhPlZwtL4TWnBlJxOoO2XxdeTI7l8/
	ux/HXPbCZ5RV+uK6QfuZViBLPXM/aEFp/11+i2pUg3UlhDjZ3bgPUHEmBAKux/mxUymUm8dUCSb
	v67YdXplMxET5sv2TaLAHPKRGWZwmDaNqzRvDadVkD6sa6WnGGDBN
X-Gm-Gg: AZFdTZfPISFUiOyNWss73P3XXukY0Ojp7tvgyLPQfaMnwr4VMWLAvT64w8k+xJk4QJT
	JXzl8ZGJ0wktiVXO2nN0k/yyaW8xRmLvapn7hlxcgq9bcYZiZte5sQ56k7cS4Zoq42e+JLl89Eo
	E9g2NB9GnHrR2Zkwr/nxnLmbKPtHKEF6nmUus+p9HVpHwzYhLXMFIBzyk9lMev+2xb4jfGwe71H
	Au7D3HIJ7okWk9OuvTMBHSBkAN6IlxXt/HgVfvgdWCS5Kha9ldSO+cM/fJuYg1lm8wZ5GyQmcD5
	aOasfx/Us4oD4VuI2vYqDG0edTdkh3Rg3oCjoAfo7pqmWIxjTc7d2jE20eAObsDI07/kpWcw3qd
	8B0mmGkz9spanSPKazMfg
X-Received: by 2002:a05:6102:448b:b0:7c1:7ca9:94bf with SMTP id ada2fe7eead31-7d739462bc5mr7097568137.19.1795472991005;
        Mon, 23 Nov 2026 14:29:51 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-99e6e120c2esm1306669241.10.2026.11.23.14.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:29:51 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 6156F40124;
	Mon, 23 Nov 2026 15:29:50 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 5DEDEDC0D02; Mon, 23 Nov 2026 15:29:50 -0700 (MST)
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
	Tariq Toukan <tariqt@nvidia.com>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Boris Pismenny <borisp@mellanox.com>
Subject: [PATCH net v6 2/2] tls: restrict device-down TX fallback to hardware TX sockets
Date: Mon, 23 Nov 2026 15:29:44 -0700
Message-ID: <20261123222947.1014041-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261123222947.1014041-1-rjethwani@purestorage.com>
References: <20261123222947.1014041-1-rjethwani@purestorage.com>
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

tls_device_down() switches every offloaded TLS context associated with
the device to the TX software fallback, including hardware-RX sockets
without TX offload (RX-only, or software TLS TX). The fallback expects
a hardware TX context in priv_ctx_tx, so such a socket can crash when
transmitting a payload skb. In the oops below, a payload skb queued on
the neighbour entry during the down/up cycle was flushed on ARP reply:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  tls_sw_fallback+0x11b/0x450
  validate_xmit_skb.isra.0+0x14f/0x420
  __dev_queue_xmit+0x5e8/0xf30

Device-down teardown cannot key on tx_conf/rx_conf: setup publishes
them after releasing device_offload_lock, and they share a byte written
without that lock. Device-down can therefore observe configuration
fields that do not yet reflect a successful tls_dev_add() and skip the
required tls_dev_del(), leaking driver state. Key it on installed
driver state instead.

TX: switch the validator only if it is tls_validate_xmit_skb(), record
the switch in TLS_TX_DEV_DOWN, and call TX tls_dev_del only when that
bit is set. tls_set_device_offload() now publishes the validator under
device_offload_lock; otherwise device-down could run between
tls_device_attach() and the store, skip tls_dev_del (leaking driver
state), and setup would then install the hardware validator on a
torn-down attachment. Contexts never return to the active list, so the
bit needs no reset.

RX: TLS_RX_DEV_CLOSED now means "no RX driver state installed". Set it
at context creation and after every RX tls_dev_del, and clear it after
a successful RX tls_dev_add under device_offload_lock. This avoids
deleting absent RX state and reading tx_conf/rx_conf while their
shared byte is updated.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled): the crash reproduces
without this patch; with it, an RX-only socket survives interface
down/up and keeps receiving TLS records.

c55dcdd435aa made the fallback switch unconditional; 4799ac81e52a keyed
teardown on tx_conf/rx_conf.

Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Cc: stable@vger.kernel.org
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    | 10 ++++++----
 net/tls/tls_device.c | 20 +++++++++++++-------
 net/tls/tls_main.c   |  1 +
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 0b001b8ab1c3..faaeffd9981b 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -188,12 +188,14 @@ enum tls_context_flags {
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
+	/* Records the TX fallback switch for device-down's cleanup loop. */
+	TLS_TX_DEV_DOWN = 3,
 };
 
 struct cipher_context {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index e4e675243779..0af2514b883c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1195,13 +1195,13 @@ int tls_set_device_offload(struct sock *sk)
 		goto release_lock;
 
 	tls_device_attach(ctx, sk, netdev);
-	up_read(&device_offload_lock);
 
 	/* following this assignment tls_is_skb_tx_device_offloaded
 	 * will return true and the context might be accessed
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
+	up_read(&device_offload_lock);
 	dev_put(netdev);
 
 	return 0;
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
@@ -1351,7 +1351,12 @@ static int tls_device_down(struct net_device *netdev)
 		 * The context reference pins ctx; tls_device_lock keeps ctx->sk
 		 * allocated until the validator has been switched.
 		 */
-		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
+		if (READ_ONCE(ctx->sk->sk_validate_xmit_skb) ==
+		    tls_validate_xmit_skb) {
+			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
+				   tls_validate_xmit_skb_sw);
+			set_bit(TLS_TX_DEV_DOWN, &ctx->flags);
+		}
 
 		list_move(&ctx->list, &list);
 	}
@@ -1375,13 +1380,14 @@ static int tls_device_down(struct net_device *netdev)
 		synchronize_net();
 
 		/* Release the offload context on the driver side. */
-		if (ctx->tx_conf == TLS_HW)
+		if (test_bit(TLS_TX_DEV_DOWN, &ctx->flags))
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

