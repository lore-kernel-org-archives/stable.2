Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA5C55C1DF
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091715; cv=none; b=er6PfW2nECxFzVkoxgvFLXeIVjtY+XzrQomxNH6eEvJdGlSRifN+YNwaATTgEEyid6xih0rw3I9hcZcDkDX+eoFGCBOEwHi+WbJ60IajGW49tvjKawe1KgYnUOlUaKTAoXwH/QGu9rC+ATB5hxWDODbU5PF5DqLvPlNK0s+F4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091715; c=relaxed/simple;
	bh=E4p/YTZYlZO89hN1/DcJyaH0itU0603/tZr1ucJcUaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSzdBMLmcW9nlbkqQJIzh7PJBYBYE8CvIF4eguQc0bZ9omwRFwWUXCzv5wcYU2uVvRuobygSHzGtW2tGRZMfHZFCsCUVMZsjXyxiJsySZ2QeQ23UkOl4OzlaM0avBqEpUD3kbnCNSr+rY7+RqsH/CerZ0LFqfYOnxD5pkdqE814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzRhqR8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzRhqR8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7F51F00898;
	Tue, 22 Sep 2026 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091714;
	bh=H954rAeWEU0UkOjOsXlhyPDZLsZG+0fSwG/2dF5WZQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UzRhqR8jZ2YWzEWtNqcrOr+k8iEIh0u9niXkI5ooEVsBJw1ciQUOYpjjWWLyA+oF6
	 zNs5HRwZ/BNAeWaBTLShUqu5Ltjbx351mu3wwVtHdU37vSVrJaa2fr78RYDY8AYIVI
	 Q9TyNWyfObl0ze4bqDEIU1iHhWa16cFyKBAp4iVqjSl8Cjmh/rHwSUly8gr4k1LoJy
	 f7h4NKmd3jxqFeoyszW227V1QFR9eDCP/68Pdg/VZffjODu6Cf5tdHRVfHfmSPVLSe
	 h3ELOIIbf7GQbWYL0tlVBCdb0acYzFYSoBwBrTCXbd913VXwqyFmyYvMxa/N4QmKAA
	 Ilp04K84PsbcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongling Zeng <zenghongling@kylinos.cn>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] btrfs: take commit root semaphore when iterating in mark_block_group_to_copy()
Date: Tue, 22 Sep 2026 11:41:52 -0400
Message-ID: <20260922154152.2890713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092247-irritably-diabolic-9ca6@gregkh>
References: <2026092247-irritably-diabolic-9ca6@gregkh>
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
index aa03f2bbcc11c..d19260ccb1c34 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -516,6 +516,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	path->reada = READA_FORWARD;
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
+	path->need_commit_sem = 1;
 
 	key.objectid = src_dev->devid;
 	key.type = BTRFS_DEV_EXTENT_KEY;
-- 
2.53.0

