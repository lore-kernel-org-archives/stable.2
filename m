Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586D4A3417
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781131; cv=none; b=qh1yi8x6KtSKYhNt8of6Gn/1t2B+rlzY1U6wFzQCt/tY/czWYK/BUpkFZzLO43dZFls2NlzR7/fF4c4BCTwniR5IuG65Vr+sWbXDjKVG+qkZjIa2jAW36B/4kNqcGLZE1n3WSiXnMRyAlzDjceMN7cFNWCjKIu9kJ7uzzvgpEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781131; c=relaxed/simple;
	bh=H8CelOzBhdyJycz+48X32xmmg9a1hcbq/jHJ8CGuWNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOSSq7qJGJxJkWEBW3MmVWrxacyB88/TOGJay9t9BL27PsuVZR0lIrLKNLkE+DpULFtC9DQ1O0L6zDeWxVMpKfLPP1tOIZTKAjE4VhdkfR+TQSAe40peOQ8fxq4sxeO4984vFrYR1dqNRMvVVSF9hTyczTBRWoQMLjNCJV/Q8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b04g5kEo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b04g5kEo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788781128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCtf6xRVznBmbNbbW++7i1w457e6VKnTXFN367d2vAQ=;
	b=b04g5kEoE9Ic61h4gGRr2Nz9yXOPcf5jcmLAFNBCig1T0ZrdATpyNlZ4+6SAh8PXEnKdA8
	99lLjr7ZUwD8I+bJtppASzI+FRrKHFU+49MYpAvy85s3PfxmBjuH/SjyQIXluk1MhBfn65
	OxyRUxx+Gm/o4E35zqwj6/AJaXt65AA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-yjjAAUx8NEKwFfGsxt4i4A-1; Mon,
 07 Sep 2026 07:38:43 -0400
X-MC-Unique: yjjAAUx8NEKwFfGsxt4i4A-1
X-Mimecast-MFC-AGG-ID: yjjAAUx8NEKwFfGsxt4i4A_1788781122
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02F921954AFF;
	Mon,  7 Sep 2026 11:38:42 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E45C71800257;
	Mon,  7 Sep 2026 11:38:38 +0000 (UTC)
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
	stable@vger.kernel.org
Subject: [PATCH net v9 10/14] rxrpc: Fix RxGK key parser to check enctype is supported
Date: Mon,  7 Sep 2026 12:37:37 +0100
Message-ID: <20260907113743.1453210-11-dhowells@redhat.com>
In-Reply-To: <20260907113743.1453210-1-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix the parser of RxGK keys supplied by userspace to check that the
specified encryption type is supported.

Fixes: 0ca100ff4df6 ("rxrpc: Add YFS RxGK (GSSAPI) security class")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
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
 net/rxrpc/key.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index a0aa78d89289..30d6db052c21 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -172,6 +172,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	const __be32 *ticket, *key;
 	s64 tmp;
 	size_t raw_keylen, raw_tktlen, keylen, tktlen;
+	int ret = -EKEYREJECTED;
 
 	_enter(",{%x,%x,%x,%x},%x",
 	       ntohl(xdr[0]), ntohl(xdr[1]), ntohl(xdr[2]), ntohl(xdr[3]),
@@ -229,6 +230,11 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	token->rxgk->key.data	= token->rxgk->_key;
 	token->rxgk->ticket.len = raw_tktlen;
 
+	if (!crypto_krb5_find_enctype(token->rxgk->enctype)) {
+		ret = -ENOPKG;
+		goto reject_token;
+	}
+
 	if (token->rxgk->endtime != 0) {
 		expiry = rxrpc_s64_to_time64(token->rxgk->endtime);
 		if (expiry < 0)
@@ -280,7 +286,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	kfree(token->rxgk);
 	kfree(token);
 reject:
-	return -EKEYREJECTED;
+	return ret;
 expired:
 	kfree(token->rxgk);
 	kfree(token);

