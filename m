Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CB636B923;
	Fri, 16 Oct 2026 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119289; cv=none; b=Ugq65aDzNHwByJepZlgqLIe0X9n9gMoYLrwiT7beEZ7ws/JbxtxxjB6GznR9SRz3vgrQ2jzQrKVki0uF81U0RcaEIoVdOLmvT9nUuYz+t7afLq3jDeCOZt7ccs0mA7rV5re3rOhy0Fa7CdD0n8HZuDm81n47YDAeanM/6Ge/qHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119289; c=relaxed/simple;
	bh=eeYDAFiTC661dVfbpUfTb+78ScWy+CrORlGiCnRdYAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ikwzn1t0TKnAg3/NpXGleKAShH2aMmripaUraws4v+iB6w2kyBuZj55pmjhHuYFinbkeOc5I/ZdoQj0Ms8uu6a61rkI8A4ZtMqygkzyZKIGJqThLw5aPKU9aFrgRAWubY3aZpu5hWQSeD9w1jC+nQr+WoKBQJf3shDAthKqh3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=T0WCOseV; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="T0WCOseV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=T0WCOseVbmNTjcNzCoPYlN8RSJ9Idm/ZioIEQHPzfFSSvMK/CF7beP/27Ua8uQbSDSVC5if/YMtfA
	 hvjj2UiqVjHlwpABWxnhXwshJ3G1vKBfpZbqhohf3ngdQZ7jkhGrNuUad0g8lSfUUIbj6ksdxVwew2
	 njC2ZDA/zRyN39fg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36ad191e343c-c5830;
	Fri, 16 Oct 2026 10:54:35 +0800 (CST)
X-RM-TRANSID:2ee36ad191e343c-c5830
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-c950f82eaac8410e-20260515094303939 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86ad191e9bbb-1ed0b;
	Fri, 16 Oct 2026 10:54:35 +0800 (CST)
X-RM-TRANSID:2ee86ad191e9bbb-1ed0b
From: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
To: mst@redhat.com,
	david@kernel.org
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org,
	Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
Subject: [PATCH] virtio_balloon: initialize wakeup_lock before virtqueues are set up
Date: Fri, 16 Oct 2026 10:54:29 +0800
Message-ID: <20261016025429.901-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <0e69abdc-0127-45dc-9bc1-bf48772cc7ea@kernel.org>
References: <0e69abdc-0127-45dc-9bc1-bf48772cc7ea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since c578123e63da ("virtio_balloon: Treat stats requests as wakeup
events") the stats_request() virtqueue callback takes vb->wakeup_lock
via start_wakeup_event().  init_vqs() registers that callback and even
primes and kicks the stats queue, so the lock is reachable from irq
context as soon as init_vqs() returns, long before the driver sets
DRIVER_OK: vring_interrupt() dispatches to the callback without any
DRIVER_OK check unless CONFIG_VIRTIO_HARDEN_NOTIFICATION is set, and
that option depends on BROKEN.  syzbot hit it from a threaded irq:

  INFO: trying to register non-static key in stats_request
  ...
  assign_lock_key
  register_lock_class
  lock_acquire
  rt_spin_lock
  start_wakeup_event drivers/virtio/virtio_balloon.c:150 [inline]
  stats_request drivers/virtio/virtio_balloon.c:435

The lock is only initialized near the end of virtballoon_probe(),
after init_vqs() and several steps that can still fail and unwind
through del_vqs(), where a racing interrupt still finds the callback
registered.  Until then it is whatever kzalloc() left in vb: lockdep
complains about the unregistered lock class, and wakeup_signal_mask
and processing_wakeup_event get updated from irq context while probe
is still running.

The rt_spin_lock() in the report is just spin_lock() on PREEMPT_RT;
any PROVE_LOCKING build takes the same path.

stop_update_lock(), which the same callback also acquires, is already
initialized before init_vqs(); do the same for wakeup_lock.

Fixes: c578123e63da ("virtio_balloon: Treat stats requests as wakeup events")
Reported-by: syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=13df72e0dc4be5c62215
Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
---

Hi David,

On 24.08.26 14:57, David Hildenbrand (Arm) wrote:
> I don't really understand what's happening here, Is the
> register_lock_class() trying to reguster a non-static key?

It is: the wakeup_lock that stats_request() ends up taking at that
point hasn't been run through spin_lock_init() yet.

> I don't immediately see how virtio-balloon is doing something odd
> here, all it does is a spin_lock_irqsave(&vb->wakeup_lock, flags),
> that was earlier initialized with spin_lock_init(&vb->wakeup_lock),
> before the device was ready.

Right, the lock is initialized before virtio_device_ready().  But if
I follow correctly, stats_request() can already fire once init_vqs()
registers it as the stats virtqueue callback, some 100 lines before
the spin_lock_init().  I also don't see anything on the guest side
gating the IRQ: vring_interrupt() calls the callback without any
DRIVER_OK check unless CONFIG_VIRTIO_HARDEN_NOTIFICATION (which
depends on BROKEN).  So a device raising the interrupt while probe is
still running would take the zero-initialized lock.

> virtio-balloon in an RT kernel/environment, unlikely in pactice ... :)

I don't think it is RT-specific, though: rt_spin_lock() is just what
spin_lock() compiles to on PREEMPT_RT, so any PROVE_LOCKING build
should hit the same register_lock_class() path on that lock.

stop_update_lock(), which the same callback takes first, is already
initialized before init_vqs(); the patch below does the same for
wakeup_lock.  Does that look reasonable?

 drivers/virtio/virtio_balloon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index ab3e3d887e..8c1b47ec17 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -942,6 +942,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
 	INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
 	spin_lock_init(&vb->stop_update_lock);
+	spin_lock_init(&vb->wakeup_lock);
 	mutex_init(&vb->balloon_lock);
 	init_waitqueue_head(&vb->acked);
 	vb->vdev = vdev;
@@ -1049,8 +1050,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
-	spin_lock_init(&vb->wakeup_lock);
-
 	/*
 	 * The virtio balloon itself can't wake up the device, but it is
 	 * responsible for processing wakeup events passed up from the transport
-- 
2.53.0.windows.1



