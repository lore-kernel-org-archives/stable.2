Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276013515C5
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730841; cv=none; b=RtXVcdZWh+h9ZWWjPLBOrG8biQIApSi2sifkepeIEnmi44Q4+XH29VV67jylUOAXTHSGdT0k5WEGf6HTTGdhuvk5oKy1F4hIgllu/CXBa200kiQuI/NOdisAv86J6lgjM30nZksjn2E4XVSJi3xyZ8vY71z0vFVhElnXM1eG4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730841; c=relaxed/simple;
	bh=5TTPFw+6pOzebpyRN9BKpiTnM6uz6kUgLoi6TD/nApg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVbIVBs4hCdxq1CiIbY1SzY//5YmjS3bHbYyMl8IXHoSboDy7qV27QgHG87efck9YtYVn+ok2x2CI5NWPdThCnSNDV/ttcIGa49kp+aApaSDGYVeO/RKLhQeod51r/wwVoOm4AZRr9ujS5IvVrNIGLzIKBNXcNcnGGFYhuw9hmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=DDTvdfGW; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="DDTvdfGW"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec309afso2089086eec.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790730839; x=1791335639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lc1wbxzVuxiw3fva36zB66RHmqecR2gjnNW5+7fJzDk=;
        b=DDTvdfGWjerA9DS7DhELvPpUBqOFJaWyixv6ykZpPhjOH7lTaPC/jxyabiazjuQPMP
         xjEcWP00K9ZQfzp7y4h5olzb3mJ8ZBNrvRnMWhoRdd4f3iNYSdFTbnU6eeRowqbpRJ8k
         eircqXmkBbvsek1igV75+My1expfy/5Uh5aV3VqBy9/oHGoYpRn5PU8GLOWJB/vTQqRk
         VnRLUCV+o+79Txx6tlNWs5RJ2I8ezaNmltAeBE1Z2ASEA03M4qCB0OkrDq8oCQkH0t/s
         OReWUC+2caCkFZwAKhrh2+hDoX0+JwuSvZ2IPI9Dgd0dgFBA028+hXNmvjZxUS0N2Pw+
         9+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730839; x=1791335639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lc1wbxzVuxiw3fva36zB66RHmqecR2gjnNW5+7fJzDk=;
        b=vkQDGW6VMfdBLOJSJMWw+Moc7AaFvUriqkp0JoKO2STOIorhmQ5Kj5AU30tb1Q/y48
         yTBDJxUfTxOOhhRky//v/RjPB2rAE20F/YXa0tCyqwTn3UqISjzKhDU/vy52Cd2ncoaL
         QxMMafHkE6rH2ZPVImDXnrEMD/tKuZdSlgo7RTJOBsQUZnRjr2Nj1c54jyKC9RCgUl8T
         l7J5YB1gNlqHv6hh3vErqrU0aMG7+CiB2TZdUJxBAwkZnzqjhdvOCF+WW7BqelLwmBvD
         rP0PQwEHm73vVhEa8J2rDk0alSjUxe1OshWA5wWuVcJOjGzJpqxBVrUuE8u70aTMQPek
         uXQw==
X-Gm-Message-State: AFq9FYKya5tIobvwJN4VJpI/aY6Wf50xv+ZDMNLoKtH1axNNGooJl492
	/zvjTIB/fcGuerTxI9/doqiBPN5qZ3CWyYYTOZZnDKFUUeOKf3IczA0zZsq2VkKG9Hbo/ax7Uvw
	2g++KCm0=
X-Gm-Gg: AYBFou1cx7uz2nH/Fpmp4w9psXL5Z2XiMfmY14Ld40GzEUJ4SCsw36KEr6RVG5hwF6T
	AaXkcMjW+fl7Lb3OVOHxzSziCQgUQ6DDMIjqgcOgVSOoxGQfcYt1g4284SrI5hCk31mfic2TOba
	s+uudpct4VWA70OaPyyDjB5PuOpbrZtnHXLXN2Hgpjp91sGT0RF5cF+uV0KR3nvbtx07RIPtzBN
	Nj5oeezfiiUh9o3URpQpslpuGx7lyTU5K5P9JEQlD0xHRFVzCTQuDJbDD4ZdRzHQLJXSMrlkN/r
	+h7wIL4TNV2Ad6xgpr7cP3yd9ShYjM5fJIYYT4ryTTRcPn2jH2MwEb2mQoU0km5aSO/k35or2L+
	rvExy9ISoJBw0F/A62aJcWnWs4Y5vB4vl9T9q0Tf9kydcdv5D6+DR/3FVdlGgUY7uE6vk1T0Lmg
	+kUTvq+/CA1fn+49qcz0IJFxjr8/zeQc0zcenUSG3fCafLxM2fDhi8ZY9WnkbRh3bWdGTjdVcKg
	tpDQ4XRa2I8z6lKlVeZD1DAif3VlwZ8+pcIDIwTavQ0RPz2matIHlkujdEym9wnmlV4gpg=
X-Received: by 2002:a05:7301:2525:b0:33c:259a:759 with SMTP id 5a478bee46e88-34c68185f7cmr1091505eec.36.1790730838921;
        Tue, 29 Sep 2026 18:13:58 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c38bf0948sm2036089eec.25.2026.09.29.18.13.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 18:13:58 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.6.y] media: av7110: fix a spectre vulnerability
Date: Tue, 29 Sep 2026 21:13:52 -0400
Message-ID: <20260930011353.94864-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 458ea1c0be991573ec436aa0afa23baacfae101a ]

As warned by smatch:
	drivers/staging/media/av7110/av7110_ca.c:270 dvb_ca_ioctl() warn: potential spectre issue 'av7110->ci_slot' [w] (local cap)

There is a spectre-related vulnerability at the code. Fix it.

[ Backport to 6.6.y: added the explicit linux/nospec.h include required
  by the older source. ]

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and media av7110 maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-50289. It masks the validated CI-slot index
before using it in the av7110 array lookup.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-50289
Upstream: 458ea1c0be991573ec436aa0afa23baacfae101a

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/staging/media/av7110/av7110.h    |  4 +++-
 drivers/staging/media/av7110/av7110_ca.c | 26 ++++++++++++++++--------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110.h b/drivers/staging/media/av7110/av7110.h
index 809d938ae1667f..f77766008b973d 100644
--- a/drivers/staging/media/av7110/av7110.h
+++ b/drivers/staging/media/av7110/av7110.h
@@ -86,6 +86,8 @@ struct infrared {
 	u32			ir_config;
 };
 
+#define MAX_CI_SLOTS	2
+
 /* place to store all the necessary device information */
 struct av7110 {
 
@@ -166,7 +168,7 @@ struct av7110 {
 
 	/* CA */
 
-	struct ca_slot_info	ci_slot[2];
+	struct ca_slot_info	ci_slot[MAX_CI_SLOTS];
 
 	enum av7110_video_mode	vidmode;
 	struct dmxdev		dmxdev;
diff --git a/drivers/staging/media/av7110/av7110_ca.c b/drivers/staging/media/av7110/av7110_ca.c
index c1338e074a3dc1..642af03fbac810 100644
--- a/drivers/staging/media/av7110/av7110_ca.c
+++ b/drivers/staging/media/av7110/av7110_ca.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/nospec.h>
 #include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
@@ -26,23 +27,28 @@
 
 void CI_handle(struct av7110 *av7110, u8 *data, u16 len)
 {
+	unsigned slot_num;
+
 	dprintk(8, "av7110:%p\n",av7110);
 
 	if (len < 3)
 		return;
 	switch (data[0]) {
 	case CI_MSG_CI_INFO:
-		if (data[2] != 1 && data[2] != 2)
+		if (data[2] != 1 && data[2] != MAX_CI_SLOTS)
 			break;
+
+		slot_num = array_index_nospec(data[2] - 1, MAX_CI_SLOTS);
+
 		switch (data[1]) {
 		case 0:
-			av7110->ci_slot[data[2] - 1].flags = 0;
+			av7110->ci_slot[slot_num].flags = 0;
 			break;
 		case 1:
-			av7110->ci_slot[data[2] - 1].flags |= CA_CI_MODULE_PRESENT;
+			av7110->ci_slot[slot_num].flags |= CA_CI_MODULE_PRESENT;
 			break;
 		case 2:
-			av7110->ci_slot[data[2] - 1].flags |= CA_CI_MODULE_READY;
+			av7110->ci_slot[slot_num].flags |= CA_CI_MODULE_READY;
 			break;
 		}
 		break;
@@ -264,15 +270,19 @@ static int dvb_ca_ioctl(struct file *file, unsigned int cmd, void *parg)
 	case CA_GET_SLOT_INFO:
 	{
 		struct ca_slot_info *info=(struct ca_slot_info *)parg;
+		unsigned int slot_num;
 
 		if (info->num < 0 || info->num > 1) {
 			mutex_unlock(&av7110->ioctl_mutex);
 			return -EINVAL;
 		}
-		av7110->ci_slot[info->num].num = info->num;
-		av7110->ci_slot[info->num].type = FW_CI_LL_SUPPORT(av7110->arm_app) ?
-							CA_CI_LINK : CA_CI;
-		memcpy(info, &av7110->ci_slot[info->num], sizeof(struct ca_slot_info));
+		slot_num = array_index_nospec(info->num, MAX_CI_SLOTS);
+
+		av7110->ci_slot[slot_num].num = info->num;
+		av7110->ci_slot[slot_num].type = FW_CI_LL_SUPPORT(av7110->arm_app) ?
+						 CA_CI_LINK : CA_CI;
+		memcpy(info, &av7110->ci_slot[slot_num],
+		       sizeof(struct ca_slot_info));
 		break;
 	}
 
-- 
2.39.5

