Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC44AA413
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148573; cv=none; b=oNqzYZVjyfmkJ+KI3J15OyjsTU8Rpg4XFdH6xmZ+SpaT7Vxpq6GtAXsIvz2YcGZW4ghp9g4Z6Z5I5PpG5GRw1NweP99jDokoyzEjBndUOTeYLr6RlQutBdCqRMRIkEr3XZa3Olf3yc79XAXwknRldqQClT5sldm1g7NUAhCVN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148573; c=relaxed/simple;
	bh=mhnhhQHH4HCzMCITNUkkHbajc5WlsU42xm2VIkHSFMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meaJZbIwN97INcO1duip2CTCfxZZiIuQe+jI9WaGn4Wq98Gsft+gI6AZY+DRXWUuzYyisPee2txXk1p1RAYYLfRkcsFwM1H+l7UPNE3LPcW6DeuuLDrW/9h41P0BiAvj4Ilr0OAqdUOlhssDTqi+lZTF4bYdKSDHrhjR9orXuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k07tJGjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k07tJGjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668B21F000FF;
	Fri, 11 Sep 2026 17:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789148572;
	bh=68vGRvPvQQ9Zh1f0ks3sR5aS/V0TgHVERiMGrBKPGhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k07tJGjD638ZEwgbsJqxKWX5FpYJHLnejKoAWnefMW8E85uSfoxmfxri9O/CnHwWH
	 S8oMyw0WKstJVuK+7uL9HP2u/DIhCnrn6j+sOErhbE+DBRgAk52nOmG4tGXq4xnuWn
	 TmDWZ90Znrt+bJD8KuY6N/ULq5DKGdmZ7UR8D3UC5SA9pn/Ieza13gL3LNyhvF2bxb
	 vO7DisLB/MbMNe1igq1aPqx+GgcT6ubeWz7oltAm9aim6iMeCBscabCDEAYWg5UwEj
	 9iEVoY0v4uCiHqTpjWkU+V4e0W77ZcrVIUx/3jxiR1/VrsjDNs1vrCUxYgWoGs/daw
	 rQubZL5iYrTAw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: stable@vger.kernel.org
Cc: Roman Li <Roman.Li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
Date: Fri, 11 Sep 2026 12:42:47 -0500
Message-ID: <20260911174247.2973758-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090953-attire-untidy-c602@gregkh>
References: <2026090953-attire-untidy-c602@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Li <Roman.Li@amd.com>

[WHY]
Splash screen corruption on some 8K monitors.

[HOW]
Set GPUVM min page size to 4K for DCN35/36 to use the correct DML2
calculations, avoiding the corruption path observed during splash.

Fixes: 115009d11ccf ("drm/amd/display: Add DCN35 DML2 support")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 2cbfb03dead5088a7bdfe2ce392a5caa3d1b3719)
Cc: stable@vger.kernel.org
(cherry picked from commit 9ce3169430f1db035d491481086e2fae2552569c)
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 3b866e876bf4d..9fea55fddded4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -299,6 +299,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
 		out->pct_ideal_dram_bw_after_urgent_pixel_only = 65.0;
+		out->gpuvm_min_page_size_kbytes = 4;
 		break;
 
 	case dml_project_dcn401:
-- 
2.53.0

