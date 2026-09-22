Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8F46D09D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099758; cv=none; b=B4FOh8tfvifiC8SAN2Pvp0MEFMlmVmr2eui53bUcJInE93ox0cWDagz38zjsn0+5bi4CErdVFhBgN7J3xFUGFVl7R6se3yrt1XdWx/QPdoV4pANTSTehV1Zb5swqVdpCG+KJO1k/G9smosFeTY/ObdWid5jx/7SlN0xirdXKUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099758; c=relaxed/simple;
	bh=cZ67qDwdDBXW8MnNqXE32Lk/opMdpdJkN6CGBD9TGh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZCtgCTyYEkWcNI45ZmUuA0bfizVVZpdc9b0A7u2wb3y6qizVD4qJOHXiuQboc0P2ShBGf2IyxOuuRZi173xag+v4+F4UokpfhO8FtDvbrD2vZ8O+gwao0YEjf3j7eoqv19pVYWGDmss1WvoSzbH76UEPrnDNQnTpWbF71LryXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOw16TzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOw16TzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD4D1F00893;
	Tue, 22 Sep 2026 17:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099756;
	bh=ryNYcCwCW3hHpw46qAah668Ubeuy1RtewgH9z2szuw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VOw16TzDCyTrhr4m5lujZ5TVFmLmDm0tTxKiD8mMjvnxLV4bSOjISaYLlgpwc+qa0
	 mVHYNHhWGOL/tFC/rWg16VnFfDTJxnLlcFQ213+dcryP/T9eruxVyjyEtPev3FW8d+
	 +uuw1GXXab2K3G6Lmcx9kW+Olfcu4EXJWQXAq3JHjwN/2DJ211tgZj5UL9zXTl2Rmf
	 Lseak2gIZLvjXooSXHU4KWxu7FMeazUdhcEogIoD+KL/mPk1IZtq/CgByZzEAz8rQx
	 EdazbMoKt8xhkp3hd5xu7NjZGCym88nEKNCyiz47bP2cXMh6K/wQgtd+7N5p6x+Zo8
	 CNaHvirJsnKyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mmc: hsq: Fix use-after-free in retry work
Date: Tue, 22 Sep 2026 13:55:54 -0400
Message-ID: <20260922175554.3320626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092257-unnamed-ligament-6b2b@gregkh>
References: <2026092257-unnamed-ligament-6b2b@gregkh>
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
[ Adjusted mmc_hsq_init() context for the missing int i declaration and tag_slot[] initialization loop. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmc_hsq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 9d35453e7371b..929cdb496cdd7 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -7,6 +7,7 @@
  * Author: Baolin Wang <baolin.wang@linaro.org>
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
@@ -339,6 +340,8 @@ static const struct mmc_cqe_ops mmc_hsq_ops = {
 
 int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 {
+	int ret;
+
 	hsq->num_slots = HSQ_NUM_SLOTS;
 	hsq->next_tag = HSQ_INVALID_TAG;
 
@@ -351,7 +354,11 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 	hsq->mmc->cqe_private = hsq;
 	mmc->cqe_ops = &mmc_hsq_ops;
 
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

