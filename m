Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5BC3491E1
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815174; cv=none; b=l4c3ApacD3c9wX6HeQh13crobWxSeu1+oSzPaz8GRVBgi9nBRbTk+Go8kiyf7ffIARu8wz2iXpFlTwXjEpb4p+J3uYVCO0ve/GR520hjfMpaIZfTSYM1XmpCYDvY8u5FVza1lCXW1LjPTheocffJxfO5BCs/eAGdMDl1uiOo1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815174; c=relaxed/simple;
	bh=IvjEefjucPIL/OaYBLvCmm6C+XOCNJTPhFw806cJmEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJzt4VLD08qU+3+lz/ORTvUkB9CmAXtIfF4cFE+CGjEvI4L/6YeiIGgYHfRVyrgKkw/GeOQFrpRQO1EtMIJ5djshsFOwzyDZabc7Rxvlz6OxBzK9X8pTh2PEgv4TydYxpDmykJg55i0rz+GRFMdJwnf1w7OE/myjsZZmNKsUqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=lg7/KMTp; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="lg7/KMTp"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsm1h3923252;
	Thu, 18 Jun 2026 20:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=yybgKBh+h9JjNx6fz79m2HIOIq1A7PRzoThnx/A0eh8=; b=lg7/
	KMTpUy54s8E3aT1KO6iQ551p8nrzyKvxl4UvOfsAiGyeACqdmAVfbr1ohVY3wVYX
	D1/Ve/Bes0mPqHtrrOX7NnyY6WLc7L2eWtsBeKBM7JyLEcrx34yppG8OPs1MsNUT
	GYlRIPeX7cCoTyxjzPnteufo3w49Vtq6U9xwYhJP+3EnCXYJsJc9o4oyET6hmfij
	Kz4ztOib+UT+S3zDgda/OcmFdMnH6TBF4RfFuocb6wNcurODum3646KbIJTSYdmG
	mJNSncoFtgA+OC89/69OcPRFBXtdw4obU2e/7zIguYQGBAj6/pNRk1wIwNI9ftDI
	a8eJflBD7nptWEaCEA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ev4y0vfpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:27 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:25 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 15/27] scripts/sorttable: Use a structure of function pointers for elf helpers
Date: Thu, 18 Jun 2026 16:38:53 -0400
Message-ID: <377ded38dbd2eae778204e8a1c42e24d9814da8c.1781814131.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX/w6p/L+v65F+
 sn5+Dik+HVf3mbOJ6R7NITF4dVWZ/V29i1q462TCBEFeAvNoa3BWkuUcrE0GYQOHeAzcEcCBlG1
 9NZJ69sFSeNzvCUYvwMY6Mcbvkp1qyL4D0AVaqtvCrh/TdhVfcLCzLY7++DUisxshJvbgIbNnTs
 bwuB+MFL1gzzSWTFsuBVJ2g5HPUa/unfLC4xXCCs8Q13aDI27jQ1tjNbvUst7yhXSVxJTmnCsnp
 RwWOr+TVWSC93fZ5/J6zaeiB0nT4jjv8ohg82uhoqOLpcPoUVSJHEFIdmVAVkMBFJ1zN+oaijn4
 YUL8FpoInlrVvYRAmQ9peje09IC7w26Fgp3jE1OqfLqvA81NvLzUHsUQUGk6oRFJ1urrBnrELIW
 KLxWSqrRqeccdzKJHbIdkRTF3FXtfuI9YNtjUZQ8PQ/EtM/9eaU05s1XnfoSsCUP6ilHzY6lLme
 4A2TZGUoT6POFxC/7rA==
X-Proofpoint-ORIG-GUID: wQ4f6syENSBMzuAVibq94XDgT43045xX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX8SpZegNtTBIr
 C8g56mW+Sq2bkB2+Bk+16ZwqXvB2b5ynLqg4VcqTtfkfTano/bDk+xpiWVK721H4OZMQWImjio4
 S6wwVhCx0Xvuxpl0nUgcWjfYTL8URKA+I3wx6Z3/otnoOPMXfGvo
X-Authority-Analysis: v=2.4 cv=Ood/DS/t c=1 sm=1 tr=0 ts=6a34577f cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=Rv9EHqwlEhjXL7MG:21 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8
 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8
 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8
 a=rOUgymgbAAAA:8 a=sxh15xuNzgYjd5F5KOEA:9 a=2JgSa4NbpEOStq-L5dxp:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22 a=HkZW87K1Qel5hWWM3VKY:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22 a=Et2XPkok5AAZYJIKzHr1:22
 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-GUID: wQ4f6syENSBMzuAVibq94XDgT43045xX
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 1e5f6771c247b28135307058d2cfe3b0153733dc ]

Instead of having a series of function pointers that gets assigned to the
Elf64 or Elf32 versions, put them all into a single structure and use
that. Add the helper function that chooses the structure into the macros
that build the different versions of the elf functions.

Link: https://lore.kernel.org/all/CAHk-=wiafEyX7UgOeZgvd6fvuByE5WXUPh9599kwOc_d-pdeug@mail.gmail.com/

Cc: bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/20250110075459.13d4b94c@gandalf.local.home
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 175 +++++++++++++++++++++++++++++---------------
 1 file changed, 118 insertions(+), 57 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 656c1e9b5..9f41575af 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -85,6 +85,25 @@ static uint64_t (*r8)(const uint64_t *);
 static void (*w)(uint32_t, uint32_t *);
 typedef void (*table_sort_t)(char *, int);
 
+static struct elf_funcs {
+	int (*compare_extable)(const void *a, const void *b);
+	uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
+	uint16_t (*ehdr_shstrndx)(Elf_Ehdr *ehdr);
+	uint16_t (*ehdr_shentsize)(Elf_Ehdr *ehdr);
+	uint16_t (*ehdr_shnum)(Elf_Ehdr *ehdr);
+	uint64_t (*shdr_addr)(Elf_Shdr *shdr);
+	uint64_t (*shdr_offset)(Elf_Shdr *shdr);
+	uint64_t (*shdr_size)(Elf_Shdr *shdr);
+	uint64_t (*shdr_entsize)(Elf_Shdr *shdr);
+	uint32_t (*shdr_link)(Elf_Shdr *shdr);
+	uint32_t (*shdr_name)(Elf_Shdr *shdr);
+	uint32_t (*shdr_type)(Elf_Shdr *shdr);
+	uint8_t (*sym_type)(Elf_Sym *sym);
+	uint32_t (*sym_name)(Elf_Sym *sym);
+	uint64_t (*sym_value)(Elf_Sym *sym);
+	uint16_t (*sym_shndx)(Elf_Sym *sym);
+} e;
+
 static uint64_t ehdr64_shoff(Elf_Ehdr *ehdr)
 {
 	return r8(&ehdr->e64.e_shoff);
@@ -95,6 +114,11 @@ static uint64_t ehdr32_shoff(Elf_Ehdr *ehdr)
 	return r(&ehdr->e32.e_shoff);
 }
 
+static uint64_t ehdr_shoff(Elf_Ehdr *ehdr)
+{
+	return e.ehdr_shoff(ehdr);
+}
+
 #define EHDR_HALF(fn_name)				\
 static uint16_t ehdr64_##fn_name(Elf_Ehdr *ehdr)	\
 {							\
@@ -104,6 +128,11 @@ static uint16_t ehdr64_##fn_name(Elf_Ehdr *ehdr)	\
 static uint16_t ehdr32_##fn_name(Elf_Ehdr *ehdr)	\
 {							\
 	return r2(&ehdr->e32.e_##fn_name);		\
+}							\
+							\
+static uint16_t ehdr_##fn_name(Elf_Ehdr *ehdr)		\
+{							\
+	return e.ehdr_##fn_name(ehdr);			\
 }
 
 EHDR_HALF(shentsize)
@@ -119,6 +148,11 @@ static uint32_t shdr64_##fn_name(Elf_Shdr *shdr)	\
 static uint32_t shdr32_##fn_name(Elf_Shdr *shdr)	\
 {							\
 	return r(&shdr->e32.sh_##fn_name);		\
+}							\
+							\
+static uint32_t shdr_##fn_name(Elf_Shdr *shdr)		\
+{							\
+	return e.shdr_##fn_name(shdr);			\
 }
 
 #define SHDR_ADDR(fn_name)				\
@@ -130,6 +164,11 @@ static uint64_t shdr64_##fn_name(Elf_Shdr *shdr)	\
 static uint64_t shdr32_##fn_name(Elf_Shdr *shdr)	\
 {							\
 	return r(&shdr->e32.sh_##fn_name);		\
+}							\
+							\
+static uint64_t shdr_##fn_name(Elf_Shdr *shdr)		\
+{							\
+	return e.shdr_##fn_name(shdr);			\
 }
 
 #define SHDR_WORD(fn_name)				\
@@ -141,6 +180,10 @@ static uint32_t shdr64_##fn_name(Elf_Shdr *shdr)	\
 static uint32_t shdr32_##fn_name(Elf_Shdr *shdr)	\
 {							\
 	return r(&shdr->e32.sh_##fn_name);		\
+}							\
+static uint32_t shdr_##fn_name(Elf_Shdr *shdr)		\
+{							\
+	return e.shdr_##fn_name(shdr);			\
 }
 
 SHDR_ADDR(addr)
@@ -161,6 +204,11 @@ static uint64_t sym64_##fn_name(Elf_Sym *sym)	\
 static uint64_t sym32_##fn_name(Elf_Sym *sym)	\
 {						\
 	return r(&sym->e32.st_##fn_name);	\
+}						\
+						\
+static uint64_t sym_##fn_name(Elf_Sym *sym)	\
+{						\
+	return e.sym_##fn_name(sym);		\
 }
 
 #define SYM_WORD(fn_name)			\
@@ -172,6 +220,11 @@ static uint32_t sym64_##fn_name(Elf_Sym *sym)	\
 static uint32_t sym32_##fn_name(Elf_Sym *sym)	\
 {						\
 	return r(&sym->e32.st_##fn_name);	\
+}						\
+						\
+static uint32_t sym_##fn_name(Elf_Sym *sym)	\
+{						\
+	return e.sym_##fn_name(sym);		\
 }
 
 #define SYM_HALF(fn_name)			\
@@ -183,6 +236,11 @@ static uint16_t sym64_##fn_name(Elf_Sym *sym)	\
 static uint16_t sym32_##fn_name(Elf_Sym *sym)	\
 {						\
 	return r2(&sym->e32.st_##fn_name);	\
+}						\
+						\
+static uint16_t sym_##fn_name(Elf_Sym *sym)	\
+{						\
+	return e.sym_##fn_name(sym);		\
 }
 
 static uint8_t sym64_type(Elf_Sym *sym)
@@ -195,6 +253,11 @@ static uint8_t sym32_type(Elf_Sym *sym)
 	return ELF32_ST_TYPE(sym->e32.st_info);
 }
 
+static uint8_t sym_type(Elf_Sym *sym)
+{
+	return e.sym_type(sym);
+}
+
 SYM_ADDR(value)
 SYM_WORD(name)
 SYM_HALF(shndx)
@@ -322,29 +385,16 @@ static int compare_extable_64(const void *a, const void *b)
 	return av > bv;
 }
 
+static int compare_extable(const void *a, const void *b)
+{
+	return e.compare_extable(a, b);
+}
+
 static inline void *get_index(void *start, int entsize, int index)
 {
 	return start + (entsize * index);
 }
 
-
-static int (*compare_extable)(const void *a, const void *b);
-static uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
-static uint16_t (*ehdr_shstrndx)(Elf_Ehdr *ehdr);
-static uint16_t (*ehdr_shentsize)(Elf_Ehdr *ehdr);
-static uint16_t (*ehdr_shnum)(Elf_Ehdr *ehdr);
-static uint64_t (*shdr_addr)(Elf_Shdr *shdr);
-static uint64_t (*shdr_offset)(Elf_Shdr *shdr);
-static uint64_t (*shdr_size)(Elf_Shdr *shdr);
-static uint64_t (*shdr_entsize)(Elf_Shdr *shdr);
-static uint32_t (*shdr_link)(Elf_Shdr *shdr);
-static uint32_t (*shdr_name)(Elf_Shdr *shdr);
-static uint32_t (*shdr_type)(Elf_Shdr *shdr);
-static uint8_t (*sym_type)(Elf_Sym *sym);
-static uint32_t (*sym_name)(Elf_Sym *sym);
-static uint64_t (*sym_value)(Elf_Sym *sym);
-static uint16_t (*sym_shndx)(Elf_Sym *sym);
-
 static int extable_ent_size;
 static int long_size;
 
@@ -864,7 +914,30 @@ static int do_file(char const *const fname, void *addr)
 	}
 
 	switch (ehdr->e32.e_ident[EI_CLASS]) {
-	case ELFCLASS32:
+	case ELFCLASS32: {
+		struct elf_funcs efuncs = {
+			.compare_extable	= compare_extable_32,
+			.ehdr_shoff		= ehdr32_shoff,
+			.ehdr_shentsize		= ehdr32_shentsize,
+			.ehdr_shstrndx		= ehdr32_shstrndx,
+			.ehdr_shnum		= ehdr32_shnum,
+			.shdr_addr		= shdr32_addr,
+			.shdr_offset		= shdr32_offset,
+			.shdr_link		= shdr32_link,
+			.shdr_size		= shdr32_size,
+			.shdr_name		= shdr32_name,
+			.shdr_type		= shdr32_type,
+			.shdr_entsize		= shdr32_entsize,
+			.sym_type		= sym32_type,
+			.sym_name		= sym32_name,
+			.sym_value		= sym32_value,
+			.sym_shndx		= sym32_shndx,
+		};
+
+		e = efuncs;
+		long_size		= 4;
+		extable_ent_size	= 8;
+
 		if (r2(&ehdr->e32.e_ehsize) != sizeof(Elf32_Ehdr) ||
 		    r2(&ehdr->e32.e_shentsize) != sizeof(Elf32_Shdr)) {
 			fprintf(stderr,
@@ -872,26 +945,32 @@ static int do_file(char const *const fname, void *addr)
 			return -1;
 		}
 
-		compare_extable		= compare_extable_32;
-		ehdr_shoff		= ehdr32_shoff;
-		ehdr_shentsize		= ehdr32_shentsize;
-		ehdr_shstrndx		= ehdr32_shstrndx;
-		ehdr_shnum		= ehdr32_shnum;
-		shdr_addr		= shdr32_addr;
-		shdr_offset		= shdr32_offset;
-		shdr_link		= shdr32_link;
-		shdr_size		= shdr32_size;
-		shdr_name		= shdr32_name;
-		shdr_type		= shdr32_type;
-		shdr_entsize		= shdr32_entsize;
-		sym_type		= sym32_type;
-		sym_name		= sym32_name;
-		sym_value		= sym32_value;
-		sym_shndx		= sym32_shndx;
-		long_size		= 4;
-		extable_ent_size	= 8;
+		}
 		break;
-	case ELFCLASS64:
+	case ELFCLASS64: {
+		struct elf_funcs efuncs = {
+			.compare_extable	= compare_extable_64,
+			.ehdr_shoff		= ehdr64_shoff,
+			.ehdr_shentsize		= ehdr64_shentsize,
+			.ehdr_shstrndx		= ehdr64_shstrndx,
+			.ehdr_shnum		= ehdr64_shnum,
+			.shdr_addr		= shdr64_addr,
+			.shdr_offset		= shdr64_offset,
+			.shdr_link		= shdr64_link,
+			.shdr_size		= shdr64_size,
+			.shdr_name		= shdr64_name,
+			.shdr_type		= shdr64_type,
+			.shdr_entsize		= shdr64_entsize,
+			.sym_type		= sym64_type,
+			.sym_name		= sym64_name,
+			.sym_value		= sym64_value,
+			.sym_shndx		= sym64_shndx,
+		};
+
+		e = efuncs;
+		long_size		= 8;
+		extable_ent_size	= 16;
+
 		if (r2(&ehdr->e64.e_ehsize) != sizeof(Elf64_Ehdr) ||
 		    r2(&ehdr->e64.e_shentsize) != sizeof(Elf64_Shdr)) {
 			fprintf(stderr,
@@ -900,25 +979,7 @@ static int do_file(char const *const fname, void *addr)
 			return -1;
 		}
 
-		compare_extable		= compare_extable_64;
-		ehdr_shoff		= ehdr64_shoff;
-		ehdr_shentsize		= ehdr64_shentsize;
-		ehdr_shstrndx		= ehdr64_shstrndx;
-		ehdr_shnum		= ehdr64_shnum;
-		shdr_addr		= shdr64_addr;
-		shdr_offset		= shdr64_offset;
-		shdr_link		= shdr64_link;
-		shdr_size		= shdr64_size;
-		shdr_name		= shdr64_name;
-		shdr_type		= shdr64_type;
-		shdr_entsize		= shdr64_entsize;
-		sym_type		= sym64_type;
-		sym_name		= sym64_name;
-		sym_value		= sym64_value;
-		sym_shndx		= sym64_shndx;
-		long_size		= 8;
-		extable_ent_size	= 16;
-
+		}
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF class %d %s\n",
-- 
2.34.1

