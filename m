Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866664334C4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191316; cv=none; b=V4EOoKiC3iMt78XdjvUu3ccR07FswWBlK+z8OwqVE0OssABemqKc+HuussQ2+nvTbpQQ+tL9YPaF6bg3beduB659X1suhGKXFd9Em5ougMHSyZPOHyV2uO9XOzDr1nl0F8mzo4F6tayOzpRqyYFcmP/2T7FBQaRZtYDEdpe7d/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191316; c=relaxed/simple;
	bh=2Y1TAuQq8ROdUF9NBjcIlhw0Kye5bV5fw0AgH9nUS0E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Swm4r/TFnOUpPrGsHTn2F20gqHA05eqLCMJZnKazjRiQJRERxvENJQ18njv9jYVJk/WBj8fNrLaSpQQ/t40SpHGZo4H6TY+pGlNetqFLMkP7WupinTWiHw21fwYO7vqBUZg+eDNzYOszLtvMCT3SD37s3KXub5tZDyV6CIv9vBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=znBYolxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="znBYolxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E781F00898;
	Mon,  5 Oct 2026 09:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791191314;
	bh=3Z2Wx3vnLdccWaYCy7oF7XuwHC8K+Roax6ICfFcZ4Ok=;
	h=Subject:To:Cc:From:Date;
	b=znBYolxqwDpjDOY8te6WO0irHBpyRrnU4mEA0e5KTOeoVkZv/qBqkBDCIUQvjHLJ4
	 aZbz1s6mO0u62O7en5DKseuE5xi8jSq58XGbaCen5xYdJvaus6ClaVo6l5xwNfGl2c
	 /8q1uLj3UIt3c5MsL0h2l8jZ88+/vc3rFBOqxUXs=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: glink: fix use-after-free of ucsi on remove" failed to apply to 6.6-stable tree
To: fanwu01@zju.edu.cn,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,songl@zju.edu.cn,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 11:07:41 +0200
Message-ID: <2026100540-barterer-those-a743@gregkh>
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
git cherry-pick -x 63b269ec537dc0fd26d0bd64872c26860d108c9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100540-barterer-those-a743@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63b269ec537dc0fd26d0bd64872c26860d108c9d Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Tue, 8 Sep 2026 06:02:15 +0000
Subject: [PATCH] usb: typec: ucsi: glink: fix use-after-free of ucsi on remove

The pmic_glink client is released by the devres cleanup, which runs
after pmic_glink_ucsi_remove() has returned, so its notification
callbacks can queue work until then. Work that runs after
ucsi_unregister() has been called touches freed state: it dereferences
the connector array that ucsi_unregister() freed, or registers and
unregisters the instance a second time.

Disable both work items with disable_work_sync() before unregistering,
and unregister only if the instance is still registered.

This issue was found by an in-house static analysis tool.

Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
Cc: stable <stable@kernel.org>
Assisted-by: Codex:gpt-5.6
Link: https://lore.kernel.org/r/20260227190430.889-1-nathan.c.rebello@gmail.com
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260908060216.616045-1-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 12e07b9fe622..1db0c88d817e 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -362,6 +362,10 @@ static void pmic_glink_ucsi_destroy(void *data)
 {
 	struct pmic_glink_ucsi *ucsi = data;
 
+	/* Drain the work items before ucsi_destroy() frees the ucsi instance */
+	cancel_work_sync(&ucsi->notify_work);
+	cancel_work_sync(&ucsi->register_work);
+
 	/* Protect to make sure we're not in a middle of a transaction from a glink callback */
 	mutex_lock(&ucsi->lock);
 	ucsi_destroy(ucsi->ucsi);
@@ -467,8 +471,15 @@ static void pmic_glink_ucsi_remove(struct auxiliary_device *adev)
 {
 	struct pmic_glink_ucsi *ucsi = dev_get_drvdata(&adev->dev);
 
-	/* Unregister first to stop having read & writes */
-	ucsi_unregister(ucsi->ucsi);
+	/* Callbacks can queue work until devres releases the client */
+	disable_work_sync(&ucsi->notify_work);
+	disable_work_sync(&ucsi->register_work);
+
+	/* register_work may have unregistered the instance already */
+	if (ucsi->ucsi_registered) {
+		ucsi->ucsi_registered = false;
+		ucsi_unregister(ucsi->ucsi);
+	}
 }
 
 static const struct auxiliary_device_id pmic_glink_ucsi_id_table[] = {

