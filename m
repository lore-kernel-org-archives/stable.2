Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801914;
	b=eQogs5gh2BKNcc1tApVnUQxMfSeD4Kmh/kkQa4Dt+1Jjnve+wddP72QI7dRbKlbnoC/Q
	 kpZPuocFX8RxhdAgqddyGXCfdeXidsTbFSFWCpyz5SjTRDuYGgTEGEuAwbJppV4oTol0F
	 J28hf3sSQZ17hsX0Q5csD0sr+cCo3Ei5F1D3FOo6pg8Tfb0rTql2vjCYioaDdFvm97LRV
	 KpM9somKZtkVpwTMQbdTF5nitMzs60IcwCw9mcDCs61eXyDoH6LYIbWbmHnsGi4yi+ZNJ
	 V48F3HOJjurwy+5kY/Ni83j11M6LRHppa9/mgMHrKCA9c6QjHsgytGMZeuxGBwKXwRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801914;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/mAR6DIQF4n6iKkCgVzakzqEPcFoMbSI/NyCLtuW6wI=;
	b=Ti3dOv0V0kiHu93kHz3SC77w1D5RE3rctWX1vg7nkmQGIEXHAb9wGjTbS1Ks4zMSIRrL
	 peSrE2u1SzryoktHb0N0jLmga68VYe3TwV3tRidGPJq2lj2BCptZHm+uC4iNbS6sfix50
	 nHLxbHmriwTqFfw9cAi6h13dA21BMWb0KaM1tMbhIiBW8nu/M7OhzVUGgU5Hy0B3LMxnw
	 Y7szWOGDkVFSi+82BwvcSBnKRdaWnk6d5H+nMKydMS8lsOmIRfnc8QH6bSvG+BX8x2RmQ
	 bguxVCWqnyTJ6AKeosT2x2o77KouKZj7ZQfi8evqfqE3axAw7f/k0IwkkWYuc5oy7OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jEdj7G5M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAE606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jEdj7G5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570631F000C1;
	Wed,  4 Nov 2026 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801913;
	bh=/mAR6DIQF4n6iKkCgVzakzqEPcFoMbSI/NyCLtuW6wI=;
	h=Subject:To:Cc:From:Date;
	b=jEdj7G5MQvDROCz7VNuqDTu2r81J7qw4Ip/xqsxebv/p1qSzwgjwDIOFFd6N9LFnn
	 67Igpjv5Kt1ygJNP38elsGgght+FP/r1aqFgiPyHKeHI1dNQVeDgVjoXPE0p4vxCcy
	 fQZSaJiSVI1l0DqGs0f3FGrzNo27yVh2/I5ROWtA=
Subject: FAILED: patch "[PATCH] media: s5p-mfc: use timer_shutdown_sync() for the" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,andrzej.hajda@intel.com,hverkuil+cisco@kernel.org,m.szyprowski@samsung.com,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:18:28 +0100
Message-ID: <2026110428-barbecue-gray-61bd@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 63069b5917cba2e15b1a78b3f4ff99e45102c56f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110428-barbecue-gray-61bd@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63069b5917cba2e15b1a78b3f4ff99e45102c56f Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Thu, 30 Jul 2026 07:15:52 +0000
Subject: [PATCH] media: s5p-mfc: use timer_shutdown_sync() for the
 self-rearming watchdog

The MFC watchdog timer (s5p_mfc_watchdog) is self-rearming: every
callback re-arms itself with add_timer() and, on a timeout, schedules
watchdog_work. s5p_mfc_remove() tears this down with timer_delete_sync()
followed by flush_work().

timer_delete_sync() dequeues the timer and waits for a callback that is
already running, but it does not prevent a subsequent re-arm. Because the
watchdog callback re-arms via add_timer(), this is the wrong shutdown
primitive: once the wait returns nothing guarantees a just-queued re-arm
will not fire later, dereferencing dev (clock on/off, deinit_hw,
load_firmware, init_hw) after video_unregister_device(), DMA teardown and
s5p_mfc_final_pm() have run, a potential use-after-free.

Use timer_shutdown_sync(), which puts the timer into a shutdown state so
that any add_timer()/mod_timer() from the callback becomes a no-op and no
later firing is possible. Switch flush_work() to cancel_work_sync() so any
watchdog_work that was already queued before the timer was stopped is
cancelled rather than allowed to run to completion against the torn-down
device.

This issue was found by an in-house static analysis tool. No runtime
reproducer is available.

Fixes: af9357467810 ("[media] MFC: Add MFC 5.1 V4L2 driver")
Cc: stable@vger.kernel.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index 32eb402d439c..03e7eac8d1f7 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1474,8 +1474,8 @@ static void s5p_mfc_remove(struct platform_device *pdev)
 	}
 	mutex_unlock(&dev->mfc_mutex);
 
-	timer_delete_sync(&dev->watchdog_timer);
-	flush_work(&dev->watchdog_work);
+	timer_shutdown_sync(&dev->watchdog_timer);
+	cancel_work_sync(&dev->watchdog_work);
 
 	video_unregister_device(dev->vfd_enc);
 	video_unregister_device(dev->vfd_dec);

