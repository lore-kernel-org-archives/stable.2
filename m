Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17E43AB0;
	Sat, 19 Sep 2026 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789832520; cv=none; b=ME+HrFRBxUhZqTOD6Ey6RYmTs+3Yy2hrqsJXKOI2oLFmdCKXWTjgt3oOV3eHhQB9HF6Di85+FcpKuRZDaR7BExHy8riGbu2xghz8Rgq1P99WM7FxcwoxACUePyeyaKAiE3YCFqsd1+vx+RbgrhojEAbaKNPYRJSo6syVZrlyMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789832520; c=relaxed/simple;
	bh=LYiZl+WOHNSO4n6Gc8EKV7X5LB2Z4F9TAU5gRUGvOKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Men+KAWJCPOwAe6Uzd8754hiW+HunFpn4Ac9j2T+tviYYVqCs4K153XW8swhWhABou11OApZXpIaQktKQNsF0476iQ7MFoi7TMpZyRR9ZAF/97Yw+tu9tI7SDNtnDs+u7O4PPgwyOm0C46XcsdmN/2v+dsfUZh1Cfb4phPDl450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=rVAQtq3X; arc=none smtp.client-ip=115.124.28.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="rVAQtq3X"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789832502; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OJ2hAYWcDFc6IElR3pmiBTTlx6KjakHAb7QlNaS0XAQ=;
	b=rVAQtq3XwIdilf4iEIgKzdKUY8Cs3vSLa8eL97t0Mkjzfa1UuRwHPsUR14eu7UyuCV6maRPThVGtCM45L/2UK1i/gwm3gkDTJCl5zDi5am2qKeBtca2eEOChRIexADWMN+LBrFaW3DWeJ90626aK18ORxTszcV0NcN/1UR4Ge90=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0547553-0.000500871-0.944744;FP=5598000967577699419|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jHWy4NM_1789832500;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jHWy4NM_1789832500 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 19 Sep 2026 23:41:41 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com
Cc: mmaurer@google.com,
	masahiroy@kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] module: Validate the __version_ext_names section type
Date: Sat, 19 Sep 2026 23:41:39 +0800
Message-ID: <20260919154139.52904-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

elf_validity_cache_sechdrs() validates the size and offset of
every section, unless its type is SHT_NULL or SHT_NOBITS:

		switch (shdr->sh_type) {
		case SHT_NULL:
		case SHT_NOBITS:
			/* No contents, offset/size don't mean anything */
			continue;
		default:
			err = validate_section_offset(info, shdr);

elf_validity_cache_index_versions() then reads the extended version
names by their sh_offset, without checking that the section holds
data:

	if (vers_ext_crc) {
		crc_count = info->sechdrs[vers_ext_crc].sh_size / sizeof(u32);
		name = (void *)info->hdr +
			info->sechdrs[vers_ext_name].sh_offset;
		remaining_len = info->sechdrs[vers_ext_name].sh_size;
		while (crc_count--) {
			name_size = strnlen(name, remaining_len) + 1;

A SHT_NOBITS __version_ext_names reaches here with an sh_offset the
validator never bounded; past the end of the module the name lookup
reads out of bounds:

  BUG: KASAN: vmalloc-out-of-bounds in strnlen+0x73/0x80
  Read of size 1 at addr ffa00000005534ff by task insmod/79
  ...
   strnlen+0x73/0x80
   load_module+0xef6/0x8600
  The buggy address belongs to a 43-page vmalloc region starting at
  0xffa0000000529000 allocated at kernel_read_file+0x7b4/0x9f0

This runs after module_sig_check() but before the blacklist check in
early_mod_check(). Commit 9a5ff4568932 ("module: validate string table
section types") closed the same class for .shstrtab and .strtab, but
not this section.

Bounding the offset is not enough: an in-bounds SHT_NOBITS section
still passes it, and the walk reads unrelated file data as a version
name. A real __version_ext_names is SHT_PROGBITS, already offset-bounded
by elf_validity_cache_sechdrs(), so require that type, matching the
string-table checks.

Fixes: 54ac1ac8edeb ("modules: Support extended MODVERSIONS info")
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

Standalone resubmission of the __version_ext_names fix that was patch 2/2 of
"[PATCH v2 0/2] module: close two ELF section-validation gaps" (Message-ID
20260917190618.94759-1-fangxy@xiaopeng.com). The series is split: patch 1/2
(the SHT_NULL sh_name fix) is withdrawn because Liu Chao posted a cleaner
fail-closed fix for the same bug ("[PATCH] module: validate sh_name for
SHT_NULL sections", 20260905110813.150411-1-liuc63@xiaopeng.com), which drops
the SHT_NULL special case entirely instead of sanitizing sh_name to 0. This
patch does not depend on it and stands alone.

Changes in v3:
  - Split from the two-patch series and rebased onto mainline; sent as a
    single patch with no cover letter.
  - Corrected the function name in the changelog and the in-code comment:
    elf_validity_check_sectionheaders() does not exist in the tree, the
    validator is elf_validity_cache_sechdrs().
  - Noted where the read sits in load_module(): after module_sig_check() and
    before the blacklist check in early_mod_check(), matching the rationale
    for commit 9a5ff4568932 ("module: validate string table section types"),
    which closed the same class for .shstrtab and .strtab but not this
    section.
  - No change to the check itself: still reject sh_type != SHT_PROGBITS.

v1 bounded the offset with validate_section_offset(). Review pointed out that
is narrower than the bug: a SHT_NOBITS section whose sh_offset is in bounds
still passes the bound, and the walk then reads whatever file bytes sit there
as a version name, which violates ELF semantics (SHT_NOBITS holds no file
data). v2 requires the section to be SHT_PROGBITS instead, so both the
out-of-bounds and the in-bounds SHT_NOBITS cases are rejected, while a real
names section (SHT_PROGBITS, already offset-checked) is unaffected.

Reproducer, two variants of a .ko carrying __version_ext_crcs and a
__version_ext_names of type SHT_NOBITS:
  - sh_offset past the end of the module image. Before: the name walk reads
    out of bounds (KASAN vmalloc-out-of-bounds in strnlen). After: rejected.
  - sh_offset in bounds, aimed at other file data (the harness points it at
    the relocated .shstrtab). Before: the walk silently consumes those bytes
    as a version name and the module is accepted; no splat fires, so a
    crash-only check scores it clean. After: rejected.
Both variants fail insmod with -ENOEXEC (rc=8, "invalid module format") on the
patched kernel, which is what a module with a malformed version section should
do.

Both cases ran on 704340f1cd0d (9 commits past v7.3-rc3): x86_64 defconfig plus
CONFIG_KASAN_GENERIC and CONFIG_KASAN_VMALLOC, gcc 13.2.0, QEMU under TCG. The
unpatched and patched kernels are built from byte-identical .config files and
differ only by this patch.

LOCALVERSION is pinned so the patched kernel's release string matches the
payload and the loader reaches the version walk instead of stopping at the
version magic check.

 kernel/module/main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0b..183e3e2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2287,6 +2287,22 @@ static int elf_validity_cache_index_versions(struct load_info *info, int flags)
 	 * number of entries in every section.
 	 */
 	if (vers_ext_crc) {
+		/*
+		 * The names section is read below as hdr + sh_offset, so it
+		 * must hold file data. A real one is SHT_PROGBITS.
+		 * elf_validity_cache_sechdrs() exempts SHT_NULL and
+		 * SHT_NOBITS from validate_section_offset() on the assumption
+		 * they have no contents, so a SHT_NOBITS __version_ext_names
+		 * would reach the walk with an offset that was never bounded.
+		 * Require the type; a SHT_PROGBITS section is already bounded
+		 * there, so its sh_offset is safe to dereference.
+		 */
+		if (info->sechdrs[vers_ext_name].sh_type != SHT_PROGBITS) {
+			pr_err("Invalid ELF __version_ext_names type: %u\n",
+			       info->sechdrs[vers_ext_name].sh_type);
+			return -ENOEXEC;
+		}
+
 		crc_count = info->sechdrs[vers_ext_crc].sh_size / sizeof(u32);
 		name = (void *)info->hdr +
 			info->sechdrs[vers_ext_name].sh_offset;
-- 
2.50.1 (Apple Git-155)

