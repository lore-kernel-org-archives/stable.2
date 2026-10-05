Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15022931C3
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190119; cv=none; b=k+SWt4woUnfR0+b8nO4NKt1WalA2p+mHfQ9yV90sZar7Z0Y406ZHGEDOzlx6zUS+wn5NC77At6eFHkLaTl00CNnwdqK7Rcxkg+jPURabT2+XyXRLHFy055PHq/fx2yxKXSFnmK5LxoNiC/kXRMP+5Bf5+CcTBp6IgPQFno/vKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190119; c=relaxed/simple;
	bh=90ud6nlkIvph3ger9YYHxq1b2IVS8faY/4jb8VtFh10=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A+K44O7BGyoHlSStrO02SsKESZrhPwqmbfh+p9s5JsyEMmxq1NpsvN5mn194NVc9/q9g6xRnCMoLne0kSpe5AeFEH79MuIOZdhkPDQ/p2vAhDOUfp/p2fXMIsXplIsCFzh0YSXH7SxxDM9+REppXt+cmlf4aSrU8/02qdsKlFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NnQgZfui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NnQgZfui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A781F000FF;
	Mon,  5 Oct 2026 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190117;
	bh=bDMXgZ4DWNOqrxdf8wOVJJA4drzuMhV5Bwnuu4RHQgw=;
	h=Subject:To:Cc:From:Date;
	b=NnQgZfuiVoRJNfUAsG9E1n8eQjhO8HJCtorvK4S8jZ7wJyvOiTjdEra1NPMA7Sqq6
	 baMDOrlpeZUdJjDZT6o+Plkb4ChrdYpwBOMVOcSemr4+keues61nqW/1sNBT+Lgn5Q
	 oRHMi3/Eb6x/URopyCEnj4lTYHb4VnhvqUyhCceQ=
Subject: FAILED: patch "[PATCH] usb: cdns3: fix use-after-free in cdns3_gadget_exit()" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,congei42@163.com,gregkh@linuxfoundation.org,peter.chen@kernel.org,songl@zju.edu.cn,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:48:34 +0200
Message-ID: <2026100534-purging-uniquely-0db7@gregkh>
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
git cherry-pick -x ebe9b68c396792c15d0ac690d592e449e74ed804
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100534-purging-uniquely-0db7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ebe9b68c396792c15d0ac690d592e449e74ed804 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Wed, 9 Sep 2026 09:56:55 +0000
Subject: [PATCH] usb: cdns3: fix use-after-free in cdns3_gadget_exit()

cdns3_gadget_start() arms two works on system_freezable_wq:
pending_status_wq for the deferred ep0 status stage and aligned_buf_wq
for realigned request buffers. Both handlers use the cdns3_device the
works are embedded in, and cdns3_pending_setup_status_handler() also
calls the ep0 request completion.

cdns3_gadget_exit() does not wait for these works. It frees all
endpoints and aligned buffers and drops the last reference to the
gadget device, which frees priv_dev, so a work queued before the exit
can run after the free.

Fix this by waiting for both works after the gadget driver is unbound
and the IRQ is freed, when no new work can be queued, and before the
endpoints and buffers are released.

This issue was found by an in-house static analysis tool.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Reported-by: Sicong Huang <congei42@163.com>
Closes: https://lore.kernel.org/linux-usb/7f5719b.8700.18f67b324d3.Coremail.congei42@163.com/
Suggested-by: Sicong Huang <congei42@163.com>
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://patch.msgid.link/20260909095655.694527-1-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 42311c1bfada..0d272e9c556c 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3269,6 +3269,10 @@ static void cdns3_gadget_exit(struct cdns *cdns)
 	usb_del_gadget(&priv_dev->gadget);
 	devm_free_irq(cdns->dev, cdns->dev_irq, priv_dev);
 
+	/* The works can still be queued until the IRQ is freed. */
+	cancel_work_sync(&priv_dev->pending_status_wq);
+	cancel_work_sync(&priv_dev->aligned_buf_wq);
+
 	cdns3_free_all_eps(priv_dev);
 
 	while (!list_empty(&priv_dev->aligned_buf_list)) {

