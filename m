Received: from mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AF3328E6
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337069; cv=none; b=athKgSDGbuPCuEJ/0jJN1rYTC/m2KIkWQpID0c9OCNkBTDAe7ZtgCToO2wb//GNZKieNjjaoj4ra5L4A/0E9TeXkVWtP/BUJLGJQFRMdVXid+59/yp0TVogc3EaB+cTc7PMPmoPVADwO1H1khrsizlaQb/9g2uYf8Ft8Q7O9xFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337069; c=relaxed/simple;
	bh=IWPG5U0baJXua7XoV+ocXpmKQBCi8RyT3W3FBxO4w10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fden3cYHqVL+Y8co2wL/7KawAyd1iTF1L0hayF2Fm0ex016Eui4PL8O2tuO0dewu7R1ew7GoWWQspxg+ONk8IPJm2LXHnjrCGm58UZypHpGeehpayJrIwOD7qkBJ600EbVWXhNF9P0sFNcn3/PEWncgPiR2fD85h0L0e1OIApww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IPKrSK4Y; arc=none smtp.client-ip=95.215.58.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IPKrSK4Y"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IWPG5U0baJXua7XoV+ocXpmKQBCi8RyT3W3FBxO4w10=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788337064; v=1; x=1788941864;
 b=IPKrSK4YEMwYEBse5k1ygRo4w+Wfgc8kHUvH+P3AMu3LD7WzK/bd8TI7CASKsqmMqIJkt/bl
 1MW2op3NprbONpukzKOVeYBqwZlTE29dhrwHNKbQ9kC1gTM5FqLlVcVx3NvXsvL7GQ+F6jyzdda
 wnNraxHtQBQVijt/3GwWksps=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 949a1ac0fa66a2aa;
	Wed, 02 Sep 2026 08:17:44 +0000
X-Mizu-Trace-ID: 949a1ac0fa66a2aa
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Hao Ge <hao.ge@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v7 2/4] module: introduce SH_ENTSIZE_STANDALONE for separately allocated sections
Date: Wed,  2 Sep 2026 16:18:00 +0800
Message-Id: <20260902081802.146145-3-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260902081802.146145-1-hao.ge@linux.dev>
References: <20260902081802.146145-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SHF_ALLOC means, per the ELF spec, that a section occupies memory
during process execution. Some module sections occupy memory
outside the regular module layout, for example the percpu section
with its per-CPU allocations. The loader currently excludes such
a section from the layout by clearing its SHF_ALLOC, which
overloads the flag with a loader-internal meaning.
apply_relocations() needs a special case for the section, and
find_sec(".data..percpu") returns different results before and
after layout_and_allocate().

Introduce SH_ENTSIZE_STANDALONE to mark sections with a separate
allocation. The percpu section is its first user. layout_sections()
and move_module() skip marked sections, and apply_relocations() goes
back to testing only SHF_ALLOC.

No functional change intended.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Based-on-a-patch-by: Petr Pavlu <petr.pavlu@suse.com>
Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 include/linux/module.h   |  2 ++
 kernel/module/internal.h |  8 ++++++++
 kernel/module/main.c     | 31 +++++++++++++------------------
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..33548daa31a3 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -325,6 +325,8 @@ enum mod_mem_type {
 	MOD_INIT_RODATA,
 
 	MOD_MEM_NUM_TYPES,
+
+	MOD_STANDALONE = -2,
 	MOD_INVALID = -1,
 };
 
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 061161cc79d9..4c738074a27b 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -29,6 +29,14 @@
 #define SH_ENTSIZE_TYPE_MASK	((1UL << SH_ENTSIZE_TYPE_BITS) - 1)
 #define SH_ENTSIZE_OFFSET_MASK	((1UL << (BITS_PER_LONG - SH_ENTSIZE_TYPE_BITS)) - 1)
 
+/*
+ * Marker for sections with a separate allocation, which are not placed
+ * into mod->mem[].
+ */
+#define SH_ENTSIZE_STANDALONE					\
+	(((unsigned long)MOD_STANDALONE & SH_ENTSIZE_TYPE_MASK)	\
+	 << SH_ENTSIZE_TYPE_SHIFT)
+
 /* Maximum number of characters written by module_flags() */
 #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c32f1d370b73..078dae188aba 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1618,14 +1618,8 @@ static int apply_relocations(struct module *mod, const struct load_info *info)
 		if (infosec >= info->hdr->e_shnum)
 			continue;
 
-		/*
-		 * Don't bother with non-allocated sections.
-		 * An exception is the percpu section, which has separate allocations
-		 * for individual CPUs. We relocate the percpu section in the initial
-		 * ELF template and subsequently copy it to the per-CPU destinations.
-		 */
-		if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
-		    (!infosec || infosec != info->index.pcpu))
+		/* Don't bother with non-allocated sections. */
+		if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC))
 			continue;
 
 		if (info->sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)
@@ -1716,7 +1710,7 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
 
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
-			    || s->sh_entsize != ~0UL
+			    || s->sh_entsize != ~0UL /* offset or standalone */
 			    || is_init != module_init_layout_section(sname))
 				continue;
 
@@ -1746,16 +1740,10 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
 /*
  * Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
  * might -- code, read-only data, read-write data, small data.  Tally
- * sizes, and place the offsets into sh_entsize fields: high bit means it
- * belongs in init.
+ * sizes, and place the offsets into sh_entsize fields.
  */
 static void layout_sections(struct module *mod, struct load_info *info)
 {
-	unsigned int i;
-
-	for (i = 0; i < info->hdr->e_shnum; i++)
-		info->sechdrs[i].sh_entsize = ~0UL;
-
 	pr_debug("Core section allocation order for %s:\n", mod->name);
 	__layout_sections(mod, info, false);
 
@@ -2811,7 +2799,8 @@ static int move_module(struct module *mod, struct load_info *info)
 		Elf_Shdr *shdr = &info->sechdrs[i];
 		const char *sname;
 
-		if (!(shdr->sh_flags & SHF_ALLOC))
+		if (!(shdr->sh_flags & SHF_ALLOC)
+		    || shdr->sh_entsize == SH_ENTSIZE_STANDALONE)
 			continue;
 
 		sname = info->secstrings + shdr->sh_name;
@@ -2943,6 +2932,7 @@ core_param(module_blacklist, module_blacklist, charp, 0400);
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
+	unsigned int i;
 	int err;
 
 	/* Allow arches to frob section contents and sizes.  */
@@ -2956,8 +2946,13 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	if (err < 0)
 		return ERR_PTR(err);
 
+	/* Repurpose sh_entsize to track where each section is allocated. */
+	for (i = 0; i < info->hdr->e_shnum; i++)
+		info->sechdrs[i].sh_entsize = ~0UL;
+
 	/* We will do a special allocation for per-cpu sections later. */
-	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
+	if (info->index.pcpu)
+		info->sechdrs[info->index.pcpu].sh_entsize = SH_ENTSIZE_STANDALONE;
 
 	/*
 	 * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can
-- 
2.25.1

