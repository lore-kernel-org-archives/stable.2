Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913743859F5;
	Mon, 20 Jul 2026 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582297; cv=none; b=nRQRloQR1m2+DEe/8q2G3earrPstq89POHxcFfIrbNFygQW4Dj/2wXOY+DKw3LUnpSWdk77FUHVMH+7TistPYZRk0xCspWu9vLNnzUYRwZ8ytm8jAjg5YAEdNBtERlJapmQh2KjJOkWML9SJFEt2EBhJcGAI9eGgjWRz/EAbr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582297; c=relaxed/simple;
	bh=2yfJp9DjgxEbuglj+KrflocPRFfWEuOdSx58mNXP0q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAIPzTaCcEHVW6iMhX1YHpqS2TTAxPShRbgKEA/Vo/ENnVwGM3I/k3jWYraMw6HqYU2dt/UI3bMg8oYYS6yudsJoEtixAXZj2feTZhX9CVi4NQseiJ98fq28Ea+kIPRux9m2Y+aSqweiDGksSOoBUOfYNfLCANM56+7FHvnJ6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DcYi5wt1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcYi5wt1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784582295; x=1816118295;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2yfJp9DjgxEbuglj+KrflocPRFfWEuOdSx58mNXP0q8=;
  b=DcYi5wt1oH/oCP1G7O1otd0W48yyZpXziTqpKZa3RTGhGFJbpl5RGm5D
   MCjEqZyqBKSeKl48+QjG7KokiMNrxh2DFQ4jaWHLt3/LC6NXItSEygIyP
   IUyyugZmwVDH5tZRdPzZypLyB57mH8US+4KQIfbBLi6rCPGLHJHO61hFa
   CPizLesWYpot7qj+EfvMQN+zH7vBNklojkgRanD9kfwDi+HuXcpqpbjz+
   GyU9pCgaP2LE0WtxNrleuLHOAuCrG7gI99Fvp3sa37kHXg1j1dfc/zus0
   FQjj2zDyDcMQcYrzNkunQndG1x2ROc5n8SCYOYF4tBty5elZ4dZEQp5v2
   Q==;
X-CSE-ConnectionGUID: kHnte9STS4u1Ni6iz/5RxQ==
X-CSE-MsgGUID: J7A3XBLEQpmUIruLKyUW5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="88850241"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="88850241"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 14:18:15 -0700
X-CSE-ConnectionGUID: QBRMasMbStCDPgTEBGCWCQ==
X-CSE-MsgGUID: yciFYR2fQ1O6y5BcFp3BQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="261359644"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 20 Jul 2026 14:18:15 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	chang.seok.bae@intel.com,
	stable@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
Date: Mon, 20 Jul 2026 20:52:08 +0000
Message-ID: <20260720205208.519622-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMX-TF32 enumeration was added based on the Intel documentation [1]. The
recent update removed the feature, indicating that the feature is no
longer planned for hardware implementation.

[1] Intel Architecture Instruction Set Extensions and Future Features

Note: The feature first appeared in the September 2025 revision of the
document and was removed in the June 2026 revision.

Cc: stable@vger.kernel.org # v6.20+
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V1 -> V2: Collect tags (Zhao, Binbin), put note (Binbu), and cc @stable
---
 arch/x86/kvm/cpuid.c         | 1 -
 arch/x86/kvm/reverse_cpuid.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 591d2294acd7..759a1c557080 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1082,7 +1082,6 @@ void kvm_initialize_cpu_caps(void)
 		F(AMX_COMPLEX_ALIAS),
 		F(AMX_FP16_ALIAS),
 		F(AMX_FP8),
-		F(AMX_TF32),
 		F(AMX_AVX512),
 		F(AMX_MOVRS),
 	);
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 2ad25781cefb..1bb13903c5b2 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -56,7 +56,6 @@
 #define X86_FEATURE_AMX_COMPLEX_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 2)
 #define X86_FEATURE_AMX_FP16_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 3)
 #define X86_FEATURE_AMX_FP8		KVM_X86_FEATURE(CPUID_1E_1_EAX, 4)
-#define X86_FEATURE_AMX_TF32		KVM_X86_FEATURE(CPUID_1E_1_EAX, 6)
 #define X86_FEATURE_AMX_AVX512		KVM_X86_FEATURE(CPUID_1E_1_EAX, 7)
 #define X86_FEATURE_AMX_MOVRS		KVM_X86_FEATURE(CPUID_1E_1_EAX, 8)
 
-- 
2.53.0

