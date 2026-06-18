Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232262FB969
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815330; cv=none; b=dnRXHBOESMxsBN+H6Hu8nEQzd+bnt/itP7dk29kY92o9AEACQ/PIBl6MXWv0sxjgL++UtOLLSjUyEE/KMnOmhZqSzzpAtpA4D8mtGs1xSd7PQCAZHxxgrpqa5tYbGyc3dlzQVhqWjbZXSD4qKK6Lggz9E/UnsR2mqCT8m/OTO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815330; c=relaxed/simple;
	bh=My3xmgJq2lsybi1jw06RzcvHBgxZZZGRCIyQJ7yxezQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpZ2mIGlM1XHkXSzahe2vqxIitKF5pvSpF3UfFDDswILMOsT9oTsDIIdD/iRXAqQRZlcg9OsAPKJ/zdVWQStI48Iiobe2Ejndy+lHDr7eFRd+lg0OD779AVuHZQu6EqZ2MUAFqqiyKBbb8NlrzBbecAxtNboQ5dijlBjk01pmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=DEM14Ge8; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="DEM14Ge8"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIscCd3950445;
	Thu, 18 Jun 2026 20:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=IOvChE/duvk5DudeUJL7HsfzCodbD6lya2dRn+IaZGA=; b=DEM1
	4Ge8rWle4TVRkpk0u3Y/d9vBiMq/v5AGGxwnSXszu1+vrkUoPsuH6SeUp5N3sA1c
	jtBoCcHC1TeahgyuqdRD0magh2KcyEZEWsKL1Li6xvewdOBO0rZ1IA1kt8tGxrje
	0xhQJwzNewEgA5KKkd/KbKcWqTuzgcwgq+HifRASSM9rRG7FP9xjduKyQyN48NEU
	TE3brekJdT39EASUWkTn5vOMuEuSXRoWjI/LmNNhwTW0AlojoGXrAMLfK/jkpeKV
	3QLXd5Pxv7Xont2IPmuHCk6QQ+4XPYO9e5Q/tZ5yyizUu8dJ9ivKygg7Z2nV26Vr
	/At/BFVY5iJNH8AQ5A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4evd10aqhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:15:54 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:15:52 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 06/27] scripts/sorttable: Convert Elf_Ehdr to union
Date: Thu, 18 Jun 2026 16:15:20 -0400
Message-ID: <ffbf4890fa9bdef1135c98294fc40bbe5f918004.1781809926.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX0KjjBHeTttDP
 bMMkcn6X6/SJhUAvtClN+11EW/Cog9cIyju+rioUSUTMazkcx8KeaaBJhKFXbIIgyhQZXVFrl25
 z2Ditn7MuK/In2p08fXKew2ZeoY4KW9juQNRrKFDhdbqkkUDMQfBOZ48vr6hPbFdz5eokS+fE62
 uSjh21ek5muBqlmPQHIFPLR0te+Up14NkRli9I67DR1TfH8kZbTEO3PgITPFXptEkS86P5r+Q/8
 4KWD6ulbPQdLCEszcN2VID/q9EW19R5nd1UG/lXyvtNP2/kD6l+39Yta30BjWtSMIQXRbggQcUo
 VaLJzHmOghbmiDKZvWVF/RuNNHGTqvoPpeIfl2KTfE+/zJo5pSJMw1TkeZc7tkhPjYjyLLoJAsw
 mRI/3UhW9mPqg99PWD+yrGdO7WPLY6xDvd52WIEz6+x7few0yT37jZx68WKvaDXlBNQcBBBK0h9
 3vsnmbgdd1Ld9K1Et7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX0xayFkkTqhxH
 VPq6Q3E8oT5//i258nc7Lbc1fFSy1WQbjrq9p0BFWTVsTt8gJD+8z8x042InZu1DjB3e9wmAYmW
 CugkEDuMnJMSRKKu3/STWjdirVH7Uag36XiY8RBg5klsvluoLSwg
X-Proofpoint-ORIG-GUID: 4RDy_I40yP46RcenIvyWQ4mkvNXEwMAf
X-Proofpoint-GUID: 4RDy_I40yP46RcenIvyWQ4mkvNXEwMAf
X-Authority-Analysis: v=2.4 cv=L7UtheT8 c=1 sm=1 tr=0 ts=6a3451fa cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=Qq8QHfOQB_7rfYQ4AIIA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 157fb5b3cfd2cb5950314f926a76e567fc1921c5 ]

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions for both, replace the Elf_Ehdr macro with a
union that defines both Elf64_Ehdr and Elf32_Ehdr, with field e64 for the
64bit version, and e32 for the 32bit version.

Then a macro etype can be used instead to get to the proper value.

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
Link: https://lore.kernel.org/20250105162345.148224465@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 36 ++++++++++++++++++++----------------
 scripts/sorttable.h | 12 ++++++------
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 3e2c17e91..67cbbfc82 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -64,6 +64,11 @@
 #define EM_LOONGARCH	258
 #endif
 
+typedef union {
+	Elf32_Ehdr	e32;
+	Elf64_Ehdr	e64;
+} Elf_Ehdr;
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
@@ -266,10 +271,10 @@ static void sort_relative_table_with_data(char *extab_image, int image_size)
 static int do_file(char const *const fname, void *addr)
 {
 	int rc = -1;
-	Elf32_Ehdr *ehdr = addr;
+	Elf_Ehdr *ehdr = addr;
 	table_sort_t custom_sort = NULL;
 
-	switch (ehdr->e_ident[EI_DATA]) {
+	switch (ehdr->e32.e_ident[EI_DATA]) {
 	case ELFDATA2LSB:
 		r	= rle;
 		r2	= r2le;
@@ -284,18 +289,18 @@ static int do_file(char const *const fname, void *addr)
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
-			ehdr->e_ident[EI_DATA], fname);
+			ehdr->e32.e_ident[EI_DATA], fname);
 		return -1;
 	}
 
-	if (memcmp(ELFMAG, ehdr->e_ident, SELFMAG) != 0 ||
-	    (r2(&ehdr->e_type) != ET_EXEC && r2(&ehdr->e_type) != ET_DYN) ||
-	    ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
+	if (memcmp(ELFMAG, ehdr->e32.e_ident, SELFMAG) != 0 ||
+	    (r2(&ehdr->e32.e_type) != ET_EXEC && r2(&ehdr->e32.e_type) != ET_DYN) ||
+	    ehdr->e32.e_ident[EI_VERSION] != EV_CURRENT) {
 		fprintf(stderr, "unrecognized ET_EXEC/ET_DYN file %s\n", fname);
 		return -1;
 	}
 
-	switch (r2(&ehdr->e_machine)) {
+	switch (r2(&ehdr->e32.e_machine)) {
 	case EM_386:
 	case EM_AARCH64:
 	case EM_LOONGARCH:
@@ -318,14 +323,14 @@ static int do_file(char const *const fname, void *addr)
 		break;
 	default:
 		fprintf(stderr, "unrecognized e_machine %d %s\n",
-			r2(&ehdr->e_machine), fname);
+			r2(&ehdr->e32.e_machine), fname);
 		return -1;
 	}
 
-	switch (ehdr->e_ident[EI_CLASS]) {
+	switch (ehdr->e32.e_ident[EI_CLASS]) {
 	case ELFCLASS32:
-		if (r2(&ehdr->e_ehsize) != sizeof(Elf32_Ehdr) ||
-		    r2(&ehdr->e_shentsize) != sizeof(Elf32_Shdr)) {
+		if (r2(&ehdr->e32.e_ehsize) != sizeof(Elf32_Ehdr) ||
+		    r2(&ehdr->e32.e_shentsize) != sizeof(Elf32_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_EXEC/ET_DYN file: %s\n", fname);
 			break;
@@ -334,20 +339,19 @@ static int do_file(char const *const fname, void *addr)
 		break;
 	case ELFCLASS64:
 		{
-		Elf64_Ehdr *const ghdr = (Elf64_Ehdr *)ehdr;
-		if (r2(&ghdr->e_ehsize) != sizeof(Elf64_Ehdr) ||
-		    r2(&ghdr->e_shentsize) != sizeof(Elf64_Shdr)) {
+		if (r2(&ehdr->e64.e_ehsize) != sizeof(Elf64_Ehdr) ||
+		    r2(&ehdr->e64.e_shentsize) != sizeof(Elf64_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_EXEC/ET_DYN file: %s\n",
 				fname);
 			break;
 		}
-		rc = do_sort_64(ghdr, fname, custom_sort);
+		rc = do_sort_64(ehdr, fname, custom_sort);
 		}
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF class %d %s\n",
-			ehdr->e_ident[EI_CLASS], fname);
+			ehdr->e32.e_ident[EI_CLASS], fname);
 		break;
 	}
 
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 36655ff16..be8b52949 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,12 +23,12 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef Elf_Ehdr
 #undef Elf_Shdr
 #undef Elf_Sym
 #undef ELF_ST_TYPE
 #undef uint_t
 #undef _r
+#undef etype
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -37,12 +37,12 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
 # define Elf_Sym		Elf64_Sym
 # define ELF_ST_TYPE		ELF64_ST_TYPE
 # define uint_t			uint64_t
 # define _r			r8
+# define etype			e64
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -50,12 +50,12 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
 # define Elf_Sym		Elf32_Sym
 # define ELF_ST_TYPE		ELF32_ST_TYPE
 # define uint_t			uint32_t
 # define _r			r
+# define etype			e32
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -222,7 +222,7 @@ static int do_sort(Elf_Ehdr *ehdr,
 		   table_sort_t custom_sort)
 {
 	int rc = -1;
-	Elf_Shdr *s, *shdr = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->e_shoff));
+	Elf_Shdr *s, *shdr = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->etype.e_shoff));
 	Elf_Shdr *strtab_sec = NULL;
 	Elf_Shdr *symtab_sec = NULL;
 	Elf_Shdr *extab_sec = NULL;
@@ -249,12 +249,12 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int orc_num_entries = 0;
 #endif
 
-	shstrndx = r2(&ehdr->e_shstrndx);
+	shstrndx = r2(&ehdr->etype.e_shstrndx);
 	if (shstrndx == SHN_XINDEX)
 		shstrndx = r(&shdr[0].sh_link);
 	secstrings = (const char *)ehdr + _r(&shdr[shstrndx].sh_offset);
 
-	shnum = r2(&ehdr->e_shnum);
+	shnum = r2(&ehdr->etype.e_shnum);
 	if (shnum == SHN_UNDEF)
 		shnum = _r(&shdr[0].sh_size);
 
-- 
2.34.1

