Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273F392819
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710218; cv=none; b=K1cHDKuOQyubwO5JFd88x8ILeSxCb2wbW6UnnSeKa5MHJli5ylVi3AMp+ujufSU6EODrnN4H/Caec0LInHaQjk4vZ0LvO9A8QYnC4orHhuewFi4oHrpiAPr8o1NHCvzZL8LssFAGk7lc1t0cM1bHAx1VpdoiuO811D80qZ+lM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710218; c=relaxed/simple;
	bh=1/ar3YvCdA5AOXZVtDPzc6oeVhjTam9RvP5ak1yBXLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ik9Z7ere6zSoDpr+TiQM242kkdC/D+oXQq52OFucPHVXmzaZ6zBIl8sfzT9VzIa/CufAX+sFqFEqWp2gJGkwA3EvrvufzvKQYN5Wv8lOgz/nfdffIDHL7WUi85gFVZU7qURWtQVPV0+gCQF6dhbHwFX4lWqSh9N3TWgM0BVqfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0JRHqOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0JRHqOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4772D1F00893;
	Tue, 29 Sep 2026 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710216;
	bh=z9vMhe6XA6lXFOKIBWzRCP4gZvTj+qMPw1DJoA5S168=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R0JRHqOgveD3plHQHNIRrk/V8NFlQatLX+fKfd5eJuXYAhQnX3g+yv4y8WMyjpa9G
	 aRgzDDlN6sMosuDj5KnWdz9RnW9vfqZmANFxkFD73KesaI2DDKUh+49QHEPDBviUar
	 uVXkrDBKh+5MP+CPBRd9c2TMRVYQjl2k7ch8iMYldS0FUjDYpqJbRfEogyBO27qTdO
	 7dx6vpwZOSJm7TiVi31oc9A5GbdjBBJekNOTi5rR2HS6SmrJL08buYm+xctFsS8rl1
	 gdqA005+4vu+ux2oAvqpaedanWaUMet4oIROF7Wy7WnHNPnYyK9CWRREA+qW67pcdp
	 mTJPljpkZfjkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] drm/amd/display: Relax DML frame limit with UBSAN
Date: Tue, 29 Sep 2026 15:30:14 -0400
Message-ID: <20260929193014.822619-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092933-finally-retired-eb54@gregkh>
References: <2026092933-finally-retired-eb54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 0fd5e9ddf362b1253b3c94b858371f90400e5c4a ]

[WHY]
UBSAN instrumentation adds checks and handler calls and increases
stack usage in the large DML calculation functions, similar to
KASAN and KCSAN. With UBSAN enabled these files exceed the default
-Wframe-larger-than limit and fail to build when -Werror is in effect.

Reproduced with LLVM (make LLVM=1, clang 19.1.1), CONFIG_UBSAN=y,
CONFIG_GCOV_PROFILE_ALL=y and CONFIG_DRM_AMDGPU_WERROR=y on x86_64.

[HOW]
Include CONFIG_UBSAN in the sanitizer check that selects the
higher per-file frame warning limit in the dml and dml2_0
Makefiles.

Suggested-by: Leo Li <sunpeng.li@amd.com>
Assisted-by: Copilot:Claude-Opus-5.5
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ebf8b0fd8508b744f85a8eee82b745b1d3502dd0)
Cc: stable@vger.kernel.org
[ Changed sanitizer checks to test for a nonempty filter result over space-separated configuration values. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile    | 2 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 10d4ace04d4f1..19fb18ec6be3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -29,7 +29,7 @@ dml_ccflags := $(CC_FLAGS_FPU)
 dml_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
-    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+    ifneq ($(filter y,$(CONFIG_KASAN) $(CONFIG_KCSAN) $(CONFIG_UBSAN)),)
         ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
             frame_warn_limit := 4096
         else
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 44e00c2b7ac79..5f6bde11c3ca2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -28,7 +28,7 @@ dml2_ccflags := $(CC_FLAGS_FPU)
 dml2_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
-    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+    ifneq ($(filter y,$(CONFIG_KASAN) $(CONFIG_KCSAN) $(CONFIG_UBSAN)),)
         ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
             frame_warn_limit := 4096
         else
-- 
2.53.0

