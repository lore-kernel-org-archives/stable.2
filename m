Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430667;
	b=y/QIBAseIiHKWR4wt4Q3YxYFgHKPpKf5VndH+BNEx5tpku4BJeccu0Z3RPZQ8D/foFoI
	 eeWTuhsbGXGbNarDp44M2lfXv5pJdTY7s0Q7jpHWrtMd5YhAiydCbEQ4IeZiybouzCYC0
	 ga9/H2N3ft8T8eUO7dVrbMcq62kKZSgca5y5P4QLhAwBqKqQ3nHagRpDEcrDNqiH+tTYY
	 z1np7Vd9V772SiodV3oSbEeWOhZ9G9GX684fQWLjgtHBCbXwuWmOhvt3THADc26p1l6w8
	 StpXrKQCee8OL0onv9dVqLtHSq1/h4TkY/iLOXp6FsJu+6k1oDQfI2A6obym9Of9r1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430667;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qqDKOqTvCmRQ2jOGsyK5U32jxhozpC0oTH/ZS42zQJ8=;
	b=DM867Xy0i4Y2Tz93lbrj/K6DSx1MYx3MRg/zJLxAxJvpUVPNanmrVTbsguw47p+0b80Z
	 vrea4IIdmBP4bA/As+V1WdRba2RzCTQDMz+14ymvEclMfT6XWYJgrWArf22zKfqkFeyZk
	 2V+SQT4jQMYpbfR8gp9ZmqjH/wTuy8TChhqTh9hjsJBlUbd1DqWasDGQMe9oEhpRU4fvh
	 YRyb8FCyQJ5Fbx9q9gG1wDiFdWvMupj0iwgINzP+JyNTGtFBSuVK9qpTM0oUEU6GRZlYO
	 Xlby1ord+jB+bx+tD8RVMrjKpHZ9Bo6kpU3Hboe6ffslsmnPfgSlXXCth161ifa0sLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvU6ncTb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC6606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvU6ncTb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328441F00A05;
	Wed, 11 Nov 2026 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794430666;
	bh=qqDKOqTvCmRQ2jOGsyK5U32jxhozpC0oTH/ZS42zQJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kvU6ncTb/i5fZccyP66IDhimctjcEozNh8RhdYL6PEuZGggT0fTcZfMUXE6Gac9d3
	 /9Uxo5gyrjXVE3YAIOcGCVSNDuhPMOR3oL6X7D+Wj+eNFXPNhh6M2aUTkNmIBj2ozU
	 zM0TcRb9wYHse7OdDwkgccFlftZJWshf2J3Yyrply4c8GKRb4hySY+gZsfE5Q7eYEr
	 ffxpDz71tKCGoyf4VkWjgKlpFvwCIY4HTSf13xLRcqSgaB0WQCmHxO5KVAQZJFx42y
	 yq0fcRn5oKxYyJwHsBU/BPCBmmmJEELkat1EKQSnly/SXg8l4Je94WObV9GdvtEKZ7
	 L4UKiISSSh2qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guolingxing <guolingxing@tju.edu.cn>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] btrfs: prevent deleting the wrong subvolume by ID
Date: Wed, 11 Nov 2026 15:57:44 -0500
Message-ID: <20261111205722.4060260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200632-failed-6.12-1960146913b3@kernel.org>
References: <20261109200632-failed-6.12-1960146913b3@kernel.org>
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

From: guolingxing <guolingxing@tju.edu.cn>

[ Upstream commit 1960146913b31b288ed2cd607d103ee3b41681d4 ]

When deleting a subvolume by ID, btrfs_ioctl_snap_destroy() first
resolves the requested ID to a name, then looks up that name again
under the parent directory lock.

A concurrent rename can change which subvolume is associated with
the name between these operations. Since the deletion path does not
verify the ID of the resolved subvolume, it can delete a different
subvolume while leaving the requested one intact.

This was reproduced by repeatedly exchanging the names of two
subvolumes using renameat2(RENAME_EXCHANGE) while deleting one of
them by ID. The wrong subvolume was deleted in 9 out of 14 independent
tests.

Fix this by checking that the resolved subvolume ID matches the
requested ID while holding the parent directory lock. Return -EAGAIN
on a mismatch so that userspace can retry the operation instead of
being told that the requested subvolume does not exist.

Fixes: 949964c92843 ("btrfs: add new BTRFS_IOC_SNAP_DESTROY_V2 ioctl")
CC: stable@vger.kernel.org
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: guolingxing <guolingxing@tju.edu.cn>
Signed-off-by: David Sterba <dsterba@suse.com>
[ sashal: Changed goto out_end_removing to goto out_dput to use the existing cleanup path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3c3c767c858f6..aa49622cd302a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2536,6 +2536,17 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
 	inode = d_inode(dentry);
 	dest = BTRFS_I(inode)->root;
+
+	/*
+	 * A concurrent rename may have changed which subvolume the name
+	 * refers to. Verify that the resolved ID still matches the requested ID.
+	 */
+	if (destroy_v2 && (vol_args2->flags & BTRFS_SUBVOL_SPEC_BY_ID) &&
+	    btrfs_root_id(dest) != vol_args2->subvolid) {
+		ret = -EAGAIN;
+		goto out_dput;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		/*
 		 * Regular user.  Only allow this with a special mount
-- 
2.53.0

