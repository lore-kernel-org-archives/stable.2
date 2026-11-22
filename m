Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363507;
	b=weGwtSDPhBJOpbAhkDg9GBkz+3LRWfxcFsi732hCafhw+1VlAiSeVmRupdep6vVkKsog
	 uNDm82hOQMBuhEmLJaer3WsXkLSOkccQQGD4JrNr/XV1/Dm5lDl1ASW7sPP0GPq532Ubn
	 VJ5+n70gv5ASUPXcW90QzPFp8mW67PZDl0ja58nQOTnUyd7ki8etBv6UKjtZnToiI5aGS
	 sveOUILVsui+m2cj4N+h0n9uYmLRCyu6g/rxmtQ82oJ34Uiwl92uxkeyokDbtT9o5eKMd
	 WqWEjKwq9BoU4Trq2NUEAnR3e9gQ3QA2P4zmVupGIM7s61prXDRXTap63YWncADhGQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363507;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=4k8LfwJrCJyqEzMgRMO8spKxx41zK9lSh3OuxZtEwr8=;
	b=hJIWONDKJnErH4C1ImjQMD1j2u6jHTiY/fGV1tctGeceDw9+irkI2xWNY7TS4KIHKUT0
	 VSEkzX+hrTWuyPJG4FmyZs5J0hXyKIiMj0WTKr16KhaTzJBSc1QIUpVKq6tMNV7oKufmm
	 8rQ0bzjBZ87v/a+ADAXRjPOxC2B2HIiWlGxwUoJM0C1U/pfMXBMRGFSVPq+q6tUUFac0A
	 BHsieyyKpkbJCiUHBaforCU9abfeAtYTbTs/0O4Gqr34d+fQJmqANzj2A65lBnmQ9q/Lc
	 4kdZ1u9hSN4YwyTTLH8Fu2dDtom8X6IcSbgkqNHuhsP19x16b4JDr9LBeSzeX+4nOiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=opfvE6fB;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE2606A320;
	Sun, 22 Nov 2026 16:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0DE2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=opfvE6fB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4k
	8LfwJrCJyqEzMgRMO8spKxx41zK9lSh3OuxZtEwr8=; b=opfvE6fBVTalQX3/Z9
	A35hsAVcN9Is6da0W96X9TaOJHZOWEOGRQhLgwUJib32ah3IH3aVymGi6JKyH4Fp
	QnouFpwoAYLcc7EKtkWfrJgOkmKVlCmMNhj/wjv2gggHxfXa1KbxsapgFvsehDoA
	wO/li9gxkGXcsIibjt6zpGzIQ=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD33yeeEgNrSkfXJQ--.33535S2;
	Mon, 23 Nov 2026 00:04:47 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: em28xx: handle builtin decoder allocation failure
Date: Mon, 23 Nov 2026 00:04:45 +0800
Message-ID: <20261122160445.519874-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wD33yeeEgNrSkfXJQ--.33535S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4kAFy7Xry3Ary5WryxuFg_yoW8Ww4rpa
	yvyrWFkry2yFnavrnrZFWUuFy5Jay8GrW0kFy2gw1Ut3yrAwn2qwsIyFyYkrs2y3Z3Za1j
	qryDtw42gr4jvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlZXrUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7R9Hl2sDEp+eXAAA3F

em28xx_v4l2_create_entities() dereferences a failed builtin decoder
allocation. The release path also unregisters the decoder without checking
for NULL.

Skip the optional entity on allocation failure and guard its
unregistration against NULL.

Found by LLM-assisted static analysis. Build tested with allmodconfig;
no runtime fault-injection test.

Fixes: 8e53399c63c3 ("media: em28xx: Add support for Empia em2828X bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---
 drivers/media/usb/em28xx/em28xx-video.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 84424284d..bb258de0f 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -1018,7 +1018,7 @@ static void em28xx_v4l2_media_release(struct em28xx *dev)
 #ifdef CONFIG_MEDIA_CONTROLLER
 	int i;
 
-	if (dev->board.decoder == EM28XX_BUILTIN) {
+	if (dev->board.decoder == EM28XX_BUILTIN && dev->v4l2->decoder) {
 		media_device_unregister_entity(dev->v4l2->decoder);
 		kfree(dev->v4l2->decoder);
 		dev->v4l2->decoder = NULL;
@@ -1170,6 +1170,9 @@ static void em28xx_v4l2_create_entities(struct em28xx *dev)
 		v4l2->decoder_pads[EM2828X_PAD_VID_OUT].sig_type = PAD_SIGNAL_DV;
 
 		v4l2->decoder = kzalloc_obj(*v4l2->decoder);
+		if (!v4l2->decoder)
+			return;
+
 		v4l2->decoder->name = "em2828x_builtin";
 		v4l2->decoder->function = MEDIA_ENT_F_ATV_DECODER;
 

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

