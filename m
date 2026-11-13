Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532214;
	b=4KI7GRz+KCRUgdiXq9BwVFIhkUrsA7SG8yI84mysnlET/WJCgqFnaYZVSZs+6fjk7QT4
	 yd9DWZ9p1HQCJ+PoVAXbfX8m21A8W3dwe3syqbLbkfZlcgLE3CZMrsrawnST4XWFhCW/U
	 bXpHhwGLVDMPi1el+nAuGQnOihGrkzavGnU0R39x2XuSbZQZKoaDMWSJvVZU82HCsoO8s
	 D2ETtpysfm8ZmQ1Z1CAjYD6BV5s+YBk2iYDtasTqKP2L2RXyDqLGlL4R1mb+dxdNG0dyb
	 c3ozf77Yp5u2EhdDrUbpmFjZ5+ZvGnOchbqcuVZT/Y53fTeHhURbr978yVfsAX/xCLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532214;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=KP3chNyPq62LE1SUl5yEk6RTR3rwbe41xhjBB3QL1EU=;
	b=HwoKT2rwnvkwEQCBGNgfGOuE/dyqTVet/X7+20TB2gJGTtvffk7fMpPsIaUhv34qKRBK
	 wJX0rIs3qOnSkNQBubvXM/EhBBG5Neq1Fe5DITPCCsjWkrIaSDVXW845PiPplbCjANOtA
	 NJYOJlbQ0JW/WC6q46wJoirtWAAqUUy7cQ4pSrNxAH//Koz/VyO0wwdIvmwaSueMMVfmB
	 UOdFA+hWIoqFzk4MV/uf7o317sLVfYGHlFQ6lakgpSaSDtKOPc6y5QlRQd6xPs921b9wy
	 h4QwZGCi4dHAfXrTQjz34wd59TlekYIpGyWWXdpXUCZeEntYJ2vD1GfJ6qp1/Bj08PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="b8AU/N+5";
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899A606A31C;
	Fri, 13 Nov 2026 01:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7899A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=b8AU/N+5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KP
	3chNyPq62LE1SUl5yEk6RTR3rwbe41xhjBB3QL1EU=; b=b8AU/N+5DPkDow0Jww
	2Tg3EVDf59Wqa4sbtKa2Tn0If7hV55K5KcO4zNC7FwpO+WUfaxWmHgypBFutIwF4
	8tqNLK542eYRpqbNbfOBcf/v/tAfMgdMRTyFBLyVlNGWO3vawo0EQX/xLuuw4Ltp
	OzWHKDaRzBdGGUQCY6PVZhuhY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wA3FxM2Y_ZqO82+HA--.10295S2;
	Fri, 13 Nov 2026 09:09:11 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] md: fix stop_sync_thread() hang on new sync in idle path
Date: Fri, 13 Nov 2026 09:09:09 +0800
Message-Id: <20261113010909.30324-1-dayou5941@163.com>
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
X-CM-TRANSID:_____wA3FxM2Y_ZqO82+HA--.10295S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr47Xw1kKFykuF47Jr1fJFb_yoW8Cw1fpF
	WxtF98WrWrXrWxXa4jg3ykAFyrAw1jqFWUJrZrC3s5Aas5t3W3AryYgF1Dua1DuFySyF4j
	van0gFsxZ3W29aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY89tUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+hc+7Gr2YzeR2QAA3-

From: Li Youhong <liyouhong@kylinos.cn>

stop_sync_thread() waits for either MD_RECOVERY_RUNNING to be cleared,
or (when MD_RECOVERY_FROZEN is clear) for mddev->sync_seq to change.
The sync_seq counter is only incremented when a sync thread is reaped
in md_reap_sync_thread(), not on the md_start_sync() not_running path.

If the previous sync attempt took the not_running path, sync_seq does
not advance. If mddev->thread then queues and runs a new sync in the
window between flush_work() and wait_event(), that new sync may start
a real sync thread, leaving MD_RECOVERY_RUNNING set while sync_seq is
still unchanged. md_idle_sync_thread() then waits until that new sync
thread is reaped and sync_seq finally changes, even though it only
needs to wait for the current sync attempt to finish.

Fix this by incrementing sync_seq on the not_running path as well, so
that the wait condition correctly observes the current sync attempt has
completed.

Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v2: 
- Fix the Fixes: tag to reference the upstream commit f52f5c71f3d4
  instead of the stable backport a17d1bca5aba.
- v1: https://lore.kernel.org/all/20261112092634.1700963-1-dayou5941@163.com/

 drivers/md/md.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 68a72513e884..1970c945e597 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -10352,6 +10352,7 @@ static void md_start_sync(struct work_struct *ws)
 	clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 	clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
+	atomic_inc(&mddev->sync_seq);
 	mddev_unlock(mddev);
 	/*
 	 * md_start_sync was triggered by MD_RECOVERY_NEEDED, so we should
-- 
2.25.1

