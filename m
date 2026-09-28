Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E084F30E8
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614143; cv=none; b=WCILMeAOaE4HgKHWCrCYOKT/cfofdAIN17urirrWMIXsmrkpXzNzc5k6EfZw1MzR+Nl59aHaWRdsqLawSdzDJOAxukyh+QiI2v0TdJRGF6BFiIoV9Nwxfn+YISGFtvjqtYDPHmXosBVBt8vE6WBwSLEXSzjwDM/gkZAvx6hf55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614143; c=relaxed/simple;
	bh=3O9snaNpj61NGwVpqAErbcwvbhUst7HrWJg9lEhq4og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKGBNNl7EXqMjbBlG29VLP7i6vbCnZ/RCOJNfsfGMBPdb0oLU1t2Vyzvyp8m/1pliPiJuGidyzhoMYJLCGtPQvE4vM2XWdVzNK40MPA/GFfVobBWGgsMtoaJr/suBUlE74/sNZb6g57yNlh5ukyTbKTPpumHwF19jWdGDsD/jww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbbOTxe4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbbOTxe4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790614142; x=1822150142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3O9snaNpj61NGwVpqAErbcwvbhUst7HrWJg9lEhq4og=;
  b=AbbOTxe4YBTeudcrXgMHUYfo7RR/GKfz7qL+kqYF5cG5zjPC8aclzWSF
   2YD8IDjZ6l9JYo5JKKQjTqJx4yN+xdl+sWk6RUWULtKmzGnW8/Jp2sApa
   1D+QHfLXKso51hg6icbdtUWsZhpHQVKsgYaMFzZbDyBzxuSZCDDm+VABI
   tXGOWp+hW1rmIlHFhDoLAdw56T0e82BDr9jU/F4BnbT3i93yuoLXh9qoh
   x2ClMqMOU0f3fin6IDrPioA/lLdHoDXJGke9yQ1YEJrWd/mnQ4S22Q/E7
   C5RQv7kl2QK7Hh4YuRn55/RbPrBS47kcpnUe5xWNtJD5GbxH7J48yNrta
   g==;
X-CSE-ConnectionGUID: mZIALcbnQ+mMPUixFlsjjA==
X-CSE-MsgGUID: M9LBUKBzR/6ievp5KZUNXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116845571"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="116845571"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 09:49:01 -0700
X-CSE-ConnectionGUID: ufmkoWpKQeizC3j95ZccbQ==
X-CSE-MsgGUID: W81AKXMNRQ2F3mzQOlT8Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="301404251"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.80])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 09:49:01 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/xe/vm: make PREFETCH to TT sticky
Date: Mon, 28 Sep 2026 17:48:23 +0100
Message-ID: <20260928164820.1237049-6-matthew.auld@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928164820.1237049-4-matthew.auld@intel.com>
References: <20260928164820.1237049-4-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When userspace explicitly requests DRM_XE_VM_BIND_OP_PREFETCH to system
memory (XE_PL_TT), xe_bo_migrate() moves the buffer object to TT.
However, because XE_PL_TT is marked with TTM_PL_FLAG_FALLBACK in the
buffer's default placement (introduced in commit 5c87fee3c96c ("drm/xe:
Attempt to bring bos back to VRAM after eviction")), any subsequent
validation during exec immediately migrates the buffer back to VRAM,
completely undoing the userspace prefetch request.

Use xe_bo_migrate_tt_sticky() when prefetching to XE_PL_TT so that the
buffer remains resident in system memory across subsequent validations.

Assisted-by: LLM
Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: 5c87fee3c96c ("drm/xe: Attempt to bring bos back to VRAM after eviction")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
---
 drivers/gpu/drm/xe/xe_vm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 425c678f4480..2068e0cf50ff 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3406,7 +3406,10 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 				mem_type = region_to_mem_type[region];
 			}
 
-			err = xe_bo_migrate(bo, mem_type, NULL, exec);
+			if (mem_type == XE_PL_TT)
+				err = xe_bo_migrate_tt_sticky(bo, NULL, exec);
+			else
+				err = xe_bo_migrate(bo, mem_type, NULL, exec);
 		}
 		break;
 	}
-- 
2.55.0

