Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FEC480961
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447967; cv=none; b=PjaWvUUGcfZwcMJ4sThEnJAsavQ1nVkqEzlh5MKsSgXFin+UwWfs/sz9hIIGTks/FTfwVQZpcm+dxOxWVy6dX1/easuaGW/I32g5UI9745qsmFiPloQe1i8FVlEHT5+oOIDq4fzOkxvMEsrgiGgtylWffBQsOvDrsL9TUZ9lrQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447967; c=relaxed/simple;
	bh=Rm7CrCk688Qwm5dWuVW+Tl0KmhE5vvB0+zbkpZ8Enrk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lyijJgurEP85SEv270pT7gqmCMMU8gmYtSeGEdYWvPUjgxqGgqUfdv2pDrzzrcUGLxF28WTwspMOi0/FzeOOX/4mRm1VdeAxSEAliZMQyHuzlm2aH8+52zRbe3P6fLRSH7p1jzjHt19DqxzSXweHwvC8njCTCqhJO5suWvf3KIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gMdnkrZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gMdnkrZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1B61F000E9;
	Thu,  3 Sep 2026 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447966;
	bh=Dxq1YKaNgf4/h15QOVmhCcSYdVW692Jo4x/Rt5rewgw=;
	h=Subject:To:Cc:From:Date;
	b=gMdnkrZbbt6QGlaHevqu2pdxGPwEH2OEDlfGjTaoIR4w8UnTfbnaNt6N8PxdVfLVY
	 ysTJMGoswB2+xR1yRl+Ps2a28bXJTIJbZkmIUmCqdpOgcBZ3fAigaHoFinmGHLArp1
	 t3qTKL5XvJf3gel5ZS8bFh4sloe0r4GtYEkWY7PY=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Return error during profile addition" failed to apply to 6.6-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com,sammiee5311@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:48:39 +0200
Message-ID: <2026090339-boxcar-confused-152e@gregkh>
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
git cherry-pick -x f9a647cb8d90c09633a49a1e766e140e78012444
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090339-boxcar-confused-152e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f9a647cb8d90c09633a49a1e766e140e78012444 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Tue, 11 Aug 2026 15:21:33 -0700
Subject: [PATCH] platform/x86: ISST: Return error during profile addition
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 92d420e706f6..a50e3aa8c4d2 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -339,7 +339,7 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 	if (!pd_info->perf_levels) {
 		pd_info->pp_header.allowed_level_mask = 0;
 		pd_info->pp_header.level_en_mask = 0;
-		return 0;
+		return -ENOMEM;
 	}
 
 	pd_info->ratio_unit = pd_info->pp_header.ratio_unit;
@@ -370,7 +370,7 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domain_info *pd_info)
 {
 	struct device *dev = &auxdev->dev;
-	int i, mask, levels;
+	int i, ret, mask, levels;
 
 	*((u64 *)&pd_info->sst_header) = readq(pd_info->sst_base);
 	pd_info->sst_header.cp_offset *= 8;
@@ -402,8 +402,12 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
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

