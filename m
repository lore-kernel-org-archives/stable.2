Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553DB26E718
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748350; cv=none; b=X/ZDaerncVq1Ouo1ubA6E8tTYRj+1m1RucjnBysZZIVdCxmTde6K02a1dbE/PvpwWVRVCsejwYupfrjwt9YIxDCO3njeuvZeX1Hc9vF9q8A6e4/JAXjxV40l5Nrzeg8hOvvhcEiLVXx056/xtWWl6nezBuq6XyneJuCOARHYFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748350; c=relaxed/simple;
	bh=ZgIT9WHdATv15SVZLWnDEPmM6DUoPhRnaXjhuxHW7JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2+8AqvyGDBfD1h0SjY2ccryPaElD2j8yuhKh3ZWTZrCvjU2ARTwDTSouQBZPc8tymy22wXXAFNjLQZI5jU7WapM0QgupUyt8zMxs7XWmga3sbEb0FvyIIaTvKB2K9xtNn46DBPDTBuY1rS1si9ZwZaFiDF7B45VHRYy8h93Yz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeXmBeS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeXmBeS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB791F00893;
	Sat,  6 Jun 2026 12:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748349;
	bh=qdRVJkPGMyGZq5lZ7Z07g6/Uvk0PfXInjQ6xyaqJwDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZeXmBeS5b/oUNX1PSy9MUN29VoEJCxZOlqQQkT5wqLRgoYc/RUKkgeOFIGnwixz9k
	 Fkvsl2Ka1gL2KwFqOmS/C43JNkXSsjsiclctN+HemfwLv37hobjC7/CmR3rG9j26gC
	 uKlQ9ppazsrQ8iDRlVJR1h3JlSKsQF7yx3s8XJLnSIa0lNTp6lEECgMSmZ/OSrFcJw
	 mX3/KdwgIta6e5ISfS1C4h8lp0r8YP+A9PrEHY/Oz92t9jnCtjeilKEAIdt4lu7/jn
	 gFlS3/JTvPpRNLkd7G1jwtFQcpa4EsZLb99zd8TYWGk8NFB4PJQjjCqimrCuV7+TI9
	 mvpheUBl8r9Xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] x86/alternatives: Rename 'apply_relocation()' to 'text_poke_apply_relocation()'
Date: Sat,  6 Jun 2026 08:19:05 -0400
Message-ID: <20260606121906.2851584-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060417-mounting-subarctic-8502@gregkh>
References: <2026060417-mounting-subarctic-8502@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ingo Molnar <mingo@kernel.org>

[ Upstream commit 023f42dd59203be8ad2fc0574af32d3b4ad041ec ]

Join the text_poke_*() API namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-52-mingo@kernel.org
Stable-dep-of: a17dc12bfed8 ("x86/ftrace: Relocate %rip-relative percpu refs in dynamic trampolines")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/text-patching.h | 2 +-
 arch/x86/kernel/alternative.c        | 6 +++---
 arch/x86/kernel/callthunks.c         | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 6259f1937fe77e..bb3fd7f2c2d4a3 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -15,7 +15,7 @@
 
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
-extern void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len);
+extern void text_poke_apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len);
 
 /*
  * Clear and restore the kernel write-protection flag on the local CPU.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6ab96bc764cfaa..a0550398313d80 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -502,7 +502,7 @@ static void __apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen,
 	}
 }
 
-void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len)
+void text_poke_apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len)
 {
 	__apply_relocation(buf, instr, instrlen, repl, repl_len);
 	optimize_nops(instr, buf, instrlen);
@@ -658,7 +658,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-		apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replacementlen);
+		text_poke_apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replacementlen);
 
 		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
 		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
@@ -1865,7 +1865,7 @@ __visible noinline void __init __alt_reloc_selftest(void *arg)
 static noinline void __init alt_reloc_selftest(void)
 {
 	/*
-	 * Tests apply_relocation().
+	 * Tests text_poke_apply_relocation().
 	 *
 	 * This has a relative immediate (CALL) in a place other than the first
 	 * instruction and additionally on x86_64 we get a RIP-relative LEA:
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index f17d166078823c..dd602d2ed126f0 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -180,7 +180,7 @@ static void *patch_dest(void *dest, bool direct)
 	u8 *pad = dest - tsize;
 
 	memcpy(insn_buff, skl_call_thunk_template, tsize);
-	apply_relocation(insn_buff, pad, tsize, skl_call_thunk_template, tsize);
+	text_poke_apply_relocation(insn_buff, pad, tsize, skl_call_thunk_template, tsize);
 
 	/* Already patched? */
 	if (!bcmp(pad, insn_buff, tsize))
@@ -302,7 +302,7 @@ static bool is_callthunk(void *addr)
 	pad = (void *)(dest - tmpl_size);
 
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
-	apply_relocation(insn_buff, pad, tmpl_size, skl_call_thunk_template, tmpl_size);
+	text_poke_apply_relocation(insn_buff, pad, tmpl_size, skl_call_thunk_template, tmpl_size);
 
 	return !bcmp(pad, insn_buff, tmpl_size);
 }
@@ -320,7 +320,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
 		return 0;
 
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
-	apply_relocation(insn_buff, ip, tmpl_size, skl_call_thunk_template, tmpl_size);
+	text_poke_apply_relocation(insn_buff, ip, tmpl_size, skl_call_thunk_template, tmpl_size);
 
 	memcpy(*pprog, insn_buff, tmpl_size);
 	*pprog += tmpl_size;
-- 
2.53.0

