Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604247CA8A
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351059; cv=none; b=kB+OFs8eOmVkfZwICJSSVBuWAyJ5TPFx/8Xptcgi9Z7cvKuDVcfEWNGXI6pI4oQQoery4MUiwCKVTv1fKKZLgca44z4wQnbQh4Wdg4u7/qvx38NF+ggoAyItM2CALz5+RYYgvzhUeQgb9Arvq3yhYOdky+A6pPCkHlw0mnq5zxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351059; c=relaxed/simple;
	bh=sBl+pLkIcu58O58s03FOD2iBRo8SAQetohj3cHGNr7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohMW7nxZX9i/JA0tlCiv6Nm0G+GlVQQv9YBUUxQoGz7LhXbZZlg/o4Xh8O5abtQUOCfBhP6rE7aBxT4Vbc/MV2NSypRpcQGkxNpgOgoQPmr3UePywtUnCBg2uLP2sqzoNIAmvksb2GFKNdBrzYtOBCjq7DOApEWtgdGoUmp2NBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzBwbfTV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzBwbfTV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788351051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Plgr/hKSkLRXyY3mXsUHN2X576dkoAmpPrwo5diFJs=;
	b=BzBwbfTVnmcAC+ZFMK69wMj6Jnh/CHzb3vWfTPbRYBejYcwzkIi7OjFgwbKg5aFOaKnyRM
	LetsDSZInqDMTH8+mEOufhQFHuPTuKkoGdWywHg5w2E08UuR/vazEnkrBrN4rPrgibECEn
	ETpIl5sGSTg9aIMNrCGGB4X4Qzd9d4Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-ChXDD57XPmKblE2D58IHpg-1; Wed,
 02 Sept 2026 08:10:47 -0400
X-MC-Unique: ChXDD57XPmKblE2D58IHpg-1
X-Mimecast-MFC-AGG-ID: ChXDD57XPmKblE2D58IHpg_1788351046
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93AE8180121E;
	Wed,  2 Sep 2026 12:10:46 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F124C1800642;
	Wed,  2 Sep 2026 12:10:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] afs: Fix incorrect free in candidate cleanup in afs_lookup_server()
Date: Wed,  2 Sep 2026 13:10:21 +0100
Message-ID: <20260902121024.3328255-4-dhowells@redhat.com>
In-Reply-To: <20260902121024.3328255-1-dhowells@redhat.com>
References: <20260902121024.3328255-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix afs_lookup_server() to not free an existing server's endpoint state
when cleaning up a candidate server.  The candidate record doesn't have an
endpoint state yet at this point, so the free for that can just be removed.

Fixes: 4882ba78574e ("afs: Fix afs_server ref accounting")
Link: https://sashiko.dev/#/patchset/20260729160108.2031453-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/afs/server.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index 0fe162ea2a36..189138bd6d71 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -242,7 +242,6 @@ struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 out:
 	afs_put_addrlist(alist, afs_alist_trace_put_server_create);
 	if (candidate) {
-		kfree(rcu_access_pointer(server->endpoint_state));
 		kfree(candidate);
 		afs_dec_servers_outstanding(cell->net);
 	}

