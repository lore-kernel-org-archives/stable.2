Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701735;
	b=xP16u8vmPNeIe1npWlMG0QcFTR062qIaVcIggZ1wq6U2fCTnS+QiyeVhpVLUts6a826+
	 FDoBgeQRS1bQj3fyBMXEAB1/Pf04w8bbY/3KeEPMIFEszqRDHUN0n0ZQg90PYR05mrp+z
	 tI3XfJX1YO6HyAVk+zNAENpty/vl6PzIObZBPeLSc305beMrbFz7I49VxeXWD9aOyYmOb
	 p8Pmbrl+8bO3KlKPX2pnS5aQ2svFA0MRQQ1VNHOgMzlQZMIuutc6AubOZIWAjo2tZguyZ
	 qzTKjswpC75bkoPIlqM3tQ3eqCqi+jZVM8IBOHTM5XHthINqTaXIpiu2DHEqNAarnVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701735;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=GIo5PxjdlqP/Xj3D5eFLFmZ+IhvJb/6GVNVYjGH5TxM=;
	b=oFAiAKkpqqKmMfKz+A0CP/PN6BV2oCPxqh+oFYQbsGlFB9WrIz2QkjdFDlGjx6oLpZwJ
	 ZsVGJ7cU6DcyP9amwcdPm6VvKEO4aCDEmLs88wonMT5g2Y6wMOdTG3ifpAMWonsDD+M7v
	 g8HH/odS9VVeymySRbjuxXCXflf9uRHGrOPgGhE8q8AqIp/eAMhI/Jjh3DD+vupsM92DR
	 m9Qlv2Wu3J/s1pvk0t1pbVq41BdaUJiy6CXPTaVdbT3y7FCHP7t1sa0aDxIvmupreA7cq
	 CF3qiDphJUSN/KUkJjUIbPz+ReUQIBfMp1jQfaMDRE864MvI5EXflzY8tHO9KQXLBUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4807360A5BFE;
	Tue,  3 Nov 2026 10:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4807360A5BFE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH0JFdt+lqkak7AA--.6524S2;
	Tue, 03 Nov 2026 18:28:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ieee802154: fakelb: release platform device if driver registration fails
Date: Tue,  3 Nov 2026 10:28:54 +0000
Message-Id: <20261103102854.1340581-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowADH0JFdt+lqkak7AA--.6524S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7Zr1fur1fAFWkuw4xXrb_yoW8Ar4kpa
	1UWayrCryUurW2yw4xJ3WxZFy3C3yIg3y09FyxJwnxZw4rZF17CF17Wa9xAF1kJF4kCasI
	vr4DGr15Can8ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYx
	BIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpnIByFQAAsg

fakelb_init_module() registers a platform device and then registers the
platform driver, returning the result of the latter directly. If driver
registration fails, module initialization fails and the module exit
function is never run, so the platform device is never unregistered and
leaks.

Check the result of platform_driver_register() and unregister the device
on failure. Also check the device registration result, which can be an
ERR_PTR, before using the stored pointer.

Fixes: e1e49b641387 ("drivers/ieee802154: IEEE 802.15.4 loopback driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ieee802154/fakelb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index e11d8eda85ea..35863c3aff44 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -243,12 +243,20 @@ static struct platform_driver ieee802154fake_driver = {
 
 static __init int fakelb_init_module(void)
 {
+	int rc;
+
 	ieee802154fake_dev = platform_device_register_simple(
 			     "ieee802154fakelb", -1, NULL, 0);
+	if (IS_ERR(ieee802154fake_dev))
+		return PTR_ERR(ieee802154fake_dev);
 
 	pr_warn("fakelb driver is marked as deprecated, please use mac802154_hwsim!\n");
 
-	return platform_driver_register(&ieee802154fake_driver);
+	rc = platform_driver_register(&ieee802154fake_driver);
+	if (rc)
+		platform_device_unregister(ieee802154fake_dev);
+
+	return rc;
 }
 
 static __exit void fake_remove_module(void)
-- 
2.34.1

