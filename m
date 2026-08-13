Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7E3B71A4;
	Thu, 13 Aug 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615761; cv=none; b=dFSbyBEe0gnZiWo4XzkZB6rRs93ypqBlMR8S6q+3w+dWbOpOQFTturKvdiyaM98fXllY5tX5FLwgX+7OsiEmthLlnqVj2RlNsgYeFDUFh7IYhiDBY3CXZvRk4Ol16yurtFZexfRLYIdD/qhcGyK3O/Mk7mFHgbkl+rU5J5of2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615761; c=relaxed/simple;
	bh=2/40GNmVMzpabgYXiLtoWLh5cSHzJFeZXyGwsZ/vHT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6qCpBQb33Va3IaPub6N8vLnXp8sQBT2tV1tqSlcDzBRhhgausMae5oSbPGZgDotGMZ/f26vswC/iBuDiLYM16Z3ZssuznsEa2Zn2PiyvC97nbS0paUCH4IYUNmyyhgu+BwBofa+mehM256Q5bleoC/hHdIcz37zznZGti9+Q7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S.localdomain (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHDDrJl31qFCclBQ--.46566S2;
	Thu, 13 Aug 2026 18:09:13 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: zajec5@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] bcma: propagate bcma_register_devices() error to host probe
Date: Thu, 13 Aug 2026 18:08:36 +0800
Message-ID: <20260813100836.2913-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHDDrJl31qFCclBQ--.46566S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4rZF1rXryfKFyxJr45Awb_yoW8Zw4kpa
	n8Wa45C34vgr48uF4DAF10yFy5Krn2krW8uF1fCwn5ua9xCry8trWUta40ga1DCFW0ka4r
	tF1jq3WruayUAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjiL05
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAISA2p9Zlej2QAAsD

bcma_bus_register() ignores the return value of bcma_register_devices(),
which reports a failure when bcma_gpio_init() cannot register the GPIO
chip. The error is silently discarded, so the bus is registered anyway
and the host device stays bound with the bus half-initialized.
On device removal bcma_bus_unregister() unconditionally calls
gpiochip_remove() on a chip whose gpio_device was never registered,
the failure paths of gpiochip_add_data() free it but leave chip->gpiodev
dangling, and gpiochip_remove() dereferences it without any check,
causing a NULL pointer dereference or use-after-free.

Fix it by checking the return value of bcma_register_devices() in
bcma_bus_register() and propagating the error to the caller, so the host
probe fails instead of leaving the device bound in a half-initialized
state. This new failure exit can be taken after some cores were already
registered, so make the SoC host probe failure path unregister them, as
the PCI host already does.

Fixes: cf0936b06d8e ("bcma: add GPIO driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/bcma/host_soc.c | 1 +
 drivers/bcma/main.c     | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/host_soc.c b/drivers/bcma/host_soc.c
index 20b1816c570b..0bec0d005b89 100644
--- a/drivers/bcma/host_soc.c
+++ b/drivers/bcma/host_soc.c
@@ -236,6 +236,7 @@ static int bcma_host_soc_probe(struct platform_device *pdev)
 	return err;
 
 err_unmap_mmio:
+	bcma_unregister_cores(bus);
 	iounmap(bus->mmio);
 	return err;
 }
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 72f045e6ed51..55d17546c797 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -477,8 +477,9 @@ int bcma_bus_register(struct bcma_bus *bus)
 	}
 
 	/* Register found cores */
-	bcma_register_devices(bus);
-
+	err = bcma_register_devices(bus);
+	if (err)
+		return err;
 	bcma_info(bus, "Bus registered\n");
 
 	return 0;
-- 
2.43.0

