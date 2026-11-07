Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049629;
	b=yISN/DUAeHvP/s9xaR3eeuJlTnZL7qKd+xQJFLZptSr05wk4WJjN2Nh28L1G2m3mFnmG
	 uH4qHdbiYPZmgVz0Ar8+Tg4jG4Cd3mC/ssW3rznac7PDjfzks3sEGlI96g+qvWG6oHJBe
	 okorTH1u+WQKB5ZHBAyg2Cgt3FFdinNmOrfAjcEVdWdwToolsVcU0GLHLNCkB4zqK0OOv
	 AU1CtWTGwoe1CZulGxGq1vGLe/XGkDe30MvpwYjaTiPvI42lTC+pXT3yzXpWfykhySn3N
	 xt/zynsDFOe7Tyx8XZbp54cjpH0pMlQenJp7hYjue54MfScYfjUKcahsTxMIweLf5MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049629;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7VIy3EdthoID7rLnYQrSoyQhpDvJVUjVvDifHObXaWc=;
	b=k252kokMJp0ojh2Lnxb5o097w0o9y7Nq8WgG0qsgdPG4kNv1W070U/MXaDNaSWA/gEs1
	 2ryEa5lzwWdpTXWQ4sPefGINHs44+HOEhOVecG50E6CQoIvks6lDrz7ciDyfUp1116VGO
	 Mzy5ck4QEOQcLsqC352aZKa4x+dPGy8RY9onjEd18obuDpBTGxgrzYhAoe94hvV/MlLzf
	 B4aFYyEh1nQrFFCLG5vQ8680J7LjxX991urtK4Ut8FoOqT1v2OW/QB715NS6es2vUeuEA
	 Awzye4B0Gaz7+jX37MRb0MhoOdalI6ZrhM2e6naKzLs+hWonKd4EDoBUtLAGMW70EaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AduLIu/k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E196606D802
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AduLIu/k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3D71F0089F;
	Sat,  7 Nov 2026 11:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049629;
	bh=7VIy3EdthoID7rLnYQrSoyQhpDvJVUjVvDifHObXaWc=;
	h=From:To:Cc:Subject:Date;
	b=AduLIu/kMOyEhXN1TFfE3c2Ri3L/J+PrYrWLzuCHu8lRoceTLJ4TbVlk+l/ca2HRM
	 QWAz8nB05+z/534bAO0MenpD2vGSGOzIj33YmMQn5Bv17mZB2CpW4cDn7/MbFq4MD7
	 wdLgeqhB76pZ9mBpd2DTdODTuxpQSSibMDVFubc4Q9ao4uWu75+8mGBxagyHMNdW8h
	 Qpnlctbxa1aMzpafZk7/c4FhVcQNBIMXbJdrmFDIZcnfwqx0Y9dWEC6hBcoJYpOe2q
	 YUfISJZ82aFjgjXBFXb5ZQ/mL4lbYIiy6K2yQA1qAsz08kTmI8CpHQh5z4yReEKF0w
	 CVx0lgB6ZnoIQ==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: return -EIO for a lost inode block after cp_error" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:07 -0500
Message-ID: <20261107060707-failed-5.15-53b12b63304b@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 53b12b63304b34a3850a901c4de3cc6ad08e0aee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060707-failed-5.15-53b12b63304b@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 53b12b63304b34a3850a901c4de3cc6ad08e0aee Mon Sep 17 00:00:00 2001
From: Daeho Jeong <daehojeong@google.com>
Date: Mon, 12 Oct 2026 18:22:33 +0000
Subject: [PATCH] f2fs: return -EIO for a lost inode block after cp_error

After cp_error, dirty node caches are dropped without being written.
If such an inode was never written, its NAT entry is still NEW_ADDR,
and reading its inode block returns -ENOENT.

f2fs_get_dnode_of_data() passes that -ENOENT up, and callers take it
as a hole. Since the inode block is missing, the next offset can only
advance one block, so fiemap walks block by block up to maxbytes,
about 2^30 blocks, while holding the inode lock. It took hours in a
power-off recovery test after shutdown and blocked unlink and umount
on the file.

Return -EIO instead of -ENOENT when the inode block itself is missing
after cp_error or shutdown. A missing direct or indirect node is still
reported as -ENOENT.

Cc: stable@kernel.org
Fixes: 28607bf3aa6f ("f2fs: drop dirty node pages when cp is in error status")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1863e8f1c859f..2dc136dbee34f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -842,8 +842,20 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 	if (!dn->inode_entry) {
 		nentry[0] = f2fs_get_inode_cache(sbi, nids[0]);
-		if (IS_ERR(nentry[0]))
-			return PTR_ERR(nentry[0]);
+		if (IS_ERR(nentry[0])) {
+			err = PTR_ERR(nentry[0]);
+			/*
+			 * cp_error drops dirty node caches, so the inode block
+			 * of an inode that was never written reads as NEW_ADDR
+			 * and returns -ENOENT. It is not a hole; the inode is
+			 * gone. Callers treat -ENOENT as a hole and keep
+			 * looking block by block (e.g. fiemap up to maxbytes).
+			 */
+			if (err == -ENOENT && (f2fs_cp_error(sbi) ||
+					is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)))
+				err = -EIO;
+			return err;
+		}
 	} else {
 		nentry[0] = dn->inode_entry;
 	}
-- 
2.53.0




