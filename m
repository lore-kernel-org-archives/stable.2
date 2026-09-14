Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57549BD65
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398892; cv=none; b=qmV/GeL/O5e1mot0nlkSItf/gThaCK65CzWGq9QNj/KO2TGEuYnFf3AZ+h/BQnevh1mTFBK8lxBxXQE916/2QXIwDyPNE74dDOv/YK/YeaPGxeX/rALZoelYe//RcfOlGvuPnUy/F08Zm2k6pes+POJbKNPDkqJq1j2oFopXU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398892; c=relaxed/simple;
	bh=dh1Mrzcf+f+rjoBXTJvcOxtnk9SkdiWfNRAvyCc0RxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP9bK13S3hKAxqesZEaPbF16aaWxJRKFSMjb94x/oTKPvl6Gf5wxKe3ZDd4i7gcC5yhB8FbYtJ6ZrPyrXLPDfnezDnnYhgJFlmoiIF02oYzlWJx9+QtY5CuQkL5/mqLjP+JiOeSazTxIYPkWgULFwmZIcKhxO3FocfQhfAFwtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IalhPHxY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IalhPHxY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789398888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XWJhOFpUonxJbFBVSNDuN9cV/WjNeJgeL08PIPjZ7A=;
	b=IalhPHxY4s+Oe618KwLnviV44iL+JM2e0yrI5qTIzzidYz3SEEEkC5xWcAQiSAVMT49ytb
	B5bMy0WIrpqQH4b/5NcyIgp9YXTomKucc6SqeXsEUq9rwePvZ65jerXiVe0FdG3wDWuWZX
	btlFEWR5/NvEI6vdCfgw2Y9e2sDy6Kw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-PcsrAKv7Obe0lTargPrb-A-1; Mon,
 14 Sep 2026 11:14:45 -0400
X-MC-Unique: PcsrAKv7Obe0lTargPrb-A-1
X-Mimecast-MFC-AGG-ID: PcsrAKv7Obe0lTargPrb-A_1789398883
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7600C195DBAA;
	Mon, 14 Sep 2026 15:14:43 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 663AF40E;
	Mon, 14 Sep 2026 15:14:40 +0000 (UTC)
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
Subject: [PATCH net v10 11/14] afs: Fix creation of RxGK CM channel token to have right size
Date: Mon, 14 Sep 2026 16:13:35 +0100
Message-ID: <20260914151340.3227501-12-dhowells@redhat.com>
In-Reply-To: <20260914151340.3227501-1-dhowells@redhat.com>
References: <20260914151340.3227501-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Fix afs_create_yfs_cm_token() so that it calculates the token size
correctly, remembering to add in the 4 bytes of the level.

As it happens, this bug has no effect because crypto_krb5_how_much_buffer()
rounds encsize up to a multiple of the crypto block size (16 or 32) before
adding on the checksum size - and so there's actually 8 bytes of unused
space allocated within the blob-to-be-encrypted and 4 bytes of that gets
used.

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

