Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795586344;
	b=uqlYTK5twHVzIJRf/NT9/geyw6/yNhR6cfQrt4/iF8rFRi5UJ+CPajw1g0uyW5+hnHzR
	 gLdavGCHgw4uGC9eDYNt6epicBjBPdS+udlw9gxcaSn4rF/8J5R6pvcM7hnUG2D8wwcLE
	 pstJmXlnpSV40cHbuvYDpucf2ZVBW0VT//S0/O0pgmeqL8Gd+uXW8LTPtSSNRjzzfY9Vg
	 f5DsMfjZj48abhGa6hCqSMan3+c9Gbqhl15FsQlwq+DUGQe1VVwSB/W45KU31DUKKo7/q
	 n05RkyWpOL98nHgaMjLBQcI/QC3CcIMxBaqyLPZ+0waWT3x7XBcLD9aR3FVMj623R7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kLO4bvaNtN2k734CUnroIhM2LaGQVLf7dwNtjbQDkFI=;
	b=C/xvCuENPZ4wq1pbh+qGn5ZdVt6MHmPaVJLkwu1r4yk4vMq4eriiZEvOSXt+gfpw3UpA
	 w5rYFHyJieZITLpgaACuH4B6wNW4X7T93Y0zlGJDm34WvGwX2xTgNMn/6RLRbQPS+q+SE
	 zsChgqGGMHCPD02aPQP1z6CklV6XXWzCpAq6kgAhJKhzW8fcAMXt/dNVaq0rcvvKDFXi7
	 9x+tSBb5cFohFAVh9YTBImP2Ugs6uBnqwxLOOZ2x1WmIiOP3LteiHm06DLxJItWPrZ4Vf
	 wAo7yBfUhRamILvAgO9LLyB3WPOV08udoj3DRfNk3BychKL8f0VF4RwHH7WB4YT0/YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KNFf/AWj";
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B629606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B629606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNFf/AWj
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c51373ae637so11243266b.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795586342; x=1796191142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLO4bvaNtN2k734CUnroIhM2LaGQVLf7dwNtjbQDkFI=;
        b=KNFf/AWjp7WY6ZuWUqCXKj371sD9eX7Tq701WLajCU+17vXhs0tsQTj9QpMEh9CBZd
         LeMT5ydltu7YVOz4lRQch9ajDJT03i9RWQRyWAPqp/BHigbAO2oPLIac5GHZ78OUpUCW
         RAbzSsrcz7s8AUjqfIwW0BBo38FRzkHV2ceL/TfDrn7AlWFwb93dL100/48lPYwkv3qo
         eSN9Cc63VX851v6BHYHUb5T+OaIDy7+BdlWdHC7O13S7R1qd8KA4J6xDrKoSBQ4XZTao
         rPLi1oTRi1hpyuV8yc7luJZS0f8omHZ5LRs3cG3In0K7bxBHU3EaB20PlFy8j1M1g3YK
         LH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795586342; x=1796191142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLO4bvaNtN2k734CUnroIhM2LaGQVLf7dwNtjbQDkFI=;
        b=K+BTpEJGer9DFOEMhr0Juq/H3GABvOYX3NlEonYbszhqaRsEII5rYQivf8bFJBa2eF
         ed8g9lb2A8GpIeZeuQRR3xFkTJMXWaE3h0J/vPz0iONPE3tigHRDgZsruAr61SDlX8an
         smLKx+B2JfICS77kj9seWY3io8pLHZ9RHuv6HiFlOk2c+jl6FFrYq62eLVUsel3QrfSu
         g/HaEa9P3CsT9ZwK80wJ6qKmh7/hCFnTz30M1UKYrEwEJxhaleuzDEMHloqYBLTjGjof
         VMr8eu27FOstZ61RXY3qM+nusv3edtbplVkdnvGm41/yO3OB58IqMdP4Je0U6aWUemRb
         mJSA==
X-Forwarded-Encrypted: i=1; AL+hErFCTIQ0ZNOA2toXdxsp1k0NduSLi+nzNnykyo1DVfKxatUeNIhnNFwn6HKO/tPKvKnf6G6HmmU=@vger.kernel.org
X-Gm-Message-State: APuU4Z99HCqGhAp9G14pdCkZhJluA8yDktyzKydld04PZgN8+8QfCmwW
	cDuyeM7rk70VA7oQpshWPbhqsPY4lt3sDcio0rQPAuzcG7Y9CMfr5VLj
X-Gm-Gg: AZFdTZdU90PWHsVhymWGQUwR3Wt6/CkLJu/oXNjiiOiXPwpWIpvBvZrHIcunObXpq7y
	CUaMeBTxGgWuGP1zP1NJdpIkcaXWJiJApsl3XTuDtQ1nUZ/uXfWJRWha/Y+6Xgg/+MWW/rCUTLG
	50lIXECDe7KefdwivAuMrDbkEVwNlwsA9jQrvFDvwUyZyb2RYrQxiS0F5/MAOs8kmR0c02A93FL
	GKB1FS/8M2wGkeH2kSmYrPw82qVwavwQA1CI0S+XWzyaD46NXFEN65dKLwfEhUUKz/VieJ1tjpg
	1zCvZekBHqX2yk5QO0QMEKYENJ5+jtT8GDFI1iipDdTQwa4eDxeYazFXwpwU41ZmQSm7CMnX9lC
	Kj0R5Bb8vGFIyHATHjWiPFyAJP7Bx4e6Z6ZCQJDzn66Wz2pWV5wvW8tS13mggEXknh/EfN/aQ3b
	cqHdxXxHxxfkpoNfibGWd3UW1sksNJ8Wse27/UMq8+a/yUiwkwX6a3rcoQTr3DQ0yEutx2NwUca
	UdUq7J9SGDahS8WMSPOAS7kfHHJwQADdrFh1GHK/Z+Yem9M9XarRCzflXRUJHXIYaiI59nTLUjk
	NUWY1RI96QA/hBX9BHDwXt1DkodQxvMGfRgUNWQvijiN32Ik9DhiFK1v+T3/J0/qvpsRSETFAPX
	wE7GWpay8h06R
X-Received: by 2002:a17:906:1c11:b0:c50:8d2b:4392 with SMTP id a640c23a62f3a-c513ab38967mr1036690966b.49.1795586341572;
        Tue, 24 Nov 2026 21:59:01 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e355easm7533212a12.3.2026.11.24.21.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:59:01 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>
Subject: [PATCH v3] xattr: enforce the name and size limits for in-kernel callers
Date: Wed, 25 Nov 2026 06:59:00 +0100
Message-ID: <20261125055900.2077059-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123165807.1939942-1-amir73il@gmail.com>
References: <20261123165807.1939942-1-amir73il@gmail.com>
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

The xattr system calls refuse an empty name, a name longer than
XATTR_NAME_MAX and a value larger than XATTR_SIZE_MAX, but the VFS
helpers do not. An in-kernel caller may pass a name or a size that it
got from another filesystem, such as overlayfs copy up from a lower
layer.

Check these limits before calling the xattr handler of the filesystem,
and fail with the errors that the system calls return for them.

Cc: stable@vger.kernel.org
Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v2:
- Rename the helper to xattr_check_name_len() (Carlos)
- Also refuse an empty name (Carlos)
- Add Reviewed-by tags

Changes since v1:
- Check the name in vfs_getxattr_alloc() too (Alex)

v2: https://lore.kernel.org/r/20261123165807.1939942-1-amir73il@gmail.com/
v1: https://lore.kernel.org/r/20261123113513.1910906-1-amir73il@gmail.com/

 fs/xattr.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 0705801a62cc5..64df10ed498c3 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -178,6 +178,21 @@ xattr_permission(const struct mnt_idmap *idmap, struct inode *inode,
 	return inode_permission(idmap, inode, mask);
 }
 
+/*
+ * The xattr system calls refuse an empty name, a name above XATTR_NAME_MAX
+ * and a value above XATTR_SIZE_MAX, but an in-kernel caller may pass a name or
+ * a size that it got from another filesystem, such as the lower layer of
+ * overlayfs.
+ */
+static int xattr_check_name_len(const char *name)
+{
+	size_t len = strnlen(name, XATTR_NAME_MAX + 1);
+
+	if (!len || len > XATTR_NAME_MAX)
+		return -ERANGE;
+	return 0;
+}
+
 /*
  * Look for any handler that deals with the specified namespace.
  */
@@ -209,10 +224,17 @@ __vfs_setxattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 	       size_t size, int flags)
 {
 	const struct xattr_handler *handler;
+	int error;
 
 	if (is_posix_acl_xattr(name))
 		return -EOPNOTSUPP;
 
+	error = xattr_check_name_len(name);
+	if (error)
+		return error;
+	if (size > XATTR_SIZE_MAX)
+		return -E2BIG;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -408,6 +430,10 @@ vfs_getxattr_alloc(const struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		return error;
 
+	error = xattr_check_name_len(name);
+	if (error)
+		return error;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -416,6 +442,8 @@ vfs_getxattr_alloc(const struct mnt_idmap *idmap, struct dentry *dentry,
 	error = handler->get(handler, dentry, inode, name, NULL, 0);
 	if (error < 0)
 		return error;
+	if (error > XATTR_SIZE_MAX)
+		return -E2BIG;
 
 	if (!value || (error > xattr_size)) {
 		value = krealloc(*xattr_value, error + 1, flags);
@@ -434,16 +462,24 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 	       void *value, size_t size)
 {
 	const struct xattr_handler *handler;
+	ssize_t ret;
 
 	if (is_posix_acl_xattr(name))
 		return -EOPNOTSUPP;
 
+	ret = xattr_check_name_len(name);
+	if (ret)
+		return ret;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
 	if (!handler->get)
 		return -EOPNOTSUPP;
-	return handler->get(handler, dentry, inode, name, value, size);
+	ret = handler->get(handler, dentry, inode, name, value, size);
+	if (ret > XATTR_SIZE_MAX)
+		return -E2BIG;
+	return ret;
 }
 EXPORT_SYMBOL(__vfs_getxattr);
 
-- 
2.56.1

