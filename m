Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9A238159
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178442; cv=none; b=oB1tQBfP5g08tv/DLDufaTR/nDRc5Rbmk4YC+t2KVb3WY6l0fwOYDASsXpFsKFP+6vEfVVo1M2+Ihj02S9Bgeo10mHzW40yUnqAM7M3Bkd8lquap6hyoaonxFdiN/xI0l0lrVQf/BT1JK5g9O8/cQtQqL6KRocdA3DqdwrrsdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178442; c=relaxed/simple;
	bh=WGm3p5oM3zo05UQVhikGUeWmOuT3VK6db4qPSyq1cYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tAeI9s+Ng5GpB9AJSqRHug1Xwi/XYg8GVX9cichAiO/R5uHiDSdrYqXg+aL8PaQ/AywZdxgLnTuuqndirWMxLPQvu92AvEADhbJiUu9TuT4ZknUEW77Clls650fG6xqxl5F/Lw9UTUxn1rNAGO24fcEpWmOur6pSYKaLN7EVYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W58TD7NG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W58TD7NG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f6609c657so729935f8f.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787178439; x=1787783239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ULPVsNiJGeOiMzRxtFMqgWR/S094ar6IrHsMXumteU=;
        b=W58TD7NGvkJGuJaAwixmRDAhJASHVfPE2oEJpIWnky+ktmNro/067QCl/8+xIENNOw
         r1hH68GD6RRI1GOWwJMJynC6ImeiWEuMvXPtjVQJw/Y4N1okVY4pobIQbkccEWk+c6VH
         zBh1qj3ICgHoZ7xpKRLJt4XlzVLxNHQlLu59H9M6gmVWu+0eAPnjEWbTtLMKX8ZQEpCX
         X2REAgSDJAMPrjh3qa1N02veFAWszp/S6ea3NaG/ebZFIH1FYzCQFO6Q31BqucvN9oD6
         52iTbtaGjH59ZxRl1fDqjnZcFFUcX8Qz1vVQjLB+yHaUFMmK+TeUByOCgDhEuCdVrBqk
         s6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787178439; x=1787783239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ULPVsNiJGeOiMzRxtFMqgWR/S094ar6IrHsMXumteU=;
        b=iK/aqUpcgwH2AYuBWGDpLRSc6HKIZy4T1Xyw4hHpCAOKV5hs8kFifcG6pZ619131Uj
         xoWjSorZ4+/wFZnTudL6ZveUx8uemC4XKI+1rhMRb27Qh6FhMBaFdLStYOx0LgTeDbaC
         tnvfc31arsI+s5r8K4l/on6qCmbFPBFFbxQvsvY5CnwDawZOBKzoXLPWJQF/vkclwp65
         rANWZ0lNSTLdoCFRgbpItghbVqa/JS1jw2ZofyHBIN9B+Y0jq07vi0s4OqECKc1z+rVL
         RIS9dzVkFXmFwbMmXhXreBMQOjomWfAz+dXTPHDzeburbBzKpLcJjWLJ9NzeDkwV0UnB
         BLog==
X-Forwarded-Encrypted: i=1; AHgh+RqmzSM6Fg5pYPgeEFJuNf8fFBY1dJT102qDkoNoenpbC97PJ38+K0mF9sXaMhQ616gV5k8Nt7Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mqMgJ2YKNIwm2SdnXOPuaTDB8QTubx00P5Mwugg73lF3H70dHK
	k+FNgy6w3rASeduIAbuOtx+3YKWCpkY29xNAlpwAmS/b7QB08C/ksygd
X-Gm-Gg: AR+sD10Rvp5fumkre+2oOa4xcQSlYTm01z47FwInfKz17N5YXwmgQQyEQPm4ii1jN/j
	uvLdfmqOrdv1t4qq/QvtGrtOxLnvJhHls5jvYMfEz7bS0ieL+cDCUV23sE25GDfMmmrFhUjJXOZ
	pwJt6l9Vpi18p3DGZccuMkTnaMx9cfcRniHtVwV4IZqMV9uuc2kll92iVNERprk9VHUgi9tMKWZ
	abZWkyLTRMcD6Bfs+a2JLg3UFU7LvTTVD9nsH8p8UfJIMTFsz3GaB+LYeYAyflOE1i1Jknhtg+1
	uizNOQxMjO/1RE3gfFSUmlV85XPzRCc9wV3fGYRmxrBAVRi+S8Hx+O+hVHQuzo/mCwI77ZPGG4a
	3Jw/35vznNKyVdxd47zkw+FkKtKoG50f9dq+AfhNqlWxRiuL5XtsbQNqL4J+vts3GaaRJOg7nEJ
	ohwa0rMn+Ce7OBn94+Qd/dQsRRY8a7d3KWO6wFmTBSbeGuBwhN+u1LpqqDir2tnwvHmtxn1pMwI
	UCZaB9hL+Dk7M4XJ+AC8WdIuV+E7oJlae5mJGfXzU2iB6+86o/lWtf1XDoiyAAs1Gsd1lI4y9+0
	hCGPz3r7igNg+l8q5rWzRRDOmnJK7AoawThRyWatnu2Uw/zql13U9dJkA4bXVCnUBoxdW8zmhXW
	rdA==
X-Received: by 2002:a05:6000:2c10:b0:47f:cb39:10c4 with SMTP id ffacd0b85a97d-482b1fd9f1emr13180340f8f.12.1787178439256;
        Wed, 19 Aug 2026 15:27:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae9e-1d01-58d3-443d-4fa6-01cd.310.pool.telefonica.de. [2a02:3100:ae9e:1d01:58d3:443d:4fa6:1cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b145153fsm8636030f8f.12.2026.08.19.15.27.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 15:27:18 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: compat: Fix decrementing LDM/STM alignment emulation
Date: Thu, 20 Aug 2026 00:27:12 +0200
Message-Id: <20260819222712.81855-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compat alignment emulator inherited unsigned long data addresses from
the 32-bit ARM implementation.

In do_alignment_ldmstm(), nr_regs is an unsigned int holding the transfer
size. The function uses the same address addition for both transfer
directions, negating nr_regs first for a decrementing LDM or STM. The
32-bit negation wraps before the addition, so the handler adds nearly
4 GiB instead of subtracting the transfer size.
The resulting address lies outside the compat task's address space, so
decrementing LDM/STM emulation fails, while incrementing forms work.

For example, a backwards-moving copy routine using decrementing LDM/STM can
take an alignment fault when called with unaligned pointers. The compat
handler should emulate the transfer, but this bug instead causes SIGBUS.

The offset negated in do_alignment_finish_ldst() is offset_union.un, which
is already unsigned long and does not have this width mismatch.

Make nr_regs unsigned long so its negation and the address arithmetic
use the same width.

Fixes: 3fc24ef32d3b ("arm64: compat: Implement misalignment fixups for multiword loads")
Cc: stable@vger.kernel.org
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
  - Narrow the fix to nr_regs, leaving the address types unchanged (Arnd).
  - Leave 32-bit address-space wraparound out of scope.
  - Add Cc: stable@vger.kernel.org now that the fix is narrowly scoped.

v1: https://lore.kernel.org/r/20260817000231.21311-1-kmehltretter@gmail.com

Tested:
  An AArch32 reproducer was run under QEMU and on a Raspberry Pi 400
  (Cortex-A72). An unaligned decrementing LDM gets SIGBUS with the baseline
  kernel and passes with v2 in both environments.

 arch/arm64/kernel/compat_alignment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/compat_alignment.c b/arch/arm64/kernel/compat_alignment.c
index b68e1d3..9b58d0a 100644
--- a/arch/arm64/kernel/compat_alignment.c
+++ b/arch/arm64/kernel/compat_alignment.c
@@ -114,8 +114,8 @@ do_alignment_ldrdstrd(unsigned long addr, u32 instr, struct pt_regs *regs)
 static int
 do_alignment_ldmstm(unsigned long addr, u32 instr, struct pt_regs *regs)
 {
-	unsigned int rd, rn, nr_regs, regbits;
-	unsigned long eaddr, newaddr;
+	unsigned int rd, rn, regbits;
+	unsigned long eaddr, newaddr, nr_regs;
 	unsigned int val;
 
 	/* count the number of registers in the mask to be transferred */
-- 
2.39.5 (Apple Git-154)

