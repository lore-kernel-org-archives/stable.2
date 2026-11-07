Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050733;
	b=oDWzyV2NJ74qHwRrX91le+JwIFAKJ9nKNnMM6NsdzuMPdRmLBh9FiS2GYkwtf8AT6Rvu
	 Ld7rKha+3VwMp5TGp6Xuczz08fYx1iwY8rfdwjaTH7BTySZdLdjZOukYgmIS7jzAxQAN/
	 mlfjhxFlJ3fih/sbC/hJWlpH0mxokrpMTTjPbzcmKc1YgKJhRjNqw1vs0GHmmReSiuogJ
	 k3I2+/nGZpgyFZuHjYHraCqZzsm1II90dnnZkX7P3xpTtdPK+vLZVSdUGZPHi9pHMK9Ls
	 FO6LRaQZ8ckHBprrNV5O4HXgMa/kfesl+7yiGeTlkGFJP3pup/1p0YawFPVPAl9hrvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050733;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=V9VDYvTPYqP8JdL6dV5iPxhTxLE7LrD7tJ5cNhqDXWc=;
	b=cX/+DKcx+kD1UZWNVJVq6ZBhir6YwyMnDcmDJzOOB7AXIgt6DDGxqGCfZq8/obKXIq0/
	 1m5/gpa9Oez7mOYdHhamvVlKFcOUSO7UOsBb+EeQkdy4K5BZrcqTyIGQnQEkdhLYi1vXk
	 IAMwCf80cvcEBOekZb2AeN09G/IXuU9k5izFYNNfcV81jhFEuc7iOMEIOmJ0XOsxXw3+f
	 qV+LHnFNhuoRk1+WbRv0t7AzIjkUme2extQ8IBbR9RJ3duJf9+4KYhKSU3ZBY69PtPmsa
	 QBkiznI2RBqTXQlNXu2EDxsqewlGqwvKjLkw6WUpXpSdaeHf99as0+3Yj4CKxRkJZzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i85FjWyv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A470F606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i85FjWyv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF561F0089F;
	Sat,  7 Nov 2026 11:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050733;
	bh=V9VDYvTPYqP8JdL6dV5iPxhTxLE7LrD7tJ5cNhqDXWc=;
	h=From:To:Cc:Subject:Date;
	b=i85FjWyvGqG3Iu/X21Bfs/jPA1p2rlX5RUAGZgpNHwVEpssoYUll0z2Ou9M5Jubm5
	 LrjskQ16ZPSXi3jaY4szXVwAxYbnY6JLdBVWHWXWmunIKdR6lg0xpNtwtem9D7nair
	 qGTG/5qZL+FCTUGJNXftGP0UYOYg+G/sy6YHn4mxIfB2KeSJ0t+Z07v2Zzf7yXpKfY
	 ofqaToOcQ8AkmxpchSYpC8B/909rSMjeRGvxi+iP5tZzOG94Q2+c81+24awhiAnbsW
	 2RpyaDAv5CHtZHQxiWHEqol4OfkffeO9YN/yeBtZl1j4uimpYYS+AbB+T3qYE7VNXh
	 tvN8Y64NLlt1w==
From: Sasha Levin <sashal@kernel.org>
To: zenghongling@kylinos.cn,
	liubaolin@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ntfs: NULL vol->vol_ino in the load_system_files() error teardown" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:25:31 -0500
Message-ID: <20261107062531-failed-5.10-a0c022c1da5b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a0c022c1da5b0fa30c61bd5b28db9f639ace5bf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062531-failed-5.10-a0c022c1da5b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a0c022c1da5b0fa30c61bd5b28db9f639ace5bf5 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Mon, 7 Sep 2026 15:08:52 +0800
Subject: [PATCH] ntfs: NULL vol->vol_ino in the load_system_files() error
 teardown

The error unwind of load_system_files() drops vol->vol_ino on two
paths but leaves the stale pointer in place while it keeps iput()ing
the remaining system inodes ($Bitmap, $MFT bitmap, $MFTMirr; $MFT
itself is dropped by the caller, ntfs_fill_super()).  A third path
carried an iput() that can never execute: it sits inside the
IS_ERR(vol->vol_ino) branch guarded by !IS_ERR(vol->vol_ino), and is
removed along with the stale pointers.  Nothing in the teardown
dereferences vol_ino today, so this is pure hygiene, but a stale
pointer to a freed inode surviving the unwind is a trap for any
future code walking the volume during teardown.

ntfs_put_super() and the ntfs_fill_super() error path already NULL it
after their iput(); do the same here.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 49ec1eb1520c1..9f5cf65fd3a55 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1536,8 +1536,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 	 */
 	vol->vol_ino = ntfs_iget(sb, FILE_Volume);
 	if (IS_ERR(vol->vol_ino)) {
-		if (!IS_ERR(vol->vol_ino))
-			iput(vol->vol_ino);
+		vol->vol_ino = NULL;
 volume_failed:
 		ntfs_error(sb, "Failed to load $Volume.");
 		goto iput_lcnbmp_err_out;
@@ -1546,6 +1545,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 	if (IS_ERR(m)) {
 iput_volume_failed:
 		iput(vol->vol_ino);
+		vol->vol_ino = NULL;
 		goto volume_failed;
 	}
 
@@ -1706,6 +1706,8 @@ static bool load_system_files(struct ntfs_volume *vol)
 	if (vol->logfile_ino)
 		iput(vol->logfile_ino);
 	iput(vol->vol_ino);
+	/* Do not leave a stale pointer behind for the rest of the teardown. */
+	vol->vol_ino = NULL;
 iput_lcnbmp_err_out:
 	iput(vol->lcnbmp_ino);
 iput_attrdef_err_out:
-- 
2.53.0




