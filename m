Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540564;
	b=Pxgiy5S5mBtEEZ1Ydubd4A+GmfQ3vnkOR7Z1lZvDxFAfu7UfgDo/e8QzZKCM49w7WXY9
	 IE8W/af/2Vx7k36QCvsz2ia50oTLrHsFMboV7W0rgmOX0LdkYw+XGOz1TzsV/lLg3XXhs
	 fL+LLioWzJ4eJxhvRwY71EqenieXSAwzqOKWV+U5dCXLw7nT329uXe9DgYIDhgZkxMKZp
	 YD5fHlxtlJLpGCF/ttpu/MtPprSFtvodSRH0vEy5z8OUStJYklfVuymfUK4huAbH+FZcL
	 +e2ld2ps6DS4uko5s4H/pGeCRK4B89TFtWYAkU4/M4Dr9YzpAneW2f+JzjncHchsKMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540564;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PRh+8Jx9An85hLR4ekN2qFC+7xQp8tszPPmcJfgRN1U=;
	b=WU48/iEqqkSH8OKnpgqwJnkpETcblm3vVVpFIj4b1+OQvM4qqwz6kF19d2C/kg9448ys
	 rksMtgB50rwi7mD4JJWg6a4KNziMfFmxpBM8I6Tuws7gdDsxsirHZGgUaS2NOAxlZf7tI
	 oK5M+ZTabsh+V9/DZ+zABiE5pruZn1Tstv5Ms84VKuwd9P8zyKbi87i4XBbzpwHVCxef8
	 yJ0JiHCMUaI1foVjQ7aZAz20HQ4VYDkFOg6UnyvPB5+YALw/6GM1BOEk0jLLgtC/jv3US
	 r+pGeeXka+zaH45ZkycQ8oXa3FGivWLid2jMyngpTPeZx1+pfEEdAiO1mZuOjHNtDDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYlYvXki;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00F606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYlYvXki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521371F000C4;
	Fri, 13 Nov 2026 03:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540563;
	bh=PRh+8Jx9An85hLR4ekN2qFC+7xQp8tszPPmcJfgRN1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SYlYvXkiassn8uF+PNdcAOm4MBkwKpOzb7ZiJn6X3CjeDkJmrEeuIeTFrLMmNCaAA
	 fLUZu1fEc0PlFBnD+1LXQwHjD0P73UYx1OzBu/feAdRoDMK4WAigrVxgG9bQfOoPyw
	 cfxz3sEN4d6Q7tzxrsHkBNrD+tpPSYHcE67YvmlUoGUMozg09UeCVQVJzJIWujRH7j
	 y3uIeT1MFtXSiiMZTXrQ6q9Yezi0cJ7yOFrBeTTNo3tfwvJtBBb1fY7Ijm2oT4+rtg
	 eukk+MjyRews1u4Z6/4TA6Jj4KwKMIMLKR+fqmllQmVjPJYfM5MoMW+PgKeQ3Bfcds
	 wnUd3WIpQG/JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ovl: look up the index by the decoded origin
Date: Thu, 12 Nov 2026 22:29:22 -0500
Message-ID: <20261113032909.1053969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202900-failed-5.10-520ef67f47f6@kernel.org>
References: <20261109202900-failed-5.10-520ef67f47f6@kernel.org>
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
[ sashal: Removed the ofs argument from ovl_get_index_name() to match the existing two-argument helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/overlayfs.rst |  3 ++-
 fs/overlayfs/export.c                   |  4 ++--
 fs/overlayfs/namei.c                    | 13 ++++++++++---
 fs/overlayfs/overlayfs.h                |  2 +-
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 137afeb3f581c..435aff7c52f65 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -527,7 +527,8 @@ When decoding an overlay file handle, the following steps are followed:
 
 1. Find underlying layer by UUID and path type information.
 2. Decode the underlying filesystem file handle to underlying dentry.
-3. For a lower file handle, lookup the handle in index directory by name.
+3. For a lower file handle, encode the decoded underlying inode again and
+   lookup that handle in index directory by name.
 4. If a whiteout is found in index, return ESTALE. This represents an
    overlay object that was deleted after its file handle was encoded.
 5. For a non-directory, instantiate a disconnected overlay dentry from the
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index dd3e1969e6c87..d85456e3607b4 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -719,9 +719,9 @@ static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
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
index 11be07632d188..9b09697754f75 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -655,14 +655,21 @@ int ovl_get_index_name(struct dentry *origin, struct qstr *name)
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
+	err = ovl_get_index_name(origin, &name);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index c149329d71e78..3d2e45d885df7 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -415,7 +415,7 @@ int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
 struct dentry *ovl_index_upper(struct ovl_fs *ofs, struct dentry *index);
 int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index);
 int ovl_get_index_name(struct dentry *origin, struct qstr *name);
-struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh);
+struct dentry *ovl_get_index_origin(struct ovl_fs *ofs, struct dentry *origin);
 struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 				struct dentry *origin, bool verify);
 int ovl_path_next(int idx, struct dentry *dentry, struct path *path);
-- 
2.53.0

