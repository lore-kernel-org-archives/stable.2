Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7837AA91;
	Fri, 24 Jul 2026 05:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870945; cv=none; b=Ix1413M/CrhpNfEPj+MXuXN6AbluT8+wOqw6EMvhNFCxSr/82IlTcBOPMq6MK6eow2a+qZfOMuK/6W8meseyd3gyhe8XkQ8VqkzWPi5E3Gq7jf6g/D85QjD3IgF6xb5+KuDjvgLlbeM1+FsqcmO55tpB2R812nC6mPjXnnnUkHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870945; c=relaxed/simple;
	bh=yWgAvsNfonKTzfPkF9NE3ARZQUZfJDMAM38Ys+Q7+OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av9Fg2MwOnKSrixy9ghsT8yev9KbJQzLPsP88A0QN8XWjHMK4EU7huvccty1qmlt3lDRh42DH6DFx5mVtRN455I+uo6fQm/vrimguge+I5NOxectzfZ2DF8N/hBicgaRNsnfWU/vEL39aHOvcUZItNBVCDeCsFlgb2O4QmE8XAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BbvA2g9H; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="BbvA2g9H"
Received: from LAPTOP-99KJFSET (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47691a1ba;
	Fri, 24 Jul 2026 13:28:57 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	arnd@arndb.de
Cc: linusw@kernel.org,
	brgl@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	getshell@seu.edu.cn
Subject: [RFC PATCH 6.6.y 4/4] misc: ti-st: synchronize TTY teardown with transport removal
Date: Fri, 24 Jul 2026 13:28:42 +0800
Message-ID: <20260724052842.1052-5-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260724052842.1052-1-getshell@seu.edu.cn>
References: <20260724052842.1052-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f9299221003a1kunm7e8f9dea24473
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDS05JVkJPTB8dGB1LTUJOSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=BbvA2g9HBERQfRYGmFLzd191JpR5LbAqX9MHF3QYqBLr0zr0J8EjZ95m3PGNIgIHAlAKQIbCBsA0gtvwHktgP6/9+VOED0NuGvRgop0lE8tuBZHIqDjrTtn58U++xB/hdlZin+aTPv9lL7V1Krh4POO1FTDu6Spt3hQ7Xejqte4=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=ltIi9JVhQVE+wcK24T3nnvz4EpLs16l0x4XUOVFM3FI=;
	h=date:mime-version:subject:message-id:from;

Unregistering the line discipline does not close an instance which is
already attached to a TTY.  Its callbacks and work_write_wakeup can keep
using the transport after st_core_exit() frees it.

Protect the attached TTY pointer with the core lock.  On removal, take a
TTY reference and synchronously hang it up, then cancel the wakeup work
before releasing the core.  Also cancel the work in normal close and clear
disc_data only after the close cleanup is complete.

Fixes: 53618cc1e51e ("Staging: sources for ST core")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/misc/ti-st/st_core.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 3aed6c3..7610656 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -723,13 +723,18 @@ EXPORT_SYMBOL_GPL(st_unregister);
 static int st_tty_open(struct tty_struct *tty)
 {
 	struct st_data_s *st_gdata __free(st_kim) = NULL;
+	unsigned long flags;
+
 	pr_info("%s ", __func__);
 
 	st_kim_ref(&st_gdata, 0);
 	if (!st_gdata)
 		return -ENODEV;
+
+	spin_lock_irqsave(&st_gdata->lock, flags);
 	st_gdata->tty = tty;
 	tty->disc_data = st_gdata;
+	spin_unlock_irqrestore(&st_gdata->lock, flags);
 
 	/* don't do an wakeup for now */
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -757,6 +762,7 @@ static void st_tty_close(struct tty_struct *tty)
 	struct	st_data_s *st_gdata = tty->disc_data;
 
 	pr_info("%s ", __func__);
+	cancel_work_sync(&st_gdata->work_write_wakeup);
 
 	/*
 	 * TODO:
@@ -777,7 +783,6 @@ static void st_tty_close(struct tty_struct *tty)
 	 * N_TI_WL ldisc is un-installed
 	 */
 	st_kim_complete(st_gdata->kim_data);
-	st_gdata->tty = NULL;
 	/* Flush any pending characters in the driver and discipline. */
 	tty_ldisc_flush(tty);
 	tty_driver_flush_buffer(tty);
@@ -791,6 +796,8 @@ static void st_tty_close(struct tty_struct *tty)
 	st_gdata->rx_state = ST_W4_PACKET_TYPE;
 	kfree_skb(st_gdata->rx_skb);
 	st_gdata->rx_skb = NULL;
+	st_gdata->tty = NULL;
+	tty->disc_data = NULL;
 	spin_unlock_irqrestore(&st_gdata->lock, flags);
 
 	pr_debug("%s: done ", __func__);
@@ -905,6 +912,8 @@ err_unreg_ldisc:
 
 void st_core_exit(struct st_data_s *st_gdata)
 {
+	struct tty_struct *tty;
+	unsigned long flags;
 	long err;
 
 	if (!st_gdata)
@@ -914,6 +923,14 @@ void st_core_exit(struct st_data_s *st_gdata)
 	wait_event(st_gdata->users_wait,
 		   !atomic_read(&st_gdata->active_users));
 
+	spin_lock_irqsave(&st_gdata->lock, flags);
+	tty = tty_kref_get(st_gdata->tty);
+	spin_unlock_irqrestore(&st_gdata->lock, flags);
+	if (tty)
+		tty_vhangup(tty);
+	cancel_work_sync(&st_gdata->work_write_wakeup);
+	tty_kref_put(tty);
+
 	/* internal module cleanup */
 	err = st_ll_deinit(st_gdata);
 	if (err)
-- 
2.50.1.windows.1

