Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E53769E0
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318345; cv=none; b=EPTt6VkYuO2VjTaLwvhvOYxpnrzJDXgIhYs5zRQVoEUMjv98bPDQw+x34Yg1REKksEgvGwG7vnZoBLVewWOXshg5I44VQGryZ59zr35J/Sm9UX4OI3YxjKYydzc0WzbLit0AbPOP8sV8NUk/1TjRqOZstVUtQloGcpbgnVXFN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318345; c=relaxed/simple;
	bh=NcYkRwbTqa9/9wwiFQPeiIapfIns+vtyqJSwRf6t/TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF7zuuyNeRKtZdH58P5lTAC/lBnST2wja7QLkvEb/zgIktM2h6Se7amo9Q9FroAiQCKi2q2WxrwGYlvW9HsQPpWa6v8ZQw933HlaDeqa9m0XwWgPAy0F31YisDv8uuwPwWd86AUI7WpvRE17v58RLMde9OJAgg+1BnxT1xieVt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpRpzCjP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpRpzCjP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf30d530bdso27250285ad.3
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 05:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780318343; x=1780923143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpFJ2vgllIWj4FqG6DXjRM527rlfnB9NVugM5813YTM=;
        b=SpRpzCjPVsdpO5mDITKcEAHGi+t2IDW90c6eDvEpM8zHXmFy6Px/QLuzywP1U3gLLE
         qO2wfeYBGIdtuN/AS5Jd1rWMRKgIFzntumbnOTAkzmdPS0VOvG9AimysflbjOOUsMgEi
         jB+NCGZtmB/RAKwN3XHbXBbmy3Rk/wRdG31WkkzzgBE6BkPuww5HoL0zXhhhN+kNd6GR
         OsawVNrkfvSm6em22nCKTdwrXqgs6t6XMyjLEeOlUXQuKsPW7CCObnwJZ2jGh+NeG0d/
         26yN0E4+/QMGb+/kZyWfoWa9ovtx4F2fjZVbs3wtzd+wwc1mCrjO/pYlzW/gCrkR0Wg6
         jaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318343; x=1780923143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JpFJ2vgllIWj4FqG6DXjRM527rlfnB9NVugM5813YTM=;
        b=O927U9wHkHmqbmQPpiHPiZ522r7EpQNz3TDG3c4FdskBUte9rwBN4faP0Ehi1uDoAK
         MpXcuJWQYxm7prRU+rEDwNGInCGhEpcYdGV5LmZsrDKSzsa+SOzVH6FonNNhv9TXBXW2
         iFBDX2eVm9ib+fnbP5TkD4A6HwbSjeha4j4LCAuJYyn/WmpUJow7iyHp7UyKIwt5aJS1
         qaYYguW+7ujbLHw29Y63teyHrb7VDL7Rjm7FkoZi48ecF7590DSBbPT45AqU4KhlxPhM
         bPwlCDfmuyL69tBQznTD4dkFSTIZscUI1HJCJkgvVqU+0/iaKQmfVGhLLx/dZXR1Y8/+
         zTMg==
X-Forwarded-Encrypted: i=1; AFNElJ8RJJV6zal4UQ7O9Wx8LZbYJdoMvydAsX4x/Ec9IdTlGSFhQXVm81RWzVPrVVwY9ZN0kKESpwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXLuaML4p8CfznYA9Ey8P8WySkGIUnoQaht0TlGr+tYKh7s1J
	iIo5M8eWJjqBoTYgGlrFvg8kcBUNGOQZe8gKmr7PLj6Ivk6E9FaFsALC
X-Gm-Gg: Acq92OGZxebLBBQdheyHeJTo02JxGoqUf/OarFhhktVBtzwNWeSwwdbNp4PjYI2fg5A
	DNwJjcQoXzcpcxgGz2jyxNNzSeb+ZDG4dpZDz8+iFTt3opgR4Vz+gsGrGIZ0pGZNqS79Vjuqb7Q
	snuhN90c4RHez26UaEjBvcHdEgmtPjB5DnAm2IKzSGlZ/x1QKvRTiW5vp++0i8684uI8dY3PGEW
	kKawbAhaV8ByLfs+uNe4Wi5lBDjxz5oylEm7aB5irWJrK8PFHw/WBp9JBGJHLK4JrUX6xEF530G
	Aw9GUkqrphO5FOqEpLKXvcJdo24XA4rXOdeWOAKPArZyl77Iop3LgieF2U+61KAio7r29lAoxYb
	xwGb3sA2obRQ+WwXVF6xOlQYMzef+rDk5q/PRFmZV66aixS/tOI044bRj1P2BJk2zJ1GgYB7a9Z
	x2ZDiI6TLl2k9SYq9pUmiifPtoVNKY0f1x4ryu68Ti4Z0nFD0Qui2uSh2wMYIJJDsA66o=
X-Received: by 2002:a17:903:1905:b0:2bf:281f:19ec with SMTP id d9443c01a7336-2bf36803dccmr130037915ad.24.1780318342942;
        Mon, 01 Jun 2026 05:52:22 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.200.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf7b6609f5sm85932415ad.60.2026.06.01.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:52:22 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Mon,  1 Jun 2026 12:52:13 +0000
Message-ID: <20260601125214.2071019-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1e2b77c7916259e3e269d19f637c29427c175350.camel@codeconstruct.com.au>
References: <1e2b77c7916259e3e269d19f637c29427c175350.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

put_fifo_with_discard() acts as both producer and consumer on the kfifo:
it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
the IRQ handler without synchronizing with snoop_file_read(), which also
consumes via kfifo_to_user(). On SMP systems this concurrent access can
leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s clamp
to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
copy_to_user() past the kmalloc-2k backing store:

  usercopy: Kernel memory exposure attempt detected from SLUB object
  'kmalloc-2k' (offset 0, size 2049)!
  kernel BUG at mm/usercopy.c!
  Call trace:
   usercopy_abort
   __check_heap_object
   __check_object_size
   kfifo_copy_to_user
   __kfifo_to_user
   snoop_file_read
   vfs_read


Serialize kfifo access with a per-channel spinlock. copy_to_user()
runs after dropping the lock, since it may sleep on a page fault.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Cc: stable@vger.kernel.org
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
Andrew,

Thanks for the review.

> This seems inappropriate and I expect is flagged if you compile with
> CONFIG_PROVE_LOCKING=y or CONFIG_DEBUG_ATOMIC_SLEEP=y

v4 drains the kfifo into a kernel buffer via kfifo_out() under
the lock, then performs copy_to_user() after dropping it.
(cf. drivers/gpio/gpiolib-cdev.c, which drains under its event lock
and copies outside it.)

> ensure you develop, build and test on recent releases

Tested on both v7.1-rc5 and v7.1-rc6 with PROVE_LOCKING,
DEBUG_ATOMIC_SLEEP and HARDENED_USERCOPY enabled: read path
round-trips correctly, no lockdep splats, no atomic-sleep
warnings, no usercopy aborts.

Changes since v3:
- Replaced kfifo_to_user() with kfifo_out() + copy_to_user()
  to avoid sleeping under spinlock
- Rebased onto v7.1-rc6

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index b03310c0830d..0fe463020e25 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -74,6 +74,7 @@ struct aspeed_lpc_snoop_channel_cfg {
 struct aspeed_lpc_snoop_channel {
 	const struct aspeed_lpc_snoop_channel_cfg *cfg;
 	bool enabled;
+	spinlock_t		lock;
 	struct kfifo		fifo;
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
@@ -115,6 +116,7 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 {
 	struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
 	unsigned int copied;
+	u8 *buf;
 	int ret = 0;
 
 	if (kfifo_is_empty(&chan->fifo)) {
@@ -125,11 +127,22 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 		if (ret == -ERESTARTSYS)
 			return -EINTR;
 	}
-	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
-	if (ret)
-		return ret;
 
-	return copied;
+	buf = kmalloc(SNOOP_FIFO_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	spin_lock_irq(&chan->lock);
+	copied = kfifo_out(&chan->fifo, buf,
+			   min_t(size_t, count, SNOOP_FIFO_SIZE));
+	spin_unlock_irq(&chan->lock);
+
+	ret = copied;
+	if (copied && copy_to_user(buffer, buf, copied))
+		ret = -EFAULT;
+
+	kfree(buf);
+	return ret;
 }
 
 static __poll_t snoop_file_poll(struct file *file,
@@ -153,9 +166,11 @@ static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan, u8 val)
 {
 	if (!kfifo_initialized(&chan->fifo))
 		return;
+	spin_lock(&chan->lock);
 	if (kfifo_is_full(&chan->fifo))
 		kfifo_skip(&chan->fifo);
 	kfifo_put(&chan->fifo, val);
+	spin_unlock(&chan->lock);
 	wake_up_interruptible(&chan->wq);
 }
 
@@ -228,6 +243,7 @@ static int aspeed_lpc_enable_snoop(struct device *dev,
 		return -EBUSY;
 
 	init_waitqueue_head(&channel->wq);
+	spin_lock_init(&channel->lock);
 
 	channel->cfg = cfg;
 	channel->miscdev.minor = MISC_DYNAMIC_MINOR;
-- 
2.43.0

