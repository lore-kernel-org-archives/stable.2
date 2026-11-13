Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794584255;
	b=rHfswgzZk86/m53IZZtsmk8A5TnmPAWfZl+cPFo4VPmY0iYWaZpFs12ltLmmJZWOygjE
	 qsDgzz9kRXN9ZYb85tljr4NgqPzxFY+IKyXM3cS9oGwXuxNk6PVh2rDHKngHqBzLK7vF4
	 COdHhv7B3rx4hisIpwXCoQcUfFRru6jAwp/tHobpyOPjzajb5WLPT0zrokUJQqnZ4r5T6
	 tpqQQlE3/tX0+3UMJlIt5foLUQxRYHZgqxT/Ve5OOLvF06tU5juCTPq84Q+6dx7+NRXEy
	 dF/TAVPWZ+lHPRBUoGhSDE8kuIgqEm69CGSxfqP8GHYxl+8MkfeLCx5H9An9ajNP2jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584255;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z9LVjNOdMQXy4dVc1hY5/8F3vca7YGl8VxbQdnJ9Aas=;
	b=E+iM0KJ9By62DqjtWhunTxr3+bdFlpv10BRa7z5WZsgBSYRUX73u4bvXA3vT/DzFtIiJ
	 FgwSWsLmmnMmT3eCel+yPlvF4mN5cW6gzlmr1HNYplQa7qTcFiGYjN7fS91w2LmKTO0Kc
	 3W1cxy0c3ao/3ut5ARyEi5Vt7sVpxa3unENAZoec0OUTcHYfwfI2joqAsyMsdCXn/0FP6
	 RGae2EaKhXdOqa/Evi+GRl/RMtqnr/2YFmzHmSsnXfdvRMAIrBz1m4ocd5426VceglyGX
	 haBd++iGv/x5nEW3BOJLh/q8aTIf0Hd3XmbJGD1KuU3LJKmEUDmMSMR1eZJX2mmVEmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O/m9T7WW";
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E075606A336;
	Fri, 13 Nov 2026 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O/m9T7WW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794584255;
	b=SWcDpEnTo0gh8KhcWRutn+aKjJNHWsOvRjq4js2ajjkWfBadoO76wl8ci0tgu6w9te16
	 1Oc9QO3/mE16SvBReQucpCXj6BKHcPUZGO6Cv0CTw/octbG58EU1vK3oSQ+IHsnwh3pyy
	 myTD0dIC7CqUCAeUw+x3rLfLlAQblBHISbz9i2trW5hMk8lwf57jnnva5DwIQ70E1Xc39
	 ZaFIv48TfyyFQ9cs5sAvLPwBSg4nfwSNsT4mybgA+oRIKLXNds3opJkAXgEcBn+Oz0AXx
	 yAMwHSiq0zWfcaZxMRDGCCzaUBcOQFyJdj/w+lzVg1+6mOQpeBpl3j/+8Q9SdLIr1RQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584255;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z9LVjNOdMQXy4dVc1hY5/8F3vca7YGl8VxbQdnJ9Aas=;
	b=UFHuuabwzj5VF361DebmmiEPCHTYVVo8qm+v/VqjuuI0SuT/5JkHPeMkS1dxlljU7tWT
	 dFqWuq0HheXwwyg6+WwNSRbu7Nnmgy7G3gC7AdIC02+Z5BR3Xn70TbBuAyBSXLOJKUY8w
	 oU1oqJE6VuC4nyoW0Gbopa83Aw614zsXJm1NddsjJKX3ostzDWkgBfIz6jrD1H2nxczeu
	 VXYXNcsc2QKLgl3TUK3dXLpCIbLwxR6JhEHyFvHq7GM7qisdMCRGwaCuuOsMSwr4MicSs
	 fwce/EhSmAueUqbiWm6O/1uakVSjvPgCeouhXDD6TnV/KWO+ifHYDR3Y006zkMVcrVA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CF9F81F000C5;
	Fri, 13 Nov 2026 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584255;
	bh=z9LVjNOdMQXy4dVc1hY5/8F3vca7YGl8VxbQdnJ9Aas=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=O/m9T7WW4AEqsWLF7uaxMwMxRpD777I+sAHRhc01zMliCUR+mGoRCJw8imOl4kmM/
	 ZhFvnMZWP+rx3TGUOjPUKHn8huQA9FfCNNwCDTxsgm9DP/WbG6RHFTURM8a4/mFHWB
	 GeEejohPW7fBpJLvP1Eq+6OcMzgpGqBuDtoJlVcU18bAhHShr7WGBTKv9vHgIJffEW
	 h85cNPu60Azp8OGSvtd1fxgGE5zfw/9kW4ZLGsdCg1xlVSwuLvKVQ6kWfCruWpSVFv
	 96aItUSE39XxDm0uSTC+ms0u01tgbH8BufdfgbW6Vtwi0OFo+GnycNzOJK/p1vBmCd
	 qMFLb55upvoUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4F2D747810;
	Fri, 13 Nov 2026 15:37:34 +0000 (UTC)
From: Davide Vitturini via B4 Relay <devnull+mdvitturini.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:37:33 +0100
Subject: [PATCH] media: staging: ipu7: isys: close the firmware stream when
 enabling the source fails
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
Message-Id: <20261113-ipu7-isys-close-on-enable-failure-v1-1-3473e098115b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQrCMBBG4auUWTvQRIzWq0gXMf1jB0JSMrRUS
 u9ucPlt3jtIUQVKz+6gik1USm4wl47C7PMHLFMz2d46Y8yVZVnvLPpVDqkouGRG9u8Ejl7SWsF
 uCo/b4AYbg6XWWSqi7P/HazzPHxzY5tpzAAAA
X-Change-ID: 20261113-ipu7-isys-close-on-enable-failure-6dc859692fc2
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Davide Vitturini <mdvitturini@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794584253; l=3670;
 i=mdvitturini@gmail.com; s=20261113; h=from:subject:message-id;
 bh=7DM20gbywDQPpG7hvrpaxI9Untar2fwINYVnL+pTASQ=;
 b=VKTVo4DwVQ0O1UizNU9kjONMX6xMH8fLXv9Mrq1uBBdWzccM2fcNnM9aayAoDnRouxlybBsNt
 4qOp0KGm3jGCleg8pTcAiBELvADcIZCceL9oj2i4FbV7/EZAo2jbnL8
X-Developer-Key: i=mdvitturini@gmail.com; a=ed25519;
 pk=qHGCynxkIIOSj9Y1SqEb12yeOmEFSgLKtIUxOhZ2o2U=
X-Endpoint-Received: by B4 Relay for mdvitturini@gmail.com/20261113 with
 auth_id=1511
X-Original-From: Davide Vitturini <mdvitturini@gmail.com>
Reply-To: mdvitturini@gmail.com
Content-Transfer-Encoding: 7bit

From: Davide Vitturini <mdvitturini@gmail.com>

ipu7_isys_video_set_streaming() opens and starts the firmware stream
(start_stream_firmware(), which increments isys->stream_opened) before
enabling the source subdevice. If v4l2_subdev_enable_streams() then
fails, the error path only flushes the stream with
stop_streaming_firmware(): the firmware stream is never closed and
stream_opened is never decremented.

Since isys_suspend() refuses to suspend while stream_opened is non-zero,
a single failed stream start (e.g. a sensor that does not answer on I2C
right after power-up) blocks system suspend with -EBUSY until the next
reboot, even though no stream is open any more:

  intel_ipu7_isys.isys intel_ipu7.isys.40: enable streams Intel IPU7 CSI2 2 failed with -121
  ...
  intel_ipu7_isys.isys intel_ipu7.isys.40: PM: failed to suspend: error -16

Close the firmware stream in the error path too, mirroring the stream-off
path (stop, disable source, close).

Observed on a Lenovo ThinkPad X1 Carbon Gen 14 (Panther Lake, IPU7.5) with
the ST VD55G1 IR sensor: after five failed stream starts suspend was refused
until reboot; with this patch applied suspend/resume works.

The leak was found, and this fix written, with the help of an AI coding
assistant (Claude Code, model Claude Opus 5.5) while debugging the failed
suspend on this laptop. I reviewed the change and tested it on the
hardware above.

Fixes: a516d36bdc3d ("media: staging/ipu7: add IPU7 input system device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Davide Vitturini <mdvitturini@gmail.com>
---
How this was tested (Lenovo ThinkPad X1 Carbon Gen 14, Ubuntu 26.04,
kernel 7.0.0-43 with the staging ipu7 ISYS rebuilt with this patch):
- Reproducer: a test-only module parameter in the out-of-tree vd55g1
  driver makes the sensor's enable_streams() return -EIO, which drives
  ipu7_isys_video_set_streaming() into the error path:
    vd55g1 i2c-TBE20A1:00: test_fail_streams: failing this stream start
    intel_ipu7_isys.isys intel_ipu7.isys.40: enable streams Intel IPU7 CSI2 2 failed with -5
    intel_ipu7_isys.isys intel_ipu7.isys.40: stream stop time out
    intel_ipu7_isys.isys intel_ipu7.isys.40: stream close time out
  (The firmware does not acknowledge flush/close of a stream whose source
  never started, so both calls time out; stream_opened is still dropped.)
- The same capture node then streamed normally again (20 frames).
- s2idle suspend/resume afterwards succeeded (suspend_stats: fail 0,
  last_hw_sleep 8.4 s). Without the patch, real -121 failures of the same
  kind made every later suspend fail with -EBUSY until reboot.

Build-tested on media-committers/next (W=1, allmodconfig, drivers/staging/media/ipu7/).

AI assistance: the leak was found while debugging failed suspend with
Claude Code (Claude Opus 5.5), which proposed the fix, the reproducer and
this description; I reviewed and tested them.
---
 drivers/staging/media/ipu7/ipu7-isys-video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/ipu7/ipu7-isys-video.c b/drivers/staging/media/ipu7/ipu7-isys-video.c
index 8c6730833..024d43f60 100644
--- a/drivers/staging/media/ipu7/ipu7-isys-video.c
+++ b/drivers/staging/media/ipu7/ipu7-isys-video.c
@@ -831,6 +831,7 @@ int ipu7_isys_video_set_streaming(struct ipu7_isys_video *av, int state,
 
 out_media_entity_stop_streaming_firmware:
 	stop_streaming_firmware(av);
+	close_streaming_firmware(av);
 
 	return ret;
 }

---
base-commit: ad6549a46748d00818483b535e5cd2a704685c98
change-id: 20261113-ipu7-isys-close-on-enable-failure-6dc859692fc2

Best regards,
-- 
Davide Vitturini <mdvitturini@gmail.com>


