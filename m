Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954238;
	b=plObVsnN+dAdBz86f/rSiJ60tMcVQwwvov+M34hNmBPKlSZuIGPutSulEsl4+yPRPTuG
	 o83PT4ViTqIqvAYiZBOOw3LeRNwFpW9MsusCEC3yjjt/sK9ZR6DaNfi5ayW7bv5DxtCsu
	 C9swImOtEaeAQsFB8ffeuVN4QjBsjiaabs3jNdu2bSWFiuZ9s4XYhFQ1uVEbG53jjchCr
	 OnUakvX6HfQ7vEA0JCSJgvVSroU+/eIplypbZd/oJ8wc7Zw9YuM1Ck9WCn2johfWNRk43
	 OpKxa7tDhxeNdz4+Zv1C09sUOPFkl4QrquaP49sFYxNfgEMOE+JP0ldb/AoW5KKJw2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954238;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=/s+yJYiFvtU8frKX3zkuCW1EAXhpcAqOLpUR/Yaz2bM=;
	b=tnhpttKf6l0fxML5YeByjyoPBXefKg3PatTajxym8lEBly5HgE+zzFYQPd7iuKcWB55S
	 Pe+MDCRdIQ2XX0CrBbRKxJtLZqIG2us5pLZIENXtqGx4vxhFXkGrLcfDBtmdk8mFCbJUI
	 mFv+Nk8lJx52hFI6u+Phs5YmcyTUnxCyvEZ79BSddcWdRx53+nxEF46jEKuSchUrQkbcF
	 RwvI2WZs/97F5dlft5eOB3PdUcUJpmcD8SY8tsyM7eelx51o7yWDIOcA+DY2Ww2rAKVpk
	 qKoShidYEmsq2v/SJE6mirsAzTQxMHVCrf0ZRDbDNeUzxvCmCcuc1icJJppaarGrVag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cgo51UCR;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6C606A32C;
	Fri,  6 Nov 2026 08:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BF6C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cgo51UCR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/s
	+yJYiFvtU8frKX3zkuCW1EAXhpcAqOLpUR/Yaz2bM=; b=cgo51UCRXxebT5mXUc
	1oxjfCjUqnUEySWP5YwAFDsLbPBH7NvXiGD+MGW3hp9Xy8lfE29eYZBNegtoBSPf
	h5bvAPBFWaQSELoOlfur7rq7kZLO2xP9xYRkmTMm9NQ3lQJ4z0HrYva45SrfgtLo
	zBa4C3o7NKryO/UcVUXxjRta4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXnc2Zke1qauhKFQ--.20838S2;
	Fri, 06 Nov 2026 16:36:43 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>,
	syzbot+a53c2918175b36cfd601@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] md: fix NULL dereference of pers in md_start_sync()
Date: Fri,  6 Nov 2026 16:35:43 +0800
Message-Id: <20261106083543.249267-1-dayou5941@163.com>
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
X-CM-TRANSID:_____wDXnc2Zke1qauhKFQ--.20838S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFW5Cr47WFW7Ww4ktrW3GFg_yoW8XFy8pF
	4SqFyYkw4Yq3y8AasrGa4UWF15Kw1fZFWUK3y7Wa95ZFs5Ar4xXry8Ka1DZ3s8KFyYkF13
	Xr4Yyan8GF10y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbCztUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3RugT2rtkZsT8AAA3H

From: Li Youhong <liyouhong@kylinos.cn>

md_start_sync() is queued on md_misc_wq to start resync or to
manage spare disks. On a read-only array it calls
remove_and_add_spares(), which ends up in remove_spares() and
invokes pers->hot_remove_disk.

md_start_sync() does not check whether mddev->pers is still
valid before using it. dm-raid stops the array through
md_stop(), which clears pers. If the queued work then runs,
remove_spares() dereferences pers->hot_remove_disk and crashes.
The read-write path has the same exposure in
md_choose_sync_action().

Return via not_running if pers is already gone.

Fixes: db5e653d7c9f ("md: delay choosing sync action to md_start_sync()")
Reported-by: syzbot+a53c2918175b36cfd601@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a53c2918175b36cfd601
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/md/md.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 680b34a63cb3..b7e162f52408 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -10286,6 +10286,13 @@ static void md_start_sync(struct work_struct *ws)
 		noio_flags = memalloc_noio_save();
 	}
 
+	/*
+	 * md_stop() clears pers. This work may have been queued earlier and
+	 * can run after that, so pers may already be NULL here.
+	 */
+	if (!mddev->pers)
+		goto not_running;
+
 	if (!md_is_rdwr(mddev)) {
 		/*
 		 * On a read-only array we can:
-- 
2.25.1

