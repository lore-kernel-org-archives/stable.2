Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC21AF0BB;
	Thu, 30 Jul 2026 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373314; cv=none; b=FYosMXoAyGucrGeSk6lvd860eGSrRGjXiqUT2AvpuyjZT6SYgcWZNAaheJZ8Y9YWr1PHY9Yx3ZZf3ZGnMlzJGBoofEWiyKMFKbQyagqPD2LOAi2qbCsTrtfq5yFfDeOwt163tpO6vM4p0hAbElp2cDWcmo+jCLWtbxV6YORcy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373314; c=relaxed/simple;
	bh=whzIaJD1Wk9glzs20HLSa7gLbWKZozgVkuVCS+ILZ9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bzul93acBsnI6y9O+DC4mjZhRstst1P0CWVo1A8PnElBG1vBsYuQD3/jFYXhpoS3lyMizx3gNSL6YvcBJlYcSQm6QhLf1AAU6BYAOzfXwCIUIfv6JeTjLvqCKujmuDKgUYXsc5n/t+/yzdekcKOFU669m77kD4jHTRFCO2gkaBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSe+G3kt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSe+G3kt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7EF1F000E9;
	Thu, 30 Jul 2026 01:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373305;
	bh=IV184mMzyuY3FpuiIwRjUzuaJqay2mHZ2w3om4g2Vxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TSe+G3kt0jBF7rtNkZ4GmZ6d38s0RpsexwdAct4FejZdLTmUfrQzuQSEKyaQN9G2v
	 4w9nyOSvETLiPhRpbev4hJ+NUt7Mv3+2GIJ/TXNT0TfwgPqL5i6bRAprTmGaJohZH1
	 mHqiPJoA/B5jNI6vJjSeQz0jYfRqoJ/pWfCEce8pBO92YxfudCVM7FjLOvBONNp4Pb
	 PWA/+j/ZW9DXf3T2OisnwIIYGrK+Ae/p4DM45aMr7IbNStx98jyA8dLv1GJhC9mRne
	 fGh1E4bU+v8K8mkLnj4GFHhqmQUcIKHu9hJDVnaFBUIThgSDQsP+mmNcRDfrmrC6VW
	 lKV/1SwvYFGfw==
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
Subject: [PATCH 6.12.y 4/9] rxrpc: Allow the app to store private data on peer structs
Date: Wed, 29 Jul 2026 21:01:35 -0400
Message-ID: <20260730010140.1700208-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730010140.1700208-1-sashal@kernel.org>
References: <2026072127-dress-overplay-421f@gregkh>
 <20260730010140.1700208-1-sashal@kernel.org>
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
Stable-dep-of: 26f17ce6fa3f ("afs: Fix premature cell exposure through /afs")
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

