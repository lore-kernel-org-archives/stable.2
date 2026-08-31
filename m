Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC2372680
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194598; cv=none; b=vEDgWy/OomgdrVftImdcGfTBh/JRIMJZQ7l5dQgYuuW/ZGkZtrl4P2W5SnHFUWzTRjHRqU29VE8kOgGZi5nMnkF+H6K/0eGiOh5UNSfSzZ6TxRBiCe21xprJTBqRIQyc2TCCniFn6suPAMSfZbbOO2ZcHhKiyuYYYubQz1KP0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194598; c=relaxed/simple;
	bh=u86+DPj7dIJCcnFl916dhyyjCm29de0RUfwibRVQDe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrgkhoTfXp5WdKBho6VHe2JnpA1b0N7ZSNbSNBEMYa08AqrP6Z1koKf+KCoum5EnGecvelBsGbhGPVtDwcBuWirJGpSOyV5ZJ2seoePNG81SvZTsd2gS+WafqUgxTgfNeo4ZNv8OB0XGCJ6HmZJ3KGOYPJpYCU7QnjXkz13ek1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrqYmIu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrqYmIu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B181F00A3E;
	Mon, 31 Aug 2026 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194596;
	bh=Z+8jAQ719umuD0e46AHVytUntvDjoApEqdxvUI4wI2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SrqYmIu4lVGPlWbIYl2abuyDiip0EZkLmylobFdHDvDiJlvNke8vL4DKzrE7vHCpz
	 BXVVCKeM/S8q9s4oCZVSAQBRk53U6NFpbcJ0sPz+FvNX2QMODBRqplPJKRZWuJD8QR
	 PpoTn5BmXzUvnodBeDY5YkPpNcT9iDb9H37Onn/bJVm9/AIS+RO91a+DLtwnAQMK5S
	 iYWbSmi+8x0sWGoBmPFxJtoEc2fAMyErv7MuLk26dInkxnFcoMuk/0ln4XJj0bdwte
	 jy29B/iM+ughD2lg6F0MhN9PZJ4UtaqOgivTwwYmsdpOCF9jyMT7yqlFAfPtHT72so
	 kb8wza7oIa8qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] fuse: remove fm arg of args->end callback
Date: Mon, 31 Aug 2026 12:43:12 -0400
Message-ID: <20260831164313.270365-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831164313.270365-1-sashal@kernel.org>
References: <2026083132-jaybird-willed-acf3@gregkh>
 <20260831164313.270365-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit a697d95fcdbb3bbe25cdc29db5542ddcebb831c1 ]

Only used by FUSE_INIT and CUSE_INIT, these can store the relevant pointer
in their structs derived from fuse_args.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: ed9c881f3b49 ("fuse: fix race between interrupt and resend")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/args.h  |  2 +-
 fs/fuse/cuse.c  |  7 ++++---
 fs/fuse/dev.c   |  7 +++----
 fs/fuse/file.c  | 22 +++++++++-------------
 fs/fuse/inode.c | 10 ++++++----
 5 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/args.h b/fs/fuse/args.h
index 12c94ece569fb..ecfe51a192af0 100644
--- a/fs/fuse/args.h
+++ b/fs/fuse/args.h
@@ -44,7 +44,7 @@ struct fuse_args {
 	bool abort_on_kill:1;
 	struct fuse_in_arg in_args[4];
 	struct fuse_arg out_args[2];
-	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
+	void (*end)(struct fuse_args *args, int error);
 	/* Used for kvec iter backed by vmalloc address */
 	void *vmap_base;
 };
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 2bb98bf81b079..e43d12f69d655 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -306,6 +306,7 @@ struct cuse_init_args {
 	struct cuse_init_out out;
 	struct folio *folio;
 	struct fuse_folio_desc desc;
+	struct fuse_conn *fc;
 };
 
 /**
@@ -319,11 +320,10 @@ struct cuse_init_args {
  * required data structures for it.  Please read the comment at the
  * top of this file for high level overview.
  */
-static void cuse_process_init_reply(struct fuse_mount *fm,
-				    struct fuse_args *args, int error)
+static void cuse_process_init_reply(struct fuse_args *args, int error)
 {
-	struct fuse_conn *fc = fm->fc;
 	struct cuse_init_args *ia = container_of(args, typeof(*ia), ap.args);
+	struct fuse_conn *fc = ia->fc;
 	struct fuse_args_pages *ap = &ia->ap;
 	struct cuse_conn *cc = fc_to_cc(fc), *pos;
 	struct cuse_init_out *arg = &ia->out;
@@ -468,6 +468,7 @@ static int cuse_send_init(struct cuse_conn *cc)
 	ap->descs = &ia->desc;
 	ia->folio = folio;
 	ia->desc.length = ap->args.out_args[1].size;
+	ia->fc = &cc->fc;
 	ap->args.end = cuse_process_init_reply;
 
 	rc = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 77c3982bca3d7..8a38a263295fe 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -512,7 +512,7 @@ void fuse_request_end(struct fuse_req *req)
 	}
 
 	if (test_bit(FR_ASYNC, &req->flags))
-		req->args->end(fm, req->args, req->out.h.error);
+		req->args->end(req->args, req->out.h.error);
 put_request:
 	fuse_put_request(req);
 }
@@ -1859,8 +1859,7 @@ struct fuse_retrieve_args {
 	struct fuse_notify_retrieve_in inarg;
 };
 
-static void fuse_retrieve_end(struct fuse_mount *fm, struct fuse_args *args,
-			      int error)
+static void fuse_retrieve_end(struct fuse_args *args, int error)
 {
 	struct fuse_retrieve_args *ra =
 		container_of(args, typeof(*ra), ap.args);
@@ -1955,7 +1954,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	err = fuse_simple_notify_reply(fm, args, outarg->notify_unique);
 	if (err)
-		fuse_retrieve_end(fm, args, err);
+		fuse_retrieve_end(args, err);
 
 	return err;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 585dd90361b65..f3b4d6ae0858a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -91,8 +91,7 @@ static struct fuse_file *fuse_file_get(struct fuse_file *ff)
 	return ff;
 }
 
-static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
-			     int error)
+static void fuse_release_end(struct fuse_args *args, int error)
 {
 	struct fuse_release_args *ra = container_of(args, typeof(*ra), args);
 
@@ -112,15 +111,15 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 		if (!args) {
 			/* Do nothing when server does not implement 'opendir' */
 		} else if (args->opcode == FUSE_RELEASE && ff->fm->fc->no_open) {
-			fuse_release_end(ff->fm, args, 0);
+			fuse_release_end(args, 0);
 		} else if (sync) {
 			fuse_simple_request(ff->fm, args);
-			fuse_release_end(ff->fm, args, 0);
+			fuse_release_end(args, 0);
 		} else {
 			args->end = fuse_release_end;
 			if (fuse_simple_background(ff->fm, args,
 						   GFP_KERNEL | __GFP_NOFAIL))
-				fuse_release_end(ff->fm, args, -ENOTCONN);
+				fuse_release_end(args, -ENOTCONN);
 		}
 		kfree(ff);
 	}
@@ -709,8 +708,7 @@ static void fuse_io_free(struct fuse_io_args *ia)
 	kfree(ia);
 }
 
-static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
-				  int err)
+static void fuse_aio_complete_req(struct fuse_args *args, int err)
 {
 	struct fuse_io_args *ia = container_of(args, typeof(*ia), ap.args);
 	struct fuse_io_priv *io = ia->io;
@@ -758,7 +756,7 @@ static ssize_t fuse_async_req_send(struct fuse_mount *fm,
 	ia->ap.args.may_block = io->should_dirty;
 	err = fuse_simple_background(fm, &ia->ap.args, GFP_KERNEL);
 	if (err)
-		fuse_aio_complete_req(fm, &ia->ap.args, err);
+		fuse_aio_complete_req(&ia->ap.args, err);
 
 	return num_bytes;
 }
@@ -881,8 +879,7 @@ static int fuse_iomap_read_folio_range(const struct iomap_iter *iter,
 	return fuse_do_readfolio(file, folio, off, len);
 }
 
-static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
-			       int err)
+static void fuse_readpages_end(struct fuse_args *args, int err)
 {
 	int i;
 	struct fuse_io_args *ia = container_of(args, typeof(*ia), ap.args);
@@ -947,7 +944,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
 		res = fuse_simple_request(fm, &ap->args);
 		err = res < 0 ? res : 0;
 	}
-	fuse_readpages_end(fm, &ap->args, err);
+	fuse_readpages_end(&ap->args, err);
 }
 
 static void fuse_readahead(struct readahead_control *rac)
@@ -1950,8 +1947,7 @@ __acquires(fi->lock)
 	}
 }
 
-static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
-			       int error)
+static void fuse_writepage_end(struct fuse_args *args, int error)
 {
 	struct fuse_writepage_args *wpa =
 		container_of(args, typeof(*wpa), ia.ap.args);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9ed693fc7b37..ae520c7388218 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1311,13 +1311,14 @@ struct fuse_init_args {
 	struct fuse_args args;
 	struct fuse_init_in in;
 	struct fuse_init_out out;
+	struct fuse_mount *fm;
 };
 
-static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
-			       int error)
+static void process_init_reply(struct fuse_args *args, int error)
 {
-	struct fuse_conn *fc = fm->fc;
 	struct fuse_init_args *ia = container_of(args, typeof(*ia), args);
+	struct fuse_mount *fm = ia->fm;
+	struct fuse_conn *fc = fm->fc;
 	struct fuse_init_out *arg = &ia->out;
 	bool ok = true;
 
@@ -1486,6 +1487,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 
 	ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
 
+	ia->fm = fm;
 	ia->in.major = FUSE_KERNEL_VERSION;
 	ia->in.minor = FUSE_KERNEL_MINOR_VERSION;
 	ia->in.max_readahead = fm->sb->s_bdi->ra_pages * PAGE_SIZE;
@@ -1559,7 +1561,7 @@ int fuse_send_init(struct fuse_mount *fm)
 		if (!err)
 			return 0;
 	}
-	process_init_reply(fm, &ia->args, err);
+	process_init_reply(&ia->args, err);
 	if (fm->fc->conn_error)
 		return -ENOTCONN;
 	return 0;
-- 
2.53.0

