Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C03DC857
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791622297; cv=none; b=ojEKAbzdXiZvvP/3WgsOR5VBiJ+5QbEgRfWLzA9QaWpo7duGSxt9YVVyA0ZDNYp3G0+T1iAWADzsp0UM/J1iRBjmz9++UE4RW/8nzadDNjW3TJPg4iIXX799LA5t1/U8+IOj0xOmZcsnZ6XM7rrqxrm1XWatdg2FROdIiDyF+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791622297; c=relaxed/simple;
	bh=UAqeBFGdzugClicsDvXlKmmOIm0c2lFCwoOIIya9pAY=;
	h=Cc:Message-Id:In-Reply-To:Content-Type:To:Subject:Mime-Version:
	 From:Date:References; b=GUnMPPKoQZDXfNEMkg7eUioIw0SHsniJdZNU5FIrQfIraMPfGKviKtGeoTO2Y9ioekthRY1pMtgWqshrc2gjd13TZYugrWj6/KUlnvOMm/3kuGAtsq7qPTmFTz/d3I2G8NVT/Q9SJeOvlbUaiuwaEZst/C3z5k7cPyRWBYk6O7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=nZ0PBfpY; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="nZ0PBfpY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791622282; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YYlAhLyA+W59txuVdfGlHzgN9jui63GdXPtcMpN2dC4=;
 b=nZ0PBfpYyJN6aW72PaJJuO5pFjXlSSfuTsUfTMh+dD2/6rruhTIHyoiWg8nSuM957TktW4
 eNSSomyYpTQpF+FlJwQFebSJps9tSyjsAqluNraXoPMHDQUfItEKAFuaPPt9zC7OB1Oteh
 j2yUDcOmR03pXDx68bK4nO7c/L7knrlV4jHPtJJI3/6/lGCVq/JXG+4ipCIgD4wyGQnco6
 RKtTF/a13NwSE+kZNVjl1UpMi1Hm9zcVJJrkwaupbuWa3wSGoQa585zntlv7T64jem3zvz
 V86FErFR2njnejJOO9ebPvKhumCYQTiLAgEA4eKdVZj3AWr0QXlSO4hwn0/nlA==
Cc: <mark.rutland@arm.com>, <ardb@kernel.org>, <song@kernel.org>, 
	<dylanbhatch@google.com>, <linux-arm-kernel@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, "Rui Qi" <qirui.001@bytedance.com>, 
	<stable@vger.kernel.org>
Message-Id: <20261010085055.2200241-2-qirui.001@bytedance.com>
In-Reply-To: <20261010085055.2200241-1-qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <catalin.marinas@arm.com>, <will@kernel.org>
Subject: [PATCH 3/3] arm64: module: Use text-poke for late PLT/veneer emission
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Sat, 10 Oct 2026 16:50:55 +0800
References: <20261010084721.2197683-1-qirui.001@bytedance.com> <20261010085055.2200241-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+26ac9fc88+f443a8+vger.kernel.org+qirui.001@bytedance.com>

module_emit_plt_entry() and module_emit_veneer_for_adrp() write PLT
entries into the .plt section by direct assignment.  Once a module is
fully formed its .plt is read-only/executable, so a late (livepatch)
relocation that falls back to PLT emission -- an out-of-range
R_AARCH64_CALL26/JUMP26, or an ADRP under CONFIG_ARM64_ERRATUM_843419
-- triggers a synchronous Data Abort and panics.

This is the same ROX premise that commit 91b89a634487
("arm64/module: Use text-poke API for late relocations.") handled for
the relocation writes through WRITE_PLACE(); the PLT/veneer emitters
were left using direct assignment.

The late path is reachable without remapping:
klp_write_section_relocs() applies .klp.rela.* sections through
apply_relocate_add() with the patch module already MODULE_STATE_LIVE,
so .plt is ROX.

Route the emitters through the text-poke API, mirroring WRITE_PLACE().

Fixes: 91b89a634487d5614e51ee773a889ed57f5551ca ("arm64/module: Use text-poke API for late relocations.")
Cc: stable@vger.kernel.org
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/arm64/kernel/module-plts.c | 35 ++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 7afd370da9f4..fa89ed014bd1 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -9,6 +9,29 @@
 #include <linux/module.h>
 #include <linux/moduleloader.h>
 #include <linux/sort.h>
+#include <linux/text-patching.h>
+
+/*
+ * The .plt section is marked ROX once the module is fully formed, so
+ * late (livepatch) relocations that emit PLT entries cannot use direct
+ * assignment.  Mirror WRITE_PLACE() and route the write through the
+ * text-poke API when the module is already loaded.
+ *
+ * Return: 0 on success, -EINVAL if the text-poke write failed.
+ */
+static int plt_entry_write(struct plt_entry *plt,
+			   struct plt_entry *entry, struct module *mod)
+{
+	if (mod->state == MODULE_STATE_UNFORMED) {
+		*plt = *entry;
+		return 0;
+	}
+
+	if (!aarch64_insn_copy(plt, entry, sizeof(*plt)))
+		return -EINVAL;
+
+	return 0;
+}
 
 static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,
 					    enum aarch64_insn_register reg)
@@ -76,11 +99,14 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
 	int i = pltsec->plt_num_entries;
 	int j = i - 1;
 	u64 val = sym->st_value + rela->r_addend;
+	struct plt_entry entry;
 
 	if (is_forbidden_offset_for_adrp(&plt[i].adrp))
 		i++;
 
-	plt[i] = get_plt_entry(val, &plt[i]);
+	entry = get_plt_entry(val, &plt[i]);
+	if (plt_entry_write(&plt[i], &entry, mod))
+		return 0;
 
 	/*
 	 * Check if the entry we just created is a duplicate. Given that the
@@ -107,6 +133,7 @@ u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
 	int i = pltsec->plt_num_entries++;
 	u32 br;
 	int rd;
+	struct plt_entry entry;
 
 	if (WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries))
 		return 0;
@@ -121,8 +148,10 @@ u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
 	br = aarch64_insn_gen_branch_imm((u64)&plt[i].br, (u64)loc + 4,
 					 AARCH64_INSN_BRANCH_NOLINK);
 
-	plt[i] = __get_adrp_add_pair(val, (u64)&plt[i], rd);
-	plt[i].br = cpu_to_le32(br);
+	entry = __get_adrp_add_pair(val, (u64)&plt[i], rd);
+	entry.br = cpu_to_le32(br);
+	if (plt_entry_write(&plt[i], &entry, mod))
+		return 0;
 
 	return (u64)&plt[i];
 }
-- 
2.20.1
