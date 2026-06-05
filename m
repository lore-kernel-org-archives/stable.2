Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF341E5B63;
	Fri,  5 Jun 2026 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619614; cv=none; b=K4aAET5RNVqzNQwlbJ1oSN2L8exxysWazQQQcaH5RjdzCUt48eDs57pnSTmE0KAPBPykpNkfwYAS7IbKOwRJe9+nXOaQaWZLPkbP2MXml/9UFdqcIyEFmvVMriaWyI43ougIND3tCjlIb3Lp5ngSXyGLpnHKhqfEe2JyZFzUMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619614; c=relaxed/simple;
	bh=FiIhFTMpDiko60PkDxAKjTjhqyUO6mVmOJmI7hvwhKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QN5QBGuQ5BFYTNWTLZtKbTcXLSqONANG5Yn3hTjI4GceTW6M2db/G2MFgBGyKTCS6eUPOVIiaS7ZQUJc5nZihzor80De95cXaa8JhfYe+aWqJ+yjJuDLeQsDd6VU08I6jkAKKx2juKJHTPyjj75pHOePYDmAuCV/DegQr7dTKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW3boJ0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW3boJ0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DDD1F00893;
	Fri,  5 Jun 2026 00:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619613;
	bh=1Fql6FtY6DpZSGux+lI1tMeBBWlScRTWwhveUt8GEA8=;
	h=From:Date:Subject:To:Cc;
	b=lW3boJ0LmgfgckSGy6GxiEZ66O9yCvpVtIy4zFIoDMRauMJHDs5ORItzr40vvjVMd
	 70wSR9XfFQgfhwdfAfhvyr/J2xZq7948718pDFIc6y348FFvv2ZUtLHClkfBp6tRGL
	 0Mnub7QutkPZBeT5NXMhJXx4pxLuLpSxzZIQoiq+R45MySj95G+FvxkRin01J/mr/4
	 s2CYClUhE4hkIHblTTVjsWOoqV+D61Uxjv/+YLD9i22UI9Z8BIUHtQrDfh68RkC9Jw
	 nn7z6YyXjgorxAGSgABLGwlxzS4oR6VL3B5iAkR57KPYNJg+DbN9yu5xkWJKKBnNxp
	 g+E0WuN3EJdSQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 04 Jun 2026 17:33:21 -0700
Subject: [PATCH] cfi: Include uaccess.h for get_kernel_nofault()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-tracing-fix-cfi-h-build-error-v1-1-b27015390901@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDsQY5tCryJdmMlEp5QoExVBv
 HujXT74/B0yq3CGV7WD8ipZxlRQ3yqgoUs9o4RisMY648wdZ+1IUo9RNqQoOKBf5BuQVUfFxpH
 1TPEZ6geUx6Rcwuvfvv/Oi/8wzecUjuMHvFNyQYEAAAA=
X-Change-ID: 20260604-tracing-fix-cfi-h-build-error-36c2becf7d15
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sami Cclvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, llvm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=nathan@kernel.org;
 h=from:subject:message-id; bh=FiIhFTMpDiko60PkDxAKjTjhqyUO6mVmOJmI7hvwhKw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlKktFNVepzVVgLy7iV/9TvTJmVO02uq6qQ58Ft+Uc1O
 9X/L27sKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABNZfJHhfyHb30V27se2Xbez
 evs7XS5EPqXHytRyiazdv7lXZ4ps3MbIsK//9LTdD159D56yfeHK/PiafvY7370nu09Zfm3umar
 lG9kA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 0652a3daa787 ("tracing: Fix CFI violation in probestub
being called by tprobes"), there are many build errors when building
ARCH=arm multi_v7_defconfig + CONFIG_CFI=y like:

  In file included from drivers/base/devres.c:17:
  In file included from drivers/base/trace.h:16:
  In file included from include/linux/tracepoint.h:23:
  include/linux/cfi.h:44:6: error: call to undeclared function 'get_kernel_nofault'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     44 |         if (get_kernel_nofault(hash, func - cfi_get_offset()))
        |             ^
  1 error generated.

get_kernel_nofault() is called in the generic version of
cfi_get_func_hash() but nothing ensures uaccess.h is always included for
a proper expansion and prototype. Include uaccess.h in cfi.h to clear up
the errors.

Cc: stable@vger.kernel.org
Fixes: 0652a3daa787 ("tracing: Fix CFI violation in probestub being called by tprobes")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/cfi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 1fd22ea6eba4..0f220d29225c 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -9,6 +9,7 @@
 
 #include <linux/bug.h>
 #include <linux/module.h>
+#include <linux/uaccess.h>
 #include <asm/cfi.h>
 
 #ifdef CONFIG_CFI

---
base-commit: 0652a3daa78723f955b1ebeb621665ce72bec53e
change-id: 20260604-tracing-fix-cfi-h-build-error-36c2becf7d15

Best regards,
--  
Cheers,
Nathan

