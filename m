Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046394;
	b=pvtj2JfuSB+sWTVq+ZkFMuRFyEtETs1rTkjI6lMrnj4zrxxAvhNI2gfLD5P02VYjAaBv
	 EkC8MGT3AWGgaY5c7qNCLp5OigRFWmDOi1P6V6h8vCAEgyOgWshqWYMINiaqHby+cQpgs
	 mwqRGYavW9AygHZtHK53D0VEhgPW2YbpBi+Pr88UEQX7ehDHCxBbdDPADo/btk9hjwwAv
	 Qb0i9lqOTDl+u0nz5hrYAM2UCnWtM72a+t/5/PiAiak64PGYGHzAJwUJ1xWZ6hdTac4ZI
	 +ZIAyEjliNt8ZZjSESZnd366pkGsj2IC0mZRrH2cQ6kcTa0Ae4FqTSQ1bNnXEoeHu6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046394;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EtD+EVOXKtFanuYJFKRgtcigR8qZzz3JqsIVZp1sVHs=;
	b=jLVM2kt8G9tnJaRDtFPq3RwfbpKUoejGRUip/fP3FE7eMk7O7T1t5YMCM9rj55vMT5e8
	 C5GgHB67TpBAzC30xtwSK5kxCWLLLSM5ShZKKbMeSVfgbwFyZHiByy7oEG926Sw2DF6Sp
	 atxpuabJ+sEF7l7Kekl8Wh+ne2Bij9680X4/wngMgwFv6tlaA0rFbEUkFtBy9TIFZVlD1
	 MRG9kIVfdojaS0LCgsuXUMkaRyzACubpANxLaEvPGNHeWRgAkbqF6cZd7PMOUZFZ8fpq0
	 1xCuFOxMrMPARDgRABV3txrlZaOs07gE91CbYDLHxu+uPIVvZpGIKWIkSW2xTNdDOtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxMqO3NY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxMqO3NY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3ED1F0089F;
	Sat,  7 Nov 2026 10:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046394;
	bh=EtD+EVOXKtFanuYJFKRgtcigR8qZzz3JqsIVZp1sVHs=;
	h=From:To:Cc:Subject:Date;
	b=TxMqO3NY1XCUgrdyWoCOeGNB/yQh8MqK2CFc3f2AQ7e04zUTyU/maAdaG6neYvoqn
	 cMFtM/XdDzbqKnYThGGIk35EmlNkw+TC6qNie5mmAMDLbpvfBJhZFc5tLPZ8rnWuS8
	 hJsGDzPTSULI6A0MLStEJYfR8NqNuyDrw/sZZ4ppQEcHS1coPfspH4rMHqj8owyZGj
	 yLI4yqBYoyNEKbEZCG9XTeYVeZ9bvjdBJLQcSQCiyCS+0BvuXPzNy2kRBmIdtvupgi
	 fstO+TmUtRKiUPCMCtkl7z7kA31+914dKaRKJX/1rBn+wSLr1zdJaxHQ8LL1QbvbfD
	 Z4E1JTK5YZTNA==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: don't use truncate_inode_pages_final() on live inodes" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:12 -0500
Message-ID: <20261107051312-failed-6.18-74bbd6ada01f@kernel.org>
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
git cherry-pick -x 74bbd6ada01f91fcad60608e0417bf45a9fa99e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051312-failed-6.18-74bbd6ada01f@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 74bbd6ada01f91fcad60608e0417bf45a9fa99e6 Mon Sep 17 00:00:00 2001
From: Daeho Jeong <daehojeong@google.com>
Date: Thu, 15 Oct 2026 16:17:14 +0000
Subject: [PATCH] f2fs: don't use truncate_inode_pages_final() on live inodes

truncate_inode_pages_final() is meant to be called from ->evict_inode.
It sets AS_EXITING on the mapping, and nothing ever clears it, to tell
the VM that the inode is going away.

f2fs calls it in two places where the inode stays live:

 - F2FS_IOC_START_ATOMIC_REPLACE uses it to drop the page cache of the
   original inode before setting i_size to 0. The atomic write then
   goes on through this inode.

 - f2fs_abort_atomic_write() uses it to drop the uncommitted data. It
   is called on eviction, but also on the last writer's close in
   f2fs_release_file(), from f2fs_file_flush() when the atomic writer
   exits, from F2FS_IOC_ABORT_ATOMIC_WRITE and when
   F2FS_IOC_COMMIT_ATOMIC_WRITE fails.

Other processes may still have the file open or mapped in all of these
cases. The mapping then stays marked as exiting for as long as the
inode is in memory. This stops reclaim from storing workingset shadow
entries for it and breaks any code that assumes an exiting mapping has
no users left.

All we need in both places is to drop the page cache, so use
truncate_inode_pages(mapping, 0) instead. The eviction path is not
affected, because f2fs_pre_evict_inode() still calls
truncate_inode_pages_final() after f2fs_abort_atomic_write().

Cc: stable@kernel.org
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Fixes: 41e8f85a75fc ("f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c    | 2 +-
 fs/f2fs/segment.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3b5ad281b518e..b077e4eb790d6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2462,7 +2462,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	fi->original_i_size = isize;
 	if (truncate) {
 		set_inode_flag(inode, FI_ATOMIC_REPLACE);
-		truncate_inode_pages_final(inode->i_mapping);
+		truncate_inode_pages(inode->i_mapping, 0);
 		f2fs_i_size_write(inode, 0);
 		isize = 0;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 92c3f255ea8fa..daf6d9617d5b6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -194,7 +194,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 		return;
 
 	if (clean)
-		truncate_inode_pages_final(inode->i_mapping);
+		truncate_inode_pages(inode->i_mapping, 0);
 
 	release_atomic_write_cnt(inode);
 	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
-- 
2.53.0




