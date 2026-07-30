Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D334EEF3;
	Thu, 30 Jul 2026 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373306; cv=none; b=E3kdn+rkFsdf15gfUc6fMB6fjHaiexLlNeXjMcVuBWXwo1JETysQ/cw/1EDC0DeEkvXOMEos6Aj4YdNnWVbuQyKYPfMLjYafxxURG4XkBv5oPRHUFQp9Px05tkEHXj+PMgJiGDEZz3WgfxkVyiYJaLBex+zhXWOAJy/sRprbu+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373306; c=relaxed/simple;
	bh=tyO2q4xuxb+Sn1Whvb8K+c3g0+o7m04N6X2kzmdfTbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o35BiPYxG/Ps06VWJ02XAYVBCG+jjI37cTrksSX1l81vh5ZT3yoohcS7qvttFgqjIPjZj3/lA+uQnE/4Il1l3DJMB7idZ6s91nYTKyRxjsuGSWzX82BjtH+H4dYYKjTFYsvsL+jUV6EvNg1oerhaKs2FwsiCH5VsBFysMlnQ2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2ypCF1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2ypCF1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C429E1F00ACA;
	Thu, 30 Jul 2026 01:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373304;
	bh=4r1qgD0fv0qGsqrWETpFDNB4mnL61ruFPgrApuawRLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2ypCF1FKrTdR3YBGUbpzHTUp3Bvm8TW38hmtgXqQJYky1gLmpSNQo16tnV0I+v1A
	 ksYsgEwpeAwIGhn1V5bKt4/FuffomQ6uVxKDIEAlgUkb4CXrMwhM4ds9IWToJAveWl
	 lA9y6KI329WJJG0c8AoCR00QBRfovmCLTdiXZ0dxR2IhF7kA9G+LltKtqiltloXn0U
	 Pv+TazkdbsbS6n2ZVXfqhV/eZnVB50TfmV13pYubfEuzYv7Ks++BjDMQRjiBe61zCi
	 uSkc4Rddl1SSl/Tuun5DGYoqke2By2FBP69rw5HtKzqGzngHR7p99R7ATQuhbZT7zs
	 rPxuK6Cvj36PA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/9] afs: Drop the net parameter from afs_unuse_cell()
Date: Wed, 29 Jul 2026 21:01:34 -0400
Message-ID: <20260730010140.1700208-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730010140.1700208-1-sashal@kernel.org>
References: <2026072127-dress-overplay-421f@gregkh>
 <20260730010140.1700208-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 469c82b558628482002e4819d35b7670f0a989fd ]

Remove the redundant net parameter to afs_unuse_cell() as cell->net can be
used instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-12-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20250310094206.801057-8-dhowells@redhat.com/ # v4
Stable-dep-of: 26f17ce6fa3f ("afs: Fix premature cell exposure through /afs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/cell.c              | 12 ++++++------
 fs/afs/dynroot.c           |  4 ++--
 fs/afs/internal.h          |  2 +-
 fs/afs/mntpt.c             |  2 +-
 fs/afs/proc.c              |  2 +-
 fs/afs/super.c             |  9 ++++-----
 fs/afs/vl_alias.c          |  4 ++--
 include/trace/events/afs.h |  1 +
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 918013d9050ea1..e3b7cf439064ba 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -339,7 +339,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 		goto wait_for_cell;
 	goto error_noput;
 error:
-	afs_unuse_cell(net, cell, afs_cell_trace_unuse_lookup);
+	afs_unuse_cell(cell, afs_cell_trace_unuse_lookup_error);
 error_noput:
 	_leave(" = %d [error]", ret);
 	return ERR_PTR(ret);
@@ -402,7 +402,7 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 				       lockdep_is_held(&net->cells_lock));
 	up_write(&net->cells_lock);
 
-	afs_unuse_cell(net, old_root, afs_cell_trace_unuse_ws);
+	afs_unuse_cell(old_root, afs_cell_trace_unuse_ws);
 	_leave(" = 0");
 	return 0;
 }
@@ -522,7 +522,7 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	trace_afs_cell(cell->debug_id, r, atomic_read(&cell->active), afs_cell_trace_free);
 
 	afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
-	afs_unuse_cell(net, cell->alias_of, afs_cell_trace_unuse_alias);
+	afs_unuse_cell(cell->alias_of, afs_cell_trace_unuse_alias);
 	key_put(cell->anonymous_key);
 	idr_remove(&net->cells_dyn_ino, cell->dynroot_ino);
 	kfree(cell->name - 1);
@@ -610,7 +610,7 @@ struct afs_cell *afs_use_cell(struct afs_cell *cell, enum afs_cell_trace reason)
  * Record a cell becoming less active.  When the active counter reaches 1, it
  * is scheduled for destruction, but may get reactivated.
  */
-void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_trace reason)
+void afs_unuse_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 {
 	unsigned int debug_id;
 	time64_t now, expire_delay;
@@ -634,7 +634,7 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
 	WARN_ON(a == 0);
 	if (a == 1)
 		/* 'cell' may now be garbage collected. */
-		afs_set_cell_timer(net, expire_delay);
+		afs_set_cell_timer(cell->net, expire_delay);
 }
 
 /*
@@ -959,7 +959,7 @@ void afs_cell_purge(struct afs_net *net)
 	ws = rcu_replace_pointer(net->ws_cell, NULL,
 				 lockdep_is_held(&net->cells_lock));
 	up_write(&net->cells_lock);
-	afs_unuse_cell(net, ws, afs_cell_trace_unuse_ws);
+	afs_unuse_cell(ws, afs_cell_trace_unuse_ws);
 
 	_debug("del timer");
 	if (del_timer_sync(&net->cells_timer))
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 3d0b4efb5b0405..e593f9618e0669 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -125,7 +125,7 @@ static struct dentry *afs_dynroot_lookup_cell(struct inode *dir, struct dentry *
 	return d_splice_alias(inode, dentry);
 
 out:
-	afs_unuse_cell(cell->net, cell, afs_cell_trace_unuse_lookup_dynroot);
+	afs_unuse_cell(cell, afs_cell_trace_unuse_lookup_dynroot);
 out_no_cell:
 	if (!inode)
 		return d_splice_alias(inode, dentry);
@@ -167,7 +167,7 @@ static void afs_dynroot_d_release(struct dentry *dentry)
 {
 	struct afs_cell *cell = dentry->d_fsdata;
 
-	afs_unuse_cell(cell->net, cell, afs_cell_trace_unuse_dynroot_mntpt);
+	afs_unuse_cell(cell, afs_cell_trace_unuse_dynroot_mntpt);
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 96804c11d129a0..217dcd4d908d6c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1045,7 +1045,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 				 const char *vllist, bool excl,
 				 enum afs_cell_trace trace);
 extern struct afs_cell *afs_use_cell(struct afs_cell *, enum afs_cell_trace);
-extern void afs_unuse_cell(struct afs_net *, struct afs_cell *, enum afs_cell_trace);
+void afs_unuse_cell(struct afs_cell *cell, enum afs_cell_trace reason);
 extern struct afs_cell *afs_get_cell(struct afs_cell *, enum afs_cell_trace);
 extern void afs_see_cell(struct afs_cell *, enum afs_cell_trace);
 extern void afs_put_cell(struct afs_cell *, enum afs_cell_trace);
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index cec86aaa6adc10..8ebac8c030952e 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -87,7 +87,7 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		ctx->force = true;
 	}
 	if (ctx->cell) {
-		afs_unuse_cell(ctx->net, ctx->cell, afs_cell_trace_unuse_mntpt);
+		afs_unuse_cell(ctx->cell, afs_cell_trace_unuse_mntpt);
 		ctx->cell = NULL;
 	}
 	if (test_bit(AFS_VNODE_PSEUDODIR, &vnode->flags)) {
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index fc7027fc3084a3..9a3d8eb5da43c2 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -130,7 +130,7 @@ static int afs_proc_cells_write(struct file *file, char *buf, size_t size)
 		}
 
 		if (test_and_set_bit(AFS_CELL_FL_NO_GC, &cell->flags))
-			afs_unuse_cell(net, cell, afs_cell_trace_unuse_no_pin);
+			afs_unuse_cell(cell, afs_cell_trace_unuse_no_pin);
 	} else {
 		goto inval;
 	}
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 287fe6ebdfda19..feb81729bd3dbe 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -297,7 +297,7 @@ static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
 			       cellnamesz, cellnamesz, cellname ?: "");
 			return PTR_ERR(cell);
 		}
-		afs_unuse_cell(ctx->net, ctx->cell, afs_cell_trace_unuse_parse);
+		afs_unuse_cell(ctx->cell, afs_cell_trace_unuse_parse);
 		afs_see_cell(cell, afs_cell_trace_see_source);
 		ctx->cell = cell;
 	}
@@ -394,7 +394,7 @@ static int afs_validate_fc(struct fs_context *fc)
 				ctx->key = NULL;
 				cell = afs_use_cell(ctx->cell->alias_of,
 						    afs_cell_trace_use_fc_alias);
-				afs_unuse_cell(ctx->net, ctx->cell, afs_cell_trace_unuse_fc);
+				afs_unuse_cell(ctx->cell, afs_cell_trace_unuse_fc);
 				ctx->cell = cell;
 				goto reget_key;
 			}
@@ -520,9 +520,8 @@ static struct afs_super_info *afs_alloc_sbi(struct fs_context *fc)
 static void afs_destroy_sbi(struct afs_super_info *as)
 {
 	if (as) {
-		struct afs_net *net = afs_net(as->net_ns);
 		afs_put_volume(as->volume, afs_volume_trace_put_destroy_sbi);
-		afs_unuse_cell(net, as->cell, afs_cell_trace_unuse_sbi);
+		afs_unuse_cell(as->cell, afs_cell_trace_unuse_sbi);
 		put_net(as->net_ns);
 		kfree(as);
 	}
@@ -606,7 +605,7 @@ static void afs_free_fc(struct fs_context *fc)
 
 	afs_destroy_sbi(fc->s_fs_info);
 	afs_put_volume(ctx->volume, afs_volume_trace_put_free_fc);
-	afs_unuse_cell(ctx->net, ctx->cell, afs_cell_trace_unuse_fc);
+	afs_unuse_cell(ctx->cell, afs_cell_trace_unuse_fc);
 	key_put(ctx->key);
 	kfree(ctx);
 }
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index ffcfba1725e6da..709b4cdb723eea 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -205,11 +205,11 @@ static int afs_query_for_alias(struct afs_cell *cell, struct key *key)
 			goto is_alias;
 
 		if (mutex_lock_interruptible(&cell->net->proc_cells_lock) < 0) {
-			afs_unuse_cell(cell->net, p, afs_cell_trace_unuse_check_alias);
+			afs_unuse_cell(p, afs_cell_trace_unuse_check_alias);
 			return -ERESTARTSYS;
 		}
 
-		afs_unuse_cell(cell->net, p, afs_cell_trace_unuse_check_alias);
+		afs_unuse_cell(p, afs_cell_trace_unuse_check_alias);
 	}
 
 	mutex_unlock(&cell->net->proc_cells_lock);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 0fc479d63ca7df..b42f2e1e07f1da 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -197,6 +197,7 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_unuse_fc,		"UNU fc    ") \
 	EM(afs_cell_trace_unuse_lookup,		"UNU lookup") \
 	EM(afs_cell_trace_unuse_lookup_dynroot,	"UNU lu-dyn") \
+	EM(afs_cell_trace_unuse_lookup_error,	"UNU lu-err") \
 	EM(afs_cell_trace_unuse_mntpt,		"UNU mntpt ") \
 	EM(afs_cell_trace_unuse_no_pin,		"UNU no-pin") \
 	EM(afs_cell_trace_unuse_parse,		"UNU parse ") \
-- 
2.53.0

