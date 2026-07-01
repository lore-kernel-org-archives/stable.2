Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484844A718;
	Wed,  1 Jul 2026 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903960; cv=none; b=sv3/kG8HZAVl/e0t6y+zVlRE7/49t8VMOFIsQQQJUdz1tA6rILQNjk8/q4a29Cx1uBzHFSngNBNPhPQk9D3rktr8HrCZ8L5BqPC78K/hcMGgsARvwmr7LQMjWlF3f21gLDHRHCNVmJeVLmjmJVfqM1fUX+WmXoTiLepbpZU8PYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903960; c=relaxed/simple;
	bh=zbfTA2VJjWQfugM0y3HKDpUMdj5msjiIH2TZdK1WrjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROacXLT46LDhySTIGW0RbSc3hKOH6YiDt+UcXCJwqrZqaP2EHBs8cQLovqGvghv7FCR3RpAAhm8jGncoI5pAWLVsgdYQSHLTwFFWD+cPnSu/qXligTt8FiqsMuLJHqWijcoHVNdPb9hZcXnxXGPJenUM4/4RjD4Yk+t392+i52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Az8LmbYm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WmQpulop; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Az8LmbYm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WmQpulop"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 9A10E13803F8;
	Wed,  1 Jul 2026 07:05:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 07:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782903957; x=
	1782911157; bh=112Yvu8MDmd9GxnWgYRo8OOQeNBIsEEGqTciWSFqlIs=; b=A
	z8LmbYmjvPWAmMrAqBDP/A3213iIS8zPl7rpuHyv0PnrNDkGRM0sa60SAl5nUtJj
	uyIiihV6ixPExRxmQ9TLwDCNY+v+zp8bBiQoXqHb3M9iNlJEusKe+Q1VM6/XwEPF
	Eu7UvpB4XnH1+xGEXBKzN9oxgD7hphrkO/buRj+dwg7viBPp8X5hN2sEHmrqz4Id
	bg8xaS4ba7CHGApCgOkDJpiIi0GPtRu/lcq590dv8N7zxalyFi4P2MjKV5mo4+m+
	s7OqYY9SGeq5c31NsI//98iYNctmw3sfRStI72kMCapYlS+OqtXj2LDVkb8n+TWY
	HOlcURTTfOaNRj7bz7IFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782903957; x=1782911157; bh=1
	12Yvu8MDmd9GxnWgYRo8OOQeNBIsEEGqTciWSFqlIs=; b=WmQpulopXQ9xFiOKn
	pWP+mq7Paimh4vny+IBOmKHfGDlZTqI3C1iFry5fKoEpPAZqsqWSNuQhbBc6v4GC
	G5aFR1uYtc6ohG6bnYGFtlgCyxySFJPsEDpoXwcaACDUCivX5M1L57Hd4C1RF0k/
	puBSYtaAR3xD9OL+fkxqinXR7RIzHMqZ4kjPYSAJjfdNl1kNTjLt0v4HqSmh1n7U
	GpWl2xT6RNdPFh2miKPcTZsJRAg03KITAJvUrYoAibp1oB9xljEpOVoxyosjZ+sC
	IUj0dCrEJqaBxY+kNSm+aEkPaLvt+QqSitZvdFSsi9SaF75WsmXj3E+/y60mv+ac
	uDG/g==
X-ME-Sender: <xms:lfREanf5L5wqq7v9QyyXeOeF3qDbHsa6DwC9l3tuQ2VCysAA-z1_bw>
    <xme:lfREaqZ4etyFKVWXSJQGXc-9dejLHKX1xLITQ-JRsKFGl0IKYF9qH_5v9tawoPJxq
    rGYPmgDH91ZyZ9kCA229han5SRdRXz8Sskl_KveA6nYGXnMGZrVrLs>
X-ME-Received: <xmr:lfREalD7SQ3jeb-AajfGLY2acmBCWmz89Sm6oqg7RtXDKSOlnnGw3mjgEujB2A>
X-ME-Proxy-Cause: dmFkZTE0CVziHoiM8lzCNq0CXTDvT1m8g9dMJX/ma1Phno0+DXyt3F2epyBsPzLGmuODEG
    w+lKAQKeIhJbndgynfjWNe3aLFPuXJC7KrfHrflE9Zcvqzigau48rDuGMiujwVKGzkxGJr
    ff59+opHRvZgty57A2ecfNVQ2MzFmGJeWTYY7Ocv2TCPIZc0BdhaKS2GE4lY3W3pRR9ayT
    W8eTKuF/yDs7o8PUE5UEZbuPBNm34DTNlZM1JgU6HQadcwGavxXtQt3Erssu8rRnm9nIOO
    QK4cb0e8dX2TgcIBxKcwTGesaEkuFsrm+rSw7w7vu/nxAXi9tazUrQLkxIFXg00QluzGjT
    CT8Q1SHN4ekxslxD78/pL4o5acLYLuJV7kjeUuCSyQM4YQi7ax+ebT5LpM1n2MBpn+GrUo
    xy8Cf69HoghnrVXAiC4xfpze6NkBXmEqLySjlgBOlEZlA5uj32INTqCIeyoIv2ldBiQTUs
    oABHQtAy4A41OHnUAHXRPhrdKCBsZW61jS1cu9CZkbz1SPHL7jIEYlXPqNYocRzYGpBAfJ
    lm5lvTFT8ajU/q6VzlGjclgsdEnBE0SJk2s/phdQeXf0Wu8LAlfHoLRwgevUQLTx9UuAds
    YLDkI+MF0sn7TAJ9E4cYGY5mLrMsDW8X60KNqV4FqssOV5xEv7FXZRTYQMOQ
X-ME-Proxy: <xmx:lfREalLo0kPNrOa3H4Cy-cB31_ufEJ34fu4RFdbdeHGEpdnAOdZMyw>
    <xmx:lfREakp84AuAY5sD4wR7vdqxiG-N4cO-Xrujsu0BEvOr2k-ukdl9oQ>
    <xmx:lfREamMOiUS3zVetYthzoppE9mTjRxathlQlbXHtJkYt8N2ozKb9xA>
    <xmx:lfREapOuhjx3hkfCgTPwFWDwL-caC9ifbgZriOlMNiBKLqcDW2y3ag>
    <xmx:lfREal3sCyZg4v5VK8QR8dz2a1p9kJni_zK92vLuj7B8wwXcIq1plXH->
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:05:56 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	Dan Williams <djbw@kernel.org>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v5 3/3] x86/tdx: Fix zero-extension for 32-bit port I/O
Date: Wed,  1 Jul 2026 12:05:47 +0100
Message-ID: <20260701110547.764083-4-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701110547.764083-1-kirill@shutemov.name>
References: <20260701110547.764083-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

According to x86 architecture rules, 32-bit operations zero-extend the
result to 64 bits. The current implementation of handle_in() only masks
the lower 32 bits, which preserves the upper 32 bits of RAX when a
32-bit port IN instruction is emulated.

Use insn_assign_reg() to write the result back into RAX with proper
partial-register-write semantics: 1- and 2-byte forms leave the upper
bits untouched, the 4-byte form zero-extends to the full register.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b8bbd715fb62..f904a636d449 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -694,8 +694,8 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
+	u64 val;
 
 	/*
 	 * Emulate the I/O read via hypercall. More info about ABI can be found
@@ -703,11 +703,9 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
 	success = !__tdx_hypercall(&args);
+	val = success ? args.r11 : 0;
 
-	/* Update part of the register affected by the emulated instruction */
-	regs->ax &= ~mask;
-	if (success)
-		regs->ax |= args.r11 & mask;
+	insn_assign_reg(&regs->ax, val, size);
 
 	return success;
 }
-- 
2.54.0

