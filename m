Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315850279A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791307; cv=none; b=GP3pXSbGlTpx0bzPoMbYokNuVpAU2LV+ndko84HTUDMCuIY00k1IYxStUHtYc4HjBXKYqqMOHHIdZU/3CU68+EOrAjfnaXyoVkVGfacRd/XOuhkenWzqLR2HQqxq+mKdTpOwNLmNKKkdU8izGtzVPCjeR5z48gJ3EnmarCaFWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791307; c=relaxed/simple;
	bh=fVsgPq0whtRKYAYetz0qKAjZkIA0410CSa0uKAt8mJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUYqxh914xXIJygBBcKMFWiAfp9snb0kF+vIbOtBkEbxITz6GH7AIWAtM2vC3l9uTyh7wjmPkJeHKZ38PCDMgHQVOk7ZDXqrwwjouVxjeolUGIGRG6AsWCzCgONe5gMFkR9z4sDoEwEBxpyjE9p0Oc08DEStHg5YB0v2vkvgaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJdKoe8e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJdKoe8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B4B1F00898;
	Wed, 30 Sep 2026 18:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791305;
	bh=UNcKXy9LxcWA2K2grlLwIw7eg0iTlqpm5qXxsdncbtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FJdKoe8eXiAaVHL2SiITs6+2jOb24XmpG3xy2i3+DmaBbUuwaOd6KrISYssDE83YY
	 v3G120VILVPmpydFOjvHWIj/5wVO5cafcCgbb8hY2y+10xsUDHEDH0f6PGJOeQCLnb
	 HAyOo272kKzK4kGWsgRkqA3NQakIakBhc6sR1gkoHqzZ2fiyGgPAvj6/JHJwgWwKue
	 hWYPXeGd7SLQ2t84eZZaa1yezQZB0D/bgFppK0umzoBY+nQyWhTVNJfGtwxRdTX8AR
	 3e8tkQ8zyWAsBLXfsEmiqnK/cz8sCKTOA8humpPIC4MUQghdOlhQ06RzQncNJI/X1B
	 2v4JEz6KAgFaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] smb: client: prevent new fids from being removed by laundromat
Date: Wed, 30 Sep 2026 14:01:41 -0400
Message-ID: <20260930180143.3974994-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092902-hacksaw-legwork-e770@gregkh>
References: <2026092902-hacksaw-legwork-e770@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 81ba10959970d15c388bf29866b01b62f387e6a3 ]

Check if @cfid->time is set in laundromat so we guarantee that only
fully cached fids will be selected for removal.  While we're at it,
add missing locks to protect access of @cfid fields in order to avoid
races with open_cached_dir() and cfids_laundromat_worker(),
respectively.

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

Stable dependency adaptation for d2ff5fb93ea8:

The 6.1 tree has no cached-directory laundromat worker or its supporting
fields, so omit the worker-only hunks instead of introducing that feature.

Keep the cache lookup and existing-lease check under one list lock, and
protect response parsing and publication of the cached directory. Move
the tcon assignment ahead of the request so the target's compound-response
error path can close a successful CREATE.

Use the existing close_cached_dir() for common error cleanup. Track whether
the prospective lease reference was handed to the cache so a concurrent
lease break cannot cause cleanup to drop that reference twice. Keep the
response and final cleanup context needed for d2ff5fb93ea8 to apply without
changes. No functions are added.

Stable-dep-of: d2ff5fb93ea8 ("smb: client: clean up failed cached directory opens")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cached_dir.c | 60 ++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index fca8656929399..f6c72c6567f9d 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -22,7 +22,6 @@ static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
 {
 	struct cached_fid *cfid;
 
-	spin_lock(&cfids->cfid_list_lock);
 	list_for_each_entry(cfid, &cfids->entries, entry) {
 		if (!strcmp(cfid->path, path)) {
 			/*
@@ -31,25 +30,20 @@ static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
 			 * being deleted due to a lease break.
 			 */
 			if (!cfid->has_lease) {
-				spin_unlock(&cfids->cfid_list_lock);
 				return NULL;
 			}
 			kref_get(&cfid->refcount);
-			spin_unlock(&cfids->cfid_list_lock);
 			return cfid;
 		}
 	}
 	if (lookup_only) {
-		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
 	if (cfids->num_entries >= MAX_CACHED_FIDS) {
-		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
 	cfid = init_cached_dir(path);
 	if (cfid == NULL) {
-		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
 	cfid->cfids = cfids;
@@ -57,7 +51,6 @@ static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
 	list_add(&cfid->entry, &cfids->entries);
 	cfid->on_list = true;
 	kref_get(&cfid->refcount);
-	spin_unlock(&cfids->cfid_list_lock);
 	return cfid;
 }
 
@@ -143,6 +136,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	struct cached_fid *cfid;
 	struct cached_fids *cfids;
 	const char *npath;
+	bool cached = false;
 
 	if (tcon == NULL || tcon->cfids == NULL || tcon->nohandlecache ||
 	    is_smb1_server(tcon->ses->server))
@@ -162,21 +156,21 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	if (!utf16_path)
 		return -ENOMEM;
 
+	spin_lock(&cfids->cfid_list_lock);
 	cfid = find_or_create_cached_dir(cfids, path, lookup_only);
 	if (cfid == NULL) {
+		spin_unlock(&cfids->cfid_list_lock);
 		kfree(utf16_path);
 		return -ENOENT;
 	}
-	/*
-	 * At this point we either have a lease already and we can just
-	 * return it. If not we are guaranteed to be the only thread accessing
-	 * this cfid.
-	 */
+	/* Return an existing leased fid while still holding the list lock. */
 	if (cfid->has_lease) {
+		spin_unlock(&cfids->cfid_list_lock);
 		*ret_cfid = cfid;
 		kfree(utf16_path);
 		return 0;
 	}
+	spin_unlock(&cfids->cfid_list_lock);
 
 	/*
 	 * Skip any prefix paths in @path as lookup_positive_unlocked() ends up
@@ -202,6 +196,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
+	cfid->tcon = tcon;
 	pfid = &cfid->fid;
 	server->ops->new_lease_key(pfid);
 
@@ -264,9 +259,10 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		}
 		goto oshr_free;
 	}
-	cfid->tcon = tcon;
 	cfid->is_open = true;
 
+	spin_lock(&cfids->cfid_list_lock);
+
 	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
 	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
 	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
@@ -274,13 +270,17 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	oparms.fid->mid = le64_to_cpu(o_rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
 
-	if (o_rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE)
+
+	if (o_rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE) {
+		spin_unlock(&cfids->cfid_list_lock);
 		goto oshr_free;
+	}
 
 	rc = smb2_parse_contexts(server, rsp_iov,
 			    &oparms.fid->epoch,
 			    oparms.fid->lease_key,
 			    &oplock, NULL, NULL);
+	spin_unlock(&cfids->cfid_list_lock);
 	if (rc)
 		goto oshr_free;
 	if (!(oplock & SMB2_LEASE_READ_CACHING_HE))
@@ -304,12 +304,14 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 			goto oshr_free;
 		}
 	}
+	spin_lock(&cfids->cfid_list_lock);
 	cfid->dentry = dentry;
 	cfid->time = jiffies;
 	cfid->has_lease = true;
+	cached = true;
+	spin_unlock(&cfids->cfid_list_lock);
 
 oshr_free:
-	kfree(utf16_path);
 	SMB2_open_free(&rqst[0]);
 	SMB2_query_info_free(&rqst[1]);
 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
@@ -324,27 +326,21 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		rc = -ENOENT;
 	}
 	spin_unlock(&cfids->cfid_list_lock);
-	if (!rc && !cfid->has_lease) {
-		/*
-		 * We are guaranteed to have two references at this point.
-		 * One for the caller and one for a potential lease.
-		 * Release the Lease-ref so that the directory will be closed
-		 * when the caller closes the cached handle.
-		 */
-		kref_put(&cfid->refcount, smb2_close_cached_fid);
-	}
+	/*
+	 * A new entry has a caller reference and a prospective lease reference.
+	 * Release the latter unless it was handed to the cache.  Once cached,
+	 * lease-break or invalidation work owns that reference, even if it has
+	 * already cleared has_lease by the time we get here.
+	 */
+	if (!cached)
+		close_cached_dir(cfid);
 	if (rc) {
-		if (cfid->is_open)
-			SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
-				   cfid->fid.volatile_fid);
-		free_cached_dir(cfid);
-		cfid = NULL;
-	}
-
-	if (rc == 0) {
+		close_cached_dir(cfid);
+	} else {
 		*ret_cfid = cfid;
 		atomic_inc(&tcon->num_remote_opens);
 	}
+	kfree(utf16_path);
 
 	return rc;
 }
-- 
2.53.0

