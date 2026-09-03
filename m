Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF654C77A8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447950; cv=none; b=ofXrj7tLjl9aFxZpQjjvcALi7LAuKI+pU+DbeeR9jZUtu1mD5PZiW21JLGz2ltonyEqzeGRrFBXGQFzBaRVaIvjIR+j51ddMiV/PqiFY7K+uDBNw5u6tIl6uNkmw07MQ8eVXEkMMr5TABxllvbiYV4gqs899hCgc++LrGfDQLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447950; c=relaxed/simple;
	bh=f4R3VyiKBZc00ZE8E0QBStzCJO2QgcpqHZBNZCfPAdY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E49ostqLURWsEHZoGgArSk7Ui/3sOPcuBw4D2Te+x3g8Z5quy2VnGj46ZAujHc25/rpYykAXVQCzbwfNGkMwNtGyqEp9OlctQedfIYWEATc6QyZQ7JMEn/tlfqHMZ7cob6hkp6UkEi5dFRMzIMSFel7vxUaLtu0aDDb0W/ffCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M9rjPvpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M9rjPvpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013F31F000E9;
	Thu,  3 Sep 2026 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447949;
	bh=aT6yc8fbSuFJBLv1z49+hwyYUFd0o6tKIaRDkFXCbBo=;
	h=Subject:To:Cc:From:Date;
	b=M9rjPvpA6SPiDCzF6iXiW8QR2SH8hkfn90N7aAcPaAW7SUslXuxQXbTNSNxR9D+Ah
	 w1mY3UEJN/Y5wj/MnBwT3Ru+34A/Fz3wHRFlZ6F+HtweSKZd8UOEw8iXf0L9EsFcPJ
	 Y0PHneLwPbS7cGfv9R2zdeHGTDNnjkewhXcyhc9U=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Use PP level enable mask" failed to apply to 6.6-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:47:55 +0200
Message-ID: <2026090355-unicorn-work-b00a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9b9026943b19d06ebf520b1f4786621947cf43c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090355-unicorn-work-b00a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b9026943b19d06ebf520b1f4786621947cf43c8 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Tue, 11 Aug 2026 15:15:13 -0700
Subject: [PATCH] platform/x86: ISST: Use PP level enable mask
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add check for enabled levels only when reading MMIO. Some levels can be
disabled by BIOS. If the level is not enabled, return an error.

Reset the enable and allowed level masks if there is a failure to add a
perf level.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811221514.3905817-6-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index ee2e1ec1b103..f1b35714a4e9 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -336,8 +336,11 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 	int i;
 
 	pd_info->perf_levels = devm_kcalloc(dev, levels, sizeof(struct perf_level), GFP_KERNEL);
-	if (!pd_info->perf_levels)
+	if (!pd_info->perf_levels) {
+		pd_info->pp_header.allowed_level_mask = 0;
+		pd_info->pp_header.level_en_mask = 0;
 		return 0;
+	}
 
 	pd_info->ratio_unit = pd_info->pp_header.ratio_unit;
 	pd_info->avx_levels = SST_MAX_AVX_LEVELS;
@@ -911,7 +914,7 @@ static int isst_if_get_perf_level(void __user *argp)
 		      SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH, SST_MUL_FACTOR_NONE)
 	perf_level.enabled = !!(power_domain_info->sst_header.cap_mask & BIT(1));
 
-	level_mask = perf_level.level_mask;
+	level_mask = perf_level.level_mask & power_domain_info->pp_header.level_en_mask;
 	perf_level.sst_bf_support = 0;
 	for_each_set_bit(level, &level_mask, BITS_PER_BYTE) {
 		/*
@@ -1349,6 +1352,9 @@ static int isst_if_get_base_freq_info(void __user *argp)
 	if (base_freq.level > power_domain_info->max_level)
 		return -EINVAL;
 
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(base_freq.level)))
+		return -EINVAL;
+
 	_read_bf_level_info("p1_high", base_freq.high_base_freq_mhz, base_freq.level,
 			    SST_BF_INFO_0_OFFSET, SST_BF_P1_HIGH_START, SST_BF_P1_HIGH_WIDTH,
 			    SST_MUL_FACTOR_FREQ)
@@ -1388,6 +1394,9 @@ static int isst_if_get_base_freq_mask(void __user *argp)
 	if (cpumask.level > power_domain_info->max_level)
 		return -EINVAL;
 
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(cpumask.level)))
+		return -EINVAL;
+
 	_read_bf_level_info("BF-cpumask", mask, cpumask.level, SST_BF_INFO_1_OFFSET,
 			    P1_HI_CORE_MASK_START, P1_HI_CORE_MASK_WIDTH,
 			    SST_MUL_FACTOR_NONE)
@@ -1483,6 +1492,9 @@ static int isst_if_get_turbo_freq_info(void __user *argp)
 	if (turbo_freq.level > power_domain_info->max_level)
 		return -EINVAL;
 
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(turbo_freq.level)))
+		return -EINVAL;
+
 	turbo_freq.max_buckets = TRL_MAX_BUCKETS;
 	turbo_freq.max_trl_levels = TRL_MAX_LEVELS;
 	turbo_freq.max_clip_freqs = SST_TF_MAX_LP_CLIP_RATIOS;

