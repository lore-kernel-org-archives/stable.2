Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046316;
	b=Oj3ss28eLDTTnD0PrKxqZdKJc4QraP7jn1jvrqkLL+EFQwNIDEggWizSn7VwfDnYvFKA
	 HeAqEgWYbcC6qZhzjxcNeqq1xgK1cF4OBEtIjg9Ry6FsCKyCP3pgdyjnWd+UHfJvif9RA
	 6b1GBOXDVAQ4er8n7mh4UVXTfVUxiPaMscqylaPB8QAAzld0qVCJ+hPERJSSBbX1aCrQS
	 80GU5ugfUrbXbFNbfTRZJ0L+dpkucs39oEJvR7F17wnS/EbLR0XD/E8KSHNQEyrT7JMsy
	 +N9CctMXrxKW9IVStVoTEKzHX8Na4rs1prykvWK/eLeaAY9vDwnVYkSWmhsOWU3d/aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046316;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aSeMR4qyb76nBd10VQ0A1z62KpgwVYRXE3eDpXo4gGc=;
	b=VxhPN2KUKLCsj1yYDc/FYjo5vCueLiGlQrSW6bkIxWG8CjTzWZvpAjP+wvEhuNdZxDkB
	 4RAUY7yysdbY4bcqqX4CtywoLN3vjtp/lWZ8gqQFi8FQDW2Z80Pc2o/vR+wY6/fWL1pQj
	 EmlP0AxBGjBui40BpVcsE2elD5y1mJFFMJX804J5W0cy2YOaHULdburhhCwPiriqJjIKy
	 AUmIH7eqZVBCoqDnmHLyW48A+P2nu+feiZWqaCezVy7Lofy8gtJa8FaCfI7QbC/h6losO
	 LG/gGc2pwEVfwvnZJKgcDOnRUYuOgHwaD/AxWT0I2i/iK/Nr6csFSGnAemh3nHx+FXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tw2LCKu7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23232606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tw2LCKu7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B32B1F0089F;
	Sat,  7 Nov 2026 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046315;
	bh=aSeMR4qyb76nBd10VQ0A1z62KpgwVYRXE3eDpXo4gGc=;
	h=From:To:Cc:Subject:Date;
	b=Tw2LCKu7waogQgpUsk4XwXLZSbTZKd/dP72prZQgd2cx7PrWJ4oAxS8hjzyLT3oHT
	 c9ghjxG+Zq2xkN57b3WtCOMtZeN5EKTApeI4ww9vkjtC8KQMYfTwMYgB4ifXMflN5g
	 a6IBhADaehLkZJGEtQRaseMRhNyhSOUvu9d2Ckx4Qccas+4UZoCjBR6pRF81guKGwT
	 q/HvF8gHTQijM+IA1Ul5N4SGyRuD6VkJK/BsDkeesOxeDiTuE8rK0VXIwPT0wMmshV
	 POakBA50ENtg5l1A2zZEBJrrwkbNMnzP5rxPRtmTq/E8XT9ZnHb/yKQ1qCVvgc/LGi
	 TkyPnwbZXmgxQ==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: return -EIO for a lost inode block after cp_error" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:54 -0500
Message-ID: <20261107051154-failed-6.18-53b12b63304b@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 53b12b63304b34a3850a901c4de3cc6ad08e0aee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051154-failed-6.18-53b12b63304b@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




