Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D33C3F6B;
	Wed, 16 Sep 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551674; cv=none; b=nvZwoZXCd+FdAWkQx21F8AQJu3z0v2rIQGybMBjGeYPosExthwmXfL1TeA0bRAZ2e5KZmyPFIf662LytwlhqT1WuZ1KhoDgSkuahs551rcNdcATNGKYsR+Zlp6IZ2FTRqxv6tctceqBypoEI2hOvHKeJOgIL1b2ZMLSXOcD7Bj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551674; c=relaxed/simple;
	bh=uzTPEWbqX5hdbyzS/J9sr9SM/ZcvFFCsZE1EBlJ4mSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HMfbgkj/YVM49B7kiksVUzuacKONPZnjItOZ+g2heaoLD06gRbWfpGUX3F+cBnwpGZgtWWUEB767jL9+5sMa0fd8sjbu4Y07/yXhOn0+pq2tCC0fKX8M2tLNzeFXIO234qjvu8i2C6QJwXf4S/jsTvNnS6XTlPKJDFhfYcUJk5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnrjwqZKpq+Y7gBw--.30362S2;
	Wed, 16 Sep 2026 17:40:58 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: eajames@linux.ibm.com
Cc: gregkh@linuxfoundation.org,
	jk@ozlabs.org,
	joel@jms.id.au,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	ninad@linux.ibm.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: master-gpio: Fix of_node reference leak in fsi_master_gpio_probe()
Date: Wed, 16 Sep 2026 09:40:30 +0000
Message-Id: <20260916094030.2005879-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnrjwqZKpq+Y7gBw--.30362S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrW5XF1kXF1xCr1UAF43KFg_yoWkJwcEk3
	Z5ZF97J3y7AF4kKrs8Jr4avr4DKr9rWFyxCrWxta1fu34rAryYqFyfZrs3J3Z7urWfJFWU
	t34DKw4rWrW3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUJWr
	AUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgEMA2qqPpSfjQAAsw

In fsi_master_gpio_probe(), a reference to the device tree node is
taken with of_node_get() and stored in master.dev.of_node.  If one of
the GPIO requests or the device_create_file() call fails, the error
path frees the master without putting that reference, leaking it.

Put the device node reference before freeing the master on the error
path.  of_node_put() tolerates a NULL node, so paths with no device
tree node are unaffected.

Fixes: f6a2f8eb73f0 ("fsi: Match fsi slaves and engines to available dt nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/fsi/fsi-master-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 0884e143b30e..03c46f9d6543 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -861,6 +861,7 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	}
 	return 0;
  err_free:
+	of_node_put(dev_of_node(master->master.dev));
 	kfree(master);
 	return rc;
 }
-- 
2.34.1

