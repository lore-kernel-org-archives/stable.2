Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470298;
	b=GxMgIL1MBFo2LkUh1AIQnIhhGdJMevNgnLUNAzeLqeIYG0XAhTZe6n03sbhGfI/FveZZ
	 q3f4w024+yt68SezOMEGkEWAk30rXoulw6ZWdPSzC8jbbXroMVyMJrsNprG01yIH3qLjP
	 YpVltNDhUkB37Qa0rwBEvBvztpSzjZBUX0gejaE9aIuW+4bGJd0rIeiDBepESWVA9Gs3N
	 qSXzLqwGuQxQPNs+lY8bZ60UMOORNVZOC888JTisPCeqWCQEJngQXNI43c8UkhKZaIlXb
	 8s979xYNcD3NqaouuyK8rn5mr+ThO6iUD4htNW5TSE0yVJWAGfRHNCKtzQ+DcDyYatg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470298;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=rsNnQiTFcLDe92iCHQ9tr8yXvLZTHyvhhN6SxCWNDgQ=;
	b=hN089rO8pqA2s9s9PlkjdcmCKH4RClOZLShIXhlXVbjX3W1Ie5cugZCMGnyWNc4P6fq2
	 l/kuenbDiDknZ6rEa5JjlK5ccfToertz+lLF6uysDRJtggj1mvAT9rvtGpxN+ggHFifr9
	 ulTzGXf1HPGHsk1glLIPdC3f+sNB2TFOFhYEqWMVZOYXuif2FxdMGJZfJkoEOWrhTlgOb
	 E67Hn5eFZ5qknBjoAVC7IeqaFas4HhSwcIjOmEmcOO0B4V6OKxxWz9YGDZJrUO6akUdVk
	 rp+uXDn5W4f1DRJl2k/PybGY7ogZ7z7df2ASxDmzY+Yk1mmXGljR3kfBT0yu0v3hogw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="FBz/mQ2t";
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC4606A336;
	Thu, 12 Nov 2026 07:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1EC4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FBz/mQ2t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rs
	NnQiTFcLDe92iCHQ9tr8yXvLZTHyvhhN6SxCWNDgQ=; b=FBz/mQ2thTAaxWla9u
	Vsg/vWTrsTL4G4Z5Rr+XS1tiLiDwg5NzwTejYr13z64cj6ruRzzbSAGMjAXAWWpo
	TyzUoFqp25l84ChDHOw7cRgLIfcxKsBXK/tfxbOgI3C7VArqysLcjYUBfMsF/rxO
	YT05AquEAa3LAAyDenT5LFDaM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgA3v+Z4cfVqJDSOEw--.7844S2;
	Thu, 12 Nov 2026 15:57:45 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	bmarzins@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dm-raid: fix use-after-free in raid_dtr()
Date: Thu, 12 Nov 2026 15:57:41 +0800
Message-Id: <20261112075741.1449168-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:PCgvCgA3v+Z4cfVqJDSOEw--.7844S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtrWDZr18Zr4xGr4xGryxuFg_yoW8JrWDpF
	45XrWakw45G3yDXF1qqw4vvF1Yq3WrWrZYkrW7Ga4rAas0yF1fua45KF4Y93yDXFs3t3WU
	Zw42qw45WrWqyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULvttUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+RmSQWr1cXlIfAAA3Q

From: Li Youhong <liyouhong@kylinos.cn>

raid_dtr() currently flushes event_work only if work_pending() is true.
This is insufficient because once a worker has dequeued the work, the
PENDING bit is cleared while do_table_event() is still running. In that
window raid_set_free() can free the raid_set, leading to a
use-after-free when do_table_event() accesses rs->ti->table.

Flush event_work whenever it has been initialized, so raid_set is not
freed while the event handler is still running. The .func guard skips the
flush for mddev instances where INIT_WORK has not run yet.

Fixes: a17d1bca5aba ("md: fix stopping sync thread")
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/md/dm-raid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index ac019a0f5a92..c1f546e8c65d 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3340,7 +3340,7 @@ static void raid_dtr(struct dm_target *ti)
 	rs->md.dm_gendisk = NULL;
 	mddev_unlock(&rs->md);
 
-	if (work_pending(&rs->md.event_work))
+	if (rs->md.event_work.func)
 		flush_work(&rs->md.event_work);
 	raid_set_free(rs);
 }
 
-- 
2.25.1

