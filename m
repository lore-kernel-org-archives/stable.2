Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733C509F1B;
	Thu, 17 Sep 2026 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649997; cv=none; b=d6VoYybThUEYjEMMpR0JZpqm+vWis0Lb/i2KST3bwaoQGVxJfeYTDQO8Tb3V3w8LZyoESMQmd/dGHLJyw/7QRCaDPXaW8c1vMGHRQUcRRx15Krp1H7iORG7ct/y8HvHFVbo4Q7rVDSw+0ZgLEaBmkJzj08nRgD42gIWyR9w34H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649997; c=relaxed/simple;
	bh=FJxrWK1gBiGxRvr+NWkzixtKYf/0QH/dX/R6Xx3kh9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DKNU2EciB9Ycy41AZAA9Ly7QDsjDm0GulHdUu/WXcbtl/q/AqnU2VhwLEoKsKjIg3lMEiJzQ/3JIec6UQEe2DL2xQT3LxEv10skPEDDcgmPm3mPY++S+FSb0qGsOyyd/aD5k6YERpZg2ePZCJx/Rs/dOSk30S5gPzTd5/SwCq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnF0I45KtqhwGBCA--.3200S2;
	Thu, 17 Sep 2026 20:59:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	stephen.boyd@linaro.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix np reference leak in of_unittest_parse_phandle_with_args_map()
Date: Thu, 17 Sep 2026 12:59:36 +0000
Message-Id: <20260917125936.2152450-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnF0I45KtqhwGBCA--.3200S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry3tF45GFWfZr15XF4UXFb_yoWkGFb_uF
	yvvr9xXrW8CF4DurW3Xrn3ur92v3W8WFWkZr10y3Wak34jvrn0qr109r95Jw1DurWS9r9x
	Gr4DCry0krnrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqkYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07jn
	gAwUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQNA2qrq02y3QAAsb

of_find_node_by_path() returns a node with an elevated reference count,
but the function returns without dropping it both when a provider node
is missing and after the last check. Add the missing of_node_put() calls.

Fixes: 357aa4b61c82 ("of: unittest: Add phandle remapping test")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 36c64d485a53..e10fff3f68c4 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -581,6 +581,7 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	for (i = 0; i < ARRAY_SIZE(p); ++i) {
 		if (!p[i]) {
 			pr_err("missing testcase data\n");
+			of_node_put(np);
 			return;
 		}
 		prefs[i] = OF_KREF_READ(p[i]);
@@ -711,6 +712,8 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 			 i, prefs[i], OF_KREF_READ(p[i]));
 		of_node_put(p[i]);
 	}
+
+	of_node_put(np);
 }
 
 static void __init of_unittest_property_string(void)
-- 
2.34.1

