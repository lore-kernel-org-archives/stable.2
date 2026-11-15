Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794759538;
	b=qvGKCRgKVObZz8S1WF3EhnkiQC9Z5Q7G5o9kVYu53qQ/pFUJ0I5rJr0F6DQ5bkk2MYp9
	 jjKHep8v9tcRNx4Ri7hmI8ZBvZ2xqEzQFfiUqeKe3H8g3YlmliMMf+x1Z4QH9X5nM84Cv
	 QrWXx2/gPyiAEgO4a/pw8TNkGEE7AwLvTRfvAEv3JfYtbeCm3GK/BlyqygQmwNJAh6oph
	 tFpzwROOZbrYj7t698/ZKMHu7U/e5JP+Q2LCpJQ/yNa5bgRkysnvXdG/hTWx5bIx27a6d
	 tIXwwtbsx31/gAXQrqdbiTrKDbujmdcmPTZdtSYoxt9hTio8oo/AUICJ6ry8g4MPTzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794759538;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=athqCRNXBpJsz/nO60393V52uhwNOUb0I8/+4v6C44E=;
	b=XVuYeL2G3DCLORPR1+Rc3DkLhSz5J5w9j/8QJu6dpi5MlMlaoRPfTJBkeRkCwL0k0NRu
	 XsBTAvKZVi8m5OxbVmF0DsXVmGtcFg1HPsVwXUNF6tccpMC09m7Y+mytD8PFjWCci4K1g
	 5ashNXJXv/nh2wAhPZaOtvYY/KPREZjTZYurnWVrkDVkAN0yxoOSPMN1eiCDR80JPg3HC
	 T2KLoFoPTPMZlqU8QM46bXAIMto0aWU/CxMddCvZZEzvlgilMucYFdBFAsjwfPVCTIgvL
	 9XXNRiZqeFc9x0vnFgiRtbO2FufQyKWKbtq6RkuVrht7bbjC88mkEvSluuR675Ac+WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DpZqWbBF;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52982606A31A;
	Sun, 15 Nov 2026 16:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52982606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DpZqWbBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=at
	hqCRNXBpJsz/nO60393V52uhwNOUb0I8/+4v6C44E=; b=DpZqWbBFEDPci7+fqA
	imqtVQfI7vNCvgrEZ2/WzuBNwyZg0DCSTx16i1v1HmJXtLKFvTtji065m5OO6Ih0
	xf82iqbmfFtYWK8T7muS/TCd0cPFf3c8+OlASUA2EexA4NeYOBjEJDrTMhQKZJJl
	Cme9LhZ3xG9y9Xkb7Q8rWgHiU=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCHZBBD2_lq2QIgHw--.38434S2;
	Mon, 16 Nov 2026 00:18:12 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: phy: reject non-PHY mdio devices in phy_connect()
Date: Mon, 16 Nov 2026 00:18:11 +0800
Message-ID: <20261115161811.941022-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHZBBD2_lq2QIgHw--.38434S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurWrJw1fGF17XFyUAr43Jrb_yoW5XrykpF
	WDtFy3GrW8Kw1xWw4kZF4UCry5Cr4vkayFgF45ursIgwn8XryYyFZakFy5Gw15JrWkAa4j
	vFZrJF93CFWkJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jKyIUUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7QQhcWr520QxGwAA3f

phy_connect() resolves the PHY by name using bus_find_device_by_name()
and then casts the result to struct phy_device without verifying that
it actually is one.

Every mdio device is registered with the same name format (PHY_ID_FMT,
bus id and address), whether it is a struct phy_device or a bare
struct mdio_device. A DT node under an MDIO bus with a compatible
string that is not an ethernet-phy-* string is registered as a bare
mdio_device, which is the normal way to describe switches and PCS
devices on the same bus.

If such a device sits at the address a MAC driver passes to
phy_connect(), the name lookup succeeds and to_phy_device() derives a
struct phy_device pointer from a smaller struct mdio_device. Accessing
any field past the embedded mdio_device then reads out of bounds.

With a test module that registers a bare mdio_device and calls
phy_connect() on its bus id (QEMU, KASAN, v7.3.1):

  BUG: KASAN: slab-out-of-bounds in phy_connect+0x196/0x200 [libphy]
  Read of size 4 at addr ffff88801b270f2c by task insmod/162
  Call Trace:
   phy_connect+0x196/0x200 [libphy]

The same problem was fixed for of_phy_find_device() in commit
6ed742363b9c ("of: of_mdio: Ensure mdio device is a PHY"), and
fwnode_phy_find_device() in this file performs the check as well.
phy_connect() was left without it. Check MDIO_DEVICE_FLAG_PHY before
calling to_phy_device() and return -ENODEV for a non-PHY device.

Found by LLM-assisted source review. Reproduced only with the synthetic
test module above; no board is known to hit this. The fix was build
tested only; it was not run against the test module, selftests or
hardware.

Fixes: a9049e0c513c ("mdio: Add support for mdio drivers.")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/net/phy/phy_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b39e945ce..4f8f9cbc3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1184,6 +1184,11 @@ struct phy_device *phy_connect(struct net_device *dev, const char *bus_id,
 		pr_err("PHY %s not found\n", bus_id);
 		return ERR_PTR(-ENODEV);
 	}
+	if (!(to_mdio_device(d)->flags & MDIO_DEVICE_FLAG_PHY)) {
+		pr_err("MDIO device %s is not a PHY\n", bus_id);
+		put_device(d);
+		return ERR_PTR(-ENODEV);
+	}
 	phydev = to_phy_device(d);
 
 	rc = phy_connect_direct(dev, phydev, handler, interface);

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

