Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D8421247
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791108481; cv=none; b=ooBts3XeebVL76roIZjneSPDx4Ebm8uAqFRKO8WpRsEBHOgEn8TvsU69Cts5v/uzczQPCQcPxLKZuzdqRkt5/pGIgZEU4bmtOFfnyqczPzHjef9uzvfx4VmbUltm/8DDkGLFLEQYEbA3yf7HWmqq3YCtLOHzStXA+3mBS1FIBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791108481; c=relaxed/simple;
	bh=fAQubV0KGt+mvnDqdtN32qJ6AxjvJFXfRppXX/2h2Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0HgDZHAhwb9vS0CPD97QEef2VUa8mMp3CrMiQD4354SpW0PsHEEGtGnKUycoO2IE3ubnBg7W+SVfG6zwyw64xgVfWEjxxdsSAc97klTWfCqH0Zi8DV3OZARNIsp2GDTpnwEYfQ9SqmoIWBUeI7K4ojZ4ryZivRz52dSvXFru4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibJ7zoyc; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibJ7zoyc"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c4f4daso694912f8f.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791108476; x=1791713276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwYDZcDVJkVuXt8AODa3dug8Nr5ODjsbg15/2zj5OhE=;
        b=ibJ7zoyc8BfVpUoDWJClQRqLKN9RqG2aIRrzfCRNyyYkb7+S6TDvCMT02pYNxc/BV2
         n6cFPhnmZq5MZ93EvOLeiTEvzBHCPSUwxei3SZh5ARqS0JE9BD6KjRyBKPVqVjhgsTea
         +UjBEB5ZleETVOW56ZqQFVl/qV2sdqr5CIKWklD8t9+VSOAU9XnTX9FpgnBXSOT2fS8w
         RyJvE6uV4Dw2ZOcHHH165y3tbKy59hD0v7YXSCGh3AJH950bKh4SqIrKggd7e7FSI4/Y
         Mo1ZOR0k4bHrOSKtGh3HAMaODG7KedMxV8cMMzTEMY9X4JRigxL2csMyxnFVXA2A6pI6
         dEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791108476; x=1791713276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwYDZcDVJkVuXt8AODa3dug8Nr5ODjsbg15/2zj5OhE=;
        b=n7ab18ooGtPNSINuKzg8ysTIRck8h+mjeDPX+ZsyP1THKPQPcjcGSgFT7V9sRtEbSn
         Q3tXEBdakezDAIuMl6yV/nqB+AHEfZagcJd1bNDzi9CrUAPANYnXzqFWOm5l3FIPMoZe
         vt1nHbVNwMnEdvVg7pF8L7dC8EPGJFulx2DzvA+lFOWlxretzz/oT6OtszBri4pUi0CH
         wNcB3RFXxh9Fjh03Ba1gBxnLypBx5jgyUxGp4xBnxtFXTMmaDD3QDQ8aALZkyi3Ou8Qt
         5Izr29Pc45dDidmrFVesqzxXxWef2k1sfB7imUVLoEFJI9D/2OeT4dDYtsrdOU0/HCZe
         8lpg==
X-Forwarded-Encrypted: i=1; AKwUvBxhC/ahENnOFHZy1zOL+9aQdtpojYYiNIfS/7OBO62AI6R4aHtNCVzZ3ZSq1exKYUyKzsksgQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCZZL+2qci1iPmuUbnWUyagBs/DPVd4xsIvBQ95DBkirgIWQzh
	zr+PdTrdHl/wIt8wSJ4LfcZsX25PjYbTb1VoirO/QdDOupNDLHHnxyjk
X-Gm-Gg: AYBFou1WDRSK3ruk1W7+mTPLmfjUi30PnnCOiRkdRX3356ZrA4RuwNRfLBrN9Y0BczQ
	bfeLcGy/mKg6DRJZvM3Qi/k/+Z0WQFmS1McyXtOm4AUE5p8IezBuTxMG53idM0qcR9o/bIW6SB5
	tRrYmw1pxUym6wtstSVPbNfAn/9kjE+N0WWP6KAgyFkUoGpyIsmO+RI0kjvKqzIQdIOcSzmN5ZI
	bvJBU5UVUUFbidce/OrRV8xNwK6Re+Gr6xTojR34aZhm03LsvOan3Yq+fVAU3rD0MIJw7CZe8rZ
	wuxRqBpzFi1nyR41RLYZJmajOWZWKIt5vryknw9FrEMoIaxWEK01bA8Xysw8V/6hu9wTD92SJYl
	/qSCC2jEvmiMRLNA6vgx6e0Trj8eI/kP0+UgWsgJZ0N6aNPSka8Zt8t4ZGaGTq0in+hQeEvVnPa
	LUmR2f1w1U2AhKMF5VXaLOiOnq5lKKKF3vzJzpmcc9p7XE9yDGdULDthcqavmT/AtrF4U8HwcCC
	QL8KuUr9FVaso7gWzVOB9GY9WOXKWv248FhYkk3pzE+qjSzTBNrFIorolR80sm/z6gUMlTGoMd9
	ZpKcvhVl+5pd+B7FX4TxToTlWQi6L6E5Cn10goZd015tlmMe9VCaX4cHNyN6CBp8odhzoE0D5NM
	pV8lFslzAI04qwRyX/ED2/88VewTDq5UN
X-Received: by 2002:a05:6000:2909:b0:48a:fc9a:3765 with SMTP id ffacd0b85a97d-48b1273e480mr13971030f8f.46.1791108476108;
        Sun, 04 Oct 2026 03:07:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a00-1028-c000-0ddf-b17d-de75-1ac4-0a1a.ipv6.o2.cz. [2a00:1028:c000:ddf:b17d:de75:1ac4:a1a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104602sm18136032f8f.26.2026.10.04.03.07.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Oct 2026 03:07:55 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 5/6] media: dvb-core: dmxdev: wake up readers on release
Date: Sun,  4 Oct 2026 12:07:40 +0200
Message-ID: <20261004100741.71711-6-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004100741.71711-1-pepe.schlehofer@gmail.com>
References: <20261004100741.71711-1-pepe.schlehofer@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dvb_dmxdev_release() sets dmxdev->exit and waits for open demux and DVR
files to close, but readers blocked in dvb_dmxdev_buffer_read() wait
only for data or buffer->error. Setting exit therefore does not wake a
blocked read or epoll wait. The release, for example on a USB
disconnect, then waits forever.

Wake the DVR and open filter wait queues on release, and make
dvb_dmxdev_buffer_read() also wait for exit and return -ENODEV once it
is set. Also return -ENODEV from dvb_demux_read() once exit is set, as
dvb_dvr_read() already does.

Check exit instead of storing -ENODEV in buffer->error. The buffer error
is cleared by the reader that reports it, and the section timeout and
ioctls such as DMX_STOP can overwrite or clear it. A second reader of
the same file could then miss the release and keep it waiting.

Blocking DMX_DQBUF waiters are not covered.

Fixes: 57861b432bda ("V4L/DVB (5511): Fix 2/3 for bug 7819: demux and dvr")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
v2: check dmxdev->exit in the readers instead of storing -ENODEV in the
buffer error. A reader could clear an -ENODEV set concurrently by the
release, as reported by Sashiko [1]. The section timeout and ioctls
such as DMX_STOP could also overwrite or clear it.

Pre-existing cases remain where the release waits for users that are
not woken up, such as a blocking DMX_DQBUF, or an ioctl that waits for
the filter mutex of a blocked read() while holding dmxdev->mutex. The
unlocked users check in dvb_dmxdev_release() also still races with a
concurrent close(), and waking the readers makes that race easier to
hit.

v1: https://lore.kernel.org/r/20260923001410.30297-6-pepe.schlehofer@gmail.com
[1] https://linuxtv.org/mailman3/hyperkitty/list/media-ci@linuxtv.org/message/N3XJE5MO4HP2LJYOKFHIRB564HATZCTI/

 drivers/media/dvb-core/dmxdev.c | 36 +++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 6a825d9bae43..8a744a96bc08 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -50,7 +50,8 @@ static int dvb_dmxdev_buffer_write(struct dvb_ringbuffer *buf,
 	return dvb_ringbuffer_write(buf, src, len);
 }
 
-static ssize_t dvb_dmxdev_buffer_read(struct dvb_ringbuffer *src,
+static ssize_t dvb_dmxdev_buffer_read(struct dmxdev *dmxdev,
+				      struct dvb_ringbuffer *src,
 				      int non_blocking, char __user *buf,
 				      size_t count, loff_t *ppos)
 {
@@ -75,10 +76,16 @@ static ssize_t dvb_dmxdev_buffer_read(struct dvb_ringbuffer *src,
 
 		ret = wait_event_interruptible(src->queue,
 					       !dvb_ringbuffer_empty(src) ||
-					       (src->error != 0));
+					       (src->error != 0) ||
+					       dmxdev->exit);
 		if (ret < 0)
 			break;
 
+		if (dmxdev->exit) {
+			ret = -ENODEV;
+			break;
+		}
+
 		if (src->error) {
 			ret = src->error;
 			dvb_ringbuffer_flush(src);
@@ -274,7 +281,7 @@ static ssize_t dvb_dvr_read(struct file *file, char __user *buf, size_t count,
 	if (dmxdev->exit)
 		return -ENODEV;
 
-	return dvb_dmxdev_buffer_read(&dmxdev->dvr_buffer,
+	return dvb_dmxdev_buffer_read(dmxdev, &dmxdev->dvr_buffer,
 				      file->f_flags & O_NONBLOCK,
 				      buf, count, ppos);
 }
@@ -998,7 +1005,7 @@ static ssize_t dvb_dmxdev_read_sec(struct dmxdev_filter *dfil,
 		hcount = 3 + dfil->todo;
 		if (hcount > count)
 			hcount = count;
-		result = dvb_dmxdev_buffer_read(&dfil->buffer,
+		result = dvb_dmxdev_buffer_read(dfil->dev, &dfil->buffer,
 						file->f_flags & O_NONBLOCK,
 						buf, hcount, ppos);
 		if (result < 0) {
@@ -1019,7 +1026,7 @@ static ssize_t dvb_dmxdev_read_sec(struct dmxdev_filter *dfil,
 	}
 	if (count > dfil->todo)
 		count = dfil->todo;
-	result = dvb_dmxdev_buffer_read(&dfil->buffer,
+	result = dvb_dmxdev_buffer_read(dfil->dev, &dfil->buffer,
 					file->f_flags & O_NONBLOCK,
 					buf, count, ppos);
 	if (result < 0)
@@ -1035,13 +1042,17 @@ dvb_demux_read(struct file *file, char __user *buf, size_t count,
 	struct dmxdev_filter *dmxdevfilter = file->private_data;
 	int ret;
 
+	if (dmxdevfilter->dev->exit)
+		return -ENODEV;
+
 	if (mutex_lock_interruptible(&dmxdevfilter->mutex))
 		return -ERESTARTSYS;
 
 	if (dmxdevfilter->type == DMXDEV_TYPE_SEC)
 		ret = dvb_dmxdev_read_sec(dmxdevfilter, file, buf, count, ppos);
 	else
-		ret = dvb_dmxdev_buffer_read(&dmxdevfilter->buffer,
+		ret = dvb_dmxdev_buffer_read(dmxdevfilter->dev,
+					     &dmxdevfilter->buffer,
 					     file->f_flags & O_NONBLOCK,
 					     buf, count, ppos);
 
@@ -1457,8 +1468,21 @@ EXPORT_SYMBOL(dvb_dmxdev_init);
 
 void dvb_dmxdev_release(struct dmxdev *dmxdev)
 {
+	int i;
+
 	mutex_lock(&dmxdev->mutex);
 	dmxdev->exit = 1;
+
+	/*
+	 * Wake up everyone blocked in read() or poll() on the demux and dvr
+	 * devices, so that they get -ENODEV or EPOLLERR, close their file
+	 * handles and let the waits below finish.
+	 */
+	wake_up_all(&dmxdev->dvr_buffer.queue);
+	for (i = 0; i < dmxdev->filternum; i++) {
+		if (dmxdev->filter[i].state >= DMXDEV_STATE_ALLOCATED)
+			wake_up_all(&dmxdev->filter[i].buffer.queue);
+	}
 	mutex_unlock(&dmxdev->mutex);
 
 	if (dmxdev->dvbdev->users > 1) {
-- 
2.54.0 (Apple Git-157)

