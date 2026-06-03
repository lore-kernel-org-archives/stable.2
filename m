Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD137C935;
	Wed,  3 Jun 2026 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482283; cv=none; b=BjDncqAL0n8Mc3+G1yBkezrKJ/MYZDsE6q9mPcvUvAbm5muTIZVdr7ZtekV+SUS+xS4ygN7DpX0DFyboSm1F/z+8vfFnWnT27LilrzdHUu2rIcyb4XsFfx8eoVldgRh1RyWl3TNSIBmIYkGasc06acAibZig5AuQZgVDYbUSeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482283; c=relaxed/simple;
	bh=+EE96W82oQIcWh5oXiEk6Dy3DfIkD8o6e34IAYeod+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VAWB0GAnL54zhhDML/1PKDe62lGVI7BlmZilmLsv/MTzDVIw4yQma0cwoiPXE8TxPcABWsoFZDcO8vsgbbuxZu3D7mpzeGlTax3xXFEkMNLF4CBcLbH4QxDlRubZd8aFAQ//4yDce2OoaFFkZFIVSzuXWUvsXtp30LHJsMYHl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACnStPeACBqTc+DAA--.1083S2;
	Wed, 03 Jun 2026 18:24:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ata: ahci_brcm: fix reset refcount leak in brcm_ahci_resume()
Date: Wed,  3 Jun 2026 10:24:20 +0000
Message-Id: <20260603102420.3735032-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnStPeACBqTc+DAA--.1083S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr15GFWfuw1fKrWUur4rZrb_yoW8Xr4rpr
	4xJr9ayry8WF40ga17Cr1Iva4S9F4qqFyxKFyDKws2v390q3s5XF42yayvgFyDKw18Gw43
	Zr1qvF18ZF43ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5ku4UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0HA2of-Y4NjgAAsK

When brcm_ahci_resume() succeeds with reset_control_reset(), any
subsequent failure in ahci_platform_enable_clks(),
ahci_platform_enable_regulators(), ahci_platform_enable_phys(),
or ahci_platform_resume_host() leaves the shared reset line's
triggered_count incremented by one. On the next attempt to reset
the hardware, atomic_inc_return() sees a count greater than one
and the reset is silently skipped, potentially causing data
corruption or device malfunction.

Add a reset_control_rearm() call in the common error path after
brcm_sata_phys_disable() and ahci_platform_disable_regulators()
to properly balance the triggered_count, matching what the probe
error path already does.

Fixes: c0cdf2ac4b5b ("ata: ahci_brcm: Fix AHCI resources management")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/ata/ahci_brcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 29be74fedcf0..38c63d73d210 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -415,6 +415,7 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 out_disable_phys:
 	brcm_sata_phys_disable(priv);
 	ahci_platform_disable_regulators(hpriv);
+	reset_control_rearm(priv->rcdev_rescal);
 out_disable_clks:
 	ahci_platform_disable_clks(hpriv);
 	return ret;
-- 
2.34.1

