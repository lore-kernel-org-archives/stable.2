Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3737246EC95
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296127; cv=none; b=ul1yOqZ2bIWFjvTDEzKyiiAf1FYe0SY4p1SEw+n6en2quc69Z0GwFXV4mDbRiPli2VdPh8G/roCvDvb+CrwM8OgnhSczHIOvL9aoN00gtgRF9sXkW726GVVjVMoux+MT04P0d3ffyJpoT2D01vrHwridtIago1MMy24tgbbL6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296127; c=relaxed/simple;
	bh=3twLCOUVctvgm+7HXE5YvCiR9KmGS4GbaF3cOWVcIN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2GctcaILIcpoLZKXkc26qosDpTpR7F6SV9EvUEfREeMzCwDDhT0qsCi7rZrYDU/PdoZtqSkjjSUEs0eCJeyHxKZ8YOcUdXosdrw22m1Th8/MMNpHoEnVj+0SWx7U5v+swsF1VIFMQlAKM6T4hq1Dwv+tIdpcvwSHZivaMx4yAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=G7RLSNBO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="G7RLSNBO"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so586155a91.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791296123; x=1791900923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5d+qEg9Unyo+IXTg1hjwRDAAFeW42uTSWnzee3KFft8=;
        b=G7RLSNBOyl7q6oJ5DCDgFc20nYvj+MuWuWqvWLXjPvhI+jQ9v4a4BfNd0oJ6nOlB5a
         dWKMPgiBndfBGXUcoFeXreslawCRgRRPu7c2oNc776W47h3FYjxmyQLfLcwkHQ5ZqIZy
         rxVHW3ZiaBwUDiCmz/pJamWSiNcdLBVabaW49ZgnXrgZtosyZ7jyHRQQwX2qxfla/4LF
         PXrNib9ED3+y1w7ZxBHPFECdCiZXYFHzKk4iRMJHw3H3mdlJj+j5IR891OWhUm7MYfUq
         OmhAcfw66GqiZ5haQwMFYnB73gEVTehC6XPdxE6sLg52kbCmtdO9Ii7QH2U8ZlxWgs8Z
         DAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791296123; x=1791900923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5d+qEg9Unyo+IXTg1hjwRDAAFeW42uTSWnzee3KFft8=;
        b=aTpmd2XEX2zHRpr7low6WrpzR4OOtRa35+3HKMWf9yFoTOt8PzO6V82V77NBJnMnDo
         j7AO97qmFUWyUukts0ZKtjGETLcCLQXdUkz4x/cQmFFMtssRVmgHM2hBk6vxsX3hjfxC
         UwrH9eyuxglcfEgmRD4/rTV2iQ0f4QsxIDqDKWVDP1CF/TallnLHgq1lzEGal4ffXNM9
         l837HVHEir6NUOntyVoRmSiTldTGq+9aLX0vFj661BEOxQyhjBQ1d+jRuF9eNrRrRsZH
         GNHezp1HMapOGMM2WyQWzVGaqpNNk1H5vYBboi1JPYcSW+0VyezbWuHfQfmn77DU4ufi
         /D/A==
X-Forwarded-Encrypted: i=1; AKwUvBymo08V1nZP3Ac9TSxqgX7VnrG7zfd532tVS0vEN0PFxrBWMJjNgCgEmxuzqUKs4pBcsCObOVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6M7YtIgglSGysGbGCMbYFKs7Koen4XlEmhReDOMDoVuOJ4QdY
	zd3dDaeQmG8ceHCeEY3NkAdd6hr1YJCJJuzVXjh39VNAhpmasdnLHi8f8ghewzXeh9o=
X-Gm-Gg: AYBFou12Df1G7ydUocAp+l0IAtpx96uNfXGMdJBR+J+lzQM/eKHIzR7KT9XcrinVU+W
	jRmbYNfiq8McEcdAbNwn9igmX9mPd9hNXEfNIXhsc7H7m6mnJgdz417jzR6O0nvBR7I2UcuDO+B
	R19az3R6Zyoc9rjqIs5dLRA0dr6B2byL5w9ur2wKyOgFoljxTKP6Y3cPdhgFLc+yo4cAerWFaEA
	qSSN9sfCIyRoFfFfJq1zJhXk/aRRXS9Ib5/T0qQN33OlP9vWBxREGHTdrkffWa3xw8kl81+gDq8
	bVbgBHuE8diN0vUXUvy5GKmJQSc9DQQGr9CrAtqCS62XzYx/yh1SwAdJBomWeWG0P8bv6u6JMWF
	vybettQw56NHxNv3rDFTSYvgLW8Qj0N4XSYKgoR0noajPljF4hL8L6aRD03Q75Kymp332loyHBx
	kdECXC7/knZwZAttjmsAn8qrz/b68dXqkLeqB5mvWZ7ZS3l5n3oGjIiZ7pW4DTdTBvA+bo3RA57
	h9qeWQ5YX65mjl6PtUbPw==
X-Received: by 2002:a17:90b:4b04:b0:3a8:5543:5572 with SMTP id 98e67ed59e1d1-3a872551602mr689793a91.1.1791296123414;
        Tue, 06 Oct 2026 07:15:23 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:a229:268f:9226:1ba3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533aba95sm5917618a91.2.2026.10.06.07.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:15:22 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2] drbd: reject an out-of-range offset when decoding a compressed bitmap
Date: Tue,  6 Oct 2026 23:15:07 +0900
Message-ID: <20261006141509.521128-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
accumulates the bit position s across the runs.  The bound was only
applied where bits are actually set: a clear run advanced s with no check
at all, so a peer could leave c->bit_offset past the end of the bitmap
once the bitstream ran out mid-sequence.  receive_bitmap() then carries
that offset into the next packet, where the plain-bitmap path computes
c->bm_words - c->word_offset, underflows it, and hands the result to
drbd_bm_merge_lel(), which only WARN_ON()s an out-of-range word offset
before reaching bm_word_to_page_idx() and its BUG_ON().

Check each run against the remaining bitmap before advancing s.  A single
VLI code decodes to a run length of up to about 2^56, so checking after
the loop would leave s free to move far out of range (and in principle to
wrap) in the middle of the sequence; bounding every run instead keeps
s <= c->bm_bits as an invariant, which also means c->bm_bits - s cannot
underflow.  The set-run bound becomes redundant once that holds --
e >= c->bm_bits is exactly rl > c->bm_bits - s -- so drop it rather than
leave a check that can no longer fire.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Suggested-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: per Philipp Reisner's review -- check each run before advancing s so
    s stays <= c->bm_bits throughout (a single VLI run can be ~2^56),
    instead of only after the loop.  The set-run bound is then redundant
    and is dropped.
v1: https://lore.kernel.org/all/20261006034333.351130-1-yhlee@isslab.korea.ac.kr/

 drivers/block/drbd/drbd_receiver.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a85..1febb5e089cc1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4529,12 +4529,19 @@ recv_bm_rle_bits(struct drbd_peer_device *peer_device,
 		if (bits <= 0)
 			return -EIO;
 
+		/*
+		 * A single run can be up to about 2^56, so check it before
+		 * advancing s: that keeps s <= c->bm_bits throughout and
+		 * leaves no way for s to wrap in the middle of the loop.
+		 */
+		if (rl > c->bm_bits - s) {
+			drbd_err(peer_device, "bitmap overflow (s:%lu rl:%llu) while decoding bm RLE packet\n",
+				 s, (unsigned long long)rl);
+			return -EIO;
+		}
+
 		if (toggle) {
 			e = s + rl -1;
-			if (e >= c->bm_bits) {
-				drbd_err(peer_device, "bitmap overflow (e:%lu) while decoding bm RLE packet\n", e);
-				return -EIO;
-			}
 			_drbd_bm_set_bits(peer_device->device, s, e);
 		}
 
-- 
2.43.0

