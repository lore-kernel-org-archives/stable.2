Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C8641228D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123307; cv=none; b=iR7RFZfMFMZGhy51thduEsYInL1syznplKaqcmx7KCP25dYpXuTqJBIeuXmA3rmbvWSlYtQ5d4fzASR6hhsIkaIfkQb4uMCdHXO+TpXo2xy5UE3vmIb2KeeZcuhfj3xy+ddO+61gx4vjYTanL/3rCW/xaLNyx5KT7oGypC0up1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123307; c=relaxed/simple;
	bh=09hToGdqQLUqgQEFflQ/QmV/cJ7v9aRxkJaGWXJYidw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qijlC4uypYBQMgSYckm9kacL1aD/wdaR63aRNNMaGFvXEeiq8PXblqKKRfAr/NaPojckVyhG/wlFrkO96xSSPc6wPM8UkWbxROkknhTZqgGRU9SHFiNPckLbDXZacdEXlJkcgQMDZiRn+iUlXiEIobUzqz81AAVLSAdL1hJTb+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtVvN8Qh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtVvN8Qh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F151F000FF;
	Fri, 11 Sep 2026 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123304;
	bh=sPc50L8LptNh1m/CrlTozP3koKuew7cYLz4hfyOVOxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RtVvN8Qh+ZG1UIlaYSx11CzvnbkrP2ogLALEo4h0IXAyj2gnMC1dGfo9NCIuvUpIk
	 YtTz+U+qo6wCZDjCieJqjrnPbLzAK+ceTgysefRtU5q0w+AjKPyTkZMYJGIg/A67H8
	 8RTrvUq1Gsz1lVJPOJoC+LjZE49A5QJQPP1MH9qJbfPGOwOxd6kQFbpeI9KcPx5ObP
	 93DTk5HSGvUzFVNUaxMnNmXXDdnSfbxsF9C/oJ2wTS4aLoAVx1/gb+QudZI4S9w3FI
	 ZL6C25cIEmVRAsQB+qvBerFbJC5MXmss8uT0zfuurVIc1Ti/IDWf4B/6WZfIUP6NSn
	 ehKejvDArzeaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 7/7] KVM: x86: Always initialize EFER reserved bits on vendor initialization
Date: Fri, 11 Sep 2026 06:41:36 -0400
Message-ID: <20260911104136.194961-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104136.194961-1-sashal@kernel.org>
References: <2026090906-angling-trickily-a20c@gregkh>
 <20260911104136.194961-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosry@kernel.org>

[ Upstream commit a4b8acd428ba3f03952ef309d7f438dbc357557b ]

EFER reserved bits are statically initialized, and do not reset if a
vendor module is re-loaded. For example, loading kvm_amd with nested=1
removes EFER.SVME (and potentially EFER.LMSLE) from the reserved bits.
Reloading kvm_amd with nested=0 does not add them back, allowing
userspace to set EFER.SVME with nested=0.

Re-initializing EFER reserved bits before configuring them on vendor
initialization.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260713181020.2735367-4-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/msrs.c | 10 ++++++++--
 arch/x86/kvm/msrs.h |  1 +
 arch/x86/kvm/x86.c  |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 87372113dc0f9..eb6791744303d 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -19,8 +19,7 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
-/* Enable syscall by default because its emulated by KVM */
-static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
+static u64 __read_mostly efer_reserved_bits;
 
 #define MAX_IO_MSRS 256
 
@@ -637,6 +636,13 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
+void kvm_init_efer_bits(void)
+{
+	/* Enable syscall by default because its emulated by KVM */
+	efer_reserved_bits = ~((u64)EFER_SCE);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_efer_bits);
+
 void kvm_enable_efer_bits(u64 mask)
 {
        efer_reserved_bits &= ~mask;
diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index 09f1098b67846..adb2c03af0c0e 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -56,6 +56,7 @@ int kvm_get_set_one_reg(struct kvm_vcpu *vcpu, unsigned int ioctl,
 int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 		     struct kvm_reg_list __user *user_list);
 
+void kvm_init_efer_bits(void);
 void kvm_enable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 796fd7fafdb85..ee249ac15e200 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7304,6 +7304,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
+	kvm_init_efer_bits();
+
 	if (kvm_cpu_cap_has(X86_FEATURE_LM))
 		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
 
-- 
2.53.0

