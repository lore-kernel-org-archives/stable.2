Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50669478E5E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781147; cv=none; b=ouKbKC5fPryFUxznC7bqU1dwN4Hcj4yI61ZXjk9q3eW93q9igtLvY094fe9jzNOFOJe4A7NBmmlgs6AISt/qlbrr65BvcHsuD0noAS8aGPmV2dY5yTvF5wb+wXusz42KJ6FHsPCoZ7NNQ1qcf+SiRleJFv3Bw3ceqH3cyWTEv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781147; c=relaxed/simple;
	bh=hNd6bIyFAvlFxc6hjuFcDqVwVqg86Zvx1YHzqvt4tLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN0+UjDqswpfLTwonUfVQaAUnGRJnyX3hB9mPfosjNFBe3EY//li67WVMQqxExjHY8ecNYCusaEYlusaCtMofRwUxlXl5byiwZuww3UChtrNF7t/ObXHXFJmxmhZctEl/2XW3hVWuc8whlbZhyjFJReULEJHvtWKOZ+UZiOSVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nch8TyND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nch8TyND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788781143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHCKmh+GTex17viqHU7+p3b1kZPrhM46bDIsKbGkEho=;
	b=Nch8TyNDlnwLos5cevYWHtv6Dk8AHrv6EQM1q10NAs8gzZC+VPgYEV7tyqGPk6Z/CvUrlE
	tyDs7uG8Y2PSOMymOWqdeWGi6B52Ms5ceX/J/dkQrJTIzPLMIPUIuhHcHeMqqAoplw+iiB
	6cE7g5p9iRolU8Ddc5CSGvt+FSENxgI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-3OA5z2N7Niam5fyVXGe7bA-1; Mon,
 07 Sep 2026 07:38:59 -0400
X-MC-Unique: 3OA5z2N7Niam5fyVXGe7bA-1
X-Mimecast-MFC-AGG-ID: 3OA5z2N7Niam5fyVXGe7bA_1788781138
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC0BD19540DE;
	Mon,  7 Sep 2026 11:38:57 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89F2530001A2;
	Mon,  7 Sep 2026 11:38:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Seungwon Bae <qotmddnjs@ajou.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH net v9 13/14] rxrpc: fix use-after-free in rxrpc_poke_conn()
Date: Mon,  7 Sep 2026 12:37:40 +0100
Message-ID: <20260907113743.1453210-14-dhowells@redhat.com>
In-Reply-To: <20260907113743.1453210-1-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Seungwon Bae <qotmddnjs@ajou.ac.kr>

rxrpc_poke_conn() takes a reference on the connection with no liveness
check, unlike its sibling rxrpc_queue_conn() which gates on
atomic_read(&conn->active) >= 0.  The per-connection timer is armed with
no reference held for it, and rxrpc_put_connection() cancels it with a
non-synchronous timer_delete() only after the refcount reaches 0.
refcount_t saturates rather than resurrecting, so the connection can be
kfree()d while still linked in local->conn_attend_q (nothing in teardown
unlinks attend_link).  The rxrpc I/O thread then performs a UAF write
(list_del_init) plus UAF reads and indirect calls through conn->security.

Reproduced on a KASAN + PREEMPT kernel: 56 "refcount_t: addition on 0"
saturations at load, escalating to

  BUG: KASAN: slab-use-after-free in rxrpc_io_thread   Write of size 8

AF_RXRPC socket creation (rxrpc_create) has no capability check, so this
is reachable by an unprivileged user.

Guard rxrpc_poke_conn() with the same liveness/refcount check the sibling
rxrpc_queue_conn() uses before taking the poke reference, so a connection
past its last-active point is not poked/requeued after teardown began.

Verified before/after on KASAN+PREEMPT at equal timer volume: 56
saturations + 15 KASAN reports unpatched vs 0 and 0 patched.

Fixes: f2cce89a074e ("rxrpc: Implement a mechanism to send an event notification to a connection")
Signed-off-by: Seungwon Bae <qotmddnjs@ajou.ac.kr>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
---
 net/rxrpc/conn_object.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0ece717db0f8..1be50e0c9cee 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -34,7 +34,10 @@ void rxrpc_poke_conn(struct rxrpc_connection *conn, enum rxrpc_conn_trace why)
 	spin_lock_irq(&local->lock);
 	busy = !list_empty(&conn->attend_link);
 	if (!busy) {
-		rxrpc_get_connection(conn, why);
+		if (!rxrpc_get_connection_maybe(conn, why)) {
+			spin_unlock_irq(&local->lock);
+			return;
+		}
 		list_add_tail(&conn->attend_link, &local->conn_attend_q);
 	}
 	spin_unlock_irq(&local->lock);

