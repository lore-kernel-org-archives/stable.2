Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58A4D9544;
	Wed, 16 Sep 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583440; cv=none; b=jyxzXn+kuAsca1euVgIOvDuEq/u1lKwISndxZpk+QUcP7no0AzIM6PTAqBLhgoIbjmCXgsnYlQDukJB/eePOm5FkAHQcjurratDHucjFfRxRJC+7Wjco/7Kg4HYf+FE5vzNWkGFuc23qY/TuawkL/065ctFigcgKfoPN0g0AFxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583440; c=relaxed/simple;
	bh=Ai3vaghIinenh+aXUz25RozFSciLjuqUKMuGqGx16vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JRECPn85H1iA8nXmBL2B/YSEO45LAhiqVp8d+71V8TrgOBHeSvwDolNPX+uYapRZm2zlNS1vftzBb3FjnhsrvK5WiUq9Et5hOsWejoPWTeKx2Zm9bl4tBbl3G21zxMvjBORwtE4Y3EP3GR7YCzOCXz1WroUnVsCWYugbYPwS0d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABn0z054KpqNI9vCA--.24501S2;
	Thu, 17 Sep 2026 02:30:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: a-bhatia1@ti.com
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	jyri.sarha@iki.fi,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tomi.valkeinen@ideasonboard.com,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tidss: Fix serial clock reference leak in tidss_oldi_init()
Date: Wed, 16 Sep 2026 18:29:50 +0000
Message-Id: <20260916182950.2092071-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn0z054KpqNI9vCA--.24501S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWUKw13Jr4rZw48urW5Awb_yoWDKrg_CF
	1UtF15Z34UAF1kKF17tF15ZryIy3ZxurZ5uwsFgFZ3t3s8ZryDWw4FvrykZr1xGFWkJFn3
	XayUJrn5Aw17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7VU1go2UUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUMA2qqpVh7DAACsF

The reference to the OLDI serial clock taken with
of_clk_get_by_name() is kept in the OLDI bridge structure for the
whole driver lifetime but is never released; neither the bridge
destruction nor tidss_oldi_deinit() drop it.  Release it when the
bridge is unregistered.

Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 17c535bfa057..bd151c83555d 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -450,6 +450,7 @@ void tidss_oldi_deinit(struct tidss_device *tidss)
 	for (int i = 0; i < tidss->num_oldis; i++) {
 		if (tidss->oldis[i]) {
 			drm_bridge_remove(&tidss->oldis[i]->bridge);
+			clk_put(tidss->oldis[i]->serial);
 			tidss->is_ext_vp_clk[tidss->oldis[i]->parent_vp] = false;
 			tidss->oldis[i] = NULL;
 		}
-- 
2.34.1

