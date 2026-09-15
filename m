Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497842C50D;
	Tue, 15 Sep 2026 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444447; cv=none; b=TbLmxpqfPxme5YGDrQShD7SwH9g2gPQqSAqIv+Y7fwHNo6JpiB3Nf3bCDsfOsjoCt2Z5XLOF3+/NDl4ZVSrtat6SwZuWfmJ0YSeLwTFW5mkcM7vvHbCBM5rhzhTmVsS6R37/Z/essjpGa5NvhKHPhF2zShghFW4PL6CGRdNESTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444447; c=relaxed/simple;
	bh=KxMd2BgOUpvDskd7nO+1egbt1DNAfpZvRON98Wwv0ow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lmkWscqN0YFks0rJ9Esof0RB/Au+HpwzMv6PTQX5XdUYuq+K/dbpB2Xx/0J5IxVtsfv4vnbpLhl6kxLiRAPt2mQftXEntgWFB8XK2/lcqOOOVh6eDHJcttXlbQ7unNLpM7+JmsHsXnheLQfjTv5IL5M93SeXVLbcvIqfOjXAPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABXLvJSwahqw9QHCA--.5267S2;
	Tue, 15 Sep 2026 11:53:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: angelogioacchino.delregno@collabora.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	matthias.bgg@gmail.com,
	sean.wang@mediatek.com,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: btmtksdio: Fix runtime PM leak in btmtksdio_shutdown()
Date: Tue, 15 Sep 2026 03:53:25 +0000
Message-Id: <20260915035325.1724227-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXLvJSwahqw9QHCA--.5267S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GFW3JFy5CF13Kw47Jr4ktFb_yoW8Jryfpr
	Wq9FyayFZavw42yFn7JanaqFWYv34YqrW8Kry0934rur4rJayIyF15tryYq3WSkrWkCw45
	A3Z2qFWfGFnFkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU19Xo7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMLA2qoi9j4JwAAsJ

btmtksdio_shutdown() takes a runtime PM reference with
pm_runtime_get_sync(bdev->dev), which leaves the device's usage
count incremented even when it fails.  If the WMT func-ctrl command
fails to send, mtk_hci_wmt_sync() returns a negative error and the
function returns immediately, skipping the pm_runtime_put_noidle()
at the ignore_wmt_cmd label, so the reference is leaked.

Drop the reference with pm_runtime_put_noidle() before returning
the error to keep the usage count balanced.

Fixes: 7f3c563c575e ("Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/bluetooth/btmtksdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 243215a81fa7..dfb61653a878 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1231,6 +1231,7 @@ static int btmtksdio_shutdown(struct hci_dev *hdev)
 	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		pm_runtime_put_noidle(bdev->dev);
 		return err;
 	}
 
-- 
2.34.1

