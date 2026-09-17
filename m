Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D54D1794;
	Thu, 17 Sep 2026 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672306; cv=none; b=hpnHWRyTs1GfWcrxh7vyea51wSEsWnjcEc2N+hViCIbbh/Byom5IsMM+Ss/InFJTKGYm/nvQAjyp8DQ9psEjXLt8iPkltPHMhpFCmQ0Xc/GGTv0sxH7GGQiEEEcjKBzydlGBBM6zem/uZdSZ0/NgtCTA2zr019+yxY7TcVO33J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672306; c=relaxed/simple;
	bh=ZOmNJmrIMk3u5pxEOy2Rj23mM2c5qnvtPoFKoM/HxOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4eZ8YCuW2TfEXqcLWh8Ck763q2lBdy1otXP7RvdgEjHgLB0l90pjwBwlb0gvyM8eW+CqPfHqyeuIov42thGy+7GYYRsWrYRIaxngC2FVA9rKG8VdvrmE8XYsLs+8WBLEclBGbUVckLzo4K6ry/GC/CflMnSZlFgFho4e78Dpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Eq2AYVbh; arc=none smtp.client-ip=115.124.28.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Eq2AYVbh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789672302; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=txpFZbn8I2u3+SIACXugxhsg4q5nyadngQpza3Bq2As=;
	b=Eq2AYVbhvHBZ/4/ZChX+CrQ1o9Faa5W6Kz6FgfIRYSe8tad+Dam+UzRIJgADZK9Gtjdw7b2vEsJflJl6RhGfLWtwiTFIt77exZfvzN7I7vN5bJZJdKpBafKZoTG64W12k1SSMPkp7dbp1UaeVpErRUzoaBwChJKotGA77hjQHC4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436491|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00685537-0.000624417-0.99252;FP=3450452327357023579|12|2|11|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jG9ODgi_1789671980;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jG9ODgi_1789671980 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 03:06:21 +0800
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
Subject: [PATCH v2 1/2] module: Sanitize the undefined sh_name of SHT_NULL sections
Date: Fri, 18 Sep 2026 03:06:17 +0800
Message-ID: <20260917190618.94759-2-fangxy@xiaopeng.com>
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

Both cases ran on 704340f1cd0d (9 commits past v7.3-rc3): x86_64 defconfig plus
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

