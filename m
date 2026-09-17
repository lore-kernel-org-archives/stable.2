Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA33D6477;
	Thu, 17 Sep 2026 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642124; cv=none; b=rzfHC28A8r/S7srXELQMHCwaI/aWivpxTBvSdud14vAypng4lRih7kHmYgFzMBIo7+dgBziZhTRzeFNipnGLTjAVEz/pG7ooV1M3qvLUsTrD/+8tA62YvSJFdLnsdWL1gi8T2gFxyyYowKr8euo3fv4K2oW6x3rm8YPyrl4NEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642124; c=relaxed/simple;
	bh=7MXza5O6ov92oIddG7OzGuj/M2Ntg/TIs8+HVddBfwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sW700EfClbRRVmPz6idxnNpS4VoWcPaoKJBPn63E6DJ3oQGmvn3HGy/CLtUhAMqdMirt20dfqOUSMqqraUKSG/sJwzBK9Hu3sGVE1LdxstLb/8G8R0N6rrSlTIesBkXOqw1a95kIXG2DhdqAxHkWcbseGBKW5Y27QG+gQCgyQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3J0Jdxatq0+5+CA--.41997S2;
	Thu, 17 Sep 2026 18:47:57 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: UNGLinuxDriver@microchip.com
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	olteanv@gmail.com,
	pabeni@redhat.com,
	woojung.huh@microchip.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: microchip: Fix parent_mdio_bus reference leak in ksz_mdio_register()
Date: Thu, 17 Sep 2026 10:47:57 +0000
Message-Id: <20260917104757.2147497-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3J0Jdxatq0+5+CA--.41997S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4fJw15tF1ktw13JrW3Awb_yoWkurb_Cr
	yfZry7ur48JF1Skw42y3W3Zr95KF9rWFy8urs29a93X3y8JrsrZFyY9F1rJr1IkFyjqFnx
	G3yq9r10v3429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgxYjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07jbHUDUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMNA2qrq01cVwAAs4

of_mdio_find_bus() returns a mii_bus whose embedded struct device has
its reference count incremented. When ksz_mdio_register() fails after
the parent bus has been stored in dev->parent_mdio_bus, that reference
is never dropped, so the parent MDIO bus device leaks on every probe
failure.

Drop the reference before returning from the error path.

Fixes: 9afaf0eec2ab ("net: dsa: microchip: Refactor MDIO handling for side MDIO access")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/dsa/microchip/ksz_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 144373e13bea..fcf3a29ffca3 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2807,6 +2807,11 @@ static int ksz_mdio_register(struct ksz_device *dev)
 	}
 
 put_mdio_node:
+	if (ret && dev->parent_mdio_bus) {
+		put_device(&dev->parent_mdio_bus->dev);
+		dev->parent_mdio_bus = NULL;
+	}
+
 	of_node_put(mdio_np);
 	of_node_put(parent_bus_node);
 
-- 
2.34.1

