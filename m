Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5581A6803
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573592; cv=none; b=pFCV5IUB/dGt0oABnCCR4qGSn1nupqactGGF/TJWcJgeU11WTC10mPW33upkAax0nUNxE4nIvGQJBnDleyN3qsovGq22hTGa48tSdhNGe9xONuSM6IG2KpwUb/d6rB4sWvbVSwsir5kpwxHhXwDlLbJcGtHJI+2MwFU/TYzyFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573592; c=relaxed/simple;
	bh=svphru8FrRD8HmAIKdKMBJBsYI5lEqA671Jh12ZpzRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouILDH3VHumUq/UbB8EcZ2j77ZEJOt1FjZc3rfXQZ5IOktnSujHR7p3N7mI0nbV4K2Sb/Y23MmML6hCABce0kWUfjHat/jWJqJsLVEjaF4ZJB+cac63Q8dWKaaB3erb3zXgkPDGHqp16s5IWu04gF9u8qIxOeDe+eSAEw6TmQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0LclX+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0LclX+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E5A1F000E9;
	Tue, 16 Jun 2026 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573591;
	bh=djLdwLuY11/fekE5o72vzb6nLtUGUva/OeMKkaJfgRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B0LclX+qCuyOE09wlf1y8Isb3F0HNzBkGntgvdTvVigVQF2urmGj9izoSUg19WlKn
	 Xy1agX8vy0FqAuiJEnPsyStDWgQ/4ET/BmyiFVvcvHi7wVWtyOnACUnKjK9dThYZf8
	 Sa6dVGzUs4/vhztEziiNTdUZXvgafsP3/vksddsvndgpHvW5giktAXO+jiCvaendAJ
	 E5qUDhVc8ssfu+ZtZ9f+eh3nwZ5L0z+y787VUV15ajiN8dfEYDm/NFLqtCRtRLV+oi
	 dRund5vA3IyG2j8CSmxELTxEtVwfePgu73TCu3kt7OqScWgY9wZMjrt0B5JJspxWKf
	 kr5+3Q6qdBHEw==
From: Clark Williams <clrkwllms@kernel.org>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH linux-6.1.y 2/2] kvm/vmx: guard regparm(0) on vmread_error_trampoline for x86_32 only
Date: Mon, 15 Jun 2026 20:33:06 -0500
Message-ID: <20260616013306.3850069-3-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616013306.3850069-1-clrkwllms@kernel.org>
References: <20260616013306.3850069-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Clark Williams <clark.williams@gmail.com>

regparm(0) overrides the kernel's -mregparm=3 convention on x86-32 so
that vmread_error_trampoline receives its arguments on the stack, matching
the inline asm callers that push args before the call.  On x86-64 the
attribute is a no-op and newer GCC now emits -Wattributes for it, which
becomes a build error under -Werror.  Guard it with CONFIG_X86_32.

Assisted-By: Claude Sonnet 4.6 <noreply@anthropic.com>
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

