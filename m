Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F801554094
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088612; cv=none; b=OR40wHBFV+pa6UeABlDgmBWV+aV1Rus7h3x3pG0TnhkpCJ8MPjxLf7HjCd/Qxa3B9hBlBg/icJVaxwd5R20EBoJ6/qqJ78FpPwOAJkQNxoOpq0Oc6zEs5Zy4Oqw3fSVF3M0Uo5enEoUhjRNPfu1yGqsfAhP8wgyjk32YYf/Ws6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088612; c=relaxed/simple;
	bh=Jw8H5PmQEy+8incaOWITymz7FKvREvqj15x28SgyvB8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cg+jhD3Rp++1RHq1GAgUJotntu4QRZCsUIEpaIPKI7uaCgJFNGRWME6ZLOflsP2C+0akeQSQYYXy+P8dTrvMdKTz94/ITthuhmOtVz8UkwSsc0EjXDu8O/2Xd+6IT9s+7olwMI2hYJbDez3DQBdq1hXkXuZPgFIh3y7iHjOoTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yWU6dy/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWU6dy/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7561F000FF;
	Tue, 22 Sep 2026 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790088610;
	bh=VxF1KueTz7uDz1xDQ0NSVkQ8vvKW9sveMuhhqNQo1xo=;
	h=Subject:To:Cc:From:Date;
	b=yWU6dy/NkYbtEw6jS6dxrIBatacyYcl5OY9yA63aIboVdq6ANGCQbqLJt/pQwWlzf
	 j9uK19fdcv+XOSNl0K5DWA8R8xrv9eYFr6CP++hz0dUVsiTdS8qp0X/wKtzI76oSt2
	 clnDpXzakeUTyivQW6jyWeOMGcrCk9J780Fnk0Po=
Subject: FAILED: patch "[PATCH] mmc: hsq: Fix use-after-free in retry work" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:49:58 +0200
Message-ID: <2026092257-ranger-harmonize-17aa@gregkh>
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
git cherry-pick -x 5d132990475f02cfa1debe03d50b479432864ebd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092257-ranger-harmonize-17aa@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

