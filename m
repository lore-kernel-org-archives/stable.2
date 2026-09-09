Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93D56B85E;
	Wed,  9 Sep 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965822; cv=none; b=nJ146JxNq0JpHaCEsvuJylp5k6SDWH+6QKhkdHQTOwHPhzxCmaXDWENFYvUoeD1UTN/qsOYku7mY+EPuTMK6eluHia0OTS3xvssFboOouAHHMQ5v6suD3Yc/A1V5kacuckMS5NqLv5lSORQvotqP6ITkEARQoMkPBiUzTi/9pkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965822; c=relaxed/simple;
	bh=h96uvAJIcFvW/gvc9/E2ZoaxXrEGFbZ0wNVkmbqJy2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AthJndVlvWFLkXX3fVZ8m6tWJ7oncFqhkQ3WIRHTU6PGq27aoDmtDFmjH6p4yQ0nqyNjvtdH+oMFPcbiuYZ4WxhNiyS249HN2aW6xFOQ/aImQ69bt3+i9gusYuQwRR2Sv5uaMsSbnZ+eN325yMzcEyLCG0UXg2w4E7WohOMFXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAn0zy0c6FqOpEDAQ--.3218S3;
	Wed, 09 Sep 2026 22:56:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgBnMXW0c6Fq1tELBQ--.36455S2;
	Wed, 09 Sep 2026 22:56:52 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Cc: logang@deltatee.com,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] NTB: ntb_msi_test: Cancel setup work on remove
Date: Wed,  9 Sep 2026 14:55:54 +0000
Message-Id: <20260909145554.704036-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBnMXW0c6Fq1tELBQ--.36455S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?EAMcSAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WMlFP4rfsrrQsG96E5DvaxSA7dPZChY0xT5almqjCaBI1yD
	kB8etoL/Q+m8BNffQ+ep9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7WF17Gry8Ww45ZrWfCryDJwc_yoW8uFy3pr
	15ZryY9ayktanrAanrXayjv3WFyws3AFWxGryfGwnrZF15AFyUKa43tayayr48JrW8ZFn3
	Aw4Uta18Za98CFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2EoXUUUUU

The MSI test client queues setup_work from the link event callback
ntb_msit_link_event(), which the NTB core dispatches whenever the link
comes up. The work handler ntb_msit_setup_work() recovers the client
context with container_of() and programs memory windows, scratchpad
registers and MSI interrupts through it.

ntb_msit_remove() never cancels the work. ntb_clear_ctx() stops new
link event callbacks from being dispatched, but it does not drain a
setup_work that was already queued. After the remove callback returns,
the NTB device's devm eventually releases the context, and a
still-pending setup work can then run and dereference freed memory.

Quiesce the callbacks and drain the work before tearing down the
resources the work programs. Cancel the work after ntb_clear_ctx(),
which guarantees no new instance can be queued: link events are
dispatched under the same ctx_lock that ntb_clear_ctx() holds. Do this
before ntb_msi_clear_mws(), so a late setup work cannot re-program
memory windows that remove() has already cleared.

This issue was found by an in-house static analysis tool.

Fixes: a6bed7a54165 ("NTB: Introduce NTB MSI Test Client")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/ntb/test/ntb_msi_test.c | 3 +++
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
index 4e18e08..290c2b3 100644
--- a/drivers/ntb/test/ntb_msi_test.c
+++ b/drivers/ntb/test/ntb_msi_test.c
@@ -391,13 +391,15 @@ static void ntb_msit_remove(struct ntb_client *client, struct ntb_dev *ntb)
 	int i;
 
 	ntb_link_disable(ntb);
+	ntb_clear_ctx(ntb);
+	cancel_work_sync(&nm->setup_work);
+
 	ntb_db_set_mask(ntb, ntb_db_valid_mask(ntb));
 	ntb_msi_clear_mws(ntb);
 
 	for (i = 0; i < ntb_peer_port_count(ntb); i++)
 		kfree(nm->peers[i].msi_desc);
 
-	ntb_clear_ctx(ntb);
 	ntb_msit_remove_dbgfs(nm);
 }
 

