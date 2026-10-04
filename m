Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5D15746F
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099470; cv=none; b=eY+2frBcL3/QmyFfANNUSQpde+kPiyiCHxR//Q/Awc91xgXB1wv0v3/Ui7Fpyq0ky4UenY5p15eA6FRMujgBCdtvkAixkblabZCqTDokgYmQORtkl8WlcLPxFHZa6knu4pZBMCUtT0uMdoFhxN6ogqkOYWpZXarhvWfm4xnIU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099470; c=relaxed/simple;
	bh=fSyQ2hBASDqhnc2q8Hw6S5+70m76TabgNPqGZ+geuRU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cMD+vY2PHRsHs+je3WUlQwCrlbFSdaGQyMnY/eDgZoraqRx8mNV4eagYxZJ6l4e6R8Jygt0laeyd0XG317ldIG/oe4JAgZDWIwpAuYAaB82Ud5Qgsw1UrCxZWsVhn4PJWnxgJBMiAEcY95bbwjh7X5S63qpXimLJOXLowAL+jRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P25VhpML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P25VhpML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943BB1F000FF;
	Sun,  4 Oct 2026 07:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791099469;
	bh=yk+TYfHDsjEJybVp02f73BgZ1eEXPf4SIET847l0uUk=;
	h=Subject:To:Cc:From:Date;
	b=P25VhpMLj86lI9PrvtPt3zG/j7spJI8zXvAnfndxe2eW4ahB+PA2UOpsehz4rTht+
	 46jmAnpl9w1rslGjVtnjrKm8q0qBRip1Up06piACh7wEsmcXlb88M3FUzRc87cy932
	 +RPZzrdXFShHGgk6khHLQOWS5cTr6fpdVT3ekgn8=
Subject: FAILED: patch "[PATCH] wifi: wlcore: Fix runtime PM leak in wlcore_remove()" failed to apply to 6.6-stable tree
To: vulab@iscas.ac.cn,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 04 Oct 2026 09:37:46 +0200
Message-ID: <2026100446-quaintly-establish-1f37@gregkh>
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
git cherry-pick -x a8b8881d0c1aff544fae190469d86db7b07f43a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100446-quaintly-establish-1f37@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

