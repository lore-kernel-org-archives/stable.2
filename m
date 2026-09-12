Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AAC472777
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212090; cv=none; b=siJo2EQURlZOCQq/TNscMXhSKhzLXHxEkRiVHpmQTcq2tk0filWXVoCnQ23ADMSQOYCV1YFAo1MRzURCNNDoG6qWGuXYg8yrN0ciDWUUSe/h/Wf8FHIVDuXfd21JR1rOAJuTuJieHHb+CPBY6nz9HrqZMt12Sqwp2S4ADmbS5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212090; c=relaxed/simple;
	bh=y+u89lYzZkJPb2u/n8acP4pCFbpWmQfcUjn1vQ6NOrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF5IB/M9iPQ1Q7qGlrHA3/z/Sfk+3IbiMZA55MTxVlS9ji/XYxyox0ibMXqdNoEU+4wtMbhIOKh8zVMnosNuHCLYTceDZG+/DtqlOgaue977aDGY6t/v4dy8knQy3LG1wTRwDKYWJ+hKdnEttk293UAe/fNY4nsaDYXIAwXKSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdXeafjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdXeafjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0E61F00898;
	Sat, 12 Sep 2026 11:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212089;
	bh=RrMy3aRra2f0lMvgUSxiHcLsMOfSVURFoo1iYSF0iE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kdXeafjr+B8MQ1vbmCVDk2K2aUuensYjWOqHxyhmNpO262eTYT0ot2WkXBydzXl90
	 xWcp0AEI2go9oITlaFrLvyegsVTaYJ8reBTGa6nKfW9x+XEsHfUFqNWjJJSRiRy3qd
	 jsz2CUAwoGswf6/wwJM924MB0cIyThNp66F3RR+A5AlHxSgPsgqGNhH/zeY9gf3p5M
	 2se1gZ5WiSsWcZklxRC/flv6+bhpY3IJXzYD0o6Kb9oTSMF2UcnfHqTow5xc5uwuXS
	 r0CJa6CJGES6v8575OQwY9hgSDFomEtnX7yHw3eSKUPWgT2KOrmE62HxhmpaW8E+sI
	 P/NU281lfWtjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] f2fs: fix to clear dirty flag on folio in error path
Date: Sat, 12 Sep 2026 07:21:26 -0400
Message-ID: <20260912112126.2312794-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912112126.2312794-1-sashal@kernel.org>
References: <2026090930-scallion-geometry-8ab1@gregkh>
 <20260912112126.2312794-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8099e56e7ac22..95992a0aa1146 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1492,7 +1492,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (!err)
 		return folio;
 out_err:
-	folio_clear_uptodate(folio);
+	clear_node_folio_dirty(folio);
 out_put_err:
 	/* ENOENT comes from read_node_folio which is not an error. */
 	if (err != -ENOENT)
-- 
2.53.0

