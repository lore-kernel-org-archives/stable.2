Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273878;
	b=r0rgTyc8tUNK/EsVBURxEcUJZSMTCUOvTlu3Sk3UmyTJhzFWBqcJgFLDAedOtQAwVSkA
	 e3p4t3za9zIQ/iC7+VvKCusafsfX+iIvvbI80K15wBWHtuohFlxFOSmCyJ8r4TAbMT/dM
	 0NJSgQmbSjsvY4ziKwKkfxYoydn1+/+7kVLNNNTC3nMKQrl3Rc7PZ7lZPF1Bw2jyoAI50
	 AczEqdjKrasUf1zwJ+N8pzbvP5SO1etDJSNnake8cc3KoRjKbqsaPiCMb50KPkko5MxRK
	 lL1+9kc7jZ+2ARAy12zZbnKmiGhgAcWb/NTxIJwlv9wx3uhIvzV+k7fs0auR+CasEbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273878;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DS0qcGYcQ6o6pby72YruZhrPbXAEQ0HlgjBhTYkonqU=;
	b=TRe4yqn9ZZ3+KybXmNLoj1Ai8DmpEziIJ4aeHTbVt4QuKsnjvFcGgVksZqTT1XgzJND1
	 qx30d1KZrMkjC3ZC8SQ4jFnzPNLGfS4iq/x791D2Z+Zl/vvg28P6xujYzBcS5BJDJB/Ez
	 xcbSk4h4FWiBDDif1lo2FYqAbSR7o970vI0b/hPLIRIf8v8UJmWDZGlQ1bJff2Y5sBOO3
	 CEH2USMLvBgwsLZoXPJ4d29ULuqf0NYUtoicnhjEcOlPE1ak7c1CsgxcxujMeuHrZHkQ3
	 lqMwLwmD4+b9NmU4bCPqZjKjzhDgoldtJfxJ50CwIe+24Ej37dMQ7r4FuhOjCuwfJ0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHV6Jk7E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F63606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHV6Jk7E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2696E1F0089F;
	Tue, 10 Nov 2026 01:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273877;
	bh=DS0qcGYcQ6o6pby72YruZhrPbXAEQ0HlgjBhTYkonqU=;
	h=From:To:Cc:Subject:Date;
	b=LHV6Jk7ELSm4QTmVcJT88fyoAQmdnZ66nyp3YVCVpqjzRExzH5ay7z7YjvVLW+5mD
	 Hbfzj4v9uVvHAGpjWkv0c5yT0baJa/tJFHhPd4Q96AFjwUF/6TBWujqnVJK6veJZpf
	 QqpJcP7DxT4f7Hk+c2Pk7/vIJEtoltuf8YN/4fAnTRS+tuUqTD7njNVtQ9jt3LnQUR
	 gFfG+7hdP2mzxSw0kualCHPyIrm06K16uXSclIriJ7Ik9kdUrjBytDp0D0iSpMPwzF
	 DSR78uvzjoQnYLE+EoDvhyoSfmf3crTrJHlNZf5GSD09QYBnTmCjGT32ATg3hONhCn
	 FksrBs/kCaVFA==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	amir73il@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ovl: look up the index by the decoded origin" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:36 -0500
Message-ID: <20261109202435-failed-5.15-520ef67f47f6@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 520ef67f47f69255695859b0008281a384d0bc20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202435-failed-5.15-520ef67f47f6@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 520ef67f47f69255695859b0008281a384d0bc20 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Fri, 16 Oct 2026 21:17:22 +0000
Subject: [PATCH] ovl: look up the index by the decoded origin

A file opened by file handle on an overlay with nfs_export=on can show
the stale lower data of a file that was copied up to the upper layer.
While the file opened this way stays in the inode cache, a lookup of the
copied up file by path fails with ESTALE for all users. The open can
also succeed for a file that was removed, where it has to fail with
ESTALE. This happens with a handle that has one byte changed. The handle
comes from an NFS client, or from a process that calls
open_by_handle_at() with CAP_DAC_READ_SEARCH in the initial user
namespace.

When a file in a lower layer is about to be modified, overlayfs first
copies it to the upper layer (copy up). With nfs_export=on, each copy up
also creates an entry in the index directory, a directory that overlayfs
keeps for itself on the upper filesystem.

The handle of an overlay file that comes from a lower layer wraps the
handle of its lower inode. Overlayfs calls this lower inode the origin.
The overlay handle stays valid after a copy up.

To decode such a handle, ovl_lower_fh_to_d() first decodes the wrapped
handle to the origin. If no overlay inode is cached for the origin, it
looks in the index directory:

- An index entry there leads to the upper file.
- A whiteout, the marker that overlayfs uses for a removed file, means
  that the overlay file was removed.

The name of an index entry is the handle that copy up encoded for the
origin, as a hex string.

ovl_lower_fh_to_d() builds the name for this lookup from the bytes that
the caller passed in. But handles with different bytes can decode to the
same inode:

- Overlayfs ignores some flag bits of the handle.
- A lower filesystem can accept a different fid type, extra bytes, or
  generation 0 for any generation.

Such a handle decodes to the origin but misses the index entry or the
whiteout. So the decode returns an overlay inode that has only the lower
file.

While that inode is cached, a path lookup of a copied up file fails with
ESTALE, since the upper file that the lookup finds does not match the
cached inode, which has none.

Reproduced on tmpfs and on ext4 with open_by_handle_at(), after a copy
up and a mount cycle. A handle in which one flag bit, the fid type, the
length or the generation was changed read the old lower data, and path
lookups returned ESTALE.

Fix this by re-encoding the decoded origin and building the index name
from that handle.

Fixes: f71bd9cfb692 ("ovl: decode indexed non-dir file handles")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/overlayfs.rst |  3 ++-
 fs/overlayfs/export.c                   |  4 ++--
 fs/overlayfs/namei.c                    | 13 ++++++++++---
 fs/overlayfs/overlayfs.h                |  2 +-
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 16c35b491dad4..4c241d220bc23 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -731,7 +731,8 @@ When decoding an overlay file handle, the following steps are followed:
 
  1. Find underlying layer by UUID and path type information.
  2. Decode the underlying filesystem file handle to underlying dentry.
- 3. For a lower file handle, lookup the handle in index directory by name.
+ 3. For a lower file handle, encode the decoded underlying inode again and
+    lookup that handle in index directory by name.
  4. If a whiteout is found in index, return ESTALE. This represents an
     overlay object that was deleted after its file handle was encoded.
  5. For a non-directory, instantiate a disconnected overlay dentry from the
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 9aae20c59608a..bd998a3d8b95c 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -713,9 +713,9 @@ static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
 		}
 	}
 
-	/* Then lookup indexed upper/whiteout by origin fh */
+	/* Then lookup indexed upper/whiteout by origin */
 	if (ovl_indexdir(sb)) {
-		index = ovl_get_index_fh(ofs, fh);
+		index = ovl_get_index_origin(ofs, origin.dentry);
 		err = PTR_ERR(index);
 		if (IS_ERR(index)) {
 			index = NULL;
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index c6127edb9be95..64d63b260709c 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -781,14 +781,21 @@ int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
 	return err;
 }
 
-/* Lookup index by file handle for NFS export */
-struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh)
+/*
+ * Lookup index by decoded origin for NFS export.
+ *
+ * The name of an index is the hex of the file handle that copy up encoded.
+ * The bytes of the handle to decode cannot be used as the name, because a
+ * lower fs may decode many handles to the same inode.  For example, it may
+ * ignore the fid type, extra fid bytes or a zero generation.
+ */
+struct dentry *ovl_get_index_origin(struct ovl_fs *ofs, struct dentry *origin)
 {
 	struct dentry *index;
 	struct qstr name;
 	int err;
 
-	err = ovl_get_index_name_fh(fh, &name);
+	err = ovl_get_index_name(ofs, origin, &name);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b5a672e8e4764..e42543d4c1080 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -750,7 +750,7 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index);
 int ovl_get_index_name_fh(const struct ovl_fh *fh, struct qstr *name);
 int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
 		       struct qstr *name);
-struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh);
+struct dentry *ovl_get_index_origin(struct ovl_fs *ofs, struct dentry *origin);
 struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 				struct dentry *origin, bool verify);
 int ovl_path_next(int idx, struct dentry *dentry, struct path *path,
-- 
2.53.0




