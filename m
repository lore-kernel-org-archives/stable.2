Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0FF471260;
	Sun, 11 Oct 2026 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758071; cv=none; b=EED0DE/eH7NpWsSesDbO8XjqTZCCxY1CuBMmPUAJ2jB7VIUyzWSSyA5OFNuAd8b9H5+vZ7kbbHG9qSTYuS2BkSVi22wRHJsLNxXYcB6itVU3wWmDijBTl9zBodAtx17ay8JSEeSPUMOqljmKRFPwl87Wv7jmIGJ0TnI+uhlzD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758071; c=relaxed/simple;
	bh=+Nl+DVp6eLDgqBtrmD7p202sJC2i5u7sG1hTsfoRpJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKUpgn4DoMKSdnA1V5C1/gNsjNosgrJ+vmkXbuo/0t/vHiNEmLzUIgD2fDz3NKm8BYRuitqmWDkxz3S427FTchsFZi+uTjuRW1LnV26ExHb5RbPkwz0LIZskAh9042tGj70hHtq9WCzpbPZVKRsXsMfmt7Rh3qFfJ8G6P2S4VdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk0OPJcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk0OPJcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BE51F0089B;
	Sun, 11 Oct 2026 22:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758070;
	bh=TKGwZ3RTxKdRUuH3w+dRxuSd//rV+l+NMsTq4MIDvYA=;
	h=From:To:Cc:Subject:Date;
	b=Vk0OPJcKwm3rjFgs+dctyCoOR+xpSRGjfWUrvpnt6zY4xkBYjM/wJz3o3FXxP9lyI
	 ZVSPCZpg1nmRGpUydlkHBVV56UQKB6WjSCczJHRTewwq4UC7y1TdcUY/C+gz4gqjbr
	 sqYl9iswyYrClRU1gOtdyzF9uGLk3gcbf8brY2aCo98cVQhgOHD4xBnP/IczoqfnxL
	 SRxpO6c0HrQthwCwFHQbuKCUP+r3JZQPcOVHtaC0MbBaoa4ynqgKHc4WI5qsR3MVho
	 h7iV9652CHoaz3lKTI5jVo4mqrH4V1pyujPUDhN5uSwIOsUUr3jfGKrEJYmOVXDfO8
	 3MuQd1ezu2tcg==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/thermal/intel: don't fail to build when cross compiling
Date: Sun, 11 Oct 2026 18:33:43 -0400
Message-ID: <20261011223358.2327625-15-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The power_floor and workload_hint Makefiles include lib.mk only for
native x86 builds. With CROSS_COMPILE set, or for other architectures,
the Makefile defines no targets at all and the build fails:

  make: *** No targets.  Stop.

Include lib.mk unconditionally, so that those builds have nothing to do
instead of failing. Native x86 builds are unchanged.

Fixes: 27801542b2b81 ("selftests/thermel/intel: Add test to read workload hint")
Fixes: d4d27e5a1a88f ("selftests/thermel/intel: Add test to read power floor status")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/thermal/intel/power_floor/Makefile   | 5 ++---
 tools/testing/selftests/thermal/intel/workload_hint/Makefile | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/Makefile b/tools/testing/selftests/thermal/intel/power_floor/Makefile
index 07463c2160e09..12697c717881d 100644
--- a/tools/testing/selftests/thermal/intel/power_floor/Makefile
+++ b/tools/testing/selftests/thermal/intel/power_floor/Makefile
@@ -5,8 +5,7 @@ override ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 TEST_GEN_PROGS := power_floor_test
-
-include ../../../lib.mk
-
 endif
 endif
+
+include ../../../lib.mk
diff --git a/tools/testing/selftests/thermal/intel/workload_hint/Makefile b/tools/testing/selftests/thermal/intel/workload_hint/Makefile
index 49e3bc2b20f9d..7f4cdbaf7452c 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/Makefile
+++ b/tools/testing/selftests/thermal/intel/workload_hint/Makefile
@@ -5,8 +5,7 @@ override ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 TEST_GEN_PROGS := workload_hint_test
-
-include ../../../lib.mk
-
 endif
 endif
+
+include ../../../lib.mk
-- 
2.53.0

