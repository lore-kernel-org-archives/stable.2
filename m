Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94912F7F00;
	Mon, 15 Jun 2026 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500408; cv=none; b=hyzqHODP1BSHutHhH2W/qZAzi3HexGVmVvP3v2ZVv3mtl3h7+L8I5owFvGcIGf30zsVL38gHLDVGq3PaeEsw0MGroy7RpbsVTghXFyxQID9bd6EGfFdipr55tiooiaLNlwdiQeg9oTHBFFDIUoPZRSa7/da3uxqOpXJsdalHyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500408; c=relaxed/simple;
	bh=ZCSg8rgUfQxYAKXvlVX623y0p0mwC+RS4U4EbVgagJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDMuQFwqKqP2YrIrWBVMbRR1d7qPfz+TMe7tMJFZZMFIQXBhNgY+lzd4egPrrr0A6bClLb9mWrGJ8juLYLGe3sux8Mgql8ymrCIF0DpjJiayJ0R6WXuh2V6Y4MyeeLaXRWo/h/sPutmCzKirAwlxggRcxDU6ZcT41tx3MWNslAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFdPugmf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFdPugmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4AA1F000E9;
	Mon, 15 Jun 2026 05:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781500406;
	bh=epeNv8U8vkCS7hPNhm6n+IOPAD0EFsVk8XMbJrLmp6Y=;
	h=From:To:Cc:Subject:Date;
	b=cFdPugmfiYHll09u/96S3QqxwCqKEkUIq63q/PTJ0ku8g21xn7qD7hLMgb1kh5SuM
	 +GdUQ9w4JDfVyCeFTtIY5EtAhUsvwYXEPbh+uy7mJTcvilpnJVOBNgfHcPE+/+qsGX
	 dP1aULWNHbZ8QApShbuqVBdwCQS35fJhuZn1iig06twkfUHj/+wcaPtiJT+fNabuic
	 tE6ybrLLL9NQ07sF8f2931EF2eerlrhItUlccaQYuvchIuI3dAVMTH+idPwcDwnX48
	 e7aBuJOXtj8pLyRQ5Fn/zk7iAKDtiHLbFar8KPoLdNvwlg1AT6f50YBQJyoKClNRCt
	 MQUrCLkMzDG3g==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: nv: Drop bogus WARN for write to ZCR_EL2
Date: Sun, 14 Jun 2026 22:13:24 -0700
Message-ID: <20260615051324.830045-1-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is entirely possible for a guest to write to the ZCR_EL2 sysreg alias
while in a nested context, as it is expected if FEAT_NV2 is advertised
to the L1 hypervisor.

Get rid of the bogus WARN which, since the hyp vectors were installed at
this point, has the effect of a hyp_panic...

Cc: stable@vger.kernel.org
Fixes: 0cfc85b8f5cf ("KVM: arm64: nv: Load guest FP state for ZCR_EL2 trap")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 161bb2a3e1d9..2e96ac3b08c0 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -595,8 +595,6 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 			return false;
 		break;
 	case ESR_ELx_EC_SYS64:
-		if (WARN_ON_ONCE(!is_hyp_ctxt(vcpu)))
-			return false;
 		fallthrough;
 	case ESR_ELx_EC_SVE:
 		if (!sve_guest)

base-commit: 1ee27dacbe5dc4def481794d899d67b0d4570094
-- 
2.47.3

