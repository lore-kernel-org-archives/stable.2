Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433716;
	b=eYnqkS/ULHFEPW3W3eZ7YSDgWTKs6hsGkstewLqWj7MVZQtUS8DuGGdeKp6/p7oFKmhX
	 LpTm941Y0+4bc8SHLhCbdQ3hA+EJ1YUwQ/1O+D3yaLOQbQng/9IjjmO6sPI1D/GJW9ZWT
	 ixM7RENWM5cJYcFtxjYeZdIFkq7bhPg+22bfhteNkdlj+L//jTLwgnNc9GMi61Gbr5Nju
	 PDYiMEaOXErQ1abZ5zXPaQrFxsI+uIIGZbD6ES7rnxYXjNf1W2dGmTkUjvs+p7B8VjiEE
	 HGlQofrdMyLL1pWzEdjQi4gwrRG2iiy7rIsy8uuFSH33eBzRp+eIZRAl4aY/Z/3PR8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cBQ1e4v+PxM0RWCwPsTi8odmO3BvILm6dYR2hRcjN1o=;
	b=hXGLr3dMOsbcZbEt4kOCmw2oJQ48Ko80PbxrRqMS4ZrN6odPAtDnFsChtBohgoH3R9le
	 9Br3Uct7huKhe78YDrDNauGMB6j3x8GjIKAVb1l2saGrPIm0ROd1nk4RPDC4EphxISndo
	 iJpE4Fm6gwL560R6BYW8vQXMO3Pi4KA8IaS1g/8WaMXIvAMt218YKS4zqp4eRYhAdAykL
	 0oa3c+LzY65gEISaV8by+tqwa2wo4efkjKwb8sSdolgDpiRvrUqaFeI+8KnQo78ib8mCO
	 0nHvxt+3AQndCzP1SwJgGjo9g+Ae5rHHT9Vnbb8hDSg7n8+5Gbwhyp6aPR2i37NzdRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tlX8c84n;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF6606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86CF6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tlX8c84n
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a358881793so1572759f8f.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795433715; x=1796038515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cBQ1e4v+PxM0RWCwPsTi8odmO3BvILm6dYR2hRcjN1o=;
        b=tlX8c84nAAvWBtxLZslesIZP8QnJSlIEXVMsN/6WU78Pn/PCxEWXlxkk6j4u8zG1sG
         mubpmD8uz0RqnccYWFmuFLBRCp6hqFxo9AfSy2JIYtwY+MOIPYQgfcUaGHvZ8l8jp/D+
         2BbbZ7tGO+JTMgPMrn3cmK10/zIPlgLif3F//PjAVDkT5lCgLxoD/9JSBWA68nyO1fVD
         BmpB3MTNXcg/hfiPNV0h1ohtqI+8MN5O7YGs86vY6LLe0HiJ2D+yW/yvXUWjhyhlVJCu
         KgxicZilAeoqkoNweY433ldnWODRRVrKi1+EEg65g266CNP01fondNYYi7/IXM1utDsd
         P8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795433715; x=1796038515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBQ1e4v+PxM0RWCwPsTi8odmO3BvILm6dYR2hRcjN1o=;
        b=dKyJ63KnxDQ/hYQrgN5Ma5Wzh5NnrzxxBsySGiVhARUq2DEKYDRQEjsdfYawmT9sGT
         UQyQrOPWtzVLaBdT6RpFEc50ugFvsLu7RTLCCdANixE08JtbK4DWGG2PJMNBx9Lpj49W
         CBs8nQzl/IvNCsh3JEffTXdOPpuh4Jb60CCfkgjOCkMg7PHs2QLBPiQfEDUlt2XXqmrL
         6ManK8yVIx/Nb/nSmZEX0WIBs5+UwOpOfaohnnAyod8sKHJarrGS7Rel5CTFeTtPs47l
         /+/z1Ya5gZvRT2ih+jGvhk7hZ1mDyAloWHtXxhIhNPa/QC6L5hD6RQd8UlVOWhqPI5Kd
         iwhw==
X-Forwarded-Encrypted: i=1; AL+hErGY8BzRwVPnC1GSbIWt0vxY8CS7INlUWASJKu+6f5IfVYSJKsCZsTVj0wTgl8ZPIkYOzS9mv10=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5LkhKTygmzI26EwNAUP1ygePdkb+GpMZkckikBc2CaROpj2/9
	y7v5/5lwRz7qFiqrDJ20xdtp4dIx+ZdbbATyLCKRHeNuKuFGLu3Lb1dT
X-Gm-Gg: AZFdTZe9Fq4Fd1UXi+5yzgymmtaNNWCx+CD2OkAM7tWH0rW8HqniMNmbyTsIciHIZRd
	vgZxdQPX9TALn6dw8UfzJJJBDz3TYLWAe3HVyyJDa3PClrZvVHYRNut9ojO49AVKKXeKM0bTmbp
	O1w5YAD+pE9GWT82VsMNz5Kd176p9Vzwk9c+ijJbAXVkAg+WEppx8VGDG/PJylbhjUnIjwCvzLG
	RmmEJtXw2dbgSkKx6vLvvqq1y4yAB/n78IT/4AmoTwdkIA3LC/V/1ZmaaE2BTGheqaFIaWYFLvC
	vlmNTf1u04sGtZoX4uCRlz3CudWSi+MqEVyeLHXva2BemZUo4sbHQZA0zd+jzLDDtXtmTkbDDRy
	5TxOlAhgQ7sEQbFiamNJWiqxlm4uTlFwxPLtP0Cfa8RZpPHqggMNkuAVHPtxpcttBxddcZ7ARAw
	nZX/ybeE8ziQnm+4ERDKkbndFbceug+o9yWgyYasbwzUw7cw5qdsa+BqrGUkyU9kJkEZaaQu2CM
	bQsQD+7xDBt6jUfxiXREF9JxgEQFyovxsu81YSwdgsSJlUKEk0pSh2QAFitif/kR2nfDjdGERdb
	7kxCRlcbsHdxhOYwK2eBtEswW991X+T+5HqvdJKyzeo7YpEf0hIigforgto0H+2uV/onToerlDa
	RExB9VaUO3C+j
X-Received: by 2002:a05:600c:674b:b0:4bb:6847:791f with SMTP id 5b1f17b1804b1-4bb8880f267mr223533805e9.7.1795433714601;
        Mon, 23 Nov 2026 03:35:14 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067a0e6sm135211175e9.4.2026.11.23.03.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:35:14 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] xattr: enforce the name and size limits for in-kernel callers
Date: Mon, 23 Nov 2026 12:35:12 +0100
Message-ID: <20261123113513.1910906-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The xattr system calls refuse a name longer than XATTR_NAME_MAX and a
value larger than XATTR_SIZE_MAX, but the VFS helpers do not. An
in-kernel caller may pass a name or a size that it got from another
filesystem, such as overlayfs copy up from a lower layer.

Check both limits before calling the xattr handler of the filesystem,
and fail with the errors that the system calls return for them.

Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/xattr.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 0705801a62cc5..824e8349e8c10 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -178,6 +178,18 @@ xattr_permission(const struct mnt_idmap *idmap, struct inode *inode,
 	return inode_permission(idmap, inode, mask);
 }
 
+/*
+ * The xattr system calls refuse a name above XATTR_NAME_MAX and a value above
+ * XATTR_SIZE_MAX, but an in-kernel caller may pass a name or a size that it
+ * got from another filesystem, such as the lower layer of overlayfs.
+ */
+static int xattr_check_name(const char *name)
+{
+	if (strnlen(name, XATTR_NAME_MAX + 1) > XATTR_NAME_MAX)
+		return -ERANGE;
+	return 0;
+}
+
 /*
  * Look for any handler that deals with the specified namespace.
  */
@@ -209,10 +221,17 @@ __vfs_setxattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 	       size_t size, int flags)
 {
 	const struct xattr_handler *handler;
+	int error;
 
 	if (is_posix_acl_xattr(name))
 		return -EOPNOTSUPP;
 
+	error = xattr_check_name(name);
+	if (error)
+		return error;
+	if (size > XATTR_SIZE_MAX)
+		return -E2BIG;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -416,6 +435,8 @@ vfs_getxattr_alloc(const struct mnt_idmap *idmap, struct dentry *dentry,
 	error = handler->get(handler, dentry, inode, name, NULL, 0);
 	if (error < 0)
 		return error;
+	if (error > XATTR_SIZE_MAX)
+		return -E2BIG;
 
 	if (!value || (error > xattr_size)) {
 		value = krealloc(*xattr_value, error + 1, flags);
@@ -434,16 +455,24 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 	       void *value, size_t size)
 {
 	const struct xattr_handler *handler;
+	ssize_t ret;
 
 	if (is_posix_acl_xattr(name))
 		return -EOPNOTSUPP;
 
+	ret = xattr_check_name(name);
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

