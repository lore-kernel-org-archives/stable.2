Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A553B47CD;
	Wed, 16 Sep 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580890; cv=none; b=PCF59AkSf8rj7vtjkWJae3hHwd6BST4HZUpZj/f4SAM3OTepE0xJmvs0RWjZ6CoaZ4ERdzLzkGQNkOJv5p4X/0kVVG/VZSxXjEpilYT6HhU44UZhHDpYHcv0xGUyqEnkvCjGI8v1Qoc+aIe8X4NPdAZEW5UzeorK18t0An9ieQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580890; c=relaxed/simple;
	bh=5SVan4TztOsht+PNjOT1U3SsgeW2aiaq0MZz1YZ/ldo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnzvCYNNF1590trwECk6SqXjG2gBHeX9RtuWVYp86/r765K5vMNmZg4jjhVVEIbvfo092UzOMoWkJuz7z+3CiW8EkbA7IvqwzaWci/GU3XbCKo3bEWr9ZRJXks+j37xfkQRVZR+393OccK4l5ebU2WNv4s448jY1MTq7+VIyNK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=SIQZAsbz; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="SIQZAsbz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789580877; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=azJubOKUIjMTBXlSrVQ1zbXf17NBQi6Q2PS0BXsTCSo=;
	b=SIQZAsbzYzt95asFNfnLuwjwhOJlODvEe9e8MfVTEDNVERppOaD0CxxVvTzW6yP+G1RyRvnA/GkNRruc+gFqYzKimBZhmvyhNqmyilI3YQudKqsmK/PgWGA+tMO1vekr7LRd8HtKXsz197uZbsXSXcZjLwIs4McWztb5nWsMU4A=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436835|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0354802-0.00586873-0.958651;FP=5742756620908168539|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jFIg.VU_1789580876;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jFIg.VU_1789580876 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 01:47:57 +0800
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
Subject: [PATCH 2/2] module: Validate the __version_ext_names section offset
Date: Thu, 17 Sep 2026 01:47:53 +0800
Message-ID: <20260916174753.14870-3-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260916174753.14870-1-fangxy@xiaopeng.com>
References: <20260916174753.14870-1-fangxy@xiaopeng.com>
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

A __version_ext_names section of type SHT_NOBITS reaches here with an
unvalidated sh_offset, so the name lookup reads past the in-memory
copy of the module:

  BUG: KASAN: vmalloc-out-of-bounds in strnlen+0x73/0x80
  Read of size 1 at addr ffa00000005534ff by task insmod/79
  ...
   strnlen+0x73/0x80
   load_module+0xef6/0x8600
  The buggy address belongs to a 43-page vmalloc region starting at
  0xffa0000000529000 allocated at kernel_read_file+0x7b4/0x9f0

A real __version_ext_names section is SHT_PROGBITS and has already
passed validate_section_offset(), so this only rejects a SHT_NOBITS
section, which holds no names to read. Validate the offset before the
dereference.

Fixes: 54ac1ac8edeb ("modules: Support extended MODVERSIONS info")
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

Found in the same review as patch 1/2. elf_validity_check_sectionheaders()
exempts SHT_NOBITS from validate_section_offset(), and
elf_validity_cache_index_versions() then dereferences the __version_ext_names
section as hdr + sh_offset without re-checking it, so a section of that name and
type SHT_NOBITS carries an unvalidated offset into the extended version name
walk. This patch stands on its own; it does not depend on patch 1/2.

Reproducer: build a .ko that carries __version_ext_crcs and a
__version_ext_names section of type SHT_NOBITS whose sh_offset points past the
end of the module image. insmod it. Before the change the name walk reads out of
bounds; after it validate_section_offset() rejects the section and insmod fails
with -ENOEXEC (rc=8, "invalid module format"), which is what a module with a
malformed version section should do.

Both cases ran on 704340f1cd0d (v7.3-rc4): x86_64 defconfig plus
CONFIG_KASAN_GENERIC and CONFIG_KASAN_VMALLOC, gcc 13.2.0, QEMU under TCG. The
unpatched and patched kernels are built from byte-identical .config files and
differ only by this patch.

The same vermagic caveat as patch 1/2 applies: LOCALVERSION is pinned so the
patched kernel's release string matches the payload, and the loader reaches the
version walk instead of stopping at the version magic check.

 kernel/module/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e36bfe4..adaaaca 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2296,6 +2296,16 @@ static int elf_validity_cache_index_versions(struct load_info *info, int flags)
 	 * number of entries in every section.
 	 */
 	if (vers_ext_crc) {
+		/*
+		 * The name section is walked by its sh_offset and sh_size
+		 * below. elf_validity_check_sectionheaders() exempts SHT_NOBITS
+		 * sections from validate_section_offset(), so a __version_ext_names
+		 * section of that type reaches here with an unvalidated sh_offset.
+		 * Bound it before dereferencing hdr + sh_offset.
+		 */
+		if (validate_section_offset(info, &info->sechdrs[vers_ext_name]))
+			return -ENOEXEC;
+
 		crc_count = info->sechdrs[vers_ext_crc].sh_size / sizeof(u32);
 		name = (void *)info->hdr +
 			info->sechdrs[vers_ext_name].sh_offset;
-- 
2.50.1 (Apple Git-155)

