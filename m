Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8DF4ADD8E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781150; cv=none; b=DB1SRivOr3/+mLHGlBr/oyRL4zkInbH7/TWjQg/VWJXs1/mAykhR3U2efjxnyizXSLFJJv55rYzrQKengEFn8ox1XZzFxYgC2po8N6RHPLfOzJZ8zQ7CHC8iwncyPwpM8houQoL5xqJjRx1p7xho+EDjoAq+boLkLfWJvNkwrgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781150; c=relaxed/simple;
	bh=dq6JvsI/jNN+xx3oqp5h32L/PtDtEz2jrI6gO+wTr7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSzPjdHs72KSkNZZlrjISVv6iq8jkeixTjxbWb03bWPPmTJH0NrKVRuGXZqxkK3a5YjnehkFqZYlA6Pn/Rn4LIv8mUQPBYIXSdm0iYbmjgh+YdigzmkGZqEC9bg5NDICyaRMDZyif36W0lxw4VGU7TNoAwDsf+VyrExnxgC7G1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaTtEw/J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaTtEw/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788781147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bnZX78xLpA1SrjplgD6zRqvHIJMbFWF4J8SNmE5f/c=;
	b=MaTtEw/JH2jNVErzqMPLkSZopbGSBC+o6HrVxl+dp6ztQ15u5OQTaD57HrDmkt15WwzZfS
	jq3QyuRSsC45PouJ4rPnYrr1E5gU0aGka5K5Iz6F2FHx6zplCc3QE8TwhHW4AE+TB9116x
	+EPDOUpVUAfVhIvmijX9zlZAnmFNLOk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-7O9EPnsDOuaN2S2plpZ7wA-1; Mon,
 07 Sep 2026 07:39:04 -0400
X-MC-Unique: 7O9EPnsDOuaN2S2plpZ7wA-1
X-Mimecast-MFC-AGG-ID: 7O9EPnsDOuaN2S2plpZ7wA_1788781142
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A70201828AD4;
	Mon,  7 Sep 2026 11:39:02 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6234D1956042;
	Mon,  7 Sep 2026 11:38:59 +0000 (UTC)
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
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v9 14/14] rxrpc: Take write lock when publishing the initial RxGK key
Date: Mon,  7 Sep 2026 12:37:41 +0100
Message-ID: <20260907113743.1453210-15-dhowells@redhat.com>
In-Reply-To: <20260907113743.1453210-1-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Chengfeng Ye <nicoyip.dev@gmail.com>

rxgk_rekey() updates the transport-key ring under security_use_lock,
and rxgk_get_key() takes a reference under the corresponding read
lock.  The initial publication in rxgk_init_connection_security()
writes conn->rxgk.enctype and conn->rxgk.keys[] without the write
lock.

On a client connection, a second sendmsg can observe
RXRPC_CONN_CLIENT through a lockless load of conn->state, skip
rxrpc_init_client_conn_security(), and call rxgk_get_key() without
ever acquiring security_lock.  Because the initializer never took
the write lock, the reader's read lock provides neither exclusion
nor a matching acquire-release pair.

Concurrent RxGK key consumers were observed in a two-sender
workload.  KCSAN reported:

  BUG: KCSAN: data-race in rxgk_get_key / rxgk_secure_packet

  write to 0xffff8aef4023c318 of 8 bytes by task 1968 on cpu 0:
   rxgk_secure_packet+0x46c/0x820
   rxrpc_send_data+0x562/0x1a20
   rxrpc_do_sendmsg+0x976/0xa80
   rxrpc_sendmsg+0x20f/0x2a0

  read to 0xffff8aef4023c318 of 8 bytes by task 1969 on cpu 1:
   rxgk_get_key+0x209/0x5e0
   rxgk_alloc_txbuf+0xa4/0x2a0
   rxrpc_send_data+0x8e2/0x1a20
   rxrpc_do_sendmsg+0x976/0xa80
   rxrpc_sendmsg+0x20f/0x2a0

  value changed: 0x7fffffffffffffff -> 0x7fffffffffffffee

That report is on the key context's byte counter rather than the
initial publication, but it shows that lookup and secured transmit
already overlap on the same connection.

Take security_use_lock for writing while publishing the initial
enctype and transport key, matching the locking used when rekeying.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
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
 net/rxrpc/rxgk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 77a67ace1d24..b49221f57f67 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -251,8 +251,10 @@ static int rxgk_init_connection_security(struct rxrpc_connection *conn,
 					 GFP_NOFS);
 	if (IS_ERR(gk))
 		return PTR_ERR(gk);
+	write_lock(&conn->security_use_lock);
 	conn->rxgk.enctype = gk->krb5->etype;
 	conn->rxgk.keys[gk->key_number & 3] = gk;
+	write_unlock(&conn->security_use_lock);
 
 	switch (conn->security_level) {
 	case RXRPC_SECURITY_PLAIN:

