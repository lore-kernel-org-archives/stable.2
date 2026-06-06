Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08523EAB8;
	Sat,  6 Jun 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780740748; cv=none; b=k+PcEWhHRS5JiHlhEUomw4mdjcxH9HD9FqpDFE3oSWJmubIDQcm3jkX5YSbhtYKTtexRaObeYzIP5th/1zYCem+MqHb1FUFnhNDw98j4hfrd+a95dBahaaeYwt/FU6Ck6k09YRij6pWb3YqFAGLpVXiWIL6Ghh5fAMbIZ8QXGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780740748; c=relaxed/simple;
	bh=BhRMvV9H/0SP4BLFSgOFzI5oVOLvCOV82nGo277oBGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=isZFy2hxIUvGTG6pi7CdoNbuHBfWesnce7ISuqWgSP/N4ZhHyF1P2pP6fxmZgXdixXt4aJV4iuw2GMOWm+lZt0NgVkehR9xWtkSG0VIVvc0RNj3jF7PB6dh5jEx2STDnNi/zaVWmacGMMFFxhgDvP8woRHQDiWP+ApUgQzy2fbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABnB9B68iNqUBu8AA--.18875S2;
	Sat, 06 Jun 2026 18:12:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/display: fix of_node refcount leak in of_dp_aux_populate_bus()
Date: Sat,  6 Jun 2026 10:12:01 +0000
Message-Id: <20260606101201.51494-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnB9B68iNqUBu8AA--.18875S2
X-Coremail-Antispam: 1UD129KBjvJXoWrur4rZry3uFWrCr4kAFWxXrb_yoW8JrWUpw
	47WFyUtryUCF47t3y7AFyxWrWqga17uFZ5WrZrCwn3uwn5ZF1UJFy8ua4DGrsrGF18A347
	Jr9rKF12gFy2krJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUJWr
	AUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4KA2ojcpPoEAAAse

of_dp_aux_populate_bus() acquires two references on np:
(1) of_get_next_available_child() at line 272, and
(2) of_node_get(np) at line 296 via device_set_node().

On the device_register() failure path, put_device() triggers
dp_aux_ep_dev_release() which only does kfree() without calling
of_node_put(). The error cleanup at err_did_get_np only releases
the first reference, leaking the second.

Add of_node_put(np) before goto err_did_set_populated to release
the extra reference on the error path.

Cc: stable@vger.kernel.org
Fixes: fe2e59aa5d70 ("drm: display: Set fwnode for aux bus devices")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/display/drm_dp_aux_bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/display/drm_dp_aux_bus.c
index 6e5e3e542290..9dd64cf25d87 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
@@ -305,6 +305,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
 		 * of kfree() directly for error cases.
 		 */
 		put_device(&aux_ep->dev);
+		of_node_put(np);
 
 		goto err_did_set_populated;
 	}
-- 
2.34.1

