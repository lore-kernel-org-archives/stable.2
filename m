Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F43AFD1C;
	Tue, 11 Aug 2026 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447800; cv=none; b=Tv1RUGmjH8fUJVJccMGSVYMa3JLmxqjHqQ4RgPaAgVLRe/0C5x5z1LsF4XQPfa+dGKOdiq3uE/7U3OkXB+tJ4Jsf3gi2Xi1RVSrROGWASWuez0EWYO7t8iHL0bzIksOsJpVKgokLJVe8ij0pHceXPDqMaSOy6tN3wNWaKbnHGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447800; c=relaxed/simple;
	bh=UWByiTYdt+0EZNikz1yaU1RP+Y72FI2riSlbBJ5/h48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bu4ip2MV4bPdFZN/564/rl4DzMsk+f79vdm32mUYz2nZQoWZsedjPZy2Ef7exS+XA1B826fJPOOrMu3Qz8Gk5KBcheJ/iI8RA4o3cdI63TZNCfPUqR6DyZLmrlTmOITiXTUH8YoRHTZKJN1IQUX3FY2SAu8IRESg/aP/3IKCuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=U2C6BP6j; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="U2C6BP6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786447765;
	bh=zUPY6MjOpliaS/5eFtZLfCoVmk3pcUkb4nuPkjP5OgU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=U2C6BP6jEA1D8PJn9INJiFqYbjEtbtY0MnimA66UBjoVGAHsq9Hkp7AB8qYZvqTyU
	 95soxKDbrqMjBf5SABjUW/ZibUf+3ZzCAtdp8J8wHgrFl2Xix2HeiiZJn6oomh4/s3
	 Bd0nImCJ39akRf+Z9ALNhyxXG2Ehksn3geuKMkQs=
X-QQ-mid: esmtpgz16t1786447747t9b707f6b
X-QQ-Originating-IP: HoFFBmwx9fG/5pu+6beedke3BWoDkMjT+aLtenRLcK8=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Aug 2026 19:29:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11484340070538419964
EX-QQ-RecipientCnt: 9
From: raoxu <raoxu@uniontech.com>
To: mchehab@kernel.org
Cc: hverkuil+cisco@kernel.org,
	laurent.pinchart@ideasonboard.com,
	jacopo.mondi@ideasonboard.com,
	raoxu@uniontech.com,
	kees@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] media: m2m-deinterlace: fix default capture field
Date: Tue, 11 Aug 2026 19:28:40 +0800
Message-ID: <F2EC6DC6AF812739+20260811112840.188843-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mau7nk0Bttg7dcA0oSsfZ7tqKb5DwOozjUYwYk/44ogbqXIDZjPGKyS7
	aHuqL8iBxqEiXvO72evUlHo3por4Cp2KUDMJs34FE6wrZev/H/26isCGx/7y9WvPY7bfyXO
	Cxclw20Gb6K0q1bRHLs7+GO4/ZxOUHmz6FFGaRsqpv79990F7QZkbk6pu7dh1GKVBaGDUIq
	NrUvDlJf+k/FwXCElIJ5hHvcb+baoE+1il2D6mp/N4ezGrZu5SOs9hy9PPQg24Q0qyQ2LLy
	rbOP07FxF2yg6J1cGw0D++m31py1M73N8uhpBdIbGpvQ2tf2u1HvxHDVrpKJ6OrSmNJol17
	rB6+hbvLn569akBFU4GHDELFdJ6BLUs6uOrxex6wPggrLtAu7iAtZsScUCuB/lJRoF6cTrb
	O129I21AKc//6ys1d05fI/Xhj3gvpGnUQx8tpORzzvf+gjZOEHa6Mk+GG3Sdz30ofuAPqZX
	2AZ330YKHyzT4OKi3aJ0Oqx+xmmkLzUwcfhkmdkiAsX5+WhD9hr3xiNrDjSB9qAkSugz11i
	+OSwECdElpxaD9pv1cQZSUcVHlkihoqrRtKzUtBhtR813lJO/qgXtZTyebZb4dWdRKDamVL
	N7T+Fv1KBH3kuPA29SBbAkzb3IN/tbB3/2IOMJSk3xPVbJh9+CcgFzrQ+7tHaqNGEy+Rynd
	yRHtuJEd9ICU3nrNUqbASratnF1BZzuh/o5cPbEiE9RqsX0AoWJ2MTAe/tYApnWBAk4BDCy
	McJcUQWGzM53r5AoTa1wokYqxhzkarSZoVbktMuIgPsZySmmsqf+aLBMNuz7lN0fCqs7R4z
	hD6LNyArs3V7pIMS7Kp3L+IwlJJLzodud/zB7TJ5ioN+kbM+xT17E0Q0jN+FeFsAYyFsGZI
	BM01wIHjEyemcZ1kffzumoMKfYWDj4s+k9F9ogEM0H1ahtG9WyGXTAa1Uu9jQy6zK57PCYq
	67j41CXtMjix738X5SkdwsdKQDhlS4p3DO+W76XdSTsOMlqmIer3BcnekuIWNoqlaHkldZK
	B0WBIH2j6zqEKbtczFry1IQQ07cLYKkyZVoMwyPcJmlKjYAryXGjYTDsywkEh8T/QOXGa5q
	HlDJIuVKAtm04y0xz2zXdyRgnMGFFj57q3H9DQ7nj3rf1npdLFNa44=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

queue_init() initializes default formats for both the source and capture
queues.  It first sets the source field to V4L2_FIELD_SEQ_TB, but then
stores the capture default, V4L2_FIELD_INTERLACED_TB, in the source queue
again while initializing the capture queue.

This overwrites the valid source default and leaves the capture field at
its zero-initialized value, V4L2_FIELD_ANY.  vidioc_streamon() accepts
only V4L2_FIELD_SEQ_TB or V4L2_FIELD_SEQ_BT on the source queue, and
requires the capture queue to use a compatible interlaced or NONE field.
Userspace that relies on the default formats can therefore get -EINVAL
when starting streaming.

Initialize the capture field instead.  The bug is usually hidden because
mem2mem applications commonly call S_FMT on both queues before streaming;
the TRY_FMT paths normalize the fields and S_FMT overwrites q_data[].field.

Fixes: 8f0755c06b90 ("[media] media: Add mem2mem deinterlacing driver")
Cc: stable@vger.kernel.org
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org as suggested by Jacopo.
- Add Reviewed-by tag from Jacopo Mondi.

 drivers/media/platform/m2m-deinterlace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/m2m-deinterlace.c b/drivers/media/platform/m2m-deinterlace.c
index 1d0e70eaea3d..9dcc4bd6cbdd 100644
--- a/drivers/media/platform/m2m-deinterlace.c
+++ b/drivers/media/platform/m2m-deinterlace.c
@@ -822,7 +822,7 @@ static int queue_init(void *priv, struct vb2_queue *src_vq,
 	q_data[V4L2_M2M_DST].width = 640;
 	q_data[V4L2_M2M_DST].height = 480;
 	q_data[V4L2_M2M_DST].sizeimage = (640 * 480 * 3) / 2;
-	q_data[V4L2_M2M_SRC].field = V4L2_FIELD_INTERLACED_TB;
+	q_data[V4L2_M2M_DST].field = V4L2_FIELD_INTERLACED_TB;

 	return vb2_queue_init(dst_vq);
 }
--
2.50.1
