Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59332A3DA
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789223239; cv=none; b=RTc+FRf8IZvPU6S5JV08C0ekGIbGJZAgGVYgYPSTxosrkSjQQWgf9lBZh5Hc1xcgCb+FV4vMBmEpSJTZF+xx6xx9yfUki1jI+B3fogKzKpmMMz/8Ey62CmkRPgOcRkD1x6OF7AYMUGgHzFf082pBRNF1XMkkrux6mYOlennN5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789223239; c=relaxed/simple;
	bh=qlkYq+12dyWRXmnuSd7He3oRSe5LHuGyvwUXOMs7rr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WENB0LLbQlxCVyKnJu9lsYhvyNnGA+qm9Afpg6uRe5TmCIvKGlMze7u9vYrgLyb+HHfWm68/Xt+8zjDUL6rQ7vzDUrcN+s106yPkPfbCxuv/XqwVHu+hUFCticAkp1Kgioyo3INFME0mqdMsIkm/y81ET4gxjt0mIyKmkXZMKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIbIGsDZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIbIGsDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC401F000FF;
	Sat, 12 Sep 2026 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789223237;
	bh=KbZ/kkLNyFZjNQlRirInt6CntEhhIOIL0UlFyxXakKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eIbIGsDZz5Lc9T0+dDy6zwphiqWek61+qtwYw57jegX+V6X0gpBdIyjSfuG06j5q8
	 7mSATiQcwB3gER23fWIcBo8OQ7Cy9fCQlo8gqF3YKar3zLpzJHE+fk5UDfTiqUGIe7
	 Ta5apovVtXJY/aa8QUN8We6oTWZ22hs72cpsrOxANKbWeG+MqBckRCYUEH4x1/++Bb
	 6I+j2WtaapIvhrw0CxC/QwpvYj6O3Mv1QgJ9gPtNj+y3hySpAQOE0KHNo/M9iBVEwK
	 eYDZpTV9Jj/GTyNlJ1Z9/1BiZHclucrVoRceqOwVR+dOO2AD0rrgtjazZCbVWhhEil
	 e37IqntRjaqnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Roman Li <Roman.Li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
Date: Sat, 12 Sep 2026 10:27:15 -0400
Message-ID: <20260912142715.2937882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090953-snowshoe-unlovely-1c25@gregkh>
References: <2026090953-snowshoe-unlovely-1c25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Li <Roman.Li@amd.com>

[ Upstream commit 9ce3169430f1db035d491481086e2fae2552569c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index c768306ca69e8..0118b398044da 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -297,6 +297,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
 		out->pct_ideal_dram_bw_after_urgent_pixel_only = 65.0;
+		out->gpuvm_min_page_size_kbytes = 4;
 		break;
 
 	case dml_project_dcn401:
-- 
2.53.0

