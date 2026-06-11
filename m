Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFEC3FBB68;
	Thu, 11 Jun 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187823; cv=none; b=IhJE+gI6Trf1Ont1c2jQCzk1AY/xCeVXkY2ljQMEP7//mhGcGSqhmje+etOEkVtG3lzclNAKGXp//W6ICnW+TwX/wmfZr1JBWw6k52dAydNSrLDjFFvzYUr19L9XjVv5urrEw03LvWxYM4o51w675VjyxNPjXkMgsGFS1HPS3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187823; c=relaxed/simple;
	bh=G5Pr4BkAuQKpXrwT2yliKLKk5qHfhm68D/Gbf5xozuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KL9tB/1qwSgXNKSZUnMSTftBi6yTWyvb0IWgBytW5sroO7ONRxMNC6cRqg2DJMr9WkCJgcL6crTlH01ZVpOtZ0IfrfbDnPPKasfDBrnjmokTT1y2OBvO9EAZPD3aIBgascZJJgBYAWY2RIPWMWK5RZlVCY7y9ibG5D519B94RFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowACXHgLixCpq43AXEw--.957S2;
	Thu, 11 Jun 2026 22:23:32 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: jgross@suse.com,
	sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] xen/gntdev: fix refcount leak in gntdev_ioctl_map_grant_ref()
Date: Thu, 11 Jun 2026 22:23:28 +0800
Message-ID: <20260611142328.87566-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXHgLixCpq43AXEw--.957S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF13Zw4kWr1UXFyxtFy8Grg_yoW8GF1fpa
	9xCa43ArWrXw1Iq3WqqayagFy5X3sxJFy3Cry0k3s8ZFnIy3WIyr15tFy8ur4UJrs7CrW5
	Ar4kCFyruFW5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUf8nOUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRAPA2oqh4XCBgAAsT

When gntdev_ioctl_map_grant_ref() fails to copy the operation
result back to userspace after successfully adding the mapping to
the list, the error path returns -EFAULT without releasing the
reference acquired by gntdev_alloc_map(). The mapping remains in
priv->maps with a refcount of 1, causing a memory leak and a
dangling list entry.

Fix this by moving the copy_to_user() before gntdev_add_map(),
so that the mapping is only inserted into the list on success.
This avoids the need to remove the mapping from the list on error.

Cc: stable@vger.kernel.org
Fixes: 68b025c813c2 ("xen-gntdev: Add reference counting to maps")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/xen/gntdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 61ea855c4508..a1c230756b3d 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -672,8 +672,13 @@ static long gntdev_ioctl_map_grant_ref(struct gntdev_priv *priv,
 	op.index = map->index << PAGE_SHIFT;
 	mutex_unlock(&priv->lock);
 
-	if (copy_to_user(u, &op, sizeof(op)) != 0)
+	if (copy_to_user(u, &op, sizeof(op)) != 0) {
+		mutex_lock(&priv->lock);
+		list_del(&map->next);
+		mutex_unlock(&priv->lock);
+		gntdev_put_map(priv, map);
 		return -EFAULT;
+	}
 
 	return 0;
 }
-- 
2.50.1 (Apple Git-155)

