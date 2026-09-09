Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF84A2A7C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964623; cv=none; b=jgCO0Y2DOJ9u7LeHIvuhtfyKn1Pd79CL/4LNfAJ2r8o3j2RrbdHuXbg6he2Q4P7rXgvDGMRzUBaEbEicB/55zT7y2V+E+zp8zFiaMIAv+G0hhc97gKe5CTTT6cA7a+qta0f3JWCMzG55Ep0Yn93WjC6qI3eUuyQzdXz5jvBaLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964623; c=relaxed/simple;
	bh=9IzQNyvfYNVhCl1F91KM7UiX/0AjxwxUQssNUM470hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbGuCSZdjtw2Vy7MSDmOxAa2fJFch9SYQSKSrQf5DfyoQDHRRCw6lGJwFu/HBbOuXb6Xsqw03IjeYfle11exQsrCUyyN6SD6WS7oKAwGTzq7/iCZvEgBDSf8QZxy8xwuZmgkwO4qj8DA9YDRaGaJUZ5IIIQVYRUynWRGaq6q8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nytQuJjj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nytQuJjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3ED1F00A3D;
	Wed,  9 Sep 2026 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964621;
	bh=5MtQFoiG7/80lK8W8HuQRN0xaUFrU+bo4Yy/09ogxqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nytQuJjj2Ew93pwcKBNchd9lYNpAslYxcAV6SLjCBPx8N1NZayg7DshDSXhnnHOB0
	 8p2rEs+V19GjPIjHXm9uPgWHxkGm8WKF0P+Govo7BqanmC2GcQCQcoPifzBAXjVGXq
	 V1yymRXxmvzIPQCxCJI/meabTzAzF4iTLS6vkLWncg96J8yN9fOO0YxSIPejEVR135
	 DEydTa/q2S3HI0b77JtXzhL4mOqsB8SnaXeuQmCVQGbnSR+BPH4tNgG4jPzvp4s+fp
	 /nZa9gEwvY0WzhTxN+JRqmGwvcxMrJKY2z6/7ThFP98nG/6yfVzZgIAev1Traa2cjz
	 +8uKMZT3Qra5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] platform/x86: ISST: Validate parameter for frequency and priority
Date: Wed,  9 Sep 2026 10:36:59 -0400
Message-ID: <20260909143659.2542083-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090329-hypnotic-unaware-0736@gregkh>
References: <2026090329-hypnotic-unaware-0736@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 574b59bb4b6bfcfd1f639d02f1041b314d43a2e6 ]

Validate range for frequency and proportional priority while setting
CLOS parameters.

Fixes: 12a7d2cb811d ("platform/x86: ISST: Add SST-CP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811221514.3905817-5-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ Adjusted insertion context for missing SST_MAX_CLOS and newer permission checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../x86/intel/speed_select_if/isst_tpmi_core.c       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index df0b0118b751f..938855464f909 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -497,6 +497,9 @@ static long isst_if_core_power_state(void __user *argp)
 #define SST_CLOS_CONFIG_MAX_START	16
 #define SST_CLOS_CONFIG_MAX_WIDTH	8
 
+#define SST_MAX_FREQ			0xff
+#define SST_CLOS_MAX_PRIORITY		0x0f
+
 static long isst_if_clos_param(void __user *argp)
 {
 	struct tpmi_per_power_domain_info *power_domain_info;
@@ -510,6 +513,15 @@ static long isst_if_clos_param(void __user *argp)
 		return -EINVAL;
 
 	if (clos_param.get_set) {
+		if (!in_range(clos_param.min_freq_mhz / SST_MUL_FACTOR_FREQ, 0, SST_MAX_FREQ + 1))
+			return -EINVAL;
+
+		if (!in_range(clos_param.max_freq_mhz / SST_MUL_FACTOR_FREQ, 0, SST_MAX_FREQ + 1))
+			return -EINVAL;
+
+		if (!in_range(clos_param.prop_prio, 0, SST_CLOS_MAX_PRIORITY + 1))
+			return -EINVAL;
+
 		_write_cp_info("clos.min_freq", clos_param.min_freq_mhz,
 			       (SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
 			       SST_CLOS_CONFIG_MIN_START, SST_CLOS_CONFIG_MIN_WIDTH,
-- 
2.53.0

