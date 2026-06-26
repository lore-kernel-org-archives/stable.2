Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3E341ADD;
	Fri, 26 Jun 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486116; cv=none; b=e5fdcOkOegqhtKh2yo3tjKqF9Z20KHB4xUSw2Ds7YawWTKJvlSTa6Lx1+s+Yv6TyEExD4jKUPyDr0wc9nxpIpMf5SsouLnfUHrctpQVYlIbqLMB12mOL1njgxJXhRp2BuvIJfRtav8dizUMFLuxZ0HfPJUwELE97elGQFN1FbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486116; c=relaxed/simple;
	bh=WfvDerzadXKZOxuzKRwmU4ca99LsHj7kq/BGwCUu22A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UI9i+oSAtbBKauDFqkrYjfTcbNPe9TCOVXd5eYGhYuruxxwmdvhNBx4FuATzBRvNv2hE4O152CRni+2d0yYLk6zYq0VNAtcIObfRTawTpG9bblndU66slAd5stwuMYKvjIEUnFQ0nFmY1Vz1RyIhl4//LvTwrBlWvv3sRd0hXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAA33NRXlD5qa0lrAw--.18793S2;
	Fri, 26 Jun 2026 23:01:44 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Zack Rusin <zack.rusin@broadcom.com>,
	dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/vmwgfx: vmw_user_shader_alloc: fix base object refcount leak on   ttm_base_object_init failure
Date: Fri, 26 Jun 2026 23:01:42 +0800
Message-Id: <20260626150142.49732-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA33NRXlD5qa0lrAw--.18793S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWrJFyDJrWxZFW5tFWUArb_yoWkKrX_GF
	WDWF18XFWUuF4vg3Wayw47X347Kwna9rZ7Zrsxta4fKF9xZ3Wjg34j93s7Ar1xXanrCr98
	JwsxGw4fArnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMKA2o+iCgieAAAs9

ttm_base_object_init unconditionally acquires a base object reference via
  kref_init. When it fails, the error path in vmw_user_shader_alloc only
  calls vmw_resource_unreference but never calls ttm_base_object_unref to
  release the base object reference, causing a refcount leak.

Add ttm_base_object_unref in the error path to properly release the base
  object reference when ttm_base_object_init fails.

Cc: stable@vger.kernel.org
Fixes: 0b8762e997df ("drm/ttm, drm/vmwgfx: Move the lock- and object functionality to the vmwgfx driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index eca4e3e97eb4..d82ec43c8901 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -724,6 +724,7 @@ static int vmw_user_shader_alloc(struct vmw_private *dev_priv,
 
 	if (unlikely(ret != 0)) {
 		vmw_resource_unreference(&tmp);
+		ttm_base_object_unref(&ushader->base);
 		goto out_err;
 	}
 
-- 
2.39.5 (Apple Git-154)

