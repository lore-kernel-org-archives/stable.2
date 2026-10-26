Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028793;
	b=qHneg83LzG+fjKFmdiizWmJNM8VzwJtdDSw4j9/X3du/cscUlhZdhr+aYZRSSn9frekq
	 LLdYYE8zDv331R6FJfaSv8+IZQ7AQgm4rjzrLihYPYTtkMr096L22ja548b+exdnZZNgt
	 lgdoSD5ZDv2DHKiUvXB5NadPS9cTwXp0NPniXf94l52MkSAT0MU0cqEKUbXkShPsXzzk/
	 xzugwLmoGcNJkqTk0nPqP6bfBk9rwpST+a3QHnefXzxjyghKlRM9mKYlLSITBEHetnr/5
	 /K1OmbwdAG0tJ12MGaviafueFAnXumRaLqpMKxZbk0/S/iY0UAVsebMtZgT6VHIe/LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028793;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jvfFLqSO+wzSndJgmfiuqCD6B3AH19K/ayR8BSeHqBM=;
	b=g3ZgRrjbi6VGrIniV/cyCM0l4sDRrPEsWlPC4zJAJZdjt4D5SQOmNsr/NTSILktaIQET
	 2o4DmEtceUrhNoSaP2Ev5CoADdzEZmA/tA5KEQTlGabM0mCOq0YDz77Ze3+HOpTZ3Y+AD
	 2O4uaDoV/rTSFSs1qw6QfvAfWSQqKArWMelyJwA7ErWFae1u5o/zE0SaOCQEpqJ5Fbtqp
	 AAqpFSkvN0SGjMS+R1ea9k3N3uk0yd1cf+wteixe2ZstB8saUhXt/2jPUjImBlOcc3oEz
	 CO8gkFpJwUWDtL7VLJPoDn6kck2nWvXusI5iesy+5Fecf7MdgiKZA6+izKqiCq0INCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=G4i0+fgH;
	arc=none smtp.remote-ip=115.124.28.196
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C0D606A326;
	Mon, 26 Oct 2026 15:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C0D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=G4i0+fgH
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793028777; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jvfFLqSO+wzSndJgmfiuqCD6B3AH19K/ayR8BSeHqBM=;
	b=G4i0+fgH0xjqaaaZsWtEisHl2IRXJ3Z49kMVlojbJkEP5NagB9RscO96++C/FMB2xTPGU0yfWGLkEjI6diP2KQgmFJWvv+5jdGHWt8CvLf9Cc/TGs+FrhoTyTkWT+eF5FVa5bQAxJm6/bLeScoPwk50cvQK4Y9F0/0zjdn7YydM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436679|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00946935-0.000441268-0.990089;FP=9323360888359619762|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045166233;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jq7I2n2_1793028775;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jq7I2n2_1793028775 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 23:32:56 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Weibin Liu <liuwb@xiaopeng.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	mfd@lists.linux.dev,
	Guanglei Zhu <zhugl3@xiaopeng.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 2/2] spi: sprd-adi: enforce the exact transfer length
Date: Mon, 26 Oct 2026 23:32:53 +0800
Message-ID: <20261026153253.689525-3-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026153253.689525-1-liuwb@xiaopeng.com>
References: <20261026153253.689525-1-liuwb@xiaopeng.com>
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
buffers. If the controller is exposed through spidev, a userspace
client can submit invalid transfers in a tight loop, so use
dev_err_ratelimited() for the driver's rejection messages.

The only in-tree user, the SC27xx PMIC driver, is updated by the
previous patch to advertise the byte length of an ADI register
access.

Tested in QEMU (aarch64 virt) against Linux 7.3-rc7, with the
controller node added to the guest device tree. QEMU has no model
of this hardware (the MMIO window is backed by RAM), so this only
exercises the software path. Transfers submitted through spidev
confirm the new checks: a 4-byte read and an 8-byte write are
accepted, every other length from 1 to 16 is rejected with
-EINVAL. A burst of 32 invalid reads and 32 invalid writes emits
only 10 messages at each new driver call site. The SC27xx driver's
transfers pass once it advertises the byte length. No Spreadtrum
hardware was available.

Fixes: 7e2903cb91df ("spi: Add ADI driver for Spreadtrum platform")
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
Changes in v3:
- Rate-limit invalid-length errors as suggested by Sashiko's review.

 drivers/spi/spi-sprd-adi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index a6baaf02b3c8..32e445cea0d3 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -339,10 +339,24 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	int ret;
 
 	if (t->rx_buf) {
+		/* ADI reads consume exactly one u32: reg in, value out. */
+		if (t->len != sizeof(u32)) {
+			dev_err_ratelimited(sadi->dev,
+					    "invalid read length %u\n",
+					    t->len);
+			return -EINVAL;
+		}
 		reg = *(u32 *)t->rx_buf;
 		ret = sprd_adi_read(sadi, reg, &val);
 		*(u32 *)t->rx_buf = val;
 	} else if (t->tx_buf) {
+		/* ADI writes consume exactly two u32: reg and value. */
+		if (t->len != 2 * sizeof(u32)) {
+			dev_err_ratelimited(sadi->dev,
+					    "invalid write length %u\n",
+					    t->len);
+			return -EINVAL;
+		}
 		u32 *p = (u32 *)t->tx_buf;
 		reg = *p++;
 		val = *p;
-- 
2.50.1

