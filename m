Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D5469842
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293503; cv=none; b=S7IoaaQc7cJia5TtTKjVM398aL7fAelPxniFvqVNUn8laQLiA9Umesw0Ox4idPY/QAwhWI4ankhroI/uutuM6oLascH1XRW3F2SFMp6g9MAM0ukDsQHBwvCvrd8Pf9eZ1H5g/rIuqA30nrAET5zsZWVRoJLM0ik9c3m88xxefG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293503; c=relaxed/simple;
	bh=hNd6bIyFAvlFxc6hjuFcDqVwVqg86Zvx1YHzqvt4tLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltzIquFX8RIBfxwEgU5stk6Minf57xDQpnrKHRNi91HL8ArIt3qOMf1VqUhSvVXr8xCMrOvjGc6WU9P3NMZR0Oc2Vq5svEylMKsghL1gNnUy4BYZBxoB7daQJ60qS9hS+2ZjDLlqdMivYc55Zfr1cUXhEvltXnkhosJ6s4lvLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brnbe5iF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brnbe5iF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791293501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHCKmh+GTex17viqHU7+p3b1kZPrhM46bDIsKbGkEho=;
	b=brnbe5iFnIiI72N5vCT8dmAbsxnzJzgGV0VAoNzGsqXnNxMv0BCGswd47/B3EbeCteRaxi
	diWALgTYy4kQLTkP4CA/pttDGlUg57SUc4gsLupGuBZCKtIfsU17UCfUnPHGTQavm+ySvS
	EV+XsLzjlgv4JxRkze3iPDTclHGxWv4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-OTKM4QN8Oh-vZU-WiirFxQ-1; Tue,
 06 Oct 2026 09:31:37 -0400
X-MC-Unique: OTKM4QN8Oh-vZU-WiirFxQ-1
X-Mimecast-MFC-AGG-ID: OTKM4QN8Oh-vZU-WiirFxQ_1791293495
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23CFD193E884;
	Tue,  6 Oct 2026 13:31:35 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.90])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77A273001D2A;
	Tue,  6 Oct 2026 13:31:31 +0000 (UTC)
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
Subject: [PATCH net v12 15/15] rxrpc: fix use-after-free in rxrpc_poke_conn()
Date: Tue,  6 Oct 2026 14:30:07 +0100
Message-ID: <20261006133011.531806-16-dhowells@redhat.com>
In-Reply-To: <20261006133011.531806-1-dhowells@redhat.com>
References: <20261006133011.531806-1-dhowells@redhat.com>
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

