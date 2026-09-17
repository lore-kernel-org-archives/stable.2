Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AC2EEE83;
	Thu, 17 Sep 2026 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649577; cv=none; b=T/GND6CBIO1XY1dsoJ75bSfKn46oR84Uox6OfX+AOn6mIqAMpLRta3LEGeOVFv4akzB38nKk/6daXuf1IComNxUk+DYiqdY22BCpf+rHnizPcBBLtMuTkQo2hZ8fuqIElAZaGJX2iqaxZl3Eie+rATx8KF6THo8YjL7pZzxBATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649577; c=relaxed/simple;
	bh=cUUcSkpLQfkqTIXsfKOqlPC6VTrxEGX1glFEmPP+NRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJaei8zeCRd6RngIuP2qJNbkJeHbCbTnOhPj96F5ZYkeUgjUNYtQbvdM8x6Czvul5YEqJVH5x6jKlZorTQzXrRLuZHQWAGI4NXxlynWeXXxGt/zvaXM3PlDBZsJnpNBP8w+WWVu65ZdkXns7iazHteuQosZOL7jd3nAbYwZr6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3pkCW4qtqsOaACA--.3033S2;
	Thu, 17 Sep 2026 20:52:39 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: f.fainelli@gmail.com,
	frowand.list@gmail.com,
	jim2101024@gmail.com,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix np reference leak in of_unittest_dma_ranges_one()
Date: Thu, 17 Sep 2026 12:52:38 +0000
Message-Id: <20260917125238.2152144-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3pkCW4qtqsOaACA--.3033S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr15Xr4fWr1ftF15JF4UCFg_yoW3uFb_Ga
	4DZr93Wr18CF1Uu34fJFZ3ZF92y3WUWrW8XrnIyanakrWjvF1jgr1Y9r95Ja45Z3yY9F9F
	yrs8ur18twsFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqkYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j8
	jjgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwINA2qrrRmjJQAAs4

When the bogus device allocation fails the function returns early and
never drops the reference obtained from of_find_node_by_path(). Add the
missing of_node_put() so the node reference is not leaked.

Fixes: a8d61a9112ad ("of: unittest: fix warning on PowerPC frame size warning")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index d1a88a043300..226debdaa5c1 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1141,6 +1141,7 @@ static void __init of_unittest_dma_ranges_one(const char *path,
 		if (!dev_bogus) {
 			unittest(0, "kzalloc() failed\n");
 			kfree(map);
+			of_node_put(np);
 			return;
 		}
 
-- 
2.34.1

