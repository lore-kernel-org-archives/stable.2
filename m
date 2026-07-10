Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B081A6838;
	Fri, 10 Jul 2026 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783655337; cv=none; b=lgA59zBDzxQM6vSUI2q3/F0TKp4ZApEt97MPnsH/AwmIORi0MskJOrWNTMhDHNMiiuYpGpTaHct4oNdq+W2uhFNqtsvflaKB9+1ZB5raGHWqLH04267o5UguyXvCoccM1SjQbDB+UPqqCOp2cHd1a8M65TiYDl+74atmgKjK8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783655337; c=relaxed/simple;
	bh=IC1suyjmt5b8DyR8pK6rxRhMkrtUSvZA/TDabVoUMEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwXyFWGNPC+7ifUXJkWWK3eBjwalrhu2GBcT414+h13h77pd+pfu9w/KDMHlN1TzJVg5lLLtQupavMGU7F6PnZ15leir9g7bPgXmhDd6k0FyreLMYQhPB8+hV0q2fGMxDHtrmFbp+/Nj5OIv06UQFpilQtR4zD3MDWPgAKNeOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crz1i8AA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crz1i8AA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783655334; x=1815191334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IC1suyjmt5b8DyR8pK6rxRhMkrtUSvZA/TDabVoUMEE=;
  b=crz1i8AA5IqIcmTaoCzx86+CDpCKfq8TVW5SDlyTDn0awZRPIf/pbvyG
   8Y8Sc5sT35TO9sEM0nhx/47oeZ1NtSzbFUkVtnYkHt6vK2ylRhLNjSQ9E
   hQwIcfcAURJuB09yc/6K7Ex/T4DHSS+7OffQSY4FbkYljAK3ToT9m0cSJ
   YEkASujNddx4z+eQjcnbm4DW01xIZtsFTmzMVxOj2Lam3/yEWd9lUkylL
   SX2cEXzeGUqT6LfApKWIKkgs60qhlsSGVOeZ2WqYckj7FLaNXqB2A7HTk
   zzTDFd8zkaLj7jHR8hqRSzbAegq/IkVSbuXdjGVHXxzb6Z7HpfBBNW2yd
   A==;
X-CSE-ConnectionGUID: GH3l/dSyTgCq0IF3nHWT/Q==
X-CSE-MsgGUID: 4uzS+Cn1TnW4sZ0rg6+jlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94956800"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94956800"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 20:48:53 -0700
X-CSE-ConnectionGUID: haCtSX8mQB+zOM0BN10Btw==
X-CSE-MsgGUID: DbRQTrCUT2Kz1KkMstE/OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255433185"
Received: from litbin-desktop.sh.intel.com ([10.239.159.62])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 20:48:50 -0700
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
Subject: [PATCH v2] KVM: TDX: Reject concurrent change to CPUID entry count
Date: Fri, 10 Jul 2026 11:53:23 +0800
Message-ID: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject KVM_TDX_INIT_VM if userspace changes cpuid.nent between the
initial read and the subsequent copy of the initialization data.

tdx_td_init() first reads user_data->cpuid.nent to size the flexible
kvm_tdx_init_vm copy.  The copied structure also contains cpuid.nent,
and that field can differ from the value used to size the allocation if
userspace modifies the input concurrently.  setup_tdparams_cpuids() later
passes init_vm->cpuid.nent to kvm_find_cpuid_entry2(), which uses it as
the array bound for the copied entries.

Require the copied count to match the value used to size the allocation
so that CPUID parsing cannot access beyond the entries actually copied.

Fixes: 0bd0a4a1428b ("KVM: TDX: Replace kmalloc + copy_from_user with memdup_user in tdx_td_init()")
Reported-by: Sashiko:gemini-3.1-pro-preview
Cc: <stable@vger.kernel.org>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v2:
- Reject the request if mismatch instead overwriting the value. (Thorsten, Rick)
- Lump the check into the existing sanity check on the cpuid field. (Sean)
- "KVM: x86: TDX:" -> "KVM: TDX:" in the shortlog.

v1:
- https://lore.kernel.org/kvm/20260708022937.2465796-1-binbin.wu@linux.intel.com/
---
 arch/x86/kvm/vmx/tdx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 6ff1469e91cc..d1af0a752e97 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2797,7 +2797,11 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 		goto out;
 	}
 
-	if (init_vm->cpuid.padding) {
+	/*
+	 * Reject the request if userspace changes cpuid.nent between the
+	 * initial read and the subsequent copy.
+	 */
+	if (init_vm->cpuid.padding || init_vm->cpuid.nent != nr_user_entries) {
 		ret = -EINVAL;
 		goto out;
 	}

base-commit: f1e5ada5ab62dbe32350bc161771c9afc6a896de
-- 
2.46.0

