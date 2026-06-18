Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49E3B2FED;
	Thu, 18 Jun 2026 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780754; cv=none; b=nnH15z3w2wGLn+5kWVz5TlBQSp9kZdeo+hIAskszY38MtZQE9jjYD4mfbmpP634bUiXfo6+cd2DXHQ8TLQKyqW30YGeFbk2lmOgkt4GuX8srbZWScrqj1dEjFMJFawXon6Y2dMPqeoIcgacIGR/V3AdZuWRm86Ptd1FqTtlv10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780754; c=relaxed/simple;
	bh=6wXnEDck6P59SvTHVD9C7VlKsJ5sdP/VHcUX+2+6JY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axY2MOwOK23FvzF4ingDPFVaXq2gB7o1lkFTkgAxHCM7kNxUu56g2aJTAs7iz+7oXp1dg6tBiCE9YiZQO13Y4ZW3ClsEFGwvaa9C5VENLYLJces8CLUD87P6DigllVvliNdLnM3K2ZI3s//4E66MN4GpeHb0PWSPIZvqW2txlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aJg/Ih3P; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aJg/Ih3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gg
	0v4mNICq66S4WjgqT9Dzd0uw6VSyp4kHXR3khbLzk=; b=aJg/Ih3Pa18N/nWZAx
	0s0iTZ8+bJH/bXNherApom2TT970bn8Mc/2T5lUn6Puhq7whiEWqvwEx20gc3tH3
	YyBF7i5aEVIOH7yTb98JbgSPaIHW0V/zNmeQZsegbeX66vXYqkTG+hml+sWmlr5U
	Hk4LrbgMy0kUlVj+kcLVVqaHo=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3t77P0DNqfkKHEA--.18129S4;
	Thu, 18 Jun 2026 19:04:53 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	hansg@kernel.org,
	matthew.d.roper@intel.com,
	vivek.kasireddy@intel.com
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/i915/dsi: fix i2c adapter reference leak in i2c_adapter_lookup()
Date: Thu, 18 Jun 2026 19:04:46 +0800
Message-ID: <20260618110446.518501-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t77P0DNqfkKHEA--.18129S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4Dtr1xJw15Gw13Jw13Arb_yoW8Gry7pr
	ZrWF4UCrWYqF9aqay7AF1UuFW7uayIy34rKFZ7Cw13u3Wkuw18JryFyrW0gFyDWa9rXa1D
	tFnrJ3yUKFyjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pES_MPUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9RXQ22oz0NWmMQAA3g

i2c_adapter_lookup() acquires a reference on the i2c adapter through
i2c_acpi_find_adapter_by_handle() but not releases it.  Each
invocation of this ACPI resource callback leaks one device reference,
potentially leading to resource exhaustion over repeated driver
load/unload cycles.

Calling path: i2c_acpi_find_adapter_by_handle() -> bus_find_device()
-> get_device.

Found by code review.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Cc: stable@vger.kernel.org
Fixes: 8cbf89db2941 ("drm/i915/dsi: Parse the I2C element from the VBT MIPI sequence block (v3)")
---
Changes in v2:
- Changed email to trigger CI, no code change.
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index fe12041e913c..2097c5d17cb7 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -460,8 +460,10 @@ static int i2c_adapter_lookup(struct acpi_resource *ares, void *data)
 		return 1;
 
 	adapter = i2c_acpi_find_adapter_by_handle(adapter_handle);
-	if (adapter)
+	if (adapter) {
 		intel_dsi->i2c_bus_num = adapter->nr;
+		put_device(&adapter->dev);
+	}
 
 	return 1;
 }
-- 
2.43.0

