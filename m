Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801908;
	b=OBF6636ssEGGdkzPlM2YFZ+eV7xT1WsQGGvidR6SO8i0BxvAg3fC1TTOjvP7XBKB6l52
	 SJfO4Lx+hSMqgzU67UaUO/wLNxODF4NmLlux2I6KopIlD7mrsU0blvjcCC00h/qXvygI3
	 NZBPkhbWho0iP9ZRDSNOK8zk9QVPG9qGUFk8kXjPDybDY004mx854/3F3nPgXdDf9IrUt
	 9yYOkSNhUwXxTd+RB0nW7d0nqTach+Ol6m3esxk9rGnMb9EcBcp9JCisAuUpYnr9vO3iL
	 6y0332yY7Hor0XD0J5ppV50MQyKmuQIzIZ35ZlTnTVF2bNPBSaMGLaKyG8xu9z59Umw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801908;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SLvSV9jTfS9V3D4Y+FDOruATfFsKs+TB7/XjPaqNI1Y=;
	b=R12tlMRzZyfwpj3h7Rp7HdQjr6XbnhXiDduepp54vE5cUtNM4Sjft21PsLyrHMG/YwgJ
	 BsmnGtnCKnXDTWJV64wQTo2+DzA+WDyxP1IBXMo0YsOyXCl2+vZoT+THWRsO5OLKdFmx/
	 +V8mZ5xuv2Y4UjWV73LymZQDmG+uGYVIlZZUDVJi0a4VDvFrqJrvwAX+UYZWDZyWeXTYQ
	 ckVt1aNohA3ZDwOKXkWqbafpEynrIQAza9kyBDhkAjIGQ19z8ohTFbvWYPpbw61jg/DqD
	 MJ/JNTvqXibumCvr8qh8C0M3UWtlI9Xqv87m+1GqTpttn17xdCAtLN8ucEEA3xY8FjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Yd54948b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30C606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Yd54948b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A975E1F000C1;
	Wed,  4 Nov 2026 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801907;
	bh=SLvSV9jTfS9V3D4Y+FDOruATfFsKs+TB7/XjPaqNI1Y=;
	h=Subject:To:Cc:From:Date;
	b=Yd54948bz9/3925m7u8fjmdAxnQbB37Fs6aQ94x2FnUkcEeuiYOVz8XMrRrjbqoXv
	 ettj+8DMNhZbh6fEGDHa7vygYk6ypZrGHk9cBDR4vFTkRDrp9zo4H+fYZAef4SFjIq
	 BCLtdBx59Dy8UP04NkjBp++mXaamGbe3hRhDm+BU=
Subject: FAILED: patch "[PATCH] media: s5p-mfc: use timer_shutdown_sync() for the" failed to apply to 6.12-stable tree
To: fanwu01@zju.edu.cn,andrzej.hajda@intel.com,hverkuil+cisco@kernel.org,m.szyprowski@samsung.com,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:18:25 +0100
Message-ID: <2026110425-turkey-reissue-e353@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 63069b5917cba2e15b1a78b3f4ff99e45102c56f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110425-turkey-reissue-e353@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

