Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2737A498
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212088; cv=none; b=Oo9rMTt27V5uDIn/MUn/Xy6iQx+2rIhvwNXFZ+V1+u6l+UTCCUvr2eS2o3CxEfJYRKsEFNHw58oJze+yBvw0On1vDRw1n2YoQjLCLNRAv5L7QXlkjecbq0ZwABYUMo4ksteDmFpVhR7vUd4H5Ec5yF/cSs8U2gPGz81N/jhfy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212088; c=relaxed/simple;
	bh=ifiXzJsJZ6dkGXysA/iuFzDzvzdnHyok2r5J+063ueQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ohd4mVagcJ0nj49CiJS+kjz06TyGvSQKJBNqsy5e3CQ/+urMD4Wn7nkd061+RlrE3xkegC83IXfPsNwra5lstjVq4SZ0B8G3g5ODYr0jYb9Qw4KBVjCLljnyt4i5Xk73yZSHaz8VfuTO7KQNo6745LsTcWr25FFihw1j4FWmLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux1oHJDG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux1oHJDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EB81F0089B;
	Sat, 12 Sep 2026 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212087;
	bh=GNDmbIu4+PNBwM+6EJXbV2E232Pps/aHoCSkV9O4iGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ux1oHJDGFqwUvkC984wDEO4ktW2mQtWymKbjG16FqHhdo5Kr/zVgwXRiWlL9O5zgy
	 hA5ec2ilm+e0XBjoHECeS06L9Gyww7aAvtbpBjAoHeDhGlUnRJKReCVc/GeudBeyL5
	 QwnNQ+eCCQ2vqFxejtTSO7MTFQ7uitJ0868p1rdOSaIt8EroKl+EfsjsrXqA/qmBez
	 ULvAukfz4R265tVA8SzsgfZs2Os8hm1hJEGjrCQNgtYe8PBYNIjYuOGshpRsHJuwUt
	 LlTL2yAZ6WSAZ+WaXoyJ8MLcwmp+MJ7ImrXh0cermnQlqOiChpVXrOV2n8gh/2XVBX
	 /XP+9OVOz3rdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] f2fs: fix to migrate all curseg types during free_segment_range
Date: Sat, 12 Sep 2026 07:21:23 -0400
Message-ID: <20260912112123.2312505-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912112123.2312505-1-sashal@kernel.org>
References: <2026090947-bankable-stroller-237b@gregkh>
 <20260912112123.2312505-1-sashal@kernel.org>
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
index 33a2079b77c2b..d090ddc4be755 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1877,7 +1877,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
 		if (err)
 			goto out;
-- 
2.53.0

