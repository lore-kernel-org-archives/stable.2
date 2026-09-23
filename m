Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430825304C8
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170696; cv=none; b=jdqT2NOoB/LA6VRvCA8ptG5EWabGHK+d6tZoBMnI5lmVj7Om4VKX247Ay/ekDNVu9cHCtNQQ71K4yBqYo4i7sRJRoke7GQz1gtshOmTcTjdhwnrQ+GUikptAr8B2jllOsjwf6IuRHZ/VKHYQFwGe6/e5QUf4CtA7US4f8ydrPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170696; c=relaxed/simple;
	bh=qz07hn8lQ4THyuIIoFyqLIU4DrrAhB80BdiWn82oR14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJJaNJZo2CgSzaTKmLWkt2jOcha6wIbSXcnWzH01SBZdtxtgXW3LFRKNmlpSpAH6lwfAcReP3byVigWku6B9YxiMBFLiVduO+VSp2aCeLJY32xNRU0CQv4FwS4lqVCsqs10UDxnfYEIAxhYxyS2h2o6KjNanl2IjjSyuujJU15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hkzwaxg+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hkzwaxg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/q/mU7BulScXkOh99fPoWpNQXaPupXrst3HyJERiYw=;
	b=Hkzwaxg+Zjf2ZTtc7dNaS8dYEJHxZLKeGgmTlmrjftt80FPpW5cdhUksWWNN0GwJs1wXfS
	K/nFb8d53dWnshM9ZoUs7Yac+zEZnkkBkUKTSdjereF9QoduNxTkI8FJxJnAnDzz3gLluA
	EA5jKSqwzOlh3E8ZKWLYpjUJ1Yl1Sjw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-koHRPuZSNOCilL-ykx51jQ-1; Wed,
 23 Sep 2026 09:38:10 -0400
X-MC-Unique: koHRPuZSNOCilL-ykx51jQ-1
X-Mimecast-MFC-AGG-ID: koHRPuZSNOCilL-ykx51jQ_1790170688
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 935E41800679;
	Wed, 23 Sep 2026 13:38:08 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 452A41956042;
	Wed, 23 Sep 2026 13:38:05 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>,
	stable@vger.kernel.org
Subject: [PATCH net v11 10/17] rxrpc: Fix return in rxrpc_recvmsg_data() for service calls
Date: Wed, 23 Sep 2026 14:36:57 +0100
Message-ID: <20260923133706.1496540-11-dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-1-dhowells@redhat.com>
References: <20260923133706.1496540-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When rxrpc_recvmsg_data() gets called on a service call that has received
all of the request, RXRPC_CALL_RECVMSG_READ_ALL has been set, and this
causes rxrpc_recvmsg_data() to jump straight out, indicating the end of the
call (ie. rxrpc_kernel_recv_data() returns 1) without waiting for the call
to be processed or the reply to be transmitted.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
---
 fs/afs/rxrpc.c      |  4 ++--
 net/rxrpc/recvmsg.c | 13 ++++++++++---
 net/rxrpc/rxperf.c  |  4 ++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 0b9027549580..8e7a83a95ac9 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -542,7 +542,7 @@ void afs_deliver_to_call(struct afs_call *call)
 						     &call->service_id);
 			trace_afs_receive_data(call, &call->def_iter, false, ret);
 
-			if (ret == -EINPROGRESS || ret == -EAGAIN)
+			if (ret == -EAGAIN || ret == 2)
 				return;
 			if (ret < 0 || ret == 1) {
 				if (ret == 1)
@@ -932,7 +932,7 @@ int afs_extract_data(struct afs_call *call, bool want_more)
 		return ret;
 
 	state = READ_ONCE(call->state);
-	if (ret == 1) {
+	if (ret == 1 || ret == 2) {
 		switch (state) {
 		case AFS_CALL_CL_AWAIT_REPLY:
 			afs_set_call_state(call, state, AFS_CALL_CL_PROC_REPLY);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index efcba4b2e74f..716f7f47d7e4 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -637,9 +637,11 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  * Note that we may return %-EAGAIN to drain empty packets at the end
  * of the data, even if we've already copied over the requested data.
  *
- * Return: %0 if got what was asked for and there's more available, %1
- * if we got what was asked for and we're at the end of the data and
- * %-EAGAIN if we need more data.
+ * Return: %0 if got what was asked for and there's more available, %1 if we
+ * got what was asked for and we're at the end of the call, %2 if a service
+ * call received all of the request but is still in progress and %-EAGAIN if we
+ * need more data.  A variety of other errors can be returned if the call
+ * completed with failure.
  */
 int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 			   struct iov_iter *iter, size_t *_len,
@@ -678,6 +680,11 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 
 read_phase_complete:
 	ret = 1;
+	if (rxrpc_is_service_call(call)) {
+		if (rxrpc_call_is_complete(call))
+			goto call_failed;
+		ret = 2;
+	}
 out:
 	if (_service)
 		*_service = call->dest_srx.srx_service;
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 5042e8bfca55..6ccfd40b5388 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -300,7 +300,7 @@ static void rxperf_deliver_to_call(struct work_struct *work)
 						     &len, false, &remote_abort,
 						     &call->service_id);
 
-			if (ret == -EINPROGRESS || ret == -EAGAIN)
+			if (ret == -EAGAIN || ret == 2)
 				return;
 			if (ret < 0 || ret == 1) {
 				if (ret == 1)
@@ -379,7 +379,7 @@ static int rxperf_extract_data(struct rxperf_call *call, bool want_more)
 	if (ret == 0 || ret == -EAGAIN)
 		return ret;
 
-	if (ret == 1) {
+	if (ret == 1 || ret == 2) {
 		switch (call->state) {
 		case RXPERF_CALL_SV_AWAIT_REQUEST:
 			rxperf_set_call_state(call, RXPERF_CALL_SV_REPLYING);

