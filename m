Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191496;
	b=UTdvt9O7KoYzwklN9dXPS5aOigTI7Zqr89/yuusHsPqis67MbyyZU0li8MfNEO5PNlt+
	 OLGNm/TzdcpFzEdOvOjNvEP/AsJJkg/rLCmva7EFhA64fFPeFPxH9+PphfMIMkScQLIQk
	 nyzJEFZkwqYbTZ3SMe5OnURjgFK2y51RlUAwJj283VsKqq8xDLwVO87i6Gl01bWMc6+LB
	 1wDrS5bi441W7reHduEQaJRM38JB8P4dBV6CJQAGYyMgPLj68TkiUdcM8AGscEmyHI7FF
	 t0GIIQC/IKCgN6OiLh1SSDyfgazRHQOqNc/r2OoVSrGDQuJrwXZ0XwMSATgtHaUujUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191496;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=8zwvWBPtZCtktZYAG541eCPKPuE+/HtLXgXPeBWjtkY=;
	b=xegrmFuHo8VNkgiGeweAXs8qpdH09h3hk2dDemWOXP+0lI2UDe8sRCkwQFneu+qSKYkH
	 9rOppJTi/adIFgqHlNSswhzVirbsAirNLNcVFyLORpdB1UYwmNUkXGhrIx2ipccgUPDU5
	 zwondUY2qbACE4nQpb2tlfV32qrGFYy//i9ndmNvgCUO067sr7swWQk+AwdxHIvJz+A5a
	 CIHEwXYDIRcxbri+CWnTwUh0XR2MuGwdivExCcupB5hd1Uh4Xd8sVdYRU9KRqDPV5u6W9
	 tL2c3Q7BieI4lS5VUIeTE1a8/kC0LAulfVZb1BsA2DsehvMwAGNgK7r0h4G7LGgRgMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RTssncOi;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39816606A323;
	Mon,  9 Nov 2026 02:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39816606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RTssncOi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8z
	wvWBPtZCtktZYAG541eCPKPuE+/HtLXgXPeBWjtkY=; b=RTssncOiHXO3poyWmF
	kItN6EuqKb1KNo8KrcgTq2PCrWKIQfyV8USH8FSSsrBQm2XArsXlaqcT/lmyW7VG
	wRb3CPRlVOwtRR24IzgKmlE5mOtlC+C3QxzLVMB7DFWtSuhiuCqzR6DxHweNyCSc
	Z+0ZVGkcNdQBrCvwUyxKg7Yh8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3f9FhMPFq9p_BGA--.58997S2;
	Mon, 09 Nov 2026 10:30:58 +0800 (CST)
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
Subject: [PATCH v2] md: stop sync_work in md_stop() before clearing pers
Date: Mon,  9 Nov 2026 10:30:55 +0800
Message-Id: <20261109023055.2164333-1-dayou5941@163.com>
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
X-CM-TRANSID:_____wD3f9FhMPFq9p_BGA--.58997S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw43tF4DGw47JrWxuw4kJFb_yoW8Aryfpr
	WrXFy5GrWjqw4xAw1qgFy8uFyjyw1aqrWDtry2ga4ru3WYyr47XF1rKa12vFWDCFyktasI
	vF4DJFZIka4vg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6yIbUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+gM76WrxMGN3IQAA31

From: Li Youhong <liyouhong@kylinos.cn>

dm-raid tears down arrays via md_stop(), which clears mddev->pers
without waiting for previously queued sync_work. This work may
then call remove_spares() with pers == NULL, or continue accessing
mddev after raid_dtr() frees it.

do_md_stop()/md_stop_writes() already call stop_sync_thread()
before teardown. Do the same in md_stop() so sync_work finishes
before pers is cleared.

Fixes: db5e653d7c9f ("md: delay choosing sync action to md_start_sync()")
Reported-by: syzbot+a53c2918175b36cfd601@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a53c2918175b36cfd601
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v2:
- Drop the pers NULL check in md_start_sync().
- Call stop_sync_thread() from md_stop() before clearing pers,
  matching do_md_stop()/md_stop_writes().
- v1: link: https://lore.kernel.org/linux-raid/20261106083543.249267-1-dayou5941@163.com

 drivers/md/md.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 680b34a63cb3..eaa20ecafbf7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7101,6 +7101,14 @@ void md_stop(struct mddev *mddev)
 {
 	lockdep_assert_held(&mddev->reconfig_mutex);
 
+	/*
+	 * md_check_recovery() may have queued sync_work; that work accesses
+	 * pers. Wait for it here before __md_stop() clears pers, as
+	 * do_md_stop()/md_stop_writes() do.
+	 */
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true);
+
 	/* stop the array and free an attached data structures.
 	 * This is called from dm-raid
 	 */
-- 
2.25.1

