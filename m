Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3A3C9886;
	Thu, 17 Sep 2026 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671990; cv=none; b=l8OT2unr4IiN2XSTWR0/UcbrLU86ecdtBuyZp4xekeNhL3K3ROw0kZUcoi3nUO08RBdrorVtLvaj1QQvI86TciYHTEZRdZyhHS//ECGG6wkA4pDR082otLSbXYI+WAWgdvNeoqXGqF+dagboTOwwfVviQFRKwuzTKuKeOnxQCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671990; c=relaxed/simple;
	bh=jUnVt7qnPHYFdiextjrD8m8DA7LvvMB/Z15rmf1j/ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddNm7qm2px+3ZRoQtZ94DUIpzh+I3Gd32j5CpJ8SXkdgX5/kiPioqDKHcaf9eeFzhM5hZ+r4rZRx5efW/DFIHwJoBNRyiUCi1Wyozc9/OM8KLwpjhWwHnnXQWlQozTioKvK4TVghkjDn00HD669hBe9gW+lLpUZ02h6XKoiQ2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=lNCbfOWH; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="lNCbfOWH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789671982; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j4f31wokbPC278wohUMG2oItib2vdp0SWcrWkefjH1s=;
	b=lNCbfOWH0bwXO/MISLbxGZIB5WMDy+AbE+4BDQHA0KHlIb5Goe8PRtZtaVGYtIWiESXBjsdGrsuMudkT5zTLziCtFcv9CIM9UoUhQMhXarV/aejaYW1+qJwY/e/x1KM7LLSx+3/sxoZNMXdLVWzalIxtQpYDDiRgRn83vJyDjX0=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436274|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0473385-0.000483961-0.952178;FP=5594062516591330395|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jG9ODhh_1789671981;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jG9ODhh_1789671981 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 03:06:22 +0800
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
Subject: [PATCH v2 2/2] module: Validate the __version_ext_names section type
Date: Fri, 18 Sep 2026 03:06:18 +0800
Message-ID: <20260917190618.94759-3-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917190618.94759-1-fangxy@xiaopeng.com>
References: <20260917190618.94759-1-fangxy@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

elf_validity_check_sectionheaders() validates the size and offset of
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

Bounding the offset is not enough: an in-bounds SHT_NOBITS section
still passes it, and the walk reads unrelated file data as a version
name. A real __version_ext_names is SHT_PROGBITS, whose offset
elf_validity_check_sectionheaders() already bounds, so require that
type and reject one holding no data, matching the string-table type
checks.

Fixes: 54ac1ac8edeb ("modules: Support extended MODVERSIONS info")
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

Found in the same review as patch 1/2. elf_validity_check_sectionheaders()
exempts SHT_NOBITS from validate_section_offset(), and
elf_validity_cache_index_versions() then dereferences the __version_ext_names
section as hdr + sh_offset without re-checking its type, so a section of that
name and type SHT_NOBITS carries an unvalidated offset into the extended
version name walk. This patch stands on its own; it does not depend on 1/2.

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

The same vermagic caveat as patch 1/2 applies: LOCALVERSION is pinned so the
patched kernel's release string matches the payload, and the loader reaches the
version walk instead of stopping at the version magic check.

 kernel/module/main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e36bfe4..07b9dde 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2296,6 +2296,22 @@ static int elf_validity_cache_index_versions(struct load_info *info, int flags)
 	 * number of entries in every section.
 	 */
 	if (vers_ext_crc) {
+		/*
+		 * The names section is read below as hdr + sh_offset, so it
+		 * must hold file data. A real one is SHT_PROGBITS.
+		 * elf_validity_check_sectionheaders() exempts SHT_NULL and
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

