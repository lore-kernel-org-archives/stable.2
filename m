Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854124;
	b=r/LVr6vUO+BjJApnfVPrtpnuEmwDEaPoxxgl0hcz8sss8xDKrxW1NfG4qct/dac2T64U
	 gSPJtwpxqsFl964vLA6lY+ooUoZPunGH/HIdPogTXkEHPpcZlFAsTS+IQaGtKk00MMvXQ
	 Co7m1W4aZdRC4Tu2DJuoVz9y9YR/dlN3zM0AWu3PMB0dx/ivrx9TijRmsTA/36YZoXr9b
	 N0UR60QRliVs0n3KhbFhVY1/OvnXIX0iKaltscau0HFnoPffJcXoY1256DC3VnxcSqbiK
	 MlC4EEj+69IYd1MGcyK/NmsrZDxzfWyjuN6F88OOO6r0dSRnRoaarcd+p6PwFTGqJVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cy/lKXDY5Mb2V69eFqBf0CzvLZ8atfymKEUEwZZTm+k=;
	b=0RBDW16Nc952OjRH+2gDpJ5G69tkITKEBn0yhHNthaUW+QQRiDJpu9En0AVbms+lEfnD
	 7vhk0jvpwg7w5ajmFa3lINo8aQqpX04bpqQapCkgyR4v+lKlqfmVZpWqaYoGWDvJGxaTX
	 o5NralIO5ogxqvjRjvioXuDXUkHgUhM3hlLkOs8L+z+lqWps3022bHoPSVdGkC4AEGqna
	 WnPHK5hqJ1qCqbF01NNlQDK6DlkHgfaBE4truzf+FEWsumyMCVypDDuS2E458CDq9b4uh
	 xTDVQVCV5WJzR4puBeb8LDmyWSgvI/CMntpiH+qNuCiErVCGvCVfScsBPUhBM46anVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=HEs0XthU;
	arc=none smtp.remote-ip=209.85.221.226
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B8606A335
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F6B8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=HEs0XthU
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5ee36376a0dso2714112e0c.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794854123; x=1795458923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cy/lKXDY5Mb2V69eFqBf0CzvLZ8atfymKEUEwZZTm+k=;
        b=HEs0XthU1JVMMyw6jGXv/qHlwmSNULfEGcbWl+T5VtuMJ8BSTNgy4+/E8HZEJF2ckw
         ZMEi/iDAlX0yYeOk5PtsZQayuIyvTZkn6/ED8FUZwoBFQ/B4dhgBJtb640nufxpAyvBv
         YgPaejepQYyQlauUbp11xXE4D4agn4czNypoE6k/s28LB4G0maTqvadg0oZbbguy1U9V
         rr2KPKCVI5iIh/TXmM1NUnkeDCT3xOTJ2kvaRhywx8CbgSe0X7oDgt/zdpH+biyGqTwt
         Osh4v0k9IceIFspbxjijhYHrp/WxBW1S757za1NZRN76gl7lJlDXpM4T0cSUJDDbkUCT
         kJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854123; x=1795458923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cy/lKXDY5Mb2V69eFqBf0CzvLZ8atfymKEUEwZZTm+k=;
        b=fiXoKs1BzQqbKeHTwRCeEO4pSUnbgsv94S25yq0nCgnFX6k4l5o+vmbDo8sFiphlol
         RYBQ3bph4ICkPjp/NLjhFpJfbDavv92eHm4JiLeDumniXi/eZjBhJ4FXLGiDP2Qh+PND
         dvEzvVK6qzE3Exddw0vOlhDltc6bmE70OZvWorz+0CvCHEPoToxgAEVRyL0qnRtw//jx
         JZ/cf75mK5rWPCnQvZ3w61A1KsO0ydAbVyL26qlSie/CByrSlDQ+7rDsm2rLyBDwgdK/
         rNPBulHA3I5l7jjeLx8/AI7955mVlVulevtumWqXoCSdWw081LHFY4L4V4ufa69G03m0
         ESHA==
X-Forwarded-Encrypted: i=1; AL+hErE4Y6+G0SFs/oL0Nw93kTLOTdy+kwUZBw9Ghf3fad6Uq9D6q9MXHKddeiMMkVlb5v4yCRCeFcA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sqqxiUWOYGZdRU7f38ZZZwiPpIwfqwTsCfCLFDWvoUZnqcGUC
	hVqFG6Mje3MdMmzcMVgNiV8DW0QwhBo9eoEQfbDuoxC/9RrItJBd+EJF38v+ORFfVDRrKwofIy6
	FAbsA7W6GwsdCB3j+pl08KwBG/K9D+7C4KGy7aR20ojYiKw3Ielsc
X-Gm-Gg: AYBFou3DBdU+7Y4SLpksY94E9GozE5oWFqnCz/up7cos0Z4uc4xcNGrjGJ0N3Nqw5i2
	Hj1WUdqcKs3yq6CiACC8ORV8N01Q4q0Nb7/To5KhRZEOEucmyrW4x8nQ0XoskDfCSzmNbRIYPse
	DoCKa8/FnSorFDrRFSKezxbR6HpY75hxnHSKd+3qGddab35gTap2rSgkThqLcytVJlHwWjaUV1I
	6B1Nmw09cn7fAIU+rna3Nb0GQLjoM7OTCXNoa6voOdqdvMvgIpbY9K97UZK6gnqRJZ9TSvo/vEy
	4yhmqfweqKry4gsaj72KXGATqSDo/joRjgf4XbB+h1lPUiPfeIMeiFfSDT2yU4EaPP32CG7Rff1
	ssNZV1DIMIEYiZk/NLdU=
X-Received: by 2002:a05:6122:178b:b0:5ea:b712:8281 with SMTP id 71dfb90a1353d-5ee34ae1c8bmr4770517e0c.18.1794854123238;
        Mon, 16 Nov 2026 10:35:23 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5ee34e3180esm218332e0c.6.2026.11.16.10.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:35:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id A0F4F401CE;
	Mon, 16 Nov 2026 11:35:22 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 9E284DC0D05; Mon, 16 Nov 2026 11:35:22 -0700 (MST)
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
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@mellanox.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 2/2] tls: restrict device-down TX fallback to hardware TX sockets
Date: Mon, 16 Nov 2026 11:35:18 -0700
Message-ID: <20261116183519.3314837-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261116183519.3314837-1-rjethwani@purestorage.com>
References: <20261116183519.3314837-1-rjethwani@purestorage.com>
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

tls_device_down() installs the hardware TX fallback on RX-only and
software-TX sockets. The fallback expects a hardware context in
priv_ctx_tx, so an RX-only socket crashes on its next transmit:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  tls_sw_fallback+0x11b/0x450
  validate_xmit_skb.isra.0+0x14f/0x420
  __dev_queue_xmit+0x5e8/0xf30

Switch only tls_validate_xmit_skb() to tls_validate_xmit_skb_sw(), and
publish the hardware validator before releasing device_offload_lock.
The switch runs under tls_device_lock, where ctx->sk is still allocated.
Record its result in TLS_TX_DEV_DOWN, and delete driver TX state only
when the bit is set. Contexts never return to the active list, so the
bit needs no reset.

Driver deletion cannot rely on tx_conf or rx_conf: they are published
after setup releases the lock, so device-down can miss a completed
attachment and leak driver state. Track RX state with TLS_RX_DEV_CLOSED:
set it at context creation and after deletion, and clear it after a
successful driver add under device_offload_lock. This avoids deleting
absent RX state and reading configuration bitfields while their shared
byte is updated.

Found by code inspection. The reproduced RX-only crash is fixed: the
socket survives interface down/up and continues receiving TLS records.
Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).

Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Cc: stable@vger.kernel.org
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    | 10 ++++++----
 net/tls/tls_device.c | 18 +++++++++++-------
 net/tls/tls_main.c   |  1 +
 3 files changed, 18 insertions(+), 11 deletions(-)

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
index 866193a506d2..ae434c304151 100644
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
@@ -1351,7 +1351,10 @@ static int tls_device_down(struct net_device *netdev)
 		 * The context reference pins ctx; tls_device_lock keeps ctx->sk
 		 * allocated until the validator has been switched.
 		 */
-		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
+		if (cmpxchg(&ctx->sk->sk_validate_xmit_skb,
+			    tls_validate_xmit_skb,
+			    tls_validate_xmit_skb_sw) == tls_validate_xmit_skb)
+			set_bit(TLS_TX_DEV_DOWN, &ctx->flags);
 
 		list_move(&ctx->list, &list);
 	}
@@ -1373,13 +1376,14 @@ static int tls_device_down(struct net_device *netdev)
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
index b8d5a843f761..9b06d0f035c5 100644
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

