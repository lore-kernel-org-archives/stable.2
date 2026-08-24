Received: from mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0436895D
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573251; cv=none; b=SI8yZifb3I90aQXpaeEre+d5kZZj90raGmyJaL8yj4oxQ4fiPOPzvhjeYAUW5KX6eBgPfmDTCncAV/splJl6XMxHOwWoQB9Ks15jAzMDXcZhT1bImWY3mjVXAwwB6p3k8MYVmU7G3eNbCJsrilcxRpmILehq9ErxOPKwv9HDRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573251; c=relaxed/simple;
	bh=BDiJdAAtUD92ISyF12fPSqcPbxouJgrro2chaJ5giqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/9wBHAF9SvcahFM7MUvd7hALaQYoR1lK5Hv+U5oSqDhT2ngKwv3tZaijXLzIaNTPJWT9Y8g7GnGw5k5albFm/YOhnHaoso1L+WRX0SvIyqbPPdPgOtaZwTS/Bu9OgEcowfHbdzT1Rw0ZsCJmbdq0nhCqaEkn5ZkOGHXf69bJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y4S1qaKr; arc=none smtp.client-ip=91.218.175.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y4S1qaKr"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BDiJdAAtUD92ISyF12fPSqcPbxouJgrro2chaJ5giqM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787573248; v=1; x=1788178048;
 b=Y4S1qaKr82Rx+ykfLLx2NR4Wl+1j7qGlNApm5N8I4qjq9USFYGKwpWBen1dxTas4RDma2YHq
 Ur4Dpj6BPGA+h0ggTM4lpcoA2w5bZ0ZiMLCLocFia7TzkI8FnMAX+M/5bLOOBhsZkLvIwmMK17c
 yVtmw/TJKcz2RqOmTA47z5vs=
X-Envelope-To: stable@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 94adfce5723ac7f1;
	Mon, 24 Aug 2026 12:07:18 +0000
X-Mizu-Trace-ID: 94adfce5723ac7f1
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1] net: phy: fix NULL deref in IRQ handler after unbind
Date: Mon, 24 Aug 2026 20:07:03 +0800
Message-ID: <20260824120703.107412-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

phydev->drv can become NULL while the phy_device is still attached to
its net_device, after the PHY driver is unbound via sysfs:

    echo <mdio_id> > /sys/bus/mdio_bus/drivers/<phy_drv>/unbind

phy_remove() clears phydev->drv but does not free the threaded IRQ
installed at attach time. A later hardware interrupt, or another
device on the same IRQF_SHARED line, then oopses in phy_interrupt()
on phydev->drv->handle_interrupt():

    Unable to handle kernel NULL pointer dereference at 0x138
    ...
    pc : phy_interrupt+0xb4/0x108
    Call trace:
     phy_interrupt+0xb4/0x108 (P)
     irq_thread_fn+0x34/0xb8
     irq_thread+0xc8/0x178
     kthread+0x128/0x138
     ret_from_fork+0x10/0x20

The same unbind sequence is already treated as valid. Skip the
driver callback when no PHY driver is bound, matching other phylib
unbind paths. Also guard phy_config_interrupt(), which is reached
from phy_disconnect() after the same unbind.

The IRQ is requested at attach time and released by phy_disconnect(),
so phy_remove() cannot free it without a later double-free. After
this change the handler returns IRQ_NONE. If the PHY keeps the line
asserted and no other shared handler claims it, the IRQ core may
eventually disable the whole line ("nobody cared") and affect other
devices on that IRQ. That is a limitation of not tearing the IRQ
down on driver unbind, but it is still better than the NULL pointer
dereference that the same interrupt triggers today.

Fixes: c974bdbc3e77 ("net: phy: Use threaded IRQ, to allow IRQ from sleeping devices")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be3304..5435f62e98171 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -168,7 +168,7 @@ EXPORT_SYMBOL_GPL(phy_get_rate_matching);
 static int phy_config_interrupt(struct phy_device *phydev, bool interrupts)
 {
 	phydev->interrupts = interrupts ? 1 : 0;
-	if (phydev->drv->config_intr)
+	if (phydev->drv && phydev->drv->config_intr)
 		return phydev->drv->config_intr(phydev);
 
 	return 0;
@@ -1436,7 +1436,10 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 	}
 
 	mutex_lock(&phydev->lock);
-	ret = phydev->drv->handle_interrupt(phydev);
+	if (!phydev->drv)
+		ret = IRQ_NONE;
+	else
+		ret = phydev->drv->handle_interrupt(phydev);
 	mutex_unlock(&phydev->lock);
 
 	return ret;
