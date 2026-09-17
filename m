Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DC4F55D0;
	Thu, 17 Sep 2026 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649674; cv=none; b=Vpci7a/nXXoVKYh4kCPusyKL+idyEywlPT7dcUQoHqUlyLxZrujl67LAd72ma95q8EZ+k6VEstl8uQ4W1jc8Y+iJj4K+v+gTx6ZjEMGDyfFEFFubn86p7fMv6oT9yr+Ku2Vd6urNOwgzCOo1s+QRMpz/UK0ALQdUCKsVCIBfTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649674; c=relaxed/simple;
	bh=GuAoM3hw3UpJd6BhxTDI4B/TzKy+yozEw1sz5hN3BFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y/IuURUkm+HMc2d6lIuu3xJsuOmjSTVROKLFwR28obKrpZp4qHoOm39nQs5hS/8ekCGo/yZP8RpEXJ1dClKD99BifEULA45q06OJl1v3Xx2uchoEJ4370fZBgoIWo6OVItTrfYaTTN52wq2d5IAOyupKr1/mrdLFihjKjEeSIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAnlT_54qtqWe6ACA--.3327S2;
	Thu, 17 Sep 2026 20:54:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: grant.likely@linaro.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix np reference leak in of_unittest_dynamic()
Date: Thu, 17 Sep 2026 12:54:18 +0000
Message-Id: <20260917125418.2152215-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnlT_54qtqWe6ACA--.3327S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry5WF18Ar43ZFyrKF43Awb_yoWDKFb_ZF
	95Zr93JrW0kF4vgrWfXrn5ZF9Fya4UuF1kZF1vywnIk343Ar15ZF1Y9r95A3y5Zw4ava4a
	yw4kCr10krsF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqkYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07jn
	gAwUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgkNA2qrq3avRgAAs0

The node obtained with of_find_node_by_path() is never released, both
on the early return after a failed allocation and on the normal return
path. Add the missing of_node_put() calls.

Fixes: 7e66c5c74f73 ("of/selftest: Add self tests for manipulation of properties")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 5c90be158dd5..316f082c430d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -200,6 +200,7 @@ static void __init of_unittest_dynamic(void)
 	prop = kzalloc_objs(*prop, 4);
 	if (!prop) {
 		unittest(0, "kzalloc() failed\n");
+		of_node_put(np);
 		return;
 	}
 
@@ -244,6 +245,8 @@ static void __init of_unittest_dynamic(void)
 	if (prop->value)
 		unittest(of_add_property(np, prop) == 0,
 			 "Adding a large property should have passed\n");
+
+	of_node_put(np);
 }
 
 static int __init of_unittest_check_node_linkage(struct device_node *np)
-- 
2.34.1

