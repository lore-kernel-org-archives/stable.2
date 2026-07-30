Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824361DA60D;
	Thu, 30 Jul 2026 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373301; cv=none; b=K6yCPO76v2QEOjx0LAMISUAAraA9FD652TMklNlwm8oVsKrvucYADTtRpQXWXQFQoswS8q8ftiB/JkFyK+5z2O73/Nr2WLOZ6rn9dxsH2Rlr9EIbJcO4122kPlD+T6gpbCv7vVeXLvua6JR7mJoYhirjBR4x7EOEonkgukCEpL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373301; c=relaxed/simple;
	bh=0Nfa6sw9XQLhyCqkYz7rZ/Q/6oCNzG5f8CIi+j4swxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krKTD0IH9FNiIMEL55cpdMJbnEnlwjTYo2uBB6p0wdDTkEfuPZAm54aqYQyqWi/2P0VQYJe5h7zGXuexfydC8abzD1MQ9y/nzwKevJzsnGZyE2Y/DDY8gcZOqAdUUjRom2dHu0tW3Hz+Fvdf0zIwA7LgZNtusOxXrtvYHimOj5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPfVK5am; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPfVK5am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD4B1F000E9;
	Thu, 30 Jul 2026 01:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373300;
	bh=YyMSMTsOu+unfV//6iglwPx9NjltONfI/10Zp1sT+XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPfVK5am2cCAbJN3DO9XOF7Iiqh5QGTmq7DWv9JmZMerHJR3Bn6VeuHAiSfjMB9Pe
	 E8IjX8T2RrGCiXU4AxhNITkWxlNXW+XxFkroH8Wglo2VN7QtOl2eoj6+blJ/VFJjnP
	 SwtFH1dZjkHFKU/i9duU1cXz3JY/CkR9NJEsbprJl90tE5WkQQrNY13skXuBiYGLlv
	 AwA0D/nxEy7ea5V4ueI3gGPvOtD+DMu3g1FQMpeuSe8JbktZYdS4kSbq2cDZox+Ekc
	 bpNKy/c5UtEuwkVd41Yfb16iijLGcy8y9DhkaVQGO8MLxHcY1WOM18rlqJ2fSF1Z1A
	 2OWP9bx0K/QgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/8] afs: Make afs_lookup_cell() take a trace note
Date: Wed, 29 Jul 2026 21:01:31 -0400
Message-ID: <20260730010137.1700032-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730010137.1700032-1-sashal@kernel.org>
References: <2026072131-schilling-spectrum-ef97@gregkh>
 <20260730010137.1700032-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 92c48157ade88e7a543a64af4a806613fbde2ef3 ]

Pass a note to be added to the afs_cell tracepoint to afs_lookup_cell() so
that different callers can be distinguished.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-11-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20250310094206.801057-7-dhowells@redhat.com/ # v4
Stable-dep-of: 330e2c514823 ("afs: Fix dynamic lookup to fail on cell lookup failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/cell.c              | 13 ++++++++-----
 fs/afs/dynroot.c           |  3 ++-
 fs/afs/internal.h          |  6 ++++--
 fs/afs/mntpt.c             |  3 ++-
 fs/afs/proc.c              |  3 ++-
 fs/afs/super.c             |  3 ++-
 fs/afs/vl_alias.c          |  3 ++-
 include/trace/events/afs.h |  7 ++++++-
 8 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index ce74438b9fb821..918013d9050ea1 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -233,6 +233,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
  * @namesz:	The strlen of the cell name.
  * @vllist:	A colon/comma separated list of numeric IP addresses or NULL.
  * @excl:	T if an error should be given if the cell name already exists.
+ * @trace:	The reason to be logged if the lookup is successful.
  *
  * Look up a cell record by name and query the DNS for VL server addresses if
  * needed.  Note that that actual DNS query is punted off to the manager thread
@@ -241,7 +242,8 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
  */
 struct afs_cell *afs_lookup_cell(struct afs_net *net,
 				 const char *name, unsigned int namesz,
-				 const char *vllist, bool excl)
+				 const char *vllist, bool excl,
+				 enum afs_cell_trace trace)
 {
 	struct afs_cell *cell, *candidate, *cursor;
 	struct rb_node *parent, **pp;
@@ -251,7 +253,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 	_enter("%s,%s", name, vllist);
 
 	if (!excl) {
-		cell = afs_find_cell(net, name, namesz, afs_cell_trace_use_lookup);
+		cell = afs_find_cell(net, name, namesz, trace);
 		if (!IS_ERR(cell))
 			goto wait_for_cell;
 	}
@@ -327,7 +329,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 	if (excl) {
 		ret = -EEXIST;
 	} else {
-		afs_use_cell(cursor, afs_cell_trace_use_lookup);
+		afs_use_cell(cursor, trace);
 		ret = 0;
 	}
 	up_write(&net->cells_lock);
@@ -382,8 +384,9 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 	if (cp && cp < rootcell + len)
 		return -EINVAL;
 
-	/* allocate a cell record for the root cell */
-	new_root = afs_lookup_cell(net, rootcell, len, vllist, false);
+	/* allocate a cell record for the root/workstation cell */
+	new_root = afs_lookup_cell(net, rootcell, len, vllist, false,
+				   afs_cell_trace_use_lookup_ws);
 	if (IS_ERR(new_root)) {
 		_leave(" = %ld", PTR_ERR(new_root));
 		return PTR_ERR(new_root);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 17dffa3b27e571..3d0b4efb5b0405 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -108,7 +108,8 @@ static struct dentry *afs_dynroot_lookup_cell(struct inode *dir, struct dentry *
 		dotted = true;
 	}
 
-	cell = afs_lookup_cell(net, name, len, NULL, false);
+	cell = afs_lookup_cell(net, name, len, NULL, false,
+			       afs_cell_trace_use_lookup_dynroot);
 	if (IS_ERR(cell)) {
 		ret = PTR_ERR(cell);
 		goto out_no_cell;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index f9b90e59659317..96804c11d129a0 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1040,8 +1040,10 @@ static inline bool afs_cb_is_broken(unsigned int cb_break,
 extern int afs_cell_init(struct afs_net *, const char *);
 extern struct afs_cell *afs_find_cell(struct afs_net *, const char *, unsigned,
 				      enum afs_cell_trace);
-extern struct afs_cell *afs_lookup_cell(struct afs_net *, const char *, unsigned,
-					const char *, bool);
+struct afs_cell *afs_lookup_cell(struct afs_net *net,
+				 const char *name, unsigned int namesz,
+				 const char *vllist, bool excl,
+				 enum afs_cell_trace trace);
 extern struct afs_cell *afs_use_cell(struct afs_cell *, enum afs_cell_trace);
 extern void afs_unuse_cell(struct afs_net *, struct afs_cell *, enum afs_cell_trace);
 extern struct afs_cell *afs_get_cell(struct afs_cell *, enum afs_cell_trace);
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 297487ee832317..cec86aaa6adc10 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -107,7 +107,8 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		if (size > AFS_MAXCELLNAME)
 			return -ENAMETOOLONG;
 
-		cell = afs_lookup_cell(ctx->net, p, size, NULL, false);
+		cell = afs_lookup_cell(ctx->net, p, size, NULL, false,
+				       afs_cell_trace_use_lookup_mntpt);
 		if (IS_ERR(cell)) {
 			pr_err("kAFS: unable to lookup cell '%pd'\n", mntpt);
 			return PTR_ERR(cell);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 12c88d8be3fe8b..fc7027fc3084a3 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -122,7 +122,8 @@ static int afs_proc_cells_write(struct file *file, char *buf, size_t size)
 	if (strcmp(buf, "add") == 0) {
 		struct afs_cell *cell;
 
-		cell = afs_lookup_cell(net, name, strlen(name), args, true);
+		cell = afs_lookup_cell(net, name, strlen(name), args, true,
+				       afs_cell_trace_use_lookup_add);
 		if (IS_ERR(cell)) {
 			ret = PTR_ERR(cell);
 			goto done;
diff --git a/fs/afs/super.c b/fs/afs/super.c
index c6378d94fb64e4..287fe6ebdfda19 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -290,7 +290,8 @@ static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
 	/* lookup the cell record */
 	if (cellname) {
 		cell = afs_lookup_cell(ctx->net, cellname, cellnamesz,
-				       NULL, false);
+				       NULL, false,
+				       afs_cell_trace_use_lookup_mount);
 		if (IS_ERR(cell)) {
 			pr_err("kAFS: unable to lookup cell '%*.*s'\n",
 			       cellnamesz, cellnamesz, cellname ?: "");
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index f9e76b604f31b9..ffcfba1725e6da 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -269,7 +269,8 @@ static int yfs_check_canonical_cell_name(struct afs_cell *cell, struct key *key)
 	if (!name_len || name_len > AFS_MAXCELLNAME)
 		master = ERR_PTR(-EOPNOTSUPP);
 	else
-		master = afs_lookup_cell(cell->net, cell_name, name_len, NULL, false);
+		master = afs_lookup_cell(cell->net, cell_name, name_len, NULL, false,
+					 afs_cell_trace_use_lookup_canonical);
 	kfree(cell_name);
 	if (IS_ERR(master))
 		return PTR_ERR(master);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 527188f393caa3..0fc479d63ca7df 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -208,7 +208,12 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_use_check_alias,	"USE chk-al") \
 	EM(afs_cell_trace_use_fc,		"USE fc    ") \
 	EM(afs_cell_trace_use_fc_alias,		"USE fc-al ") \
-	EM(afs_cell_trace_use_lookup,		"USE lookup") \
+	EM(afs_cell_trace_use_lookup_add,	"USE lu-add") \
+	EM(afs_cell_trace_use_lookup_canonical,	"USE lu-can") \
+	EM(afs_cell_trace_use_lookup_dynroot,	"USE lu-dyn") \
+	EM(afs_cell_trace_use_lookup_mntpt,	"USE lu-mpt") \
+	EM(afs_cell_trace_use_lookup_mount,	"USE lu-mnt") \
+	EM(afs_cell_trace_use_lookup_ws,	"USE lu-ws ") \
 	EM(afs_cell_trace_use_mntpt,		"USE mntpt ") \
 	EM(afs_cell_trace_use_pin,		"USE pin   ") \
 	EM(afs_cell_trace_use_probe,		"USE probe ") \
-- 
2.53.0

