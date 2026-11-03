Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702552;
	b=pPFCxVAjj5e3zeEVKvKL/s6bXbhSqLQ2RkehWC5uCjjsv1npwEHhiTI5ufYUMGKT7YQK
	 O1fTxxFZunXWI3ihEDE8vb2LWHRdyzpSRhKfQDJEr75Ylzq76AM1Pg4muqyzBax/njmoD
	 oGLbEH+Qbc29VWSQBh/8Av5ewfr5lXuNcc+Sy/WlMR5JElhsJYz0qq/DMlIu+ixmRI/Cp
	 q1O2HOkJVrqx7mlGXURaQvapnR8yopI3lvkegbBm9eaafZ5a7dMHK6nMzAFtsh5FpIOl6
	 pcz306HZVKeMdlWwrp6fvtYTkz3x8BmI61SiKl7+vEaA9F04tcQJL58MJkWyr1skrOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702552;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=xFjMgrhysd3SIaAbXUTjEv9Ns6i+HPsKQ/+El2X0XN8=;
	b=F97/j0cUS399Uuq4GDCss/k6BeE1K9nQB5Kxx4TKpTtYsk5sHBx6mMinGU7MTfobdwIW
	 Cqd7TD+B2u65PQ2G4YHRoUMRIvBZ+ch7T8ooyA94ZIpCpxF4xJltpX6H6bM6ptz5nSWPG
	 6t7mvOybOLjrZgiqU/VUKAVw3gF8ZzZoHft25QQ7Lf5Y7A+uxzhsZj84qJlidfqt0c9tU
	 B3hQXaCPuqGjkbr3ebpNlZDiuGaZWBZPxAli0o2FSzD0WkGclVFhP7xYvhLMHj3YevWnx
	 IaF8hhAnSHKujJP4GlibYSXWyYsYLdyZXS+LJfEqrL8K3Al9H6NvSYCk7URaE+tHdtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48866606EE81;
	Tue,  3 Nov 2026 10:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48866606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QpOUuulqfcg7AA--.3190S2;
	Tue, 03 Nov 2026 18:42:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: fix node reference leak in of_unittest_match_node()
Date: Tue,  3 Nov 2026 10:42:37 +0000
Message-Id: <20261103104237.1373649-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAA3QpOUuulqfcg7AA--.3190S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur47Kr17Zryfuw4kKrWUtwb_yoW8JFy8pr
	W5KFyYyrWrJF4UK34I9a47uFyYy3W7JrWYkryUG3ZF93yrJa4UJry0q3y5Wrn8XF95Wa4Y
	yw18tr4vga4UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	yj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07bwfOcUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIAA2rpnOF63gAAsX

of_find_node_by_path() returns a device_node with its reference count
incremented. of_unittest_match_node() never releases that reference:
failed matches continue to the next iteration, and the reference taken
for the last test case is still held when the function returns.

Drop the reference on all three paths.

Fixes: 1f42e5dd5065 ("of: Add self test for of_match_node()")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e255f54f4d76..7426d13e9958 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1921,6 +1921,7 @@ static void __init of_unittest_match_node(void)
 		if (!match) {
 			unittest(0, "%s didn't match anything\n",
 				match_node_tests[i].path);
+			of_node_put(np);
 			continue;
 		}
 
@@ -1928,9 +1929,11 @@ static void __init of_unittest_match_node(void)
 			unittest(0, "%s got wrong match. expected %s, got %s\n",
 				match_node_tests[i].path, match_node_tests[i].data,
 				(const char *)match->data);
+			of_node_put(np);
 			continue;
 		}
 		unittest(1, "passed");
+		of_node_put(np);
 	}
 }
 
-- 
2.34.1

