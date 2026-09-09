Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D3566C71
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965909; cv=none; b=LFKkPJPMTSZW1mQaizwOHY39/jdvV6PkJBESAK1hpD8EKd1SxSnV0UFBaq5Sv4Fl6eZSY0IVpVtFG0lEA+0gtmNBJeSUbD2FFq3jHNTlH/BtZaMpdj1OIIAAaPaeEc/SD6AY5jcb+eRM5QwePfhuHdIkIVXUXnnmjI5diGfKujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965909; c=relaxed/simple;
	bh=3EW1rmzTvXNJtlWcor9Tbr5/G22k46713b/zUvo3ezE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meQyQMhqPrKL/y9U29zuyzPPX5l8Liyck5jyM81ttIqRJfJwhPaIATAeNPFEIf0R9tlIbELHtMD/tX9QUiXNJ6ZljP7wpEEcw/qaLnIG4pCf7FkRUvZjXoZu6gwgGjp7hX62jnFhz4aYWIpNsx4O1KngQKBJCzuhwJ9IKNFNldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwDMO1Q+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwDMO1Q+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8CB1F00ACA;
	Wed,  9 Sep 2026 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965908;
	bh=Ov3QjG2AIis2xCxTZF7KdFmRgU/kt+sIXsN61NtH/bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NwDMO1Q+rGdiooAkXgEeB51zVc1kB0QcHQA+UNV6Ncem/ZyG/6Lj/b7iaK7qUD77A
	 3xTBQC/v9KU2aR+PstT/I92QMq492+hQJKTlYS/nfNI6RlBiZ4B6u4mpCH6qf5/HWN
	 dUkCLT0eDtFWB4CeSyKoJsOiYFibu9XABocbX44yjKXFCMFW2v9r+emqNlktHfPEhf
	 QiZGboRQ+w8GDeZRtD2+X4KlArZceEJWCBYGmYnrD12aN2WH5Qpnm2z53bxj1nGVxZ
	 pikidwjS8zmQBnKZ+YbriGk49KcddaH+PIvGiL7Pz0L6B7+bKotS0Ca9hEaNPbvWGl
	 hNE24q9KcuBaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: HyeongJun An <sammiee5311@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] platform/x86: ISST: Validate level in perf mask ioctls
Date: Wed,  9 Sep 2026 10:58:20 -0400
Message-ID: <20260909145822.2742457-5-sashal@kernel.org>
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

From: HyeongJun An <sammiee5311@gmail.com>

[ Upstream commit 80e0d353c86a9a168ad6d213f494796294381538 ]

isst_if_get_perf_level_mask() and isst_if_get_base_freq_mask() use the
user-provided level as an index into perf_levels[] via
_read_pp_level_info() and _read_bf_level_info(), but neither helper
validates it first.

The adjacent level-info helpers reject levels above max_level before
reading the same per-level register block. Add the same bounds checks to
the mask helpers, and reject disabled SST-PP levels in
isst_if_get_perf_level_mask() to match isst_if_get_perf_level_info().

This prevents out-of-bounds reads from the per-level offset table on
invalid ioctl input.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Fixes: 06a61df83209 ("platform/x86: ISST: Add SST-BF support via TPMI")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260807144003.3498972-3-sammiee5311@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: f9a647cb8d90 ("platform/x86: ISST: Return error during profile addition")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/x86/intel/speed_select_if/isst_tpmi_core.c  | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index a73d425cf0410..1220ce4e3b970 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1029,6 +1029,12 @@ static int isst_if_get_perf_level_mask(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (cpumask.level > power_domain_info->max_level)
+		return -EINVAL;
+
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(cpumask.level)))
+		return -EINVAL;
+
 	_read_pp_level_info("mask", mask, cpumask.level, SST_PP_INFO_2_OFFSET,
 			    SST_PP_RSLVD_CORE_MASK_START, SST_PP_RSLVD_CORE_MASK_WIDTH,
 			    SST_MUL_FACTOR_NONE)
@@ -1110,6 +1116,9 @@ static int isst_if_get_base_freq_mask(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (cpumask.level > power_domain_info->max_level)
+		return -EINVAL;
+
 	_read_bf_level_info("BF-cpumask", mask, cpumask.level, SST_BF_INFO_1_OFFSET,
 			    P1_HI_CORE_MASK_START, P1_HI_CORE_MASK_WIDTH,
 			    SST_MUL_FACTOR_NONE)
-- 
2.53.0

