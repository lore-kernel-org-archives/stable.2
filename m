Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FC3F823D
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466737; cv=none; b=fr4kvdR5Gn9yAjcClhs8e0W39e09IJMZ6ZQhAxfXLXikIyVg/dhP3ARu/t4wjyD3Er5NonDhNgRmrE1ADqc17fl4wScuv6W8sM5GDZfPDxCj3DqHZSVCCsPp5xjmIVlfVJoMA05FMrOmMlKmf249WmlUBXPeySAu7vfubNIvdYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466737; c=relaxed/simple;
	bh=/dFtgpI6m2Kwt4mTbzBbOiTxtYRwhiPbVMJ5Uv07nHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=shDExIsz7OejKFvE6PlvYMaXaPWg7LnRqw591kv1VP9lFTVlNIRod54vrFn1yEF/xigIOuRqk4hRPbLYQAmvVmUC70T6hFfxBzdev3wNMsXcVKBf4DTUiTgNI28ETvvzwWP4gRhc8PPOFkosVzyj2EBjSHbaH99QU2ksJcG93NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+p/0zUB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+p/0zUB"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso2900523f8f.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786466734; x=1787071534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hF7Kn6Oocs5orb8GcrxywBb2rOULTfC5b3zs7Me4nLc=;
        b=f+p/0zUBnFfZ08GGkE5rplZLUXNsCe3zxHOqKd7Ss8OYRZ1KKc+ueb+KLlxlhXEf0t
         XElyb+crL0nEfxFoGhuwJlzW7S1ZSe14xjr4sF+ZFp1KDS+7ssyaMbdS1q51/WTvdVXn
         +mTE8BaqSpY4/0N5SOxwMt9XNIj4Znensehp9+zglmZqwVWyJYgJ7vAsxhJ81mZeMxww
         Rrv8zStOO2YHXmlxCuOlXexS7cBAY4AZJSrT1HkMJUZ7Twjk96Y70q9qG8eqK/Q1Tlsa
         1KBaCdudXREwNVQD8JLB64iZF0BsbEDOyldoBP40zSiGP0esMc/GkDe9z98RmVHG9wp9
         8L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466734; x=1787071534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hF7Kn6Oocs5orb8GcrxywBb2rOULTfC5b3zs7Me4nLc=;
        b=fapMNg6MzUGX3FGfXekc4wV5SDcYb3j7gmcAKSZwH1j+8rmULMtkLpywfZCS+EUMFY
         iYkBPYFdoHaOTMQ/dd1GfEfE7WLrALswKubzvwGlXSO+JbotJrQGFebswr+8BWVOFmWO
         7dJqPhak84Buony7A5G757S+I/5bAyBV+B2FEmkzppHLC9ZzeyFlbyHHvM1VjS6nUHKo
         mWOrYFAb6sLJKZs7DJoCZZzuYNmrOhusUktBzfGTdkkmQltnjwTPoiW7oawf7HnfffXF
         VlhW6INywxbl83mI5Y0BPQbYghV11w1eXp4KxgFYMIveC8n3yh42iTUH6TVOBpCQSQ4k
         7FBw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5qBOUPnVYtWGG/iMlXi6AUUM7uQUjYVsnTsBq200i9dvWgnikhY1FZg/ZMzhI8/Qq2aUza/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAj0sO6LP+hig+YWPebrKe3WtYWfRvyNASGn0VMKlv+oGLAdn1
	X106thFxevN3PY7FSDFxou5czo72U5D0OoiLUBBQygLNuLhZ5VLrkLXj
X-Gm-Gg: AR+sD13zAn0SaSEE20tRKoibTzNcksPK752tZiB/+y9Vej1JGtioLqI5ySWVZ8PYj0w
	uwGne/XsvB0NFDMnoJVjcKYVdWoRpULkXZ1WuyafOCj4xWon4Hb9xQXLhfhLrcmtmLQv8AS8v6T
	1Nv1HHxgRkd9vYvU/vhGcFhVgzYD5KQC5Z2HcGVrKDjMH6XBG8yd8QU89PQj6NwofIIENVTKxt9
	BX3n6+pTMLNPd6BgA8eW7c+qAwH+f6w3oy2Zfcla1yY1gLJ+SxLACXMSYENy4ru+aXWhrHoa7g5
	Og6ckTb+gTOR/zms+sZWbUZn4ga7ft3jWDEE3iFHhMyMVthf5eaqHJgFD1/nPrju/EBRyuuivD8
	CScPJ73OqilFkWkzZKEbHw98lWZMej+40jN/BTFeaFyNQH4h0iMacwxGWvIMRA1CJGzJFWTN4eg
	RGQ9IY7nzZoMKdIXBJ7sBdLC14vyJwYpx8hv13LL9zbltwzY3Vh2r/WtRmxc4Z8KWa2cTVINKLj
	iHgleimKxBOU2kf/OKiR3LWFtmkMUZe8Ud8bdBAFZoRpfHD8nnqhtvvbZzKYi/s7BT9zVskvPg8
	x9RQIkhUvba7f6C2ibLdOQF6fVDD7/iNE+UhK1cUFxyCEqZGwBdtFA5I3by4ephEs9hF
X-Received: by 2002:a5d:5888:0:b0:47f:d011:f644 with SMTP id ffacd0b85a97d-4814ad82de4mr7363109f8f.4.1786466733642;
        Tue, 11 Aug 2026 09:45:33 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac691sm5949354f8f.3.2026.08.11.09.45.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 09:45:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] ARM: alignment: restore uaccess state on emulation fault
Date: Tue, 11 Aug 2026 18:45:28 +0200
Message-Id: <20260811164528.65747-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alignment handlers enable access to user memory while emulating
unaligned instructions. If a checked access faults, its exception table
fixup jumps to the handler's fault label and bypasses uaccess_restore().
This leaves DOMAIN_USER as DOMAIN_CLIENT with SW domain PAN, or leaves
TTBR0 page table walks enabled with TTBR0 PAN, while the fault is handled.

An ARM926 QEMU test using LDMIA across an unmapped page boundary reports
DOMAIN_USER=1 at TYPE_FAULT before this change and DOMAIN_USER=0 after it.
SW domain PAN is the default on ARMv5, ARMv6, and non-LPAE ARMv7 builds.

Keep the saved uaccess state at function scope and track whether it was
saved. Restore it at the fault label only when needed. Paths that did not
enable user access continue to skip the restore.

Fixes: 274e91b81ed2 ("ARM: alignment: fix alignment handling for uaccess changes")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Resending after two weeks without feedback; add ARM alignment/PAN
reviewers to Cc.

 arch/arm/mm/alignment.c | 51 ++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 812380f30ae3..2b470a419dda 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -341,6 +341,8 @@ static int
 do_alignment_ldrhstrh(unsigned long addr, u32 instr, struct pt_regs *regs)
 {
 	unsigned int rd = RD_BITS(instr);
+	unsigned int ua_flags;
+	bool ua_saved = false;
 
 	ai_half += 1;
 
@@ -364,10 +366,11 @@ do_alignment_ldrhstrh(unsigned long addr, u32 instr, struct pt_regs *regs)
  user:
 	if (LDST_L_BIT(instr)) {
 		unsigned long val;
-		unsigned int __ua_flags = uaccess_save_and_enable();
 
+		ua_flags = uaccess_save_and_enable();
+		ua_saved = true;
 		get16t_unaligned_check(val, addr);
-		uaccess_restore(__ua_flags);
+		uaccess_restore(ua_flags);
 
 		/* signed half-word? */
 		if (instr & 0x40)
@@ -375,14 +378,17 @@ do_alignment_ldrhstrh(unsigned long addr, u32 instr, struct pt_regs *regs)
 
 		regs->uregs[rd] = val;
 	} else {
-		unsigned int __ua_flags = uaccess_save_and_enable();
+		ua_flags = uaccess_save_and_enable();
+		ua_saved = true;
 		put16t_unaligned_check(regs->uregs[rd], addr);
-		uaccess_restore(__ua_flags);
+		uaccess_restore(ua_flags);
 	}
 
 	return TYPE_LDST;
 
  fault:
+	if (ua_saved)
+		uaccess_restore(ua_flags);
 	return TYPE_FAULT;
 }
 
@@ -391,6 +397,8 @@ do_alignment_ldrdstrd(unsigned long addr, u32 instr, struct pt_regs *regs)
 {
 	unsigned int rd = RD_BITS(instr);
 	unsigned int rd2;
+	unsigned int ua_flags;
+	bool ua_saved = false;
 	int load;
 
 	if ((instr & 0xfe000000) == 0xe8000000) {
@@ -425,26 +433,30 @@ do_alignment_ldrdstrd(unsigned long addr, u32 instr, struct pt_regs *regs)
  user:
 	if (load) {
 		unsigned long val, val2;
-		unsigned int __ua_flags = uaccess_save_and_enable();
 
+		ua_flags = uaccess_save_and_enable();
+		ua_saved = true;
 		get32t_unaligned_check(val, addr);
 		get32t_unaligned_check(val2, addr + 4);
 
-		uaccess_restore(__ua_flags);
+		uaccess_restore(ua_flags);
 
 		regs->uregs[rd] = val;
 		regs->uregs[rd2] = val2;
 	} else {
-		unsigned int __ua_flags = uaccess_save_and_enable();
+		ua_flags = uaccess_save_and_enable();
+		ua_saved = true;
 		put32t_unaligned_check(regs->uregs[rd], addr);
 		put32t_unaligned_check(regs->uregs[rd2], addr + 4);
-		uaccess_restore(__ua_flags);
+		uaccess_restore(ua_flags);
 	}
 
 	return TYPE_LDST;
  bad:
 	return TYPE_ERROR;
  fault:
+	if (ua_saved)
+		uaccess_restore(ua_flags);
 	return TYPE_FAULT;
 }
 
@@ -452,6 +464,8 @@ static int
 do_alignment_ldrstr(unsigned long addr, u32 instr, struct pt_regs *regs)
 {
 	unsigned int rd = RD_BITS(instr);
+	unsigned int ua_flags;
+	bool ua_saved = false;
 
 	ai_word += 1;
 
@@ -469,18 +483,22 @@ do_alignment_ldrstr(unsigned long addr, u32 instr, struct pt_regs *regs)
  trans:
 	if (LDST_L_BIT(instr)) {
 		unsigned int val;
-		unsigned int __ua_flags = uaccess_save_and_enable();
+		ua_flags = uaccess_save_and_enable();
+		ua_saved = true;
 		get32t_unaligned_check(val, addr);
-		uaccess_restore(__ua_flags);
+		uaccess_restore(ua_flags);
 		regs->uregs[rd] = val;
 	} else {
-		unsigned int __ua_flags = uaccess_save_and_enable();
+		ua_flags = uaccess_save_and_enable();
+		ua_saved = true;
 		put32t_unaligned_check(regs->uregs[rd], addr);
-		uaccess_restore(__ua_flags);
+		uaccess_restore(ua_flags);
 	}
 	return TYPE_LDST;
 
  fault:
+	if (ua_saved)
+		uaccess_restore(ua_flags);
 	return TYPE_FAULT;
 }
 
@@ -502,6 +520,8 @@ do_alignment_ldmstm(unsigned long addr, u32 instr, struct pt_regs *regs)
 {
 	unsigned int rd, rn, correction, nr_regs, regbits;
 	unsigned long eaddr, newaddr;
+	unsigned int ua_flags;
+	bool ua_saved = false;
 
 	if (LDM_S_BIT(instr))
 		goto bad;
@@ -547,7 +567,8 @@ do_alignment_ldmstm(unsigned long addr, u32 instr, struct pt_regs *regs)
 #endif
 
 	if (user_mode(regs)) {
-		unsigned int __ua_flags = uaccess_save_and_enable();
+		ua_flags = uaccess_save_and_enable();
+		ua_saved = true;
 		for (regbits = REGMASK_BITS(instr), rd = 0; regbits;
 		     regbits >>= 1, rd += 1)
 			if (regbits & 1) {
@@ -559,7 +580,7 @@ do_alignment_ldmstm(unsigned long addr, u32 instr, struct pt_regs *regs)
 					put32t_unaligned_check(regs->uregs[rd], eaddr);
 				eaddr += 4;
 			}
-		uaccess_restore(__ua_flags);
+		uaccess_restore(ua_flags);
 	} else {
 		for (regbits = REGMASK_BITS(instr), rd = 0; regbits;
 		     regbits >>= 1, rd += 1)
@@ -581,6 +602,8 @@ do_alignment_ldmstm(unsigned long addr, u32 instr, struct pt_regs *regs)
 	return TYPE_DONE;
 
 fault:
+	if (ua_saved)
+		uaccess_restore(ua_flags);
 	regs->ARM_pc -= correction;
 	return TYPE_FAULT;
 
-- 
2.53.0

