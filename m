Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095F3F788F;
	Mon, 27 Jul 2026 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145440; cv=none; b=dGOQBBJ6HFSu971QHhycYl1Oj2o0HEuw+n2iyzfUwYZSFrLtEU8tr50YVOv4K5gwTMkDttxwx6u9Qp/6TXz/UAaCSkz+/PqRlozLNySi8xTXDOn4LTsMgLeXbtiAQypE2szlfdIm5TQIRK8uuJ5pSKpkvd//5SSHSBShw1nNZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145440; c=relaxed/simple;
	bh=4xfvWL5nSz2X/Fmn6KeKhw+QvE/JbbryDi52d4ltegk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCE2vsgf0XraYNTicFKWcF8dqrGKlInZVZ+jzmQKla90rgW5alTlZo5+bKxOJLckeC3FdN/dfjunyCTO8Ki2ET9hXAYX0/FUhzergSL5GiXV28BLfHudaNAcBEBskLs5GCM91VKfLZ8/2D9lT6wqhMf6hsPPO8TPdnZSP3qgjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAdmxzUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAdmxzUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA731F000E9;
	Mon, 27 Jul 2026 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785145438;
	bh=cWVTMq1evmaoyaTXcan4qOMVQf3WoxnNXMkVHEYJ85U=;
	h=From:To:Cc:Subject:Date;
	b=TAdmxzUFZ0hJ3SDVctmhKTkHVIlPJMNVNuE/GlkWeBRBpSRRdlw+Xru9FF+jm2nka
	 slAKs89LResBI1jLgdKrMK7syZKXKb8ppIAzQATVgQpzxA/kECgYtY5iPV21lgbrr/
	 jIhiUOLA+5LL7I5Caqo6hN1PCcN666M3r1SZi6HZXX8TooaWkDjt6a3EG9c8YWwgZ2
	 eKNdZstQT0Wkc8UppmAS/NKj6ZkXC5rCsu4gZcCdtWF8XfGjA+98x/JMftKW5IU9Gk
	 I2ImgJUw395ZxW4kSJDs5cYGShaEOtDjV84XEbA604WRHrfZRz+a4nZBFrqzCnQqHz
	 3YCJ7Z/lUj8Xw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fsverity@lists.linux.dev,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] fs,fsverity: remove check for fsverity being enabled in setattr_prepare()
Date: Mon, 27 Jul 2026 11:43:52 +0200
Message-ID: <20260727094352.1734826-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check that fs-verity is available in the kernel is not necessary
here. Filesystems could have fsverity files even without fs-verity
enabled. In that case, truncate on fsverity file will succeed, what this
check is trying to prevent.

Fixes: e9734653c523 ("fs,fsverity: reject size changes on fsverity files in setattr_prepare")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Acked-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---

Notes:
    I rephrased commit messages a bit to be more clear.

 fs/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/attr.c b/fs/attr.c
index 4f437fabb7f0..71888ac903c2 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -176,7 +176,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * covered by the open-time check because sys_truncate() takes a
 		 * path, not an open file.
 		 */
-		if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
+		if (IS_VERITY(inode))
 			return -EPERM;
 
 		error = inode_newsize_ok(inode, attr->ia_size);
-- 
2.54.0

