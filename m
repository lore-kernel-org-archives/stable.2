Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AB4C77C6
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447806; cv=none; b=nd2KfMeVriFSxm340LnGEZM0WG0SEbqglIxhODZdcB0MKk6CG4MoJc0ozm4A2IzO7jQez/V8WsQRx+kroq3xcdRlEGQdSKkEsqIdh8YvyoKvP96Sk7Vb8L9P4P2z+bIDvEgsBI9zHH6gN8t1QEa/Tp48pEF5yvFp7FUj3qEX1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447806; c=relaxed/simple;
	bh=pgDUDU7+MKpAPoRL5KVM0N0ybmj0EM2yLiP6Cs+Fv7M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CAbED8I4I+C/pnfsmZQYIr1Nb+5t23C0NCQR1ErJGj1ZUGUDPAbbpQVPvmnvax6+6Hp2FOGkp+MNdhJz677HkhhGpoR08pb40RVVXWRUWXxy5hlsB+EFaO+Az8x3BClH2+Xg4fY1VjB3Z138RoNXF98+J/d6XgI80ic8auGAGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KyXBQbq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KyXBQbq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DE41F000E9;
	Thu,  3 Sep 2026 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447804;
	bh=SQHpyk/i7AIgm8e6douNx61/jP2RI6rftHkFzSWPJEM=;
	h=Subject:To:Cc:From:Date;
	b=KyXBQbq98VT98R5rixuSBGBSX+cB1bGKDa3QzDk4qGwCqwpiEqr/VpOWW7NsxQxXy
	 +c033SZy4efCSR6DZR2Yh8fUfUtAE+ocCKOuTA63UD+3UI0gxdRY1f14YUVRH9A9sE
	 STE8nux+ehQoB/+9T2xuoTedEGFiVRNvqj1hsYp4=
Subject: FAILED: patch "[PATCH] power: supply: lp8788-charger: fix use-after-free on remove" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:38:53 +0200
Message-ID: <2026090353-unadorned-buffed-09ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 831c29a12d560f8a3225f43050b3fbb5dfd79c66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090353-unadorned-buffed-09ad@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

