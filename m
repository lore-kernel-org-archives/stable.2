Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891CF30E82C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815165; cv=none; b=B3YO6i5oCAEBhkcQFfqa6b+EriilhV7iPz4aLP0MilSU7cRngKawIA1vj0RGgnHxlPSUduwvacLFGJs/d/tTLqB174E0Y65DsFe2EKqs2EGGHi21QVZrJUFV4QAE2tMTRtZCiRdcqf4d0KkDF1fwnQlLuZd3olewaiRMA5ywt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815165; c=relaxed/simple;
	bh=8jHi/OaIGmqbqXRJVaAp2h5gDMcWECSTRRKDY5DkFGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ab9nfG+Ax/vDM4N6VsLH82Z36khc8Ceo09Q2eQ9DNc0sX1wMU+nQYqAAO8XaKNImWy05R51EmNbKjd43mwb6ui6CkoR+0Mx6493aMZ3GAH2H9bLAjZb7SL7Rx1SI41CsZHHArfgfv/uCgzRdLNjfh1DMN77P9puRelGWAcyLWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=C7pbHzps; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="C7pbHzps"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsdVC3922608;
	Thu, 18 Jun 2026 20:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=aq4utDUzSlvDBrPwUcy0/2DoVzzHFCdWMXWXlKshz7o=; b=C7pb
	HzpsqbYKYrpcxXswwS+Ka/y3/QdW1XWVk7b0M0Ajzt4cdo8+MmKbhOspbzwLaX96
	/kuKLM6P4F49mkgUhNujXmcCbzFj4NyjD/c+WLtjNJ1BKQnUyKObXSXkrckzbn86
	N5blaw3MrhCtGOLIUbghn3U36A6OfUEixi0Gwjo3WgqvfOJauz3OMCgzDS7BI5Ws
	jdPG45vOE6Hdh7YBG+m5BktOhxe3Uu/l7xdOFCTneSwLe2q96cSoByTd2biVryiC
	Cogs4DchEU9vka3nvEQP+cQr5JjKMxivOLbNKlrxRFZciDVZj16kA5kXO0ydc3Xv
	la1+iTC1B2FUMi4h0A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ev4y0vfp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:17 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:16 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 07/27] scripts/sorttable: Replace Elf_Shdr Macro with a union
Date: Thu, 18 Jun 2026 16:38:45 -0400
Message-ID: <52839599d3d153450ee462499e049f0fdaf867c2.1781814106.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX8TLEQInMmXgJ
 skDu99eUS3HNTaiPV1X68vliLt3/CNbfwf09LIMDBy/sUkNPavNvrep9dk/rUHZcEvCU81tRtAi
 5PJo+/+caKmCZufM6Z0eOtXLGZbQfKREWpoxop6CZ3xsgqgn1aL8lTw7kuuQ4K54w2zMwL9FgYH
 88IVMy3HM6tQYmYkaoLXiGTw7nvaglh2XUTYBrspqTQsFDhIUGBc0dLhv9lhTzTmE8i9/joDa+y
 EKwQWQuj3dUR7YyER4pzfh49Eyld0EflY0SlDsnLlC9Y8OLiS91V1pqGfqUTkyHIBy0I8Kf3nvu
 Ckog2ops2CXXjaJmTPT4ES3yj8ZHFnjfqiqn3VWY+G9Ro0FlGQiPLpiTRVNkyUNEFin8ZLqt2f9
 Q9Zex+4wib+UCRBeo+nxHFzMdcJJQMOe6zmvfbCZu0hZTAP5AkohOvHwMT9FmENulSxHu7J/jf2
 V6wwv+LwCmYUHASYT9A==
X-Proofpoint-ORIG-GUID: R8G4eGb7LpjGFDD63Bj2xqQwJ02XTvwx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX2kxluYZRnRlM
 NglFcP3cxfPTeXNxx1TSF0k6q5Pdt6p5+A8HG/BrGvt0+wW6YW0bKOfIY+Vrlwh8xgQA3OT9qhG
 kmo0sho6Yu+lzHKX/GVfODtkUuoMvUzpN/7cjSmAyZW6a012sWv+
X-Authority-Analysis: v=2.4 cv=Ood/DS/t c=1 sm=1 tr=0 ts=6a345775 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=6vICrReggJXa14mXokMA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: R8G4eGb7LpjGFDD63Bj2xqQwJ02XTvwx
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 545f6cf8f4c9a268e0bab2637f1d279679befdbf ]

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions for both, replace the Elf_Shdr macro with a
union that defines both Elf64_Shdr and Elf32_Shdr, with field e64 for the
64bit version, and e32 for the 32bit version.

It can then use the macro etype to get the proper value.

This will eventually be replaced with just single functions that can
handle both 32bit and 64bit ELF parsing.

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
Link: https://lore.kernel.org/20250105162345.339462681@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 10 ++++++
 scripts/sorttable.h | 74 +++++++++++++++++++++++++--------------------
 2 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 67cbbfc82..94497b8ab 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -69,6 +69,11 @@ typedef union {
 	Elf64_Ehdr	e64;
 } Elf_Ehdr;
 
+typedef union {
+	Elf32_Shdr	e32;
+	Elf64_Shdr	e64;
+} Elf_Shdr;
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
@@ -198,6 +203,11 @@ static int compare_extable_64(const void *a, const void *b)
 	return av > bv;
 }
 
+static inline void *get_index(void *start, int entsize, int index)
+{
+	return start + (entsize * index);
+}
+
 /* 32 bit and 64 bit are very similar */
 #include "sorttable.h"
 #define SORTTABLE_64
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index be8b52949..3daf37bb6 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,7 +23,6 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef Elf_Shdr
 #undef Elf_Sym
 #undef ELF_ST_TYPE
 #undef uint_t
@@ -37,7 +36,6 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define Elf_Shdr		Elf64_Shdr
 # define Elf_Sym		Elf64_Sym
 # define ELF_ST_TYPE		ELF64_ST_TYPE
 # define uint_t			uint64_t
@@ -50,7 +48,6 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define Elf_Shdr		Elf32_Shdr
 # define Elf_Sym		Elf32_Sym
 # define ELF_ST_TYPE		ELF32_ST_TYPE
 # define uint_t			uint32_t
@@ -171,8 +168,8 @@ struct elf_mcount_loc {
 static void *sort_mcount_loc(void *arg)
 {
 	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
-	uint_t offset = emloc->start_mcount_loc - _r(&(emloc->init_data_sec)->sh_addr)
-					+ _r(&(emloc->init_data_sec)->sh_offset);
+	uint_t offset = emloc->start_mcount_loc - _r(&(emloc->init_data_sec)->etype.sh_addr)
+					+ _r(&(emloc->init_data_sec)->etype.sh_offset);
 	uint_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 
@@ -222,10 +219,11 @@ static int do_sort(Elf_Ehdr *ehdr,
 		   table_sort_t custom_sort)
 {
 	int rc = -1;
-	Elf_Shdr *s, *shdr = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->etype.e_shoff));
+	Elf_Shdr *shdr_start;
 	Elf_Shdr *strtab_sec = NULL;
 	Elf_Shdr *symtab_sec = NULL;
 	Elf_Shdr *extab_sec = NULL;
+	Elf_Shdr *string_sec;
 	Elf_Sym *sym;
 	const Elf_Sym *symtab;
 	Elf32_Word *symtab_shndx = NULL;
@@ -235,7 +233,10 @@ static int do_sort(Elf_Ehdr *ehdr,
 	const char *secstrings;
 	const char *strtab;
 	char *extab_image;
+	int sort_need_index;
+	int shentsize;
 	int idx;
+	int i;
 	unsigned int shnum;
 	unsigned int shstrndx;
 #ifdef MCOUNT_SORT_ENABLED
@@ -249,34 +250,40 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int orc_num_entries = 0;
 #endif
 
+	shdr_start = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->etype.e_shoff));
+	shentsize = r2(&ehdr->etype.e_shentsize);
+
 	shstrndx = r2(&ehdr->etype.e_shstrndx);
 	if (shstrndx == SHN_XINDEX)
-		shstrndx = r(&shdr[0].sh_link);
-	secstrings = (const char *)ehdr + _r(&shdr[shstrndx].sh_offset);
+		shstrndx = r(&shdr_start->etype.sh_link);
+	string_sec = get_index(shdr_start, shentsize, shstrndx);
+	secstrings = (const char *)ehdr + _r(&string_sec->etype.sh_offset);
 
 	shnum = r2(&ehdr->etype.e_shnum);
 	if (shnum == SHN_UNDEF)
-		shnum = _r(&shdr[0].sh_size);
+		shnum = _r(&shdr_start->etype.sh_size);
+
+	for (i = 0; i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
 
-	for (s = shdr; s < shdr + shnum; s++) {
-		idx = r(&s->sh_name);
+		idx = r(&shdr->etype.sh_name);
 		if (!strcmp(secstrings + idx, "__ex_table"))
-			extab_sec = s;
+			extab_sec = shdr;
 		if (!strcmp(secstrings + idx, ".symtab"))
-			symtab_sec = s;
+			symtab_sec = shdr;
 		if (!strcmp(secstrings + idx, ".strtab"))
-			strtab_sec = s;
+			strtab_sec = shdr;
 
-		if (r(&s->sh_type) == SHT_SYMTAB_SHNDX)
+		if (r(&shdr->etype.sh_type) == SHT_SYMTAB_SHNDX)
 			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
-						      _r(&s->sh_offset));
+						      _r(&shdr->etype.sh_offset));
 
 #ifdef MCOUNT_SORT_ENABLED
 		/* locate the .init.data section in vmlinux */
 		if (!strcmp(secstrings + idx, ".init.data")) {
 			get_mcount_loc(&_start_mcount_loc, &_stop_mcount_loc);
 			mstruct.ehdr = ehdr;
-			mstruct.init_data_sec = s;
+			mstruct.init_data_sec = shdr;
 			mstruct.start_mcount_loc = _start_mcount_loc;
 			mstruct.stop_mcount_loc = _stop_mcount_loc;
 		}
@@ -285,14 +292,14 @@ static int do_sort(Elf_Ehdr *ehdr,
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
-			orc_ip_size = _r(&s->sh_size);
+			orc_ip_size = _r(&shdr->etype.sh_size);
 			g_orc_ip_table = (int *)((void *)ehdr +
-						   _r(&s->sh_offset));
+						   _r(&shdr->etype.sh_offset));
 		}
 		if (!strcmp(secstrings + idx, ".orc_unwind")) {
-			orc_size = _r(&s->sh_size);
+			orc_size = _r(&shdr->etype.sh_size);
 			g_orc_table = (struct orc_entry *)((void *)ehdr +
-							     _r(&s->sh_offset));
+							     _r(&shdr->etype.sh_offset));
 		}
 #endif
 	} /* for loop */
@@ -355,22 +362,22 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 
-	extab_image = (void *)ehdr + _r(&extab_sec->sh_offset);
-	strtab = (const char *)ehdr + _r(&strtab_sec->sh_offset);
+	extab_image = (void *)ehdr + _r(&extab_sec->etype.sh_offset);
+	strtab = (const char *)ehdr + _r(&strtab_sec->etype.sh_offset);
 	symtab = (const Elf_Sym *)((const char *)ehdr +
-						  _r(&symtab_sec->sh_offset));
+						  _r(&symtab_sec->etype.sh_offset));
 
 	if (custom_sort) {
-		custom_sort(extab_image, _r(&extab_sec->sh_size));
+		custom_sort(extab_image, _r(&extab_sec->etype.sh_size));
 	} else {
-		int num_entries = _r(&extab_sec->sh_size) / extable_ent_size;
+		int num_entries = _r(&extab_sec->etype.sh_size) / extable_ent_size;
 		qsort(extab_image, num_entries,
 		      extable_ent_size, compare_extable);
 	}
 
 	/* find the flag main_extable_sort_needed */
-	for (sym = (void *)ehdr + _r(&symtab_sec->sh_offset);
-	     sym < sym + _r(&symtab_sec->sh_size) / sizeof(Elf_Sym);
+	for (sym = (void *)ehdr + _r(&symtab_sec->etype.sh_offset);
+	     sym < sym + _r(&symtab_sec->etype.sh_size) / sizeof(Elf_Sym);
 	     sym++) {
 		if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
 			continue;
@@ -388,13 +395,14 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 
-	sort_needed_sec = &shdr[get_secindex(r2(&sym->st_shndx),
-					     sort_needed_sym - symtab,
-					     symtab_shndx)];
+	sort_need_index = get_secindex(r2(&sym->st_shndx),
+				       sort_needed_sym - symtab,
+				       symtab_shndx);
+	sort_needed_sec = get_index(shdr_start, shentsize, sort_need_index);
 	sort_needed_loc = (void *)ehdr +
-		_r(&sort_needed_sec->sh_offset) +
+		_r(&sort_needed_sec->etype.sh_offset) +
 		_r(&sort_needed_sym->st_value) -
-		_r(&sort_needed_sec->sh_addr);
+		_r(&sort_needed_sec->etype.sh_addr);
 
 	/* extable has been sorted, clear the flag */
 	w(0, sort_needed_loc);
-- 
2.34.1

