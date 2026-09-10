Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD094BFE8A;
	Thu, 10 Sep 2026 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006010; cv=none; b=Mg0k/GRAaGtrbmZWW+1iLaXRCmKiXPnCxuvKFDPLl7VSlPluabJ0xaWPfIdhxXBjZuMBhIbSsRSXcYcy7RNDrN+zNtzX1wsmk3PGmUC2VxlTKUfqAnKjUUqlVj8f52LGB3DiKvQHjSabl+Hc1cYHSKhojChzldciSjOAESTAqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006010; c=relaxed/simple;
	bh=XMPOz26HqVnHeHRmY8MftMZznl7PAJ3nT+H42oGzXGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePug1YI1HIP0NQJ8xwTV49vEf1uEylyzDTnafxzZ2ZUpSObYxpNAo/MYV4ERScqtJ0XOL8V7mSKUF+JUo+0WPhin9idWhSbTPYxXE5F3hVkimlgjz18SgVrudjuLwDFzQPJIOzZgxeZxOw4OQ2wPUK7mj2hF+DMzerziYIPtI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAH8oSkEKJqAgwFAQ--.1190S3;
	Thu, 10 Sep 2026 10:06:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgCn2TCkEKJqzQ2rAw--.47387S2;
	Thu, 10 Sep 2026 10:06:28 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH net] net: korina: fix use-after-free in media check timer
Date: Thu, 10 Sep 2026 02:05:33 +0000
Message-Id: <20260910020533.2904-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCn2TCkEKJqzQ2rAw--.47387S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?fPB5JQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZwEggqrLUGMM4u4fBL1frl/RuNybv+rPmmuT252nq42Tb96
	rA9sMovbn0l9DmPurQ6p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7uw47ArWrKrWDKF4xXr1rZrc_yoW8Ary7pF
	ZxWa4jkryvy3y7Aw17Za97WFy5A39xtry7Wr1xCayrZwn5AF4UKFy3GasY9FW2kFWDJaya
	yw4DZ343AFs8J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

korina_poll_media() rearms the media check timer by calling mod_timer()
unconditionally before returning. korina_close() stops it with
timer_delete(), which does not wait for a callback already running on
another CPU.

Such a callback can continue to access the netdev private data and can
rearm the timer. Once korina_remove() returns, devres releases the
netdev and its private data, so either the running callback or a later
timer expiry can dereference freed memory through lp->dev, lp->mii_if,
or lp->eth_regs.

The only timer armers are the callback itself and korina_open(). RTNL
serializes open against close, and timer_delete_sync() waits for a
running callback and removes the timer it rearmed. It is therefore
sufficient here while preserving the close/open cycle.

This issue was found by an in-house static analysis tool.

Fixes: 4d5ef9f0f588 ("korina: periodically poll the media")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/ethernet/korina.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index 891a94d89f4b..b7de2238f4b3 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -1240,7 +1240,7 @@ static int korina_close(struct net_device *dev)
 	struct korina_private *lp = netdev_priv(dev);
 	u32 tmp;
 
-	timer_delete(&lp->media_check_timer);
+	timer_delete_sync(&lp->media_check_timer);
 
 	/* Disable interrupts */
 	disable_irq(lp->rx_irq);

