Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474810;
	b=L9P+5AOVpeucNGPEqtqldW8WP4XTLiKq5J9dzh3prEgChO+nL6nGlizWpBTMYVHsBCxm
	 gO6/QtmOoLvb5b4pwyzJm3kQR0tHRY0WSPDxHCjY4oLF5N1LB1VkAfJhANoRVOKXUJZQr
	 NvTY+Pk3MDRCNWpGN1V2AmhX010TRO+9mFCMGNs4j7H8LrwCsqUt2UCm3RpE5umsIZeOt
	 sEqJ+iVpseCbyDbzSsAx+d2E2E4NjwDmRJGR5CtUBoAq826M2+LcKxzzcoPywnbPzD6bY
	 bciRHG7ZFp52p0K0S0a9CVkFupJWJeKs7KBVtWQR+OuKujYUxAD05xH965nH0jCsucw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474810;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=yUZruvBPIEocxGxY1L+qkR4KftDZLF9AyW7Z6G1x5Ds=;
	b=LGoRXTD17x+HjYSdY/Li7zFAQlmi+x3rVZRmTkh7p/Wjy3LXjhxKc6pLYZwSeO8psvnu
	 +JLvS4Ut76VHEtpSQDDPkguJ/9+zmzrwun+ZViUeHP/TFWUGvy/aDAxhuxXG9LVPvTE86
	 FR4/yhJKlqpByovN2FGjWyCG1CLUpl6LqVkYM7EjT5uHONpepTwBRu+6mPtw45va/6pDR
	 elQxSCjnnL3LOZ2wnw+ncdfqnjaj/ygH4pUvQPBeQq9qEYKP8XXCgZHJGqX0acSQcrBZ3
	 XvOJjjVcxRZ+F+1cJX9tTOUHV4CpngbToDI5iIX7renebQRC+7AHuspHDxqXIN2wMVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dQtrinCY;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF183606A32D;
	Thu, 12 Nov 2026 09:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF183606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dQtrinCY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yU
	ZruvBPIEocxGxY1L+qkR4KftDZLF9AyW7Z6G1x5Ds=; b=dQtrinCYkvmeCW140l
	zZqX/7DlgdkLd+WD6qpjdKWTcLXkV7ReY05NWnMP2ynUhMsD9g1xMnY6z84TNaOX
	XRWcpU5cSPW2dXj9rYJHLI6nAc0YxnBtzRlsixX3VnKX4lkdbBfmUmKRkpypMWp8
	zLfFx4oAoJjnFp7aWsClvh0cI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnbDvngvVqwloxFg--.38026S2;
	Thu, 12 Nov 2026 17:12:09 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	bmarzins@redhat.com
Cc: yukuai@fygo.io,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dm-raid: fix use-after-free in raid_dtr()
Date: Thu, 12 Nov 2026 17:12:05 +0800
Message-Id: <20261112091206.1656622-1-dayou5941@163.com>
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
X-CM-TRANSID:PigvCgCnbDvngvVqwloxFg--.38026S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4rWFy3Ar1xZFykJry5urg_yoW8XF47pa
	15XrWakws8trWDXF1DKw4v93WYgw1rWrZYkrW7Ja4rAa4YyF1xua4xKr4Y9F4DXFZ5t3W7
	Zw43tw4DWryjyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6mh7UUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+gnyoWr1gulcEwAA3b

From: Li Youhong <liyouhong@kylinos.cn>

raid_dtr() currently flushes event_work only if work_pending() is true.
This is insufficient because once a worker has dequeued the work, the
PENDING bit is cleared while do_table_event() is still running. In that
window raid_set_free() can free the raid_set, leading to a
use-after-free when do_table_event() accesses rs->ti->table.

Flush event_work whenever it has been initialized, so raid_set is not
freed while the event handler is still running. The .func guard skips the
flush for mddev instances where INIT_WORK has not run yet.

Fixes: db29d79b34d9 ("dm-raid: delay flushing event_work() after reconfig_mutex is released")
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v2: 
- Fix incorrect Fixes tag; the work_pending() check in raid_dtr() was
  introduced by db29d79b34d9, not a17d1bca5aba.
- v1: https://lore.kernel.org/all/20261112075741.1449168-1-dayou5941@163.com/

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

