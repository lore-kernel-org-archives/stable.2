Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680541;
	b=QOfh444F0a9Wtz0jkWQhSqIYNzfLsiLazhRpddBeVFNhE/a0t6ynQJAuNx1U199l8Jbq
	 FeI1R8rQ0WrtA9G3VX7om/C32tG6Hiyd1sqQ0MRdFEkEma3enmznB10uh+n1nrkxNVGHx
	 DlULiN0pDh+VrsMxCOqmsYShE/Lx3SiD618a3Md0nbMVVzNuRP1ShbFRFZ5zCQB0/71vL
	 e6qctmziSCraAAH1In8IAwN3GBizMQYuyD+yfTb2hRaoysum86sS5D7pa5aMObdFT72uB
	 W0xl6ZZ50R4Eat8cBn4f8ggV0alQTc8Rqs1mFke+/P+tHVI4d5QFOXfIVuiR0RJmHVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680541;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=yuE/zUNEYMaSqjPjlCfrNop+D72AkNLIjDev14YO6JM=;
	b=uC6JIlLnNsGGUKneeyXMtfm3w6cSWjDRLupCWBA4Ym0mQd12ANA/nRjWPgni/J9bW7B9
	 +JsRJO36JSC57NAlOstnPOHDcAsqEN6kN+pMQEwizvapyzvpRMY3+8/rY/KNnqxK3JwRo
	 rgYVbxSMYaW8RAgP07HlwPxQJs7ewGKC+81YCnU1IXSMAP1vrBJQeDZwRJfBKuIkOPJO3
	 1X7TQJ+5fyGP++gSBKxv7IA4LuosdYYRV4yoE03+paAJWDkMf74jCsDgOYYFw4mKgrFda
	 mo+SswWc21fOwl4ykofcU3duKzsD1oTZL4lXorQPX3yJLWSBfWzRItLy66ND4YSWI8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NyQ21NML;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335E606A323;
	Thu, 26 Nov 2026 08:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6335E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NyQ21NML
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yu
	E/zUNEYMaSqjPjlCfrNop+D72AkNLIjDev14YO6JM=; b=NyQ21NMLlAB+3XPcTP
	Qc1BKlWtV8CgLHLOPhT3sUBps58FBZsaAIL4Ik1FcArD59pLWp5koh2xWbminZZ3
	LNOKg8k/BfTHRy8n4sw3BgnjC0FZPEubNLYLAXe4uTd8azGaHXB3QxMvxm/mdmZm
	gtJBOVx8PekHEyFlcili7PPTw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXnmz_6Adrmd0YIQ--.26S2;
	Thu, 26 Nov 2026 16:08:32 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v6 1/2] md: use work_busy() to flush sync_work in stop_sync_thread()
Date: Thu, 26 Nov 2026 16:08:30 +0800
Message-Id: <20261126080830.144525-1-dayou5941@163.com>
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
X-CM-TRANSID:PygvCgDXnmz_6Adrmd0YIQ--.26S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFy5Ww47Gry5WryxJw18Zrb_yoWfZrXE9F
	Z8Zry7Gr9rKw1rJF1ruwn7ZrWrtrnIg3WDWF1IyFW2kryjvr1IqFs5C39Ivwn3A397W3ya
	9rWUCa4Ikws8ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbKL9UUUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+gAXxWsH6QDNEAAA3w

From: Li Youhong <liyouhong@kylinos.cn>

stop_sync_thread() only flushes sync_work when work_pending() is true.
Once the work is running, PENDING is cleared, so an in-flight
md_start_sync() can be missed and teardown can race with it.

Use work_busy() instead, so both queued and executing sync_work are
flushed.

Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 03e35386a802..1974943bf746 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5213,7 +5213,7 @@ static void stop_sync_thread(struct mddev *mddev, bool locked)
 	 * never happen
 	 */
 	md_wakeup_thread_directly(&mddev->sync_thread);
-	if (work_pending(&mddev->sync_work))
+	if (work_busy(&mddev->sync_work))
 		flush_work(&mddev->sync_work);
 
 	wait_event(resync_wait,

