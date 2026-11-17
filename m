Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915363;
	b=R6OCLAVEtb72R9hYpZ7bj6goo5dEQTwGT+TFjJ5HkwcLB+PfHDvta5Vazw5oQXPTxD3n
	 cORkRnM+mcPURk2FI0v7t8JMRVLWBx13JvPLCgJC/qJWPYw26tddHcwY786OqUBKauwT9
	 /xA7JCwf8RAm3d36CMGIOWKCUrh5D4vY7EOT8hhPX4iDjsq5GKo/qZxhAPf1dfczptXcX
	 PaMmR6A4b9jUSXZnLG6jYEN+U0lxO1Pv2c5bquPl/q5vh4YQ/Z2io4cagRTFqzDYAgzT3
	 S4DEg6Qj1j7axqQdaFNZn7SWGh0eO6acJp60BmAabiu+Wf1KY2WVHU/o+V6+TvVq25A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915363;
	h=DMARC-Filter:DKIM-Signature:X-Mailer:From:Date:Message-Id:
	 Content-Transfer-Encoding:To:Cc:Subject:Mime-Version:X-Original-From:
	 X-Lms-Return-Path:Content-Type;
	bh=mj2r4cIuKc2qJcTEco5uEZ1BXmGp0wRkfe/FJDaNSco=;
	b=rL+kCjqp/rGdE1Zx05dJNVaQYFlejkOk3QZVl9UubzYEYr8fyzX2Ok5jmDivk0xtmINr
	 7z3kt58n33UKbPWimKhloiW8IxrY5Xvj6iEl33rtMyL64iJ8eMzU7V+7hM9Q/ZYGlllSM
	 l6Ws/pcFModk+viMeXXWm/nmivsNWXs6zhzHPV6tya588jM1L1W3I5R9UOnXg6lhm6mBu
	 t5qRdFUAvAzejZOAWfQvJEtXKOR/2GB0oSrXBzN+j9YiorCmYzkRhhGsoG8cHeJj1Y89Q
	 zL8mm3vSQccKnmqbW+/hF/7b7ka+/Or8x2B6sVk9BWZ9IhUgFNr1rIjnCtXhWvJFN5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=WYtKa8sh;
	arc=none smtp.remote-ip=209.127.230.111
Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0A606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C0A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=WYtKa8sh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794915358; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=mj2r4cIuKc2qJcTEco5uEZ1BXmGp0wRkfe/FJDaNSco=;
 b=WYtKa8shKaPTVmRoVIIRUt7dv/8VVz2z5RH2O4m8b/DsEf4JX4qcCmpyYygfj7dOCfMIzt
 49BR3iw8y6UhQVK/85KAxmX/hI5t3M/0JnwUXEqMqSkCYVDHhnjgWMSrzZ/lkbI6GFqHth
 LBUnjmIG90cgwUtD49gY5taZG2707rT2Ab23vyE61XRqG6uN8mmaRaIRDMmaXfr8SwmfB9
 9S+q0JCK427PXV5FAUyWE/lZ5yL+ewuaul2gLG1SAqmAFvy2UeWHy1rwRDazU32wnnHadH
 Lg2EF5lvK5eoXq9fQ90sKVGIH8+Kn39lh7KSV4DdtjznqGmcTTE3znexIGkPrw==
X-Mailer: git-send-email 2.20.1
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Tue, 17 Nov 2026 19:35:35 +0800
Message-Id: <20261117113535.399407-1-qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <catalin.marinas@arm.com>, <will@kernel.org>
Cc: <mark.rutland@arm.com>, <dylanbhatch@google.com>, <song@kernel.org>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	"Rui Qi" <qirui.001@bytedance.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] arm64: module: Use text-poke for late PLT/veneer emission
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+26afc3c1c+8fa5f1+vger.kernel.org+qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8

module_emit_plt_entry() and module_emit_veneer_for_adrp() write PLT
entries into the .plt section by direct assignment.  Once a module is
fully formed its .plt is read-only/executable, so a late (livepatch)
relocation that falls back to PLT emission -- an out-of-range
R_AARCH64_CALL26/JUMP26, or an ADRP under CONFIG_ARM64_ERRATUM_843419
-- triggers a synchronous Data Abort and panics.

This is the same ROX premise that commit 91b89a634487 ("arm64/module:
Use text-poke API for late relocations.") handled for the relocation
writes through WRITE_PLACE(); the PLT/veneer emitters were left using
direct assignment.

The late path is reachable without remapping: klp_write_section_relocs()
applies .klp.rela.* sections through apply_relocate_add() with the patch
module already MODULE_STATE_LIVE, so .plt is ROX.

Route the emitters through the same text-poke write path the relocation
code already uses.  The write helper is moved from asm/module.h (which
linux/module.h pulls into nearly every translation unit) to
asm/text-patching.h and turned into an out-of-line function; a static
inline is not possible there because it dereferences mod->state and
would require linux/module.h, which is circular (linux/module.h ->
asm/module.h -> text-patching.h).

Once late writes go through text-poke they no longer fault on the ROX
mapping, so PLT slot exhaustion -- e.g. when livepatch relocations are
reapplied without resetting plt_num_entries -- would silently overwrite
memory beyond .plt instead of faulting.  Add a bounds check before each
write so exhaustion fails cleanly with -ENOEXEC instead of corrupting
memory.

Fixes: 91b89a634487 ("arm64/module: Use text-poke API for late relocations.")
Cc: stable@vger.kernel.org
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
Changes in v3 (feedback from Catalin Marinas):
- Move the module_write_place() helper out of asm/module.h (which
  linux/module.h pulls into nearly every TU) into asm/text-patching.h
  and turn it into an out-of-line function.
- Add a bounds check before the PLT write so slot exhaustion fails
  cleanly with -ENOEXEC instead of overwriting memory beyond .plt.
  module_emit_plt_entry() previously wrote before its post-write
  WARN_ON; the check now runs before the write and the redundant
  post-write WARN_ON is dropped.  module_emit_veneer_for_adrp() is
  restructured so its single check covers the erratum forbidden-offset
  bump as well.

Changes in v2 (feedback from Catalin Marinas on v1 patch 3):
- Unify the PLT/veneer write helper with the relocation WRITE_PLACE()
  macro into a single module_write_place() helper in asm/module.h,
  used by both module.c (relocations) and module-plts.c (PLT/veneer
  emitters), instead of a separate plt_entry_write() helper.
- Drop the redundant !aarch64_insn_copy() NULL check: the destination
  is always 4-byte aligned for struct plt_entry, and __text_poke()
  never returns NULL, so the check guards an impossible condition.
- Drop the big-endian byte-order fix patches (patches 1 and 2 of the
  v1 series); arm64 big-endian support is being removed.  This patch
  is now standalone.

 arch/arm64/include/asm/text-patching.h | 11 ++++++
 arch/arm64/kernel/module-plts.c        | 23 +++++++----
 arch/arm64/kernel/module.c             | 53 +++++++++++++++++---------
 3 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/text-patching.h b/arch/arm64/include/asm/text-patching.h
index 587bdb91ab7a..b728a1e82a5c 100644
--- a/arch/arm64/include/asm/text-patching.h
+++ b/arch/arm64/include/asm/text-patching.h
@@ -14,4 +14,15 @@ void *aarch64_insn_copy(void *dst, void *src, size_t len);
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
 
+struct module;
+
+/*
+ * Write @len bytes from @val to @place within a module.  While the module is
+ * MODULE_STATE_UNFORMED the destination is writable and a plain copy is used;
+ * once the module is fully formed the region is read-only and executable, so
+ * the write is routed through the text-poke API.
+ */
+void module_write_place(void *place, const void *val, size_t len,
+			struct module *mod);
+
 #endif	/* __ASM_PATCHING_H */
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 7afd370da9f4..66680a1f46ea 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -10,6 +10,8 @@
 #include <linux/moduleloader.h>
 #include <linux/sort.h>
 
+#include <asm/text-patching.h>
+
 static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,
 					    enum aarch64_insn_register reg)
 {
@@ -76,11 +78,16 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
 	int i = pltsec->plt_num_entries;
 	int j = i - 1;
 	u64 val = sym->st_value + rela->r_addend;
+	struct plt_entry entry;
 
 	if (is_forbidden_offset_for_adrp(&plt[i].adrp))
 		i++;
 
-	plt[i] = get_plt_entry(val, &plt[i]);
+	if (WARN_ON_ONCE(i >= pltsec->plt_max_entries))
+		return 0;
+
+	entry = get_plt_entry(val, &plt[i]);
+	module_write_place(&plt[i], &entry, sizeof(entry), mod);
 
 	/*
 	 * Check if the entry we just created is a duplicate. Given that the
@@ -91,8 +98,6 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
 		return (u64)&plt[j];
 
 	pltsec->plt_num_entries += i - j;
-	if (WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries))
-		return 0;
 
 	return (u64)&plt[i];
 }
@@ -107,13 +112,14 @@ u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
 	int i = pltsec->plt_num_entries++;
 	u32 br;
 	int rd;
-
-	if (WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries))
-		return 0;
+	struct plt_entry entry;
 
 	if (is_forbidden_offset_for_adrp(&plt[i].adrp))
 		i = pltsec->plt_num_entries++;
 
+	if (WARN_ON_ONCE(pltsec->plt_num_entries > pltsec->plt_max_entries))
+		return 0;
+
 	/* get the destination register of the ADRP instruction */
 	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD,
 					  le32_to_cpup((__le32 *)loc));
@@ -121,8 +127,9 @@ u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
 	br = aarch64_insn_gen_branch_imm((u64)&plt[i].br, (u64)loc + 4,
 					 AARCH64_INSN_BRANCH_NOLINK);
 
-	plt[i] = __get_adrp_add_pair(val, (u64)&plt[i], rd);
-	plt[i].br = cpu_to_le32(br);
+	entry = __get_adrp_add_pair(val, (u64)&plt[i], rd);
+	entry.br = cpu_to_le32(br);
+	module_write_place(&plt[i], &entry, sizeof(entry), mod);
 
 	return (u64)&plt[i];
 }
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 24adb581af0e..a8219e604f55 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -18,6 +18,7 @@
 #include <linux/moduleloader.h>
 #include <linux/random.h>
 #include <linux/scs.h>
+#include <linux/string.h>
 
 #include <asm/alternative.h>
 #include <asm/insn.h>
@@ -49,14 +50,14 @@ static u64 do_reloc(enum aarch64_reloc_op reloc_op, __le32 *place, u64 val)
 	return 0;
 }
 
-#define WRITE_PLACE(place, val, mod) do {				\
-	__typeof__(val) __val = (val);					\
-									\
-	if (mod->state == MODULE_STATE_UNFORMED)			\
-		*(place) = __val;					\
-	else								\
-		aarch64_insn_copy(place, &(__val), sizeof(*place));	\
-} while (0)
+void module_write_place(void *place, const void *val, size_t len,
+			struct module *mod)
+{
+	if (mod->state == MODULE_STATE_UNFORMED)
+		memcpy(place, val, len);
+	else
+		aarch64_insn_copy(place, (void *)val, len);
+}
 
 static int reloc_data(enum aarch64_reloc_op op, void *place, u64 val, int len,
 		      struct module *me)
@@ -76,8 +77,10 @@ static int reloc_data(enum aarch64_reloc_op op, void *place, u64 val, int len,
 	 */
 
 	switch (len) {
-	case 16:
-		WRITE_PLACE((s16 *)place, sval, me);
+	case 16: {
+		s16 v = sval;
+
+		module_write_place(place, &v, sizeof(v), me);
 		switch (op) {
 		case RELOC_OP_ABS:
 			if (sval < 0 || sval > U16_MAX)
@@ -92,8 +95,11 @@ static int reloc_data(enum aarch64_reloc_op op, void *place, u64 val, int len,
 			return 0;
 		}
 		break;
-	case 32:
-		WRITE_PLACE((s32 *)place, sval, me);
+	}
+	case 32: {
+		s32 v = sval;
+
+		module_write_place(place, &v, sizeof(v), me);
 		switch (op) {
 		case RELOC_OP_ABS:
 			if (sval < 0 || sval > U32_MAX)
@@ -108,9 +114,13 @@ static int reloc_data(enum aarch64_reloc_op op, void *place, u64 val, int len,
 			return 0;
 		}
 		break;
-	case 64:
-		WRITE_PLACE((s64 *)place, sval, me);
+	}
+	case 64: {
+		s64 v = sval;
+
+		module_write_place(place, &v, sizeof(v), me);
 		break;
+	}
 	default:
 		pr_err("Invalid length (%d) for data relocation\n", len);
 		return 0;
@@ -130,6 +140,7 @@ static int reloc_insn_movw(enum aarch64_reloc_op op, __le32 *place, u64 val,
 	u64 imm;
 	s64 sval;
 	u32 insn = le32_to_cpu(*place);
+	__le32 v;
 
 	sval = do_reloc(op, place, val);
 	imm = sval >> lsb;
@@ -157,7 +168,9 @@ static int reloc_insn_movw(enum aarch64_reloc_op op, __le32 *place, u64 val,
 
 	/* Update the instruction with the new encoding. */
 	insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_16, insn, imm);
-	WRITE_PLACE(place, cpu_to_le32(insn), me);
+	v = cpu_to_le32(insn);
+
+	module_write_place(place, &v, sizeof(v), me);
 
 	if (imm > U16_MAX)
 		return -ERANGE;
@@ -172,6 +185,7 @@ static int reloc_insn_imm(enum aarch64_reloc_op op, __le32 *place, u64 val,
 	u64 imm, imm_mask;
 	s64 sval;
 	u32 insn = le32_to_cpu(*place);
+	__le32 v;
 
 	/* Calculate the relocation value. */
 	sval = do_reloc(op, place, val);
@@ -183,7 +197,9 @@ static int reloc_insn_imm(enum aarch64_reloc_op op, __le32 *place, u64 val,
 
 	/* Update the instruction's immediate field. */
 	insn = aarch64_insn_encode_immediate(imm_type, insn, imm);
-	WRITE_PLACE(place, cpu_to_le32(insn), me);
+	v = cpu_to_le32(insn);
+
+	module_write_place(place, &v, sizeof(v), me);
 
 	/*
 	 * Extract the upper value bits (including the sign bit) and
@@ -205,6 +221,7 @@ static int reloc_insn_adrp(struct module *mod, Elf64_Shdr *sechdrs,
 			   __le32 *place, u64 val, struct module *me)
 {
 	u32 insn;
+	__le32 v;
 
 	if (!is_forbidden_offset_for_adrp(place))
 		return reloc_insn_imm(RELOC_OP_PAGE, place, val, 12, 21,
@@ -224,7 +241,9 @@ static int reloc_insn_adrp(struct module *mod, Elf64_Shdr *sechdrs,
 						   AARCH64_INSN_BRANCH_NOLINK);
 	}
 
-	WRITE_PLACE(place, cpu_to_le32(insn), me);
+	v = cpu_to_le32(insn);
+
+	module_write_place(place, &v, sizeof(v), me);
 	return 0;
 }
 
-- 
2.20.1
