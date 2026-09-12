Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AF3DB31A
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789215800; cv=none; b=BBeOcGuqWIo/VAqjjrSOyFuQEmMIlm03OqOw8ZVYrQJqoWujvFe35iIrSFOBKKCx2uh3uOmahCc8C3kaJlKaXCLntKR1umLekujuvxN2FNIcaSMvwfYMkYX2Qbktn0FfNTRAL9qwlNbRfJ0NkrrIOGs/OvKS4hypILe/xJCBxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789215800; c=relaxed/simple;
	bh=5t2Ji3PVnr7oqYz7j0Uz/Y7UGS5MkKBxEZr0G0AHak8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGchEdUMstHMYUEZbr36JSVUk+YEOniVGPOMTAIxkz0Ap0Re4GBoYEJxcw2dAGStV0GTipwxAjKeZW/v4IIlz7ucRzG4hT16Y8xxafWb8EWEZwkp3MQNLc+LS1Y9dcGpEGCm3EWKWt81rFYeda3QbcANxnA9f5LJT9CQCA2l/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgAsgYnw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgAsgYnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED2E1F00893;
	Sat, 12 Sep 2026 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789215798;
	bh=LVhrnmXdblqjRtAyxWIWEf7kmXieSYq1zvP2Y0JiC6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgAsgYnw4enMdHXSd2ksswYRUuwdHaSeCfF40sFOytfo9NWADaH5NznchfdPsre1W
	 lqElR8U6le4MqzQDO9V7R3rccWIv/cUydYqNF5RqfnOyZx/9K2RvqSSdTdHBJ3IlCA
	 l5xKh4goxKKT5sQP4pjLVzc5UxP1Dk/dGY9XPW8IATM5Gq/m4smtG+MM13ZA7tnS+l
	 JNPMCCMnixpvUDCzAZ0N7phMMdq4N2m/fs9ILANlMKRTDSJ/VezOBkBnlyTZUarZDd
	 xPRaVBSkhBvGRW8/xECPxPsoA1e8uA+BofvhGB0IsxLL2NBetMlUWD4tfrirIAsAWf
	 4hXd8kI+C+BZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix to clear dirty flag on folio in error path
Date: Sat, 12 Sep 2026 08:23:16 -0400
Message-ID: <20260912122316.2591560-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090931-unpack-bankroll-095f@gregkh>
References: <2026090931-unpack-bankroll-095f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 5b86eab84ac8e9289b5afc52ef88ab18ba5bacab ]

If node block is corrupted due to chksum mismatch or inconsistent
footer info, it needs to drop clear flag of node folio, in order
to persist inconsistent node data to storage.

Cc: stable@kernel.org
Fixes: b42b179bda9f ("f2fs: fix to do checksum even if inode page is uptodate")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Changed clear_node_folio_dirty(folio) to clear_node_page_dirty(page) for the older page-based API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e5a06a65a5398..667a8def8b305 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1473,7 +1473,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		err = -EINVAL;
 out_err:
-		ClearPageUptodate(page);
+		clear_node_page_dirty(page);
 		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
 	}
-- 
2.53.0

