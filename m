Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC93E49F4;
	Mon, 12 Oct 2026 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813601; cv=none; b=e7NK6yoGWg/lqXcpb6HzZS2larGwtLkH75uINehR6/U0ugD6ecR1vXyQOp1pO41L5KBnekp2KOilwClBtk48AdcMoMOlMln1L9QNH9LGwnVDPDZkF5agwuZxJZjNo1YEhFcsXYLGmTNmFKGwOe2Jw212gpk+uU+eBAAYv6pv2rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813601; c=relaxed/simple;
	bh=erU+Vtn/XrxY5Ctqe6ZEUQit+ugO8G22dILw7aKewDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jETfpl9FcBC1a/aOgPo/Hf3XU+LG1ng1xHjfxktDGpbZkeF/3hvuOb791ot4G9VIBIPhz+qOnDbfdajUszglUUo4tknshzdLq/X5lamy7VBnHPgsTNm9oGL8cZz2XGoC+5DM4PMXczkDgurfY1uFLa3HJMAScMblW2TuOL+IqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.11.3.216])
	by mtasvr (Coremail) with SMTP id _____wB3MfzP58xquOV9AQ--.10080S3;
	Mon, 12 Oct 2026 21:59:45 +0800 (CST)
Received: from localhost.localdomain (unknown [112.11.3.216])
	by mail-app1 (Coremail) with UTF8SMTPA id yy_KCgBHmonO58xqFDBYAA--.8506S2;
	Mon, 12 Oct 2026 21:59:43 +0800 (CST)
From: Jiacheng Xu <stitch@zju.edu.cn>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiacheng Xu <stitch@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] netdevsim: avoid NULL dereference after failed probe
Date: Mon, 12 Oct 2026 21:59:41 +0800
Message-ID: <20261012135941.78329-1-stitch@zju.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBHmonO58xqFDBYAA--.8506S2
X-CM-SenderInfo: qtrxiiaqttimo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?AKuJvgXKKxbFmtjJiESix3B1w3tMoM3snk/k5SVzZVydjEqe1eefKHnLf95EnB4iem
	egW7q+4qg3kAwHIt6WUKLmaHqT5b+eSmyf0J41sJ7TquGnO3lAKCf+U/R+SzNK7XS1KTT9
	anvBD+gP1d0mrvw2xw1gR/p1tPmVcNBN/fZxSumT
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw15XFWUuryxurW3Cw47KFX_yoW5Jr4rpa
	98KFy5trykWws7Wwn8ZF40yFyrWw18Jw43ury3A3s3ur12qryqqryYgF90k3W0y3yxJFy5
	XrWDCFW8uFZ0yrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvqb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x
	07jj7KsUUUUU=

device_register() reports whether device registration succeeded, not
whether the matching driver's probe succeeded. If nsim_drv_probe()
fails, the driver core leaves the nsim_bus_dev registered while the probe
error path clears its driver data.

new_device_store() subsequently marks the nsim_bus_dev initialized. A
write to its new_port or del_port attribute therefore passes the init
check and calls nsim_drv_port_add() or nsim_drv_port_del() with no valid
nsim_dev. Both helpers pass the NULL driver data to priv_to_devlink(),
leading to a NULL pointer dereference.

This can be reproduced by creating a netdevsim device for which
nsim_drv_probe() fails and then writing to the new_port or del_port
attribute of the registered device.

Serialize the driver data check and the port operation with the device
lock, and reject the operation with -ENODEV when no driver data is
present. This also prevents driver unbind from freeing nsim_dev between
the check and its use, and follows the locking used by sriov_numvfs.

Fixes: 794b2c05ca1c ("netdevsim: extend device attrs to support port addition and deletion")
Cc: stable@vger.kernel.org
Signed-off-by: Jiacheng Xu <stitch@zju.edu.cn>
---
 drivers/net/netdevsim/bus.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 41483e371f05..0ab51306ad0a 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -93,8 +93,13 @@ new_port_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index,
-				addr_set ? eth_addr : NULL);
+	device_lock(dev);
+	if (!dev_get_drvdata(dev))
+		ret = -ENODEV;
+	else
+		ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
+					port_index, addr_set ? eth_addr : NULL);
+	device_unlock(dev);
 	return ret ? ret : count;
 }
 
@@ -115,7 +120,13 @@ del_port_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index);
+	device_lock(dev);
+	if (!dev_get_drvdata(dev))
+		ret = -ENODEV;
+	else
+		ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
+					port_index);
+	device_unlock(dev);
 	return ret ? ret : count;
 }
 
-- 
2.25.1

