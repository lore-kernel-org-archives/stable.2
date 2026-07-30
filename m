Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C529E116;
	Thu, 30 Jul 2026 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373335; cv=none; b=DK9bwzvN2RP2CIjv0kj0QIMq7aLd1NOsFe4OsLtxffmKdP4sQdVYMqQF1D56bgoyiuuxK/aVRAXdj7icCRD+otk8rb/I7Kmwu3KIoZqtLlAyU+qjDkv5M9QOFcIC7lHcrO/DhVs2wUXN89LpaPJbU1s5zznAzJejdWDwrFRaTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373335; c=relaxed/simple;
	bh=mBP7yYMDhsPD+Rh+hBdyO8motdkYoaHnlVjMWRqzU28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzXlUdtsPiNkvYTckU6pm+eEqnoHjIy+fR2D21zT6Ultj7hU/sKVYeD7dU8l4tWbHngFd5wETge5XhwWZJWoDFvRcSUpRsKY1sU/2dEv954Ra5F33voqsHtUibv5/mBcaiAdn9wWUf4rSzGaUqPMs5l6ynEqMVV81eDYrdc7SuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqbfGJ6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqbfGJ6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833FE1F00A3A;
	Thu, 30 Jul 2026 01:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373333;
	bh=yTDJ9u+m573RK7iOGs8iVRf3TciYkkHXM29BEI2B8EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fqbfGJ6hE9xSH9FqUbUeahmRIvzZmbnZ9G1Fw+4sD8wC/B/wqic3/of+QGMzeM6Us
	 Id4Tt+vx5s9ZLkgMPdhOeFSd6TaCTmB/YSpl8djeqVL76OgGY4cxCqs0yxF/cMZ6Re
	 mamofhMxswVqfBxq1hf9n8WiyCINVo/w2RrDcASgyZNGtmRETbIJSw4gm95EhG8aZI
	 XnZYG4UynxzYgApXwV5c7iJN6VhCxNanxZAcwM+7wlxpBrNEEowkbybLrS7V/IDj3m
	 FMVd6uPEVHNUVl0aJsBjLMW6i+v2lNMGrY+/9xYYR1JchGNEzibT00503bi17NZYqH
	 qj2H2klZMj8mQ==
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
Date: Wed, 29 Jul 2026 21:02:04 -0400
Message-ID: <20260730010208.1700694-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730010208.1700694-1-sashal@kernel.org>
References: <2026072116-feeble-cusp-7fff@gregkh>
 <20260730010208.1700694-1-sashal@kernel.org>
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
Stable-dep-of: 55e841836c6f ("afs: Fix lack of locking around modifications of net->cells_dyn_ino")
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

