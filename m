Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94141F35E
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211827; cv=none; b=jSziGLadI4IWyHpiQJPiRSOlrnglbuC0g9gc1FaNapbkCmHVlLa31BRfEUD1tGYlzENf6NtxidwHdMNCf0cNE+rafhL4/4gRzs+sVkXxQXr75wpL47dsjxYX/HX5LGosoNdePm8gmqigPKHrVOtPGRrXPNOCePIyXhlqLrU9hOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211827; c=relaxed/simple;
	bh=fRQpleoHnzPrYs8791JeyOWgBUW7C10WcX/Jadt3k2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjnpKg/izjr0KB5n2DNefo4djXP5CUKaul5yLgFA6PqSIpqM+1VTIJjxYVGGYIklp/lpiblS85ruR1Ys0U6vVe/AgOpWDdn+QeAUy72ZMwc3Cj8UKF8wZDu8pR79Pqc35DCBXChMtv1labHlcHVGsn/FRrpBQHl9tMhShfFxdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUu8+n+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUu8+n+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDCA1F00899;
	Sat, 12 Sep 2026 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211826;
	bh=7VW2MUmfk55IBts0/QCFgtSxzdvf9A5dRSduwPQ9D6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QUu8+n+FHJoJOkMxTHr+i8gVuBqLXQlsYwcS7C93PBumt2GGvaY6rMMYLcvbKcJ+L
	 E4g3QBkSsjTiqv3ngkGU362lL8Y57IGqQRjoS5u1Jf4+Ph19ueyyKmZMF+US2xJrQv
	 lQdNT6A+OpIz4a/ROMsouEjrUcmJyWzo/TAy5llp0aBhzkwZJzMSS1vJ0TInRFnJ/0
	 8SDmXXBykdWvJVfC6jq4pUpmuejurWbe97x46JSG17nVCydUmXaQNZcPeaiW46av65
	 7BAYtWsZHWiUiH9EcTrHLw3a6Vq1G4lYp6FtnhbqMu9qS8vN3hMX6BugD2BMifNvEM
	 WKl39wpWI6Z8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] f2fs: fix to migrate all curseg types during free_segment_range
Date: Sat, 12 Sep 2026 07:17:02 -0400
Message-ID: <20260912111702.2280721-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111702.2280721-1-sashal@kernel.org>
References: <2026090947-hardwired-robust-7d28@gregkh>
 <20260912111702.2280721-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit 8ec06f50ddd8d201bd7e55b896ae28ed9d4cb7d1 ]

In free_segment_range(), the curseg evacuation loop only iterates up to
NR_CURSEG_PERSIST_TYPE (0..5), missing non-persistent in-memory curseg
types such as CURSEG_COLD_DATA_PINNED and CURSEG_ALL_DATA_ATGC.

Even though these in-memory curseg types are not saved in the on-disk
checkpoint header, they still occupy active physical segments at runtime.
If an active in-memory curseg happens to be allocated within the segment
range being truncated during filesystem shrink, failing to evacuate it
will cause subsequent writes to the curseg attempting out-of-bounds I/O
on the truncated storage range.

Fix this by expanding the curseg evacuation loop upper bound to
NR_CURSEG_TYPE to ensure all active curseg types are safely migrated
out of the target range.

Fixes: d0b9e42ab615 ("f2fs: introduce inmem curseg")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 56c72a8a82840..10cdb2c2c2d6c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1900,7 +1900,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
 		if (err)
 			goto out;
-- 
2.53.0

