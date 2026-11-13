Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540127;
	b=S3ApYOlyeQfsrRT/X7zYs0zr15loj26TcLjabj+sneScbXc20SdgiIuqlnenBN15tauL
	 8xBZHl+G67CUtpo3nAMChn2RQjX6slTxOq6Ku74OPemXH7aW2v0VMwzuJJ0XyT+jgg++Z
	 mdbOb2ffwtUFvhqlTYhZJNZ8uBzc/pdpQJFWwTcuu22Ydru0nEBFJ5usLRV5m9tKWi966
	 L78apqOZLgOuUYhY/nPzEg/nfhTpSXfliza8JMDywggkHuTJ+hd2KgA/maMqBVa73OC+d
	 ZDan5Jt9aG0w3QAdmRoHYBashXXcPqABk5doJy2LMwatabRcZuctzzeV5QBlrFR0qpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540127;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uqni6PbexmvSsZYWV8HW2Fz17kmd+Ga95Z0wI5rx59o=;
	b=CF1TmqyIpRBxMBOrFoUtsmqjMXO4LoKDLPs6ujOKNOgtmVmkb/RFNyiM/o882CDTRHot
	 pkXSKODHnyj7ebJqjG8PKxgypT48oHYTJ5TQNU7eSz9UbxRJ1biwbLHN00w19M2a0P6g6
	 4S/DXfuG8rsQcMPsw3SmrfwhfWl3jkrrIbn+qets5kvGdxNunFzDHQrToq1pUgvEo0Ypq
	 L618rwFleg/mUvjNkgkS64e/1z9oY8bE+Pb1TNFvOqXeUAy+S4lTscJF1CA9jR6W5u6JU
	 m+7A8Ad2GgGzooEqUH6bYHHOblhRkQl7pq74rSNHEXN3jLCObB7KnUcdJRcOaARWALQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgbYZIb+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7A606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgbYZIb+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B19B1F000C4;
	Fri, 13 Nov 2026 03:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540127;
	bh=uqni6PbexmvSsZYWV8HW2Fz17kmd+Ga95Z0wI5rx59o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FgbYZIb+64edrVhbOInOAvE0Uc7jsh2fA/s2NGH3cQ+iTX7QYfMcOXIG4sLOE/1iA
	 Sw42Ngkbf9G7VGWALdqYmqs0e6Tq+3V/Ha/V+92M4sFtXyXpEQ0rJJ9QSz7/bhp2Jd
	 DIwHYp8SY9RkrSl2LDwj19zCB+zHprr3CH0qAnT8pYvPJ2EV/o26DVeI38O+VRwCc0
	 WPe0QcoLldkz8R+onaAJeFk2AhwdeZw0sRLKUbi8Ux2pLKx2bYeBQ6jS8MBk0Ojcuc
	 wQt5Hzdgc54cyo8u2spOFxxITbMQZbc55W2HtFzHeviK3tGB1XJF2sYDK00QJb7t+x
	 2w1hhCtzQew1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: look up the index by the decoded origin
Date: Thu, 12 Nov 2026 22:22:05 -0500
Message-ID: <20261113032148.1044675-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202435-failed-5.15-520ef67f47f6@kernel.org>
References: <20261109202435-failed-5.15-520ef67f47f6@kernel.org>
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

From: Chris Mason <mason@kernel.org>

[ Upstream commit 520ef67f47f69255695859b0008281a384d0bc20 ]

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
[ sashal: adjusted context for direct ofs->indexdir access instead of ovl_indexdir(sb) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/overlayfs.rst |  3 ++-
 fs/overlayfs/export.c                   |  4 ++--
 fs/overlayfs/namei.c                    | 13 ++++++++++---
 fs/overlayfs/overlayfs.h                |  2 +-
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 7da6c30ed596a..809963fff365c 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -534,7 +534,8 @@ When decoding an overlay file handle, the following steps are followed:
 
 1. Find underlying layer by UUID and path type information.
 2. Decode the underlying filesystem file handle to underlying dentry.
-3. For a lower file handle, lookup the handle in index directory by name.
+3. For a lower file handle, encode the decoded underlying inode again and
+   lookup that handle in index directory by name.
 4. If a whiteout is found in index, return ESTALE. This represents an
    overlay object that was deleted after its file handle was encoded.
 5. For a non-directory, instantiate a disconnected overlay dentry from the
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index baa50ece0bc53..c9932d0d7cdfa 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -721,9 +721,9 @@ static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
 		}
 	}
 
-	/* Then lookup indexed upper/whiteout by origin fh */
+	/* Then lookup indexed upper/whiteout by origin */
 	if (ofs->indexdir) {
-		index = ovl_get_index_fh(ofs, fh);
+		index = ovl_get_index_origin(ofs, origin.dentry);
 		err = PTR_ERR(index);
 		if (IS_ERR(index)) {
 			index = NULL;
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 22408f4a2b48d..ee4e37646e85c 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -666,14 +666,21 @@ int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
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
index 4b6c82292a8cd..c2b49a717a94c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -500,7 +500,7 @@ struct dentry *ovl_index_upper(struct ovl_fs *ofs, struct dentry *index);
 int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index);
 int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
 		       struct qstr *name);
-struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh);
+struct dentry *ovl_get_index_origin(struct ovl_fs *ofs, struct dentry *origin);
 struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 				struct dentry *origin, bool verify);
 int ovl_path_next(int idx, struct dentry *dentry, struct path *path);
-- 
2.53.0

