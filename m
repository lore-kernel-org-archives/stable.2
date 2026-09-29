Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E614746BB
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671120; cv=none; b=pidz14wmEDhj4e/HbWHbqtFG9ZXfrqoE6iNrMSvwbQu+MtE4adIuUxgELEMHMcs9wpTdeVNzdXha0Zsmaw3PIW5CGcpSrXTPUkjQ4NxYkus27/RqM0AcE7WEakks2OTWiBMBRGETtog1I9I7huOp6IAt49rmyvoxHRw42pjpiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671120; c=relaxed/simple;
	bh=nfzVxh6bsG5YW2inbxE0qnNs8g+fwsRQUa3CtDNetkI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C+LR6/D1t3azQqjJ9yI/f+buljzBmW3wJyu4b1vGxKX5/DXgiMw5E0ptqMAFASS7BHyFDkrZuP77ibWMrn6XGuu0CuDTXOh5aRRHv/h0AiuDs/K8nDCHZd2LilEVbagx7rHlK57GXbNk1d/zB/kxuAE+Zz1p767NSw86NeKvGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=odO7ZL1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="odO7ZL1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842491F00893;
	Tue, 29 Sep 2026 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790671119;
	bh=NuPU03yGxnfbNWtQ5ROo9WuxGxiH25c63dOoHmyQDNM=;
	h=Subject:To:Cc:From:Date;
	b=odO7ZL1CdwPKktG3uF9zm5J9/kieezJYkxo1e8M4vcExUsDXWHmuQEjlyfEf0jK4G
	 PN2+BD7LiDH3hbLhjwRLUgf/FjlPo0eD/HYpVN5WQ2PcJ6lWHtBFpUwusmiXNKjlFD
	 I3fFYE9Ekfm1bHij2aZXNJBHLadZepLEpTZcanis=
Subject: FAILED: patch "[PATCH] drm/amd/display: Relax DML frame limit with UBSAN" failed to apply to 7.2-stable tree
To: alex.hung@amd.com,alexander.deucher@amd.com,sunpeng.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:38:33 +0200
Message-ID: <2026092933-finally-retired-eb54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 0fd5e9ddf362b1253b3c94b858371f90400e5c4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092933-finally-retired-eb54@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0fd5e9ddf362b1253b3c94b858371f90400e5c4a Mon Sep 17 00:00:00 2001
From: Alex Hung <alex.hung@amd.com>
Date: Wed, 23 Sep 2026 11:31:18 -0600
Subject: [PATCH] drm/amd/display: Relax DML frame limit with UBSAN

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

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 10d4ace04d4f..096520bd27c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -29,7 +29,7 @@ dml_ccflags := $(CC_FLAGS_FPU)
 dml_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
-    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
         ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
             frame_warn_limit := 4096
         else
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 5388bf094fbc..4d682e92df1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -28,7 +28,7 @@ dml2_ccflags := $(CC_FLAGS_FPU)
 dml2_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
-    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
         ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
             frame_warn_limit := 4096
         else

