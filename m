Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5053D0A8
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090569; cv=none; b=bf+x8TGyo+Z1Fi+CQ6eoaKSoQ9rsyQeopLlcDaZh+clh5kOiXqenwSaKRSu0NXqkBQwEFjBs7VUNUx+YA7R3CaetqJMv9RAwF6M8Sb41wpkztcQlmB8/IKDCIbPAqCH2+d1YyKYBX+5lR/xbadn2OzaEV0tI7yxOwFURi/7ZQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090569; c=relaxed/simple;
	bh=pwAvOPxJsf7rgddlQMOqth0do3LnlrYTlXSAkynmLeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXsBzY1cBHudCFf3nNZ1JW3arU62j8/Mqwr3av8iFbq/mQbVxM9wXdd3pnbTq2koxmsCMq29Jtv1NUMcqv0evEwCcOg12krcJHO2EkGGsQjkZTM9wdDuv1myuFADWy8NLrQvrzwGkukSsptxG0c25yf4SaiqdEkC4nhT84hhNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJWdY5b2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJWdY5b2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997E01F000FF;
	Tue, 22 Sep 2026 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090568;
	bh=cYS3T4uV6l6uhGAQxSiOnK9cZ99MAmMXnL9dIfJO8o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KJWdY5b2Io7GN7Zo+XT13fnme+Lv510HyufeOGzl/n3CqFchx6Ws7IvBgrpmAnjbZ
	 tDeFRSV4CZ5/DUrwetymogDfQVAaiz4pFjg8cX+teJckZ/aNNULP/9Q8yApqEXNgKH
	 rwK5GU/v11uw01ZIr1SwHBsbEi8InI8sWwnYYxqMlJQLCazvUKrPW+wANgtfv5qiT4
	 RHN4pxEdcXbk480DNJgh8NZNExboqqSdQ1k6a0+Z80ilNGsxg2bHKCjLQV4L/xeH6X
	 tm6HOJpEZShLTMc5zpECEOclyLCfJ7Hk4XReu+VIux5He66u5bqCqj3K7+e6uoSefM
	 S7Zkd6Bsd3DCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongling Zeng <zenghongling@kylinos.cn>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] btrfs: take commit root semaphore when iterating in mark_block_group_to_copy()
Date: Tue, 22 Sep 2026 11:22:46 -0400
Message-ID: <20260922152246.2799800-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092245-unlovely-antarctic-7c00@gregkh>
References: <2026092245-unlovely-antarctic-7c00@gregkh>
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
index 604399e59a3d1..bc05a5d23dafa 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -505,6 +505,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	path->reada = READA_FORWARD;
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
+	path->need_commit_sem = 1;
 
 	key.objectid = src_dev->devid;
 	key.type = BTRFS_DEV_EXTENT_KEY;
-- 
2.53.0

