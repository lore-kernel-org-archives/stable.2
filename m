Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E592EC090
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 03:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259059; cv=none; b=E5EXIcw02ko5Bta8F+RiA5XnvRNsOEzLclUqISzGhZpzuCKwCf1j+XPeH9fogMMxXjAetYfcvxmxbL69wJLrP4fhUSOVvj8qSyJ5uAVPh6kNR41J5xv149Jth4Xl+t6LXx5r175aLSkcPY76G1ZoV0Gftkw34gHtwQeTV45vfwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259059; c=relaxed/simple;
	bh=AKFO+6kMRIf999SHyvoUrdjxxCfFmmXdHeh9Zljcz8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xu3RkujDbBdlwt7ENTb/BGW+6WpQ0+UHEUExWww/XUIKMwWMYxuNnToxlCKAWFzbfLE5zotjmX8lHWtNvCGK3r5BIy/D8YgD1wF+5BVUn4uB7O2DG2i/PnODhLYNNQSj0S1D6R+d4XckXhKpwhREuAHl9zzPwLH1QQW3vH4YKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=A/TeS+UP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="A/TeS+UP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38759bcd877so464161a91.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791259056; x=1791863856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FIg2j8cR5l8EWHD0aFToxc23c2wafCfRdD264dRHKCg=;
        b=A/TeS+UPM7Hf6RVDsa6bMDIVInNY/OFvGiGMCyc/V8mzMOsZMJNDZhLqy7nhZ8jJ51
         cse1/L0bshLdtxVk0IG11eJSwm6VuMaM28U2klq0L9gR60tarieqrqZ6f2YhzjZ64gF/
         smYqw6yQ9U++fGglI6kxfBy+Vc/xNwbV39CwR/HiVuTiYt7fdbnvbuSjHcSXwSkgGmG6
         fd6J7ltLV6jarhA8c6M56S2D7oIe5zzyRID6LLQMWxU/fEZK5jWFaGIcIQ1umZNqyPlk
         zUT03frKTf5Q1V/xepxwYE8Lu53Ln2gAiusd5GjabK34jsZpZq56MjhNCbQFLvcNfvgk
         FHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791259056; x=1791863856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIg2j8cR5l8EWHD0aFToxc23c2wafCfRdD264dRHKCg=;
        b=THqa2qDJqphYmrt8wjB+86225QxFaM6GAA7Y1K5Y0JoDqoo2Y/mkw3AYe2Pg/bVD7S
         wQXiycPUxTcqF+dpRKegBUIc+QKiI2LB/EVeAaOAIo9G1O6eRcXCEML2450Fu+/TOqqX
         VqP0ufYYH3ckRIZGmJ7H7LjziNi2PJ0LvxE7DmaYfbd4G3X34nqlsTrU69ecbQMkr3OX
         rY31X7LAX4iSf2v7rBf/ML+QV6LG7z9CQaqsh6KWSKAGbTHgwR0AZolc5Gv+OI8ExNIP
         ixAFrDaVQnPpPYOcWXzD2OZIA2+OzeDmWjg1+P49SgXvr2aEnJMiAkUw3gBtU+nk7jd0
         UOzA==
X-Forwarded-Encrypted: i=1; AKwUvBxPhrjXYVGxgx8qhQztquBdAxb3ZvjN06mGcbnkySJ21Nh1Ke09NEsXY7dXM8ZzIicXALNrnkY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVieBAeA+wMS15st5zRCK1lBD7q/vvCdVtsUkaI+G5ECNcKwyl
	Vp4W8z1BI/mgbBkTy5RlHvgpDdhMJ8+HN0PhXREbx2l0sNmO2hAdi6nIli55vJZNUgrRgdV6NMI
	Dqlza7+U=
X-Gm-Gg: AYBFou1lykNZZkX2wiYjr+ZhXFSYWzznLpAlqZ6mJHzk//DZ0B0oBizb0Vd/9BtG02N
	7uiZMBFyWb5U3PYpb+sxvz4QEbijPUO40+2ws6cPbsJdyDETAB1Su+3rW02Z0/wEVX6Wkj/hl9q
	MdGCaOLBt3p9h7jzSUQKXfGkMEokjU/Xs+2b4Zb3Zi96c6zVRNXKgYcfi8RtJuH+GOHGi/pajM4
	wtoK78GxRxergDfKShYAETet4gmmmAVZoh37RdYRFNkC6Qc2bBaKBqjWp5HBiS/umSp9CupuDtk
	Tv4RgjLHaBxVKkZkK8Oaj3pxC6BcvLugY/MlAbyBf1NHUF8oL3Em54Nps2UglWMihJpxf8iZ/hl
	Al6B0u7YHjiQB3LZxjMrsMbVmZX633zl145zSGQ4o1upvGPmdALWLhiBaIR6d74wCKpK6f/29Oq
	fJHVugBS043GBdA3CnUYF2gjl4lg7uNtJX03J9tHO00NIdN6kWZy1PUdncETiMNDy2wZ6VXy4in
	DCvOBQUmRA+D/9QExWcfA==
X-Received: by 2002:a17:90b:3d43:b0:3a0:7591:ad7a with SMTP id 98e67ed59e1d1-3a8726b57a2mr111120a91.5.1791259055781;
        Mon, 05 Oct 2026 20:57:35 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:5364:bba9:2adf:d611])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853e66d7fsm2543601a91.5.2026.10.05.20.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 20:57:35 -0700 (PDT)
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
Subject: [PATCH] drbd: reject an out-of-range offset when decoding a compressed bitmap
Date: Tue,  6 Oct 2026 12:57:13 +0900
Message-ID: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
accumulates the bit position s across the runs.  The upper bound
(e >= c->bm_bits) is only checked in the branch taken for a set-bits
(toggle) run, so a clear run advances s with no check at all.  A peer can
make s run past the bitmap with a single run; it is stored in
c->bit_offset unvalidated, recv_bm_rle_bits() returns "not done"
(s != c->bm_bits), and receive_bitmap() goes on to the next packet.

The following plain P_BITMAP packet computes c->bm_words - c->word_offset,
which underflows once word_offset is past bm_words, and drbd_bm_merge_lel()
turns the result into an out-of-range word offset.  drbd_bm_merge_lel()
only WARN_ON()s that and proceeds into bm_word_to_page_idx(), which
BUG_ON()s on the out-of-range page index.  A malicious or buggy peer can
thus panic the node with a crafted bitmap during the bitmap exchange.

Reject a decoded offset that is past the bitmap.  s == c->bm_bits is the
normal end-of-bitmap signal and must still be accepted, so bound with '>'.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/block/drbd/drbd_receiver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a85..b3da2bcb646a7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4559,6 +4559,11 @@ recv_bm_rle_bits(struct drbd_peer_device *peer_device,
 		have += bits;
 	}
 
+	if (s > c->bm_bits) {
+		drbd_err(peer_device, "bitmap overflow (s:%lu) while decoding bm RLE packet\n", s);
+		return -EIO;
+	}
+
 	c->bit_offset = s;
 	bm_xfer_ctx_bit_to_word_offset(c);
 
-- 
2.43.0

