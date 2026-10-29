Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270360;
	b=QpSyZ6FVsh0yysePUQT2rZrlMqRNi9WMevf777+MTjwP01Fuz79FXpTHdYn1kwf1BdIP
	 3MjTQ3S0G3NK+WWqadhMwa+pWhwf4ParVUDK4aH8n95/XPuICAXMJmO+N2Nh3WWmkbtfA
	 25IhUhNQY0YJnsa+zSmY5xQWq5sn1IAFC74X8FTeadPc+A9dYKMMO7aKvWwh2ECEbMAwJ
	 FEU8vIrTAy/dFfIkC1bG7w9oslleGsra1WCMZ1PVxSn2hubKmG8Ck4UlhXkIyrnbpvAIK
	 B2kVZekD8p0Y8ebFnWGwS5Iu82/vRLeWBx1UjQ4yWcclXCf0VbwQ5gAJOe77hzHORPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8cu0Twbd3w2gzcJmrd4ZCL+JhFNI2Ni02bPrZLMEiF0=;
	b=pLefaCL8wqM/W2fy29CZJaCW2DfF6tGiTAUqaHAblQhREfKqblv2f4I56PZEDSClCf5+
	 lTf4gMvEzqQPRdmnr1P9psygbR8abRPZOzH4BXcJrFXfKleNIQFprjMyS8Adaalrf0y3i
	 gRw69IYeyDfApJ+E+YchTicAoxnhaNVenD2Bqr4oiZ+tc2X7QgmQ9TIwJVHKvXYzjIjKb
	 GMVO72yVDeHlXXjxgJF0sJcIWBVzMSI+Rzp3XtFQKBWmCZQygiZHAEE4w/Q/YPZKW4dDB
	 /24OQMYMWPFc0AFmkgp+RaKXUwFlmNzaK1jyKUdeI30tUORHW8IAt2q5ypKtXApsgeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kJ3lHANV;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F460A2605
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F19F460A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kJ3lHANV
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso344545366b.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270358; x=1793875158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8cu0Twbd3w2gzcJmrd4ZCL+JhFNI2Ni02bPrZLMEiF0=;
        b=kJ3lHANVAveBa9gqWIMXTMDDH4J+p34Yv9FPML+MzmSufck4xJ68ugS9dMf66QlKYu
         eQ1Kf3ZnNSkmWe9nFVCdAbJDOwmkCKj7K9O7haIWVmQo3ol3BlTmbuNooKShGljryjfm
         E2WEs0tZK0ylUSp72o9NcrKXuH/n/0afZ6yLQYQjL7hNoxImc2lrodWIYcfjzEptJyJm
         5fmot/hSmtHPr7Y97soS8deN2PXEf+Ef/J/EQgF2zDazdw9rJTuqg3HJhcqg4jTQcW6P
         /lou2aQVR+W9U6RFz2I1eQd1VodClxu92VUaVSRF0tSklEPRvE0J9xTRll6hGUqIE/qO
         4xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270358; x=1793875158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8cu0Twbd3w2gzcJmrd4ZCL+JhFNI2Ni02bPrZLMEiF0=;
        b=qq9sWdDYxVsHKWPyvBM/uRzF+q6yAsgcb8eig/TCz2ACuKXV9s5XerkNcncSDF7eC4
         cC61AXcLszx0GS/oNds+SikcQg8D4eJ/JuyQ/Hno9YxjdzZ6Dka5Ns+h/xikqmm2yUbP
         GAgaAIeVuuQJysiHyjCVq+fo/NXfPLPASYX5oiGlu6gqxN9pUTAuz9sG5496sLxB9t5D
         3rBL4FGYWLjc3JqNe48QarTpuDaCo/mvunThyanQShYdM0E7EPMfIGSyDV3nunRadsQT
         kbCYhK6unQQCn7mdqDohxJ/JVUBEDdE6ASpKMds/rw19F1hPTEzP7L9qduFAcvIfB+Dn
         9Gzg==
X-Forwarded-Encrypted: i=1; AKwUvByBZae2qcbw3k7NW2722My1BfTMvPX8cz9k11/78vSQ3LDsK13fYU/ieLHml64bHd6DA5Ps3aA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZUwAqEv+aD9GwxNfLeUq34FBIlobd3vPYFi5AY7r4H74iHp3k
	Z0Gg5Ih5NERQeq7KfbjnJd55z4zCY8uHDt2pivYg4dIB/g9An+6+YMo+
X-Gm-Gg: AYBFou0NQU5l3sjQjs4iwBhO9Ms55yoDsqmeSlI5rls7uY1yz3OiHvNsO6f6+9/CoZ1
	cQiJfChK6C5eGLkYpG4fwCnete63uHgwVNjbIjGY1DzLahp7yaOEzZWUlrhOr+N7CYu5e2SzN8T
	2LmlxEkyyw+myxwZzDQagEG3OHoHezj8CkwI43JUkgXPhw+PZ9WGtRjxu3ddDV7MSEZlq6rAs4L
	kYmGSd+DJzvNpRG7RyiKUMftLp2wBHHW5q7BK+sh5dyoCg/sez3lRqQ9gg2AUrtzd+0bVPCdUuJ
	GWvzg7QEe0CF210jDIZuIC2OlgQR9pMH0RZPBnOqqrE26i4lcT9qWVI9HiAX3qkgJxm9dGRWkjf
	dDsO9a3aqE5a+Yp/ISt4gTDudJDCLS3NEQovqcB8b+0oFvzft2rMlqc8lxqpDlPjCnZZGCcPmB0
	6Ud2ilx2mVpdDTESMpIQmofD0KZmOIyRW5KYba+uyHtAGRkVmzyscNL1TyPHug4eLHFkTtu2Ryb
	edfwkOJ2oyEY6rDgLlow/NsN5+JU65lwLTpEMVlt3KzMHpT2w8Q2cxpD6HTdzsNMoN7lSSbOrFy
	m3gdBICMg71oEijYHjYktpQ/IeJNjn0jre9x737zlwwVyUE5QQIJ+aKfq4kDVm/Fnu3555Z98rY
	JjUh+/2NnG1SLkT6wFi3Ne+tlzqov+ne19Q==
X-Received: by 2002:a17:907:962a:b0:c33:dbe8:291c with SMTP id a640c23a62f3a-c49bdf43b4bmr451277766b.20.1793270358157;
        Thu, 29 Oct 2026 03:39:18 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd34fa1asm719578366b.6.2026.10.29.03.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:17 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Fahad Alharbi <fahad@codepure.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/16] ovl: fortify ovl_copy_xattr() against underlying layer modifications
Date: Thu, 29 Oct 2026 11:39:06 +0100
Message-ID: <20261029103913.2785828-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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

Adapt ovl_getxattr_value() to be used from ovl_copy_xattr(), by
allowing to pass it a pre-allocated buffer, which can be resized
and by handling the ENODATA/EOPNOTSUPP return codes in the caller.

This replaces the retry loop in ovl_copy_xattr() with a single retry
after resizing the buffer. If the value changed again by then, the
underlying layer was modified, so return -EIO instead of retrying.

As a side effect, ovl_copy_up_meta_inode_data() now returns -EIO instead
of -ERANGE in this case of underlying xattr size changes.

Reported-by: Fahad Alharbi <fahad@codepure.com>
Tested-by: Fahad Alharbi <fahad@codepure.com>
Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/linux-fsdevel/CAJfpegsVoUyqy0dYkTvBGRZvgdv_nmzmCw_uF+LP-Vq3EhEkSg@mail.gmail.com/
Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 68 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index c220cb5d0b70c..eee22581b14f1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -72,6 +72,9 @@ static int ovl_copy_acl(struct ovl_fs *ofs, const struct path *path,
 	return err;
 }
 
+static ssize_t ovl_getxattr_value(const struct path *path, char *name,
+				  char **value, ssize_t *value_size);
+
 int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
@@ -129,34 +132,12 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 			break;
 		}
 
-retry:
-		size = ovl_do_getxattr(oldpath, name, value, value_size);
-		if (size == -ERANGE) {
-			size = ovl_do_getxattr(oldpath, name, NULL, 0);
-			/* Nothing was read into value, so it must not be used */
-			if (size >= 0 && size <= value_size)
-				size = -EIO;
-		}
-
+		size = ovl_getxattr_value(oldpath, name, &value, &value_size);
 		if (size < 0) {
 			error = size;
 			break;
 		}
 
-		if (size > value_size) {
-			void *new;
-
-			new = kvmalloc(size, GFP_KERNEL);
-			if (!new) {
-				error = -ENOMEM;
-				break;
-			}
-			kvfree(value);
-			value = new;
-			value_size = size;
-			goto retry;
-		}
-
 		error = ovl_do_setxattr(OVL_FS(sb), new, name, value, size, 0);
 		if (error) {
 			if (error != -EOPNOTSUPP || ovl_must_copy_xattr(name))
@@ -1059,26 +1040,39 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 	return true;
 }
 
-static ssize_t ovl_getxattr_value(const struct path *path, char *name, char **value)
+static ssize_t ovl_getxattr_value(const struct path *path, char *name,
+				  char **value, ssize_t *value_size)
 {
 	ssize_t res;
 	char *buf;
 
-	res = ovl_do_getxattr(path, name, NULL, 0);
-	if (res == -ENODATA || res == -EOPNOTSUPP)
-		res = 0;
+	res = ovl_do_getxattr(path, name, *value, *value_size);
+	if (res == -ERANGE) {
+		res = ovl_do_getxattr(path, name, NULL, 0);
+		/* Xattr changed underneath us? */
+		if (res >= 0 && res <= *value_size)
+			return -EIO;
+	}
 
-	if (res > 0) {
-		buf = kzalloc(res, GFP_KERNEL);
+	if (res > *value_size) {
+		buf = kvmalloc(res, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 
 		res = ovl_do_getxattr(path, name, buf, res);
-		if (res < 0)
-			kfree(buf);
-		else
-			*value = buf;
+		if (res < 0) {
+			kvfree(buf);
+			/* Xattr changed underneath us? */
+			if (res == -ERANGE)
+				return -EIO;
+			return res;
+		}
+
+		kvfree(*value);
+		*value = buf;
+		*value_size = res;
 	}
+
 	return res;
 }
 
@@ -1089,7 +1083,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	struct path upperpath;
 	int err;
 	char *capability = NULL;
-	ssize_t cap_size;
+	ssize_t cap_size = 0;
 
 	ovl_path_upper(c->dentry, &upperpath);
 	if (WARN_ON(upperpath.dentry == NULL))
@@ -1097,7 +1091,9 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 
 	if (c->stat.size) {
 		err = cap_size = ovl_getxattr_value(&upperpath, XATTR_NAME_CAPS,
-						    &capability);
+						    &capability, &cap_size);
+		if (cap_size == -ENODATA || cap_size == -EOPNOTSUPP)
+			cap_size = 0;
 		if (cap_size < 0)
 			goto out;
 	}
@@ -1127,7 +1123,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	ovl_clear_flag(OVL_VERIFIED_DIGEST, d_inode(c->dentry));
 	ovl_set_upperdata(d_inode(c->dentry));
 out_free:
-	kfree(capability);
+	kvfree(capability);
 out:
 	return err;
 }
-- 
2.55.0

