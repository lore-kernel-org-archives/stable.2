Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2A556BA2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091124; cv=none; b=cDnaV08/G+cJ8VSdN4a0MLZTvkEjLcoe8m8sZyyj2vSo1in2NspkOg6zxD4PoFFKo7v+xqTaZiC7kid8SlRlEFv7Bl2DwnRCWhK9tmfUyr6on5ag7M18YjD7sKGB1vC5ztdJ1jb2QJHu0d5PK0j1c0SZsJqMhVN2A7IFUP8VkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091124; c=relaxed/simple;
	bh=6pWnEEnS7uzZxs9oLh2g8HL1CGaxcQxA9TUq6o9kuMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHTTFZTQ3lTlziiHh3rRXP9bpYj+lwg3aa2YugbONE8MsL44+e6SUUs9nKRP9NhN0cF3jm67JGpZNDF2+y2yV+FG4QX8si+cr5hQamnmcAVkc/LTl9d66Al+idsgq34ayO3Q1RD/V14boXEfzJYAnuQC30toBS711kSN+3QiopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz46wp5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz46wp5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A861F000FF;
	Tue, 22 Sep 2026 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091123;
	bh=7nQRvqZMLXq8jTVIHK+aTLq6q/AWbPaZ5pscWjNJOIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mz46wp5lobsCQu9ewuQxdaqAe4AmgddbYeVQQZu7uB5VDxz5CJpS+jXlcx1VAYkzQ
	 CrlRl6rFTnnT2r+3jde1x84jjLaTFFKKiZe7UDWMPiGvXos5NbiYE/xFj3EjkTYLH6
	 yFiJzEbG3SP9pL7qYMGheSgunviwsqu1suzPOwGmWdAXMt7cfPzOjtPiDbRLXwrgcM
	 pbcxg1DWfREH0avTuBQQPWrAgix5Fdfy+RRkmJMk4LxZXc87+v2WhBhwXA1s3OTMW9
	 ThRE0ojHaDnJqkg1EZym1yOni6pAJOCG2cyNLs06qHgbBPsf8Fke4nFlIgmzRXiF+L
	 RqGaGwgO/5Kxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongling Zeng <zenghongling@kylinos.cn>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] btrfs: take commit root semaphore when iterating in mark_block_group_to_copy()
Date: Tue, 22 Sep 2026 11:32:01 -0400
Message-ID: <20260922153201.2820708-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092246-stagnant-delete-08e7@gregkh>
References: <2026092246-stagnant-delete-08e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongling Zeng <zenghongling@kylinos.cn>

[ Upstream commit 0594e3423f4ba3137c734371169491f9a98e9af4 ]

mark_block_group_to_copy() iterates over the commit root with
skip_locking=true. A concurrent transaction commit can swap and free
the commit root during iteration, causing use-after-free when
accessing extent buffers.

Fix it by using path->need_commit_sem to protect the commit root search.

Fixes: 78ce9fc269af ("btrfs: zoned: mark block groups to copy for device-replace")
CC: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ changed path->need_commit_sem assignment from true to 1 to match the older unsigned bitfield representation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/dev-replace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f77ef719a3b11..4f97a9222b74e 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -506,6 +506,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	path->reada = READA_FORWARD;
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
+	path->need_commit_sem = 1;
 
 	key.objectid = src_dev->devid;
 	key.type = BTRFS_DEV_EXTENT_KEY;
-- 
2.53.0

