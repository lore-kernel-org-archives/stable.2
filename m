Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5E3128B2
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813766; cv=none; b=po2aQANCRIdrniXlma06JmcoUMDzqqXThEFmIRWQF1QRiITwUdY4UsQBP2GUqQ09WPRJd7BrPz67VjQGWpgm6uwsOuGgz9ZBZHqF6beuVFa03vxG2gDZWZibW681hvlKGB6a5lpPbvoiEhC3SzXC9jg1TXoklCcim8AE+9J96Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813766; c=relaxed/simple;
	bh=zmG/AJEV8FkuAKaaBtaIitEM/d1aBNpp7OAe1OGa5bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdA3v44fY4n+vKMpgmyk1Mq4xOp2y+YKNtyjukzH7GW5rbM6WA7oSinA1++ubH5G+5m8Dp+vsPTokMPNtdKW3i74zV//n7s2nAetTByo+JPyaDKRSpNRANvx4TmXn3x2Xw+MJwITQ+c7p27hveFW4P16163QP5JrxubH48LGgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=N8ZSgyMh; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="N8ZSgyMh"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiHp54006096;
	Thu, 18 Jun 2026 20:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=xIYfCXnP1IzHnRF00WoHXlQM5LWKTaNHNr3kSGkSqYo=; b=N8ZS
	gyMh98n38bDOylBA3UK+ZSb0YAmBGtoYxvWFNm0+GMOLYObxONc6Kl3D8Cjz5aTy
	2YUtQufB2qQUQa7pnHSf4LlMn56nwFQPu/4cSAk96BV0x/U2daWDU33vFihhUt4M
	tKGRZMMJzUVd7LpqAaZAdJVG9Gqs1z3dm66HH94V8F582PyNmVfNT9d+ETjukHKl
	nRxQkMU/dxwt8pQhYdOfgpv1C5MUAGaoVhDwPgtC8mnaISNF3WCuNPVnalj6/iIy
	db76ffAqdIxAUkh4iOpjWx8uqKkU0QyZLIgESSXKqh0wfXOXQfTmZUVe5wR4FafM
	cVqrSZzuw7hZNbhBIA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3jg4ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:15:59 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:15:57 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 10/27] scripts/sorttable: Add helper functions for Elf_Shdr
Date: Thu, 18 Jun 2026 16:15:24 -0400
Message-ID: <67462057b3867a75adaa8de9b8a091c2787f7735.1781809940.git.andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781809906.git.andrey.grodzovsky@crowdstrike.com>
References: <cover.1781809906.git.andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX7eY0X11alP5V
 v/MEw9SpLerz85HOcYUeU+VyP9C3V4IuZBsbFI7BZLQGMwF4PhlBnL9dHCv3mWovsoZ2Bd/ifaf
 GwzNgkUVOkhntxf0wZQ16FmIn2kVYXQLgiB7mKs8PvPSnddQQxLS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfXynYRhrFVG/aU
 fVUxtBu/ZKiH8cZE3H3yF0OC8U2zsHY1XIzybQDEsNKXUp4fyl7BQaLsQ2BjdMpEPkAtFVw7lMg
 dUvhM1F2aGi9S1pcztIGZAaHJDlSbHWXp0oHyTrVnKKGrBeSgsXs2ThUJT7xmn8ftgbJt/RLfW4
 9dJ+UZZQrFeazotQXTPo1XSix7kNZ4Jl1f1FqNo4RLGqlRhgHVnBaEshidPVb30ceB822i8Tjll
 hnVS3ENoV6gYb3SIBxXDnzt6nD8gZonSUQJAx5bsHwCKoMEBOg04b6GqRqMuz/9Vu+cZSm/jk9e
 s9jjCp0HvEfvHaNYvMMhOJWy58/ulJwDIVt3OZ31jd9mp9rSTYxhB85q9NMUjHyCMnlqoljcX5+
 uoj4CT7uscMYcwrwazWX6mcnxFo/YeAQtZpY3CrQ2m1m5m9nLYZBbclFeKPYemFsfWXdrhwzsPe
 uBCyRGXMKVnsvd+px0w==
X-Proofpoint-ORIG-GUID: -DxvewoSNgFp9yXE2-Bikt3ZDegYIiCL
X-Proofpoint-GUID: -DxvewoSNgFp9yXE2-Bikt3ZDegYIiCL
X-Authority-Analysis: v=2.4 cv=AvLeGu9P c=1 sm=1 tr=0 ts=6a3451ff cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=yQawIpTVkRBz0W3hp8YA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 67afb7f504400e5b4e5ff895459fbb3eb63d4450 ]

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions, add helper functions for Elf_Shdr.  This
will create a function pointer for each helper that will get assigned to
the appropriate function to handle either the 64bit or 32bit version.

This also moves the _r()/r() wrappers for the Elf_Shdr references that
handle endian and size differences between the different architectures,
into the helper function and out of the open code which is more error
prone.

Cc: bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Martin  Kelly <martin.kelly@crowdstrike.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/20250105162345.940924221@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 42 +++++++++++++++++++++++++++++
 scripts/sorttable.h | 66 +++++++++++++++++++++++++++++----------------
 2 files changed, 85 insertions(+), 23 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 5dfa734ef..b2b96ff26 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -110,6 +110,48 @@ EHDR_HALF(shentsize)
 EHDR_HALF(shstrndx)
 EHDR_HALF(shnum)
 
+#define SHDR_WORD(fn_name)				\
+static uint32_t shdr64_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r(&shdr->e64.sh_##fn_name);		\
+}							\
+							\
+static uint32_t shdr32_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r(&shdr->e32.sh_##fn_name);		\
+}
+
+#define SHDR_ADDR(fn_name)				\
+static uint64_t shdr64_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r8(&shdr->e64.sh_##fn_name);		\
+}							\
+							\
+static uint64_t shdr32_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r(&shdr->e32.sh_##fn_name);		\
+}
+
+#define SHDR_WORD(fn_name)				\
+static uint32_t shdr64_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r(&shdr->e64.sh_##fn_name);		\
+}							\
+							\
+static uint32_t shdr32_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r(&shdr->e32.sh_##fn_name);		\
+}
+
+SHDR_ADDR(addr)
+SHDR_ADDR(offset)
+SHDR_ADDR(size)
+SHDR_ADDR(entsize)
+
+SHDR_WORD(link)
+SHDR_WORD(name)
+SHDR_WORD(type)
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 97278c973..af3a5f020 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -31,6 +31,13 @@
 #undef ehdr_shentsize
 #undef ehdr_shstrndx
 #undef ehdr_shnum
+#undef shdr_addr
+#undef shdr_offset
+#undef shdr_link
+#undef shdr_size
+#undef shdr_name
+#undef shdr_type
+#undef shdr_entsize
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -47,6 +54,13 @@
 # define ehdr_shentsize		ehdr64_shentsize
 # define ehdr_shstrndx		ehdr64_shstrndx
 # define ehdr_shnum		ehdr64_shnum
+# define shdr_addr		shdr64_addr
+# define shdr_offset		shdr64_offset
+# define shdr_link		shdr64_link
+# define shdr_size		shdr64_size
+# define shdr_name		shdr64_name
+# define shdr_type		shdr64_type
+# define shdr_entsize		shdr64_entsize
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -62,6 +76,13 @@
 # define ehdr_shentsize		ehdr32_shentsize
 # define ehdr_shstrndx		ehdr32_shstrndx
 # define ehdr_shnum		ehdr32_shnum
+# define shdr_addr		shdr32_addr
+# define shdr_offset		shdr32_offset
+# define shdr_link		shdr32_link
+# define shdr_size		shdr32_size
+# define shdr_name		shdr32_name
+# define shdr_type		shdr32_type
+# define shdr_entsize		shdr32_entsize
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -177,8 +198,8 @@ struct elf_mcount_loc {
 static void *sort_mcount_loc(void *arg)
 {
 	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
-	uint_t offset = emloc->start_mcount_loc - _r(&(emloc->init_data_sec)->etype.sh_addr)
-					+ _r(&(emloc->init_data_sec)->etype.sh_offset);
+	uint_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
+					+ shdr_offset(emloc->init_data_sec);
 	uint_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 
@@ -267,18 +288,18 @@ static int do_sort(Elf_Ehdr *ehdr,
 
 	shstrndx = ehdr_shstrndx(ehdr);
 	if (shstrndx == SHN_XINDEX)
-		shstrndx = r(&shdr_start->etype.sh_link);
+		shstrndx = shdr_link(shdr_start);
 	string_sec = get_index(shdr_start, shentsize, shstrndx);
-	secstrings = (const char *)ehdr + _r(&string_sec->etype.sh_offset);
+	secstrings = (const char *)ehdr + shdr_offset(string_sec);
 
 	shnum = ehdr_shnum(ehdr);
 	if (shnum == SHN_UNDEF)
-		shnum = _r(&shdr_start->etype.sh_size);
+		shnum = shdr_size(shdr_start);
 
 	for (i = 0; i < shnum; i++) {
 		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
 
-		idx = r(&shdr->etype.sh_name);
+		idx = shdr_name(shdr);
 		if (!strcmp(secstrings + idx, "__ex_table"))
 			extab_sec = shdr;
 		if (!strcmp(secstrings + idx, ".symtab"))
@@ -286,9 +307,9 @@ static int do_sort(Elf_Ehdr *ehdr,
 		if (!strcmp(secstrings + idx, ".strtab"))
 			strtab_sec = shdr;
 
-		if (r(&shdr->etype.sh_type) == SHT_SYMTAB_SHNDX)
+		if (shdr_type(shdr) == SHT_SYMTAB_SHNDX)
 			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
-						      _r(&shdr->etype.sh_offset));
+						      shdr_offset(shdr));
 
 #ifdef MCOUNT_SORT_ENABLED
 		/* locate the .init.data section in vmlinux */
@@ -304,14 +325,14 @@ static int do_sort(Elf_Ehdr *ehdr,
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
-			orc_ip_size = _r(&shdr->etype.sh_size);
+			orc_ip_size = shdr_size(shdr);
 			g_orc_ip_table = (int *)((void *)ehdr +
-						   _r(&shdr->etype.sh_offset));
+						   shdr_offset(shdr));
 		}
 		if (!strcmp(secstrings + idx, ".orc_unwind")) {
-			orc_size = _r(&shdr->etype.sh_size);
+			orc_size = shdr_size(shdr);
 			g_orc_table = (struct orc_entry *)((void *)ehdr +
-							     _r(&shdr->etype.sh_offset));
+							     shdr_offset(shdr));
 		}
 #endif
 	} /* for loop */
@@ -374,23 +395,22 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 
-	extab_image = (void *)ehdr + _r(&extab_sec->etype.sh_offset);
-	strtab = (const char *)ehdr + _r(&strtab_sec->etype.sh_offset);
-	symtab = (const Elf_Sym *)((const char *)ehdr +
-						  _r(&symtab_sec->etype.sh_offset));
+	extab_image = (void *)ehdr + shdr_offset(extab_sec);
+	strtab = (const char *)ehdr + shdr_offset(strtab_sec);
+	symtab = (const Elf_Sym *)((const char *)ehdr + shdr_offset(symtab_sec));
 
 	if (custom_sort) {
-		custom_sort(extab_image, _r(&extab_sec->etype.sh_size));
+		custom_sort(extab_image, shdr_size(extab_sec));
 	} else {
-		int num_entries = _r(&extab_sec->etype.sh_size) / extable_ent_size;
+		int num_entries = shdr_size(extab_sec) / extable_ent_size;
 		qsort(extab_image, num_entries,
 		      extable_ent_size, compare_extable);
 	}
 
 	/* find the flag main_extable_sort_needed */
-	sym_start = (void *)ehdr + _r(&symtab_sec->etype.sh_offset);
-	sym_end = sym_start + _r(&symtab_sec->etype.sh_size);
-	symentsize = _r(&symtab_sec->etype.sh_entsize);
+	sym_start = (void *)ehdr + shdr_offset(symtab_sec);
+	sym_end = sym_start + shdr_size(symtab_sec);
+	symentsize = shdr_entsize(symtab_sec);
 
 	for (sym = sym_start; (void *)sym + symentsize < sym_end;
 	     sym = (void *)sym + symentsize) {
@@ -415,9 +435,9 @@ static int do_sort(Elf_Ehdr *ehdr,
 				       symtab_shndx);
 	sort_needed_sec = get_index(shdr_start, shentsize, sort_need_index);
 	sort_needed_loc = (void *)ehdr +
-		_r(&sort_needed_sec->etype.sh_offset) +
+		shdr_offset(sort_needed_sec) +
 		_r(&sort_needed_sym->etype.st_value) -
-		_r(&sort_needed_sec->etype.sh_addr);
+		shdr_addr(sort_needed_sec);
 
 	/* extable has been sorted, clear the flag */
 	w(0, sort_needed_loc);
-- 
2.34.1

