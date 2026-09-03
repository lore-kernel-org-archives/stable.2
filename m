Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF584AF684
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443246; cv=none; b=Bh3hefvNk1AJGx8o1ZAw/faZnDyrmyMG4HPbgqZUEe5eUgfueZng60zk6gLS7WhMaOj6ByQLLxwwQ/jWLNvMGONzWGVdetX7wyPMnat7S2rCQEE2mYqPvZMegzfrFIc2/YSsEO7BXWY4q0xAX2uG7STFlr6RrD5e0EiUHQfwvgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443246; c=relaxed/simple;
	bh=Bj/b2iCd0TUwm/V769lmWtedgJnze7C7MPhtNe3vTYw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qgFte99O2HxtOpZnoPPLLCFQLa2w2B/ejoKCk5VgPX4ZcamcRezaKCg4FlO6SqPU9JPxa1LjrY7avR4xvsmbMBrmiGzK0fIHW5fBucHP4DxA/MZOujIQoT8HD2Oc9GVPK/fJfl4Y6eg6h5u1yAkYx9os2tIuVOslrAC8SiTpIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P6QssxFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P6QssxFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4221F00ADB;
	Thu,  3 Sep 2026 13:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443230;
	bh=Z20FbuUczKoCeiazIZ02tFSwmuNBxz5iKkLQL3Mnw1Y=;
	h=Subject:To:Cc:From:Date;
	b=P6QssxFWwrUMHdOj4vq+x/OxKJkxyB4vQjLRlziiYZOqB1ud9CAkkVIPiFpXJswmM
	 DsE2B+IcN3aAVYBBGdB30sAlGk0tVkOdhNVGKaecineHl/Q0b4AR4qqc9plW6HrYd+
	 M/U7cTv771Bd3ZJYvY9DGOJ6WOxK9zkJIHY7cnJY=
Subject: FAILED: patch "[PATCH] ceph: properly decrypt filenames in vmalloc() buffers" failed to apply to 6.12-stable tree
To: cfsworks@gmail.com,CFSworks@gmail.com,amarkuze@redhat.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:23:28 +0200
Message-ID: <2026090328-bolt-atrium-edf4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e939fc6a7bd969a58a150b7f188c1047138403e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090328-bolt-atrium-edf4@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e939fc6a7bd969a58a150b7f188c1047138403e3 Mon Sep 17 00:00:00 2001
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 29 May 2026 20:06:46 -0700
Subject: [PATCH] ceph: properly decrypt filenames in vmalloc() buffers

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

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 7493a3acd7d0..bc0a097a4cea 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -298,6 +298,10 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
  * Otherwise, base64 decode the string, and then ask fscrypt to format it
  * for userland presentation.
  *
+ * Though the fscrypt/crypto subsystems broadly expect all buffers to be in the
+ * linear-mapped region, this function slightly relaxes those requirements:
+ * fname->ctext, fname->name, and oname->name may be vmalloc(), but not tname.
+ *
  * Returns 0 on success or negative error code on error.
  */
 int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
@@ -305,11 +309,15 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 {
 	struct inode *dir = fname->dir;
 	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str _oname;
 	struct fscrypt_str iname;
 	char *name = fname->name;
 	int name_len = fname->name_len;
 	int ret;
 
+	if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname)))
+		return -EIO;
+
 	/* Sanity check that the resulting name will fit in the buffer */
 	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
 		return -EIO;
@@ -350,16 +358,18 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 		goto out_inode;
 	}
 
+	if (!tname && (fname->ctext_len == 0 ||
+		       unlikely(is_vmalloc_addr(fname->ctext)) ||
+		       unlikely(is_vmalloc_addr(oname->name)))) {
+		ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
+		if (ret)
+			goto out_inode;
+		tname = _tname.name;
+	}
+
 	if (fname->ctext_len == 0) {
 		int declen;
 
-		if (!tname) {
-			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
-			if (ret)
-				goto out_inode;
-			tname = _tname.name;
-		}
-
 		declen = base64_decode(name, name_len, tname, false, BASE64_IMAP);
 		if (declen <= 0) {
 			ret = -EIO;
@@ -367,13 +377,28 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 		}
 		iname.name = tname;
 		iname.len = declen;
+	} else if (unlikely(is_vmalloc_addr(fname->ctext))) {
+		memcpy(tname, fname->ctext, fname->ctext_len);
+
+		iname.name = tname;
+		iname.len = fname->ctext_len;
 	} else {
 		iname.name = fname->ctext;
 		iname.len = fname->ctext_len;
 	}
 
-	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
-	if (!ret && (dir != fname->dir)) {
+	_oname.name = unlikely(is_vmalloc_addr(oname->name)) ? tname : oname->name;
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
index 80c72f295bcb..1cb95688c633 100644
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
-			tname = _name;
+			if (likely(!is_vmalloc_addr(_name)))
+				tname = _name;
 
 			/*
 			 * Set oname to _name too, and this will be

