Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A04363C46;
	Fri, 26 Jun 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486199; cv=none; b=K04D/MoWRvrNNmFbg97S+kuB1aRNj9/lj68Cx8FQKHRPNT8utHxcOizerncMWsc7d9u5cPVhDpMjjo9rpLVGwF0d3/Emw2EOB4cUlo34h8bV2QmYxyrGeexXLqoZ9tdjGUiwzT+mJdzlJTsMM1hjfwnLpMzvSYRL9bmc1VX2Svc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486199; c=relaxed/simple;
	bh=O1G+q5mXYegd2BUhunPhLkRmzlP6u63R2SRS/JAOJjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QY1YgXGy2sVEK2VThz/OosYhw3843efLqx28iCzFD3r+zduWQEUGBxbDQhJiwn5LJPoYz30cA9z0qY9Tks/l/NcgU7R1mElS6WVF1QI5pB76l7l73L++0X7uZaFXrihur3adufB+P5XIf8zok8oyok/kIL7gl5steDiIoeHEPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowACXOtOulD5qHVdrAw--.53907S2;
	Fri, 26 Jun 2026 23:03:11 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@lysator.liu.se>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: i2c: i2c_mux_add_adapter: fix child device_node reference leak on   adapter registration failure
Date: Fri, 26 Jun 2026 23:03:10 +0800
Message-Id: <20260626150310.49875-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXOtOulD5qHVdrAw--.53907S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur1rArW5XFy3Aw47uw13CFg_yoWDAwc_CF
	yrX3srWrn8Krs8urZrXFWfuwnakF1kuFZ3Aan7KFW3Aas7XFsrCFWfXrs3Cw45Jw4kKa4D
	Xw4kWr1xuw17tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj2YLD
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUKA2o+iCgj+QAAs7

When the OF block successfully acquires a child device_node reference and
  stores it in priv->adap.dev.of_node, but the subsequent
  i2c_add_numbered_adapter or i2c_add_adapter call fails, the error path
  jumps to err_free_priv which only kfree's the priv without calling
  of_node_put on the stored child node, leaking the reference.

Add of_node_put(priv->adap.dev.of_node) in the err_free_priv error path.

Cc: stable@vger.kernel.org
Fixes: a7ab72390b77 ("i2c: mux: add common data for every i2c-mux instance")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/i2c/i2c-mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c239b..68a4c34b5987 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -408,6 +408,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	return 0;
 
 err_free_priv:
+	of_node_put(priv->adap.dev.of_node);
 	kfree(priv);
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)

