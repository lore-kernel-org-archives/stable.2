Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA344F30EF;
	Thu, 17 Sep 2026 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649741; cv=none; b=Wa00ico0bNeK7enbkPagv8YW6KThZ94vBnWG9icug7qHQyDabtj8T8IWCuvjMYj2AcqK/9bhLTkLuPk/qbwX6Ti3wzzxoPsZJfPIZqbH3TCjFi5RsTaMjHFwszi5iQCOR0XWxfCK2ETDt4sLcwaWRoWy6HK0VXQ5U10E4M4VF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649741; c=relaxed/simple;
	bh=CgS8foIw+CAoe+nNj8jqdCzBiKTjw+dSU+vclH4uv/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=siPL67tk9IhmSGwTJmvd7A8T/ZHQkVDOhvxvdDyYzzJQXOrNwgP3C2pQNXRdczNY8J7L3hLNbp1dPAA0TERpOOlBgAut8gFhiD4PBkPhkGbJRyDGqcxOaiwopUbVZAaUB0ZlmkeAkZLt05UGV8Ia3F5h1MIw/mrLi1M6Xcigt/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3qEI_46tqTfKACA--.3059S2;
	Thu, 17 Sep 2026 20:55:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: grant.likely@linaro.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix np reference leak in of_unittest_match_node()
Date: Thu, 17 Sep 2026 12:55:27 +0000
Message-Id: <20260917125527.2152286-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3qEI_46tqTfKACA--.3059S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1DGFW3ZFWrXFyUJw1xuFg_yoWkGrg_Wr
	1kZrnxWrWjkr1vgFsavF1rurnFy3WDWrykWr4vyFna934jvr15Xrs0gryrA345Z3yFv3sr
	tr4DGan5trsFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqkYjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
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
	1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07je
	0PfUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMNA2qrq02wuwAAs4

Every iteration takes a reference with of_find_node_by_path() but the
loop never drops it, neither on the early continue paths nor after a
successful match. Add the missing of_node_put() calls.

Fixes: 1f42e5dd5065 ("of: Add self test for of_match_node()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 316f082c430d..900840850814 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1897,6 +1897,7 @@ static void __init of_unittest_match_node(void)
 		if (!match) {
 			unittest(0, "%s didn't match anything\n",
 				match_node_tests[i].path);
+			of_node_put(np);
 			continue;
 		}
 
@@ -1904,9 +1905,11 @@ static void __init of_unittest_match_node(void)
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

