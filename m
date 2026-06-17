Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81F2D47E9;
	Wed, 17 Jun 2026 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658794; cv=none; b=Dja5EvGb5GLAYmBiqSpUxltLdoaiJ3iXaUlrrOrA5zkOZBMDUVSGagsMlBrB0iDi1tJeUzp7SfXjH84wrOqW8rPFgLym+oVQ1svrXeMVCabajzsZTT7u1KUCfrWxuRUlVDxo6HXQXaIbiKOhAJkxCJUVIYtKK9+PK+wZp/Abiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658794; c=relaxed/simple;
	bh=cndbEueGuqGQ0fNItr6sFaHHvC8hqe/+neHVFg5j460=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSXD3lzb7j8HQ5QehVRH+1n+nzEuCj9VDcQxCypbdS/M2+wMN6d1+wc54JXkQy9EtvzmbrGst8dTTe2zWnaeoUYZv1Dt/ALwu1r9Au8r8hDjoAst+QzNgLLTQSyhvyG2V/sYyUri9ZXdAeRL7h6gUTKsHWtZjj0BeIlghaNbSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEYQpNN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEYQpNN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F421F000E9;
	Wed, 17 Jun 2026 01:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658793;
	bh=wZlZEPEPECzrs7Kf9aWean30BHjLoK5QK+W6E1Zm1J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JEYQpNN/2tApDWzZH1uxyhDGjv0IDQ0ItmYp5T6Bu6aYEQ2Siw68ktq37CjHabtOw
	 pFaaMJITa2OqlC04YMZvW7CMfjmunNBuj8V2Ymi7syf2ruWXL30bgi9JVyTF9HYsQY
	 2dUREefkBNmIXLhnrRleIa4cwklEta3PK8tIBJP2o88HZZ6r/VvdUlEtS2oOjgAYlo
	 13VQCVjBJ49/rDFPiBc+Op46rkHY9JQCSkIkCQfbFcnxFfIfxqpjwmZ4JQbQj5GLaZ
	 nw6+rfy49DQ6lFgMiahC92fTZKWoOM2tpmG+bmbUthlwI7xsni666C8/zfb7D33i7U
	 NdSvfI7Qx7B4A==
From: Clark Williams <clrkwllms@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	x86@ekrnel.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: VMX: guard regparm(0) on vmread_error_trampoline for x86_32 only
Date: Tue, 16 Jun 2026 20:13:02 -0500
Message-ID: <20260617011303.3969027-3-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617011303.3969027-1-clrkwllms@kernel.org>
References: <20260617011303.3969027-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 0b5e7a16a0a79a3742f0df9e45bca46f01b40e6a ]

regparm(0) overrides the kernel's -mregparm=3 convention on x86-32 so
that vmread_error_trampoline receives its arguments on the stack, matching
the inline asm callers that push args before the call.  On x86-64 the
attribute is a no-op and newer GCC now emits -Wattributes for it, which
becomes a build error under -Werror.  Guard it with CONFIG_X86_32.

[ clrkwllms: the upstream commit redesigns the trampoline declaration as
  an opaque symbol; this simpler approach guards the regparm(0) attribute
  with CONFIG_X86_32 since the attribute is only meaningful on x86-32. ]

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
---
 arch/x86/kvm/vmx/vmx_ops.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 5edab28dfb2e..50328be40b2b 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -11,8 +11,11 @@
 #include "../x86.h"
 
 void vmread_error(unsigned long field, bool fault);
-__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
-							 bool fault);
+/* regparm(0) overrides -mregparm=3 so args are stack-passed, matching asm callers */
+#ifdef CONFIG_X86_32
+__attribute__((regparm(0)))
+#endif
+void vmread_error_trampoline(unsigned long field, bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
-- 
2.54.0

