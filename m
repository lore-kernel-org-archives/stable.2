Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955C368D65;
	Wed, 16 Sep 2026 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574682; cv=none; b=SkfEsHIjkK3ijj+FCEOtfVIHjyiL98SoFXxbO7TBG5DF3wYHD/r1pazFgSw6aKULsjjQOziIMoMDcHKvHpVOrP0I22JC5ThDLRh0FJJgrqM3hntCh08q3y3radn5eUOuZqNccIWFLny5EJ3w1HjIYpPxsGOK5RKt10IZKIEWSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574682; c=relaxed/simple;
	bh=hBsPM0EE/2ZoEKYqwERUSAVfKlYpvFBh2J2gN5/KlUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ACkUiNoamTJun/8x+x0YCI6hGqI3zmdrkYKf/Yq9F4wj6vLmFOXxYc5Dm2dFqePkY98OZPxZJD3utENOe5jROhIsJUCG4veOc4OVLd52AR3H9HaFeX/ZzUGM5ty3NFoX2C4Eaf+GE7+/AZ9QG4ydyMzRQnI43bvoztlyDQOVbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXiEIKvqpqIVRtCA--.21697S2;
	Thu, 17 Sep 2026 00:04:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Frank.Li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	arnd@arndb.de,
	bbrezillon@kernel.org,
	gregkh@linuxfoundation.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] i3c: master: Fix of_node reference leak in i3c_master_register()
Date: Wed, 16 Sep 2026 16:03:58 +0000
Message-Id: <20260916160358.2081087-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXiEIKvqpqIVRtCA--.21697S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr15trWkWr4Dtr1DGr17KFg_yoWDKFc_KF
	48Wr92qr48Cr4vkr43GFW3urZFkFWqg34IkFWFyFyxW3y8XryDJ34UXrZ8AF4UCrWfZr9x
	ArWDKr1rC3y7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoq2MUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcMA2qqpVg+UQAAsd

The reference taken on the parent's device node with of_node_get() is
normally dropped by i3c_masterdev_release() once the master device is
unregistered. When i3c_master_rpm_get() fails, the function returns
before device_initialize(), so put_device() is never called and the
node reference is leaked.

Release the device node reference on the runtime PM failure path.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/i3c/master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 5cd4e5da2233..23f490a00591 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -3033,8 +3033,10 @@ int i3c_master_register(struct i3c_master_controller *master,
 	INIT_LIST_HEAD(&master->boardinfo.i3c);
 
 	ret = i3c_master_rpm_get(master);
-	if (ret)
+	if (ret) {
+		of_node_put(master->dev.of_node);
 		return ret;
+	}
 
 	device_initialize(&master->dev);
 
-- 
2.34.1

