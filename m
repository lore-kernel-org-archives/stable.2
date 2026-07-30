Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3F1DA60D;
	Thu, 30 Jul 2026 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373304; cv=none; b=juVnYsDLsyt5SgSmocKALwkCuZsxaC+DD5lIMSgOnbGqUwC1bhyU21JwC1TpiNtuMeb4VBnATAUOSdMBSYU+gCSjHeRF/jBqNtiqJVGiwkjk4lYS3k1qXRdGx6jHJwPh6mLWO9IC4pTWop9jd5B6vzlYbIs3L7xuq/XZxVbxWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373304; c=relaxed/simple;
	bh=gRGXzSakZiJaXj7Qpdv/+QdbrYel7A8TRVi8NA5CjvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5kYLCwpkHmAYUbIVVU/Z1ABvDN/7Cg+LAr5BGjH/JSE2XBhd1jlU8AQRD94af8WDUs9TkAF/B/mipN3Nf2v8/ulrfeb8xVNY3u94PrKZ/ErgUUe4MUyQ3BVCHSuzwWALvSFzC8qN8Me9WH8+9xQlcL04dJFB+xXZ4Vu01YkHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhQYvnV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhQYvnV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909681F00A3A;
	Thu, 30 Jul 2026 01:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373302;
	bh=6LIaTLd4GrJ9A0RDu/tU48tl9MVB4sXzgCjiDvwOeRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hhQYvnV709x3Wh+Z4dStafefiy8obi3fYC8EuuG3SeYXV+K+8+6cUW7cKeBcytgyf
	 jiLKU0BlRPGZUVI/+31+y+7q8WMjP8tZCOXAYyFaYdyYiDki16lN0sw2qS65a0j4H4
	 Dhm1HcZv9fT0q6L1rR5s86qJroM97dAN4hljM3BQUfK6UOm/qsjrCu7aDVNt3xM+Bi
	 zFpq6skLqLmfCU4OUulISb8Eh9Gmdwcz7qbtaYvnILmO20hLmOHlIf0qTGKpBxmt9b
	 IKAIc9ddd/UI9qdoFLANRnAHUyBO7frhagAaDNgTYYLcoY4o+H+YQhZDR8Pj6LOWfT
	 4xhtDUa/P2XDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/8] rxrpc: Allow the app to store private data on peer structs
Date: Wed, 29 Jul 2026 21:01:33 -0400
Message-ID: <20260730010137.1700032-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730010137.1700032-1-sashal@kernel.org>
References: <2026072131-schilling-spectrum-ef97@gregkh>
 <20260730010137.1700032-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit f3a123b25429dc03508e3bf598373005220b7203 ]

Provide a way for the application (e.g. the afs filesystem) to store
private data on the rxrpc_peer structs for later retrieval via the call
object.

This will allow afs to store a pointer to the afs_server object on the
rxrpc_peer struct, thereby obviating the need for afs to keep lookup tables
by which it can associate an incoming call with server that transmitted it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-13-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20250310094206.801057-9-dhowells@redhat.com/ # v4
Stable-dep-of: 330e2c514823 ("afs: Fix dynamic lookup to fail on cell lookup failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/af_rxrpc.h  |  2 ++
 net/rxrpc/ar-internal.h |  1 +
 net/rxrpc/peer_object.c | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 0754c463224a43..cf793d18e5df51 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -69,6 +69,8 @@ struct rxrpc_peer *rxrpc_kernel_get_peer(struct rxrpc_peer *peer);
 struct rxrpc_peer *rxrpc_kernel_get_call_peer(struct socket *sock, struct rxrpc_call *call);
 const struct sockaddr_rxrpc *rxrpc_kernel_remote_srx(const struct rxrpc_peer *peer);
 const struct sockaddr *rxrpc_kernel_remote_addr(const struct rxrpc_peer *peer);
+unsigned long rxrpc_kernel_set_peer_data(struct rxrpc_peer *peer, unsigned long app_data);
+unsigned long rxrpc_kernel_get_peer_data(const struct rxrpc_peer *peer);
 unsigned int rxrpc_kernel_get_srtt(const struct rxrpc_peer *);
 int rxrpc_kernel_charge_accept(struct socket *, rxrpc_notify_rx_t,
 			       rxrpc_user_attach_call_t, unsigned long, gfp_t,
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 61dd1298124f62..346fb8fa2cafcd 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -334,6 +334,7 @@ struct rxrpc_peer {
 	struct hlist_head	error_targets;	/* targets for net error distribution */
 	struct rb_root		service_conns;	/* Service connections */
 	struct list_head	keepalive_link;	/* Link in net->peer_keepalive[] */
+	unsigned long		app_data;	/* Application data (e.g. afs_server) */
 	unsigned int		last_tx_at;	/* Last time packet sent here (time64_t LSW) */
 	seqlock_t		service_conn_lock;
 	spinlock_t		lock;		/* access lock */
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 956fc7ea4b7346..5664469fdd0c77 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -509,3 +509,29 @@ const struct sockaddr *rxrpc_kernel_remote_addr(const struct rxrpc_peer *peer)
 		(peer ? &peer->srx.transport : &rxrpc_null_addr.transport);
 }
 EXPORT_SYMBOL(rxrpc_kernel_remote_addr);
+
+/**
+ * rxrpc_kernel_set_peer_data - Set app-specific data on a peer.
+ * @peer: The peer to alter
+ * @app_data: The data to set
+ *
+ * Set the app-specific data on a peer.  AF_RXRPC makes no effort to retain
+ * anything the data might refer to.  The previous app_data is returned.
+ */
+unsigned long rxrpc_kernel_set_peer_data(struct rxrpc_peer *peer, unsigned long app_data)
+{
+	return xchg(&peer->app_data, app_data);
+}
+EXPORT_SYMBOL(rxrpc_kernel_set_peer_data);
+
+/**
+ * rxrpc_kernel_get_peer_data - Get app-specific data from a peer.
+ * @peer: The peer to query
+ *
+ * Retrieve the app-specific data from a peer.
+ */
+unsigned long rxrpc_kernel_get_peer_data(const struct rxrpc_peer *peer)
+{
+	return peer->app_data;
+}
+EXPORT_SYMBOL(rxrpc_kernel_get_peer_data);
-- 
2.53.0

