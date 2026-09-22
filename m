Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFAB552939
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088605; cv=none; b=J81+48MYphSjKViL81MOkiu6jls9DsPCIayoEF8P0CJeHROpBsT+mH7tB1levH/EYPB14ayzVBhm/ihIAgPyqpWPWp5Fs9fJrFCXBeAlm920a98W4HpfN0FWo05DE+eQ7UJT4ZvzqoPsgss2cAtOkEpOd9Oduv3MZlPWSzPL2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088605; c=relaxed/simple;
	bh=+kinYMR0yMhivzrs8ORg4/MSyFKtdP9Mj3lZS+87das=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OM2590BYN/sHFhLHewII3ObsAQHAXvMwuOYEUEj8W0BzQh6J+qgGHMTXe0GH7Ww9XyJvyv0BJmko8C+sxkU+ssJEIoyMRWPFD+zlBeoGO8uDM7b03M/Hgcui/dWeZq6rulZQd2NX0EMyOdVvX+12oYKv/pL1laH40tV+P2BnClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LfFhn0bo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LfFhn0bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C591F000FF;
	Tue, 22 Sep 2026 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790088603;
	bh=01MqJadwCBQgXfrsVSNifetfEEh5CE50BbKBB4eZOFQ=;
	h=Subject:To:Cc:From:Date;
	b=LfFhn0boA0+SiC/sdP59hRJ7Zybl0AqAFz6exlEQ+C15sYjNlaZ9fXrJYf8wbvH2J
	 AkZT20w9etL12S4FT7zxdOUSN06WZOiUuL0rMN4zlAobRiBCRuH9k6bXAGUvcFUzs6
	 0Biaw9efiLbALku4CTNNHDRqC5vRL+3WOhJoKqKc=
Subject: FAILED: patch "[PATCH] mmc: hsq: Fix use-after-free in retry work" failed to apply to 6.1-stable tree
To: fanwu01@zju.edu.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:49:56 +0200
Message-ID: <2026092256-daytime-musty-b7f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5d132990475f02cfa1debe03d50b479432864ebd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092256-daytime-musty-b7f1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d132990475f02cfa1debe03d50b479432864ebd Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Fri, 14 Aug 2026 08:23:54 +0000
Subject: [PATCH] mmc: hsq: Fix use-after-free in retry work

mmc_hsq_pump_requests() queues retry_work when request_atomic() returns
-EBUSY; today sdhci-sprd is the only consumer that implements
request_atomic(). The work is embedded in a devm-allocated mmc_hsq, but
is never cancelled during driver removal. Work still pending at unbind
can therefore run after the devm allocation has been released and
dereference hsq->mmc and hsq->mrq.

Use devm_work_autocancel() to cancel and drain retry_work before the devm
allocation is released. By the time devres cleanup begins,
mmc_remove_host() has already stopped the host, so no new requests can
arm the work.

This issue was found by an in-house static analysis tool.

Fixes: 6db96e5810e0 ("mmc: host: Introduce the request_atomic() for the host")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 79836705c176..57e172bd3487 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -7,6 +7,7 @@
  * Author: Baolin Wang <baolin.wang@linaro.org>
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
@@ -345,6 +346,7 @@ static const struct mmc_cqe_ops mmc_hsq_ops = {
 
 int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 {
+	int ret;
 	int i;
 	hsq->num_slots = HSQ_NUM_SLOTS;
 	hsq->next_tag = HSQ_INVALID_TAG;
@@ -363,7 +365,11 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 	for (i = 0; i < HSQ_NUM_SLOTS; i++)
 		hsq->tag_slot[i] = HSQ_INVALID_TAG;
 
-	INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
+	ret = devm_work_autocancel(mmc_dev(mmc), &hsq->retry_work,
+				   mmc_hsq_retry_handler);
+	if (ret)
+		return ret;
+
 	spin_lock_init(&hsq->lock);
 	init_waitqueue_head(&hsq->wait_queue);
 

