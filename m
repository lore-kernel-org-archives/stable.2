Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7672434E21;
	Sat,  5 Sep 2026 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788606508; cv=none; b=H7DvVR6hYf29xrRTIvbV9Fx26ICAP6XVLLioYTtMt/2NrqnmOz3o7qHcl6TVmtIkV9jUzs5AKT0YLw+puv+1jtfzme4FcWiQBxL05Su6x0HdI0/a5ch8Lop+/6/e4e4QxzyIonpNlVm349Quu47qdlAZ8lq2py0wL55yvxL5mJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788606508; c=relaxed/simple;
	bh=qVX/kHhQxbRS06bauUjWPo2+Y5pvhFS5SSCI9+p6kaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAuczZu2XyZYLEOWqHv72tc2/jzQ28ouR4P35UilX+FGH7oVs+8tmW8CVeOeJoitz3Lt2NOVzUSydk3No56g+U/v8vyW28K39BIlvGVCBnn3AEUCtf0FICvUkbLurvW1m1M1BAiwNEHrfw5utS+2WBMwUtVsgqal+GCdSEA/DQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=r6etbjbJ; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="r6etbjbJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788606494; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YilmYO5G+M7tedW7DLjoBBbCENZkZk8Z5GGZz+7RmVE=;
	b=r6etbjbJ1SAGJU5K3jwMDLcCA0xh0mpZgfaMFUVBNHz/0fHzA8HZaaWcwFgGvKkZhCN5Mhrbbti92f6T3kJm25/dMZXqxYle+pOCSfl0dzgXINeKdyk0qSDmmSX5gJgplimOG5mmr64XL1nTtbRKBym3IKFBmjQm1r8PgTVCZXI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436459|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00844834-0.00229274-0.989259;FP=7057237632770475591|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.j6IKN8r_1788606493;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.j6IKN8r_1788606493 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 05 Sep 2026 19:08:14 +0800
From: liuc63 <liuc63@xiaopeng.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH] module: validate sh_name for SHT_NULL sections
Date: Sat,  5 Sep 2026 19:08:13 +0800
Message-ID: <20260905110813.150411-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Chao <liuc63@xiaopeng.com>

elf_validity_cache_secstrings() checks that every section name offset is
inside the section name table, but skips headers of type SHT_NULL, since
ELF leaves their field values undefined.

However, the section lookup helpers do not check sh_type. This is
find_any_unique_sec(), which load_module() uses to locate ".modinfo":

	for (i = 1; i < info->hdr->e_shnum; i++) {
		if (strcmp(info->secstrings + info->sechdrs[i].sh_name,
			   name) == 0) {

find_any_sec() and module_enforce_rwx_sections() read sh_name the same
way, the latter from index 0. find_sec() is only shielded by its
SHF_ALLOC test, which a crafted module can satisfy.

ELF also permits SHT_NULL entries above index 0. A module that carries
one with a large sh_name passes validation and then reads out of bounds:

  BUG: unable to handle page fault for address: ffffc9004052f988
  Oops: 0000 [#1] SMP KASAN PTI
  CPU: 0 UID: 0 PID: 261 Comm: insmod Not tainted 6.18.0-rc7 #2
  RIP: 0010:strcmp+0xc/0x40
  Call Trace:
   ? find_any_unique_sec+0x89/0xf0
   load_module+0x516/0x3d30
   init_module_from_file+0xf5/0x180
   __x64_sys_finit_module+0x91/0x100

The read happens in elf_validity_cache_copy(), before the blacklist check
in early_mod_check().

Bounds check sh_name for every section header. The name table is already
known to be non-empty, so the sh_name of 0 that ELF requires at index 0
still passes, and a name offset that points outside the name table is
malformed regardless of section type. Neither an Ubuntu 20.04 x86_64
build (GCC 9.4, 6025 modules) nor an aarch64 vendor build (GCC 13.2, 127
modules) has a header with an out-of-bounds sh_name, or any SHT_NULL
header above index 0.

Link: https://lore.kernel.org/linux-modules/20260708013301.C4D4A1F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
The same report lists two more SHT_NULL gaps, both from
elf_validity_cache_sechdrs skipping offset and size validation:
move_module will memcpy such a section, and elf_validity_cache_index_mod
rejects SHT_NOBITS but not SHT_NULL. Sending this one on its own first,
happy to respin all three as a series if you would rather have them
together.

The Oops line says KASAN, but the access faults rather than producing a
KASAN report, because lib/string.o is built with KASAN_SANITIZE disabled.

No Fixes tag. 3c5700aeabd8 ("module: Factor out
elf_validity_cache_secstrings") is where the exemption was added, but the
problem predates it: before that commit sh_name was only checked for
SHF_ALLOC sections and the ".modinfo" strcmp() ran ahead of the check, so
find_any_sec() could already walk off the end. Same conclusion as
9a5ff4568932 ("module: validate string table section types"), which went
in with Cc: stable and no Fixes tag. checkpatch complains about that
combination.

The scan behind that last paragraph applies exactly the predicate this
patch introduces, sh_name >= strhdr->sh_size, to every section header
from index 0. On the x86_64 host it covered 17546 modules across three
kernel trees (5.15.0-181, 5.15.0-190, 5.4.0-182), all built by GCC 9.4.0;
those trees are the same toolchain recompiling much the same driver set,
so the changelog quotes one tree rather than the total. The aarch64 side
is a 5.10 vendor kernel built with Arm GNU Toolchain 13.2. Both are GNU
toolchains - no clang-built module set was available to me.

Reproducer, needs root and an unsigned module on a kernel without
CONFIG_MODULE_SIG_FORCE. Build any minimal module, then append a
SHT_NULL section header with an out-of-bounds sh_name:

  python3 - <<'EOF'
  import struct
  SHDR = 0x40
  data = bytearray(open('dummy.ko', 'rb').read())
  shoff = struct.unpack_from('<Q', data, 0x28)[0]
  shnum = struct.unpack_from('<H', data, 0x3c)[0]
  old = bytes(data[shoff:shoff + shnum * SHDR])
  evil = bytearray(SHDR)
  struct.pack_into('<I', evil, 0, 0x40000000)
  data += b'\0' * ((8 - len(data) % 8) % 8)
  new_shoff = len(data)
  data += old + bytes(evil)
  struct.pack_into('<Q', data, 0x28, new_shoff)
  struct.pack_into('<H', data, 0x3c, shnum + 1)
  open('evil.ko', 'wb').write(data)
  EOF

  insmod evil.ko

 kernel/module/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..7d5943cd6543 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2060,9 +2060,6 @@ static int elf_validity_cache_secstrings(struct load_info *info)
 
 	for (i = 0; i < info->hdr->e_shnum; i++) {
 		shdr = &info->sechdrs[i];
-		/* SHT_NULL means sh_name has an undefined value */
-		if (shdr->sh_type == SHT_NULL)
-			continue;
 		if (shdr->sh_name >= strhdr->sh_size) {
 			pr_err("Invalid ELF section name in module (section %u type %u)\n",
 			       i, shdr->sh_type);
