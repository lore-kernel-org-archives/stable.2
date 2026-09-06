Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17218C02E
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714381; cv=none; b=i+7nFuUVYhpU7BKgkAD26k3IIQQnN7iOzNVna7jnZ/etAkm8DL8J2ZKXZSC0N+7Ig0KtMYKHDndocOKYQjeYN+sDdquvT1G9NAh8MHXUGF7KikBAu4qM7yKGKM9nW0vizdtVNrSJPY53ijt/y1rvIDP+J5tF3/o0e4vOpFcBOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714381; c=relaxed/simple;
	bh=ZRfh+IJG16KhNSU+urM9o49rxLFea5yx7tBNEYMZN40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNp4Zp3B+0LvWScu1VCPJCAkU9qsjohbDIDSO7DTZVTLtfvudhLDKzEypI5nTgeMjSoKrQotNVJu7J+TVB7ELHP0aFyS+WSfT+rv7DKsIqrJyQSczlUmXck+bycaEyW7Ng4PyfOIGX32PLX4Hm7lRtlWvXoUhGVifdnswIvipQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7gmkI9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7gmkI9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592351F00A3A;
	Sun,  6 Sep 2026 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788714380;
	bh=A3iqxDTfmWi2RjmnjSlYWgUy7BC1a91n4q6cNnAaZ2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7gmkI9zonaEqVdWpzzvDA/JBYhVtUuWfMcMWypUGW5o7Vi0iDsmNNtjkwEmMMfOR
	 uCM51R2nghDu5nqAUPBgznhWKd+wzMixMXEfiJHi2+9IzntFti5mP0ZvD0dqiFCk0r
	 LDhUBvQ0z/l7RW4FqhMlf0dZBAi5wEXDWy1CW4p31eWVVlVp1Mkpc1V4IJymwGm3hz
	 K2tG9BMqOF52IO1V4svCL09P5NeyHSo/n9HKPrNIrGAQ+hswk6gnBYRfzd47OjO/Zu
	 /Y5K4OFYhR8+WCIwFXdzJIGKi2nRebBp9MQNaLcKEx+xZ3cF3y0qfa0A+fG4/6nhMg
	 jXE9Fio+06LYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sam Edwards <cfsworks@gmail.com>,
	Sam Edwards <CFSworks@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] ceph: properly decrypt filenames in vmalloc() buffers
Date: Sun,  6 Sep 2026 13:06:18 -0400
Message-ID: <20260906170618.1647518-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090327-treadmill-duller-f207@gregkh>
References: <2026090327-treadmill-duller-f207@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sam Edwards <cfsworks@gmail.com>

[ Upstream commit e939fc6a7bd969a58a150b7f188c1047138403e3 ]

The fscrypt subsystem uses the scatterlist crypto API, inheriting its
requirement that any buffers are in the linear mapping region. However,
the messenger client uses kvmalloc() to create buffers for messages,
which will occasionally place those buffers in the vmalloc() region when
physical memory fragmentation doesn't permit a large enough kmalloc().
The various callers of ceph_fname_to_usr() directly pass (slices of) raw
messages from the MDS without considering that the messages may be in
vmalloc() buffers, resulting in oopses especially on non-x86 platforms
(see 'Closes:' for more details and a reproducer).

Make ceph_fname_to_usr() explicitly tolerant of vmalloc()-allocated
fname->ctext, fname->name, and/or oname->name buffers, using `tname`
(which, when non-null, must be a linear address; when null, is briefly
allocated as necessary) as a bounce buffer to avoid passing any
inappropriate addresses to fscrypt_fname_disk_to_usr().

Additionally change parse_reply_info_readdir() -- the only function to
supply its own `tname` -- to follow the new "tname must never come from
vmalloc()" rule by passing NULL when the message is not in the linear
region. Though this causes a per-dentry kmalloc()+kfree(), this overhead
exists only when processing the minority of messages that spill into
vmalloc(). My (crude) testing puts this at only about 1 in 8,000 readdir
messages. Still, if the overhead proves unreasonable in the future, it
is easy enough to mitigate: a future change could allocate a bounce
buffer in parse_reply_info_readdir() and use that as `tname` instead.

Cc: stable@vger.kernel.org # 888d33b208bd: ceph: pass fscrypt `tname` buffers directly
Cc: stable@vger.kernel.org
Fixes: 457117f077c6 ("ceph: add helpers for converting names for userland presentation")
Closes: https://lore.kernel.org/ceph-devel/20260415034020.11530-1-CFSworks@gmail.com/
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ adapted raw tname buffer access to the existing struct fscrypt_str interface ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/crypto.c     | 50 ++++++++++++++++++++++++++++++++++----------
 fs/ceph/mds_client.c |  8 +++++--
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 64d2407592772..1cc11f77413c1 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -298,6 +298,11 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
  * Otherwise, base64 decode the string, and then ask fscrypt to format it
  * for userland presentation.
  *
+ * Though the fscrypt/crypto subsystems broadly expect all buffers to be in the
+ * linear-mapped region, this function slightly relaxes those requirements:
+ * fname->ctext, fname->name, and oname->name may be vmalloc(), but not
+ * tname->name.
+ *
  * Returns 0 on success or negative error code on error.
  */
 int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
@@ -305,11 +310,15 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 {
 	struct inode *dir = fname->dir;
 	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str _oname;
 	struct fscrypt_str iname;
 	char *name = fname->name;
 	int name_len = fname->name_len;
 	int ret;
 
+	if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname->name)))
+		return -EIO;
+
 	/* Sanity check that the resulting name will fit in the buffer */
 	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
 		return -EIO;
@@ -350,31 +359,50 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 		goto out_inode;
 	}
 
+	if ((!tname || !tname->name) &&
+	    (fname->ctext_len == 0 ||
+	     unlikely(is_vmalloc_addr(fname->ctext)) ||
+	     unlikely(is_vmalloc_addr(oname->name)))) {
+		ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
+		if (ret)
+			goto out_inode;
+		tname = &_tname;
+	}
+
 	if (fname->ctext_len == 0) {
 		int declen;
 
-		if (!tname) {
-			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
-			if (ret)
-				goto out_inode;
-			tname = &_tname;
-		}
-
-		declen = base64_decode(name, name_len,
-				       tname->name, false, BASE64_IMAP);
+		declen = base64_decode(name, name_len, tname->name, false,
+				       BASE64_IMAP);
 		if (declen <= 0) {
 			ret = -EIO;
 			goto out;
 		}
 		iname.name = tname->name;
 		iname.len = declen;
+	} else if (unlikely(is_vmalloc_addr(fname->ctext))) {
+		memcpy(tname->name, fname->ctext, fname->ctext_len);
+
+		iname.name = tname->name;
+		iname.len = fname->ctext_len;
 	} else {
 		iname.name = fname->ctext;
 		iname.len = fname->ctext_len;
 	}
 
-	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
-	if (!ret && (dir != fname->dir)) {
+	_oname.name = unlikely(is_vmalloc_addr(oname->name)) ?
+		      tname->name : oname->name;
+	_oname.len = oname->len;
+
+	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, &_oname);
+	if (ret)
+		goto out;
+
+	if (unlikely(is_vmalloc_addr(oname->name)))
+		memcpy(oname->name, _oname.name, _oname.len);
+	oname->len = _oname.len;
+
+	if (dir != fname->dir) {
 		char tmp_buf[BASE64_CHARS(NAME_MAX)];
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%llu",
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3c692ad02c857..b1bb3a30c3bad 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -541,9 +541,13 @@ static int parse_reply_info_readdir(void **p, void *end,
 			 * to do the base64_decode in-place. It's
 			 * safe because the decoded string should
 			 * always be shorter, which is 3/4 of origin
-			 * string.
+			 * string. If this message was allocated with
+			 * vmalloc() (happens, but rarely), leave it
+			 * NULL and let ceph_fname_to_usr() allocate
+			 * suitable temporary working space instead.
 			 */
-			tname.name = _name;
+			if (likely(!is_vmalloc_addr(_name)))
+				tname.name = _name;
 
 			/*
 			 * Set oname to _name too, and this will be
-- 
2.53.0

