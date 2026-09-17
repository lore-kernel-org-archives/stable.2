Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66625489892;
	Thu, 17 Sep 2026 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642366; cv=none; b=bSiZk+tDtEpozBek3WntN6NuiKFdvHmczxoHNrh81J6N4ArDXRXreLnwhmbPgdNcu2gfp8k2a7Vy02t55UKglAaeFnp4Njb9KHR00bVI3CIqxEQTMp8jkVVk6GM2c5x/KsHVRMddgD+faFUa+41MgEbBoQ5Vom/mGSwrFDgvqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642366; c=relaxed/simple;
	bh=sgkq/w+75NRnuNkHiMS3OCUahF56aur0WpiUpldJWf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XWIAGsBC+BBueMfEEXDzhp/80c6yJ32fNDEQpTBk9X+Xl1PFViNv08WgfcZ8HrMNbYvt/Ah+6B+WoC1jNTwHuWgk2B7i/9R9EB4IHVlRmOYd5HJIhWYx+GNSjeHTZk56ZkOzlc6XosuuPSbflnYv8ZJcJN889VYiGeX8cHkKsZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnVD9mxqtqwgB_CA--.1105S2;
	Thu, 17 Sep 2026 18:52:23 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: conor.dooley@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	theo.lebrun@bootlin.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: macb: Fix mdio_np reference leak in macb_mii_init()
Date: Thu, 17 Sep 2026 10:52:23 +0000
Message-Id: <20260917105223.2147724-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD9mxqtqwgB_CA--.1105S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw1DKw1xtr18Aw4kZr1fJFb_yoWDuFc_Gr
	n7WF1fWF4DGFnFkw40yr4j93sayF1DX393uFs7tay5Cay3Ar18Ary5Cr9xJw18WF4xC3Zr
	Gr17Aa4j9w12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgkYjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxU7WE_DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRINA2qrq01dFQACs4

of_get_child_by_name() returns a device node with an elevated reference
count. macb_mii_init() drops it on the error paths via err_out, but the
success path returns 0 without calling of_node_put(), leaking a
reference to the "mdio" child node on every successful probe.

Release the reference before returning on the success path.

Fixes: 8a6631f1cece ("net: macb: avoid redundant lookup for "mdio" child node in MDIO setup")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a12aa21244e8..0c4775d51263 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1164,6 +1164,8 @@ static int macb_mii_init(struct macb *bp)
 	if (err)
 		goto err_out_unregister_bus;
 
+	of_node_put(mdio_np);
+
 	return 0;
 
 err_out_unregister_bus:
-- 
2.34.1

