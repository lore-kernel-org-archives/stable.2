Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35B3B585F
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099484; cv=none; b=YiAP+MNFah8dT+Ps0Lhh6ieFcwcCpFFy0kTXgLlbMzNPH3UX8s31OI/RTpnKywsBUK5mdvZxVLFsScXFMIjvQG1FVQTY6fY1pQipSnSbgNuBfROwd+CS2mj9oGw1ifl3gyx5jOTIFlnikHgxP87g9r6/2npsH4uxk7x9/bVuRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099484; c=relaxed/simple;
	bh=gl4Q92XjNQ8U0uiY/6KDZZHtve/Q4K/A0W86XTzX6cQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TOddbWplhYKvd/JaTowxGGVIKt3ZFiKC5p2/ci7d4e91Ka1A42xw/UwZ1y9im0HcyhfkazJ/pUO5vLfBTFnNHmuxhLAj1RxPHGMC8kGn4YP5UNlwBV9s1tuBdA3w5+/gpKynYqmy5hDY9u7PXQipjHoelkeRA9WCwH7ic5lI4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qmLyubi5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qmLyubi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34721F000FF;
	Sun,  4 Oct 2026 07:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791099483;
	bh=+t9rBk47KBCxrO4SfOg2GiCDUoTxzeYDssUmgFlHTCg=;
	h=Subject:To:Cc:From:Date;
	b=qmLyubi5wJdkMt+jVWlN/IgXREdOLX80pmDCWGrRCPJhk5xU+BH8iPg9SaQ3uz7vF
	 3+TeB97vD+PQ6gs8D88h3xaYVq2gW6a0WvwgPu9iteaGmPz9gP5GSFCcZKbFmpGbEx
	 jyKqROj6nK+mfub3IkP7hWtdZ33Za0U+YU1pWLig=
Subject: FAILED: patch "[PATCH] wifi: wlcore: Fix runtime PM leak in wlcore_remove()" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 04 Oct 2026 09:37:47 +0200
Message-ID: <2026100447-retainer-dude-dd4a@gregkh>
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
git cherry-pick -x a8b8881d0c1aff544fae190469d86db7b07f43a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100447-retainer-dude-dd4a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a8b8881d0c1aff544fae190469d86db7b07f43a9 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 12:23:25 +0000
Subject: [PATCH] wifi: wlcore: Fix runtime PM leak in wlcore_remove()

pm_runtime_get_sync() keeps the runtime PM usage counter elevated even
when it returns an error, so the reference taken at the beginning of
wlcore_remove() has to be dropped on every exit path. When the device
was not initialized the function returned early without doing so,
leaking the reference.

Release it with pm_runtime_put_noidle() as done on the other early error
paths of this driver.

Fixes: fa2648a34e73f ("wlcore: Add support for runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917122325.2150910-1-vulab@iscas.ac.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index edf6ca23c6c3..26aabf4ea127 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6809,8 +6809,10 @@ void wlcore_remove(struct platform_device *pdev)
 
 	if (pdev_data->family && pdev_data->family->nvs_name)
 		wait_for_completion(&wl->nvs_loading_complete);
-	if (!wl->initialized)
+	if (!wl->initialized) {
+		pm_runtime_put_noidle(wl->dev);
 		return;
+	}
 
 	if (wl->wakeirq >= 0) {
 		dev_pm_clear_wake_irq(wl->dev);

