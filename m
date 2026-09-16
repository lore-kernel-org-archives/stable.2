Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA924A4996;
	Wed, 16 Sep 2026 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551611; cv=none; b=WB+iPQySUoZlVkWK1doAgn6jCiT5Ii4F+3RF2l29YaxcIFv8TVxdi1SI7BJSQyoGsCRftw2QQO2chc1LrhWhW59+c9rrdw2xdcuSz6WQw+LmMH7hKYVFPBp2t1UIbZ0qQsOmjssChgubG5LEEjJN3uSQ6r8OMJ/ezKpUeSL0CAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551611; c=relaxed/simple;
	bh=hLbmi6WvFh3bqyxpo2IrHGcGtF3z9mONMEoVjFdFFx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RnBzzWHZoJnuy2PIlWBWg6W0QUrGtPNH/C6NS/4WJnvJ5ArN9s3HIG9SRPw4+MIMhyFSp1dYzzdr/nMhJw/tErzc4MikY4oI6zA8FepMlkb7n4ShNVinI1vHlEmsG9MBNPZRt1idvKEDPNrmVUy2us6yj54FKLaRbgMwdA9WtvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wkDeY6pqGorgBw--.1498S2;
	Wed, 16 Sep 2026 17:39:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alistair@popple.id.au
Cc: andrew@codeconstruct.com.au,
	eajames@linux.ibm.com,
	gregkh@linuxfoundation.org,
	joel@jms.id.au,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	ninad@linux.ibm.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: master-aspeed: Fix of_node reference leak in fsi_master_aspeed_probe()
Date: Wed, 16 Sep 2026 09:39:14 +0000
Message-Id: <20260916093914.2005582-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wkDeY6pqGorgBw--.1498S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4ruw15Ww4UKw45Xr1kKrg_yoWkGwcE93
	W8uF93JFWUCFWkJws0yanIvw4qkF9rWFyxKrZ7ta1Sg34UZrZ8JFW5Xrs3Ca17WrWxJFWD
	Ar1DKw4rGrW3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUJWrAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMMA2qqPpSecAAAsO

In fsi_master_aspeed_probe(), a reference to the device tree node is
taken with of_node_get() and stored in master.dev.of_node.  If
fsi_master_register() fails, the error path frees the master without
putting that reference, leaking it.

Put the device node reference before returning on the error path.
of_node_put() tolerates a NULL node, so the earlier err_release path
via opb_readl() is unaffected.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/fsi/fsi-master-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff33..7c7f30c2b8e6 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -640,6 +640,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	return 0;
 
 err_release:
+	of_node_put(aspeed->master.dev.of_node);
 	clk_disable_unprepare(aspeed->clk);
 err_free_aspeed:
 	kfree(aspeed);
-- 
2.34.1

