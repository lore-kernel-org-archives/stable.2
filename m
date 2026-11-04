Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818440;
	b=mnd3jaDMoQdaCk+uUUXQzORRAHPkBjoUmxXkTeMPIhqh69/6t8ua6gYTWLxSlZO/Qw07
	 nDiV2KOQEXU/AA27wqw8YTRnMZ5usUY7Yl4qoP79NIvCf/Wv1ZmZzAZ33Cf0p3Dg49mZ/
	 kFxh62H3pj/793c1SVwsJHiySnIlzc+MWvNV0dkogz78dXG4Yn8+YsTAuj3PRHHN3dMtd
	 I8CoxRx8Q6jhki8O7bmDtqY49Wiftqp6ShbLmrb606pkg0VokR0jIYtxAnb8V3I2SIE+A
	 fVrjXkc+TmlkMk4WO+E13lBd6RUmfukzTNPJQOQg6Reovx7msG47Xy4uAQjXkI2/Ecg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G5wbYNiPhAHIb+26anH3v3vEHstJg4FjlaenE/QZAko=;
	b=5ANzoERE1KIE9vyH+YPLqVW28dcS2hEzVFa1+0+ZoUKG9SQEB4KqowI1hgBqZU+qZLvl
	 JgMHn146+l7kbJbh7PC/K1/QJi+/M3UkqmBOcXvwK7Pi4k9gevKra20glTw1dYfy/EXEa
	 6ZRZ0W6eVBMekvXk52xG+cj92Hc0xwZkUH6quOCNmmrUScV5hwo+6RXvzr247KlWtkYTp
	 uVuB8qjSpWg5XUJQAhF33LP7v75ZVx+/a+hOvuss6JOndESCwJV+YXwsgF4jHOXhur4x7
	 EaXtmJqERyTLZJW6S1xJkhA+0kxTrPfXZJIazRcrJOG6OMJPe2IMhUHZr7VnxsYsulg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4gDAWve;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF5606EE9F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAF5606EE9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4gDAWve
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48bbb06e746so696145f8f.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818438; x=1794423238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G5wbYNiPhAHIb+26anH3v3vEHstJg4FjlaenE/QZAko=;
        b=w4gDAWveJlfcdoihCDwXx9RBMOCcH2h36Pa3eLdnrl6Lr7QVTrk2MGx7+S3FCayk70
         7WjWbLHkvBIBmS3ANQEjxQ2lu1mdA9B2+n0F4vfWLs6YZOazhKD/MPiQ4MUNEOD9kKjx
         I/yYl6a8IBCaUqWOQihMxMlJj1mIUnyKMBuG5FrT02+OY5eULftm7IRmrfPUxNpOQh8+
         QCfy1WorYWqAWla7SuKWP03Yl4waWffqS74izShxCKyJ7RLumPEMa74/CcIGYwpkdAJ6
         vy1jLgELsrW6LDIHjuYqyLS1nPRXPGoOZz4yXDFq7GtzTPjVvxybRA9i8qKf8IIQiKDa
         Yy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818438; x=1794423238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5wbYNiPhAHIb+26anH3v3vEHstJg4FjlaenE/QZAko=;
        b=Lx+P0NgBSzYqRMNpX7SonHaeCrLyKqyBziKCgqCzC4gsGjbeRd5PvndSFop357GFcL
         9oOgNU6vLwprwYmKrkuACCH24W+HeuNM1J/EB7pjVw5HuSdgVBdrhdwoz4hWkZYCjLXw
         iIj0Bc893dUYW2oUAODDv5/pY9Bp8CEOucC1/uBghqPlF+sMr0295nEYqYJ24WgmWV6I
         +PL8Ym2rxCej+VbzV1llfL/Ik4gvABSpVpTz9TPwfntEQigiiPRpL4FUa0i17SsM+bxc
         xGZvazrUuKavfurGetbI6KBY7inkBY41PttI1ir6meDYChrS3bMDLfWoqFmnGTAK0jA/
         Ysqw==
X-Forwarded-Encrypted: i=1; AKwUvBxT++5neGZCLfUKyY/W1mkZoskTR7HYU8IyrAQok5CQEcdt4P+QQlSZncXDtiyl8aO8ufYhCsw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IuW/l63lv9BcWHbJLCFZF7GFnFcbjVhNNBaVJ5FAru+fp0WT3
	vNylLI5dKgaY8RVjnI/yaV9P9FHGe7MBMWhYdYk8XZg1t1zmBsbY/yKg
X-Gm-Gg: AYBFou0EnvNvXM0Gv8+X8KR0uQ9nGtSom7+9T0r1u8sYcV4XrLCcNNirdiCxYN6oy6B
	2aS7AylVvYwignJv9lxYJL/bfRqsy4CiihxSaeecixfQSczK3YSsYcpZ9i/WB/idy7eujaOzvso
	YKzWypTae3QSsXAlYnz4vWoSbRMjW/aRIywDPT9bn+fU1DUUDL9SJ943ZwS9vYCASyVLB8VybuA
	CTOR1iTSsjVudkXPugbUZtLkiZDuz9l5QMY4LQVZM/sPD5q38SbX5oeFCN8HYh6VdPJbGzJEETh
	I6CklmnHD+VaY/L4lkEqKZOC7VddoqcPFHFvlP3D5GP7CexDayDW0Pk+H+L8wCivrTQtvFvzYqS
	OKInaIq7E+alB9orKsNy+YRAmcqpv7FFStygevyCTHd0a3ye8WRUwqJhgTFzUbJA2W+XsDuWUa0
	yoPypkksBZFYjY8wgHjJ6tA/n9nM2ajF2jfsb1rtDXc+JKAcGzjUQu11M98YbKhzzU7bC6mx/5l
	NGEr90bjvan2x3m6N47lQuFdSjRlTNrTvX+8ZF8GCE9kEjIxVKHl5IfdjsR2mbWyFrJjldTYFDN
	55ydwoycmL8pv6X8NdkLH9icVZgSVgJXALc0AWPa1FBlrmaJlm91NuPCVAr8fv3UUTh99uoLiOh
	MJOvccq8I5sI=
X-Received: by 2002:a05:600c:8b04:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4ac17a3683bmr388138315e9.18.1793818437576;
        Wed, 04 Nov 2026 10:53:57 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57317cb8esm3727555e9.13.2026.11.04.10.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:53:57 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Fahad Alharbi <fahad@codepure.com>
Subject: [PATCH 6.1 1/3] ovl: fortify ovl_copy_xattr() against underlying layer modifications
Date: Wed,  4 Nov 2026 19:53:55 +0100
Message-ID: <20261104185356.3631002-1-amir73il@gmail.com>
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

commit e6b9117076fb4c0ff4a670efa9c876d9a50d79ab upstream.

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
[ backport: context: ovl_must_copy_xattr() instead of ovl_copy_acl(), no
  blank line before the retry: label and no OVL_VERIFIED_DIGEST;
  depends on 755b5c5c9277 ("ovl: do not copy up an xattr value that was
  never read") ]

 fs/overlayfs/copy_up.c | 68 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -44,6 +44,9 @@ static bool ovl_must_copy_xattr(const char *name)
 	       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN);
 }
 
+static ssize_t ovl_getxattr_value(const struct path *path, char *name,
+				  char **value, ssize_t *value_size);
+
 int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
@@ -93,34 +96,12 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 			error = 0;
 			continue; /* Discard */
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
@@ -896,26 +877,39 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
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
 
@@ -926,7 +920,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	struct path upperpath;
 	int err;
 	char *capability = NULL;
-	ssize_t cap_size;
+	ssize_t cap_size = 0;
 
 	ovl_path_upper(c->dentry, &upperpath);
 	if (WARN_ON(upperpath.dentry == NULL))
@@ -934,7 +928,9 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 
 	if (c->stat.size) {
 		err = cap_size = ovl_getxattr_value(&upperpath, XATTR_NAME_CAPS,
-						    &capability);
+						    &capability, &cap_size);
+		if (cap_size == -ENODATA || cap_size == -EOPNOTSUPP)
+			cap_size = 0;
 		if (cap_size < 0)
 			goto out;
 	}
@@ -961,7 +957,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 
 	ovl_set_upperdata(d_inode(c->dentry));
 out_free:
-	kfree(capability);
+	kvfree(capability);
 out:
 	return err;
 }
-- 
backport
