Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559974756A3
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201124; cv=none; b=XatxgWWR+U0W7dkQh3wx1WH1Uiu1cN9i3uNAtmDy8a5vHdWL5AfmTLFU8O8UTNHcLEg2b5eWUmkIMX664orgp1x9J7r//kjGD4uW2yF8L7En2UgPXaps2JtlZ1uQKv6COkprQhUI5Qmnf1OAu6ZA2FtRoYsklyb7wheH+iHaSuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201124; c=relaxed/simple;
	bh=Jw1DiHKPg0HYvBgwncOW6UYM9K0MOgq34GyYbDXmYZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdX56j+PKUrCyRmn5J8R0wBjt/HF7PrbaIsu/+wC8+Xpjd7I87C0ba3z2AIGI36tDb0O98YgPUlaAgvQj1ocWQp5WoicnuZMLuP2aaKY83s5soimgXQqldsLcMPViVjfIPmaJNf7Ct2pnaJfm0HRkSXhk44VPNN4LlIDbJuPh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/qDCs5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/qDCs5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448901F00A3D;
	Mon, 31 Aug 2026 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201123;
	bh=mAUoZ0h5AFGI70r9iEY9mx7IJfQ/dSbo/uLH0YDxkZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n/qDCs5OgVg8vpQ02ibtZ4WMGB4+Kl8XNOlRD7O80n71UbHcDtGSzP4cNdzzzBha6
	 EDLrtV+5Oz5m/9CNgjpv5UaGaG4/GgEfIL0d01bR4iyGhVt1024vQCYjdP6nd28yiI
	 6PdPx9FDIF/W1z2k/oXAqxb6WwtgzCDRWI/KGNyZXobGX2pHN5dKlnQwWbtm7waflq
	 yuL6kNid8/IimZ54eJXL3YwNE6I+0o9yEnJSQ21yftTgSTZS7sn4ROxaapkBDeml+1
	 /USDNajcIgfL+qdwT2AxKqE3u1U4kmDmDJNtyj78NhBcohzM/0WsRXFo2veET4XOsx
	 k7mvpRrFACNLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Pratik R. Sampat" <prsampat@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Pavan Kumar Paluri <papaluri@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/6] KVM: SEV: Disable SEV-SNP support on initialization failure
Date: Mon, 31 Aug 2026 14:31:55 -0400
Message-ID: <20260831183157.1673215-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831183157.1673215-1-sashal@kernel.org>
References: <2026083106-utensil-mangy-28f5@gregkh>
 <20260831183157.1673215-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashish Kalra <ashish.kalra@amd.com>

[ Upstream commit 179a8427fcbffe36ccfed5e138d7c9b6180caff9 ]

During platform init, SNP initialization may fail for several reasons,
such as firmware command failures and incompatible versions. However,
the KVM capability may continue to advertise support for it.

The platform may have SNP enabled but if SNP_INIT fails then SNP is
not supported by KVM.

During KVM module initialization query the SNP platform status to obtain
the SNP initialization state and use it as an additional condition to
determine support for SEV-SNP.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Pratik R. Sampat <prsampat@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Pavan Kumar Paluri <papaluri@amd.com>
Message-ID: <20250512221634.12045-1-Ashish.Kalra@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 42a39ad5d592 ("KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 44 +++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7a94a5f0ca805..d4026cd634c0f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2984,6 +2984,33 @@ void __init sev_set_cpu_caps(void)
 	}
 }
 
+static bool is_sev_snp_initialized(void)
+{
+	struct sev_user_data_snp_status *status;
+	struct sev_data_snp_addr buf;
+	bool initialized = false;
+	int ret, error = 0;
+
+	status = snp_alloc_firmware_page(GFP_KERNEL | __GFP_ZERO);
+	if (!status)
+		return false;
+
+	buf.address = __psp_pa(status);
+	ret = sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error);
+	if (ret) {
+		pr_err("SEV: SNP_PLATFORM_STATUS failed ret=%d, fw_error=%d (%#x)\n",
+		       ret, error, error);
+		goto out;
+	}
+
+	initialized = !!status->state;
+
+out:
+	snp_free_firmware_page(status);
+
+	return initialized;
+}
+
 void __init sev_hardware_setup(void)
 {
 	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
@@ -3088,6 +3115,14 @@ void __init sev_hardware_setup(void)
 	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
 
 out:
+	if (sev_enabled) {
+		init_args.probe = true;
+		if (sev_platform_init(&init_args))
+			sev_supported = sev_es_supported = sev_snp_supported = false;
+		else if (sev_snp_supported)
+			sev_snp_supported = is_sev_snp_initialized();
+	}
+
 	if (boot_cpu_has(X86_FEATURE_SEV))
 		pr_info("SEV %s (ASIDs %u - %u)\n",
 			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
@@ -3114,15 +3149,6 @@ void __init sev_hardware_setup(void)
 	sev_supported_vmsa_features = 0;
 	if (sev_es_debug_swap_enabled)
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
-
-	if (!sev_enabled)
-		return;
-
-	/*
-	 * Do both SNP and SEV initialization at KVM module load.
-	 */
-	init_args.probe = true;
-	sev_platform_init(&init_args);
 }
 
 void sev_hardware_unsetup(void)
-- 
2.53.0

