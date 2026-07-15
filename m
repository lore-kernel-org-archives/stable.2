Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3BA2F7AC1;
	Wed, 15 Jul 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105122; cv=none; b=T9zrZkPQQv6IrmFgpA/Lt54BA4zLPHzNtc+5nI2WtyvKs2cVGJ3DJf8xnkg9+XunAiA9/RovFeJgVb8dtJNRFhcZ3J638YzFdQRcIOY3Pvk0U2NS2TcriwJAe42XxfQaH9/ylXB4jy3+1fX8nDb3Wg5nwY9musMx7bN53qMdJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105122; c=relaxed/simple;
	bh=jrqxvQ6fl3wHhckb9vjLy3xKdNcIqzjtXsr5o/DqW/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jnka7H56nnoyZ8ii9tARw+QGbd+hn3qBllP7EwGiFhq/V3VUhdKrLVMIMXLUqvxsT4if6YZoqLhwV5UO+eibs52/HCFjM4WWWhGx2QLy2A4enkcvCIDg0sS4+g4aR7H/fkP1i/vAGeowbXu/aLVwWq4Z4YXqiUfytiiQbJede5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABnw9aQSFdqUXdHGA--.8434S2;
	Wed, 15 Jul 2026 16:45:04 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: srini@kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	rafal@milecki.pl,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nvmem: brcm_nvram: validate cached NVRAM length
Date: Wed, 15 Jul 2026 16:45:04 +0800
Message-ID: <20260715084504.43774-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnw9aQSFdqUXdHGA--.8434S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF18tFyxXw4fGw47Cry8Zrb_yoW8Aw4rpa
	43XFy0qwsrXa4ftw17CrsrGas8A39aga42g3WUZ3sYvw13Zry5try0gF92gFyYkF48XwsF
	934FqF15WF4rGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	nmRUUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The cached-content conversion stops at the partition padding.  Therefore,
data_len may be smaller than nvmem_size.  brcm_nvram_parse() checks
header->len against nvmem_size, then passes that length to
brcm_nvram_add_cells(), which temporarily writes data[len - 1] and parses
NUL-separated entries.

A corrupted header can declare a length that fits the MMIO resource but
exceeds the cached allocation.  Also reject a cached object that is too
small for the header, and reject declared lengths shorter than the header.

Validate the declaration against data_len, which bounds the parsed object.

Fixes: 1e37bf84afac ("nvmem: brcm_nvram: store a copy of NVRAM content")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/nvmem/brcm_nvram.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index aaa6537798bf..4701772cfa47 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -181,15 +181,21 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
 	size_t len;
 	int err;
 
+	if (priv->data_len < sizeof(*header)) {
+		dev_err(dev, "NVRAM content (%zu) is smaller than header (%zu)\n",
+			priv->data_len, sizeof(*header));
+		return -EINVAL;
+	}
+
 	if (memcmp(header->magic, NVRAM_MAGIC, 4)) {
 		dev_err(dev, "Invalid NVRAM magic\n");
 		return -EINVAL;
 	}
 
 	len = le32_to_cpu(header->len);
-	if (len > priv->nvmem_size) {
-		dev_err(dev, "NVRAM length (%zd) exceeds mapped size (%zd)\n", len,
-			priv->nvmem_size);
+	if (len < sizeof(*header) || len > priv->data_len) {
+		dev_err(dev, "NVRAM length (%zu) is outside cached content (%zu)\n",
+			len, priv->data_len);
 		return -EINVAL;
 	}
 
-- 
2.43.0

