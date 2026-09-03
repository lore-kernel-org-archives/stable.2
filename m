Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D54C77C1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447803; cv=none; b=ucfCrG9admP/mwEBSUGcjkgCej6NDhHqnEX7QLxkVLTQR0OwU6hL6Bj/pzzxTc32IXzxRvFRFkR9WQmgP4FuQUTH/K9Y2oM6bIXneP99b3k8xBSY6y3mLxM3naYxMxYcK65briY0eUD726Bd+4HA1U3i8PsouePVg6SKrt4ZHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447803; c=relaxed/simple;
	bh=3soix+jMxFK7cK6ZlRbhyoW8w360HZxXnCc9VZoqgf0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BvXV84W10kSx4JzEPucl2Mq0FlL8on7dH5b6+QuF+TNtWtzF9oV7lUEn0v3TN6UzFEODBXFKTAT/h/ZK6gUrUG1FANrjkMm6u4mEYVmEOw1YT40X53f2wcWKpDICWvg3j7FxQXaLxFGTPT56rZpZnBTn/pP2skgIkDLXAJEPVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wie+O/xe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wie+O/xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725F81F000E9;
	Thu,  3 Sep 2026 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447802;
	bh=mX52c290m1SVTFIHp7XfKKqbbB+QoWuXfoeqe0tKT3Y=;
	h=Subject:To:Cc:From:Date;
	b=Wie+O/xehclnb5uyJwKTn3mRYN6VPUMFO7bBhlmicg5Ok89Ytg/Pj8lTFpZxRilJX
	 4CzQX0IswqPGa5AdDnMb5/CJdyruXgct0t3DUkzAoMnLGJ9PrizThay3yiWVrvrnpm
	 W41Ec/j5DLDvVU2uCeW5wM3GKdCinfEop74dZ8sU=
Subject: FAILED: patch "[PATCH] power: supply: lp8788-charger: fix use-after-free on remove" failed to apply to 6.6-stable tree
To: fanwu01@zju.edu.cn,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:38:52 +0200
Message-ID: <2026090352-math-comrade-6046@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 831c29a12d560f8a3225f43050b3fbb5dfd79c66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090352-math-comrade-6046@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 831c29a12d560f8a3225f43050b3fbb5dfd79c66 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Sun, 2 Aug 2026 03:54:42 +0000
Subject: [PATCH] power: supply: lp8788-charger: fix use-after-free on remove

lp8788_charger_remove() flushes charger_work before unregistering the
IRQs. An IRQ thread can queue charger_work after flush_work() has
returned. The work can then run after devres frees pchg and dereference
it in lp8788_charger_event().

Unregister the IRQs first. free_irq() waits for any running threaded
handler, so no handler can queue more work afterwards. Then use
cancel_work_sync() to cancel pending work or wait for running work to
finish.

This issue was found by an in-house static analysis tool.

Fixes: 98a276649358 ("power_supply: Add new lp8788 charger driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260802035442.421697-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index f0a680c155c4..1bc2c150fb91 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -710,8 +710,8 @@ static void lp8788_charger_remove(struct platform_device *pdev)
 {
 	struct lp8788_charger *pchg = platform_get_drvdata(pdev);
 
-	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
+	cancel_work_sync(&pchg->charger_work);
 }
 
 static struct platform_driver lp8788_charger_driver = {

