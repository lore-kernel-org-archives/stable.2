Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550012F3C19;
	Fri, 26 Jun 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488098; cv=none; b=Db5eDhS8TP//k4NEQQd+tQljNo1ZvmdnH79icHjwuMiXlbEriZXo6gkF24lwJIW+/SsZ1rDnj+s/ksaWuG1Vg6CwT3p2omg0emSAHJG++6RtGhdGHTDdefZFTuYK8YP+N5g2Kpq9DYzNV7MO25V3TMxytdvTtmWCWvrBIMP3aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488098; c=relaxed/simple;
	bh=oFpXKqWORphhVGV6RFYdBGzlZ4nasvc+9cZbXiOZDCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZsXBYt/6+KzuN9nqZKR7o72TcnCsULjA69hH4A2LGRXEdDTkSQRS5cxIVbBks4HEeqYWW/iEdNERvJt0DkAmBNTMU7kENwPnsdXon7iACEc+rrbDe0HHLCn2LCnClo6fsKdf6Y2qMteO6ukcArlxC61+hfPkzJkrFx8dptVdYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowADHa9QTnD5q8mZsAw--.4787S2;
	Fri, 26 Jun 2026 23:34:45 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: net: phy: phy_sfp_probe: fix kref leak when phy_setup_sfp_port fails   after sfp_bus_add_upstream
Date: Fri, 26 Jun 2026 23:34:43 +0800
Message-Id: <20260626153443.52842-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHa9QTnD5q8mZsAw--.4787S2
X-Coremail-Antispam: 1UD129KBjvJXoWruFykZF1rJryxZFy3Jry5Arb_yoW8Jr1Dpw
	4DZ34SvryUJF1xt3yDAF1UtFyYvaySy3yrGrWUK39a9r15Xry7XFyktFyjqw1SkrWkZa1f
	Ar1ktayfGFW5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUKA2o+iCg3LQAAs7

sfp_bus_add_upstream unconditionally acquires a kref on the SFP bus. When
  this call succeeds but the subsequent phy_setup_sfp_port fails, the error
  path returns without releasing the upstream reference. Since probe fails,
  the device's remove function (which would normally clean this up) will
  never be called, permanently leaking the kref.

Call sfp_bus_del_upstream on the error path after a successful
  sfp_bus_add_upstream to properly release the upstream reference.

Cc: stable@vger.kernel.org
Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/phy/phy_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3370eb822017..cd62c46de017 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1723,6 +1723,11 @@ static int phy_sfp_probe(struct phy_device *phydev)
 	if (!ret && phydev->sfp_bus)
 		ret = phy_setup_sfp_port(phydev);
 
+	if (ret && phydev->sfp_bus) {
+		sfp_bus_del_upstream(phydev->sfp_bus);
+		phydev->sfp_bus = NULL;
+	}
+
 	return ret;
 }
 
-- 
2.39.5 (Apple Git-154)

