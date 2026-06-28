Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2161EA65;
	Sun, 28 Jun 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782647491; cv=none; b=oH1hc9cfqrcUYVA+M5ZooVkT299yJdluavt3tGVoEGddBvYih4fqNzFeVAg5VgsrGUARtecmMim4mmQF1jiDhBsV0GNuaJH8Btgn5Lyezr9CN/s/pqVsCK1BDldSyHSj8BdxIPMzKMFyq3i6y2Q/3ftbTBLigJiutM8DqDv579Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782647491; c=relaxed/simple;
	bh=p0l7Pw06IIRXehEcjEbmX6Ste92cS0fQgkO4BiYxIGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u4SA/VYjGagC8BBEGNM1ym8cTQBoOE0oS/OKJBgH6lBBz/zvZ0RORdr3R6tMPxGaT9XrAY7hbRB/alp6WsdP9ZDPgoakzUtySb2zp9/frvJsEEgUCYTGOifjiQy68qF0sZwncFddFoHltLP74/k8dQYFyj2nl2pJGveDs5Y7jKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowABXo8a5CkFq5yHDFQ--.53914S2;
	Sun, 28 Jun 2026 19:51:23 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	jeff.hugo@oss.qualcomm.com,
	carl.vanderlip@oss.qualcomm.com,
	ogabbay@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v2] accel/qaic: fix GEM object refcount leak in qaic_attach_slice_bo_ioctl
Date: Sun, 28 Jun 2026 19:51:19 +0800
Message-Id: <20260628115119.44215-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXo8a5CkFq5yHDFQ--.53914S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryrAF47JFy3Xw1fZryrZwb_yoW8Jrykpr
	ZI9FZFqrW5Zr4UKrWjvFyDuF1jk3WY9ry7Kay5G34aqFn5XFyxZa45KFZ8GFnxtr17CFZI
	vr12vw1kWw12ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqeHgUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUMA2pAiNnYPwAAsP

drm_gem_object_lookup() acquires a GEM object reference on success. All
error paths correctly release it via put_bo, but the success path returns
without calling drm_gem_object_put(obj). Since list_add_tail does not
transfer ownership, the GEM object reference is permanently leaked on
each successful call.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: 75af0a585af9 ("accel/qaic: Grab ch_lock during QAIC_ATTACH_SLICE_BO")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
---
 drivers/accel/qaic/qaic_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 1e4c579d2725..b17df7bf565d 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -1084,6 +1084,7 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 
 	bo->sliced = true;
 	list_add_tail(&bo->bo_list, &bo->dbc->bo_lists);
+	drm_gem_object_put(obj);
 	srcu_read_unlock(&dbc->ch_lock, rcu_id);
 	mutex_unlock(&bo->lock);
 	kfree(slice_ent);
-- 
2.39.5 (Apple Git-154)

