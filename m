Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86C52123A;
	Thu, 15 Oct 2026 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067992; cv=none; b=q78LiIHEojEZqxSk6kS1hkJYJTJKM1xxVOMSIE+iNFUDpYjrY3rrvJFJHDit5NT4i1T/DMPH/J4QXlosI5nBoriMRQg0Y1gdPUeVpwcCF6us7EPh+/a8u+l28ukIEzTJTWtnZ03NnStK9UYmn+nMyU5M0XZHZYklACzroMQ2Fdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067992; c=relaxed/simple;
	bh=9jj5EeXLlOxjRdR+zAV5hvpMxKYNVjJAb16VRuznqDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTks5GQGeHiqwa+iM1Ojoj9t1gkmlnrd9r36YLEMZ+hGDSWb58n1n5077iY8Ht+VDJVTHlKMFn43L/W4z95kXt2EmR9TYtviKI6w4+yWU5efYqB5nizZS9ThiXcxvmQP/BIkHjVkaF1TXyyc5yID1qS7Jlgr/pEIUad0YnRdg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=W0Nchy26; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="W0Nchy26"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792067986; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=KsrSEPU4ZtBt1Ym2oMGlk7H+9jwpiIHOpORSTl0EMCA=;
	b=W0Nchy26o55p/8o5sEEE2EZ62CT3H0c4hoVYZEG8vnErMoxTDvLu0bFgww4uLN9UYsnQ6UJ9I+MwZSA7OJ7sa0QoYQ0FKA+jZAC+jJTRfy/KIDwPnlAvhhfLxqlUGV/KfJRh+kvR1Sluf89uaAoTADIlz7j/45fmBt6lYNs88KI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07440349|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00470219-0.000751167-0.994547;FP=9971602157767101618|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jem-UFs_1792067985;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jem-UFs_1792067985 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 20:39:46 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Thu, 15 Oct 2026 20:33:13 +0800
Subject: [PATCH v2 2/2] spi: sprd-adi: enforce the exact transfer length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-spi-sprd-adi-exactlen-v2-2-13203b6aef7e@xiaopeng.com>
References: <20261014-spi-sprd-adi-minlen-v1-1-77fee7e64259@xiaopeng.com>
 <5e662ac5-efea-46dc-bd09-88a5a4841851@sirena.org.uk>
 <20261015-spi-sprd-adi-exactlen-v2-0-13203b6aef7e@xiaopeng.com>
In-Reply-To: <20261015-spi-sprd-adi-exactlen-v2-0-13203b6aef7e@xiaopeng.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>,
 Lee Jones <lee@kernel.org>
Cc: Weibin Liu <liuwb@xiaopeng.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-spi@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>, mfd@lists.linux.dev,
 Guanglei Zhu <zhugl3@xiaopeng.com>
X-Mailer: b4 0.14.3

sprd_adi_transfer_one() never looks at the transfer length: the
read path dereferences t->rx_buf as one u32 and stores the result
back, and the write path reads two consecutive u32 values from
t->tx_buf. A transfer whose length does not exactly match what the
controller touches is a bug in the caller: a short transfer reads
or writes past the end of the buffer, and a long transfer is
silently truncated.

The SPI core does not enforce the expected length, so reject reads
whose length is not exactly sizeof(u32) and writes whose length is
not exactly 2 * sizeof(u32) with -EINVAL before touching the
buffers.

The only in-tree user, the SC27xx PMIC driver, is updated by the
previous patch to advertise the byte length of an ADI register
access.

Tested in QEMU (aarch64 virt) against Linux 7.3-rc7, with the
controller node added to the guest device tree. QEMU has no model
of this hardware (the MMIO window is backed by RAM), so this only
exercises the software path. Transfers submitted through spidev
confirm the new checks: a 4-byte read and an 8-byte write are
accepted, every other length from 1 to 16 is rejected with
-EINVAL, and the SC27xx driver's transfers pass once it
advertises the byte length. No Spreadtrum hardware was available.

Fixes: 7e2903cb91df ("spi: Add ADI driver for Spreadtrum platform")
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/spi/spi-sprd-adi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index a6baaf02b3c8..ecec1da3ca7a 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -339,10 +339,20 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	int ret;
 
 	if (t->rx_buf) {
+		/* ADI reads consume exactly one u32: reg in, value out. */
+		if (t->len != sizeof(u32)) {
+			dev_err(sadi->dev, "invalid read length %u\n", t->len);
+			return -EINVAL;
+		}
 		reg = *(u32 *)t->rx_buf;
 		ret = sprd_adi_read(sadi, reg, &val);
 		*(u32 *)t->rx_buf = val;
 	} else if (t->tx_buf) {
+		/* ADI writes consume exactly two u32: reg and value. */
+		if (t->len != 2 * sizeof(u32)) {
+			dev_err(sadi->dev, "invalid write length %u\n", t->len);
+			return -EINVAL;
+		}
 		u32 *p = (u32 *)t->tx_buf;
 		reg = *p++;
 		val = *p;

-- 
2.50.1

