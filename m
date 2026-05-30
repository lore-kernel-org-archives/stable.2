Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7C329C6B
	for <stable@vger.kernel.org>; Sat, 30 May 2026 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110430; cv=none; b=iDMf1VTKGbtT3uB/IZfHD9KkTfN1WCbQd3wk4LibRGbdy2CFboTCOT+qttq78Ha91XS0HmoZpQwswrMvzwijLzAoXFR0mBqhfs5+dA+PQGfz0xfT8c8ODMqS6mYuQWzxrDnG9NOy+F2XYiUkzQhyNrI6UfhLAeVjozYqtpfqOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110430; c=relaxed/simple;
	bh=y9o5pE/t2QwB8acLQ6u3PuFsa7vnP5zDEEAoI8hWT6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hp1wO/gk6pS9aZRhDPbk6YQReNb8K2KqJoh8RtJBNKmXYloCh05xnt+VkZFJA7iuoDCmarsrUxq8lDQ56OGsgutj6YB4oqkZb/FKWmWY0h7TKcUgFpkyIkhaLYwKZRO/NSdjldwau+TGxSW+qp6YU6AFUpiMGF+wDqV4J+68ia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye+po/QO; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye+po/QO"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43a2ad7bcc4so6722880fac.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 20:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780110428; x=1780715228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqjY4u9zUiWcPW2IlZPEJiw+YGemyDZucGA8LuuTFVU=;
        b=Ye+po/QOHyRrLXjxUNfqlFfMKWiIN8ieXdmdhLpPaJtq6xv9K7Deg3yivJWcYk9Pp2
         rbfgTZmho0TGBZwNGCkYWhs5K4m9Zx6JxyDwHaFt1CfXP/V4mGLuzvPiS1A91kHTpsNo
         0N6z+Jk2/jQZZfYbnKQwA9pFztGYwc+2P8KgtBzHQ8ABDj8ZXbJlvwk0PJZM1E8X7v4k
         Byj3WiRbbm0QSXf8bxWaBQGTTJlczvCBF7M1SuPCtJT7BRKPT4s2PL8IeR1fnhzujwdJ
         WDdvjiJjQKm/UbF0hYGMPd1A4c9MAaFhoEIxSg0kohqUAJNcT3ER5O1wdlTP7SGvz5cr
         AlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780110428; x=1780715228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dqjY4u9zUiWcPW2IlZPEJiw+YGemyDZucGA8LuuTFVU=;
        b=KQ3OqQ+dSkrdnUwFwPNbmgwlIVld10HX+Etrl+Z6T0VKa1zJZ2LPvuW4JJtziVdIXm
         McSDBUe+0CJdvqqvDyqWeiuTwgCZXN7Fq5kWXH0ESWLoXYNMa6CcL3ji3RSw+Wesx/XT
         2XkYa1PWkumPBdfPDxwubwE/Q2xxbVqZMQ7DRPF0nL+iLIUQiYweevvUJ8PEeBL5pE1h
         8zgwC1maK08z1qbObrkIoLVGPjMnaRjjsovS1Qefkf/ut0GJc0Uxxg5YeI5caBoiXQZv
         DM/rtPX3PRqjwj+tHwkJH8IoyqjcGV1oHCudXYIqCoEIMtTC5lkiejZ8cj6bjW3/bOes
         /YFA==
X-Forwarded-Encrypted: i=1; AFNElJ+w6AykqRw0LjDEcrXjywQHE3j5z1ggWCgXaa4dx0WLDTuvsoRjTpR7NdWKF9xb5ytAKY4ShfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIfKqiwqX+t409roqblM8g1mASaQhTl8AlTNUX0tcpl94hu1d
	n4jHv+cP02X0Lun1qrhP7TW80BqslfD3tI4Swn/5iH+p2glNQKFIZut7
X-Gm-Gg: Acq92OG8hAnzsGl43kMz6Q0RjxyD4IJSsOEvQdjuQd2fPMTlQoK1ZSTxjMlq/ex7IOa
	sbklXTQMlpOpFMWOluyA1VD/Xufno7I4E2pm7evIADpnWhbfPRLWfgxXh3oPVEjKyVr7C8y6Dd1
	GX73oqowuuCGal4h5CDCnEv+ebayBk9d6xkM8An6bvN9JxR8/2yUH/eX3Wqk4cRNvJQ7N8tOloI
	K6tOcg2eK73o8JXmqJe1KRXRMk/rDZ/c6VR532lWNNkzfQK7+EKIeLoh6QtQUVZvHBAPbC/gnYd
	mq0Yl/TQDGJvye34h5DeZSoKc6GgaIwRw/Q/XUmbe6WS3r4FkR84OZoKaUcW0HG8DoJHViTnCIS
	/0U/R4tCsMN3SQlQQNgV6cOj2sYIPHB8DcGnyv9p6lR63C3jBDmkrVlfOg1al7OPXK4a9wZPVXR
	O7CnK9dDUeyvSsYcH62QXRSGxSwOgrh4kfZ6AxpMQXQeGjcyh+upzeAZj/0FPijSRdUDK7wA==
X-Received: by 2002:a05:6870:1613:b0:43b:722c:d29 with SMTP id 586e51a60fabf-43ca42c5fd2mr1468423fac.25.1780110427609;
        Fri, 29 May 2026 20:07:07 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-43c93abfe02sm2549669fac.5.2026.05.29.20.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 20:07:06 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] ceph: properly decrypt filenames in vmalloc() buffers
Date: Fri, 29 May 2026 20:06:46 -0700
Message-ID: <20260530030646.85589-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530030646.85589-1-CFSworks@gmail.com>
References: <20260530030646.85589-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: 457117f077c67 ("ceph: add helpers for converting names for userland presentation")
Closes: https://lore.kernel.org/ceph-devel/CAH5Ym4ga7miUQE0K-cJA93Ya7w62P69MAN27R5cBiYnudoOHdA@mail.gmail.com/T/
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/crypto.c     | 43 ++++++++++++++++++++++++++++++++++---------
 fs/ceph/mds_client.c |  8 ++++++--
 2 files changed, 40 insertions(+), 11 deletions(-)

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
index aa6730b48e97..8fcf185e3a82 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -538,9 +538,13 @@ static int parse_reply_info_readdir(void **p, void *end,
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
-- 
2.53.0

