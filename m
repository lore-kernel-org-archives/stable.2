Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674829;
	b=NXn9yPnJHpJkRm/edNhEW1zGTELiXjBEg4u1zLkbbPdArgFb03/+ZEMmrcQEeU+85wrd
	 3lHDNKXl+l+RagRicjSKIxJY2dtU+SrKuGfLuKNtzvnxhiQkdPipK+Ul/AwzMJ4Ff+EDX
	 ofkegtz9mGxXuS/CE40UtkBlxLCG5ZJGRfRYLazyAR3S70IUXVaiUjSL765IXCbmW6YRt
	 ti0TP6WNFn0G1Ke0FOQmIwa65dFr4FzREzssZ6fxRBO1D4ZskEVMigtQKLrrwq1PtGeDh
	 TEk16/SXDCUyiZqKJnuguMadOsJql6jNt8UAcCPJCJH193tAhbYH0b9Yd8uxEMVDXjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674829;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5BnVeCd9pl1KYVT0NWFrVW3FQ7zfs5et7wlnK5EaQRA=;
	b=Jytkbd+7g4bmW9ffBU6zTKwXe/thGs4fNSrjy9/tCnbQn6i3HZ0E5IMMWFvO1HuVHK69
	 6udHGGD618BoqhohRJ/8t0PG7xAvBupd3W4sAVI4ZkNdmIn7VGiAcA3PZis83he/JNLRf
	 Us2cx+PKqG43fZqAG3Xd4fSrnZHwsVL7bo8jhsyGg6CvoMw1QWbBEVRK4DE57oshFJ7T/
	 Ciy0wXyiC5682cggqYNHVwFXO4MAku74Nmy7u+BHf469ao//cL2xQHnB2njIk+uosUtpM
	 fRst/CkjmMrDJF3gPT2QKt8ebCfGS4rHvyNnOGGi3O0jgEeDA3A91RjN+uYk9ZlLQmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RdgJ7aJb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0B606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RdgJ7aJb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129501F000C2;
	Thu, 22 Oct 2026 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674828;
	bh=5BnVeCd9pl1KYVT0NWFrVW3FQ7zfs5et7wlnK5EaQRA=;
	h=Subject:To:Cc:From:Date;
	b=RdgJ7aJbErQniYi1mjnoQX3HefAGA6Tvq5uXJWLrJuiAN1TyorH28mqANUT/3Q1H1
	 Zemqh0rqrpfC4Dw4uAu2bexP7LGsruGxIHFO4VBQQBB/s4CtaPyJCDfSEpQuHc2UV6
	 6DSIr+v/5ndscbL9LndimOXgZN3D1qxEtqSiDDzk=
Subject: FAILED: patch "[PATCH] ntfs: take invalidate_lock in ntfs_setattr_size()" failed to apply to 7.2-stable tree
To: zenghongling@kylinos.cn,hyc.lee@gmail.com,linkinjeon@kernel.org,liubaolin@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:12:44 +0200
Message-ID: <2026102244-balmy-unicycle-3160@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 9cc5761b8f28f9cef72061094eb5e37e2cd44d97
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102244-balmy-unicycle-3160@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9cc5761b8f28f9cef72061094eb5e37e2cd44d97 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Mon, 31 Aug 2026 16:30:14 +0800
Subject: [PATCH] ntfs: take invalidate_lock in ntfs_setattr_size()

ntfs_setattr_size() updates i_size and resizes the on-disk attribute
without holding mapping->invalidate_lock.  Page faults take the lock
shared, so a fault racing the resize can resolve a VCN against the
transient runlist state of ntfs_non_resident_attr_expand() and fail
with a spurious SIGBUS, and can interleave with the size-change
epilogue (truncate_pagecache(), i_size_write(),
pagecache_isize_extended()).

Take invalidate_lock exclusively around the whole resize after
inode_dio_wait(), matching the fallocate path and other filesystems
such as xfs, which wraps truncate in its mmaplock (= invalidate_lock).

Fixes: 9c87959601e8 ("ntfs: update file operations")
Cc: stable@vger.kernel.org
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 1969e4f444f7..585ab2145797 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -270,18 +270,25 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 		return err;
 
 	inode_dio_wait(vi);
+
+	/*
+	 * Serialize with page faults and pagecache instantiation so that
+	 * readers cannot observe the size change until the attribute
+	 * updates below have completed.
+	 */
+	filemap_invalidate_lock(vi->i_mapping);
 	if (attr->ia_size > old_size) {
 		truncate_pagecache(vi, old_size);
 		i_size_write(vi, attr->ia_size);
 		pagecache_isize_extended(vi, old_size, attr->ia_size);
-	} else
+	} else {
 		truncate_setsize(vi, attr->ia_size);
+	}
 
 	err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
-	if (err) {
+	if (err)
 		i_size_write(vi, old_size);
-		return err;
-	}
+	filemap_invalidate_unlock(vi->i_mapping);
 
 	return err;
 }

