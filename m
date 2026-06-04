Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432E3612EC;
	Thu,  4 Jun 2026 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541504; cv=none; b=HYFlykzL3n/jTqRu607EZlY6EqJsR7SoMr8X4sedlwdMMG0YgT+SlSsViFHmSuBSV59yxsBvWiovwoDEaVb8FPT+89U3Ye6JlGkyaFOvrkcHKcoqHBrCmfvUHBfac597eTAAooIhKR59AZNOcAvNUIQToetszFOklpdM1wu5w0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541504; c=relaxed/simple;
	bh=ZqBFLVCzUj35LkWVljXk0PQiG1S8CW8BkK8WXxH4as4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jw45kGFOcSc6hWPOqgaJQPyaqsEENdxC+/7/wcpb3Cv/Jhoq88ygC7XkZA42BLd/5GO0VCVt0PWjkqQ6Xm7OxrrbvGkzkvnGOwId5CKiEaCFkLZDafR2je0Q5gYdKxc3Ibgl/kTCPbTbgke1Jnhro+KyOcDknzUQtHsBSYRJEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACHKtMv6CBq7TqRAA--.9439S2;
	Thu, 04 Jun 2026 10:51:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: bmasney@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clk: mvebu: ap-cpu: fix missing clk_put() in ap_cpu_clock_probe()
Date: Thu,  4 Jun 2026 02:51:15 +0000
Message-Id: <20260604025115.3763823-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHKtMv6CBq7TqRAA--.9439S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rGw1DXry7XFWUAr1fZwb_yoW8Jw4fpr
	1UGFZYkr4UXr4UJay7Gan7Wa4rua1kXFW5Ca1vya4v93Z3JFy5Gr18A3yvqF18urW8W3y5
	tF4UJan8uF1DuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUrrWFUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0IA2ogubGxKQAAsa

The function ap_cpu_clock_probe() calls of_clk_get() to obtain a
reference to the parent clock for each CPU cluster, but it never
releases it with clk_put().  The returned clk is used only to read
the parent's name via __clk_get_name(), and the reference is leaked
on every successful cluster initialization as well as on the error
path when devm_clk_hw_register() fails.

Add the missing clk_put() after the name has been extracted and
before returning on error to fix the leak.

Fixes: af9617b419f7 ("clk: mvebu: ap-cpu-clk: Fix a memory leak in error handling paths")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clk/mvebu/ap-cpu-clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
index 1e44ace7d951..a8175908e353 100644
--- a/drivers/clk/mvebu/ap-cpu-clk.c
+++ b/drivers/clk/mvebu/ap-cpu-clk.c
@@ -328,9 +328,11 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 		ret = devm_clk_hw_register(dev, &ap_cpu_clk[cluster_index].hw);
 		if (ret) {
 			of_node_put(dn);
+			clk_put(parent);
 			return ret;
 		}
 		ap_cpu_data->hws[cluster_index] = &ap_cpu_clk[cluster_index].hw;
+		clk_put(parent);
 	}
 
 	ap_cpu_data->num = cluster_index + 1;
-- 
2.34.1

