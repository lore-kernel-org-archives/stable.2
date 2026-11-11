Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437055;
	b=aSPBZvWEzNrKvT+K/5kI2xuWVEe6/ho60bFxiPLjNYrPk3PIEm3bZ4ERhfnqy4UviEzC
	 IjCHnuCliPL7QNjjTbKx3+01j75vQHule3+eE6v/mGWyhevpzxgneXXZ2T/7AF7exAjSA
	 lHZSJYJHEVxPmpd9jods6mRWdqO8erGS5fqt5B6cW3sp9v0fQ72VXeJcwV0+CfjJnZbSY
	 iVCEy4KoJqDFwY15XtRSlfTWQBe9emEBb26OOh1hXRIICpMttwo7m4vPzNGqJkAn1/XXH
	 /rUQ/OTqCISsmHCCVPELAAP+PkGZpTuAiB4kvhGZXXv1MiXDITx9pip96P+929cn48Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437055;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BJVaokxi1HkW//91EYF77ujbHU1vnN9qiv/YtnjJO3E=;
	b=16/pjlhOI6Wmzrw9DJbuOIB58dIAYyBUOPsBN1RB3Vpg9F0X2H/zsHWZY0Gq/YfwDsFZ
	 N2tme1iaCusHjI6yqaleMhDm10cdVE7W3igN5qa0uL9Giay+y+nCCzFNgTRYhNaL5guqO
	 Lqor5wtTpeuOGvvsyeywtf0PiEZhSiwHqpr8JnhkQjD0Lidrt1axAOoRdso4HNKD+9l/Y
	 WeZr0d13B8DCNW+Pi3eGHUp1nBdDVqqwBohppU4HNYYt/seyQSD8qKqF65dHGNEnCMNyN
	 2DWQZRpvn9pi2z3fNk+B7bUt8ntXRM9Xlu5ZOPWydc4OijvGRF3Xr2Npy8qIZw2YQag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGnCe5Qz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B1606A337
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGnCe5Qz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E56C1F00A09;
	Wed, 11 Nov 2026 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437055;
	bh=BJVaokxi1HkW//91EYF77ujbHU1vnN9qiv/YtnjJO3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DGnCe5QzOMXhbFo3QNutD4dZr5ffz0QBjoq3/M/W5O88AOL9HnqwDj6+LdvDuamQI
	 FV0bPm5ajtiXoijmH/86EEYlhaf0NIS/Md+ssW+xOhsiAVVhIgfF5DZKjGEtRsv7LK
	 JICm2N1QHfTkC+4yHl1qOm9j/MX/6zOYU3LWYLhbAXLUCixC+uVUuX/FJRKfTThZB1
	 +f5Y/VK56sa/+IngYDuAENn7gp2eYV9K7CyM/eF0+pK3YOFWMt9u60xxahmn7AZ4cw
	 y+9va84ujPxVxWANv9epeOFrEhsC4AG7bYj8O5gnz0nEXeTe4WkpxP9uMSmRUMjKXf
	 9WTMuwGAz0D6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/6] new helper: d_splice_alias_ops()
Date: Wed, 11 Nov 2026 17:44:09 -0500
Message-ID: <20261111224335.80100-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111224335.80100-1-sashal@kernel.org>
References: <20261107063040-failed-5.10-eeecea75ece2@kernel.org>
 <20261111224335.80100-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 790fa81b8c43cda9fe25c1b564d0afe3ddeeb370 ]

Uses of d_set_d_op() on live dentry can be very dangerous; it is going
to be withdrawn and replaced with saner things.

The best way for a filesystem is to have the default dentry_operations
set at mount time and be done with that - __d_alloc() will use that.

Currently there are two cases when d_set_d_op() is used on a live dentry -
one is procfs, which has several genuinely different dentry_operations
instances (different ->d_revalidate(), etc.) and another is
simple_lookup(), where we would be better off without overriding ->d_op.

For procfs we have d_set_d_op() calls followed by d_splice_alias();
provide a new helper (d_splice_alias_ops(inode, dentry, d_ops)) that would
combine those two, and do the d_set_d_op() part while under ->d_lock.
That eliminates one of the places where ->d_flags had been modified
without holding ->d_lock; current behaviour is not racy, but the reasons
for that are far too brittle.  Better move to uniform locking rules and
simpler proof of correctness...

The next commit will convert procfs to use of that helper; it is not
exported and won't be until somebody comes up with convincing modular
user for it.

Again, the best approach is to have default ->d_op and let __d_alloc()
do the right thing; filesystem _may_ need non-uniform ->d_op (procfs
does), but there'd better be good reasons for that.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: eeecea75ece2 ("proc: don't let an entry below /proc/<pid>/net be a mountpoint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c            | 63 ++++++++++++++++++++++++------------------
 include/linux/dcache.h |  3 ++
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index d17c98508a088..bc7e514eee9ab 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2668,7 +2668,8 @@ EXPORT_SYMBOL(__d_lookup_done);
 
 /* inode->i_lock held if inode is non-NULL */
 
-static inline void __d_add(struct dentry *dentry, struct inode *inode)
+static inline void __d_add(struct dentry *dentry, struct inode *inode,
+			   const struct dentry_operations *ops)
 {
 	struct inode *dir = NULL;
 	unsigned n;
@@ -2678,6 +2679,8 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 		n = start_dir_add(dir);
 		__d_lookup_done(dentry);
 	}
+	if (unlikely(ops))
+		d_set_d_op(dentry, ops);
 	if (inode) {
 		unsigned add_flags = d_flags_for_inode(inode);
 		hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
@@ -2709,7 +2712,7 @@ void d_add(struct dentry *entry, struct inode *inode)
 		security_d_instantiate(entry, inode);
 		spin_lock(&inode->i_lock);
 	}
-	__d_add(entry, inode);
+	__d_add(entry, inode, NULL);
 }
 EXPORT_SYMBOL(d_add);
 
@@ -3004,30 +3007,8 @@ static int __d_unalias(struct inode *inode,
 	return ret;
 }
 
-/**
- * d_splice_alias - splice a disconnected dentry into the tree if one exists
- * @inode:  the inode which may have a disconnected dentry
- * @dentry: a negative dentry which we want to point to the inode.
- *
- * If inode is a directory and has an IS_ROOT alias, then d_move that in
- * place of the given dentry and return it, else simply d_add the inode
- * to the dentry and return NULL.
- *
- * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
- * we should error out: directories can't have multiple aliases.
- *
- * This is needed in the lookup routine of any filesystem that is exportable
- * (via knfsd) so that we can build dcache paths to directories effectively.
- *
- * If a dentry was found and moved, then it is returned.  Otherwise NULL
- * is returned.  This matches the expected return value of ->lookup.
- *
- * Cluster filesystems may call this function with a negative, hashed dentry.
- * In that case, we know that the inode will be a regular file, and also this
- * will only occur during atomic_open. So we need to check for the dentry
- * being already hashed only in the final case.
- */
-struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
+struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
+				  const struct dentry_operations *ops)
 {
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
@@ -3073,9 +3054,37 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 		}
 	}
 out:
-	__d_add(dentry, inode);
+	__d_add(dentry, inode, ops);
 	return NULL;
 }
+
+/**
+ * d_splice_alias - splice a disconnected dentry into the tree if one exists
+ * @inode:  the inode which may have a disconnected dentry
+ * @dentry: a negative dentry which we want to point to the inode.
+ *
+ * If inode is a directory and has an IS_ROOT alias, then d_move that in
+ * place of the given dentry and return it, else simply d_add the inode
+ * to the dentry and return NULL.
+ *
+ * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
+ * we should error out: directories can't have multiple aliases.
+ *
+ * This is needed in the lookup routine of any filesystem that is exportable
+ * (via knfsd) so that we can build dcache paths to directories effectively.
+ *
+ * If a dentry was found and moved, then it is returned.  Otherwise NULL
+ * is returned.  This matches the expected return value of ->lookup.
+ *
+ * Cluster filesystems may call this function with a negative, hashed dentry.
+ * In that case, we know that the inode will be a regular file, and also this
+ * will only occur during atomic_open. So we need to check for the dentry
+ * being already hashed only in the final case.
+ */
+struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
+{
+	return d_splice_alias_ops(inode, dentry, NULL);
+}
 EXPORT_SYMBOL(d_splice_alias);
 
 /*
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6f95c3300cbbb..9f21ea124842c 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -240,6 +240,9 @@ extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
 					wait_queue_head_t *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
+/* weird procfs mess; *NOT* exported */
+extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
+					  const struct dentry_operations *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
 extern struct dentry * d_exact_alias(struct dentry *, struct inode *);
 extern struct dentry *d_find_any_alias(struct inode *inode);
-- 
2.53.0

