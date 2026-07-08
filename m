Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62A3B71DC;
	Wed,  8 Jul 2026 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477506; cv=none; b=R6to6p6BNRKLhjs33bgvjUMAU51EVN6SibubSWXzNarbsrDg8/lGspGkjCj+jwtnJl6YMK/ZDNYUuuzXL/TLJlYHKeI5NNpW2eam425DhqH+FnCLRCY3ruFLYSxSNPuSWH6SlY1Qm5/qt4BYGCWEktZYcMooE5dlEC4lijjqpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477506; c=relaxed/simple;
	bh=uMRcGUfcSxGy3KJX0xa0rRYeXeX5tZKuWgpF+l22Qbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W2XWad1izIzvwXMxyMSDh3m8g8yRFi/lkH1LnBemyQmoQqGszSl/N/7jg3NBTfPIqB4yxW3ELHWbDM8BytGG7awiU6iljw0gr8Mo1T+yP2X9ObQLKr3+T7ubGiRMKMvVjl4ueOsMAM/L525cgZE//IGiMrU8FdSn354uIHsLyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/f4QDQC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/f4QDQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783477505; x=1815013505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uMRcGUfcSxGy3KJX0xa0rRYeXeX5tZKuWgpF+l22Qbk=;
  b=k/f4QDQCGiThPbAXPIw2/myy+3ogrXxUCigtXWq1ZS+0IkYiLdKN7wqj
   suPLTv00Xyl+22aI/fRlpW7bCCv4Ig2c27jWgIphTSfa1ErO8D8c3LUAe
   lwIoSQ5Qi2R8kakKnNQSS/fUBhYaDJ9N8lmdu0N/v+X/NZr8H8jO+4fcg
   HCzSWyzIu98NxS0fBCq0HdEPpfTEcemxgRdlhWPe5pLykCjri8xdiPVBT
   wCmPf19PSzyA9FgGmZoSqLjFuvlLTaCElJ4z90Tl8BHOG4O/HIxsRQH7D
   d3MxHNK2A1PrVXO/WsDr7TFrqkAwHWpOt7Z8nnMq7Gz0QBn1RhG/gesnu
   Q==;
X-CSE-ConnectionGUID: k7e9PSE4SKugjfRbS0TvVQ==
X-CSE-MsgGUID: rKy2b+KFTIiWio1aGrffQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84230079"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84230079"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:25:04 -0700
X-CSE-ConnectionGUID: C4jOcgdnTqqbeQRAetsxgw==
X-CSE-MsgGUID: 82wwJbsvSNCX+SII30ajQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="252414965"
Received: from litbin-desktop.sh.intel.com ([10.239.159.62])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:25:02 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: stable@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	thorsten.blum@linux.dev,
	binbin.wu@linux.intel.com
Subject: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD init
Date: Wed,  8 Jul 2026 10:29:37 +0800
Message-ID: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the validated CPUID entry count when parsing CPUID data for
KVM_TDX_INIT_VM.

tdx_td_init() first reads user_data->cpuid.nent to size the flexible
kvm_tdx_init_vm copy.  The copied structure also contains cpuid.nent, and
that field can differ from the value used to size the allocation if
userspace modifies the input concurrently.  setup_tdparams_cpuids() later
passes init_vm->cpuid.nent to kvm_find_cpuid_entry2(), which uses it as
the array bound for the copied entries.

Overwrite the copied nent with the validated count so CPUID parsing is
bounded by the number of entries actually copied.

Fixes: 0bd0a4a1428b ("KVM: TDX: Replace kmalloc + copy_from_user with memdup_user in tdx_td_init()")
Reported-by: Sashiko:gemini-3.1-pro-preview
Cc: <stable@vger.kernel.org>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ffe9d0db58c5..b658b03e7750 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2802,6 +2802,12 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 	if (IS_ERR(init_vm))
 		return PTR_ERR(init_vm);
 
+	/*
+	 * Use the validated entry count, as user_data->cpuid.nent may have
+	 * changed.
+	 */
+	init_vm->cpuid.nent = nr_user_entries;
+
 	if (memchr_inv(init_vm->reserved, 0, sizeof(init_vm->reserved))) {
 		ret = -EINVAL;
 		goto out;

base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.46.0

