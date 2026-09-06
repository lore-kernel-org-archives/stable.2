Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6BE3A875D
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716885; cv=none; b=ZOZ9FOtEa5TywKiv4ZRU9WWxAHMOClVmKEVctinKj+UzAwCdQWaAQpyZoh2xfPZwE4j6v5fdNBfjDU1eXQUHoekGkGcwlJ7jB6LiqJgpuKGGDhb4ImFuFeYvexmF8yxB1Y8pOTPIEOg3kDS43qWj7Oy57XsfIfhjIApU6DlQl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716885; c=relaxed/simple;
	bh=pS4KYgLGRoBQWp79v6UceUM7W3hueiGOf5QitAw/36g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEjCwIkruAg7vDBtNOhMoxr8bOGQn4g7j4OzzJ4Pk5fP8vxRDyN8LjBDEVp+5mm8mRtpe69VbaSunjD5IWUhdyY8so6Ja8B3MVc4iPXyIOqd2yTPtjQioJVEGKpWSGUnYiFQihU4PFwG4o5o/gmKzA+oWWYYNVl3GGjyZPTEFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvGQGWoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvGQGWoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1821F00A3A;
	Sun,  6 Sep 2026 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788716883;
	bh=eS4N1INXIr2kICb4iKTEPndLNv+pm4a4khwNjIpQlKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OvGQGWojmH4orEn5uLwXOGIVJzjdADD3x0ZpLI3bjK1WbN1BGEgXJzcqHiV3+Q9UT
	 8wpduNpGKpzEZAC2MF1yFEDxLrKVPmKMSushXQw1WPT43ZeItK6U1Ki2Y1XuDDWYet
	 PaGrrr1ycmLyOrFeQyZ9b8ZOrN3C+jvWpsSOCvpxUyoVi/C/CKVj4psLRl1TKHZldH
	 gtITDckIUsaI6P1SXAnRX0IMCgWhrE2h8OGhDCHz+sJAq9RnJve7SQwjpOBoBhUmby
	 jKGBKvcO/Hg7t3VzHvjjp7rhXuzDmdCMDq12Lwz88dDfguUWHS52UxCjTHYLtPRv+h
	 aWuUY6nHtKnng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sam Edwards <cfsworks@gmail.com>,
	Sam Edwards <CFSworks@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ceph: properly decrypt filenames in vmalloc() buffers
Date: Sun,  6 Sep 2026 13:47:59 -0400
Message-ID: <20260906174759.1745216-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090328-bolt-atrium-edf4@gregkh>
References: <2026090328-bolt-atrium-edf4@gregkh>
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
[ adapted raw tname buffer accesses to the legacy tname->name interface ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/crypto.c     | 46 +++++++++++++++++++++++++++++++++++---------
 fs/ceph/mds_client.c |  8 ++++++--
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 3c382486c5e98..ed6b32f821a8d 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -370,6 +370,11 @@ int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry,
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
@@ -377,11 +382,15 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
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
@@ -422,16 +431,19 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
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
 		declen = ceph_base64_decode(name, name_len, tname->name);
 		if (declen <= 0) {
 			ret = -EIO;
@@ -439,13 +451,29 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
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
+			tname->name : oname->name;
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
 		char tmp_buf[CEPH_BASE64_CHARS(NAME_MAX)];
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5f2b70b846e71..b3a7920297f4d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -496,9 +496,13 @@ static int parse_reply_info_readdir(void **p, void *end,
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

