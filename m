Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD88346782;
	Sun, 14 Jun 2026 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781447044; cv=none; b=SrqQKo4VTEZicvMbVWnqP7iiY1JhYYo/kufVaIg67iGPANH6VjUQC1xoB3uI2eaCN5mHxDiqsGtb6sEeXZgkEBkCi2usB8IxGF8A8zh01gqBauy9AaujXWN9mQn1M22wYD7NU5h+KtrHSv9Di5oUEPhHRo0achB028QPZtz3PaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781447044; c=relaxed/simple;
	bh=7kgmIlPkBCuUPC9DEsqgfh5j3g1olgLsvZbKsJ5mzn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFRFjr+E7zbuDY5Ei9yEGBtbzbabX3dCrPhmXTaMh0MOrk0ZYN9xLwHjnDr0ajI8moLL49ksZAs94+P0+JmthIojtNeUWOVzaE9nPiqtebDw8IelKk6rizfNAxaCwlEZuekB6ASr4NhPGGyatAi22LVd+N55P+aT13a3aWtl9yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aa7BqSPW; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aa7BqSPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kA
	dOHfVqDF74w3XFEUTLT8kIauibT8ourgUuTIUthpI=; b=aa7BqSPWBx+ZsHbuj9
	6Wu9SQatN3VxQpQ3q5QN/229UPfEDZrGX+fHr+RseAJaL93yhtdIDNnGquBwFSJK
	y5+Xq0JGTx650zr8OwMFOucCbJRzmF3zkIvmtn68ZNcaVZoiMbm+sJoRclLfrw2S
	gT2Pshk+6puKmMsEDbwAumDaM=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDH1uI8uS5q3zRWDg--.41766S4;
	Sun, 14 Jun 2026 22:22:56 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	hansg@kernel.org,
	vivek.kasireddy@intel.com,
	matthew.d.roper@intel.com
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/dsi: fix i2c adapter reference leak in i2c_adapter_lookup()
Date: Sun, 14 Jun 2026 22:22:49 +0800
Message-ID: <20260614142250.2001136-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH1uI8uS5q3zRWDg--.41766S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4Dtr1xJw15Gw13Jw13Arb_yoW8JFW8pr
	W7WFWUCrWYqF92q3y7AF1UuFW7uayIy3s3KFZ7Cw13uF1kuw18Jr9YyrW2gFyDWa9rXa1D
	trnrJ3yUKFyjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMc_-DUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC1ACkr2ouuUArbQAA3k

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

