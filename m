Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D12E8B67;
	Mon,  8 Jun 2026 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780889282; cv=none; b=NuyMaxSlrECgsgStmgp7rcsHos+TwRdqmE2SBJP+KEpL+H+mYICFmFdOt1kft66HQMVkzz5kEYSQNVchosRj5FJ38VOXMgDaf86a3LlLIDMJGQF5qlQ307WzUkbUTSsJBaZdmv3lKd0M8oBMv1YsEnPByt9p+rUrR3Lmm3qyjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780889282; c=relaxed/simple;
	bh=HJ8VdU4FxC85edYh0TTG/I7UeomzKrqp2I7xaawfr60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sqM0yOwO7LGLxGH1/8KyCW1uqy1FiZ6FZeVHP5iZ1FKi3lUhTXiUVS5RE1v7sNtQhNoX+Yq3tjExY644yML6kov6GHYm5MFWBuWvC6vIP6wnWmrXN68nBEOquj2JVIJEm7JMygMf/Vt2/PP7jE9uj9dhxR9g/f3YZ+mm6WtLbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADX5s2zNiZqE5H+Ew--.21668S2;
	Mon, 08 Jun 2026 11:27:47 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: fix ttm_base_object refcount leak in vmw_buffer_prime_to_surface_base()
Date: Mon,  8 Jun 2026 03:27:39 +0000
Message-Id: <20260608032739.111055-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX5s2zNiZqE5H+Ew--.21668S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKw4DuryfJFWxuF15Ww17ZFb_yoW8Jr4rpr
	43KrW3KryfAFWIqF9Ikan5XF1Yg3Wq9FyS9FZY9wnxZr1fAr9xuw45Aa9xKr42krn7Jr45
	JrykAw47uF1UCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU11rW7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkMA2omIvBVYwAAsp

vmw_lookup_user_surface_for_buffer() returns a pointer with a
temporary reference taken via kref_get_unless_zero(). The other
two callers (vmw_lookup_surface_for_buffer and
vmw_lookup_surface_handle_for_buffer) correctly release it with
ttm_base_object_unref(). vmw_buffer_prime_to_surface_base() does
not, leaking the reference on both the success and
ttm_ref_object_add() failure paths.

Add the missing ttm_base_object_unref() before vmw_user_bo_unref()
at the out label.

Cc: stable@vger.kernel.org
Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index b2d3927b5567..9e63846fd663 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -972,6 +972,7 @@ static int vmw_buffer_prime_to_surface_base(struct vmw_private *dev_priv,
 
 	*base_p = base;
 out:
+	ttm_base_object_unref(&base);
 	vmw_user_bo_unref(&bo);
 
 	return ret;
-- 
2.34.1

