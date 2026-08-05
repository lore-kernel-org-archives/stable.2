Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270C298CAB;
	Wed,  5 Aug 2026 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893110; cv=none; b=Z28UGmJPQgqSQx4CBBMBllQr9IMl5imtT1zvpVONRZ9kRyYIaygy3crfg8xs6LGeE+UDqUYRdtvtQLWlGNHoFmWxW4PLKXpA674VeWlCDoZ21CqLgoRHb4sWgpI4Dy/tA76jo5K+VVsvlYVCd7uVMIEqzj1IPy1/WImUHfBnj2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893110; c=relaxed/simple;
	bh=14LQz/KZg6vzOaF8oXJI/mmrnCTlYceRnqOmtBZOcrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTV+MmlQ6b6R06XQGWHFyxYONBG5Hg92PkF3Q/iqdB4jXzsEKy1QdtrIMELnv6uuXEPoVoSJVhmSBCeeLu5s1rmR8cr4bfvYW5YVnF7ZpAE0v2cT/bHqHWA6Yeuk/IoiHC3ObhQUlzNj+OHwoA+YVGo/I9OpBADCpqfM29sPKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCHgD_TkHJqLfhmAA--.15366S3;
	Wed, 05 Aug 2026 09:24:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCHUXXSkHJqqx32Aw--.31562S2;
	Wed, 05 Aug 2026 09:24:34 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net 2/2] fjes: cancel force_close_task in fjes_remove()
Date: Wed,  5 Aug 2026 01:23:37 +0000
Message-Id: <20260805012337.416908-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805011410.414431-1-fanwu01@zju.edu.cn>
References: <20260805011410.414431-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCHUXXSkHJqqx32Aw--.31562S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?+txdwQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WMiY2ZC40s8wkgCtw1ZMdQGncnuOq8iCpYYcFIjXTUu9ygJ
	P4TahSWiUUq494bm6VWp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj9xXoW7XF1DAw4xuw45ZrWDtF43urX_yoWDZrX_C3
	42qFs7Ww4DCay0gw1jkF47Zr1IkFn2qrn293W2kayrtasrAw1ayrnrZrsYqryUZ3sxAF9r
	u3ZIgw1Yqa4xuosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbT8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxU7rcfUUUUU

force_close_task runs on the system workqueue, which destroy_workqueue()
does not drain, so it can run after free_netdev() and touch freed memory.
Cancel it after destroying the workqueues, before free_netdev().

This issue was found by an in-house static analysis tool.

Fixes: 658d439b2292 ("fjes: Introduce FUJITSU Extended Socket Network Device driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/fjes/fjes_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index cddabc965..a2c77ca0d 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1402,6 +1402,8 @@ static void fjes_remove(struct platform_device *plat_dev)
 	if (adapter->txrx_wq)
 		destroy_workqueue(adapter->txrx_wq);
 
+	cancel_work_sync(&adapter->force_close_task);
+
 	fjes_hw_exit(hw);
 
 	netif_napi_del(&adapter->napi);
-- 
2.34.1

