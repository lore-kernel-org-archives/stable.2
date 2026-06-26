Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF73F39EB;
	Fri, 26 Jun 2026 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477702; cv=none; b=UeJWo9/7pDID5PW/DqVBdsVr8MO4lJCg81vDo38uL+ztjgdXsoTJvgDrm9mD9vu0VtA0sGqJbpjXN21n7v9810O69OKoq9zrMZjakRUfiJvHC0KOHpjmjWE0U+msdrIBQfVqd+W7/IM/MvD6pqASPa5LFdOx7Em2EdqXXD87jhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477702; c=relaxed/simple;
	bh=Zb5N0CFIuzlNFQ/BZIRjVHgwyG1ejmJk3z8Rm5u09Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIMBJVHTUuZBYf2J90StwdE73MS5A0kXiI1/+Kw2joMwf2qHxJHM6f6GdnuLJh+qN1uoTVLgx1LpuSYZ68QxvWtdyKHbg8HjuwwRtqDBSH+Sr4YqAZwXSE20PI6zJbxPi8tVGqqZ65LxFwGRkMlCi/JvFAi/SDRMO3TsCB4AgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowADXI8d6cz5qWKRoFQ--.22937S2;
	Fri, 26 Jun 2026 20:41:31 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: siqueira@igalia.com,
	mario.limonciello@amd.com,
	alex.hung@amd.com,
	superm1@kernel.org,
	timur.kristof@gmail.com,
	ivan.lipski@amd.com,
	aurabindo.pillai@amd.com,
	chen-yu.chen@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drm/amd/display: dm_update_crtc_state: skip_modeset path leaves   new_stream dangling, causing double release
Date: Fri, 26 Jun 2026 20:41:28 +0800
Message-Id: <20260626124128.36625-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXI8d6cz5qWKRoFQ--.22937S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF47WFW7Kr1kGF17Xw48tFb_yoWkuFb_GF
	WUJr9xX3WayFs0qF12yrZ3urs2qFWYvFs7Gr17tFZ3try7JryUAry5Wrs5Wa1rCFnIgF98
	Za40g3W3AwsIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pR-189UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgKA2o+ThJwSwAAs+

The skip_modeset path calls dc_stream_release(new_stream) but does not
  set new_stream to NULL. If a subsequent error (e.g., color management
  failure) triggers goto fail, the fail label executes a second
  dc_stream_release on the same pointer, causing a use-after-free or excess
  put on the stream reference.

Cc: stable@vger.kernel.org
Fixes: 3ce51649cdf2 ("drm/amdgpu/display: add quirk handling for stutter mode")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5fc5d5608506..acf0b01d6f62 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11708,6 +11708,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	/* Release extra reference */
 	if (new_stream)
 		dc_stream_release(new_stream);
+	new_stream = NULL;
 
 	/*
 	 * We want to do dc stream updates that do not require a
-- 
2.39.5 (Apple Git-154)

