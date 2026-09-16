Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE46483BD1;
	Wed, 16 Sep 2026 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551525; cv=none; b=szqQpVvi3PEarNSrAqdI2pG6mIkoZ2wnBKL5O98c+Tp2fCCQKIZaxa7HAxQQc9jd7mZQk/kfVG1KyJ0SCI/xA9240GxsdtlrbaGZhq6GjLVfkhA5B2UYWkgEJHoI5bCmgbWy8IMLY/ECO5r+GBpwrFuIW1RyLuVfQqNiwhIdfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551525; c=relaxed/simple;
	bh=jYUpo4i54vYGFYzfdSB/VedMVfT1vKku0NiQqbzcHZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JiL72n+ao1odp0q9CzYAdkWEcUsvyUgjOJ51uFEAX7JbkLhRoSgyp12S3TKPvTM2dFzMr20uuQ4D2eBnVWAiBUGXzbLAapQmolxTw2i56viAd6CcXDU8qUVYdZOUrD1A0wdVFm6JDZ/7kZcYiJsyUU0jvFCKN4vh0xE9Gl5FmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXnz2UY6pqG4PgBw--.42121S2;
	Wed, 16 Sep 2026 17:38:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: eajames@linux.ibm.com
Cc: joel@jms.id.au,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	ninad@linux.ibm.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: i2cr: Fix of_node reference leak in i2cr_probe()
Date: Wed, 16 Sep 2026 09:38:00 +0000
Message-Id: <20260916093800.2005305-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXnz2UY6pqG4PgBw--.42121S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrW5XF1UXw1kWry8CFW7Arb_yoWDAwbEka
	4kWF97XrWUCF45Krn3Aayavw4q9F9rWa4xGF42ya1fW34Yyryjy3W3Zws8C3WUWFWxJr48
	Jw1qkFn3urW7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHpB
	fUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQMA2qqQJWQ-QAAs0

In i2cr_probe(), a reference to the device tree node is taken with
of_node_get() and stored in master.dev.of_node.  If fsi_master_register()
fails, i2cr_release() never runs and the reference is leaked.

Put the device node reference before returning on the error path.

Fixes: 53e89e3e4490 ("fsi: Add IBM I2C Responder virtual FSI master")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/fsi/fsi-master-i2cr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index d36a4328ad73..31c9b3b70d92 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -280,8 +280,10 @@ static int i2cr_probe(struct i2c_client *client)
 	i2cr->client = client;
 
 	ret = fsi_master_register(&i2cr->master);
-	if (ret)
+	if (ret) {
+		of_node_put(i2cr->master.dev.of_node);
 		return ret;
+	}
 
 	i2c_set_clientdata(client, i2cr);
 	return 0;
-- 
2.34.1

