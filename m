Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938299;
	b=Gqc4y7EYhB0EeiQ85OkAnYw2tS8/dtIIBVVDkBKPImuVN44m1Lswr+8xYuTyvnpjFki4
	 BEKl+bFrC0qCnb7j7OzNe8xjDmJ2aRzdhsfl0g99jnheHLAfFG2j8qu60FhCsceD5u3Fi
	 qefNQh0X6VvRO/ahARcy/HgvHwDh2BbKL7ONuDITucH4IST5fiekYmE0BeClDaHlw/WyU
	 Qr6LZMNYxnxH2oj+uJYMNuIuvdcG0t9uGteA5kP3xZKp+yvIEtXaxjTTvdzWy3T27eTDn
	 tqnmmvx04MhQSCRC2psiAF2wpVMgxED2/zwmWFCXCV9IbWZ7yiA/Pthd2rGT2ARcdCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yw3Hukdm9hjkYi3v+QZBT936SHqKGZI3cszKFBhuw/o=;
	b=Du8eeD9Br85Ph+glnkqSyFlu5J9aeOtUsWbgcQtJ+ldM8pyyWh5+Sfurt6pNgJsI0hsn
	 DQD3sYugIhf2xPno7QrEqLdI+SuInuP5cH7HDV5wSY3gpi7ayGNkpXFmaY+CLEQTMI7Oh
	 9MjWZHrpemoLzzgtye91VGHDXMVHg2dXXtbVu2xqxgOTirSLOTwmF3KoCj+n0nmo4CqUN
	 UUKK4RFHxCAHHqUw6JDxJXP/Nkxd86x+VNLjDRbxs3Cqhp89Ltzx2gBeSrHkyf29sHQmI
	 4eFvnSiilSOXdjGhpEoJs4bIhbsUbEuEDffxg6Eg4Btj98fh5QPJBRB3LC1GbV0W/WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljxHZEbB;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0915606A330
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0915606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljxHZEbB
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b4f7d3cd98so209802a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938297; x=1794543097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yw3Hukdm9hjkYi3v+QZBT936SHqKGZI3cszKFBhuw/o=;
        b=ljxHZEbB5osOm2+Iafsv165D7BwMXlp7taAlA72CLAeACG8r/UlqUc5pbBT0uvXgFb
         ddMPAaL4QJLo1YXxVhSh7vq3GYZCmSXZD7aGiDPKqHMW1tO1RU4TDzeTxXBU0qm9ZKQM
         shfDVWjXD57qYluwqL4TkMgj5dSnVuodPJX0yesOkv6TszwKKJAavJJ1gcJnWKXXD86B
         aiCoSahWSjxroOSDvoDc3i0lYfJMwNq3AqOJoiRv80Cdxh257GGGVWwimgYMwz0qf9Gt
         YwvfPqbbhr+cKiKPDeve0mqULxKA/lJUNdYSpI7g4bTTearpdkLhDrdAqNr1QulDgGfc
         ERGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938297; x=1794543097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yw3Hukdm9hjkYi3v+QZBT936SHqKGZI3cszKFBhuw/o=;
        b=QA/8pT6ZFtI45opDAtev8GlEQ3VZHkudCR68GqcKYF0m2/jV3Z3sTlm3o6EE3Nm2ub
         FD74enXN8KbT84nVGU37/yhlGd9Jvfr0K6yCxXgU1rG/I/TLvSxCU0O6HMnGxj+KtXgk
         +vAlnWkLd0rSGig954ArAD9Mv8XjqOTw2x8A/LdzqPIOUZFd6yPBeOoHTeUhl/vE3o4P
         unUEp1JpFoDjct4geGzvJzck37JMkEdKfsdZAwyDx8jsS8+Jpj+P3g5xJ6/ZgMdwQH3w
         H5YAx2hQNj/NqwBMTJDGOl4KK+USHOtcHOvX3AGrKAA8KUhdXedXaw9WjhXWmvhdfrmj
         Aj3g==
X-Forwarded-Encrypted: i=1; AKwUvBwXMeuT13LloDCUPXE4akzn+4bkjMRUSSkGIHwlb1oaYjtVLCqc3nngR7kSX8/O/LHP03+qZNg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0YvZ/zQ78QYEQ+I9EogOXTBHngY8cVbiJA3a9m43QqltVrsTz
	1Npfoha1SCCJMtGWR6FkacQb+EYUovQvR4qmQbF6ARW4Wb3PWeBhUaZpNxjcjXZs
X-Gm-Gg: AYBFou3HhkDP5jrZ2ScalQgyNFhaYjjX+BuvXIUShvGckAjTsWOecLT7qJMpwlNo8Rr
	8PsWht5ih1mcGtwcXdpVzeCMZDt2onpInH0CAP4uVDv8tP1uiXHl1mMvDMEiZ5eIpAL4LyaBES6
	+atu3vdCSickFNoTpOwSb5yLmCIUc3N3ep7Zez/H81/DYyhcQFjx02+xAj7ZBzSwQWieEAKxxIj
	+M8KcbPgmIeHbUd0lDx+8FH1sKeXiXgwnQe+1ivwbuviGfYIYqQY7jZk3RqLO75MYvChv3dc28u
	mIHBZWLgF5HXlOJ6j0ypnlhgx3XL53rB75Zr4eXOGGrRkSC2Ny7nplL+soefukpNI5Iv+dR71QX
	lyHMIwI5loWSTt5eh7diPH4XEvlBI0xvIEPMeHabsRv4ZSxZk1Jy8h1XnHCOjkTi45Biaq3Wcjd
	yh/Pd9z84Bdo8sAsk5tuyDFCYYd3nQ7hnT+Cn5HLfanED17NkpWbVeqiz1Filwrjz5gVc1dCv1B
	zXZXvQctYU2Gv1FXaPjeD1ANNsxk4meJWcNPduZ3wUd917qpJTovGdJFlh8Sv1t2IlBlDecZhCD
	fa1vrBvbMl6+OVc8l/YUzusqS21yznutWLfFFc6OArwzA5yGhkc5lboaNsMII1ODOQdZA2xouYy
	YJyJkug3d30yV
X-Received: by 2002:a05:6402:210c:b0:6ac:9a44:d3ed with SMTP id 4fb4d7f45d1cf-6b5975249c5mr890967a12.5.1793938297099;
        Thu, 05 Nov 2026 20:11:37 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b65d6b3847sm236655a12.1.2026.11.05.20.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:11:36 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.6 1/3] ovl: check that the parents of volatile/dirty are dirs
Date: Fri,  6 Nov 2026 05:11:26 +0100
Message-ID: <20261106041128.3797453-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106041128.3797453-1-amir73il@gmail.com>
References: <20261106041128.3797453-1-amir73il@gmail.com>
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

commit e34d2ef818e4c7676d8d8e1bf43e6a1ed39efb2a upstream.

An unprivileged user crashes the kernel by mounting overlayfs with the
volatile option.

A dentry that serves as the parent of a lookup must be a directory.
ovl_create_volatile_dirty() walks work/incompat/volatile/dirty by name,
and ovl_lookup_or_create() returns an existing entry whatever its type.
A file or a symlink that another task creates during the mount becomes
the parent of the next lookup, which calls a NULL ->lookup.

An unprivileged user mounted overlayfs with "volatile" in a user
namespace while a second process created a symlink named work/incompat,
and the mount task oopsed on a NULL ->lookup call.

Fix this by returning -ENOTDIR from ovl_lookup_or_create() when the
caller asked for a directory and the existing entry is a non-dir.

Fixes: c86243b090bc ("ovl: provide a mount option "volatile"")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[backport: no ovl_start_creating_upper(), check the child of
 ovl_lookup_upper() in ovl_lookup_or_create() instead]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -658,18 +658,25 @@
 	return err;
 }
 
 static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 					   struct dentry *parent,
-					   const char *name, umode_t mode)
+					   const char *name, bool is_dir)
 {
 	size_t len = strlen(name);
 	struct dentry *child;
 
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
 	child = ovl_lookup_upper(ofs, name, parent, len);
-	if (!IS_ERR(child) && !child->d_inode)
-		child = ovl_create_real(ofs, parent->d_inode, child,
-					OVL_CATTR(mode));
+	if (!IS_ERR(child)) {
+		if (!child->d_inode) {
+			child = ovl_create_real(ofs, parent->d_inode, child,
+						OVL_CATTR(is_dir ? S_IFDIR :
+								   S_IFREG));
+		} else if (is_dir && !d_can_lookup(child)) {
+			dput(child);
+			child = ERR_PTR(-ENOTDIR);
+		}
+	}
 	inode_unlock(parent->d_inode);
 	dput(parent);
 
@@ -690,7 +697,7 @@
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
backport

