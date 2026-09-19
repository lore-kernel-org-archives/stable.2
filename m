Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB554136351;
	Sat, 19 Sep 2026 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835596; cv=none; b=txyZn+EBEI+tcUahUCKX1nrgsfENnu8Pbmtc6AU8uZq/mEhnPiuS8ztu4J1o6XqpSQWwA1lvMXa5lC7YBbRFPIBdw4rEVA8eGNQuDmTUgBZREskeYdOUilyd6Lc6rUes4bh7rNjsPMoPHXRl16fK0EKMxRypy7dCXfXcIVvXass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835596; c=relaxed/simple;
	bh=e8HneWoXT/vfDlKxTSBn3OdiiHQbSjpkDN74PNmdzE8=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=LSCbtxg0Ht0G3f/fguG9kHTx6yMlCM12BevlEeqTWNpYXnn5xcIB5E2IDcIGPmjVCL6iSrDUfZPk7xhXX+IMa5Ad++Kp1TTFdiErDWquevKiICqlS+JEhYjCb5lrb71ulX0+RkeiDrKw2r2DbaE4ysnpkmqp9DGI+HrXdYqf3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qt8nwts5; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=6zu75718; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qt8nwts5";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="6zu75718"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789835569; bh=JTdqrtAlDyYHn/03deEE90g
	5plTe4MQOLGGVBXfd5Ys=; b=qt8nwts5Q7ofd0i7r4i76UwCXHUqWhpq/o2jj7NOWL7S8PAwZc
	XLrSh4KLS20tN2pkKpjSTSbEbQE/8n5ifAovYTxRb6A0agYa4e/yZy41/p1H5lqUpAGOGyXAZnG
	qZ9zTEKlqGRNJnOIAP4OMFAQiQXInVPake2akEU5aufLCFRKeqS4/iJUOyAcDBB6jRJa8dzK3ZV
	g3ydEs5yE7aH2LPsWXr50/impArlDqkGxT0pjNbRlUQMM938PMdNEoC9+V+NEyFKn7JRzrxyR8L
	cqzQY/dhsWIQfA5Iu2fV5LD+RI0QMUYLzLcnYEK33DF1utcRbYeq2op9xpnuTgtAMug==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789835569; bh=JTdqrtAlDyYHn/03deEE90g
	5plTe4MQOLGGVBXfd5Ys=; b=6zu75718CH6WsBowwV9q7aOAQmI1IR1KDu2hmMcsnVY2O4slK1
	ofK40KmX6dXUe+msuGSkvtrbVxT1vfA+reAw==;
Date: Sat, 19 Sep 2026 17:32:50 +0100
From: Bradley Morgan <brads@mainlining.org>
To: fangxy@xiaopeng.com
CC: atomlin@atomlin.com, da.gomez@kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
 mmaurer@google.com, petr.pavlu@suse.com, samitolvanen@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] module: Validate the __version_ext_names section type
In-Reply-To: <20260919154139.52904-1-fangxy@xiaopeng.com>
Message-ID: <C04CC94F-26D0-4823-84F4-7AFEBCDCA9AE@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 September 2026 16:41:39 BST, Fang Xieyan <fangxy@xiaopeng.com> wrote:
>elf_validity_cache_sechdrs() validates the size and offset of
>every section, unless its type is SHT_NULL or SHT_NOBITS:
>
>		switch (shdr->sh_type) {
>		case SHT_NULL:
>		case SHT_NOBITS:
>			/* No contents, offset/size don't mean anything */
>			continue;
>		default:
>			err = validate_section_offset(info, shdr);
>
>elf_validity_cache_index_versions() then reads the extended version
>names by their sh_offset, without checking that the section holds
>data:
>
>	if (vers_ext_crc) {
>		crc_count = info->sechdrs[vers_ext_crc].sh_size / sizeof(u32);
>		name = (void *)info->hdr +
>			info->sechdrs[vers_ext_name].sh_offset;
>		remaining_len = info->sechdrs[vers_ext_name].sh_size;
>		while (crc_count--) {
>			name_size = strnlen(name, remaining_len) + 1;
>
>A SHT_NOBITS __version_ext_names reaches here with an sh_offset the
>validator never bounded; past the end of the module the name lookup
>reads out of bounds:
>
>  BUG: KASAN: vmalloc-out-of-bounds in strnlen+0x73/0x80
>  Read of size 1 at addr ffa00000005534ff by task insmod/79
>  ...
>   strnlen+0x73/0x80
>   load_module+0xef6/0x8600
>  The buggy address belongs to a 43-page vmalloc region starting at
>  0xffa0000000529000 allocated at kernel_read_file+0x7b4/0x9f0
>
>This runs after module_sig_check() but before the blacklist check in
>early_mod_check(). Commit 9a5ff4568932 ("module: validate string table
>section types") closed the same class for .shstrtab and .strtab, but
>not this section.
>
>Bounding the offset is not enough: an in-bounds SHT_NOBITS section
>still passes it, and the walk reads unrelated file data as a version
>name. A real __version_ext_names is SHT_PROGBITS, already offset-bounded
>by elf_validity_cache_sechdrs(), so require that type, matching the
>string-table checks.
>
>Fixes: 54ac1ac8edeb ("modules: Support extended MODVERSIONS info")
>Cc: stable@vger.kernel.org
>Assisted-by: Hawkeye:GLM-5.3-flash
>Assisted-by: Qoder:Qwen3.8-Max
>Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
>---
>
>Standalone resubmission of the __version_ext_names fix that was patch 2/2
>of
>"[PATCH v2 0/2] module: close two ELF section-validation gaps" (Message-ID
>20260917190618.94759-1-fangxy@xiaopeng.com). The series is split: patch
>1/2
>(the SHT_NULL sh_name fix) is withdrawn because Liu Chao posted a cleaner
>fail-closed fix for the same bug ("[PATCH] module: validate sh_name for
>SHT_NULL sections", 20260905110813.150411-1-liuc63@xiaopeng.com), which
>drops
>the SHT_NULL special case entirely instead of sanitizing sh_name to 0.
>This
>patch does not depend on it and stands alone.
>
>Changes in v3:
>  - Split from the two-patch series and rebased onto mainline; sent as a
>    single patch with no cover letter.
>  - Corrected the function name in the changelog and the in-code comment:
>    elf_validity_check_sectionheaders() does not exist in the tree, the
>    validator is elf_validity_cache_sechdrs().
>  - Noted where the read sits in load_module(): after module_sig_check() and
>    before the blacklist check in early_mod_check(), matching the rationale
>    for commit 9a5ff4568932 ("module: validate string table section types"),
>    which closed the same class for .shstrtab and .strtab but not this
>    section.
>  - No change to the check itself: still reject sh_type != SHT_PROGBITS.
>
>v1 bounded the offset with validate_section_offset(). Review pointed out
>that
>is narrower than the bug: a SHT_NOBITS section whose sh_offset is in
>bounds
>still passes the bound, and the walk then reads whatever file bytes sit
>there
>as a version name, which violates ELF semantics (SHT_NOBITS holds no file
>data). v2 requires the section to be SHT_PROGBITS instead, so both the
>out-of-bounds and the in-bounds SHT_NOBITS cases are rejected, while a
>real
>names section (SHT_PROGBITS, already offset-checked) is unaffected.
>
>Reproducer, two variants of a .ko carrying __version_ext_crcs and a
>__version_ext_names of type SHT_NOBITS:
>  - sh_offset past the end of the module image. Before: the name walk reads
>    out of bounds (KASAN vmalloc-out-of-bounds in strnlen). After: rejected.
>  - sh_offset in bounds, aimed at other file data (the harness points it at
>    the relocated .shstrtab). Before: the walk silently consumes those bytes
>    as a version name and the module is accepted; no splat fires, so a
>    crash-only check scores it clean. After: rejected.
>Both variants fail insmod with -ENOEXEC (rc=8, "invalid module format") on
>the
>patched kernel, which is what a module with a malformed version section
>should
>do.
>
>Both cases ran on 704340f1cd0d (9 commits past v7.3-rc3): x86_64 defconfig
>plus
>CONFIG_KASAN_GENERIC and CONFIG_KASAN_VMALLOC, gcc 13.2.0, QEMU under TCG.
>The
>unpatched and patched kernels are built from byte-identical .config files
>and
>differ only by this patch.
>
>LOCALVERSION is pinned so the patched kernel's release string matches the
>payload and the loader reaches the version walk instead of stopping at the
>version magic check.
>
> kernel/module/main.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
>diff --git a/kernel/module/main.c b/kernel/module/main.c
>index d0e1e0b..183e3e2 100644
>--- a/kernel/module/main.c
>+++ b/kernel/module/main.c
>@@ -2287,6 +2287,22 @@ static int elf_validity_cache_index_versions(struct load_info *info, int flags)
> 	 * number of entries in every section.
> 	 */
> 	if (vers_ext_crc) {
>+		/*
>+		 * The names section is read below as hdr + sh_offset, so it
>+		 * must hold file data. A real one is SHT_PROGBITS.
>+		 * elf_validity_cache_sechdrs() exempts SHT_NULL and
>+		 * SHT_NOBITS from validate_section_offset() on the assumption
>+		 * they have no contents, so a SHT_NOBITS __version_ext_names
>+		 * would reach the walk with an offset that was never bounded.
>+		 * Require the type; a SHT_PROGBITS section is already bounded
>+		 * there, so its sh_offset is safe to dereference.
>+		 */

Jesus that comment is huge, did you use AI?

I'm sure I could shorten this

/* sht_nobits skips offset validation so require sht_progbits */

That's it. But this isn't necessarily the "perfect" sort of comment. So it
could be bikeshedded

if (info->sechdrs[vers_ext_name].sh_type != SHT_PROGBITS) {
	pr_err("Invalid ELF __version_ext_names type: %u\n",
	       info->sechdrs[vers_ext_name].sh_type);
	return -ENOEXEC;
}


>+		if (info->sechdrs[vers_ext_name].sh_type != SHT_PROGBITS) {
>+			pr_err("Invalid ELF __version_ext_names type: %u\n",
>+			       info->sechdrs[vers_ext_name].sh_type);
>+			return -ENOEXEC;
>+		}
>+
> 		crc_count = info->sechdrs[vers_ext_crc].sh_size / sizeof(u32);
> 		name = (void *)info->hdr +
> 			info->sechdrs[vers_ext_name].sh_offset;
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
