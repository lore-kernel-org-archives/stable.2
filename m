Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109624D0CDF;
	Thu, 17 Sep 2026 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642497; cv=none; b=hIuzmwAPxP4rAJd1uSiKluX44TIhsaxaKeGN7CfO6Q4cK1bfg1/3+GVJ1+adzHVL0ufGs1MP6zca9KWTFW0oRAVomHCx07Ff9Py4AeHqeMIFEcAn0/sjt0elbP/4mMQ+2rDdhp2jHePMMiLX/8sjBY/h7GPki1ysPJOQ2otWzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642497; c=relaxed/simple;
	bh=giIWjDDBHc/Az7Gt57hxkGh/olN1AnVWv+gcsPhSTsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T3CIutQpJ0Uz8s7eLKAxbLV68wzAjjSr/ACUbenxjV9q4TLbAtXQ2lHPOHELqklO44IhET6LQswcUcS0u23b7K9fvNVYVRE832iX+J4M2sD8uInpDfnQpxOGPRoGZjv3oGDW1IVw8Y1Pg4So2KMrts17Y5NG+sDGpGf9y7jSlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAXgDrhxqtqdwl_CA--.64396S2;
	Thu, 17 Sep 2026 18:54:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	jeff@garzik.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stephen@networkplumber.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: cxgb: Fix skb reference leak in espibug_workaround_t204()
Date: Thu, 17 Sep 2026 10:54:25 +0000
Message-Id: <20260917105425.2147804-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXgDrhxqtqdwl_CA--.64396S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4fAFyUGFyDXrWUZFyrZwb_yoW8JFyDpw
	4qka47CrZ8Za12ka1kAw48tF9xua1ktFWrKF1fJws5ZrsxJr4UWry0qF45KFWDArZ3WanI
	yrs8Aan8Krs0y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU5TOJ7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgENA2qrq3ZfDQAAsH

The timer handler takes an extra reference with skb_get() before handing
the skb to t1_sge_tx(), so that the skb survives until the DMA has
completed. When the command queue is full, t1_sge_tx() returns
NETDEV_TX_BUSY without queueing the skb, and the return value is
ignored, so the extra reference is never dropped.

Free the skb when t1_sge_tx() reports that it did not consume it.

Fixes: f1d3d38af757 ("[PATCH] chelsio: add support for other 10G boards")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/chelsio/cxgb/sge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb/sge.c b/drivers/net/ethernet/chelsio/cxgb/sge.c
index d8fca697874a..d4677c5b8d74 100644
--- a/drivers/net/ethernet/chelsio/cxgb/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb/sge.c
@@ -2052,7 +2052,8 @@ static void espibug_workaround_t204(struct timer_list *t)
 			 * the skb once the DMA has completed.
 			 */
 			skb = skb_get(skb);
-			t1_sge_tx(skb, adapter, 0, adapter->port[i].dev);
+			if (t1_sge_tx(skb, adapter, 0, adapter->port[i].dev))
+				dev_kfree_skb_any(skb);
 		}
 	}
 	mod_timer(&sge->espibug_timer, jiffies + sge->espibug_timeout);
-- 
2.34.1

