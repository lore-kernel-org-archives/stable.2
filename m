Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834F49A3A2;
	Wed, 16 Sep 2026 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584477; cv=none; b=Gk/eKhtCJWn1HVCDbkx6CGBQnN+JIae/pYbxx7mhmjLMPEbaYCTwj4Rd/r2nzo4NNNLhZ9rLA33YjLr82lzc90G+RRdbx8SNnFsi3I9LByawNHNkNzgvE4f4uesGAXud6VTzakAE+Km+Z9PfBBzWoZUlRE82hTceP/1nDUj7oTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584477; c=relaxed/simple;
	bh=dDLKKajzXueqEhFJZ00uZet42bNEKHZTSnJsbB+OhEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2glJ1H/H7oz1V5cC6cX3UsmIMnPQTLcYYdppH0BYXnc5EVhdLCj3E+NhJh+UjKXRHNdRlr9i0rocc6oKATP4+FKs0dqeGdbA3jGfdD4UDMeJpFBP3IfjtCBsHEkcVVOa3b4y6Dtuw70QIWu6WeDn2O3vhHFgoTRwqC+I71ttxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3oDpU5KpqR9RvCA--.24262S2;
	Thu, 17 Sep 2026 02:47:49 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	samuel@sholland.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Input: Fix i2c_bus OF node reference leak in ppkb_probe()
Date: Wed, 16 Sep 2026 18:47:21 +0000
Message-Id: <20260916184721.2093344-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3oDpU5KpqR9RvCA--.24262S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy5Wry7tFWxJFyDtF1rCrg_yoWktFb_Wa
	4rXas3Wr98KF42grn5Ars3Zr9Fkw10vF97AFyvg34SkrW5ZrWjga4UZrZ5Ar17uw4fKr1D
	G3Wjkayvyrs8ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j
	6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUYZ
	XoUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUMA2qqpViDRQAAs2

The device node reference returned by of_get_child_by_name() is
stored as the adapter's of_node but never released, leaking one node
reference on every probe, successful or not.

The adapter only borrows the node, so drop the reference once the
adapter has been added, and also on the error path.

Fixes: 63c5eb157cfd ("Input: pinephone-keyboard - support the proxied I2C bus")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/input/keyboard/pinephone-keyboard.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/pinephone-keyboard.c b/drivers/input/keyboard/pinephone-keyboard.c
index 147b1f288a33..c82323713be8 100644
--- a/drivers/input/keyboard/pinephone-keyboard.c
+++ b/drivers/input/keyboard/pinephone-keyboard.c
@@ -384,8 +384,10 @@ static int ppkb_probe(struct i2c_client *client)
 		error = devm_i2c_add_adapter(dev, &ppkb->adapter);
 		if (error) {
 			dev_err(dev, "Failed to add I2C adapter: %d\n", error);
+			of_node_put(i2c_bus);
 			return error;
 		}
+		of_node_put(i2c_bus);
 	}
 
 	crc8_populate_msb(ppkb->crc_table, PPKB_CRC8_POLYNOMIAL);
-- 
2.34.1

