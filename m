Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67374472F6A
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351054; cv=none; b=helj7INSk1sdovkleF2JN32Mgs/Kpf/zyqNFlIV6PTvbeUZqUrdzUXy5kdPa6T3//zbwmglFidAQPJcq9Znk15Osm+IT85Fo+k6S4nelw0qSNuMgsz8Qa1XyARLlQEB/Lstrk3mFz60avYckVwblu0GnWhxk1AgSsVMSLnMqGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351054; c=relaxed/simple;
	bh=AhEHvXnlqjhULJbnLscjMcsqHiQQVTqFOXFaQMY9Rrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l60CbpOUHwTTXU9CUY3IQePXBcJJVbQAMWcnjJsMa+RPbezWdJMsXEZV31gwyzVw5qRCiyoMkGZOSpprsmUlrO45aaa6YaEKIlzNBjKrrrHRz5YMbS58CP1TPbBnRfNwCuOdPOzSepgalHS7lQndkF+l1AtUHYWeDO7aThFdk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9ZXj05d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9ZXj05d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788351047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ao17jtkcyHXF1zZt5SJ094Pq8EcCzBFJGX1iQ8ssRM0=;
	b=C9ZXj05dtKkqA7eLmMlgJiVs1CZ+CPAczEG8dzcsdKd13qIi1N1h6+46J+bHEcL1ktCeur
	DgsavY4BXZ+AnNUnqJ2JlPRLJtDhUFG/8CN8zOuTm0L1Bg0TrKTgfdH4sUldIn3i3ZDXJe
	sdRTzmjSAAcwD3YzEGpOltF7aSdbkJw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-ns0KasSFMmqF1CpdtDu04w-1; Wed,
 02 Sept 2026 08:10:43 -0400
X-MC-Unique: ns0KasSFMmqF1CpdtDu04w-1
X-Mimecast-MFC-AGG-ID: ns0KasSFMmqF1CpdtDu04w_1788351042
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EAEB1933E82;
	Wed,  2 Sep 2026 12:10:42 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70AAA1800577;
	Wed,  2 Sep 2026 12:10:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] afs: Fix double-unmap of directory block
Date: Wed,  2 Sep 2026 13:10:20 +0100
Message-ID: <20260902121024.3328255-3-dhowells@redhat.com>
In-Reply-To: <20260902121024.3328255-1-dhowells@redhat.com>
References: <20260902121024.3328255-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix afs_edit_dir_remove() to use a cleanup function to unmap the block
pointed to by afs_dir_iter::block if it's left pointing to something rather
than manually kunmapping the blocks.  Manually kunmapping without clearing
iter.blocks can result in a double-kunmap if afs_dir_find_block() is called
twice in a row (which would be the case if the block being modified is not
first in the hash chain).

Fixes: a5b5beebcf96 ("afs: Use the contained hashtable to search a directory")
Closes: https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/afs/dir_edit.c   |  9 ++-------
 fs/afs/dir_search.c | 10 ++--------
 fs/afs/internal.h   |  8 ++++++++
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 3ead36a07048..c31303059444 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -442,7 +442,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	/* Check and clear the entry. */
 	de = &block->dirents[slot];
 	if (de->u.valid != 1)
-		goto error_unmap;
+		goto error;
 
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete, b, slot,
 			   ntohl(de->u.vnode), ntohl(de->u.unique),
@@ -458,7 +458,6 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	/* Clear the constituent entries. */
 	next = de->u.hash_next;
 	memset(de, 0, sizeof(*de) * iter.nr_slots);
-	kunmap_local(block);
 
 	/* Adjust the hash chain: if iter->prev_entry is 0, the hashtable head
 	 * index is previous; otherwise it's slot number of the previous entry.
@@ -485,7 +484,6 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 		pde = &pblock->dirents[ps];
 		prev_next = pde->u.hash_next;
 		if (prev_next != htons(entry)) {
-			kunmap_local(pblock);
 			pr_warn("%llx:%llx:%x: not prev in chain b=%x p=%x,%x e=%x %*s",
 				vnode->fid.vid, vnode->fid.vnode, vnode->fid.unique,
 				iter.bucket, iter.prev_entry, prev_next, entry,
@@ -493,7 +491,6 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 			goto error;
 		}
 		pde->u.hash_next = next;
-		kunmap_local(pblock);
 	}
 
 	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
@@ -503,18 +500,16 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	_debug("Remove %s from %u[%u]", name->name, b, slot);
 
 out_unmap:
+	afs_dir_end_iter(&iter);
 	kunmap_local(meta);
 	_leave("");
 	return;
 
 already_invalidated:
-	kunmap_local(block);
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_inval,
 			   0, 0, 0, 0, name->name);
 	goto out_unmap;
 
-error_unmap:
-	kunmap_local(block);
 error:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_error,
 			   0, 0, 0, 0, name->name);
diff --git a/fs/afs/dir_search.c b/fs/afs/dir_search.c
index 4977ad81fa82..11ebdfffcb1d 100644
--- a/fs/afs/dir_search.c
+++ b/fs/afs/dir_search.c
@@ -75,10 +75,7 @@ union afs_xdr_dir_block *afs_dir_find_block(struct afs_dir_iter *iter, size_t bl
 
 	_enter("%zx,%d", block, slot);
 
-	if (iter->block) {
-		kunmap_local(iter->block);
-		iter->block = NULL;
-	}
+	afs_dir_end_iter(iter);
 
 	if (dvnode->directory_size < blend)
 		goto fail;
@@ -174,10 +171,7 @@ int afs_dir_search_bucket(struct afs_dir_iter *iter, const struct qstr *name,
 	ret = -ENOENT;
 found:
 bad:
-	if (iter->block) {
-		kunmap_local(iter->block);
-		iter->block = NULL;
-	}
+	afs_dir_end_iter(iter);
 	if (ret == -ESTALE)
 		afs_invalidate_dir(iter->dvnode, afs_dir_invalid_iter_stale);
 	_leave(" = %d", ret);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 290873bac89b..330654ed16ec 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1133,6 +1133,14 @@ int afs_dir_search_bucket(struct afs_dir_iter *iter, const struct qstr *name,
 int afs_dir_search(struct afs_vnode *dvnode, const struct qstr *name,
 		   struct afs_fid *_fid, afs_dataversion_t *_dir_version);
 
+static inline void afs_dir_end_iter(struct afs_dir_iter *iter)
+{
+	if (iter->block) {
+		kunmap_local(iter->block);
+		iter->block = NULL;
+	}
+}
+
 /*
  * dir_silly.c
  */

