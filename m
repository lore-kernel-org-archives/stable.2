Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B373A9D8D
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272924; cv=none; b=svR9ueu9kZKSlpUm9mAAjbF8thGi0zPRDuWnPItSgekGO5RXq0ktJfuzG1POqgT/pAHh/JCNbXg5DUwZ28mNZTna62DEf4zqAjgClT/ZcYTMJ4I6bSXICDC0OMBEtBy2bPNSVcJAlAOVpgpGu82GsLlmAaHIXosOjb7AeqkNgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272924; c=relaxed/simple;
	bh=pWk+0D/DYFNghMX3LuWqusesL3I8kURaNWVlvTC5TgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N7iLF7N7aiEbBKkMbaxcxpPRDB+AsZfVZq8WN7/9KoYAeDL0ix+R7ygB1mHI8rLyqwVsq6INpHri3Cay2mZnYuIuYG41kHep6Etm+rnafBV6jgjIgdei/mQ5QhHmmnIvr4/dd1gsl21w2UWn+X2j4KYKjWRC4vTYJtckh4sEaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNrIw7Rx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNrIw7Rx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956242332dso2123285e9.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785272921; x=1785877721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vxOu3XF7bVHUG+0agmcIDyKP04Qh+pMOMDiJD5AR2Rg=;
        b=DNrIw7RxRwAm+FI5TaFjNx8N5q5n9JMsgPqMhpJHiJ+Q5ebMs4rorbaZ3izP+63UNr
         fW0miXFGctH9insb1T8/8ovMd29nLhnvRkwHr6NKI8cw4HRb3Jetb4zjOSfKQQz7qzHN
         4td0bthDEtvZ716L7vWKbZnOzaspFjF5oBz5ILZqudgg8hxzcsaVvNOd+eA0CoURAUNF
         4W5ogeSKg3VGc+kxBwvZXV4rVb5O4sDFmea6RVRrMYmsbHd14M7/h6jYUQATUiJFolik
         OkGaNXaJk1rAazSmniw0dEZ89lIrtLT6LyWgfMX/Avq+kYMIDvftuqwar0QH4Bs/z0ZG
         ATJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272921; x=1785877721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxOu3XF7bVHUG+0agmcIDyKP04Qh+pMOMDiJD5AR2Rg=;
        b=JdN2ycwVXBJIYtIIC/xgAJ10/MRvLY599S/qhK7CFaQd/1jfO7JYgQQo20LFCzzyWR
         Qi16sntIW7fWwHyyWpUdZhpLIAKPkAmLNPjwNv11zb57PIHpsD6/qUaJ+oDdDX4pr3EI
         sQNNBnWFobQo4GOvsACmLtMmIDga/oAn6PIlqQvVo/IN6VoMzVkPCt2BbZ4cpRR8FxZ8
         BSeBcA2PbE8wJb2rrM+XCA0pTBX5bgnv0uoOk2Do1ZIFelA3VfPqBF81RdN0afpzx1kh
         Hn65Agk+OqjHRNCdepUCG0NpJpRwknKFkbexr5S/XdKuWRVi7MkeU0luLrMRM2HGEKL8
         +l1w==
X-Forwarded-Encrypted: i=1; AHgh+RpgxICYnm793VDo28hagL6Ko9eFFa91Sk2v5WV/Nzg/5p66BQDwMzEL8kWFPtie5i/1U/x1MVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4zy0Q0V75u6iMytx9OHyuFQmgHwpJxrc43X1ZWXJotIMClApl
	y2jC7q9Wd2FeZ2LsM+8a3n7vIPyz80zO2BeefNuYtRnNQzzBBoBpbaV6
X-Gm-Gg: AR+sD12oAg4+9nVjovixnLdxqy3uBOMJLrK4fTEaqX4rUZYGX+SSGr2y7qOr86jhDg2
	DCimnk/97eVDjZNNCCtR2F01AGmtYy6j8uM48wJSBkmKi2N1KP5/f+cMyBWmQmcmrAGTcXnEz3R
	zDCY2rSxqYVK64uFuDBaXl9KIgVhdL0aAM53daooWGr/m3PVvi4FK1K21+mC36cNRKqIhkHHLOu
	k1vCEHFPHrgq0VOLvYu8uAjBu4Wq/oIs8d6WK9tkfrjokJoGtFr5ULVRvk9tdqXXD4bkTgAgxFn
	dNz59NFP8Ehvtbb7nFqzeemc3128t8T3fpxW+p+OmxKMaihiveyFYPRjdtvDZzxqpAAlXFy45cH
	X8KwYuFTnRdS1oUWRfrQKXFJ+whINqbcTK/ejl0boYmcEcu83YY0S+r3C2CZ8xR6hrI4I+j+wHD
	N2NxIX465lkhE4PCB44BuSzADGCNm6CUO2N9VTtCTrT1trStatq9sMZ2d/0t2gAOSn/17cukD0+
	nTqdWn7s6DNDlnkoqo/3SuFpu5GghIFeEj+gh8xVMtltp4YJVDd73eNhoFfzssUp5bzhZ68wrS6
	UWKMJTbY1CpDNBKKUD97BRiki1+4dMwCxy50iKafBCTrWqLsuXMdAmo5W8sqFkBXJGBIgxIk
X-Received: by 2002:a05:600c:4452:b0:492:6f6f:fa42 with SMTP id 5b1f17b1804b1-496c65cd672mr40420045e9.37.1785272921199;
        Tue, 28 Jul 2026 14:08:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b323-2b01-0d98-9fe8-a4cd-78ab.310.pool.telefonica.de. [2a02:3100:b323:2b01:d98:9fe8:a4cd:78ab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6acfdafsm1934679f8f.15.2026.07.28.14.08.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 14:08:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ARM: alignment: restore uaccess state on emulation fault
Date: Tue, 28 Jul 2026 23:08:28 +0200
Message-Id: <20260728210828.10488-1-kmehltretter@gmail.com>
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

