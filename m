Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2314772B7
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781134; cv=none; b=D02uLBNqvbsovytGtUl3VjXR/gCiWmlxkJEXdDwUgkjs5FcXjxYHoJZJ7nDla7a71bQP+KDTZXuDPmZWncebxX44WCY4eRHrf9nED1MBeDFP5V1/GWPO2qHqxqTeEduqIH171buC98jVL9M4GKUKjwW+C0PrWFfbB1whEXIU9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781134; c=relaxed/simple;
	bh=4rulRz/ACvzdMV65PymqWxPemkbqAcLLi8c99C7xCYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if9VpLp5aQGOVAxP9f0Dstm0N7MZSnxsC2MjufvtyEk3TgBjTXlxATmfLgdJDpFiTAPjF2tp5cbjFrm4/j53711FGExDobwXI8+Pb4dPeW2hgsRtHWouLvgYoWmJWPj8WNfIqx7UyEN+fxnhSo/YgWiHFA4F9t+d0BdNJe8hdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhN0uDR3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhN0uDR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788781131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPG3JCWqVjH93XC+uYutRtQ5wp+gmwXzPifpp4N5UQY=;
	b=JhN0uDR3IhLOlWU+uDWVAj4/mtXrC00B7Eknn3771gBkBr/SiVKJpNz4oD2tk1MWnc81zs
	nGkjkd00fA4HNvRDHungdljbA4FlCneELLuKeMHSXZw0eAFKPnR/c32gXAGV3OQ6MGQHlG
	wUwn8ASxjZhC+132jcn3Og3c5MmwRm8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-oAm3Z8qOPM-i-l067vioqA-1; Mon,
 07 Sep 2026 07:38:48 -0400
X-MC-Unique: oAm3Z8qOPM-i-l067vioqA-1
X-Mimecast-MFC-AGG-ID: oAm3Z8qOPM-i-l067vioqA_1788781126
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A116F19540DB;
	Mon,  7 Sep 2026 11:38:46 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8901130001A2;
	Mon,  7 Sep 2026 11:38:43 +0000 (UTC)
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
Subject: [PATCH net v9 11/14] afs: Fix creation of RxGK CM channel token to have right size
Date: Mon,  7 Sep 2026 12:37:38 +0100
Message-ID: <20260907113743.1453210-12-dhowells@redhat.com>
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

