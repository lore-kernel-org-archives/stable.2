Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480C4E1C66
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363753; cv=none; b=HzFQgtavvqPvWw4MOBra52gcTlLf3UUGnk629bKOBoZV/jIhvbUxYH31vfTrPR/6W/mQ5afzUbn3fcpTiHsic0fwbNODjDVu1gfv/LyM9KGbfw4ZKrVJw0g26ykEhdgvlR1RmeyhcHtL7AvUL+xMBm7lBV/wVe9ogTLKr73kPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363753; c=relaxed/simple;
	bh=JuXbN+6BvtavzaPnJsUC69JNx0dZ1qUHi3g5XhGnJfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFtvcFMTiMKEjG0Vq6+vc7aIa+hsRpK17EOaT/aTZgepIWTV6kftwl5EdrYI1wWAiHkTxoa+77s8uiMlWDQ/Fe/eUzUmfJVe39pHYnJxqVQCF3ZU18KZ0MSwbzneuTbj50YffG3nq5xwqGHOLQ9SQ5PvaoV1zsQl6ETHZTQYqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbUsDyUs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbUsDyUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790363746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6v8INefHSiPE7xI6RtsFWjIqkSMTeB9m2QgysI22Lbk=;
	b=XbUsDyUs2pXY5XGXCb3RLzXgHnW+X3/TUmuK8hK9piEyQ7qo4jrcglL1Xa+WU8VUZ2/mz+
	OT+VXLDHKgADspB5qkzCradtvCfdET8+Xs+iSjh+DG8g7rv6nW0XAbH85fkrmAdMcy3qwm
	TsqI07C2b9UoDHrcgdL5EBfuZcstFnY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-3C_V4URNNRa3G8dhfQsyRw-1; Fri,
 25 Sep 2026 15:15:42 -0400
X-MC-Unique: 3C_V4URNNRa3G8dhfQsyRw-1
X-Mimecast-MFC-AGG-ID: 3C_V4URNNRa3G8dhfQsyRw_1790363741
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AB89195E93D;
	Fri, 25 Sep 2026 19:15:40 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2FBE1800361;
	Fri, 25 Sep 2026 19:15:36 +0000 (UTC)
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
Subject: [PATCH net 1/2] rxrpc: Fix the comments saying RFC8958 to be RFC8985
Date: Fri, 25 Sep 2026 20:15:18 +0100
Message-ID: <20260925191520.2206700-2-dhowells@redhat.com>
In-Reply-To: <20260925191520.2206700-1-dhowells@redhat.com>
References: <20260925191520.2206700-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix the comments saying RFC8958 to be RFC8985 - ie. The RACK-TLP Loss
Detection Algorithm for TCP.

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
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
 net/rxrpc/ar-internal.h |  2 +-
 net/rxrpc/input_rack.c  | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab..f0c8cbcc5dd5 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1264,7 +1264,7 @@ void rxrpc_tlp_send_probe(struct rxrpc_call *call);
 void rxrpc_tlp_process_ack(struct rxrpc_call *call, struct rxrpc_ack_summary *summary);
 void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by);
 
-/* Initialise TLP state [RFC8958 7.1]. */
+/* Initialise TLP state [RFC8985 7.1]. */
 static inline void rxrpc_tlp_init(struct rxrpc_call *call)
 {
 	call->tlp_serial = 0;
diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 9eb109ffba56..072e1d9ecb2e 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* RACK-TLP [RFC8958] Implementation
+/* RACK-TLP [RFC8985] Implementation
  *
  * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
@@ -57,7 +57,7 @@ static unsigned long rxrpc_tq_nacks(const struct rxrpc_txqueue *tq)
 
 /*
  * Update the RACK state for the most recently sent packet that has been
- * delivered [RFC8958 6.2 Step 2].
+ * delivered [RFC8985 6.2 Step 2].
  */
 static void rxrpc_rack_update(struct rxrpc_call *call,
 			      struct rxrpc_ack_summary *summary,
@@ -98,7 +98,7 @@ static void rxrpc_rack_update(struct rxrpc_call *call,
 }
 
 /*
- * Detect data segment reordering [RFC8958 6.2 Step 3].
+ * Detect data segment reordering [RFC8985 6.2 Step 3].
  */
 static void rxrpc_rack_detect_reordering(struct rxrpc_call *call,
 					 struct rxrpc_ack_summary *summary,
@@ -143,7 +143,7 @@ void rxrpc_input_rack(struct rxrpc_call *call,
 }
 
 /*
- * Update the reordering window [RFC8958 6.2 Step 4].  Returns the updated
+ * Update the reordering window [RFC8985 6.2 Step 4].  Returns the updated
  * duration of the reordering window.
  *
  * Note that the Rx protocol doesn't have a 'DSACK option' per se, but ACKs can
@@ -192,7 +192,7 @@ static ktime_t rxrpc_rack_update_reo_wnd(struct rxrpc_call *call,
 }
 
 /*
- * Detect losses [RFC8958 6.2 Step 5].
+ * Detect losses [RFC8985 6.2 Step 5].
  */
 static ktime_t rxrpc_rack_detect_loss(struct rxrpc_call *call,
 				      struct rxrpc_ack_summary *summary)
@@ -239,7 +239,7 @@ static ktime_t rxrpc_rack_detect_loss(struct rxrpc_call *call,
 }
 
 /*
- * Detect losses and set a timer to retry the detection [RFC8958 6.2 Step 5].
+ * Detect losses and set a timer to retry the detection [RFC8985 6.2 Step 5].
  */
 void rxrpc_rack_detect_loss_and_arm_timer(struct rxrpc_call *call,
 					  struct rxrpc_ack_summary *summary)
@@ -255,7 +255,7 @@ void rxrpc_rack_detect_loss_and_arm_timer(struct rxrpc_call *call,
 }
 
 /*
- * Handle RACK-TLP RTO expiration [RFC8958 6.3].
+ * Handle RACK-TLP RTO expiration [RFC8985 6.3].
  */
 static void rxrpc_rack_mark_losses_on_rto(struct rxrpc_call *call)
 {
@@ -285,7 +285,7 @@ static void rxrpc_rack_mark_losses_on_rto(struct rxrpc_call *call)
 }
 
 /*
- * Calculate the TLP loss probe timeout (PTO) [RFC8958 7.2].
+ * Calculate the TLP loss probe timeout (PTO) [RFC8985 7.2].
  */
 ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
 {
@@ -309,7 +309,7 @@ ktime_t rxrpc_tlp_calc_pto(struct rxrpc_call *call, ktime_t now)
 }
 
 /*
- * Send a TLP loss probe on PTO expiration [RFC8958 7.3].
+ * Send a TLP loss probe on PTO expiration [RFC8985 7.3].
  */
 void rxrpc_tlp_send_probe(struct rxrpc_call *call)
 {
@@ -356,7 +356,7 @@ void rxrpc_tlp_send_probe(struct rxrpc_call *call)
 }
 
 /*
- * Detect losses using the ACK of a TLP loss probe [RFC8958 7.4].
+ * Detect losses using the ACK of a TLP loss probe [RFC8985 7.4].
  */
 void rxrpc_tlp_process_ack(struct rxrpc_call *call, struct rxrpc_ack_summary *summary)
 {

