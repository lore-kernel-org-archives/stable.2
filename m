Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D04C33F9;
	Wed, 16 Sep 2026 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580280; cv=none; b=sYjlNzyD3R/CeI8wcnPQV/MYSlnVrioIDou7fCBKFnwhDAtqBK+UllUHKwB5QoksiqbBMN8+o+b5x81tb0RABD3zgdEssGlRPYrEZuXi8ZuXiVMkA0FlWQn4UV65G2r7HH9xSXbGg7TdTcAxG1vAZWmKyCjQkfN3KpOBnS2P0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580280; c=relaxed/simple;
	bh=tRrBB94Ac1vBCVngbQmmsX/+qgVZH0H6u3dnhVrD+1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pXlixvHD8Q2Os1UOUPIOZDw8bloDcgkz1sLcmH6/oRvMvviB4dHHiYIO6nv0FrgSTEr0DPX6REBKY60fhDJ9H9jALF40456vDadosFebidAQ6lsFAlEdCtLJjBjQa/zMGtuutKOwzklsokncPsDEWzHcIIIavYYMGD0LHJ0tEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHcz3r06pqir9uCA--.23200S2;
	Thu, 17 Sep 2026 01:37:47 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: changbin.du@intel.com,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	rodrigo.vivi@intel.com,
	simona@ffwll.ch,
	tursulin@ursulin.net,
	zhenyuw.linux@gmail.com,
	zhi.wang.linux@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gvt: Fix mm reference leak in handle_g2v_notification()
Date: Wed, 16 Sep 2026 17:37:20 +0000
Message-Id: <20260916173720.2088455-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHcz3r06pqir9uCA--.23200S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWDur4xZF4DAFWxtw13Jwb_yoW8Ww4rp3
	98WryYyFZ8AF4IvFW3C3Wjv3Wav3WIgFWfCrZrG3s0g3ZIya4Utr1Fv34UtFyUArZ3GF1a
	qr45GFW5Cw42v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJV
	WxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU1go2UUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUMA2qqozVvFAAAs+

intel_vgpu_get_ppgtt_mm() returns a reference the caller must drop, but
the PPGTT page table create path only inspected the result. A page
table that is already tracked gained an extra reference which nothing
would ever drop. Skip the lookup-get for an already registered mm; a
newly created mm keeps its initial registration reference.

Fixes: e6e9c46fd235 ("drm/i915/gvt: Factor out intel_vgpu_{get, put}_ppgtt_mm interface")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gvt/handlers.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index a34f56630af9..3d7aae6c5cf1 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -1506,7 +1506,17 @@ static int handle_g2v_notification(struct intel_vgpu *vgpu, int notification)
 		root_entry_type = GTT_TYPE_PPGTT_ROOT_L3_ENTRY;
 		fallthrough;
 	case VGT_G2V_PPGTT_L4_PAGE_TABLE_CREATE:
-		mm = intel_vgpu_get_ppgtt_mm(vgpu, root_entry_type, pdps);
+		/*
+		 * A newly created mm keeps its initial reference as the
+		 * registration reference, dropped by the DESTROY
+		 * notification. A duplicate CREATE for an already tracked
+		 * mm must not take an extra reference that nothing drops.
+		 */
+		mm = intel_vgpu_find_ppgtt_mm(vgpu, pdps);
+		if (mm)
+			return 0;
+
+		mm = intel_vgpu_create_ppgtt_mm(vgpu, root_entry_type, pdps);
 		return PTR_ERR_OR_ZERO(mm);
 	case VGT_G2V_PPGTT_L3_PAGE_TABLE_DESTROY:
 	case VGT_G2V_PPGTT_L4_PAGE_TABLE_DESTROY:
-- 
2.34.1

