Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F02277C88
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112204; cv=none; b=UgIH/4ghEfltFXltAcIZes+MdGa/sS+anSJjwgxLlX6shZSCTls7R+HPUK5kUksHqaTsOYvnv+S30NEawWrPpO805MQ/0PZiiG/u61ctnz3QiLint8HYuwf9RjHDsHaA1w85juTroxgyQobJHOjjkofyuNhWBi9ik1ySNAXHLw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112204; c=relaxed/simple;
	bh=YXGIddQNeytHLWGYJg4Ww/Xgptm1s3cVFDDhU2JKvyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfZ0GoWo/DprQcEzSLSf5nIWVjXEYY6Miy1QpUOwN3XN+WjQIXG0p9FOKUqJ0AM9PcKL+1iVAG/2OM9b7Qu9Hs6fywox064mJBWKB0iWgW/6noF0uGHOWj1bXs00XK6aA8PUGj8WFiXAru1zTzcs+9DO6Gb6dlMIRwazMWiv0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n56APZbp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n56APZbp"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0b944f6edso71907955ad.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781112202; x=1781717002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSnU05LP4qr/miE9bcmCtKHpcKuotIP+m7Vp5isT2ME=;
        b=n56APZbpRm8KQEK7z1TywweeSmumeYeQzJXjX0gz+ZpCMzGXZ0I5b2C02t5QYyat7a
         /tC942L/7Z7cUTlXYe1reEgW0KlANBUN5h7g0lluDbtlu+Jwfh65XaOppvm3N/54ql/M
         7Ya1BSI5JXF5MsD7rv0UYJtkC97jXxaf0cnOq7SFqrF9Tc7tyAwJUJEgok7gO/Q2RuT2
         /pwQyZSjsfHiPnfzELSzTETWGc36uHQr3sdtBr+/f5WBfJG75KlxffEMOqg2bsXqEz6n
         qhvGIHKQRzLD0JSARpTvXx1ziwbUsbBWlLwR8bT6JKPGP8EY8wQx9B6B+NHVnjZBOCWx
         ehBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112202; x=1781717002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSnU05LP4qr/miE9bcmCtKHpcKuotIP+m7Vp5isT2ME=;
        b=WQJ0XfEA2v+983Jz3Z4AziL79VhLOiPiBuUuLl2FeFcr7YGuQWRtm+FCBu5/HO6lI7
         gRKanVw06FLACQTEq9e7sqyaEFiJkk5EuAjB96VP1lVvKC4i3ybzHkWvuTr1N4bn9MZ3
         rdJCxoGOA8SkoJF19bAHgN2TijJM8zLMLvEfaJ/GDWq+GW8wjW43QklqtF9ZG+JX/SOk
         1rakZWGwE9bCO1FP02AuaqLZpvDR+VFJZE8wLovBzxazgvkKk4vR8AUirTdW16kCxfwF
         kMNn33ZPb7R0hMba8wUrlnlBCYaQa1bhWs1f5vGw1/NhmiNOyrhNgXmLKurYyKEvEu6o
         zVLg==
X-Forwarded-Encrypted: i=1; AFNElJ+MmVB36Jfz0d8QCDlaMQ8xsxBHgpabSM4rSDxQMAns2dK5yf4B0MQZkUp1XtB0wE5Zn77iDE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFbCCOTS5RMtTZoEPvtUj23l/Grm3e1U58BlJg9oK/y6Rp0iQA
	7bBTweb8fqoI3Y6UCKV19/SalNKXQkVNzmm/wj4eiiTuN8Cogg1u9xOV
X-Gm-Gg: Acq92OFRGdBQJe3/vOt2I0CRigYMprfd1d3D+SiCNsVxPl45iP69MLya4O1mLDEzXFE
	nYaxAo7fZWauiZ2bgGvvP/HZb2HaDJlCr2eQZHZT+Gx6KpSETLGO+gCouGm36CHMLpnPp1DJVxZ
	lfxypGXIZYhLJCAPhUyTyU+ZPC7bJRTzqFFdx1vgP/9keq2mSaoMKp87IzhuTHAmcHQ+RZpcmDo
	4BpJLE3IJPzUsiChQYJkDfY9VBdZpSappVMLe0tWY7is3ShEckJEuISeWLhLw2o4uZECgwH85Ma
	YK0K7RA36VqJpfA8qsb7xYQkxJec83TjHomlIyZCX0B6Qk1CF1lEpTQH9FT0R0JvtQICfsaJ075
	4/D60LrCcJnBLhs2yDZieniV1nGzLlYEbULScl3w+Sn29YKmbVRAOXkB+K5hasNyQZHUAQLFo9B
	eCwtXXeLn11+2f5v5doc8SSkPyliT7YGJDb53KEZDFJvAaXzjx0nmZD3ogkkhDa9/jMu4sS2ck7
	/V+mQ==
X-Received: by 2002:a17:902:c946:b0:2bf:281f:19ec with SMTP id d9443c01a7336-2c1e8208778mr304491405ad.24.1781112202455;
        Wed, 10 Jun 2026 10:23:22 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.202.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2139sm2247585ad.69.2026.06.10.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:23:21 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Wed, 10 Jun 2026 17:23:10 +0000
Message-ID: <20260610172310.163321-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
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

Serialize kfifo access with a per-channel spinlock. The reader drains
into a bounce buffer under the lock with kfifo_out_spinlocked() and then
copies to userspace after dropping it, since copy_to_user() may sleep on
a page fault.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Cc: stable@vger.kernel.org
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
Andrew,

Thanks for the review.

Changes since v4:
- Use __free(kfree) for automatic cleanup
- Allocate clamped count instead of full SNOOP_FIFO_SIZE
- Use kfifo_out_spinlocked() in snoop_file_read
- Use scoped_guard(spinlock) in put_fifo_with_discard

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index b03310c0830d..c9c87a794228 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/dev_printk.h>
 #include <linux/interrupt.h>
@@ -74,6 +75,7 @@ struct aspeed_lpc_snoop_channel_cfg {
 struct aspeed_lpc_snoop_channel {
 	const struct aspeed_lpc_snoop_channel_cfg *cfg;
 	bool enabled;
+	spinlock_t		lock;    /* serialises @fifo: irq producer vs reader */
 	struct kfifo		fifo;
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
@@ -114,6 +116,7 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 				size_t count, loff_t *ppos)
 {
 	struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
+	u8 *buf __free(kfree) = NULL;
 	unsigned int copied;
 	int ret = 0;
 
@@ -125,9 +128,16 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 		if (ret == -ERESTARTSYS)
 			return -EINTR;
 	}
-	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
-	if (ret)
-		return ret;
+
+	count = min_t(size_t, count, SNOOP_FIFO_SIZE);
+
+	buf = kmalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	copied = kfifo_out_spinlocked(&chan->fifo, buf, count, &chan->lock);
+	if (copied && copy_to_user(buffer, buf, copied))
+		return -EFAULT;
 
 	return copied;
 }
@@ -153,9 +163,11 @@ static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan, u8 val)
 {
 	if (!kfifo_initialized(&chan->fifo))
 		return;
-	if (kfifo_is_full(&chan->fifo))
-		kfifo_skip(&chan->fifo);
-	kfifo_put(&chan->fifo, val);
+	scoped_guard(spinlock, &chan->lock) {
+		if (kfifo_is_full(&chan->fifo))
+			kfifo_skip(&chan->fifo);
+		kfifo_put(&chan->fifo, val);
+	}
 	wake_up_interruptible(&chan->wq);
 }
 
@@ -228,6 +240,7 @@ static int aspeed_lpc_enable_snoop(struct device *dev,
 		return -EBUSY;
 
 	init_waitqueue_head(&channel->wq);
+	spin_lock_init(&channel->lock);
 
 	channel->cfg = cfg;
 	channel->miscdev.minor = MISC_DYNAMIC_MINOR;
-- 
2.43.0

