Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D34CE68E;
	Thu, 15 Oct 2026 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099980; cv=none; b=KVUNs+pqXWwCZAdKT41JgsHAHHdRQUw2lG49d91yldslaX6DsX9GR+4oxa4t3Z04lBZ3DmvzAax6pCPX4308PgZU/yxbA1E2l7wPdVGdEySHzeuHr7N/CV0HrLilOuyOEjbckCNFpuY/0Ja6EefU2xuu/4J3xKezh0Rrv/23Gro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099980; c=relaxed/simple;
	bh=iZ/fpEfpiKYGqhm90uOi4vCX3SZbYmvwnQ5nVGT2LWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eukJdBPltdzhgWf5pMApMG2saFeOH/Fza8sGtUPfOtMiUXd8+mdVbztfXA2QdtJYjV3I04EFktnn5cAMlqaTRUlCg/bDGan656hQT5ewCIo9oohEEjfDGcB5/NIlZj/kSx1mUtAv4Ye7serntbieM/o7k7gfz40ePdWHLL+Y3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ih+6EEG1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ih+6EEG1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792099977; x=1823635977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iZ/fpEfpiKYGqhm90uOi4vCX3SZbYmvwnQ5nVGT2LWw=;
  b=Ih+6EEG1gIHBUrvcCxaS7DpIIwRASBWl1vxsEzNjVjZT6gOFPVQzpWhZ
   5dpVO24Pdmp06Sm5e06WVWU5UiOir3pCLWl9CnIissy2xydyYjBfNrzK8
   mk2f2EmmnzBebUKm5O46TuNGLlr67c9shDWL4THY2cGN6cdVLYUzrIdGu
   YWXsQH0C6WXGr5Bq9cg2dMvGJEqmmhI8nz4LRXTRe8zUtC9YnHlk4f4+e
   Ym8OnpoCIX4+/UkM/nGKSZuP4rYJ6kxazOxcF1c2UKcSJR3C3/VEpwVTv
   d/qmbahwTbSqUIAGPaelBqr549fYXsM1gow35+RfEn4N04AYjQw9yqkAB
   A==;
X-CSE-ConnectionGUID: 7rnVNoChRwiL+0Zh5TcweA==
X-CSE-MsgGUID: tt7z+p1mTu6XQ0wrqEz/Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="891521"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="891521"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 14:32:57 -0700
X-CSE-ConnectionGUID: /G5zkxSqTb6j5ZVBxzOT2g==
X-CSE-MsgGUID: 6rUHKrOTSpqk7g78LyDKGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="3617409"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa011.fm.intel.com with ESMTP; 15 Oct 2026 14:32:56 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	christina.joos@intel.com,
	stephan.rohr@intel.com,
	chang.seok.bae@intel.com,
	stable@vger.kernel.org
Subject: [PATCH] x86/fpu: Fix PKRU state saving for coredump
Date: Thu, 15 Oct 2026 21:05:44 +0000
Message-ID: <20261015210545.48208-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christina reported mismatched PKRU values from GDB coredump tests [1].

PKRU is stored in thread.pkru rather than in fpstate. Then the coredump
path currently syncs fpstate only and hands thread.pkru to
copy_xstate_to_uabi_buf(), so a task that still owns the register state
can end up dumping a stale PKRU value.

Save PKRU from the register when the target is the current task.

Fixes: e84ba47e313d ("x86/fpu: Hook up PKRU into ptrace()")
Closes: https://sourceware.org/bugzilla/show_bug.cgi?id=34646 # [1]
Reported-by: Christina Joos <christina.joos@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Christina Joos <christina.joos@intel.com>
Cc: stable@vger.kernel.org
---
Testing:
Christina verified the fix through the GDB tests that originally exposed
the issue. Also a simple test that sets PKRU and triggers a coredump by
dereferencing a NULL pointer can verify the saved PKRU from the corefile
read.

The existing ptrace selftests cover most of this path but not completely,
e.g. not checking back from a corefile. So it may worth adding coredump
tests for XSTATEs in general. I'd follow up on this separately.

Code changes:
The PKRU saving could be folded into sync_fpstate() similar to
restore_fpregs_from_init_fpstate(). Instead, since this is on the saving
path and PKRU storage is separate, sync_pkru() makes that dinstinction
more explicit along with the fix.
---
 arch/x86/kernel/fpu/regset.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 0986c2200adc..213a06fd72f3 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -49,6 +49,13 @@ static void sync_fpstate(struct fpu *fpu)
 		fpu_sync_fpstate(fpu);
 }
 
+/* Keep the same invocation context with sync_fpstate() */
+static void sync_pkru(struct task_struct *target)
+{
+	if (target == current)
+		target->thread.pkru = read_pkru();
+}
+
 /*
  * Invalidate cached FPU registers before modifying the stopped target
  * task's fpstate.
@@ -135,6 +142,9 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 
 	sync_fpstate(x86_task_fpu(target));
 
+	/* copy_xstate_to_uabi_buf() takes PKRU from thread.pkru */
+	sync_pkru(target);
+
 	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_XSAVE);
 	return 0;
 }
-- 
2.53.0

