Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236A4BCABB
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334641; cv=none; b=BX8leY1Nq8sWKmNECHsElHBgoDEEhvrvT+cFMvTiKXzX+efsm+0krkk9JviEU9gsXlX614mF+EpINZPG2zpUWZ1Lz7dcWwVrKT8PosU4osrGIVw7ChSvl75K0CZEWSnOp8aqTQRlUskQXfRoxspu685tJb40hC8TLfpbUMLApDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334641; c=relaxed/simple;
	bh=NhQmeJ7xXtC2qhhuZdlM1pf4BctUAxpJW0Z9jOz1lXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyFl9oGkeIOpjI1pUIu2sNtgJrjiPD6hpq/Y5SWe1KWdZB5WkiXHDWnoxv8KKMGKjq7/Xbp0OqQN/eZa2psbyJ/mVcZeLKdMRVt9dcgg6cfpdwg82CqA/wtyAjyymc/7+KbcNMH1h0qOf7j+hXDuxQbpYk1RCyCq2FWOa7sA5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aa9ysoMw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aa9ysoMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785334638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQ4xYgPisX1eloJMBrUIHWw1g1geoI0YKTxulh3uSC0=;
	b=Aa9ysoMwNR8Tnl3Rsz/fNEQrMi7DSBe5f5rRQ+0QT6ISTWyQByTJA4rWyV8Ayt6BGAfcV8
	t0xWeH3VYuLf4EQ9vkBmAd9uef5ZBME9e+kA4YTXfl4Coko4V/czR70hK2RnneOrYFLdYA
	nJk7wZE1XX1wbgEryOUdwk8WTJtfN4k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-UxrhIQrBNFK1JgoZYsij3w-1; Wed,
 29 Jul 2026 10:17:17 -0400
X-MC-Unique: UxrhIQrBNFK1JgoZYsij3w-1
X-Mimecast-MFC-AGG-ID: UxrhIQrBNFK1JgoZYsij3w_1785334636
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB9C91956040;
	Wed, 29 Jul 2026 14:17:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4878D19560AB;
	Wed, 29 Jul 2026 14:17:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] afs: Fix missing kunmap in afs_dir_search_bucket()
Date: Wed, 29 Jul 2026 15:17:03 +0100
Message-ID: <20260729141705.1977658-2-dhowells@redhat.com>
In-Reply-To: <20260729141705.1977658-1-dhowells@redhat.com>
References: <20260729141705.1977658-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix afs_dir_search_bucket() to kunmap the block it's using in the "bad:"
path.

Fixes: a5b5beebcf96 ("afs: Use the contained hashtable to search a directory")
Closes: https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/afs/dir_search.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/dir_search.c b/fs/afs/dir_search.c
index 104411c0692f..4977ad81fa82 100644
--- a/fs/afs/dir_search.c
+++ b/fs/afs/dir_search.c
@@ -173,12 +173,11 @@ int afs_dir_search_bucket(struct afs_dir_iter *iter, const struct qstr *name,
 
 	ret = -ENOENT;
 found:
+bad:
 	if (iter->block) {
 		kunmap_local(iter->block);
 		iter->block = NULL;
 	}
-
-bad:
 	if (ret == -ESTALE)
 		afs_invalidate_dir(iter->dvnode, afs_dir_invalid_iter_stale);
 	_leave(" = %d", ret);

