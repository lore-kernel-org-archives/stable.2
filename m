Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604426;
	b=nd40Yfaz8T+DgVUFPgqAnHRNCnkLzSNdjCNQ2BjajZKHCM52L2+UUoRMSuNhqjVSNeT+
	 MTCrYOW4QvWJgQ73vemxQiY3eBpCB14BTyvt2d7zITaxKvF0dwYjl5kEyrR3DkqdDXXC4
	 2ozcXaRBXY+VKBz4rQ1WVbkbWyrMYIv6jkdwdbUD0YuZafLKLiFc96LTOOBuOXf3ua2fC
	 k1KwuP1rBh5DYlR4DEfLrxuvMNSynuPNmS5PG4HM2+NlmOhqbbooOBIYUqdFBedG58vbQ
	 RTQ3AMbG9zNwb38C152eY6eFvKiafm/SqUY1sKOdgRqpwagyT8LdI+IshK6SxzGDY/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0dHmRdnk/ATqwo/EsTbTcwWoDXKXa9dTSpvherQIWhM=;
	b=w/HPFmFDcB4vTA6XFO5VGe69+kd/ciNfxFpsiZVlZpGDD6ElnoRgIcFyouj40Tqux6mr
	 FvFvZmA2RqQ/rHtWyirWxgsxFjVAyxlBq4/pAZMyyjzVnnsSzSHW7svEYTdB3F8PERwZS
	 0SIqeCW0+GE5cGpIzGY7ul2ahTOwqyNF0D9m6OxEHOFpSRE6JWQ8EvATbdro8/upgn+Zc
	 NumLg9sllliGePTbOBGoe/9vRUalHDO22saIkHEb/GepPrymWZWd0LkJ5xjKIueAPi5PC
	 WrodN6ebFqFHTX8QvfkUurs+/mj826AOTGfrIvj/gEX89+Reo8xhVGjRCgdBKD+DmRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=DvEoY+AP;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15781606A88B
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15781606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=DvEoY+AP
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-53ec2cc397aso1672503b6e.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794604424; x=1795209224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0dHmRdnk/ATqwo/EsTbTcwWoDXKXa9dTSpvherQIWhM=;
        b=DvEoY+AP82+e8/1Co2xXayhA3H7nJwC/dDd+BsFkjRRoDnpkxsuzrJua9vVISSTSZZ
         f/yB5hdOz4TaF/WlCJelG1kVtSqhP02Q3JTYiBqWTltK/hJ70+ViDrQJiry+gPVi423w
         hgIsIHYyBoOZKZPd4jU9PriRbr76K0LUOXwDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604424; x=1795209224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0dHmRdnk/ATqwo/EsTbTcwWoDXKXa9dTSpvherQIWhM=;
        b=xb4DchNeC8oY9MeXRC6DBpqrnnx/xwn6nRExvZUl77KCH3+Fg9cjIxYUauXDw6usJ2
         zqS8EONXtoQM/1T80Mb7/GlRpFDZcU4XoYwUPrWVjjTThIV5zt5pjX8bCEFci1teQfMr
         gmoNPo5TrNm/CKkznfK/23F2AB3AahEJKVoUlftKMvj/f0GeXz3U98JREQx+TdzJjt+D
         lRHxBebEvw2VOS6QprM/OTJuTXSl5PHjwUyXcEIgDGxn86ArkYqmR2S+MD2hpGxjwoWC
         rOFBC9l0+gKnYjT7Hrt1iwseL6rG6OK2cQaJbfLHY7o1UkLuyup6MUimOneg4nCBWrfA
         UmTA==
X-Forwarded-Encrypted: i=1; AL+hErFa/ESy5yRnX/kBMnsWmq+x1n35XNsUxMr5MUMul3+1fC2ESPUj4CAQu/tIMhDdMzc5/nUnVbQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oNpmotOYOSW2pT6yOtC6uM/ioV3fRTZY7Unity5j6Dml6XGpM
	d+GOQ/S+BymgVhAF/LCC/HmR7aI4ig1BdgFaRspNNHXzUMDLcyrUsZnYnGAWoNcyJ7A=
X-Gm-Gg: AYBFou15ovl4NnUUZplwk5Wu8JwDrOmdDbNdQ81eWvbmTVOTBzWviEc9dElodZYO7HI
	P4z0MNTWag5ambzPBV3zhpvwDF3uCb1sOesFYSvh+V2IImKbGeON0nMaG0RGQMW4JWiYtoGfkZA
	KSWPW4SJZTBQitV5USq3QMAlC1TDvIzX2nKyZ7No8NcSMdII7CtIlJoRnBb6JCqZpV9F+eEQXWJ
	vmHomX5RUQi2ycqup0/nOAt7cHvON3Mdymyon49qOxhxHObepG3l+nSsi1sXWVmhsH1GepIhcLV
	P4HTX/d/LONAPHUUwjnDvECL/nl9xI5d9TSGq3q+Gmc+MSp7TzBvYajtouS1SlrSWezMR+LJY3d
	NmfIbUEpqY04dQbxrS8CktmK6FQZnqQ+um/pJjeXFeXEo8Qb4rjrrNCBgnW30bmAgXlqQZGkNF1
	02b+96h6S2UCueMBI4tpFol7bfwxl6dP1JvLV5ggCuCEiTTEvUQ2Wz82k/fDnbLNyaBpWaY+3+1
	lbG5EECghh8BRqJcS2L9oDfj4mFi7M7WCnnocCAW9T3h09eznfQxLPxYy3Y7y/7hMURp+9ahDhx
	XIUM9uBfHowg0hocrZuPGsIixjqeE8A5M1PNwCg5rgYAfzmgtID5UgEmhn1V69G5O8KWFUfec4A
	I3ip0N3qOXk3KABWH4bmt6gmrU002VA==
X-Received: by 2002:a05:6808:1a03:b0:56b:4351:49bd with SMTP id 5614622812f47-56e647dfc6dmr3129683b6e.52.1794604423720;
        Fri, 13 Nov 2026 13:13:43 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e71262becsm2809890b6e.17.2026.11.13.13.13.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 13:13:43 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: linux-afs@lists.infradead.org
Cc: dhowells@redhat.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] rxrpc: Serialize client connection IDR updates
Date: Fri, 13 Nov 2026 13:11:30 -0800
Message-ID: <20261113211130.86092-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

Service connections use peer-selected CIDs and do not own client IDR
entries, but the common destructor removes those IDs. This can delete a
live client connection or race allocation and corrupt the IDR and its
RCU callbacks. Client destruction can also repeat an earlier removal
and delete a reused ID.

Restrict client cleanup to clients. Restore a per-local writer lock and
an ownership flag so each ID is released once. Retire IDs even if the
bundle slot was replaced, preventing deferred final puts from leaving
the IDR nonempty at endpoint teardown. Keep IDs until retirement to
preserve active calls and terminal retransmissions. Unlock before the
existing leak BUG() so later destructors cannot get stuck.
Client-only cleanup also corrects nr_client_conns and restores the
intended expiry selection.

The issue was found by an LLM.

Fixes: 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O thread")
Fixes: 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v3:
  - Unlock conn_ids_lock before the existing leak BUG().
  - Add the Fixes tag for the earlier service/client accounting bug.

v2: https://lore.kernel.org/r/20261110062221.96452-1-kylebot@openai.com
v1: https://lore.kernel.org/r/20261030042129.73690-1-kylebot@openai.com

I have a reproducer for this issue and can share via DM

 net/rxrpc/ar-internal.h  |  2 ++
 net/rxrpc/conn_client.c  | 22 ++++++++++++++++++----
 net/rxrpc/conn_object.c  |  3 ++-
 net/rxrpc/local_object.c |  1 +
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab..5e49fe0f4a6f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -377,6 +377,7 @@ struct rxrpc_local {
 	bool			dead;
 	bool			service_closed;	/* Service socket closed */
 	struct idr		conn_ids;	/* List of connection IDs */
+	spinlock_t		conn_ids_lock;	/* Lock for conn_ids */
 	struct list_head	new_client_calls; /* Newly created client calls need connection */
 	spinlock_t		client_call_lock; /* Lock for ->new_client_calls */
 	struct sockaddr_rxrpc	srx;		/* local address */
@@ -472,6 +473,7 @@ enum rxrpc_call_completion {
  * Bits in the connection flags.
  */
 enum rxrpc_conn_flag {
+	RXRPC_CONN_HAS_IDR,		/* Has a client conn ID assigned */
 	RXRPC_CONN_IN_SERVICE_CONNS,	/* Conn is in peer->service_conns */
 	RXRPC_CONN_DONT_REUSE,		/* Don't reuse this connection */
 	RXRPC_CONN_PROBING_FOR_UPGRADE,	/* Probing for service upgrade */
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 48519f0de185..2da6460472a7 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -40,12 +40,16 @@ static void rxrpc_activate_bundle(struct rxrpc_bundle *bundle)
 }
 
 /*
- * Release a connection ID for a client connection.
+ * Release a client connection ID exactly once.  The final reference may be
+ * dropped outside the local endpoint's I/O thread.
  */
 static void rxrpc_put_client_connection_id(struct rxrpc_local *local,
 					   struct rxrpc_connection *conn)
 {
-	idr_remove(&local->conn_ids, conn->proto.cid >> RXRPC_CIDSHIFT);
+	spin_lock(&local->conn_ids_lock);
+	if (test_and_clear_bit(RXRPC_CONN_HAS_IDR, &conn->flags))
+		idr_remove(&local->conn_ids, conn->proto.cid >> RXRPC_CIDSHIFT);
+	spin_unlock(&local->conn_ids_lock);
 }
 
 /*
@@ -56,15 +60,18 @@ static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
 	struct rxrpc_connection *conn;
 	int id;
 
+	spin_lock(&local->conn_ids_lock);
 	if (!idr_is_empty(&local->conn_ids)) {
 		idr_for_each_entry(&local->conn_ids, conn, id) {
 			pr_err("AF_RXRPC: Leaked client conn %p {%d}\n",
 			       conn, refcount_read(&conn->ref));
 		}
+		spin_unlock(&local->conn_ids_lock);
 		BUG();
 	}
 
 	idr_destroy(&local->conn_ids);
+	spin_unlock(&local->conn_ids_lock);
 }
 
 /*
@@ -162,15 +169,20 @@ rxrpc_alloc_client_connection(struct rxrpc_bundle *bundle)
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
+	spin_lock(&local->conn_ids_lock);
 	id = idr_alloc_cyclic(&local->conn_ids, conn, 1, 0x40000000,
 			      GFP_ATOMIC | __GFP_NOWARN);
+	if (id >= 0) {
+		conn->proto.cid = id << RXRPC_CIDSHIFT;
+		set_bit(RXRPC_CONN_HAS_IDR, &conn->flags);
+	}
+	spin_unlock(&local->conn_ids_lock);
 	if (id < 0) {
 		kfree(conn);
 		return ERR_PTR(id);
 	}
 
 	refcount_set(&conn->ref, 1);
-	conn->proto.cid		= id << RXRPC_CIDSHIFT;
 	conn->proto.epoch	= local->rxnet->epoch;
 	conn->out_clientflag	= RXRPC_CLIENT_INITIATED;
 	conn->bundle		= rxrpc_get_bundle(bundle, rxrpc_bundle_get_client_conn);
@@ -682,6 +694,9 @@ static void rxrpc_unbundle_conn(struct rxrpc_connection *conn)
 	if (conn->flags & RXRPC_CONN_FINAL_ACK_MASK)
 		rxrpc_process_delayed_final_acks(conn, true);
 
+	/* A replaced connection is no longer in the bundle. */
+	rxrpc_put_client_connection_id(bundle->local, conn);
+
 	bindex = conn->bundle_shift / RXRPC_MAXCALLS;
 	if (bundle->conns[bindex] == conn) {
 		_debug("clear slot %u", bindex);
@@ -689,7 +704,6 @@ static void rxrpc_unbundle_conn(struct rxrpc_connection *conn)
 		bundle->conn_ids[bindex] = 0;
 		for (i = 0; i < RXRPC_MAXCALLS; i++)
 			clear_bit(conn->bundle_shift + i, &bundle->avail_chans);
-		rxrpc_put_client_connection_id(bundle->local, conn);
 		rxrpc_deactivate_bundle(bundle);
 		rxrpc_put_connection(conn, rxrpc_conn_put_unbundle);
 	}
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0ece717db0f8..bae95cadd72b 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -332,7 +332,8 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	rxrpc_purge_queue(&conn->rx_queue);
 	rxrpc_free_skb(conn->tx_response, rxrpc_skb_put_response);
 
-	rxrpc_kill_client_conn(conn);
+	if (rxrpc_conn_is_client(conn))
+		rxrpc_kill_client_conn(conn);
 
 	conn->security->clear(conn);
 	key_put(conn->key);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 169f9dfdaa77..5a7acd595e11 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -140,6 +140,7 @@ static struct rxrpc_local *rxrpc_alloc_local(struct net *net,
 		memcpy(&local->srx, srx, sizeof(*srx));
 		local->srx.srx_service = 0;
 		idr_init(&local->conn_ids);
+		spin_lock_init(&local->conn_ids_lock);
 		get_random_bytes(&tmp, sizeof(tmp));
 		tmp &= 0x3fffffff;
 		if (tmp == 0)

base-commit: 2800868f63227c8237d70c41e70d441c919620d6
-- 
2.55.0.openai.911.g06873a30d2f3

