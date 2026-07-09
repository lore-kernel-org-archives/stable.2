Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DF7271443;
	Thu,  9 Jul 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615389; cv=none; b=qV9mX2XCRsDIM55BfCinkr6yyEjAvjU+wHU1UBidJPnMe2018KqH/We2YH1n6Zoz2iuMxUo53kI8EVph2Q6uoOoGi+/fEX+ORvx7BP95Z/UZiVjmtwDL8coxm2zuUfkre5CAFOyWG4nnOgNNnNRqeXxyqmb+XqvAfjCidoNBLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615389; c=relaxed/simple;
	bh=YquYgiHz27cAYahxa2jasOBSEGSj+59543goIaQFJiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/A/tDHgznuI0M4tWNUEmBgX54F2J5BxnECSKJLtxadyD3VeSOm94QvMC2XUvQiJLzZcKNA35rKTZtq1SUjuain9FGwtXNv2k8y7wUgkVZ61z0oGoHVnNOdZ1keUpTnvEpBVL+fKfCtYXkzstqFHeM+qspgmM9MKVeSjy2tSKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wB3YReQz09qdzosAA--.3625S3;
	Fri, 10 Jul 2026 00:42:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgDHcHOOz09qb4ACAw--.4426S2;
	Fri, 10 Jul 2026 00:42:54 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-can@vger.kernel.org
Cc: frank.jungclaus@esd.eu,
	socketcan@esd.eu,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	jedrzej.jagielski@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v2] can: esd_usb: kill anchored URBs before freeing netdevs
Date: Thu,  9 Jul 2026 16:41:59 +0000
Message-Id: <20260709164159.497640-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709104620.133765-1-fanwu01@zju.edu.cn>
References: <20260709104620.133765-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgDHcHOOz09qb4ACAw--.4426S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?MGOOSgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WMgQP3E+hpoHT8pUffByOwzd1S5MrBh9WwXO8UubmxgkkDg
	kpY8W4eVWYkcJbwBZSAB5rM+H8XhqwExY4Cjs2QP
X-Coremail-Antispam: 1Uk129KBj93XoW7CFW8Xw1fZFyfAr1fJryrGrX_yoW8ur13p3
	yFyF1ftFykWrn3AwsrA3ZrJFyUC3ZrA34UWry7W345Zrs3ZFy0g3W8KrWj9r1kurZYkFyF
	vwnrA3yUKa95urgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVWUJVW8JwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

esd_usb_disconnect() frees each CAN netdev with free_candev() inside
its per-netdev loop and only calls unlink_all_urbs(dev) afterwards.
The per-netdev private data (struct esd_usb_net_priv) is embedded in
the net_device allocation returned by alloc_candev(), so once
free_candev() has run, dev->nets[i] points to freed memory.
unlink_all_urbs() then dereferences the freed dev->nets[i] to kill the
per-netdev TX anchor (usb_kill_anchored_urbs(&priv->tx_submitted)),
clear active_tx_jobs, and reset priv->tx_contexts[].

Reorder the teardown so the anchored URBs are killed before the netdevs
are freed, matching other CAN/USB drivers in the same directory such as
ems_usb, usb_8dev and mcba_usb, which unregister, then unlink, then
free: unregister the netdevs first (which stops their TX queues), call
unlink_all_urbs(dev) once, then free the netdevs.

This issue was found by an in-house static analysis tool.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes in v2: shorten the Fixes: tag to the abbreviated 12-char SHA
per Jedrzej Jagielski ("no need to put whole SHA, 12 first chars is
enough").

v1: https://lore.kernel.org/netdev/20260709104620.133765-1-fanwu01@zju.edu.cn/
 drivers/net/can/usb/esd_usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index d257440fa..f41d4a0d1 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1390,10 +1390,13 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 				netdev = dev->nets[i]->netdev;
 				netdev_info(netdev, "unregister\n");
 				unregister_netdev(netdev);
-				free_candev(netdev);
 			}
 		}
 		unlink_all_urbs(dev);
+		for (i = 0; i < dev->net_count; i++) {
+			if (dev->nets[i])
+				free_candev(dev->nets[i]->netdev);
+		}
 		kfree(dev);
 	}
 }
-- 
2.34.1

