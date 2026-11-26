Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657417;
	b=tdXbLrZsBhUNDWOj2M9p4nAusTlBpyhFcBry5BGFvgM2qajVTirFkzb0oCAPY4IJ3+HI
	 PvEmto1ElTpmuPN1+/ak8vGRSrIIOadgGlsFTa9+gsHKD6MopMyrEnFwMZ2QF+Dx817Kd
	 GO8Uls98ZHqNIf5plKO+bVpEJz9O1pvx9p+Cs4P958siGMMljgIVf/w+Z5jFevRBITx5/
	 o/sP8pxYDr+sqMlNpF++CiyJNwB5PjKvTQxhfPSnYXa1ARlqVzhiLW11JNQxoM/hztyQG
	 CMtlujWjVZIzoNmiDSyfy6tbwcOHGfh98IZY4B8os8zVcwEwIiB5/kT07QfhGPyQdpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fwQxHjW1tB/URqAbLH02/TaEG23Ukky41eUBrxOnHoU=;
	b=rs7p0/HHRsE9PbLeMGItQQ+HzHZDOnDIEZgK+aGIpBpyKiC6M/2/OOz0vEA/swJTTykb
	 TCYu7DCHTosNBFyw6x9ePQJ8iXWfIcwixQtSc65FTZkG4idRX6+KxHaARD2VvCAkYYkVy
	 FOSU50ZmP5q672hTfywi6ziMfU8/YnccZwxUeT5HBfQvjPsimT0R5EidkRTOc/Wlwi36Y
	 Y3Gn8L6VNJBK3e5o078gjUWGWdZROlzQqWbz/IwfWJ1laC7+KJEjIAGGW7JQy6c/4UC8/
	 HZzf/LSB+36D3HgSANX4LAupARqP5CUenAOhWe0G+xmeSk/aytpNgl4VRVpAX9YOe1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Yr57WxnJ;
	arc=none smtp.remote-ip=74.125.82.227
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88514606A339
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88514606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Yr57WxnJ
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso13736986eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795657417; x=1796262217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwQxHjW1tB/URqAbLH02/TaEG23Ukky41eUBrxOnHoU=;
        b=Yr57WxnJjOrR2w7bxyjAtZlnEi2B5pxDWIzskvsQLa4WSChtq7+9p9ZX0r/UPwfbcR
         xG9Ovh3Vp8Llo47h/qL/yTBOGUAk3RQs71Z0WFh4/apKZ1GHDA6B/sGG1oiwNM+kNr0d
         HTxlBj3cmt5IRc6SCufJRz7bisTJXEtgZLIqCc+7Wfwlc2mWgADyCJxpvvL5L5A2h+12
         f1jCv0NOv9SGCJeLPgPURu1mImNuPGvaABMTvvKQ3REhIhVpwNFRpuhdnxKkCWGP8dBq
         TAcGpdDsbk6TPMVTMEzgrHyT5avV2sDauQ7XFimQvtP43S7A2eIaSocjC5bL1wqUHVhN
         IpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795657417; x=1796262217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fwQxHjW1tB/URqAbLH02/TaEG23Ukky41eUBrxOnHoU=;
        b=Ttz+IuF7HhUStHjTGKvdi0KUbaXFWTfndlLjgeo7g4ajf2kxQEXeKoz1G/l6yMu60C
         anVLzhP4qhrcXZhZkLWxhgtYR+1R/HSXq9irm04/jk0HN4mQr/BMqJzZxlFWIbJogPO8
         NVZMDb7xGxKwtd4s0lPejGcz3KrECR+AagixByvXdd8p9CJDAo/jWGtKWmUTesmaMW+i
         DTIjOOENQkzkQPPMeiLwAnH+cJShLe6jsjO1gq8ulAl6tlLDNC6BnahDFw/vo+1l/VZv
         K/qn7EK8dkoScfr6YWxebGfbnfs9cKacrrSxHJ5nCfbSO66pLzDHi/baDHMXdC7chgAe
         0eRw==
X-Forwarded-Encrypted: i=1; AL+hErFkJCgUZ/z8rIf0lIEPf9xSHDxF5ntnhT8oJw9mpc/1HRMLqLz1F7rpDxZrznFqw9RruJ5WbII=@vger.kernel.org
X-Gm-Message-State: APuU4Z+L4iSHDf8wxHnaDi6WNX+JJBgk23D37SWS2Ybm7hLcNGdBYaTa
	bp/w1YYqIJE1FrOZR6N2Dp6s58b4rqdvKZ/iyH9FVVCNVD1kOxDMf2/K2NCclNjEovde0NtUa/j
	9XfwbVNTCeaN2yJvZwJwDwe7mlyCDvI6ggewzUoV+O7q8ZC7uMlW7
X-Gm-Gg: AZFdTZfkL3D4Qdbjo8jtEdM7CEoPx16JPbhOqaOLKlUwl47wm6GyqeXYYKWxRdhp/ln
	oRbWdncH7w1ner7agN+Sl7ZEIfKo1NRFsrxxBoBs5Souc2K558q6AgXR7hRIE4yMuDFU5Dkz/VI
	CD1y3aOTZ6d7epUxMZRdGJtTDNXRtmB3MT9rCYvhfoz8DQ13/gAK+qeRYMcZarvRY5CscGFbrLH
	8vb+hJF7W++My76QEBgcHmIIBAm1KaroUHvigYJoIna2N1Sh3o3tIdh4+pPLKc7+03Jh/QHeNqP
	vmSgivZjDIMWbfIxGRo/czoRHAjL4T3CZa4D2olRedUDr05XJuV4bD+XL56CFRWOK7cFoubhgK9
	C6qH+Zb4OKeAqPTwk5Pg=
X-Received: by 2002:a05:7300:f68e:b0:369:f291:49da with SMTP id 5a478bee46e88-38571814b1dmr20131674eec.40.1795657416624;
        Wed, 25 Nov 2026 17:43:36 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-38567da4fc9sm2964930eec.26.2026.11.25.17.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:43:36 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 307B3400B7;
	Wed, 25 Nov 2026 18:43:36 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 2DF12DC0C28; Wed, 25 Nov 2026 18:43:36 -0700 (MST)
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
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@mellanox.com>
Subject: [PATCH net v7 2/3] tls: restrict device-down TX fallback to hardware TX sockets
Date: Wed, 25 Nov 2026 18:42:43 -0700
Message-ID: <20261126014327.1638133-3-rjethwani@purestorage.com>
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

tls_device_down() sets sk_validate_xmit_skb to tls_validate_xmit_skb_sw()
on every offloaded TLS socket on the device, including hardware-RX
sockets without TX offload (RX-only, or software TLS TX).
tls_validate_xmit_skb_sw() passes the skb to tls_sw_fallback(), which
expects a tls_offload_context_tx in priv_ctx_tx, so such a socket can
crash when transmitting a payload skb. In the oops below, a payload skb
queued on the neighbour entry during the down/up cycle was flushed on
ARP reply:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  tls_sw_fallback+0x11b/0x450
  validate_xmit_skb.isra.0+0x14f/0x420
  __dev_queue_xmit+0x5e8/0xf30

Switch sk_validate_xmit_skb to tls_validate_xmit_skb_sw() only if it is
currently tls_validate_xmit_skb(). Record the switch in the new
TLS_TX_DEV_DOWN flag and call the TX tls_dev_del only when it is set,
instead of checking tx_conf. do_tls_setsockopt_conf() sets tx_conf after
tls_set_device_offload() has released device_offload_lock, so
tls_device_down() can see a context whose tls_dev_add() succeeded with
tx_conf not yet TLS_HW, skip the TX tls_dev_del and leak the driver
state.

For the same reason, set sk_validate_xmit_skb in
tls_set_device_offload() before releasing device_offload_lock.
Otherwise tls_device_down() could run between tls_device_attach() and
the store, skip the switch and the TX tls_dev_del, and setup would then
set tls_validate_xmit_skb() on a context already detached from the
device.

Contexts never return to tls_device_list, so TLS_TX_DEV_DOWN is never
cleared.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled): the crash reproduces
without this patch; with it, an RX-only socket survives interface
down/up and keeps receiving TLS records.

Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Cc: stable@vger.kernel.org
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    |  2 ++
 net/tls/tls_device.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 0b001b8ab1c3..f9540910b2e3 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -194,6 +194,8 @@ enum tls_context_flags {
 	 * tls_dev_del call in tls_device_down if it happens simultaneously.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
+	/* tls_device_down() replaced tls_validate_xmit_skb(). */
+	TLS_TX_DEV_DOWN = 3,
 };
 
 struct cipher_context {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 3ea764bdc949..3473299b16de 100644
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
@@ -1348,7 +1348,12 @@ static int tls_device_down(struct net_device *netdev)
 		/* Stop offloaded TX and switch to the fallback.
 		 * tls_is_skb_tx_device_offloaded will return false.
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
@@ -1372,7 +1377,7 @@ static int tls_device_down(struct net_device *netdev)
 		synchronize_net();
 
 		/* Release the offload context on the driver side. */
-		if (ctx->tx_conf == TLS_HW)
+		if (test_bit(TLS_TX_DEV_DOWN, &ctx->flags))
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_TX);
 		if (ctx->rx_conf == TLS_HW &&
-- 
2.50.1

