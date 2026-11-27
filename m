Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777004;
	b=gJ0gy6lZHiaEWwRZkO7iNm9n0P3uL8KMqXgKKBZ62tPVTVg5AwbzkZ2HHvJ1kwyOiU2T
	 pkLNF5JDuhjugoemXoreACwhgdvaHSIiIRjXLOix/CnyKaMzZhM8Hr6gu3DH3lPragIWZ
	 Kly2NuzdAzhjj7Dws3NHQcia0MOR5WeqE9Mk+35+vGPI7QrxE0XgI3nO4hK+EiIJBZUl0
	 Fn5orVxmrOeJf/2gcvOH79m132aA5NDhF3MyZXVaaJG7a+tqPAbrzNwegvRqtKHpOZSpm
	 N7p4ZwuoxZ9NrwBNaEZBzIcTkBSTCmG2stcoDIcQL4Tc8jidJPelHGeF1MKamL/LkwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777004;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ixpJ8FVsaUtzbYGvKZMv3iePyio0tQ1UpoRhwVro58s=;
	b=I3cbhl2IIleW68M6KqPUcifeXFrfAsBQQ+udM63toZLd+y+otcGpjoQn7cp8iJMCfoJp
	 XwBwLp4jgO6k55ayzNYHROcFm6EbV536t+DOd7MwlbEjaKBEvSp2UA+W9wJIj+P9ivbGO
	 oiqk74gu77Pmdq+D1PKt59jwbAbwB9TNCgYGj7kFjtXw5lMuHFXf6gHMFaVEik2g9/90q
	 j7amZid6ep1VZWN6OpuEyR4mGoMcYrtPMkgriYff/6rUgpzWAZjpPfeb0zIxpsDBZtkYH
	 jE4WmE/qFCS6M7b1aLc3I027e6yLe3nrMRr0bLoOLqN7lBDw4JiWLP4HVbUIgL0AHtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dV7E1/xo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C11606A327;
	Fri, 27 Nov 2026 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dV7E1/xo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6BB1F00898;
	Fri, 27 Nov 2026 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795777003;
	bh=ixpJ8FVsaUtzbYGvKZMv3iePyio0tQ1UpoRhwVro58s=;
	h=From:To:Cc:Subject:Date;
	b=dV7E1/xohDKd6dZZp3jQtSYpClT4BgLczWrsqp2uTk90zW4T9rl7RjRRbdBWS3dbb
	 foptU5l3/U2XrmTRXAM2VWlN8LLDFQGfBkRxzlZ1RthW2PGE8oWXXhtQaFJ8LeSBuq
	 wiq89m6iKeoql26dWs8Kz+CxfWTCCGHMMf9tHfbsFp4/zhaVVTxAufKEE2x8po9MyJ
	 AxhYnLOsZFDVFHCpnkLdMm+kg39NWhUGtA1/lsuZ4YFhvjSjHtcHEs+1nKQ2ptpRbN
	 x6Y+uBqBpt/ux2Vvj9tGAWBhVT9xPG0wQBuj1PfCotveI2I/FY39Gt5cvYrCKSMzFL
	 QzZlE60psmvAw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] f2fs: fix to account entry_cnt for all write bios
Date: Fri, 27 Nov 2026 10:56:41 +0000
Message-ID: <20261127105640.537608-4-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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

From: Chao Yu <chao@kernel.org>

Commit f32744a8b83d ("f2fs: introduce max_atc_write_bio_entry_cnt")
tracks the number of entries queued to a write bio via entry_cnt, so
that f2fs_write_end_io() can offload the completion of a write bio with
too many entries to sbi->wq if it is called in atomic context.

However, entry_cnt is only increased in f2fs_submit_page_write() and
f2fs_submit_cache_write(), it misses below write paths:
- f2fs_submit_page_bio(): single folio write bio.
- add_bio_entry(): the first folio of an IPU write bio.
- add_ipu_page(): folios merged into an IPU write bio.

So entry_cnt of these bios is less than the actual number of folios,
and a merged IPU write bio, which may contain up to BIO_MAX_VECS folios,
will never be offloaded to sbi->wq, then it may be completed in atomic
context with high latency. Let's fix to account entry_cnt in all above
paths.

Cc: stable@vger.kernel.org
Fixes: f32744a8b83d ("f2fs: introduce max_atc_write_bio_entry_cnt")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase to the latest dev-test branch, which supports subpage block,
  no logic change.

 fs/f2fs/data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdc9e6e8633c..6be0cadc511e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -959,6 +959,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 			fio_lblk, fio, GFP_NOIO);
 	bio_add_folio_nofail(bio, data_folio, bio_len, bio_offset);
 
+	if (!is_read_io(fio->op))
+		F2FS_BIO(bio)->entry_cnt++;
+
 	if (fio->io_wbc && !is_read_io(fio->op))
 		wbc_account_cgroup_owner(fio->io_wbc, fio_folio, bio_len);
 
@@ -1030,6 +1033,7 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
 	bio_get(bio);
 
 	bio_add_folio_nofail(bio, folio, len, offset);
+	F2FS_BIO(bio)->entry_cnt++;
 
 	f2fs_down_write(&io->bio_list_lock);
 	list_add_tail(&be->list, &io->bio_list);
@@ -1077,6 +1081,7 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 					fio_folio->mapping->host,
 					fio_lblk, fio) &&
 			    bio_add_folio(*bio, folio, bio_len, bio_offset)) {
+				F2FS_BIO(*bio)->entry_cnt++;
 				ret = 0;
 				break;
 			}

base-commit: 9ad6c58bfbe5882b1aa0cbe2393dbfca89d2c199
prerequisite-patch-id: 23bb28339e4f35a111279d46493ac1e04fc66d58
prerequisite-patch-id: aaf2ca8ae4a7422c58daa02714ad9a5b4578bccc
prerequisite-patch-id: 207a76a8bede95d1b0ec30dc2323963da5f6ff3f
prerequisite-patch-id: baa9eb03ece0f1f0155a2226b99946327ceb3e33
prerequisite-patch-id: 1eca125a4d02fba284eaad33e37de978ec89a7d0
prerequisite-patch-id: b4566514d95142b9291270f2b64205f69c9b6edc
prerequisite-patch-id: b8f7552919f622aedea1b119674eec9cc93d8671
-- 
2.49.0

