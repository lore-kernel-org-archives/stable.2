Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8A4FB9A6;
	Thu, 17 Sep 2026 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650370; cv=none; b=YbkDm7U8aVuhtNxug4UBzUF3JkDkVDONtP6YfG6Jwaec5PTWifQb5TQ6P9PmwjJ5O3x1NlD7AqtCqoiJX+Z8Q8LKXcwaTMbD1rjqZzdUG8Y0WJx2ma/s/jU/rK69d95TM7Y98TVXwsVlTnd6rg+wz6B9pABkxgCxK6YvjaLW7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650370; c=relaxed/simple;
	bh=oezo/SszkwE+zd4QWtRoMT8kUkoRl08sTrTSZxrGGac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J6+rXXBQmLZBR2JxShr3ZwyvXJeQslb7NCwD3kQNh9pdnv5tR0oKGzHTP5c8eKntNq9u+c3qAqR8CUL9U/fSCzwJt+2bSfUJIUKjidtDXLl3+G3LLlACH8s1ynDm2H6EseKGatD8ceNlEIMU9edaRCPdJsoPKdpOqjbiHgol2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnF0Kz5atqHxmBCA--.3307S2;
	Thu, 17 Sep 2026 21:05:55 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: grant.likely@linaro.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix pdev reference leaks in of_unittest_platform_populate()
Date: Thu, 17 Sep 2026 13:05:55 +0000
Message-Id: <20260917130555.2152765-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnF0Kz5atqHxmBCA--.3307S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1UAFW8CF1xCFy8AFykAFb_yoW8JF4Dpr
	W7KFWa9rn5GF47taykuFyUZFyIyanxK395GryUJ3ZY9an3Aa43AryUXay0gFn8XFWxWayY
	yFnrtrWDJa9FvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07b818PUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAANA2qrrJquywADsT

The platform devices obtained with of_find_device_by_node() are never
released, and the second lookup overwrites the first one, losing its
reference as well. Drop each reference once the device has been used.

Fixes: 82c0f5897a87 ("of: selftest: add deferred probe interrupt test")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 4a8af9b992c4..e6e938bcb100 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1946,6 +1946,7 @@ static void __init of_unittest_platform_populate(void)
 		unittest(irq == -EPROBE_DEFER,
 			 "device deferred probe failed - %d\n", irq);
 		of_node_put(np);
+		platform_device_put(pdev);
 
 		/* Test that a parsing failure does not return -EPROBE_DEFER */
 		np = of_find_node_by_path("/testcase-data/testcase-device2");
@@ -1964,6 +1965,7 @@ static void __init of_unittest_platform_populate(void)
 			 "device parsing error failed - %d\n", irq);
 	}
 	of_node_put(np);
+	platform_device_put(pdev);
 
 	np = of_find_node_by_path("/testcase-data/platform-tests");
 	unittest(np, "No testcase data in device tree\n");
-- 
2.34.1

