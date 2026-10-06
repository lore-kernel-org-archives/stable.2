Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604753DC4BC;
	Tue,  6 Oct 2026 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322611; cv=none; b=QcB5prbNOy+CSxc2n3ZjenKTcc+BbTpEXLQH+vXafa5xR4yQaRr1XBdBN5eZwg0hFmeZ1kAmWQ1yE5N8TLk0QACsnZfRieMdZkNzzEb/eVfDOOeCuO09CMADzGD65/5sJFFJiXwQwtZc6vYzWzZhaPMkI4b2UWZEDfSgcP6mjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322611; c=relaxed/simple;
	bh=fUHw+GjqmjKXDL/ibxZDMMtUSVhvipuRCloZPdPSNIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyfgXAb78CWX65yP9QDJWulp4CdvbHmtGbXy6GJ3tZtQpn8Me68VmKX+hhIA+nZWvDMkdEBSfCaef/mMebLdJODvHntwN4TVdEX+qxJou/ZmhJ2NLLqhDVsrcMcFNHDV3PV7s4wrhGbp0O+cd+ZZbTBOUFV50C6wq6ATsoIHgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFF8g3x2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFF8g3x2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23071F0089B;
	Tue,  6 Oct 2026 21:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322610;
	bh=gdRzWkvfH1v3OyUmUUWTFq86SgXfWNzN+syAmu9zArk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RFF8g3x2URq/JSxfmzPEzYNygUhFhkYuezSjAaDrUgNTvoz7FCx4hbUICa2ijeHQi
	 4XQHLOs6GzqNJcjEJT/Zc4hrF9fUi7xL2PlEWEkLRE6IRHZAedYRnwQaSrwoUP/OCo
	 AYRTPrASaVLN6UPgwgVqa1DWKl6AqQa8A1T7CKQ+LqHxgWucN5ekZkmBIGV/75DjD7
	 +IYi8AN5SVIr38ScRD88XN8I2lKl8XL8n5LS2qCDWcIulVKt9/Xr1uyHQ3iOI8sfcp
	 JEf35hGUXmJ4R8r+jKCSUF1gbgk76lzf74ZG9RY1oA8tKMALE4BkQbMGJ2uiWgccYG
	 C/OuCcsJYF0aA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 2/2] fs,fsverity: remove check for fsverity being enabled in setattr_prepare()
Date: Tue,  6 Oct 2026 23:36:05 +0200
Message-ID: <20261006213605.46946-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006213605.46946-1-ebiggers@kernel.org>
References: <20261006213605.46946-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrey Albershteyn <aalbersh@kernel.org>

commit d2f96bcb89d36d488a10e3bcf819b98536968286 upstream.

The check that fs-verity is available in the kernel is not necessary
here. Filesystems could have fsverity files even without fs-verity
enabled. In that case, truncate on fsverity file will succeed, what this
check is trying to prevent.

Fixes: e9734653c523 ("fs,fsverity: reject size changes on fsverity files in setattr_prepare")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260727094352.1734826-1-aalbersh@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/attr.c b/fs/attr.c
index 2c94af08be18..3f2cce4e4ad1 100644
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
2.56.0

