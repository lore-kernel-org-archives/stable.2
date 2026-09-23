Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC55372FC
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170717; cv=none; b=bK8+d6qnb1jnXc8KAdWgaM0FkJEEghnU/M78+KYWXZ4UVZW6monaA7KSSYHOV2N0TooYtq0JN3on9HltQIOhUHJwzRPeJYtvDp0uB+RhRgKwASyATSrvtuqDCEVL++qcPS9Zq9JvnXsokiLbb2dBtIBECnqYsiBpMNl89ICzo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170717; c=relaxed/simple;
	bh=4rulRz/ACvzdMV65PymqWxPemkbqAcLLi8c99C7xCYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4QfCw1ow8Mo2m58vyphd/6y/WqO40vwVYqG/AOkyhcQ0dTgTjERoIQzTlcIBQhNBobKApLkPlsCH1ELqCRNke/kc5VKjJJVgofeixoJtjPM7/q2ySmVMceFtHPB+qA1v1JeTczGMkAr1ibZiVGJZNxYBE+gC6Fn8kfjPfoTuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKxdA5f1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKxdA5f1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPG3JCWqVjH93XC+uYutRtQ5wp+gmwXzPifpp4N5UQY=;
	b=BKxdA5f1vCLLi8gYiDXi4UeuzLVDHFJKhfi+8iMP4E3zx9XNav39EHm+tWQBKSVkLXwy6x
	3aOQZt85904Tt3frf9obWeaEQ99ZfBkqg7tCIwMQykFM05dF0iAfgov6woDYTZrFPAlmS7
	31Y90aEL99joM40Fn5y5cvPXlmQFWOg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-RunEewxrMmy8GXkfaE6xOQ-1; Wed,
 23 Sep 2026 09:38:31 -0400
X-MC-Unique: RunEewxrMmy8GXkfaE6xOQ-1
X-Mimecast-MFC-AGG-ID: RunEewxrMmy8GXkfaE6xOQ_1790170708
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 700551955EAB;
	Wed, 23 Sep 2026 13:38:28 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48CC51800473;
	Wed, 23 Sep 2026 13:38:25 +0000 (UTC)
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
Subject: [PATCH net v11 14/17] afs: Fix creation of RxGK CM channel token to have right size
Date: Wed, 23 Sep 2026 14:37:01 +0100
Message-ID: <20260923133706.1496540-15-dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-1-dhowells@redhat.com>
References: <20260923133706.1496540-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix afs_create_yfs_cm_token() so that it calculates the token size
correctly, remembering to add in the 4 bytes of the level.

Fixes: d98c317fd9aa ("afs: Use rxgk RESPONSE to pass token for callback channel")
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
 fs/afs/cm_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
index 103168c70dd4..5eeeef761cf3 100644
--- a/fs/afs/cm_security.c
+++ b/fs/afs/cm_security.c
@@ -235,7 +235,7 @@ static int afs_create_yfs_cm_token(struct sk_buff *challenge,
 	 *	struct RXGK_AuthName	identities<>;
 	 * };
 	 */
-	toksize = keysize + 8 + 4 + 4 + 8 + xdr_len_object(authsize);
+	toksize = keysize + 4 + 8 + 4 + 4 + 8 + xdr_len_object(authsize);
 
 	offset = 0;
 	encsize = crypto_krb5_how_much_buffer(token_krb5, KRB5_ENCRYPT_MODE, toksize, &offset);

