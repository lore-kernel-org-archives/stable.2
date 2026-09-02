Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738049480D
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352839; cv=none; b=nV8HIoVhfUudHqd81xW3aoa6DrZd3KDA7pu6fRUxsn+f/Zz22mZe7bCDcgQaK2Wzz7iivmGvuin4O0Y4Bigpamd+y95fFf4hxeF6PPQwEEddIMOjsec/5oqitXanrLUASv2Um7tR0ykjka124GQ+OpxuGSaH7x9zM5liFmnoOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352839; c=relaxed/simple;
	bh=KbRa9OXMvWHbzr+Yyu5aHHJkUVl5pkx6HyWv8NOq5RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCRzicwdgUYZ4vNzDo7CjHz9IdjONrJlbY+CDNUpDaB5roaPCDLPeGCmGH2RtCZw41YOtEG2G5E17s6/6uAXh2Oro1XKkaaZ0xMuw3etahscyMmKO4pkzq/hFvq3Qkyd5/VXQPCNHexphYrQQU5Y1dO65RZLaRjroyjr84Ae0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hJzghgaQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hJzghgaQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so9088485e9.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788352833; x=1788957633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dduSWCdsI4IWacKJ2a51JLCsc2/3qyPJmTbv/oB0hkY=;
        b=hJzghgaQoHUSsm/XrXDPfiaHYSJCe2yYOQedKFbBkrfUqhO1OpszszTM/1YickVNoh
         MlcBLrurF1LDKE9isyOsrw9WQSQL+Fguij+onxURhVXFODPTbFPRNu5+XMFVzQFzhTFm
         Y03anrgCXOzkeC9ddHJJBKZ7PPtidn3pd4SN3o0E9otTScr59SzFYL1qQgPWvFzDUOHF
         JGX1sDSffYDHk6DhtIqQtlZAQOMP5Unw8gGtiSJvATUZQJ3S7ub9Ce0hu+Uk6zfApaCI
         S4d1lu1NCM5jxH4O3+OFX7cQbcVk2YwNsxX28ULWhWG8P6BpwZGIeWi+fMmgU7dqPoc0
         gJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352833; x=1788957633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dduSWCdsI4IWacKJ2a51JLCsc2/3qyPJmTbv/oB0hkY=;
        b=pPCKWuTp3AdzqJ3Os4le+l992iVFJPbpfe4m2QTInc+b250fNAxyYFy/f5yaQ4AdWQ
         YR4jrvkxjecwbm0A2KlEv6O/O5gOad/wOgQ5hRlzGE3Qc4+bYuJbRu0lanMvMN8B4CUp
         BdOMYs0wfvNlsJsRs5hli9BDidAZTmv+F0NRVax11li2I9SvKfovguWhhI++HocADZgP
         o8N7QKacaCnbCtYuREzu76XAAoftbQMqC+XMKJ8D1y16ZEi05mpOD+dY81oMDou55wj1
         itILHUutrQziI4cRajtbw2B4WGbgRiCEXLgS43becQJhU436rYkZROLUJ4t6CD/qYIIp
         DeyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJ2dHxbcxZP4ZShoygBU3UHxzxedyCUKzQ0cHm+DSbocow0ya6uUUkpCo3fSKaIkuyUzySx4s=@vger.kernel.org
X-Gm-Message-State: AFuF++kDL7lJbrn1kut5+ecmC/SAeZFLlQQTIYrZWFSnXP+3+yep1V9b
	LCst7jaPRBN6hQwe8UBBvgcKFkfJttWcFY6gaJCsMvwS6uT+4zZ/s2X9+qlaIHvn2M0=
X-Gm-Gg: AR+sD10fuGpxCNa0B4Hfkas+nR7IUO0Tz0P5s8bka59F3JPewLv0e0FWQ6q/44ts7WF
	xsN6JgwbZ3EE4s6jU7OPNYXRECRdnGBWC+OZIPh62KvpIe22FFHc+VlrR9bsYm2vb1TLB0sh1DI
	1BcOO31X6VKWSn0YHeoiaWwJw7X8T+6GezaKbAN4qJC7uBMValaFKOXq0dze8UW1BFk4Ulqsj83
	FzuftksU2I0fTPaVBC6TDDO65CAl9BYlf1XORn/OIKkkTfP1LjMmr0G6e6FiAqcdtOYG7xqce86
	iZOfyt3sT1qbfyS/M3mhz530aYqocF/EtA7cj9gmwiLRHG0bL0CYPyMZQAuSKoo+FpLDnS0sIpo
	CVmDIiHydIR8j3GeLGHvbtTMek4aZweqFJb06K9q+qGiYQq6+r+w7XFVJMKQCgyzvuxDPBGBmMP
	CfhpxbQZp8f14MCl9KiTI5jJp8WG8sJ+Hn955It8WGlPL4v82dDAsNTuDLh3ar1cG7hFjVV3NUv
	4qGoXMmdODfnfCFcEhwLkpFCvoDjEPTOr6kupi+EES7lUbBbSIx+qH+ssLt27Qc
X-Received: by 2002:a05:600c:c170:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49ce57f072fmr99509425e9.8.1788352833093;
        Wed, 02 Sep 2026 05:40:33 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce7d04c69sm33742725e9.8.2026.09.02.05.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:40:32 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: acquire caps for read_folio requests without an rw context
Date: Wed,  2 Sep 2026 14:40:26 +0200
Message-ID: <20260902124026.1774575-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a data corruption problem that leaked permanently into
fscache.  File-backed erofs images are read using
read_mapping_folio(), and the Ceph implementation of this call forgets
to acquire Ceph caps.  Therefore, mounting an erofs image file from a
Ceph mount that was just written (but not yet committed to the OSD)
would fail because the erofs code saw only zero-filled pages.  These
zero-filled backes were then copied to the fscache, making this data
corruption permanent (on this host).

Usually, Ceph checks/acquires caps at its own entry points and not in
the `address_space_operations`: ceph_read_iter() and
ceph_filemap_fault() acquire Fr/Fc before calling filemap_read() or
filemap_fault(), and ceph_write_iter() holds Fw/Fb around write_begin.

Only readahead, which the VM can invoke without a Ceph entry point
above it, checks caps itself.  That check was added by commit
2b1ac852eb67 ("ceph: try getting buffer capability for readahead/fadvise")
in 2016 to the readpages path, converted to the rw
context list by commit 5d988308283e ("ceph: track read contexts in
ceph_file_info"), and moved into ceph_init_request() for
`origin==NETFS_READAHEAD` by commit a5c9dc445139 ("ceph: Make
ceph_init_request() check caps on readahead").

The single-folio read path never had such a check, neither in the old
ceph_readpage() nor in netfs_read_folio() via ceph_init_request().  It
assumes that the `read_folio` method is only ever reached from
filemap_read() or filemap_fault(), both of which Ceph wraps.

However, since Linux 6.12, erofs file-backed mounts
(commit ce63cb62d794 ("erofs: support unencoded inodes for fileio"))
read all metadata (including the superblock) by calling
read_mapping_folio() directly on the backing file's mapping.  On Ceph,
this issues an OSD read without holding any caps.

The result is silent data corruption.  Ceph clients do not write back
dirty pages on close(); a writer keeps Fb and its dirty data until the
MDS revokes the cap.  When another client opens the file, the MDS
initiates that revoke and replies to the open immediately.  A read()
would now block in ceph_get_caps() until the writer has flushed and
acked the cap-revoke, but the erofs superblock read goes to the OSD
without acquiring caps and thus races with the writeback.  If the
object does not exist yet, the OSD returns -ENOENT, which
finish_netfs_read() treats as "success, no data", and netfs zero-fills
the folio.  The folio is marked uptodate and, because it counts as
downloaded from the server, is also copied into fscache.  This never
recovers because Ceph invalidates the page cache and fscache only when
Fc is revoked, but gaining Fc later will not invalidate it.

My patch fixes this in ceph_init_request() by reusing the existing
`NETFS_READAHEAD` code for `NETFS_READPAGE`, but uses
__ceph_get_caps() instead of ceph_try_get_caps() to make it blocking
(something which would be undesirable for readahead).

Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c | 69 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 657c2cb0f881..580b45a68a75 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -468,6 +468,7 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	struct inode *inode = rreq->inode;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
+	struct ceph_file_info *fi = file ? file->private_data : NULL;
 	int got = 0, want = CEPH_CAP_FILE_CACHE;
 	struct ceph_netfs_request_data *priv;
 	int ret = 0;
@@ -475,45 +476,65 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cache. */
 	__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
 
-	if (rreq->origin != NETFS_READAHEAD)
+	if (rreq->origin != NETFS_READAHEAD && rreq->origin != NETFS_READPAGE)
 		return 0;
 
 	priv = kzalloc_obj(*priv, GFP_NOFS);
 	if (!priv)
 		return -ENOMEM;
 
-	if (file) {
-		struct ceph_rw_context *rw_ctx;
-		struct ceph_file_info *fi = file->private_data;
-
+	if (fi) {
 		priv->file_ra_pages = file->f_ra.ra_pages;
 		priv->file_ra_disabled = file->f_mode & FMODE_RANDOM;
 
-		rw_ctx = ceph_find_rw_context(fi);
-		if (rw_ctx) {
+		/*
+		 * ceph_read_iter() and ceph_filemap_fault() hold caps and
+		 * register an rw context before entering the page cache.
+		 */
+		if (ceph_find_rw_context(fi)) {
 			rreq->netfs_priv = priv;
 			return 0;
 		}
 	}
 
-	/*
-	 * readahead callers do not necessarily hold Fcb caps
-	 * (e.g. fadvise, madvise).
-	 */
-	ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
-	if (ret < 0) {
-		doutc(cl, "%llx.%llx, error getting cap\n", ceph_vinop(inode));
-		goto out;
-	}
+	if (rreq->origin == NETFS_READAHEAD) {
+		/*
+		 * readahead callers do not necessarily hold Fcb caps
+		 * (e.g. fadvise, madvise).  Readahead is optional, so do
+		 * not block; without caps the VM falls back to read_folio.
+		 */
+		ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true,
+					&got);
+		if (ret < 0) {
+			doutc(cl, "%llx.%llx, error getting cap\n",
+			      ceph_vinop(inode));
+			goto out;
+		}
 
-	if (!(got & want)) {
-		doutc(cl, "%llx.%llx, no cache cap\n", ceph_vinop(inode));
-		ret = -EACCES;
-		goto out;
-	}
-	if (ret == 0) {
-		ret = -EACCES;
-		goto out;
+		if (!(got & want)) {
+			doutc(cl, "%llx.%llx, no cache cap\n", ceph_vinop(inode));
+			ret = -EACCES;
+			goto out;
+		}
+		if (ret == 0) {
+			ret = -EACCES;
+			goto out;
+		}
+	} else {
+		/*
+		 * Make sure we have caps, just in case read_folio was
+		 * called directly (e.g. by erofs) which may have
+		 * bypassed the usual Ceph cap checks.  This branch
+		 * uses __ceph_get_caps() which blocks until the
+		 * required cap has been granted.
+		 */
+		ret = __ceph_get_caps(inode, fi, CEPH_CAP_FILE_RD, want, -1,
+				      &got);
+		if (ret < 0) {
+			doutc(cl, "%llx.%llx, error getting cap\n",
+			      ceph_vinop(inode));
+			goto out;
+		}
 	}
 
 	priv->caps = got;
-- 
2.47.3

