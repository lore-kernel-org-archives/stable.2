Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD054B4873;
	Thu, 17 Sep 2026 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638801; cv=none; b=eTXUvu0/kGwpIsGnRvRSnS/ht0itezF3t5mJkBhWGayUxrZ1bKa+HA4rCuPJuLTMSoHuy1TDYh273mCsPeUmUuBkg2D/k2xzwBhL2qLhPKxkc331mghjWIBF0GWwKfbmeN0JQM1hnqztM2yeWrGM/QK3R9/4ePLw638TMxjZXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638801; c=relaxed/simple;
	bh=3f+jxO7PK1JG6jEHmHY1Phs4vDzY8wgV/qRx4U2vZNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NZgRs9VerTYbL8pdvaa0FPcZiYgSuWTbEMi03TX0Y4a7Q7jV2W8M+cDgyIMpF6j/UlA/aY9WfFQAu8wc5doQ5plIkU2FhW+piA25vugFR/2lMYuKLXz2smpTtRe/FS/JjV6ASeeTaVU730PK3cPUa3ixeG/VdGnEc6AtMagUomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAXgDp+uKtqMQ9+CA--.63250S2;
	Thu, 17 Sep 2026 17:53:02 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: davem@davemloft.net
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] can: flexcan: Fix OF node reference leak in flexcan_setup_stop_mode_gpr()
Date: Thu, 17 Sep 2026 09:53:02 +0000
Message-Id: <20260917095302.2145506-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXgDp+uKtqMQ9+CA--.63250S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF4xZFWkWFW7Wr4xCr17ZFb_yoWkXFb_Gr
	97uF93Ww1UurnrKw4UKw43ZrZa9F1DXF95Xr4xtFW3GayjqF1UtrWfZF45GwsrJrs5ZF9Y
	kF9xArW0g34UXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73Uj
	IFyTuYvjfUOMKuUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUNA2qrrRks4QAAs0

of_find_node_by_phandle() takes a reference on the GPR node and the
error path releases it through out_put_node.  The success path returns
before reaching that label, so the reference is leaked every time the
stop mode is set up successfully, and the node can never be freed.

Release the node reference before returning.

Fixes: 13dfb3fa4943 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/can/flexcan/flexcan-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..68699d674fc3 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1986,6 +1986,7 @@ static int flexcan_setup_stop_mode_gpr(struct platform_device *pdev)
 		"gpr %s req_gpr=0x02%x req_bit=%u\n",
 		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit);
 
+	of_node_put(gpr_np);
 	return 0;
 
 out_put_node:
-- 
2.34.1

