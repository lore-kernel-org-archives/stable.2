Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537F30E82C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815168; cv=none; b=jCsQHqL1S88UtNsosg8INCDF0h50w3IDcBG0p1SdgSEndmw7KBT2hk2/r70I39NVk0GY2xlsK/jTx0qTEqpGpLFxhNXl5thwx4JBRxLvcWaow7hb8sS4rQHJ+P0mhjeOxLRK/1kUiDAM5lFCG0NWDOJZHJw/cgQtzGk/uZr4038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815168; c=relaxed/simple;
	bh=zmG/AJEV8FkuAKaaBtaIitEM/d1aBNpp7OAe1OGa5bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSl8E3r+fuApZwdnvlokV2ujIk/vEGk8vrLnW4X+dkShMRyqowOvNWqyDMw/st9HR8gVxvlPApQRJlLKDf/IkBYSkjo36+tD0moC37+nMY7kY31jurtdYUmoVGO3z3qlU9qE9X/d4eoQTZ1dXmZGgszmu08Dn/DyFgbcMczuiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=blLLSJyu; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="blLLSJyu"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsa5P3922544;
	Thu, 18 Jun 2026 20:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=xIYfCXnP1IzHnRF00WoHXlQM5LWKTaNHNr3kSGkSqYo=; b=blLL
	SJyuvMhbM1hAkl/5mHAAgFfxK7yMuAVlih4JgQj67tnra46TyZwXzKsBbrVW351C
	X7jp1eebQOQo9X7sCQyCsFeCgEan6eDLTHgVQRdENp9267WqSnDxxktJBgyxPYy5
	9K6F/YrbU69COcHuLsjWqFfsumqiMcUKb1ECphbLz5YZUUK5Iyv/CC/OeGJeD2xc
	pz8+jxHDSSweMVjWMm6eHQCkmnftaMAgnoyAm1DraRkYfkhMFZ/6kzI/eerEfCoG
	h4o7fz/DlV33JTR6Gd+WxqbChB3Vv4oUWPgQUKgQEhEraEWlZ4ixnRuHyUldt8Vl
	/VEFKI87apBCnO+Erw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ev4y0vfpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:21 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:19 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 10/27] scripts/sorttable: Add helper functions for Elf_Shdr
Date: Thu, 18 Jun 2026 16:38:48 -0400
Message-ID: <d5b270e2f1be692a4ca5d4dc0301c913cfe5d10c.1781814116.git.andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781814083.git.andrey.grodzovsky@crowdstrike.com>
References: <cover.1781814083.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX9wqxKJziIU04
 NHjJqstvUyoNE7Qx7+xtiQuDpPBQWLyJM3wmvM5F3I9z3HnEJwovzxpMvK/CzUNZvFhLhRd72Rd
 3s2LRa/uQuMICl+QnAQ37gEUT63AdPvZHsojIokxEptw/+U1y69ZjN8www5p06QxIXOmZijAKXO
 Aak/piMBEQnm+ehO0p9Lh701SQqWOKYMXoijYmwq99lcteK2LEPiafK5wEBp8TywgEjNje7xa2x
 kEKpj7nPITOsHqX0C6SQAi1M9ddAL9Dpsmiath6eUIaptazdsIiyiM8D8NRgmWU9wLni2ltZivr
 eMONDQs+9z0i8+EcnG9mSzQoVmkXwB4+szGbCaB8Jzxd7ATCdYn5mRIBqRDm52HIgu5PvM4oAtb
 92VWj4ikKJyqgOFfyH4MMU4NObysYlBbaq8u9jx3LrWs80jyxEfoPwDf99kkmcp0yttS5BzCgrn
 AyjhNQxWYaDtLXARM7A==
X-Proofpoint-ORIG-GUID: T3jz22GEH3YkLm-Uu4j6pb9SdUr9t9-Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfXyy3PeylLifDe
 KXM2wyldFp9yw4m7TrmCL5rH2iFrhltOuwnJdsdTYalxJo3V/vnlMUvcn0BxN/iR1vaNFODXtv7
 VftEiPuX5GdYZElbSylttHGQ8bHi1k9NkqqZ717PUM1A9PLh4UmW
X-Authority-Analysis: v=2.4 cv=Ood/DS/t c=1 sm=1 tr=0 ts=6a345779 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=yQawIpTVkRBz0W3hp8YA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: T3jz22GEH3YkLm-Uu4j6pb9SdUr9t9-Z
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

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

