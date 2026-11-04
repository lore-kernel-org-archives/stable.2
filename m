Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801912;
	b=CMxgGb0P+TDCygPSpiL/SkrccSBaIrh4vsbbsvTbWvtX9wvJ/4oohb0T4wn7D1cGlf6b
	 2PzF3TzgjygzNjo0Sl75oGoEfdTIiro2ZJPQARqUjQSVP0fmgywFqdRM+uW7eAS92C79q
	 O6KGLkEvbqIgHTrz5x76JynV/Tfr8LzDNErEpZ4KPBy3PBYzvho/iv06WzzmToSr46wcJ
	 RMXNU1gERsfC4zjiCB5YwpML8QLBdnvp+rUOqwOSG4nzgp0xghScRQYmxJHwvItGYKcXb
	 +nrV4Kr2ShnCTD1tqGt3OzWzIJ4CjnJwzTYTUwp+ZyJsQ1wQzxNXp7foWm1WgvO565Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801912;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=v1ha+56iee7VQ/drYoLJEq2S4n7wEEKHSa9n0kp5jr0=;
	b=JCfIn2Nu/Z/Opd2mInSUUprFeB7txyZ8faSqgCQ6sakplXmmw4FOQ/EfWHszpE0SeEmb
	 1UdiY/VsJ7r1c4FQpZyy824agy55lWPXPZyTEggntleGyuI0X6awmYAqt+9lnLLiCEcTF
	 W1/OaTDQm82kbsk2tJVbQpcp6zaSOjxYP3nCz8C3P4giev6CGmMwJHLmF0V904GgxnuMt
	 gj329grlI4KJ4tlZuvuTFIPVgTY3PQ5GMuUAlCHaSOlOWshy2T+HZhD6T1NCy5gL+S4Fe
	 /I1NQVY7AJI8/FyV35oFOF1C3nYlWabnpsCGYp+kB6BjzMYhPJoU298IKiYRnmz5ung==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="dj6uHvd/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951FF606A333
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dj6uHvd/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2221F000C1;
	Wed,  4 Nov 2026 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801912;
	bh=v1ha+56iee7VQ/drYoLJEq2S4n7wEEKHSa9n0kp5jr0=;
	h=Subject:To:Cc:From:Date;
	b=dj6uHvd/mklhbPVBzaLLaJz6pDO7F/TO4nNOmzMTAjYR8fVYYDCGKAjVJ2sFbmip6
	 sNZynbOp4nwAuau21jby7y22SK2+tvyRAnGehZ27/ynnlRpgDIIkT2EPG4uIdDUyOG
	 LEpZikvAkNf1CCTNeArW96s7DGSKgw76ks7rfjys=
Subject: FAILED: patch "[PATCH] media: s5p-mfc: use timer_shutdown_sync() for the" failed to apply to 5.15-stable tree
To: fanwu01@zju.edu.cn,andrzej.hajda@intel.com,hverkuil+cisco@kernel.org,m.szyprowski@samsung.com,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:18:27 +0100
Message-ID: <2026110427-decoy-mayflower-3cb6@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 63069b5917cba2e15b1a78b3f4ff99e45102c56f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110427-decoy-mayflower-3cb6@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

