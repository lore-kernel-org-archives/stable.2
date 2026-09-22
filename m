Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB165488747
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101013; cv=none; b=JjFvIpZBwY3RA6K7nBMomd4cT8pj6M3LcgbjW8oxQV39l84fj9LuhYhcGiERnwLChPHkl+HNoQmCRwV19eLyfLlExiKUfFPj/ulXF1c7ajr8kvBS/sGXc3Tyjo01cfHjEIf9Ip3lpzqsdo6Q9BVZxfXzE+XJBSkYt+OZoFbqGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101013; c=relaxed/simple;
	bh=QG/hfwLDQSJMiBUpvTee5uhL9FzgO13gDBue1pcGlxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2JI2Ks052XoPV6UUkjMJozzU+FI01zc4ikHEIuYmAghHIw2AMIMErDl1XvYaoMEtUW2XSb8BOhbl3gg8eDwNbRVTckLoTR6BUP5JPpyAAQ6emd5U/dIeOkxR1gUcW3jzKx7TkmKEaZmQVyO+jGi/JT/wKI2SLTqmwj+RI/mw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isF3b46a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isF3b46a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC781F000FF;
	Tue, 22 Sep 2026 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101011;
	bh=08hkWN0olQb+UsEWJd7CKon3qY2RAe7N9oEZAV6WGWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=isF3b46avAtdLiB5oPKsjjkUWAXeHyiEw41njmi1qQvnivJzlMRh8JSdFuEGBKI1U
	 hOvsPtITYTUmcXYVmsWlGZm9podScPiuv0cB+L7espazvYm7E2j30xn/ON+CdEcris
	 mTTRwAvYZtTt3UW6xhZ9i+mwcMWAZ//7W8Zqhg/bpiAWWhh5XU4fhEIN4ww5vKronv
	 ryBsACEI3Zr+s5bYqTeV7k44r1F5D5AMfZNDoCx7VAchdpOvMkcMBZKTnbmlbEqdtS
	 WbTP3w8Sz2Vcj8DF3p5/YsVvhr9VzaKHSHyQ99TzZqL8GjnGB4DXnvt+kUjkPPKvL8
	 hUrAs5qnDb1/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] mmc: hsq: Fix use-after-free in retry work
Date: Tue, 22 Sep 2026 14:16:47 -0400
Message-ID: <20260922181647.3522363-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922181647.3522363-1-sashal@kernel.org>
References: <2026092257-ranger-harmonize-17aa@gregkh>
 <20260922181647.3522363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 5d132990475f02cfa1debe03d50b479432864ebd ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmc_hsq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 424dc7b07858f..473aa02973d65 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -7,6 +7,7 @@
  * Author: Baolin Wang <baolin.wang@linaro.org>
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
@@ -324,6 +325,7 @@ static const struct mmc_cqe_ops mmc_hsq_ops = {
 
 int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 {
+	int ret;
 	int i;
 	hsq->num_slots = HSQ_NUM_SLOTS;
 	hsq->next_tag = HSQ_INVALID_TAG;
@@ -341,7 +343,11 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
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
 
-- 
2.53.0

