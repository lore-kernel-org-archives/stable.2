Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F05377010;
	Mon, 21 Sep 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994272; cv=none; b=rpfLh1I57qCjuvC3VN7EXHWZoYxm1mKJw+PbRD/JL1QhyV76ffQqjdH/HRGmCG9QHBNGzbDOo7NzhjPJua7FLv/4OM0xbGZ6LPRK019EaLE7VXlhgbHTnHi9IBvgqq0Ssh2mNzO+xB/r4wqI9v8HOZMPhtzWh83sVlOGJcptIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994272; c=relaxed/simple;
	bh=pCHZ+0L3d15L4I8PvI9TPUsMshBFUyEfjm3U/5H6Bwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIwzTO9hYBEKobRVJv37+H2sHMlIbd2DolxRI1YbA+AsVswGGz1lRQBcFC6D1FfOrAgpXvlo5F2kYlw9Vc5+RolqLrSB+8xC671yUILFwABAwBeTHG68w1re7GS8X9gS/OJ9qdUySF4SKYy4Vfz388IUQoa6Gyyo9qvSvqpj/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Am+out3g; arc=none smtp.client-ip=115.124.28.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Am+out3g"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789994258; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=o/puxiRCVI7n2+/8fAiUbqwHg5A90Gb1J0aQN2rumXY=;
	b=Am+out3g+ncW2MsqgfRqQ7UVB3ajJOVddUzwMkn+BuYAu/iZoRIP7oP3aB07MqFI60abKICVWS5EZiJXScORsVIZjafT2Ba9hssolVOa3O0bsKfeNTeQ2bL7T51UK6mRv5MAN9m6CCBFiQHKgbWg5e6dCpPjLA/DdZOMTHi1aio=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0350538-0.00187946-0.963067;FP=7471856784318729563|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jJ2aCIS_1789994256;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jJ2aCIS_1789994256 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 21 Sep 2026 20:37:37 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Bradley Morgan <brads@mainlining.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Maurer <mmaurer@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] module: Validate __version_ext_crcs and __version_ext_names section types
Date: Mon, 21 Sep 2026 20:37:35 +0800
Message-ID: <20260921123735.72202-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

elf_validity_cache_sechdrs() skips validate_section_offset() for
SHT_NOBITS sections, which hold no data in the ELF file. However, the
extended MODVERSIONS sections __version_ext_crcs and __version_ext_names
are later read as file contents without re-checking their type.

elf_validity_cache_index_versions() reads __version_ext_names directly
from the module image using sh_offset:

	if (vers_ext_crc) {
		crc_count = info->sechdrs[vers_ext_crc].sh_size / sizeof(u32);
		name = (void *)info->hdr +
			info->sechdrs[vers_ext_name].sh_offset;
		remaining_len = info->sechdrs[vers_ext_name].sh_size;
		while (crc_count--) {
			name_size = strnlen(name, remaining_len) + 1;

A SHT_NOBITS __version_ext_names therefore bypasses the generic offset
validation and can carry an out-of-bounds sh_offset, so strnlen() reads
past the end of the kernel's in-memory copy of the module:

  BUG: KASAN: vmalloc-out-of-bounds in strnlen+0x73/0x80
  Read of size 1 at addr ffa00000005834ff by task insmod/79
  CPU: 0 PID: 79 Comm: insmod Not tainted 7.3.0-rc3-g704340f1cd0d #1
  Call Trace:
   strnlen+0x73/0x80
   load_module+0xef6/0x8600

The CRC section is read the same way, only later. In early_mod_check(),
rewrite_section_headers() sets each sh_addr to hdr + sh_offset, and the
version sections are not copied into the final image, so
check_modstruct_version() reads the CRC data from that temporary image.
A SHT_NOBITS __version_ext_crcs then makes check_version() dereference
past the end of the image:

  BUG: KASAN: vmalloc-out-of-bounds in check_version+0x5c7/0x600
  Read of size 4 at addr ffa0000000583509 by task insmod/78
  Call Trace:
   check_version+0x5c7/0x600
   check_modstruct_version+0x101/0x140
   load_module+0x1442/0x8600

Both reads occur after module_sig_check() and before
layout_and_allocate(), on the temporary copy made by kernel_read_file(),
so an unvalidated sh_offset points outside that vmalloc region.

An offset bound is not enough: an in-bounds SHT_NOBITS section still
passes it, and the loader would read unrelated image data as extended
MODVERSIONS. A real __version_ext_crcs and __version_ext_names are
SHT_PROGBITS, so require that type before either is read.

Fixes: 54ac1ac8edeb ("modules: Support extended MODVERSIONS info")
Cc: stable@vger.kernel.org
Suggested-by: Bradley Morgan <brads@mainlining.org>
Link: https://lore.kernel.org/all/C04CC94F-26D0-4823-84F4-7AFEBCDCA9AE@mainlining.org/
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

Changes in v4:
  - Extended the type check to __version_ext_crcs, not just
    __version_ext_names (Bradley Morgan). The crc array is dereferenced
    at hdr + sh_offset in check_version(), the same exposure as the name
    walk, so a SHT_NOBITS __version_ext_crcs faults there too. Added a
    second splat for it (check_version, Read of size 4).
  - Shortened the in-code comment (Bradley Morgan).
  - Reworked the changelog as defect / splat / fix and trimmed it. The
    names walk in elf_validity_cache_index_versions() is inlined into
    load_module(), so its splat has no frame for it.

Standalone since v3 (20260919154139.52904-1-fangxy@xiaopeng.com). v1/v2 were
patch 2/2 of a two-patch series, split off when the sibling SHT_NULL fix
was withdrawn in favor of Liu Chao's fail-closed fix for the same bug. This
patch does not depend on it.

Reproducer: a .ko carrying __version_ext_crcs and __version_ext_names, in
three variants. (1) names SHT_NOBITS with sh_offset past the end of the
image: before, the name walk reads out of bounds (KASAN
vmalloc-out-of-bounds in strnlen, Read of size 1). (2) names SHT_NOBITS
with sh_offset in bounds, aimed at other file data: before, the walk
silently consumes it as a version name and no splat fires. (3) crcs
SHT_NOBITS with sh_offset past the end and names a valid SHT_PROGBITS
"module_layout": before, check_version() reads the crc out of bounds
(KASAN vmalloc-out-of-bounds, Read of size 4). On the patched kernel all
three are rejected before the dereference and insmod fails with -ENOEXEC
(rc=8); variant (3) prints "Invalid ELF __version_ext_* type: crc=8
name=1".

Tested on 704340f1cd0d (9 commits past v7.3-rc3), x86_64 defconfig plus
CONFIG_KASAN_GENERIC and CONFIG_KASAN_VMALLOC, gcc 13.2.0, QEMU under TCG;
the unpatched and patched kernels are built from byte-identical .config
files and differ only by this patch. LOCALVERSION is pinned so the loader
reaches the version walk instead of stopping at the vermagic check.

 kernel/module/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0b..e46eba6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2287,6 +2287,18 @@ static int elf_validity_cache_index_versions(struct load_info *info, int flags)
 	 * number of entries in every section.
 	 */
 	if (vers_ext_crc) {
+		/*
+		 * SHT_NOBITS skips offset validation; both sections
+		 * contain file data.
+		 */
+		if (info->sechdrs[vers_ext_crc].sh_type != SHT_PROGBITS ||
+		    info->sechdrs[vers_ext_name].sh_type != SHT_PROGBITS) {
+			pr_err("Invalid ELF __version_ext_* type: crc=%u name=%u\n",
+			       info->sechdrs[vers_ext_crc].sh_type,
+			       info->sechdrs[vers_ext_name].sh_type);
+			return -ENOEXEC;
+		}
+
 		crc_count = info->sechdrs[vers_ext_crc].sh_size / sizeof(u32);
 		name = (void *)info->hdr +
 			info->sechdrs[vers_ext_name].sh_offset;
-- 
2.50.1 (Apple Git-155)

