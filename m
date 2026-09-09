Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E557EDAD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963071; cv=none; b=S0SbyjqBM8qWxTC5XL/las3K3t1l+Bzbfor87W5In8NumTStzXUfkCSC/yGlNpuQTyUno4lmY/ned3DRVGSJt1HWIBNn4CWZqYi0SfUQFezh5SRonVXqKivYCi0c5zcUb6Idm+JdIdCvxV8LvJXUJd5ETeD5LSouWxJCWGjgHJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963071; c=relaxed/simple;
	bh=CWmxUvTyVXGXRGwb26WkqnIPws+4IHspQp2kkDUPfJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/GfspRju1W3Uf5+D1AHv5PnVNBxuoVDSB+sy1PpOc3pRrII/QyJVy4begCP47EwkjNCw1JjRrSk8/Gs/2O6izJwzhfqbTU/7KzRXMWDcb6HV51dzVR9fm2BZdGQvHF4URWOcswkvRekwc+29sKQPa0e4Si/PUQBPE0aRtxXtwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFVA76YO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFVA76YO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78A91F00A3F;
	Wed,  9 Sep 2026 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963069;
	bh=Su40MurkCpawXcgKuRwMSL+uagMKgif64Be7RW1LTWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PFVA76YO17g2XNytQwRy/RYar+u3Agvj1mrb/h0ieQu1CDu8UtFzMLXe5XgJc4vnG
	 oT6hwN1e9qkSNbX1cvhqcoV5xkxTnzcI6QsWmJHse4ClQ5yx77dgXqeo7nd9B2vl/f
	 r+BJGuKgXFNcLOgwrvN7Bq33bCmu/qcQHlnoo8Q17wOlI4mo4a1E27PHXIg9f5YBPo
	 dvatYD7WhZAJ6A0nqsn8EebFIdePfy/WnOqL5JKAnNfECoaFiSIupbD/CHnZFwc6W9
	 PNo7HM8LHW92s3dN6BxDIqfHivbl82S73jzVMX0IZ78KXoN+35xPEbyhBLr4k7qUhb
	 DugQ0hzKl1JVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/7] platform/x86: ISST: Shorten the assignments for power_domain_info
Date: Wed,  9 Sep 2026 10:11:01 -0400
Message-ID: <20260909141102.2383363-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141102.2383363-1-sashal@kernel.org>
References: <2026090334-lumber-underfoot-3bf9@gregkh>
 <20260909141102.2383363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit fe4211d21fee3672b251f9a535eaf0a0cf0b51e1 ]

Instead of long lines for assignment to tpmi_sst->power_domain_info, use
a local variable pd_info and assign later. Also move the assignment
of number of resources after the assignment of pd_info.

No functional change is expected.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240423204619.3946901-7-srinivas.pandruvada@linux.intel.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 3de2776e9d70 ("platform/x86: ISST: Add a NULL check for sst_inst[]")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 33 +++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index c41c9a6fe3378..b6cd0ab38a7ec 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1267,6 +1267,7 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 
 int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 {
+	struct tpmi_per_power_domain_info *pd_info;
 	bool read_blocked = 0, write_blocked = 0;
 	struct intel_tpmi_plat_info *plat_info;
 	struct device *dev = &auxdev->dev;
@@ -1307,35 +1308,31 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 	if (!tpmi_sst)
 		return -ENOMEM;
 
-	tpmi_sst->power_domain_info = devm_kcalloc(dev, num_resources,
-						   sizeof(*tpmi_sst->power_domain_info),
-						   GFP_KERNEL);
-	if (!tpmi_sst->power_domain_info)
+	pd_info = devm_kcalloc(dev, num_resources, sizeof(*pd_info), GFP_KERNEL);
+	if (!pd_info)
 		return -ENOMEM;
 
-	tpmi_sst->number_of_power_domains = num_resources;
-
 	for (i = 0; i < num_resources; ++i) {
 		struct resource *res;
 
 		res = tpmi_get_resource_at_index(auxdev, i);
 		if (!res) {
-			tpmi_sst->power_domain_info[i].sst_base = NULL;
+			pd_info[i].sst_base = NULL;
 			continue;
 		}
 
-		tpmi_sst->power_domain_info[i].package_id = pkg;
-		tpmi_sst->power_domain_info[i].power_domain_id = i;
-		tpmi_sst->power_domain_info[i].auxdev = auxdev;
-		tpmi_sst->power_domain_info[i].write_blocked = write_blocked;
-		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
-			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);
+		pd_info[i].package_id = pkg;
+		pd_info[i].power_domain_id = i;
+		pd_info[i].auxdev = auxdev;
+		pd_info[i].write_blocked = write_blocked;
+		pd_info[i].sst_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(pd_info[i].sst_base))
+			return PTR_ERR(pd_info[i].sst_base);
 
-		ret = sst_main(auxdev, &tpmi_sst->power_domain_info[i]);
+		ret = sst_main(auxdev, &pd_info[i]);
 		if (ret) {
-			devm_iounmap(dev, tpmi_sst->power_domain_info[i].sst_base);
-			tpmi_sst->power_domain_info[i].sst_base =  NULL;
+			devm_iounmap(dev, pd_info[i].sst_base);
+			pd_info[i].sst_base = NULL;
 			continue;
 		}
 
@@ -1346,6 +1343,8 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		return -ENODEV;
 
 	tpmi_sst->package_id = pkg;
+	tpmi_sst->power_domain_info = pd_info;
+	tpmi_sst->number_of_power_domains = num_resources;
 	auxiliary_set_drvdata(auxdev, tpmi_sst);
 
 	mutex_lock(&isst_tpmi_dev_lock);
-- 
2.53.0

