Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F14E1C94;
	Thu, 17 Sep 2026 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650298; cv=none; b=YGZEPA4UxEgYfuf2Rw3yjcC5dniRBVz5C9cEA9qGyNmqt2VbU3ZzEpx+NTufYXniZyTdHucMz63hdU8ryeH+Bl2Mhq5odJWTtnPmzhuvwj2Qvs7ucfA0fuR3XUIO0SSjWil162yp2vOJNLUZlH7GkGTTvULvr+25z2YcBOSkkeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650298; c=relaxed/simple;
	bh=64Ylne07jTj2VXNOWf8yEG8Gw+xMkVMd8q+OECBl1HM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OoT1ly2mpno16QeN9HiRT/jficJOTk13JPo9Kzh8cPQ0udqGML/eeohqKKsSUFQ3GrU4tXp1Nqu3UmlJH3bFYX6JEDZNHn3DwWQBHyr5j+bl0Qrx1qNJlz8VRn98tKYETC22KGNg8IEABEtVF9Y2+xuZoFeYWdVFxpDXvrMxJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACHuEJt5atqwRSBCA--.3396S2;
	Thu, 17 Sep 2026 21:04:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: grant.likely@linaro.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix np reference leaks in of_unittest_platform_populate()
Date: Thu, 17 Sep 2026 13:04:45 +0000
Message-Id: <20260917130445.2152694-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHuEJt5atqwRSBCA--.3396S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1kAF4kWw1fXF1Uuw43GFg_yoW8WFy8pr
	W7GFWavrn8Ga17taykuryUuFyIyanI9rWrGryUK34kuan7A3W7AFy2gay0gFn3XrW8Wa98
	A3W7trWDG3srt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07UM
	q2NUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAANA2qrrJquywABsR

np holds a reference obtained from of_find_node_by_path() but is
reassigned several times without a matching of_node_put(). Drop the
reference before each reassignment so it is not leaked on any path
through the function.

Fixes: 82c0f5897a87 ("of: selftest: add deferred probe interrupt test")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 6bc5babddf0a..4a8af9b992c4 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1934,6 +1934,7 @@ static void __init of_unittest_platform_populate(void)
 
 	np = of_find_node_by_path("/testcase-data");
 	of_platform_default_populate(np, NULL, NULL);
+	of_node_put(np);
 
 	/* Test that a missing irq domain returns -EPROBE_DEFER */
 	np = of_find_node_by_path("/testcase-data/testcase-device1");
@@ -1944,6 +1945,7 @@ static void __init of_unittest_platform_populate(void)
 		irq = platform_get_irq(pdev, 0);
 		unittest(irq == -EPROBE_DEFER,
 			 "device deferred probe failed - %d\n", irq);
+		of_node_put(np);
 
 		/* Test that a parsing failure does not return -EPROBE_DEFER */
 		np = of_find_node_by_path("/testcase-data/testcase-device2");
@@ -1961,6 +1963,7 @@ static void __init of_unittest_platform_populate(void)
 		unittest(irq < 0 && irq != -EPROBE_DEFER,
 			 "device parsing error failed - %d\n", irq);
 	}
+	of_node_put(np);
 
 	np = of_find_node_by_path("/testcase-data/platform-tests");
 	unittest(np, "No testcase data in device tree\n");
-- 
2.34.1

