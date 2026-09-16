Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4549B46C;
	Wed, 16 Sep 2026 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573752; cv=none; b=OVM7YJMCep9KVPa1ROtFae+2bob3E0lSyc/QOvvTs+tCBJ/G2bWJ9dbcox/SlrNF6KKewU8p6Kzc9ycvr4X4vT0wSc4RUYXK31WpBC2j9Z7mq4oAh/KHiysQYhlxa5i21wgkSuqqDQAZ9PJ0Im8Wc7KbbidSyiRy3GKYd/Kid98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573752; c=relaxed/simple;
	bh=W7g0ZQM7jaPULHJ0kK5uWm56KQSXFeFSX2OrJsmbf6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jJrWFiht5tsA6U7CLWb7QJ6Rh9YJORnSdyAqqxFivqW1Ad1/pVeuHclkinorDpa7h0MpjrpA+D0mM0k9r2cvU0KjmJwg26f0qaXqC519rP3WV/Uwvm7J8we7IO35c+GyiZV44gTl0ukC6s5yDQVN+QhQbH6pJyyVJNK/LsBKMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHKkNruqpqZhxtCA--.21134S2;
	Wed, 16 Sep 2026 23:49:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	maaz.mombasawala@broadcom.com,
	martin.krastev@broadcom.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	zack.rusin@broadcom.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix user surface reference leak in vmw_buffer_prime_to_surface_base()
Date: Wed, 16 Sep 2026 15:48:32 +0000
Message-Id: <20260916154832.2066415-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHKkNruqpqZhxtCA--.21134S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XrWrXFWUCr4kJr17Xw4rGrg_yoW8JF1rpw
	43KFW3KryfJF4xtF9rAa95Xr909a1qgFyF9FyvkwnrZw17A3sxWa15A398KF42krs7Ar45
	JrykAwsxuF1UCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0ob
	IYCTnIWIevJa73UjIFyTuYvjfUrrWFUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcMA2qqok8+0QABsN

vmw_lookup_user_surface_for_buffer() returns the surface base object
with an extra reference that the caller must release. When
ttm_ref_object_add() fails in vmw_buffer_prime_to_surface_base(), the
function jumps to out without releasing it, and *base_p is never set,
so the caller cannot clean it up either.

Drop the reference with ttm_base_object_unref() when
ttm_ref_object_add() fails.

Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index b2d3927b5567..8d3bd34b00f3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -965,6 +965,7 @@ static int vmw_buffer_prime_to_surface_base(struct vmw_private *dev_priv,
 	base = &user_srf->prime.base;
 	ret = ttm_ref_object_add(tfile, base, NULL, false);
 	if (ret) {
+		ttm_base_object_unref(&base);
 		drm_warn(&dev_priv->drm,
 			 "Couldn't add an object ref for the buffer (%d).\n", *handle);
 		goto out;
-- 
2.34.1

