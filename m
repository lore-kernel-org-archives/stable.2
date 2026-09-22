Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578631E848
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091367; cv=none; b=ca/jvjsoDrWDcsMmUE7YnnjTuLKiikcIbXpa/pbvZjUAwrRi/2D8pl9m6AsN3z6m/7uTcsH7SWshmdeV1UIglpnc64Q2A8oLBan+/T0J25+YPsLZL1sshm7zkNgYRC/qnThiQPzo3DDlgk0SI/+zdkLCsgxDGMZCpfCQEN07R2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091367; c=relaxed/simple;
	bh=3WlX5iY7tYFEcB3FPuRai56x8SVONi5EjPrSQJDmoec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1A5bZ+Bwp3VHk/NENDwburWiIkls4UNKg9BGnvp5fD4pp2cBPNsVtnG6rXoEeZM9fFyGAHalopOrlwfzbUcLdSzcfhkS/vO4qzsF0+axoiNbSdI6b5MVXvQfe7THvILB9RiyKLLirVw2iWOeUx4aFecdQtt3l1+FRybH0gFvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZP8IZsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZP8IZsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F89D1F000FF;
	Tue, 22 Sep 2026 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091366;
	bh=CDKexx37jAXrNP7BnDiKWoEg22oOEa5hWHG7yVEveSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PZP8IZsWbEcncGGvkRZujnpSZOVdibR+/a4YwM6skvbjhBsrD/uhL/UAGDQ01cAFy
	 e/Y4fz/sji55OD6KB2qnyo5Ix2e06Ne1mKX0NgGmBKYuD6X3WyLRjk98uHfTD2Uu6c
	 VaOjA99bZIJVhBbWbzL8Sga5WEcPDIuCB1WIxrlyJpYjf21Km3OFK/jm2Io6Uiakgq
	 xqoO93YfJVpU5lirBqRRTwW0Wxp4B7c6SaeJB9e9cdtJvEWTzhy0fnpwkHEpMCsMra
	 6DWzSqhm0tZKUDhRSpXrs5KCaY7ILBWsMtKeYjEMB5JA3eyWYd5kTAV/hDjaEPYu9e
	 EDilfbrOFcflw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongling Zeng <zenghongling@kylinos.cn>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] btrfs: take commit root semaphore when iterating in mark_block_group_to_copy()
Date: Tue, 22 Sep 2026 11:36:03 -0400
Message-ID: <20260922153604.2831837-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092246-darkened-imminent-3978@gregkh>
References: <2026092246-darkened-imminent-3978@gregkh>
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
index 9c856a73d5333..f9c43aadc78ad 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -520,6 +520,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	path->reada = READA_FORWARD;
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
+	path->need_commit_sem = 1;
 
 	key.objectid = src_dev->devid;
 	key.type = BTRFS_DEV_EXTENT_KEY;
-- 
2.53.0

