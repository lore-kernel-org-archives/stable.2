Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5054F0526;
	Thu, 17 Sep 2026 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648443; cv=none; b=j72l2GK42h8VQBgfta9/P9Tz5WjJUDZNtAe6V3njVAQ9CldAynR+qJ1vV/gj0XPDrFIgOgrEbwlJ6P6523LY4Q/nE54o3lBAxXnXsPbpBxDJfzrGicJ5RaQzrwWCJavyG14dUwbUYRecq84MWgU6PzijgDMb7Meh5GIXoy1NenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648443; c=relaxed/simple;
	bh=A34bFxgBnWeF4VHl7PGrj4teQuNWgfYQUvkh55i8cJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ER6zeMJx/pmq8vRg7jwoxm1/3qwKQFooLbcGngMVvVQ6Rea5R5wjtkYGuK43fi8PSRPmEXKbjwgyTTcunb7FRcUJzY41NumTACIi3IUZLbL+1GwLcTw72kE045AN4XczlCyA+xZWurd1YSLX2wUMg6xBhuHdOMSaVftZytb5S3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH7zko3qtqiJeACA--.2774S2;
	Thu, 17 Sep 2026 20:33:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	srini@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nvmem: core: Fix nvmem use-after-free in nvmem_cell_put()
Date: Thu, 17 Sep 2026 12:33:44 +0000
Message-Id: <20260917123344.2151268-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH7zko3qtqiJeACA--.2774S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1DKF18Xr1DZF1rur13twb_yoWDZFb_uw
	1j9FsrXF1fJrnrKr1fCF1fZ348tr4SgrZYyF1vqFs5JFWjvr9ru3sY9398Ary3Xr4SvrZr
	XryDJr4FgrW7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYNA2qrq3ag0gAAsg

__nvmem_device_put() drops the last reference to the nvmem device, which
runs nvmem_device_release() and unregisters and frees the device, but
nvmem_layout_module_put() then dereferences nvmem->layout on that freed
device.

Call nvmem_layout_module_put() before __nvmem_device_put() so the layout
is still accessed while the device is alive.

Fixes: fc29fd821d9ac ("nvmem: core: Rework layouts to become regular devices")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 311cb2e5a5c0..4df7efde2cd2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1593,8 +1593,8 @@ void nvmem_cell_put(struct nvmem_cell *cell)
 		kfree_const(cell->id);
 
 	kfree(cell);
-	__nvmem_device_put(nvmem);
 	nvmem_layout_module_put(nvmem);
+	__nvmem_device_put(nvmem);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 
-- 
2.34.1

