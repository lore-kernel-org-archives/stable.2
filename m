Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8750EC1D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902360; cv=none; b=C+JC51NuAhkcLR0D6SdFQGeeGqZ4I1iJrOXHoHYK8qU08uUknJ21qUNNANHHZanDrcrhcvg21jjqtygv7vawsm8Qu0Y32F01pAllVgmmk+JYA8EGfao9gdKXhHOfJ8tRvY1eLn+W68LboePeCW2kx5fYv9HcxcpGn6+c0EyECAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902360; c=relaxed/simple;
	bh=B6DbRkS9LZsiRA9ySDjh+u53ZrPXN6R6EmcwtE9plpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+e9JGTJJD5Odo0oZ/lO0MFopAbiyUPELzddAZ73cUgp9GE7dhbmZ2xsSjwJVTR8GuP1d+Oxabky9t9Wwviffsu4iOHucGtY819qT5pc6tZXkRnkgziSrOVD96XZwNUn09fLgoMKpL7zgUP8Kf3kAiYrEc63002tBlN2x5LA1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k337GWn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k337GWn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A325D1F00893;
	Tue, 13 Oct 2026 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902359;
	bh=bLAmIYpxJzaJpHR7gJIXjGtsi5ecGslVso6QrcXsf+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k337GWn45StXefi53aFVr6U3d77ayrQYm4o+Ea8TVjN7MqYYMXSXzWzEXD23C8aMM
	 aa4m1G5S2aRDIF4imz8dBm06q9JaqZ0ldTla4EAXBxj91sRU0ks2IZitJHa6ErCzSa
	 X5Xvhi6+jgSUI717nDMK1XjzGfefY4S75A1uTgD5p93iJwa89QBDeLjGZ3HOzhEgDr
	 Z3mXE6rfwSnNIFytlN8r+fTq2McneLcj0Orpdx5gyVq0tECE3U+NQt6SokRGycAx8/
	 mfrxxFo0yrltfR5OHcyrEcvLXNuKCIvhvaiK6TR4pXzVnRvuEBr8YdUq8hcDH7KDIH
	 P1Gyg/C1c0+IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ben Cressey <ben@cressey.dev>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] dm-integrity: fix buffer overflow in inline mode with large tag size
Date: Tue, 13 Oct 2026 10:39:16 -0400
Message-ID: <20261013143848.4044801-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013143848.4044801-1-sashal@kernel.org>
References: <2026101250-why-icon-9fa2@gregkh>
 <20261013143848.4044801-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Cressey <ben@cressey.dev>

[ Upstream commit 764b683a6180fd72c931c13fea98d383506a3475 ]

In inline mode, dm_integrity_check and dm_integrity_inline_recheck
compute the checksum of each block into an on-stack buffer of
HASH_MAX_DIGESTSIZE bytes. integrity_sector_checksum pads its result
with zeroes up to the tag size, so if the tag size is larger than
HASH_MAX_DIGESTSIZE, the padding runs past the end of the buffer. With
CONFIG_STACKPROTECTOR the kernel panics in dm_integrity_check on the
first read.

Enlarge both buffers to hold MAX_TAG_SIZE bytes, as commit b93b6643e9b5
("dm integrity: fix a crash with unusually large tag size") did for
integrity_metadata.

Note that this is not a security bug because the buffer overflow can only
be triggered by root.

Fixes: fb0987682c62 ("dm-integrity: introduce the Inline mode")
Cc: stable@vger.kernel.org
Signed-off-by: Ben Cressey <ben@cressey.dev>
Assisted-by: LLM
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ sashal: Adapted the dm_integrity_check() hunk to the existing verification loop in dm_integrity_end_io(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index bdc83a5f583b9..e43892d1619db 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2548,7 +2548,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 	outgoing_data = dio->integrity_payload + PAGE_SIZE;
 
 	while (dio->bio_details.bi_iter.bi_size) {
-		char digest[HASH_MAX_DIGESTSIZE];
+		char digest[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 		int r;
 		struct bio_integrity_payload *bip;
 		struct bio_vec bv;
@@ -2626,7 +2626,7 @@ static int dm_integrity_end_io(struct dm_target *ti, struct bio *bio, blk_status
 			    unlikely(dio->integrity_range_locked))
 				goto skip_check;
 			while (dio->bio_details.bi_iter.bi_size) {
-				char digest[HASH_MAX_DIGESTSIZE];
+				char digest[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 				struct bio_vec bv = bio_iter_iovec(bio, dio->bio_details.bi_iter);
 				char *mem = bvec_kmap_local(&bv);
 				//memset(mem, 0xff, ic->sectors_per_block << SECTOR_SHIFT);
-- 
2.53.0

