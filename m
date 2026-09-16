Received: from out198-10.us.a.mail.aliyun.com (out198-10.us.a.mail.aliyun.com [47.90.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BF389E1A;
	Wed, 16 Sep 2026 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580934; cv=none; b=SAI7JrVOwF0TuGJ/nC6VIBQf5Z7qHPQ0X7BuBnH9hcOFiFJxTeGfEuekqiCzM2fciXwLiBTRI7ETI1cKXTl4Ke1kCu/TlNbW+/fhn1vogFwKVHDVCgDaHgV++LQ7BrSUJAH4ObDuC03f7lCAZQuo8tpPQqjkml+UPswPy0jyx+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580934; c=relaxed/simple;
	bh=k33fXF4XusNxY5ulRNWOjlV64rtCPhIW66nonQLKaoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvynvH3ZK0A0GIcC4UXObm2Loae7LU8kI7qLPHuhtdpfhq3c4/imc66ZekrAt7jn9j9ugUJ6/evmvDq/V5r9Oc0cxlgLbjTdSyf48CBM1a64jjZ9RyQimDZZWKtCuGxwMFyi6Gffll9+PHGc3eI/pwk6KKWOYKnKq56ELuMTMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=NaFB7E9g; arc=none smtp.client-ip=47.90.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="NaFB7E9g"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789580876; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Zx1QEPZrMvacbciA8Pq0PrXq/rwJg/pG0xocikRHfbE=;
	b=NaFB7E9g7Cz1b98erf7uf1QlfHCBMmiJzN6Pz3F6IByvXrQYoC/U4kGGJzWzF0MBlic/umkMXKD3QQCJzVbhRh/4RelEfKMMxdx6Y0suZpNZJ/n4sJB7bxRFYCRKG6BM+qQrOdX0QFtRjDiVBXudyz2He0v2NIpH7/e9pp2kRvc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436481|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00685537-0.000624417-0.99252;FP=3450452327357023579|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jFIg.Ue_1789580875;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jFIg.Ue_1789580875 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 01:47:56 +0800
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
Subject: [PATCH 1/2] module: Sanitize the undefined sh_name of SHT_NULL sections
Date: Thu, 17 Sep 2026 01:47:52 +0800
Message-ID: <20260916174753.14870-2-fangxy@xiaopeng.com>
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

elf_validity_cache_secstrings() skips the sh_name bounds check for a
SHT_NULL section:

	for (i = 0; i < info->hdr->e_shnum; i++) {
		shdr = &info->sechdrs[i];
		/* SHT_NULL means sh_name has an undefined value */
		if (shdr->sh_type == SHT_NULL)
			continue;
		if (shdr->sh_name >= strhdr->sh_size) {

A SHT_NULL section may then carry an sh_name past the end of
.shstrtab. The name lookups that run afterwards do not skip SHT_NULL.
This is find_any_unique_sec(), which load_module() uses to locate
".modinfo":

	for (i = 1; i < info->hdr->e_shnum; i++) {
		if (strcmp(info->secstrings + info->sechdrs[i].sh_name,
			   name) == 0) {

so the out-of-bounds sh_name is read as a string. A module carrying a
crafted SHT_NULL section reads past its in-memory copy:

  BUG: KASAN: vmalloc-out-of-bounds in strcmp+0xb0/0xc0
  Read of size 1 at addr ffa00000005436e0 by task insmod/81
  ...
   strcmp+0xb0/0xc0
   find_any_unique_sec+0x103/0x190
   load_module+0x5c4/0x8600

sh_name has no defined value for SHT_NULL, so give it one that is in
bounds: the empty string at index 0. The walkers then compare against
"" and, as before, ignore the section, so no valid module is affected.

Fixes: 3c5700aeabd8 ("module: Factor out elf_validity_cache_secstrings")
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

Found by reading the section-name walkers in kernel/module/main.c after
9a5ff4568932 tightened the string-table types. elf_validity_cache_secstrings()
skips the sh_name bounds check for a SHT_NULL section, but find_any_unique_sec()
still resolves every section's name as secstrings + sh_name, so the skip leaves
one path where an unchecked sh_name is read as a string. Patch 2/2 fixes the
matching SHT_NOBITS gap on __version_ext_names; the two are independent.

Reproducer: build an otherwise valid .ko and add a SHT_NULL section whose
sh_name is past the end of .shstrtab (0x2000 in the run below, aimed at the
redzone after the in-memory module copy). insmod it. Before the change the name
lookup reads out of bounds; after it the SHT_NULL section resolves to "" and, as
before, is ignored, so the module loads with rc=0.

Both cases ran on 704340f1cd0d (v7.3-rc4): x86_64 defconfig plus
CONFIG_KASAN_GENERIC and CONFIG_KASAN_VMALLOC, gcc 13.2.0, QEMU under TCG. The
unpatched and patched kernels are built from byte-identical .config files and
differ only by this patch. The tree already contains 9a5ff4568932, so this is
the gap that commit left, not a re-report of it.

One setup detail is not obvious. The payload has to match the kernel's
vermagic to reach load_module()'s name walkers, so the patched kernel is built
with LOCALVERSION pinned to keep the release string byte-identical to the
unpatched one; otherwise insmod fails on the version magic before the buggy
lookup ever runs and the run proves nothing.

 kernel/module/main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0b..e36bfe4 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2060,9 +2060,18 @@ static int elf_validity_cache_secstrings(struct load_info *info)
 
 	for (i = 0; i < info->hdr->e_shnum; i++) {
 		shdr = &info->sechdrs[i];
-		/* SHT_NULL means sh_name has an undefined value */
-		if (shdr->sh_type == SHT_NULL)
+		/*
+		 * SHT_NULL means sh_name has an undefined value. The section
+		 * name walkers that follow (find_any_unique_sec(),
+		 * module_mark_ro_after_init(), ...) look the name up as
+		 * secstrings + sh_name for every section, so give the undefined
+		 * value a safe in-bounds meaning instead of skipping the check:
+		 * the empty string at index 0.
+		 */
+		if (shdr->sh_type == SHT_NULL) {
+			shdr->sh_name = 0;
 			continue;
+		}
 		if (shdr->sh_name >= strhdr->sh_size) {
 			pr_err("Invalid ELF section name in module (section %u type %u)\n",
 			       i, shdr->sh_type);
-- 
2.50.1 (Apple Git-155)

