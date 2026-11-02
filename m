Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657212;
	b=r4sSRazLhn+HaiOYS+JXebeNyaA46m5V388Ms79rp1l00G7T3i2AIHKnJ8xZHM07kSyP
	 5FFq0TxCQRAg3tT5E2MVu1bV850vT2az7kK3XhJGNcGMs3oOWqfF+cpRSj/mkQ/9Mc7xv
	 TWlIGQc3usse2EjJlevZ0npV0QZupbHfBoaRCPTKpBeHek1oeUJJh1D1PMxhbDIv1B22l
	 T7kcG46+OpFmt+1sdYFxiCRrqXhLCRFbBxUzFFgRyUJweJGWmwZS4uNd6URx32XgF0zVc
	 MDcx1/blk2x1/8jwM8dDVkNQQeSWYNCNefgheHqkS2DupNxO8JsPaWaTnVkUpk0JbwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657212;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Vuoc0Sqqs1PhFGJeinH1RMuIv5+lRtZwlt6+Pv+h+nE=;
	b=Vfu0AfphcUnYiSdmQl9fb7oG1lWXiodAkuarHXNf6QuTg3yE7f2VgueQKNyWlPMJmmRA
	 N6p1YYQreDbUjtiiLotFh1kegQU70+lGl3J6wyLMC9KCTzp/Dp+kB2SdFoKNkD0v6nNDh
	 MyfKQScOYyBzRKvsx1pWCA8BhS0Yddu5OMG08WV9g675QqOZvo1TsXMX+Tn+mArg8S3r7
	 FOjgxVFxQbcDhtLrZRsKilZj09K/UkBQ1U8xhrh6YETBxPADCr/k0ssiK61+3e9rrfsl0
	 QzzDxuWmEqhdFt9kxHMyZHO7n9ug109ZoaUjcIWtT4KtEG+xAcZyJIYs0bwifa3k0OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="JoZ7aQo/";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0jhrq+Ho;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455C606A326;
	Mon,  2 Nov 2026 22:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3455C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JoZ7aQo/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0jhrq+Ho
Date: Mon, 02 Nov 2026 22:06:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793657209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vuoc0Sqqs1PhFGJeinH1RMuIv5+lRtZwlt6+Pv+h+nE=;
	b=JoZ7aQo/MEFzs0lYrK5cKRFnMJ3Zeubpv7kOnlwHqenX8G43PnC+fQ/1F7E1PUWkcHupvJ
	i0sQR5X+0DUwp8lHGSWwdoWxVNVSqU687SkMwZcQJk7ARqrnNmXSu/p0qxbRECPebBB907
	Voa9C9FNFwcJVGlLLOrEMqdSJ5u9ByY6As1vLqjsZKpqxAcAE0NMgsNbOY5qbCmjhmVbkc
	jW8Ju9QJde+Ul57JC8GDv8hRVftbUEF7Rc2DAMOS5eqxYFoXwBOLS7bczmSbC1J3Q6KBgh
	FUD23UKxx6d59zO8UobuaUdYq4MksEUF0hlovkH8d4X/sWhbAYzyzpm/ZkbrBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793657209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vuoc0Sqqs1PhFGJeinH1RMuIv5+lRtZwlt6+Pv+h+nE=;
	b=0jhrq+Hoy3oCZXCmMaF3dxQsdNqHN9nTTD2XKJgWzq0dSb72A6Ze1DcpGsqSldNdkfrh37
	HAR7+/cs10mQPeAw==
From: "tip-bot2 for Zack Rusin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/vmware: Fix i386 high-bandwidth hypercall arguments
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	stable@vger.kernel.org, #@tip-bot2.tec.linutronix.de,
	6.11+@tip-bot2.tec.linutronix.de, x86@kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4ab10678a8f50053934b62b56af81f881c1d3798=2E1788414?=
 =?utf-8?q?669=2Egit=2Ezack=2Erusin=40broadcom=2Ecom=3E?=
References: =?utf-8?q?=3C4ab10678a8f50053934b62b56af81f881c1d3798=2E17884146?=
 =?utf-8?q?69=2Egit=2Ezack=2Erusin=40broadcom=2Ecom=3E?=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179365720809.1009794.5658884257049428844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e0e022004bbedc7caf1c18770980eb5372019189
Gitweb:        https://git.kernel.org/tip/e0e022004bbedc7caf1c18770980eb53720=
19189
Author:        Zack Rusin <zack.rusin@broadcom.com>
AuthorDate:    Thu, 03 Sep 2026 12:07:20 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Nov 2026 13:51:17 -08:00

x86/vmware: Fix i386 high-bandwidth hypercall arguments

The high-bandwidth hypercall helpers push %ebp before loading the in6
operand into it. On i386 without frame pointers, both GCC and Clang can
address the memory-constrained operand relative to %esp. The push then
moves the stack and the helpers load the wrong value.

Typical i386 configurations use the frame-pointer unwinder and happen to
address the operand through %ebp. However, UNWINDER_GUESS is available
with EXPERT and permits the affected frame-pointer-disabled configuration.
vmwgfx is also available on i386 and calls both helpers.

Stage in6 through %eax before changing either stack register, then save
%ebp and copy the staged value into it. Load the VMware magic immediately
before the string I/O instruction. Mark %eax early-clobber so it cannot
also provide in6 or an address register for it. Use the same sequence on
x86-64, where the full-width register preserves in6.

Fixes: 34bf25e820ae ("x86/vmware: Introduce VMware hypercall API")
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: stable@vger.kernel.org # 6.11+
Link: https://patch.msgid.link/4ab10678a8f50053934b62b56af81f881c1d3798.17884=
14669.git.zack.rusin@broadcom.com
---
 arch/x86/include/asm/vmware.h | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 4220dae..fb011ce 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -276,20 +276,22 @@ unsigned long vmware_hypercall_hb_out(unsigned long cmd=
, unsigned long in2,
=20
 	asm_inline volatile (
 		UNWIND_HINT_SAVE
+		"mov %[in6], %%" _ASM_AX "\n\t"
 		"push %%" _ASM_BP "\n\t"
 		UNWIND_HINT_UNDEFINED
-		"mov %[in6], %%" _ASM_BP "\n\t"
+		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
+		"mov %[magic], %%eax\n\t"
 		"rep outsb\n\t"
 		"pop %%" _ASM_BP "\n\t"
 		UNWIND_HINT_RESTORE
-		: "=3Da" (out0), "=3Db" (*out1)
-		: "a" (VMWARE_HYPERVISOR_MAGIC),
-		  "b" (cmd),
+		: "=3D&a" (out0), "=3Db" (*out1)
+		: "b" (cmd),
 		  "c" (in2),
 		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
 		  "S" (in4),
 		  "D" (in5),
-		  [in6] VMW_BP_CONSTRAINT (in6)
+		  [in6] VMW_BP_CONSTRAINT(in6),
+		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
 		: "cc", "memory");
 	return out0;
 }
@@ -304,20 +306,22 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd,=
 unsigned long in2,
=20
 	asm_inline volatile (
 		UNWIND_HINT_SAVE
+		"mov %[in6], %%" _ASM_AX "\n\t"
 		"push %%" _ASM_BP "\n\t"
 		UNWIND_HINT_UNDEFINED
-		"mov %[in6], %%" _ASM_BP "\n\t"
+		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
+		"mov %[magic], %%eax\n\t"
 		"rep insb\n\t"
 		"pop %%" _ASM_BP "\n\t"
 		UNWIND_HINT_RESTORE
-		: "=3Da" (out0), "=3Db" (*out1)
-		: "a" (VMWARE_HYPERVISOR_MAGIC),
-		  "b" (cmd),
+		: "=3D&a" (out0), "=3Db" (*out1)
+		: "b" (cmd),
 		  "c" (in2),
 		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
 		  "S" (in4),
 		  "D" (in5),
-		  [in6] VMW_BP_CONSTRAINT (in6)
+		  [in6] VMW_BP_CONSTRAINT(in6),
+		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
 		: "cc", "memory");
 	return out0;
 }
