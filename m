Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB095274FD1;
	Fri, 26 Jun 2026 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474251; cv=none; b=tPKqoNYsOfczsNa18I0GQpDryGcRbTBjSVjUBXkbU03InUvpnyPROsVn0kEXYVxOCx2VctUGVITBSLlfVCD0xpbq8y31CwCTyn1YTYppGjxgFAVvIr6H4vcCAd2qS7GfGeXZ6/kCZDZx9dTgaJ+3F3m9m/F8KIzzeWlDBF8syCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474251; c=relaxed/simple;
	bh=UGHswoJR+MaQdfHVOnEO2dOfMl/eG0YOzS1FvY6cqnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LYThsnP26g45iXzUIHOnqd49ztVWglDdTRNv24MvZMEmL9nCiXmR71FGf2DDaYsVqvZDbV4geuAaxkE0SUtqS1S91xhspsljRgbgX/DjlNd+xOWPsuyeK8sQrBeiZfNz7qivo7AX+XmwISwUYRJTHMAgMn1VxZ2I1KF5DNgqGA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhEBZj5qj3dmFQ--.22667S2;
	Fri, 26 Jun 2026 19:44:03 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: jeff.hugo@oss.qualcomm.com,
	ogabbay@kernel.org
Cc: carl.vanderlip@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: accel/qaic: qaic_attach_slice_bo_ioctl: success path missing   drm_gem_object_put
Date: Fri, 26 Jun 2026 19:43:59 +0800
Message-Id: <20260626114359.32938-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhEBZj5qj3dmFQ--.22667S2
X-Coremail-Antispam: 1UD129KBjvdXoW7WryrAF47JFy3Xw1fZryrZwb_yoWkXwc_WF
	93WF1DWry3Wr1kWrnxZw1fArn2yr9agF1v9rWIqF9xAayrZr1avryku348Aa4kJ3Wxu3sx
	JFnxtw4FyFnFyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYKA2o+ThJJGwAAsZ

drm_gem_object_lookup() acquires a GEM object reference on success. All
  error paths correctly release it via put_bo, but the success path returns
  without calling drm_gem_object_put(obj). Since list_add_tail does not
  transfer ownership, the GEM object reference is permanently leaked on
  each successful call.

Cc: stable@vger.kernel.org
Fixes: 75af0a585af9 ("accel/qaic: Grab ch_lock during QAIC_ATTACH_SLICE_BO")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
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

