Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA933B636A;
	Wed, 26 Aug 2026 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733135; cv=none; b=Wq+IaSXSJEoogtuCr9bLTmbBJLQTct9L1WhPUTBTUc8dzYJXRyLkv5zcU6P1sWzAHoSNa5k0CHr/XAR+vb7IcaN4trFzPCIDbRX6aLvEqnbIiKKqIUa2dgvBc3EHoAV9F5P9NXIK5TOx8HlpbLPjhSf6FwT+nww6ZAlQHdpbB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733135; c=relaxed/simple;
	bh=WS8VIN+ctujznSJU27WbA+Pfn26My8hSuse7hxkZmzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c7bwh51IYmgv2X+BRb6mda6c4euNlY4KSr6lteb0EcGlAuhs7GuoKKPmKsH52bMRD4kcQT4hhfrquacBeWUpvlcYY07gj6X+QFCSVULA79N7h6kW4lI0L5kAe10x82m5QXl9jK5U8OyTuvINgGYYtMDlgXWtNgQsaOZAwewWoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9d9b50d2a12811f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:1fe527d4-a48a-431e-b3a5-312d20939439,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:ac3a470db1ee798009eb4f1d796c0482,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9d9b50d2a12811f19a56ed5b684f684d-20260826
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 312569427; Wed, 26 Aug 2026 16:32:04 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: adc: ade9000: fix NULL pointer dereference in clkout registration
Date: Wed, 26 Aug 2026 16:31:56 +0800
Message-Id: <20260826083156.2287106-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ade9000_setup_clkout() passes NULL as the register address when
registering a divider clock. During clock registration, the common
clock framework calls clk_divider_recalc_rate(), which dereferences
the address through readl(). As a result, probing an ADE9000 configured
as a clock provider with an external input clock crashes.

CLKOUT passes CLKIN through without changing its rate. Register it as
a 1:1 fixed-factor clock, which does not require register access.

This change does not affect the configuration using the internal clock,
for which the driver does not register a clock provider.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
Changes in v2:
- Clarify that the configuration using the internal clock is unaffected.

 drivers/iio/adc/ade9000.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index e57e24b6acdf7..4e96cc37fbedf 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1647,8 +1647,9 @@ static int ade9000_setup_clkout(struct device *dev, struct ade9000_state *st)
 		return 0;
 
 	/* CLKOUT passes through CLKIN with divider of 1 */
-	clkout_hw = devm_clk_hw_register_divider(dev, "clkout", __clk_get_name(st->clkin),
-						 CLK_SET_RATE_PARENT, NULL, 0, 1, 0, NULL);
+	clkout_hw = devm_clk_hw_register_fixed_factor(dev, "clkout",
+						      __clk_get_name(st->clkin),
+						      CLK_SET_RATE_PARENT, 1, 1);
 	if (IS_ERR(clkout_hw))
 		return dev_err_probe(dev, PTR_ERR(clkout_hw), "Failed to register clkout");
 

base-commit: 6b9f23b5460818aaf199dda90210d5fc08d66c8f
-- 
2.25.1
