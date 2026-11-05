Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793845216;
	b=J94fVs1i1U9KxBXP8dOeHmk61c94o958sPR/687yZ3R/2ltF3gbYdeL8QCp/Gf6yDvPD
	 82FLlUenPddBodVs+bfyr/dEkkMH4yEN4kKO8V74SI4TByi8Zd154+mi5jdK2v+a4Pkys
	 x3WBnf5fHvKMjV9kYlyraO0woLVkIrmR0BHtOx0O76Kt2GIXlJxzvjc0IXGyXHQzdWj+X
	 lcsozkEtPywCytRjUyrNzi745rpS/+L5GSjePKicv1Yg45DeVj9Eolw2Zii+7E9Fh6JyX
	 eqbvW9PnW0Rm/USWPLbE92xVc+Kjmhu76jgEoeCPcoUzcXwbRQGHPF12f45Kfs2TRsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845216;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kwyi3xE5HC3vx77XwDaZCAD8Ng4RkB7EcEx9n2x6K5M=;
	b=UG53Iglkk46Qw6rQaPiz6S6sPoLdO9ih73KAuZ5LoyVWcpP2uk0ej0hg/1SR7zum/31u
	 HNoTA59YFAA6qsMM9V1luVsnkDPNP7XWlPeN8lKFk1QiUADjHtDD5WwfskrpiH2FBLF7X
	 EfXcovLGOQ8Q3YPH26HV7bB+2RfdZ+fyzfb/kbdbDkT+MEa3qoKiliN7A5IExCghJ9jnR
	 Qk4Dh63DJ1WZCaQUsqw+USrhqpk6JR1ebQnhe8cJL8x6YwYpudnO2NtRbRaV0DX43jCSU
	 q5cbUFLs27ipr6EXYEqinen9o5xr6GGU2X05vdj+Pg3URT94lSsqkD81JfqSEXXmgoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QX+kFSxb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B5606A326;
	Thu,  5 Nov 2026 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QX+kFSxb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793845215;
	b=wa39GSSEHDrQh51DulpZO3AcaGlIm6UQVEFZHA2m60dO3N2cw5mx9a3QXFDKK4MNzC+r
	 DmDsQA+ybtvb1AFvTUE3ucS/WwyoFui1/w6DRdYyB1LXE1KHX0HUXtWRhg3gwQxWTHTlQ
	 ZSYK3Hz8jQDj+sTOiBy26prhnUZbr7nQrEvZfFuQV/0/lkC8dVyWDJiz97kGkxbrhBRca
	 1ZB05rhIIH3DNUvkpA1XvTyP/s7XHxoj58M4O974HK2xpPinTCanwRHAIaPfr8yOnelJr
	 UEBx/ODOXV1tCx30bAw0S/bTZA3BG3/sndScsNj6Qh/a0WhKS7+V4xseIxagRNVmpMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793845215;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=kwyi3xE5HC3vx77XwDaZCAD8Ng4RkB7EcEx9n2x6K5M=;
	b=3Ljcki+gtj4FA54QAX1OZOAG8Xt1GhzlMPVRjOPAkRTZgPOM4OmsMDbHQLtBYzZZBhuz
	 0niMsjGUzLc8AEXAdMhGDLzGZ8eH3urCdDx4T3R9TKGXhO1H66cqFKz2g0Iz79JWB45ry
	 Wo+4jfjHjintRkGHjAXdJuSms8i532L+TflXG1hVGjWfueRGoa0ee6UEDf7pHTzIykD28
	 RBbkswO7cbPER7Btqo5mSkYR3Htt5DIhcLbWHEZgqPxZfmxKQD3zrnvHQDrunkB+QlxIX
	 tUTgc8taTOJN27zzNGkAQRiK2sT4Dq25vZz3IyV7Qc/XlIZp6J0iq7kgmoSCXZZVyMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C83A71F000C1;
	Thu,  5 Nov 2026 02:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793845215;
	bh=kwyi3xE5HC3vx77XwDaZCAD8Ng4RkB7EcEx9n2x6K5M=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=QX+kFSxbvbL/8znyFYE1ufYSB99g5nhhkfX2u0ZztIjDiZrARWuoZPo4pv6qSiZc/
	 6MZGjVMd7DZjfYdadU+RrD3oX+PC0mAZJf/3BnA9+fCSKZDXdguL+5Sb+8pML2kqc4
	 tQ+JKvvmhaFVDQnEnidFVlkJ5EEYKDwCfgUT1oUZiJJJHCFU4G1W/XlrNOEM8SKqKI
	 x4GaCIxCAgVeoSsHq79g39XrySaEU6kcgheFLRtoLCZj7bjj2uxF8Q2tyti37o0+2m
	 RprO0TgierTfHKjPNf5n4Kd2yr9wo0oQ65jvlXg2fND1kLR5iFcq+wZyJvSP0ykgnN
	 Hqu8yy3dw0H8g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2A88C4701A;
	Thu,  5 Nov 2026 02:20:14 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 02:20:14 +0000
Subject: [PATCH] media: dvb-core: fix use-after-free in dvb_remove_device()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-dvb-remove-device-uaf-v1-1-a9e091d7c9ae@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN3n62oC/x2MOwqAMBAFryJbu+CqsfAqYhGTp27hhwSDIN7dY
 DkwMw9FBEWkvngoIGnUY88gZUFutfsCVp+Z6qruRCrDPk0csB0J7LPvwJed2cI2rTSdM2Iot2f
 ArPf/Hcb3/QDZT06qZwAAAA==
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+37578f730d38898f4b74@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Joas Antonio dos Santos <joasantonio108@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793845213; l=2266;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=prLpSJVWNrnZT55RbJ2w1/TI1YO7NXSCENMkRGHUepw=;
 b=zCVEFfk4tLNKrt4gCOPsh3ztTBXtUF35/c3pdzSfvAzgmMIih85IFQxlWBVrgTs/tGl0aN+ib
 ICsbECE8OH3CIWpJSE7Z0yTVnIqb9SBOurvdMKsOf9AFWkgpphJRgci
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

dvb_remove_device() calls dvb_device_put() while still holding and
using the dvb_device pointer.  If the put drops the last reference,
dvb_free_device() kfrees the struct, and the subsequent calls to
dvb_media_device_free(), device_destroy(), and list_del() all operate
on freed memory.

The syzbot KASAN report shows the freed kmalloc-256 object being read
at dvb_media_device_free()+0x3a, which dereferences dvbdev->entity
(dvbdev.c:210) after dvb_device_put() in dvb_remove_device() already
freed it via dvb_free_device().

Fix by saving the minor number before releasing the reference and
moving dvb_device_put() to after all accesses to the dvb_device
struct.  This ensures the device remains valid for the entire cleanup
sequence regardless of the reference count.

Found by LLM-assisted code review of syzbot-reported crash patterns.

Reported-by: syzbot+37578f730d38898f4b74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=37578f730d38898f4b74
Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/media/dvb-core/dvbdev.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d3295..b2beacbab 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -593,19 +593,22 @@ EXPORT_SYMBOL(dvb_register_device);
 
 void dvb_remove_device(struct dvb_device *dvbdev)
 {
+	int minor;
+
 	if (!dvbdev)
 		return;
 
+	minor = dvbdev->minor;
+
 	down_write(&minor_rwsem);
-	dvb_minors[dvbdev->minor] = NULL;
-	dvb_device_put(dvbdev);
+	dvb_minors[minor] = NULL;
 	up_write(&minor_rwsem);
 
 	dvb_media_device_free(dvbdev);
-
-	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
-
+	device_destroy(dvb_class, MKDEV(DVB_MAJOR, minor));
 	list_del(&dvbdev->list_head);
+
+	dvb_device_put(dvbdev);
 }
 EXPORT_SYMBOL(dvb_remove_device);
 

---
base-commit: ebcf66fba448879076bfdd1018ac5cda37b912bf
change-id: 20261105-dvb-remove-device-uaf-aea34136c515

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


