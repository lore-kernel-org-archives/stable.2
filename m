Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C0583AAE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965913; cv=none; b=Wzhz3g4XwDEat4SxywpqUK2DJidLqQ7njzQUuSBw/+XcUCJ7NrXklGoWubpsNTogA2xxsmLt2hesK3Aii+F4CN4HPmxhl1IHz6ocuzbdZemLcsrHsebpeDPKnlz+QH8a4VWks+QDFDtlxiR3iVQbOHTkDVvESyOUad/yXxP1Qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965913; c=relaxed/simple;
	bh=OPfSlJb3/ATIi/7vP6LkoSpie/yZ1wjMWvKsRrwTqp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPv2YCs5zM2odEsx8wJsVZ9bKB076MBMJbwcyks3nIFoVcKiMH8M6jStJOEPA1UOmX1fo/I8t+JAxHjRc3IWfG+J4f2bgfcD10ToNEs8aNru6G44Cp7xCY6OdnQhBlcwxT7T19S9c+fuTkfZz15kWaXrMli6mT0kODrmkYOBddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbZFI2V5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbZFI2V5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127581F00AC4;
	Wed,  9 Sep 2026 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965909;
	bh=Coqq2essDpYpCESEhRJJ5u3o/qDcSN2EpNLLeYE6w6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GbZFI2V5sv540xN18nZIJAizDSyi67CpqfCASapc1l9f8cFCgCoyaiF+b2MrKmaN3
	 jg3gP5l+vm5QF+EIK5fxT5llHxlV683pmJWXKn6lDwj70r8ZUDfDuTRAu8fbaN8uGx
	 QnJc2tjiAVIG/9AX1L60sBTlSCvX5FleVyz25IJhK8i7aneQ9NAsjbK2GwrR5KeG7B
	 OUZT6s+hKaY8434CA2HLQMGuL6bf8V+EM6co95roZf3gpwnpnNkoJGWbyZkO466L4f
	 PRqwrh7i3UFu4/i4k/fO1pHk0Mr4OztPcLqYu+ZbE2RbOMBZ0eWrXlWEZNshLFV94x
	 PvDUyMSkI21iA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	HyeongJun An <sammiee5311@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/7] platform/x86: ISST: Return error during profile addition
Date: Wed,  9 Sep 2026 10:58:22 -0400
Message-ID: <20260909145822.2742457-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909145822.2742457-1-sashal@kernel.org>
References: <2026090339-boxcar-confused-152e@gregkh>
 <20260909145822.2742457-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit f9a647cb8d90c09633a49a1e766e140e78012444 ]

If sst_add_perf_profiles() fails for memory allocation, it continues
to allow SST-CP (core-power) feature. But in practice this is not
very useful as to achieve some frequencies via SST-CP, an SST-PP
(perf-profile) level change is required.

Fixes: 0ab147bb840f ("platform/x86: ISST: Parse SST MMIO and update instance")
Cc: HyeongJun An <sammiee5311@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811222134.3912626-2-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../x86/intel/speed_select_if/isst_tpmi_core.c         | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 8382974f31027..a0c6c66b8442a 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -321,7 +321,7 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 	if (!pd_info->perf_levels) {
 		pd_info->pp_header.allowed_level_mask = 0;
 		pd_info->pp_header.level_en_mask = 0;
-		return 0;
+		return -ENOMEM;
 	}
 
 	pd_info->ratio_unit = pd_info->pp_header.ratio_unit;
@@ -352,7 +352,7 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domain_info *pd_info)
 {
 	struct device *dev = &auxdev->dev;
-	int i, mask, levels;
+	int i, ret, mask, levels;
 
 	*((u64 *)&pd_info->sst_header) = readq(pd_info->sst_base);
 	pd_info->sst_header.cp_offset *= 8;
@@ -387,8 +387,12 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
 			levels = i;
 		mask <<= 1;
 	}
+
+	ret = sst_add_perf_profiles(auxdev, pd_info, levels + 1);
+	if (ret)
+		return ret;
+
 	pd_info->max_level = levels;
-	sst_add_perf_profiles(auxdev, pd_info, levels + 1);
 
 	return 0;
 }
-- 
2.53.0

