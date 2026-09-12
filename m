Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B430DEA3
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222862; cv=none; b=P8yrLsJ0qcumQ98rpjdBCW2rGiCz9nCds98fOHvkpX+v3geVyv7n80o5blcyWMTLggHaxyuLihqi8CJKtIAkOdCtDbYqVvvwQ1QZIjVUGXe0WqeOPNo76nM6qPhI6BrnWQI2D91Bp4r7y8ES5aWpsKN4BGSWQLHWq3maEqG+Arc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222862; c=relaxed/simple;
	bh=MmGBK+k+HW+uteBy2TuFQkgfykdq+P4uDQquLujYEvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYX0omaF1TI4Y6v/vxAeWnCX5MjfdLNpJp98ZO6DobdFGRwCAAnte/Pb9ncz0jJWsjdi+wQ3/N9gpBGoQdJx1d5ehZSkOx6iCx7r7NB8RYnzbpN4nmm7Gy2JF+/QJRiAhiYXI9q6a3F16bsvBALyXh5w44cCAkKCmE/nNpo+7xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk0Ii/7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk0Ii/7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227471F00899;
	Sat, 12 Sep 2026 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222860;
	bh=m5LzDGTas821E5iMnjCKuLNrTOgfmwXhfCV/Js2THOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mk0Ii/7TwHQvmRENogkV8C/WKn6U6+RpVp+tZ89OzGuYE/GeXlffeL0i0esdCNZDD
	 l8cHVXu67gGE+I3oR9nBDWi8eSDzhGFUAUswNRYiy2HK0cb0XVjwSrKhoXf8645ffE
	 8rQovi/nssF5WIAK8MNnoH+auqUI7Kxaabx+hciLvQR9HypHsvQiZdtl22TlBvuZcc
	 sCtUm3armQeT68RFcLMX3gOYeLsxvyDXoqGtQUGU89V683W1lIMLcF0ql8y6D3ymjB
	 hVV/PnxEq1UpSViVgWCMTcZrjYEW9bgMp+tZLsQYx7ubSrmIrqlxF0xE6+jk6+/AYD
	 DdBYEHGqI5NxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] f2fs: fix to reset all pinned status during fggc
Date: Sat, 12 Sep 2026 10:20:57 -0400
Message-ID: <20260912142057.2913172-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912142057.2913172-1-sashal@kernel.org>
References: <2026090945-delicacy-nutmeg-a9dc@gregkh>
 <20260912142057.2913172-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 ]

Otherwise, the pinned status may affect latter flow of fggc.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f6ae5b086f44d..8759f0e013fe6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2060,6 +2060,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 						dry_run_sections == 0);
 		put_gc_inode(&gc_list);
 
+		/* reset all pinned status during fggc */
+		f2fs_unpin_all_sections(sbi, true);
+
 		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
 			return -EAGAIN;
 		}
-- 
2.53.0

