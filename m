Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828392;
	b=qnbTiCy4c27kf1TKtzzzoOiYGAr+wkbvuC2qJrjXz1ZyAx7VQrsFCFxd5sFOaODJLGjH
	 e+t6RXU/5X/EPpUfR+gjgGiPLhKuUSNjw9CrdNaVT7vK8i1PYP/0yyI4Fv4zA0KVNM/Hv
	 yoOlTbQeD2abrDBNEfAyB27GtTku7SIk8nHoCeK+w+8H5mEAgmcxbMd0/KO/5uC7cKM2R
	 fXTU7+5nr9DvoPRtGnoTIXZ9vZk9n++YtuksqskK5oiWjgGwlH5xSpPX/vwHDmt4yGGAv
	 TtpOD/9pLrkVDH8uaYEon+9aDeh4JMCXHobXoSjZk9MiT2mEK40D1EEBOW76urDJUIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u7CcFHErpg5MyF3XpM4xUInbMSzKXVsJFYKaM62tDY4=;
	b=5IFjO7OtSH8R/KBa+nuLw56yC0MjQirwXkT258NVhjvnWfmtOtsJs+49rc8nje2bDMjS
	 Ek0z9oovAG7+15ajDVH/rZQSbbaUh2ZhbLcU+KyBhXodI4H8o7KFxuheKVabdU7gSpoe2
	 GsLgT26LcRayAxGOrDbTPMijeNpW0RRZbr4655vJ12psAm95RVa68C+S5QCreoXQT4yyw
	 /91pM3tr7cm98XhdG4c7tkAv1n9DEJbjTfoIK6+x7/2gvQtowT9dCu4KXb0BhLAQGKxjn
	 O+YZ7iZciZKQQRE8dBm05/eirRF8KKGopZVydfVr8iQUI5ZOTBoK8bEnTZaPCdwTt0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rc+dbIPF;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA08606E2D6
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 21:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BA08606E2D6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rc+dbIPF
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso10551175e9.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 13:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793828391; x=1794433191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u7CcFHErpg5MyF3XpM4xUInbMSzKXVsJFYKaM62tDY4=;
        b=Rc+dbIPF2v1k57xNpo6CbAQr9NPtXSdtLQBSlJDYs3sSIcR7KBlSHqqBlVYGcraNdq
         34qCxoclTxWAa7dBe9o6vS2/Qj0zU+2p8WqaQ6KxpqvH1x68DVEdj4Yo3oSBdf8MYbF6
         cfX9f9aWYdYu1VDLf3nYSjrkR5K04JlbS2a+YoirdaLCoUCqNiuCsxyHFJGXRT3oe2ul
         N1iu/6uF1yQPT6QYNJh2VsW2d0M/G6L3fg3/az9nNvqRSEf81rkyyplyFgWxTSuMzfrR
         KfzLlqfq0PchmeSCIaAyr+OWmy/YTuRA8qOskNIWyqa65AmoyQYWlbmMeX783FU14oPi
         qrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828391; x=1794433191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u7CcFHErpg5MyF3XpM4xUInbMSzKXVsJFYKaM62tDY4=;
        b=Q+orrJhveMe6V4z5rdjZZvmxlJ5xrrkJCS2dojsnGHFLTkyj5d9ta+ZAYltLzwZ4Kk
         mJQQeyTC3aawmBvfXmSk+hgQVDn8PRgKWHp2Sg5HXYpclpxDZMHYK3Z83vcDUrIAqF1i
         bVYSuUNm9Dpcqd7uUmgh52KccRP6PlM1PzFx611VuohL5uMksnScKIW5/RHrMCEqSGBA
         nUVcutDOAJSVPBfX4NZDdclbsNChSHlfl9vUmSQ9TFd+mJ3fA73YTop+u3b1ncL0ZRqR
         OLaK0nPMK24n/NaUQxUZDayJn4j7sWOd7gniw2IdVN0G3rBWbOVBjoBMFWFikDoxQpb4
         Bs/A==
X-Forwarded-Encrypted: i=1; AKwUvBxP43vFMFeSKLO6yNIySWo7hCNhNj9+po9imFPQoMGv7f2cqfbSP7t4Kk3EecJXepOx+QB9Wkg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GMolRQG2uI4Q2HEl0bRbpHASPe28UWquLJ/oOdVV4w8Feb20Y
	nl+PZNUcb1eumSF4GgCjSm7y/QBwhSzkZ1nDIOtOl2j3TVtPZCebxoei
X-Gm-Gg: AYBFou3rmYVgFRPQ09p8fFiHnQ+6MAJOQk84uxlw3BN1MC2JNM2FYmODuL/wz65U7uz
	hc5hzTkv0yQoJ6Iil/bNq6iYiOVJrmnMhuasckiM0Nfvk6a4svEJlJmFDRgkkXrB+v+tWb3XudI
	x9J1rdOpIxJc0gJvhzJ+Ty93mSvTTUsNgZjFo6zaMS7O/poPQ/7VxYu5Sym4pBUjZDSRlorGizT
	pFZ2h8vrKHwP63i0+AGq9oqS/T8hOPjGqQQerMDf6hIiM8FumSYbBs+XquBw2TVGgaT/K8kJmXG
	aaljwPKPSPagn5u7NHx7QrsyWUndh7oujz3kmzHDtYz9+HL61LZK4elyRdgCjk49ChqkXmiA6lC
	SU9W0N1fUA72QDLb7wGgi148RYbyZ8f1Fm2jskc7I4L3xikgomQitRe6rPvUoO7v+PxobGW54db
	X7b0uRNwrxYwE82yxxQm6Vil/590PZdBaa3Wd8OTOZdAoOncjOVw1dFldhV2f8XrmjVFIBdy408
	Zbq42M8ujoI9jTxpnfswJbvf1LiaptrcR601ncJlqlEA4OsPPFx1CLOTmQfWjUQeExg+WBF4QX0
	jK82Pqf91VAV9q6Ki/p2dGvgu12r9g85LIL9/x6/q81YuBPa2WyD/KirHLNu8q3P48Ahd9WEqSt
	IoFV8Q+DuXxY=
X-Received: by 2002:a05:600c:3554:b0:4a4:7a8d:c436 with SMTP id 5b1f17b1804b1-4ac17470fdbmr390966155e9.11.1793828390513;
        Wed, 04 Nov 2026 13:39:50 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feeb5196esm5534756f8f.58.2026.11.04.13.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:39:49 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ovl: look up the index by the decoded origin
Date: Wed,  4 Nov 2026 22:39:48 +0100
Message-ID: <20261104213949.3671581-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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
2.55.0

