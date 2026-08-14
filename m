Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080B42D757;
	Fri, 14 Aug 2026 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695906; cv=none; b=BVI2ZmygSavCn0yZ/DS4sAEFTH46LMDSGG1S2qGTkDgshbeOfxL98/Wv19XXCmfTehylcjDyGNl83d1Bdp3AJaD9x/8J57rtAL2E9BZssMxUxeXVBN3NwbwzOcDAPvUMX+//XS50irRw0iKnN2RjHchZZV0e21zEjXvMZZSoPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695906; c=relaxed/simple;
	bh=b6yWjzFqSw4TKQnvxuFSsOVoBNjKJoeTFoAKV80cnbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SVuXi+630GP25ZM8VlrcuYvo3Uw5kl+1+L6Z8YKeu+1kkBUP6CgADSbLssD5h/n3MosUgWZzMtGZUHg9lqlUvfTY08ZBXGoabKhCqezfFbrJANAMQSfEBl1P3ibrVMlKIGW68XJcbONg6BQSRODU1lT3rt+fjFrubJBV92SE2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBHxjTS0H5q6a2RAA--.11763S3;
	Fri, 14 Aug 2026 16:24:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgCXUprS0H5qGBzdAw--.15198S2;
	Fri, 14 Aug 2026 16:24:50 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baolin.wang7@gmail.com,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] mmc: hsq: Fix use-after-free in retry work
Date: Fri, 14 Aug 2026 08:23:54 +0000
Message-Id: <20260814082354.211351-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgCXUprS0H5qGBzdAw--.15198S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?EFH2/AXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBFpL80pQrsI0DJHoQlCwFswRysejU9QzOOhM2RQTCQKOrBG
	/DMYx2PupNuCFRg2qsmp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW7XFWDurW8GFW3Jr43Arc_yoW8ZF4fpF
	s3CayYyrs8tFs8G3WDCa1S9Fy3uwn7u3y7Kry0q3Z29rW5Kr1DCF1qyF1jqFn8JrW5Cana
	9FW2vF1DurW5AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tv3UUUUUU==

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
---
 drivers/mmc/host/mmc_hsq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 79836705c..57e172bd3 100644
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
 

