Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7E364EA4
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925698; cv=none; b=gPlQ8PKM8asO/md/T30QxQo5XbCMC0lpqObunXDicRPuuSSJkmi0wegO4Reyg7VDa3jntzchlgwsgvAUnd5RlfokhhmBf/lZsVVbcdeodxWcf/xAbMOZ3np1OXjUqpr20D30lYbM6EPFStqy2+iLQNNAaHuu5z0KXhFL44MTnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925698; c=relaxed/simple;
	bh=PzbXWJQs72R9iV99XX9jksyQUQ+nRv5EhQapM0F3FKw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QsTJ+0LddROTOKFcyh29I9KCuk4rZhJSbno9xzZZeDTXegCsTTcCwgQcj5RNihxBJePIQXGpkVUiNx1qtYF6YVpVSJ12+KU/PgE5+3Mklh4HoiaaXwvWq8qdoTw0lTG3uqItsUR+pW+peBJrnTviH0N11NwyQDBUCSZGXQX3HCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TV3dIdxy; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TV3dIdxy"
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ab4af22d09so895468b6e.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 13:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784925695; x=1785530495; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iajl6b3K8rXMmm9gJwdCmJTZEBGl8q0xqBBTV9E/nkk=;
        b=TV3dIdxyMzImq0rmOMOVfzx7v095aWPcmXdttXdbYawpoHLU1JpU7c0MWRAqQGNkFj
         83yKEbnKgJAW8D7MajYhV/hXqAkQm3QtkMEC8E+hn8Z0Ie6vUYQjpY9RdrBvuEX+Ujav
         BCplSPd7eL1DDSWxdUUoBMA+D++DaYYqVVMnRi0BSBmVEnTRMPiwSaiUKhdDLztnxnDj
         apvHnN9oByb3ZVJohnjZ0UfgHgKaKYU6u/GfPCSyHCDsWlbFo3B9dk305hPqQhDN7F9W
         559F5qJb8PLA4fpUxBaJItvpdQZwrJwRboS/2d1C3gYr4LQdVsZ4tyMkonsJxdyXcc6B
         Gliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784925695; x=1785530495;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iajl6b3K8rXMmm9gJwdCmJTZEBGl8q0xqBBTV9E/nkk=;
        b=LpZdvrZhOSoRCR8sUqt6GerDyMYbTcCbwFPvkyJTqKdWnqrETsTINwpSJEQGc5x9lx
         A15MMgbYdNwhJu3mJpoVP4fNutRJO2iLBT2jnPC/5dC8X9ZtjTVPcISGNX3brpr4kQ47
         GTlNptAfd809pVRvzEpI+6o/h6LxJXHDSFwXcezNusc4DQryfVaKirdC9T/3ngnisZW9
         MwDDolpTB082UYWTe1MGcoXNXgvNMedIuNap4gF2sJhrrI6A2oaFM87FzSFTEfWcGsLY
         uKul6hMgjAlc9rWJg5lMZoWXeWJA7zT0o7lNWqkz1AqxIcCbRitz+JFCIhuLdtuPflvA
         bmwg==
X-Forwarded-Encrypted: i=1; AHgh+RrjZoxCyAcSnahzhDixBSMIJitPVoyouIIYvGJdwUAUAmNWcfzVFnu1KHReEtk82KryE1OEIqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBwo6igtmaaZ8bdzw4y0xmbC7usQbSeK/2eEAwYO1uGOQkmyw
	xIhxxokskJwOVQDT/w52OS0tAC2e+Bz2bUbH2zl9IstL01ibbhgna8w6Aaw1KoxRb+EafLBA4bd
	2GlK+Ak+Rfg==
X-Received: from jaqt21.prod.google.com ([2002:a05:6638:1f5:b0:5e8:f77c:fa88])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:180a:b0:497:cd5c:7f0b
 with SMTP id 5614622812f47-4ab6a1bbb09mr2339b6e.30.1784925694976; Fri, 24 Jul
 2026 13:41:34 -0700 (PDT)
Date: Fri, 24 Jul 2026 20:41:16 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724204117.4036015-1-nkapron@google.com>
Subject: [PATCH] usb: gadget: f_fs: Prevent deadlock during ep0 read loop
From: Neill Kapron <nkapron@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michal Nazarewicz <m.nazarewicz@samsung.com>
Cc: nkapron@google.com, kernel-team@android.com, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, ffs_ep0_read() holds ffs->mutex when it prepares to go to
sleep waiting for an event. When no setup events are pending, it calls
wait_event_interruptible_exclusive_locked_irq() with the mutex still
held. The wait macro deliberately drops the waitqueue spinlock before
sleeping but does not drop the mutex.

If a userspace daemon is polling ep0 via read() and the gadget is
asynchronously torn down via configfs (e.g., echo "" > UDC), a
deadlock can occur:

1. The configfs teardown calls functionfs_unbind(), which queues a
   FUNCTIONFS_UNBIND event.
2. The daemon wakes up, consumes the event, and drops the mutex.
3. However, if the daemon loops and immediately issues another read()
   before exiting, it reacquires ffs->mutex and again goes into an
   interruptible sleep.
4. Meanwhile, functionfs_unbind() continues execution and attempts to
   acquire ffs->mutex to tear down ep0req.
5. The kernel deadlocks because the configfs thread is stuck in an
   uninterruptible sleep waiting for the mutex, while the userspace
   daemon is in an interruptible sleep holding the mutex forever
   because no more events will arrive.

To fix this, we drop both the waitqueue spinlock and ffs->mutex before
going to sleep, and use wait_event_interruptible_exclusive() instead.
Upon waking up, we jump back to the `retry` label to safely reacquire
the mutex and re-evaluate the state machine. By not sleeping with
ffs->mutex held, we natively decouple gadget teardowns (which require
the mutex) from userspace polling.

Fixes: ddf8abd25994 ("USB: f_fs: the FunctionFS driver")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
---
 drivers/usb/gadget/function/f_fs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 073c4cbd90fb..cfa05266e551 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -551,6 +551,7 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 	if (ffs_setup_state_clear_cancelled(ffs) == FFS_SETUP_CANCELLED)
 		return -EIDRM;
 
+retry:
 	/* Acquire mutex */
 	ret = ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
 	if (ret < 0)
@@ -585,10 +586,15 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 			break;
 		}
 
-		if (wait_event_interruptible_exclusive_locked_irq(ffs->ev.waitq,
-							ffs->ev.count)) {
-			ret = -EINTR;
-			break;
+		if (!ffs->ev.count) {
+			spin_unlock_irq(&ffs->ev.waitq.lock);
+			mutex_unlock(&ffs->mutex);
+
+			if (wait_event_interruptible_exclusive(ffs->ev.waitq,
+							       ffs->ev.count))
+				return -EINTR;
+
+			goto retry;
 		}
 
 		/* unlocks spinlock */
-- 
2.55.0.229.g6434b31f56-goog

