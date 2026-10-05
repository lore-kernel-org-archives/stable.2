Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09E20B80B
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187677; cv=none; b=IJrsOqRET5Pbstu25SyAbYjk3zPr2EppRpOk9oIfIodbjSXTcx9YBB7O2HGZyMOulcR/21gd8ypQCKlXZkdRv8BDKIeOCaPE23eRRxztUwkXpNHY4gQkxCJfTKcSjIsDB2cgiamve+2TxmpX3RSMfAHnSHtXxezsqHOp5kBCGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187677; c=relaxed/simple;
	bh=Uvl/EPIX2khA96bFSmk+Xz/LpeOjBokVgWi6gMpnERg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=So45WaLjGjuc94OyQDBFvK1/+4z7ADq/i9I9ZhsV7+FCJXrXOmrlEy09x+4LWl9by8q+MhwIYHzDPT47ukvcccM1XMJMqL76cmj20w8p355UKWPv/nhVGutL1EHOzFcVPuVFnnfeHnWGq3h9k1hxUXeBSUtnIcLT8k67P5KfIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x5nm4VN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x5nm4VN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ED81F000FF;
	Mon,  5 Oct 2026 08:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187676;
	bh=NwIKVYXzVEs/40sz99l+AcTT9FRnvxPz+XU+Yf0uuKs=;
	h=Subject:To:Cc:From:Date;
	b=x5nm4VN409JidWLNiP1gyQyrf+cLijJ5SLYjNtEivtKPcY3Mk0rUOYg7Ypxeoc/gY
	 yf2qpoF3WMvDQg1bBP7v8zgTOmtuKijznPxTnUA04XRasSSC8FF69b3duUCkr4COKK
	 ztXOwsv00F8LEpLbVAcw8oqMO2UNc9Wkif4AQT2w=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix sanitizer check for the DML frame size" failed to apply to 6.1-stable tree
To: sashal@kernel.org,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:07:32 +0200
Message-ID: <2026100532-shrink-valiant-89a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fbc988f236a60cf50a89da78fc6b7213daa9999c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100532-shrink-valiant-89a9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fbc988f236a60cf50a89da78fc6b7213daa9999c Mon Sep 17 00:00:00 2001
From: Sasha Levin <sashal@kernel.org>
Date: Sun, 27 Sep 2026 12:16:01 -0400
Subject: [PATCH] drm/amd/display: Fix sanitizer check for the DML frame size
 limit

Building x86_64 allmodconfig with clang fails:

  .../dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:10491:13:
  error: stack frame size (3128) exceeds limit (3072) in
  'dml_core_mode_programming' [-Werror,-Wframe-larger-than]

That config enables both KASAN and UBSAN, and should get the 4096
byte limit meant for clang COMPILE_TEST sanitizer builds. The check
in the dml and dml2_0 Makefiles concatenates the three symbols with
no separator:

  ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)

KASAN and KCSAN cannot be enabled together, so before UBSAN was
added the string was at most "y". UBSAN can be enabled alongside
either of them, and with both set the string becomes "yy",
$(filter y,yy) is empty, and the build falls through to the
non-sanitizer limit of 3072. Adding UBSAN to the check therefore
lowered the limit for the most heavily instrumented builds instead
of raising it.

Separate the symbols with spaces so that $(filter) sees individual
words, and test for a non-empty result. Only the configs with two
sanitizers enabled change behaviour.

Found by KernelCI builds of the linus-next tree.

Fixes: ebf8b0fd8508 ("drm/amd/display: Relax DML frame limit with UBSAN")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0400d53fd03e7d4beb09fdabda42a7b2c4ca465d)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 91465ac05c97..eb4ce5b1ecfb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -29,7 +29,7 @@ dml_ccflags := $(CC_FLAGS_FPU)
 dml_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
-    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
+    ifneq ($(filter y,$(CONFIG_KASAN) $(CONFIG_KCSAN) $(CONFIG_UBSAN)),)
         ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
             frame_warn_limit := 4096
         else
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 39ee2d1999dd..289bac08c82c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -28,7 +28,7 @@ dml2_ccflags := $(CC_FLAGS_FPU)
 dml2_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
-    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
+    ifneq ($(filter y,$(CONFIG_KASAN) $(CONFIG_KCSAN) $(CONFIG_UBSAN)),)
         ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
             frame_warn_limit := 4096
         else

