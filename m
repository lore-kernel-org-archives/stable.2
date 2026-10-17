Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492403E49F7;
	Sat, 17 Oct 2026 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223046; cv=none; b=VcOAwBnAYNZJCPi/U1dTvcKEDcQpggKjo85O2uY+CzYAVakzJCRFcEtemdGND6K00uf+D/HAr/NwYjkHwN/Jpi7YyvbKzKOuljPovdld0egQybEyulZOzjpFShwqtdGnjAr3TTmI5mY3tLy1sLArV4xkyXCorPQ0k12vkg3jRdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223046; c=relaxed/simple;
	bh=d5s+U1xynEBidcfTy3l1a0UGpJ0XIBZFfRngrNU0RW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEN9dWJkV/WzQfUinZitQClLlFWeU8+c+2Df+SfKzGe22lXTdaQqnrkTZDIkUIvI1lLlDw40rgDDe8Zm97f4svCvCgVpCZjNOjPpoVIEW4kqrC9wzK7EURzXAgV69AA7y8ourxn25QJ/ddHuPrHmGEseW8IFxeAHb5l7oxxNMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h1GS5RGj; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h1GS5RGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SZ
	c5AhPFvmF7qT8nRXpWlmKEX66dB4gon7/zJcUhDh4=; b=h1GS5RGjCvNRj1bU6m
	GsPpSFU/TZ11Up6TAehjaXL9AyZWcumAErTL8DkyIAYAwziH/eADmIvskggaxFYa
	77OZGs+oS42KRcCdI9gDn8QWjFmVdxkLFrtejZbwHqKYP8oWy+5wtnDpBOlPAZdv
	7LUi5eUTImOPG1uNqswyM08AI=
Received: from 163.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3n7QzJ9NqcoFrAQ--.45846S2;
	Sat, 17 Oct 2026 15:43:47 +0800 (CST)
From: zhanghao <zh_exit@163.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanghao <zh_exit@163.com>
Subject: [PATCH] md/raid5: fix inverted condition in rdev_set_badblocks call
Date: Sat, 17 Oct 2026 15:43:43 +0800
Message-ID: <20261017074343.59513-1-zh_exit@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3n7QzJ9NqcoFrAQ--.45846S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWfXw1xKry3Xw1rGrWDCFg_yoW8Aryxpr
	Z8Ga4Yv34DWr95Aa1DXrWkAFy8ua17ta9F9ay3A3W29as0qF4IqF4rXFyUZFyUXF1ft3Wv
	qF17WrWqvFyrGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE-eO9UUUUU=
X-CM-SenderInfo: p2kbv5llw6il2tof0z/xtbC9hRmzmrTJzStpQAA3o

Commit fd4d44c14ff6 ("md: mark rdev Faulty when badblocks setting fails")
attempted to unify badblock handling but introduced a logic inversion in
raid5_end_read_request().

The original check was:

    if (!(set_bad && In_sync && rdev_set_badblocks(...)))
            md_error(...);

which records badblocks when `set_bad && In_sync`, and calls md_error()
either when recording fails or when the rdev is not In_sync. The new
condition `if (!(set_bad && In_sync))` skips rdev_set_badblocks() exactly
during recovery/reshape (In_sync is set), so failed badblock updates no
longer trigger md_error() and the rdev is not marked Faulty. This allows
reconstruction to continue on a disk with a saturated badblock table,
potentially propagating corrupted data to the replacement disk.

Fix the condition to match the intended behavior: call rdev_set_badblocks()
when `set_bad && In_sync`, and let the callee handle md_error() on failure.

Fixes: fd4d44c14ff6 ("md: mark rdev Faulty when badblocks setting fails")
Cc: stable@vger.kernel.org
Signed-off-by: zhanghao <zh_exit@163.com>
---
 drivers/md/raid5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index d52adf81065a..dcfb1bfa9ebf 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2866,7 +2866,7 @@ static void raid5_end_read_request(struct bio * bi)
 		else {
 			clear_bit(R5_ReadError, &sh->dev[i].flags);
 			clear_bit(R5_ReWrite, &sh->dev[i].flags);
-			if (!(set_bad && test_bit(In_sync, &rdev->flags)))
+			if (set_bad && test_bit(In_sync, &rdev->flags))
 				rdev_set_badblocks(rdev, sh->sector,
 						   RAID5_STRIPE_SECTORS(conf), 0);
 		}
-- 
2.43.0

