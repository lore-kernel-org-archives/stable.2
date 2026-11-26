Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693274;
	b=TYxE9dpRlLsUa3sxktZpQCsWBBXldu29fRkqIzGhm64xNjEdEPIYOZHghRuQ7GjlN+K6
	 PxErvALYYKKn6LJflB3nFORy83LyyF1CfQNvP29sHaoRmKp1Ums1HaPvBA6VuhZ0fN21x
	 dieQEOzmh9S+OoH9/Dk7SZjrBabxwOp7duj92Ss9dlpXdLNyRAbnELrA+ATOgarNO5GiZ
	 v/c+9YHivN+Uf4v94tBVyZh0l3s/kbhjtlm9I96RrM4XIkZWMeZ+pLEIBEc6JeT5OJnuw
	 qrsxKiOjkvbMx78z28TZ/0zPInott/9G4/AhXe03ymStPAxsn+KqMmsCbx9mpXnDo/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693274;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7HOYhpJGLjrkTlh7xvgl6rhBHPtcVUXz8xkKDyHu/gU=;
	b=q8cWimphHESN9Jb19SpSjT06ItG8YYaG07DEq+nL75nWLwWAFmqJFTtBu9YB8EC3tzBr
	 JiK97siKS2ceQLyvYTPsjgc0fvcauRU6AcKckoCZaYsEPMAWLjxQFDnioBFX84/ntJtK/
	 8gZgw8D6olNHvxaAlJD8cNzBSZiFWdsP9v/+52fz/k3DD5Us+eByK/P4Jeog2taI9oixj
	 zuz4V6d6WxnpHQ83vsxD2R2T+S3o7DvJsoXoD0UMSjglyQ6jPDbM9VvxWIli/lNXNHuyF
	 XSf35sR7LZFC+5zKPHuAoTeTgMDyNIIa8ISR5mcyJ4D/+oBMwBFkdP/bHk6cfRE2Kfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajewG0Ex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1752D606A31C;
	Thu, 26 Nov 2026 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajewG0Ex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457A51F000C0;
	Thu, 26 Nov 2026 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693273;
	bh=7HOYhpJGLjrkTlh7xvgl6rhBHPtcVUXz8xkKDyHu/gU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ajewG0ExiAX7Y2Fdj0R5IAdb+uFc4iTmtcs+dKbt2xLZPq8XDcH44B4QPPgdz7O0S
	 aoyqi9n9WCYmOvmov+4N7VBQ1W30LcJ2JfCJlsLl01MsiYBMlQo2SF5S4SBg5YcLrg
	 K2BSqT8mMpS+u/lXnOGGCLvatFbahihCn5gfJgegBCZTcMFCXSawuU7KDMmt97h8la
	 jzSySuvoUVAOe+4IP2NDpiu7Tt6kvBdsIp5KI9yqbqf58fq+86rBQahycP7aYUpik8
	 yI9lUZadW1UfIw/lZfOz4jmCXAV562dTwHBZBZZ6d5hAHH6DHn/sb6NOsWnDgSt1bx
	 RsxxFnHUKBc6g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Nov 2026 12:40:33 +0100
Subject: [PATCH 1/2] namespace: allow bind mounts of ephemeral procfs files
 again
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-work-mount-cant_mount-v1-1-781d911a32e1@kernel.org>
References: <20261126-work-mount-cant_mount-v1-0-781d911a32e1@kernel.org>
In-Reply-To: <20261126-work-mount-cant_mount-v1-0-781d911a32e1@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=4794; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G6z1QP/jE/NS78zeAyPCY+agifrWaQiQWPLVHcJaeFE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzSF10ryjyfJWofrRUcabJysVJUt8elm6f06OxLMFjk
 cWqRYuXdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk6gEjw8y0+Myl81krEgTO
 5FQwpbkq+Z42W2nA8W752mUaS+KXHmD4Zzv70aE5B3LT9c+siune96zG1e7aDt5r81/F/GftSyw
 rZgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Commit 75f4197f1e11 ("dcache: don't put a mountpoint on a dentry that's
being removed") made d_set_mounted() refuse dentries that dont_mount()
was called on. I overlooked that procfs calls dont_mount() on the files
in /proc/<pid>/{fd,fdinfo,map_files} and below /proc/<pid>/net when it
creates them and that attach_recursive_mnt() makes a mountpoint out of
the root of every source in case it goes beneath a mount. So
bind-mounting one of these files fails with ENOENT now. libpathrs does
that in its tests, e.g., by bind-mounting /proc/1/fd/0 over
/proc/self/exe.

Nothing may be mounted on top of these files but they can be the source
of a mount. So drop the check from d_set_mounted() again and refuse such
a root only if the source or one of its copies would go beneath a mount
that is already there. attach_recursive_mnt() checks the source and
propagate_mnt() checks each copy right after making it. The root is a
mountpoint by then so either we see the flag or detach_mounts() finds
the mount, same as before.

Fixes: 75f4197f1e11 ("dcache: don't put a mountpoint on a dentry that's being removed")
Cc: stable@vger.kernel.org
Reported-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/dcache.c    |  5 ++---
 fs/namespace.c | 25 +++++++++++++++++++++++++
 fs/pnode.c     |  6 ++++++
 fs/pnode.h     |  2 ++
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ba17f49f8a636..b734ce65e6377 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1628,8 +1628,7 @@ static __cacheline_aligned_in_smp DEFINE_SEQLOCK(d_set_mounted_lock);
  *
  * Only one of d_invalidate() and d_set_mounted() must succeed.  For
  * this reason take rename_lock, d_set_mounted_lock and d_lock on dentry
- * and ancestors.  Likewise for dont_mount() which marks a dentry that
- * is being removed under d_lock.
+ * and ancestors.
  */
 int d_set_mounted(struct dentry *dentry)
 {
@@ -1647,7 +1646,7 @@ int d_set_mounted(struct dentry *dentry)
 		spin_unlock(&p->d_lock);
 	}
 	spin_lock(&dentry->d_lock);
-	if (!d_unlinked(dentry) && !cant_mount(dentry)) {
+	if (!d_unlinked(dentry)) {
 		ret = -EBUSY;
 		if (!d_mountpoint(dentry)) {
 			dentry->d_flags |= DCACHE_MOUNTED;
diff --git a/fs/namespace.c b/fs/namespace.c
index aecd05ac01705..443a8e3b74f9b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2561,6 +2561,21 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 	return 0;
 }
 
+/*
+ * Would @source_mnt or a copy of it go beneath a mount that is already at
+ * @mp on @parent? Call under namespace_sem, without mount_lock.
+ */
+bool mount_goes_beneath(struct mount *parent, struct mountpoint *mp,
+			struct mount *source_mnt)
+{
+	struct mount *q;
+
+	guard(mount_locked_reader)();
+	q = __lookup_mnt(&parent->mnt, mp->m_dentry);
+	/* a moved @source_mnt is gone from there by then */
+	return q && q != source_mnt;
+}
+
 enum mnt_tree_flags_t {
 	MNT_TREE_BENEATH = BIT(0),
 	MNT_TREE_PROPAGATION = BIT(1),
@@ -2677,6 +2692,16 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	if (err)
 		return err;
 
+	/*
+	 * Don't mount on top of a root that dont_mount() was called on. It's
+	 * a mountpoint now so a later detach_mounts() will find it.
+	 */
+	if (cant_mount(root.mp->m_dentry) &&
+	    mount_goes_beneath(dest_mnt, dest_mp, source_mnt)) {
+		err = -ENOENT;
+		goto out;
+	}
+
 	/* Is there space to add these mounts to the mount namespace? */
 	if (!moving) {
 		err = count_mounts(ns, source_mnt);
diff --git a/fs/pnode.c b/fs/pnode.c
index 5f07fa14099bf..4514e75311972 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -351,6 +351,12 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 			err = count_mounts(n->mnt_ns, this);
 			if (err)
 				break;
+			/* what is already there would end up on this root */
+			if (cant_mount(topmost_overmount(this)->mnt.mnt_root) &&
+			    mount_goes_beneath(n, dest_mp, source_mnt)) {
+				err = -ENOENT;
+				break;
+			}
 			type = CL_MAKE_SHARED;
 		} while ((n = next_peer(n)) != m);
 	}
diff --git a/fs/pnode.h b/fs/pnode.h
index b029db225f33c..0fb217c48f17a 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -59,6 +59,8 @@ struct mount *copy_tree(struct mount *, struct dentry *, int);
 bool is_path_reachable(struct mount *, struct dentry *,
 			 const struct path *root);
 int count_mounts(struct mnt_namespace *ns, struct mount *mnt);
+bool mount_goes_beneath(struct mount *parent, struct mountpoint *mp,
+			struct mount *source_mnt);
 bool propagation_would_overmount(const struct mount *from,
 				 const struct mount *to,
 				 const struct mountpoint *mp);

-- 
2.53.0

