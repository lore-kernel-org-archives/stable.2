Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609466;
	b=2N2bnH6SpGCMYgp7QmIyhMRYRiuli2Nq9OqwDAkdSLYbFbPT5I4yCU92BVNthP7hyvgN
	 5VEVUCu7ha0yLbt4i3vlis9zYQZiFSbpOVszloAVIs8iGanzEqeNCTDKCJL/RwJKIW8+2
	 CUeBa16yZGczLRb77yn3P2L0P37D5rmv/lDq1OOqnRpRHpCfLUMNdhDOoq8n7JTyvejVR
	 05f2KRS5RDxDe2+BF42lzSTjSXWelAQOelx9bQKWSe5adEGKRxAphqr/fxpmpMBCHEvMi
	 ek59cSy2O9/TYXppGEhw3p1wMXIdVLVjBsVsj1ma1RTw9I2ns5RXQG8mb5ZLQ2sqHqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609466;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=70wfmpckLJY7t4y0Fx97f10KuExiQiQfEVKXZ+Zm+bU=;
	b=zFMiSkPxK0lTsFm1nBRyEyM6lo5thvE2da9odl7dzyn3rpxhL6RikCmf/zkf5tHreVQd
	 yVhqGwOgU9F878HZbMIHnWApAldybhPCSmTJx29MueRWfvhiMnwLmf+TsnFq7NVtan2eU
	 Z6NToIx0H2pU7TabQZ7MhD12L9RGklYyDYWEmm2WkGwlYOv3JRGj7kG5PrOQWgDboX9Ps
	 eiYCeuXq1SPusvXCfZZkMg8CfIahASeQ1ma3zBkj8MAgXX6WZc8tJHHecXq26O+NGr3Us
	 dpyI4UCujiFYpLz/kktj2YfUGDXLGF+KMaAxNKCxwUHMdXYsyDGavnIZFl1pCLS01Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ph0EmpHN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7269606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ph0EmpHN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BA41F000CA;
	Wed, 25 Nov 2026 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609466;
	bh=70wfmpckLJY7t4y0Fx97f10KuExiQiQfEVKXZ+Zm+bU=;
	h=Subject:To:Cc:From:Date;
	b=Ph0EmpHN8BDKOxU7naSzm90r5mjrc8Z81nvxXxOfKNdO2pnxi59GlKCoqZ/97F75j
	 3wNfuyJOmFPYB+IBjKMQX99ilGfypkbBh/NqxS0FpKiRNpuKmA37KmLun+zedzErLV
	 R/Z0rlKbyqWC6R9V1qm0+GOrCFFt8vAIIFtyhv50=
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: fix parsing of all FIFO frames for" failed to apply to 6.1-stable tree
To: jean-baptiste.maneyrol@tdk.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:21:58 +0100
Message-ID: <2026112557-lustiness-canning-81fb@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4a141623442888458d147f4e61fe47411c0e4e17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112557-lustiness-canning-81fb@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a141623442888458d147f4e61fe47411c0e4e17 Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Mon, 19 Oct 2026 15:37:33 +0200
Subject: [PATCH] iio: imu: inv_icm42600: fix parsing of all FIFO frames for
 odr change

For getting all odr change events, we need to parse all FIFO frames
in each iio device. Fix this correctly by sending effectively all
frames to all iio devices.

Previously only batches of frames containing a matching sensor event
were sent to the corresponding iio device.

Fixes: f670d4d34773 ("iio: imu: inv_icm42600: fix odr change not caught in certain cases")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 2bf9fc29d7d2..5bff2a3a44bc 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -532,22 +532,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 		ts = &gyro_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
 						st->timestamp.gyro);
-		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
-		if (ret)
-			return ret;
 	}
 
+	ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
+	if (ret)
+		return ret;
+
 	/* handle accelerometer timestamp and FIFO data parsing */
 	if (st->fifo.nb.accel > 0) {
 		ts = &accel_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
 						st->timestamp.accel);
-		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
-		if (ret)
-			return ret;
 	}
 
-	return 0;
+	return inv_icm42600_accel_parse_fifo(st->indio_accel);
 }
 
 int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
@@ -572,20 +570,18 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 	if (st->fifo.nb.gyro > 0) {
 		ts = &gyro_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
-		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
-		if (ret)
-			return ret;
 	}
 
+	ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
+	if (ret)
+		return ret;
+
 	if (st->fifo.nb.accel > 0) {
 		ts = &accel_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
-		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
-		if (ret)
-			return ret;
 	}
 
-	return 0;
+	return inv_icm42600_accel_parse_fifo(st->indio_accel);
 }
 
 int inv_icm42600_buffer_init(struct inv_icm42600_state *st)

