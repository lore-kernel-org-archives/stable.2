Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0711379C4A;
	Tue,  9 Jun 2026 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991081; cv=none; b=j5lXXRe0Kn2E1eeEkAyxlWgzJAYimDqx2OLz3n0T4hCumB1YLsiRAO5nXfRFLizfEjPXXF6oYIhwSb68SG+Y2Te665SIi1sP93r9DJiB46ifwb0n0iDMhU3NaA/kTHtHsCzAXzoU6L2kwxMYQ6BWv9TyRU7CfzPD4j0UEAPA5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991081; c=relaxed/simple;
	bh=dT6vDmKRz6NxY7iVclWzsJDfP8e8gOjNEpBh+mHBxt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MHM9xz1b/8PWfB23qZlgxuuL64ppnkt8s7wFmc80EG/6GEYVaS5i+pXug2QUGfhDJwMv35nCR5lJHsIK/FXBSezg3eAytaYJzYiH3rzKnBruS3f7n7YPTdEXIpR91asOIZRVH5mdaaRWGfrsdxUiIR/FjPz55j8GXsJvClJ0DfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAntQhTxCdqr5nNEg--.12509S2;
	Tue, 09 Jun 2026 15:44:19 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: bgmac: fix refcount leak in bgmac_phy_connect_direct()
Date: Tue,  9 Jun 2026 07:44:11 +0000
Message-Id: <20260609074411.205176-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAntQhTxCdqr5nNEg--.12509S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4ktFWrWrWfWF43Kw1kAFb_yoWDuwcEgF
	n5Xw1xWw45GFZIkw47Ar47Z3sa9F1qk34kuF42qrWfKw1DWr17C397uFyrAryDG3y8Zr98
	WrnF9ayxC34IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU7TmhDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkNA2onpjNyLgABsF

In bgmac_phy_connect_direct(), fixed_phy_register() returns a
phy_device with an incremented refcount. If the subsequent
phy_connect_direct() call fails, the function returns the error
without releasing the phy_device reference. Add the missing
fixed_phy_unregister() in the error path to prevent the leak.

Cc: stable@vger.kernel.org
Fixes: c25b23b8a387 ("bgmac: register fixed PHY for ARM BCM470X / BCM5301X chipsets")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/broadcom/bgmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 3e9c57196a39..c97cf7ebad7f 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1456,6 +1456,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
 				 PHY_INTERFACE_MODE_MII);
 	if (err) {
 		dev_err(bgmac->dev, "Connecting PHY failed\n");
+		fixed_phy_unregister(phy_dev);
 		return err;
 	}
 
-- 
2.34.1

