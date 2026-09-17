Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36154F796E;
	Thu, 17 Sep 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649846; cv=none; b=ZDv4EiDYI9EImXfHZKhAKn24wQ9QDwK/bYOnKwnuOkvA9zl2X0XBrthf7f60C/vOD7KB5eNhwJEZ1fI+uWXnCYmyWiV4DnV9jRMqHsm6ctXj2G3YzPXmkuci5LR3teg0ek7yDcpJZVvHGY4v98T/NjVBm4VF/p6KpuWS90TauqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649846; c=relaxed/simple;
	bh=oco9a85LGscLJtRKtxq+cy0jzX3sKo17VJcL+GUEixw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pkOU2oEceB4YEa27+kXTC0laUbqSZMC0uBqHHBonpH4Ua0xgDPNIWBDWz9WcXr7D2vWAu1XH9TvDIu7WNr0zuPDrH4NmLM3ZZ6K8hphJ8AqQ0yXUx+1B4BF4CxZbxnYO+6I2y5u1Sxs8SDcV1qSL6G8dDiiN/HBb9FaLJDzT5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnFD+t46tqXPmACA--.3086S2;
	Thu, 17 Sep 2026 20:57:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix of_symbols reference leak in of_unittest_overlay_high_level()
Date: Thu, 17 Sep 2026 12:57:17 +0000
Message-Id: <20260917125717.2152371-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnFD+t46tqXPmACA--.3086S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr4xur4xAw4Utw17KFW3ZFb_yoWkKwc_KF
	1kZasxXrW8CF4UurWSyry5Zr9F9ay5urW8XF1vkwnI93yayrnrXr1Y9rn5Jw15ZayFy3s0
	kr4Du348Ar9FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07jngAwUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQNA2qrq02xtAAAsx

of_get_child_by_name() returns a node with an elevated reference count,
but the function never drops it: neither on the early return for an
illegal node name, nor on the normal return, nor on the err_unlock
path. Add the missing of_node_put() calls.

Fixes: 81d0848fc8d2 ("of: Add unit tests for applying overlays")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 900840850814..36c64d485a53 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4091,6 +4091,7 @@ static __init void of_unittest_overlay_high_level(void)
 					 np);
 				of_node_put(np);
 				of_node_put(base_child);
+				of_node_put(of_symbols);
 				return;
 			}
 		}
@@ -4289,10 +4290,13 @@ static __init void of_unittest_overlay_high_level(void)
 	EXPECT_END(KERN_ERR,
 		   "OF: resolver: node label 'this_label_does_not_exist' not found in live devicetree symbols table");
 
+	of_node_put(of_symbols);
+
 	return;
 
 err_unlock:
 	mutex_unlock(&of_mutex);
+	of_node_put(of_symbols);
 }
 
 static int of_unittest_pci_dev_num;
-- 
2.34.1

