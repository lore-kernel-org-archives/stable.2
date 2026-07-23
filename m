Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C41A285
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764942; cv=none; b=CgNY4tZYRvpp2pr9R9+A/ZmYdR1Ik3EQHzvOwvDjfbSkLjLbDBK+Z+bX8jCtwMdr3Rlpd4jtnLlQcIx4JUwhFZNl8xhP5x1990Rdas6f5DEvM8U4J5kKIa3ka9qVoLf2VjDrs1x6rNWQ6lcvLgZTv9ctbtaF88ZtQj0fGtVasRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764942; c=relaxed/simple;
	bh=nDHwGQaXGMuuaGG6qOmiW0lE5wNxDly8GUn5XWwT0oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKKU75vw8pk96uLBoA3S5wZzM3jh7W/vqVvLQFY0QLV8XQv446bKHG1zRhvn5U6aNRC3lHBegyTOqT1Ev/r5Iu3B+KnPKnTP0RApFeLJ2VI4R0dgD5sVFqP0SI7QD3AVMseLqSb+32TX/Ebh2dtXC6LpF0PN/U36Z7bd5LhqdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXqeDFA8; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXqeDFA8"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6688a2dceb8so13373d50.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784764938; x=1785369738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aJUm3MLQsqh/2fKr3xOSeTiTlhgXutJ78HCkgaFr/+0=;
        b=BXqeDFA8Pzfq6Ao6Gg5pMiQByUb0LAsjpUj3YZ5tLmbisgz1Xvv+juvbFtUFbwhfs1
         TKvhdFdf/Qgybq/h+7IVWWWtmUJwok9uLuZQn4V46xQWL4t8xlXkTMEIIkHJNUknaxJD
         nbkov+8JY2bGM99lcoMA3SHjiFwmgZH+XpSMrGTrT9Mz2ueDQqRoCtPtlD2dEfjQCnFL
         gRYi0Rg7G53c1MtvIlkos8d7Y5rjqR6oUcNbcfpxJNPdv21z2ANjfk+HUvBCKSv0Ex+Z
         9xwaDNGTflJvjEoS2vJUfyOAmGV0OJLeKmAD4dQ0cGfHVL2P303kNduHYavY1pfsAMkg
         SMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784764938; x=1785369738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJUm3MLQsqh/2fKr3xOSeTiTlhgXutJ78HCkgaFr/+0=;
        b=OxnO7J+NwqXNqlG9KRrzNXDL7s1gKNg67ldLVjPYFfV9xWMTLRyK/+jcUf7mrBpvCn
         aOGRuAHjaVHarQmxuFgWsUeFpP4gsX1E+L9IzyItx5qgR7yeyznEJDIX05jRqsjfolrc
         WDIwVzOkYwGwti5RR9fJDqrv9U2PtFL2rmgEUl2ttXs2Jrt1azn6REM69mRMrmdbDYG7
         Bv5VAPB9c/fD8A93vBLBzTCLXmbL9Qnf9nYCoLAaUERc3++TuonMirXV0NLHB6Ca5GuV
         B37qV4jX1u4FWN0erIp0ILWB4+dxLdbuyQoqxno8RHoXLwvTyjfl8XnNNq/AqvwPjqxy
         UfIg==
X-Forwarded-Encrypted: i=1; AHgh+Rrytu/wfkRGXTchevTBElNRXSwH4w6E+Jjh1ensEecK9MkYciZAiNv5XsZuRGXjGABf5HJzud8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6NDYERTeUkYHdyfCM8HO9UbYHXwQBaYYWS5qoNaUzrp0zbFZ
	tBg7yu9yY6kdscIITgdROoHLeWMrf+XM5CRs0GMmICWf+auOwqztD/JP
X-Gm-Gg: AR+sD13M6qitJxXRf9oSBgH7gPtlBT8sgW3Iaa1luT0CjAOuAmEk2dNSlGGJm6yC0Vw
	e/kIOZU1sDqK1zaFTR3wkSRrl4iG4gdTHQYp+ERDyKVI/BCjz/CVsYA+9lK5wF0KO4AK/HSj76P
	yHllLytCSSaLS8sPIsf1K7stOTZmjKXgN5C+Zb2igqsptzc+e6WE0NYFPUfsatHHuVKXE7QIVq5
	oQna+5rEaCa1imbiIdMYGSs+8zeUgv6kIgyEAsqc24bghGMj0zEKL04jOHG0+Hs2xH5OBwJrv1F
	8jBLEXaCR6YF2fHB6Z4l0yg4P+zcwXQHskwh5TlY5qoXeqLhQ7if1829Trscd4wgF/g5ItJXC01
	w/VW1lku1/f/4FkR9Rd+4lcWptAVXMcEa9ODQUb30AAipT7mTUeNEHfRQvJ4DkopPFZEXE3OQE2
	AwzIGtJ6usprpjl0sXGuMyw9cPKdtEUwBjdNfFlbehIOk5ul95yJG79YwEIOwoe1Cx87G9/LEsO
	2tD4JF/1KKzebfL+N+VEQBDDjk1T7Y/+Am4BA9NUggDfJsJXbmuT9BOk/Tp5JEIq3E=
X-Received: by 2002:a05:690c:6f0c:b0:80d:21d3:a399 with SMTP id 00721157ae682-81f4c307df2mr2454957b3.48.1784764938252;
        Wed, 22 Jul 2026 17:02:18 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local (76-204-101-112.lightspeed.tukrga.sbcglobal.net. [76.204.101.112])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c2df04sm21047067b3.12.2026.07.22.17.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 17:02:17 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: mchehab@kernel.org,
	hverkuil@kernel.org
Cc: kees@kernel.org,
	rongqianfeng@vivo.com,
	axboe@kernel.dk,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] media: dvb-core: fix race between dvb_dvr_read() and  dvb_dvr_set_buffer_size()
Date: Wed, 22 Jul 2026 20:00:16 -0400
Message-ID: <20260723000016.84091-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dvb_dvr_read() accesses the DVR ring buffer without holding
dmxdev->mutex, while ioctl(DMX_SET_BUFFER_SIZE) replaces the backing
memory of the buffer under that mutex. A concurrent resize can free
the vmalloc region while the reader is still copying from it,
resulting in a use-after-free read.

  BUG: KASAN: vmalloc-out-of-bounds in _copy_to_user+0x4e/0x80

    _copy_to_user+0x4e/0x80
    dvb_ringbuffer_read_user+0x141/0x390 (dvb_ringbuffer.c:151)
    dvb_dmxdev_buffer_read.isra.0+0x310/0x3e0
    dvb_dvr_read+0xc6/0x110
    vfs_read+0x1ac/0x940

This is a re-discovery of an issue noted by the original author:
https://lore.kernel.org/all/47E45138.1030107@googlemail.com/.

Fix by protecting dvb_dvr_read() with dmxdev->mutex.

Fixes: a095be4b030c ("V4L/DVB (7659): dvb-core: Implement DMX_SET_BUFFER_SIZE for dvr")
Cc: stable@vger.kernel.org
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 drivers/media/dvb-core/dmxdev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 3c8bc75e4d6c..b4aa8d37ff03 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -270,13 +270,23 @@ static ssize_t dvb_dvr_read(struct file *file, char __user *buf, size_t count,
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dmxdev *dmxdev = dvbdev->priv;
+	ssize_t ret;
 
-	if (dmxdev->exit)
+	if (mutex_lock_interruptible(&dmxdev->mutex))
+		return -ERESTARTSYS;
+
+	if (dmxdev->exit) {
+		mutex_unlock(&dmxdev->mutex);
 		return -ENODEV;
+	}
+
+	ret = dvb_dmxdev_buffer_read(&dmxdev->dvr_buffer,
+				     file->f_flags & O_NONBLOCK,
+				     buf, count, ppos);
 
-	return dvb_dmxdev_buffer_read(&dmxdev->dvr_buffer,
-				      file->f_flags & O_NONBLOCK,
-				      buf, count, ppos);
+	mutex_unlock(&dmxdev->mutex);
+
+	return ret;
 }
 
 static int dvb_dvr_set_buffer_size(struct dmxdev *dmxdev,
-- 
2.53.0

