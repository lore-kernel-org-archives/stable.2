Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954994C77BA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447801; cv=none; b=dw+9LxlLGC3X/MC/rziGQ/KIaG6z/AjG8GM3o/g0fTEukIqqA7T4fxoSWNmo/8NTOCbpMeaKB0o/txhHD2+2DH1fZ5AdklT1lLAEdGa9OU0TmgnGs570fBlVSzUGJ3FsDwLCkqd+Nl8uZeyXhUCLNvcHTW8tCyVas+ltv3MUbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447801; c=relaxed/simple;
	bh=bJ5EHzyeEG40ndjrAcISn4gt+KUnENtqtVxNElnLde0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kpuGDb1wmQRo1eceyorRPyqY7/Uf6TmFK05m4M+bBTQ1Rf2zQ4cENb39mJcSnriFw30UV3plCRCzro+SHiOF9JfMVsx11eFsIZEFxOnzx4sv3ltbH56tZvEWTcJgWDefqA+ceQzDLtBkl52hsKAjimXst4McbucHKU0ip6vjnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t0E7jNx4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t0E7jNx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9956A1F000E9;
	Thu,  3 Sep 2026 15:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447799;
	bh=idR3M5FXTIKHwL8tTsbamnFMga0qvFlA4KuQJR8uQm8=;
	h=Subject:To:Cc:From:Date;
	b=t0E7jNx4bxxk7fNffjHT+uR68Nq9b+c5etOkcIcHSdBZhInbXdlmq9BTeR0X2RSEW
	 Ssa0d/xdc33cLNjukqCRZOlvRCINvZ7fUiBOxm95GGk//WpGZ17qX19GPS1ijdEoUS
	 6gvw84/glXQgs0Wx+L9z733ioQAddP/f0eJJpc2s=
Subject: FAILED: patch "[PATCH] power: supply: lp8788-charger: fix use-after-free on remove" failed to apply to 5.15-stable tree
To: fanwu01@zju.edu.cn,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:38:52 +0200
Message-ID: <2026090352-endanger-avenue-c367@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 831c29a12d560f8a3225f43050b3fbb5dfd79c66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090352-endanger-avenue-c367@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

