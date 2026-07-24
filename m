Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFF377A96;
	Fri, 24 Jul 2026 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870880; cv=none; b=iTPQ1wpG+2ZDEE2GcpeD7S08grRFEgGGIpVw1GAJmPLNtTq+KJz8QzpmVYVr1Tf2hiTUoRA8DDv2GZWBitVkTYgOz2JiygKsHX5kSk2AjCHHekMg9XHvKVTskOovithiJNUF+viZMpf5827hgp6cptPCcLJOzqfLbLd/eLygtas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870880; c=relaxed/simple;
	bh=NkRAAqtSSXmk+tg5AqNmfpD3Cy5a0Kmfx7t9yag9+vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7pCiTkhHW8cXb1r14Wb0EGWLzwDSb5RRCzpgGOfkV12NDJyUIVoEaJ1XsnvziDKXS8aTdlcRC8WJsvkRIeC3anF5rfaU1Du3GDZZDiKyVCys2ZfLG0alxwofs/vJ4FozqrbtpT/b1YrStyFRiSVLITYsX2FinUIhEt3nx/aSiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=TH+lIse+; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="TH+lIse+"
Received: from LAPTOP-99KJFSET (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47691a1a2;
	Fri, 24 Jul 2026 13:27:49 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: 3chas3@gmail.com,
	stable@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	getshell@seu.edu.cn
Subject: [RFC PATCH 6.6.y] atm: suni: synchronize poll timer with device removal
Date: Fri, 24 Jul 2026 13:27:47 +0800
Message-ID: <20260724052747.1976-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f9298174003a1kunm7304a06f243c1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUkYVk1JSh9KHUoaH0MeQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=TH+lIse+Qz9XQBmvyVfVqo9agrbO/WM58EGksak400CU0dgQM8qG6QSwsy9wTHaBQ5w3/rqxhF90A5IeqcQHbw6iYUD31bBpR0fA95x3G2qtzKpi4179gIpmV+hX0OW7EilXtmZgcS4TplbWLFBIEI4JudcBB61ZuIWY2XO+vD0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=c5Ugs+CkrYnw+UEStcu+8FqtB1MdwrqYS033j1CAzng=;
	h=date:mime-version:subject:message-id:from;

suni_hz() walks the global device list and dereferences each private
structure without taking sunis_lock. suni_stop() can therefore unlink and
free a device while the timer callback is still using it. The existing
timer synchronization only runs for the last device and is performed while
holding sunis_lock.

Protect the callback traversal with sunis_lock. Serialize the first/last
timer transitions with a mutex, unlink under the spinlock, then shut the
timer down outside the spinlock before freeing the last device.
timer_shutdown_sync() also prevents the running callback from rearming
itself; a later first start reinitializes the timer with timer_setup().
Move device initialization before list publication so an existing timer
cannot observe a partially initialized entry.

This driver was removed from mainline by commit 6deb53595092 ("net: remove
unused ATM protocols and legacy ATM device drivers"), but is still present
in the 6.6 LTS series.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/atm/suni.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/atm/suni.c b/drivers/atm/suni.c
index 21e5acc..5fa939b 100644
--- a/drivers/atm/suni.c
+++ b/drivers/atm/suni.c
@@ -14,6 +14,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/errno.h>
 #include <linux/atmdev.h>
 #include <linux/sonet.h>
@@ -46,6 +47,7 @@
 static struct timer_list poll_timer;
 static struct suni_priv *sunis = NULL;
 static DEFINE_SPINLOCK(sunis_lock);
+static DEFINE_MUTEX(sunis_mutex);
 
 
 #define ADD_LIMITED(s,v) \
@@ -59,6 +61,7 @@ static void suni_hz(struct timer_list *timer)
 	struct atm_dev *dev;
 	struct k_sonet_stats *stats;
 
+	spin_lock_bh(&sunis_lock);
 	for (walk = sunis; walk; walk = walk->next) {
 		dev = walk->dev;
 		stats = &walk->sonet_stats;
@@ -85,6 +88,7 @@ static void suni_hz(struct timer_list *timer)
 		    ((GET(TACP_TCC) & 0xff) << 8) |
 		    ((GET(TACP_TCCM) & 7) << 16));
 	}
+	spin_unlock_bh(&sunis_lock);
 	if (timer) mod_timer(&poll_timer,jiffies+HZ);
 }
 
@@ -306,14 +310,9 @@ static void suni_int(struct atm_dev *dev)
 
 static int suni_start(struct atm_dev *dev)
 {
-	unsigned long flags;
 	int first;
 
-	spin_lock_irqsave(&sunis_lock,flags);
-	first = !sunis;
-	PRIV(dev)->next = sunis;
-	sunis = PRIV(dev);
-	spin_unlock_irqrestore(&sunis_lock,flags);
+	mutex_lock(&sunis_mutex);
 	memset(&PRIV(dev)->sonet_stats,0,sizeof(struct k_sonet_stats));
 	PUT(GET(RSOP_CIE) | SUNI_RSOP_CIE_LOSE,RSOP_CIE);
 		/* interrupt on loss of signal */
@@ -322,6 +321,11 @@ static int suni_start(struct atm_dev *dev)
 		printk(KERN_WARNING "%s(itf %d): no signal\n",dev->type,
 		    dev->number);
 	PRIV(dev)->loop_mode = ATM_LM_NONE;
+	spin_lock_bh(&sunis_lock);
+	first = !sunis;
+	PRIV(dev)->next = sunis;
+	sunis = PRIV(dev);
+	spin_unlock_bh(&sunis_lock);
 	suni_hz(NULL); /* clear SUNI counters */
 	(void) fetch_stats(dev,NULL,1); /* clear kernel counters */
 	if (first) {
@@ -333,6 +337,7 @@ printk(KERN_DEBUG "[u] p=0x%lx,n=0x%lx\n",(unsigned long) poll_timer.list.prev,
 #endif
 		add_timer(&poll_timer);
 	}
+	mutex_unlock(&sunis_mutex);
 	return 0;
 }
 
@@ -340,16 +345,20 @@ printk(KERN_DEBUG "[u] p=0x%lx,n=0x%lx\n",(unsigned long) poll_timer.list.prev,
 static int suni_stop(struct atm_dev *dev)
 {
 	struct suni_priv **walk;
-	unsigned long flags;
+	bool last;
 
 	/* let SAR driver worry about stopping interrupts */
-	spin_lock_irqsave(&sunis_lock,flags);
+	mutex_lock(&sunis_mutex);
+	spin_lock_bh(&sunis_lock);
 	for (walk = &sunis; *walk != PRIV(dev);
 	    walk = &PRIV((*walk)->dev)->next);
 	*walk = PRIV((*walk)->dev)->next;
-	if (!sunis) del_timer_sync(&poll_timer);
-	spin_unlock_irqrestore(&sunis_lock,flags);
+	last = !sunis;
+	spin_unlock_bh(&sunis_lock);
+	if (last)
+		timer_shutdown_sync(&poll_timer);
 	kfree(PRIV(dev));
+	mutex_unlock(&sunis_mutex);
 
 	return 0;
 }
-- 
2.50.1.windows.1

