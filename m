Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2743BBA03;
	Sat, 17 Oct 2026 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792226288; cv=none; b=bQ2Gfs7VcWv5jrhaDn5hSDY4rxfl82+r61/okbfwviTqFktl0iA3bNLY1m23ppTonHUFG+bDQo80extM0UuMlL3kzlIBnzwbilVTynTnPn4GfqvoIQEwzgAs3ZY4HWa1UlIKNPrgQ+qI6T38l5f16cfIMaiYwlPklAt3ph7pYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792226288; c=relaxed/simple;
	bh=8YhiKmF1Nm93yWV2XKJvhfAd/B3334WjIgcUP7SRcaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KX+QhY3B8qd50A44KSHVCdYdVlColcMGPgE6/HQpBhUOEHpXbPEYsaKV1gJ1qOumOBesT3qlZK7s4ojujrNlDlwBaxM/4ZmvD1OGNaIzMalls1v9ShwuQwXSp5b+238f3tsMdKi5EWQW9lQalK/b3a1Bms0u0XA0VHfKxVM4nwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X1ZHIuhh; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X1ZHIuhh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+w
	ZQYfDXyigfN8u2pCrU2sG1bVZ6QjVFy8zUjVHhfsY=; b=X1ZHIuhhOKOWoH74ny
	gIYS2cldnMdfcWbePoic9z3qdZCZ+xt1seYfPzGCMlKWSQ3IGE4Re7xVY/a5jGfA
	ot8zu2By9yLX9m4IYUT1viRCQM0rXrl+sbQ8EaegkY0qaVzm9LicoSkj/YkAqA6r
	ctGOIi1Go175zTQ4D5NCXY5p4=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD33xHVM9Nq65H_Ag--.52920S2;
	Sat, 17 Oct 2026 16:37:42 +0800 (CST)
From: zhanghao <zh_exit@163.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanghao <zh_exit@163.com>
Subject: [PATCH v2] md/raid5: fix inverted condition in rdev_set_badblocks call
Date: Sat, 17 Oct 2026 16:37:37 +0800
Message-ID: <20261017083737.61793-1-zh_exit@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017074343.59513-1-zh_exit@163.com>
References: <20261017074343.59513-1-zh_exit@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33xHVM9Nq65H_Ag--.52920S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWfXw1xKry3Xw1rGrWDCFg_yoW8uw1rpr
	s8Gas0y34DWr95A3WDZaykAFy8Ww47tayqga1fJ3Wa9as0qFWSqF4rXryjgFyUWr4ft3W0
	qr9IgrZ8ZF98CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEAhLUUUUUU=
X-CM-SenderInfo: p2kbv5llw6il2tof0z/xtbC9RaR+WrTM9Y95wAA3N

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

Restore the intended behavior by recording badblocks when `set_bad &&
In_sync`, and calling md_error() in the else branch so that non-In_sync
rdevs, replacement devices, and the too-many-read-errors path are still
marked Faulty.

Fixes: fd4d44c14ff6 ("md: mark rdev Faulty when badblocks setting fails")
Cc: stable@vger.kernel.org
Signed-off-by: zhanghao <zh_exit@163.com>
---
v2:
- Add the else branch calling md_error() for the !(set_bad && In_sync)
  cases, as pointed out by Sashiko: replacement device read errors,
  the too-many-read-errors path, and non-In_sync uncorrectable reads
  would otherwise no longer mark the rdev Faulty.

 drivers/md/raid5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index d52adf81065a..25395a9c996a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2866,9 +2866,11 @@ static void raid5_end_read_request(struct bio * bi)
 		else {
 			clear_bit(R5_ReadError, &sh->dev[i].flags);
 			clear_bit(R5_ReWrite, &sh->dev[i].flags);
-			if (!(set_bad && test_bit(In_sync, &rdev->flags)))
+			if (set_bad && test_bit(In_sync, &rdev->flags))
 				rdev_set_badblocks(rdev, sh->sector,
 						   RAID5_STRIPE_SECTORS(conf), 0);
+			else
+				md_error(conf->mddev, rdev);
 		}
 	}
 	rdev_dec_pending(rdev, conf->mddev);
-- 
2.43.0

