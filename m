Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A64718F4;
	Tue,  6 Oct 2026 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322666; cv=none; b=UYP0JxWnE448R+JMJ4KV5cioY9qqaYpvXC3jzD6HzIkr6VNhyYpJfaCayS+IVc4u36AZd8pkOQ1IjEU60WANuMHNx5+OqK42DoKfFoh4e8PiJFhvgXwqIfD6sUgV4my9SkMb1CZXXi81pVo8Fz8r2wbG3wUAB98ZdRKHe42u8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322666; c=relaxed/simple;
	bh=1ziGm2HV0qD4xRjmH3LXyWrO9jsvLSvgLalhd+Tx8xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSNl6EQ6IeojmTZMuohBxfUlh/Fsbx9lOOnln+Pp/mngAjRzAVF9nK2LeUduY4oI+R/SsPZsIu3ue0dDFsIQnMC7fGnqLF0VW7EwEjCELjKEQ+5rgGl99CzN6BJABoxx5HUB2wl1qbNXnwPtGFvEESsoBlFASaHMPuxDlBXK2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBBWpZhC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBBWpZhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE301F0089D;
	Tue,  6 Oct 2026 21:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322661;
	bh=YpnPpzYA/yc+pzhnEtBuMpKuqZkPirHbpxBQTGlaQNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PBBWpZhCE7TO/42T/reYCqXZhCis8r9fJBogm770I7MNbYsbFjOugQU54P8coffn4
	 7Er2NiaBGA8qz7PcmUonpTLH+reHJ+O0nsdfvOIpF5CCYpUYww7oAJNGltxz9PKuPr
	 ub5mC5BYAcK7fj7AFuPd6KxxWvhkbJm4Oc6mfIr1+wBgE9SvvRf5ABym85Wp9evAw7
	 Lx6GlYfIwGsFHTeSJULU3CMVh6RB8jHTX1zgUgR//hObcL9Xl4ozW52nbEt1AQ0Vqh
	 x10/uAw4EnHqHQKRm5ggOTljTeQOF7Vq1s0XkGfx6F4DR2Rvn5VgSsfEk/s0NIWbyl
	 aFm0W8Pb6FyuA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.12 2/2] fs,fsverity: remove check for fsverity being enabled in setattr_prepare()
Date: Tue,  6 Oct 2026 23:37:25 +0200
Message-ID: <20261006213725.47114-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006213725.47114-1-ebiggers@kernel.org>
References: <20261006213725.47114-1-ebiggers@kernel.org>
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
index 714f159d58ea..927cb18d25d5 100644
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

