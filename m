Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC782C375A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047771; cv=none; b=gwmyDVPX5yofiUtfOFwZrtJOCoDOH1ezdoAMuPU24pWBtdqfXiEq8hEEZhH3EBmtQbBSl9f9IgaB4XK7zr4iySHX3BRavNL3r5DA47nQ030CWj2LdZzQtbieO/EnHARAqvK5cqlDyRPjd3vsJIGXzjOpBWJpMbGQuRnkx8JkQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047771; c=relaxed/simple;
	bh=CJqajI3w4+IqHcMTYRLnFwbyOgCGyM8Jd2zlwZtiXhE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WeIXAf+kopyNiDib5MuAK4Fzx+0eQ/KG4tOBKcsUFmYM5VMvKOQIFRKv+K+yepSu5oJYyGgne6NfXCPZDaUWOCiosvJ1oOGDYDzC1P2jwNZr9Q6jWvOjY9ngsTrlhTEZk03hb7RnaWjamyF8oG8otTqb49DXALIjBYC35EOjGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S5EE0K8+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S5EE0K8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F681F000E9;
	Tue, 14 Jul 2026 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784047769;
	bh=3QIf+sAmgSJy4QWnqZ9R0fF1SKv8zCwurgFSt+6M1MU=;
	h=Subject:To:Cc:From:Date;
	b=S5EE0K8+67tPdeleQGrh05G0psmb7mxYG+cqA5tpW9KByuncD4kTi/3tA6ZOzFyaH
	 xoN8laoxUzJRbbSeJ6KMeNv4LmCvqdXHy9SvL6xfuKJAlXTEmVn7pYfM/iu+jsjIjQ
	 sPtgY0jXRQvBsBp9RkZbB1o2Dasnbi2uOgyPt/20=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove" failed to apply to 5.15-stable tree
To: fanwu01@zju.edu.cn,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:49:22 +0200
Message-ID: <2026071422-comment-stardust-654c@gregkh>
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
git cherry-pick -x 1f0bdc2884b67de337215079bba166df0cdf4ac5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071422-comment-stardust-654c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f0bdc2884b67de337215079bba166df0cdf4ac5 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Tue, 16 Jun 2026 13:20:11 +0000
Subject: [PATCH] usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove

The threaded IRQ handler ccg_irq_handler() calls ucsi_notify_common(),
which on a connector-change event calls ucsi_connector_change() and
schedules connector work.  In ucsi_ccg_remove(), ucsi_destroy() frees
uc->ucsi (kfree) before free_irq() is called, so a handler invocation
already in flight may access the freed object after ucsi_destroy().

  CPU 0 (remove)            | CPU 1 (threaded IRQ)
    ucsi_destroy(uc->ucsi)  |   ccg_irq_handler()
      kfree(ucsi) // FREE   |     ucsi_notify_common(uc->ucsi) // USE

Move free_irq() before ucsi_destroy() in the remove path.  It is kept
after ucsi_unregister(): ucsi_unregister() cancels connector work whose
handler issues GET_CONNECTOR_STATUS through ucsi_send_command_common(),
which waits for a completion that is signalled from the IRQ handler, so
the IRQ must stay active until that work has been cancelled.

The probe error path already orders free_irq() before ucsi_destroy().

This bug was found by static analysis.

Fixes: e32fd989ac1c ("usb: typec: ucsi: ccg: Move to the new API")
Cc: stable <stable@kernel.org>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260616132011.103279-1-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index d46ca942026e..91c2958a708c 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1521,8 +1521,8 @@ static void ucsi_ccg_remove(struct i2c_client *client)
 	cancel_work_sync(&uc->work);
 	pm_runtime_disable(uc->dev);
 	ucsi_unregister(uc->ucsi);
-	ucsi_destroy(uc->ucsi);
 	free_irq(uc->irq, uc);
+	ucsi_destroy(uc->ucsi);
 }
 
 static const struct of_device_id ucsi_ccg_of_match_table[] = {

