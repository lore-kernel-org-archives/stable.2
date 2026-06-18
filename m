Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA66B279907
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813774; cv=none; b=RS3WIoAUxsdy3bH9+I8jJILkySFASkP8fY7cxx2IIFtNjw3rJsYjv11I1eLtKBDN6626e6oCPhdyX6zJ//8JRTenpl1epyYJYhiV+i8kMxqPoeC3IKaRRMUPGAm2VmQighi6vCno8iIFSa0GkHgN99sS/vMINlOVg4DNvWPZhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813774; c=relaxed/simple;
	bh=5a9VWgh8a81sIobifLnVAz+uUOPaQTiS5NhJUwz1D+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmYMcoFTsXtV3BmRMfftNV+M7n+W0gLVnEe8XmGcNfwmZJsFd2xEzIxQIgndraiPK7MMMl2Vuk7ysmP+1MoQgkoopam09Ixe6nw8RD/YNp91F6u0nM2cZ9hpgWb8C5n6NY5984qGdok5hZS4dCg0c1XFYutXrUcxzSqGSoiGPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=v2v21Cir; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="v2v21Cir"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsfhv3939470;
	Thu, 18 Jun 2026 20:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=RX20JOsH9O96WwVm4+2KSq8fH4UbXB+jDoGXUbX1UFY=; b=v2v2
	1CirbQZi5XvgsofPHsO9C6oYRWTQ3NOnqzwoqXzDznC8FSBb9R1hhVUYl01neJEw
	FfIbxUcW1FwShUyLfTpTRE35OcKdUCXDEKXpzfDYMd5z/ZBj54FEvRY0Q1iUD11C
	mJuS8O0N6Ti36L7P1pUZ004vEUP9+sexdQ/bdAzCANs6j8kdtOSLqrar0sKAwiEa
	1JVr4DBGQ2O7JMTvMIJAJeafgb75J7ZdlJcUKICsdxaz/pz+8yWsY4c7jpqF0R/t
	UOPJRw+Z05fHNy5ImMc/Le3zNLcWsG+2MCA041FUdUNgEF2IXXtJMTMk7sI6BV0A
	g1qJ/EntESx/Y0dV1g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev5c6uwyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:07 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:05 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 16/27] arm64: scripts/sorttable: Implement sorting mcount_loc at boot for arm64
Date: Thu, 18 Jun 2026 16:15:30 -0400
Message-ID: <bf4bcdb583a211d91e2e566510551b8dab733ea5.1781809956.git.andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=Eez4hvmC c=1 sm=1 tr=0 ts=6a345207 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=zO_4OnNRGU9hkkdKmrEA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: 9EdSDWu1xuY3yOJd2zmNfp6F-eI6j-YJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX5xiQCcm9tvVY
 P7wWv6MXj+Zhj1oqdpMkNF4A4PG/msMCP/NxxZBk3pnCJhBTyEEKncbHL6rbN0V49d89B/GN2R9
 KtGkdq3zGhZYl5u8bgEQ4UoZMbe1JO4/DFdsNjncBZFYwMPxoHsv
X-Proofpoint-ORIG-GUID: 9EdSDWu1xuY3yOJd2zmNfp6F-eI6j-YJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfXxxkH4zuQHaam
 82/bVXPE08oqlt4ivryB6eQ+Tpnh/d5DjytUacsKMqE048UHF13u0qwgZNifLsa5ZevDZONioiV
 npdMV0G6TDegl1RyJubn0lB724k47HvpzRQPDoFHPsSNc1BiT8leLJThg5rx2DxuiUN78Pjo3b8
 5HFVoCOoh+u+EzDrDQoOa/yiePr78EgvGMxCmGKY0LMeLjqQmXVq8WQ7ee9JI5cXTyU2fke61Sy
 Icg4Psrz2He7FIVXNjg72M3KbgU0aLHLrKR+4OfUL4E/Y1QVdl07wsNZoKXERIf1652Bf3uil2Q
 iJHTmy538lv/lrDWvygSp/2PJuTNt6c/3jvvLl+YGqcqzgLI1kKmGyu0uwbqtJGrU7tfBsEIH6L
 IhcRR3rmbinQ7dditGQtiFkFY1MrIqZS+eqvUNcj3yK+mMKX3qGVKWQeGQfuMNftvU2M4egdCvV
 yfn3jowq0Aa22vXPmPg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit b3d09d06e052e1d754645acea4e4d1e96f81c934 ]

The mcount_loc section holds the addresses of the functions that get
patched by ftrace when enabling function callbacks. It can contain tens of
thousands of entries. These addresses must be sorted. If they are not
sorted at compile time, they are sorted at boot. Sorting at boot does take
some time and does have a small impact on boot performance.

x86 and arm32 have the addresses in the mcount_loc section of the ELF
file. But for arm64, the section just contains zeros. The .rela.dyn
Elf_Rela section holds the addresses and they get patched at boot during
the relocation phase.

In order to sort these addresses, the Elf_Rela needs to be updated instead
of the location in the binary that holds the mcount_loc section. Have the
sorttable code, allocate an array to hold the functions, load the
addresses from the Elf_Rela entries, sort them, then put them back in
order into the Elf_rela entries so that they will be sorted at boot up
without having to sort them during boot up.

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
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250218200022.373319428@goodmis.org
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 arch/arm64/Kconfig  |   1 +
 scripts/sorttable.c | 185 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 183 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d4ebdc16c..f0a363996 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -212,6 +212,7 @@ config ARM64
 		if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
+	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 9f41575af..4a34c2751 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -28,6 +28,7 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
@@ -79,10 +80,16 @@ typedef union {
 	Elf64_Sym	e64;
 } Elf_Sym;
 
+typedef union {
+	Elf32_Rela	e32;
+	Elf64_Rela	e64;
+} Elf_Rela;
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
 static void (*w)(uint32_t, uint32_t *);
+static void (*w8)(uint64_t, uint64_t *);
 typedef void (*table_sort_t)(char *, int);
 
 static struct elf_funcs {
@@ -102,6 +109,10 @@ static struct elf_funcs {
 	uint32_t (*sym_name)(Elf_Sym *sym);
 	uint64_t (*sym_value)(Elf_Sym *sym);
 	uint16_t (*sym_shndx)(Elf_Sym *sym);
+	uint64_t (*rela_offset)(Elf_Rela *rela);
+	uint64_t (*rela_info)(Elf_Rela *rela);
+	uint64_t (*rela_addend)(Elf_Rela *rela);
+	void (*rela_write_addend)(Elf_Rela *rela, uint64_t val);
 } e;
 
 static uint64_t ehdr64_shoff(Elf_Ehdr *ehdr)
@@ -262,6 +273,38 @@ SYM_ADDR(value)
 SYM_WORD(name)
 SYM_HALF(shndx)
 
+#define __maybe_unused			__attribute__((__unused__))
+
+#define RELA_ADDR(fn_name)					\
+static uint64_t rela64_##fn_name(Elf_Rela *rela)		\
+{								\
+	return r8((uint64_t *)&rela->e64.r_##fn_name);		\
+}								\
+								\
+static uint64_t rela32_##fn_name(Elf_Rela *rela)		\
+{								\
+	return r((uint32_t *)&rela->e32.r_##fn_name);		\
+}								\
+								\
+static uint64_t __maybe_unused rela_##fn_name(Elf_Rela *rela)	\
+{								\
+	return e.rela_##fn_name(rela);				\
+}
+
+RELA_ADDR(offset)
+RELA_ADDR(info)
+RELA_ADDR(addend)
+
+static void rela64_write_addend(Elf_Rela *rela, uint64_t val)
+{
+	w8(val, (uint64_t *)&rela->e64.r_addend);
+}
+
+static void rela32_write_addend(Elf_Rela *rela, uint64_t val)
+{
+	w(val, (uint32_t *)&rela->e32.r_addend);
+}
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
@@ -341,6 +384,16 @@ static void wle(uint32_t val, uint32_t *x)
 	put_unaligned_le32(val, x);
 }
 
+static void w8be(uint64_t val, uint64_t *x)
+{
+	put_unaligned_be64(val, x);
+}
+
+static void w8le(uint64_t val, uint64_t *x)
+{
+	put_unaligned_le64(val, x);
+}
+
 /*
  * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
  * the way to -256..-1, to avoid conflicting with real section
@@ -398,13 +451,12 @@ static inline void *get_index(void *start, int entsize, int index)
 static int extable_ent_size;
 static int long_size;
 
+#define ERRSTR_MAXSZ	256
 
 #ifdef UNWINDER_ORC_ENABLED
 /* ORC unwinder only support X86_64 */
 #include <asm/orc_types.h>
 
-#define ERRSTR_MAXSZ	256
-
 static char g_err[ERRSTR_MAXSZ];
 static int *g_orc_ip_table;
 static struct orc_entry *g_orc_table;
@@ -499,7 +551,19 @@ static void *sort_orctable(void *arg)
 #endif
 
 #ifdef MCOUNT_SORT_ENABLED
+
+/* Only used for sorting mcount table */
+static void rela_write_addend(Elf_Rela *rela, uint64_t val)
+{
+	e.rela_write_addend(rela, val);
+}
+
 static pthread_t mcount_sort_thread;
+static bool sort_reloc;
+
+static long rela_type;
+
+static char m_err[ERRSTR_MAXSZ];
 
 struct elf_mcount_loc {
 	Elf_Ehdr *ehdr;
@@ -508,6 +572,103 @@ struct elf_mcount_loc {
 	uint64_t stop_mcount_loc;
 };
 
+/* Sort the relocations not the address itself */
+static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
+{
+	Elf_Shdr *shdr_start;
+	Elf_Rela *rel;
+	unsigned int shnum;
+	unsigned int count;
+	int shentsize;
+	void *vals;
+	void *ptr;
+
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
+
+	vals = malloc(long_size * size);
+	if (!vals) {
+		snprintf(m_err, ERRSTR_MAXSZ, "Failed to allocate sort array");
+		pthread_exit(m_err);
+		return NULL;
+	}
+
+	ptr = vals;
+
+	shnum = ehdr_shnum(ehdr);
+	if (shnum == SHN_UNDEF)
+		shnum = shdr_size(shdr_start);
+
+	for (int i = 0; i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
+		void *end;
+
+		if (shdr_type(shdr) != SHT_RELA)
+			continue;
+
+		rel = (void *)ehdr + shdr_offset(shdr);
+		end = (void *)rel + shdr_size(shdr);
+
+		for (; (void *)rel < end; rel = (void *)rel + shdr_entsize(shdr)) {
+			uint64_t offset = rela_offset(rel);
+
+			if (offset >= start_loc && offset < start_loc + size) {
+				if (ptr + long_size > vals + size) {
+					free(vals);
+					snprintf(m_err, ERRSTR_MAXSZ,
+						 "Too many relocations");
+					pthread_exit(m_err);
+					return NULL;
+				}
+
+				/* Make sure this has the correct type */
+				if (rela_info(rel) != rela_type) {
+					free(vals);
+					snprintf(m_err, ERRSTR_MAXSZ,
+						"rela has type %lx but expected %lx\n",
+						(long)rela_info(rel), rela_type);
+					pthread_exit(m_err);
+					return NULL;
+				}
+
+				if (long_size == 4)
+					*(uint32_t *)ptr = rela_addend(rel);
+				else
+					*(uint64_t *)ptr = rela_addend(rel);
+				ptr += long_size;
+			}
+		}
+	}
+	count = ptr - vals;
+	qsort(vals, count / long_size, long_size, compare_extable);
+
+	ptr = vals;
+	for (int i = 0; i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
+		void *end;
+
+		if (shdr_type(shdr) != SHT_RELA)
+			continue;
+
+		rel = (void *)ehdr + shdr_offset(shdr);
+		end = (void *)rel + shdr_size(shdr);
+
+		for (; (void *)rel < end; rel = (void *)rel + shdr_entsize(shdr)) {
+			uint64_t offset = rela_offset(rel);
+
+			if (offset >= start_loc && offset < start_loc + size) {
+				if (long_size == 4)
+					rela_write_addend(rel, *(uint32_t *)ptr);
+				else
+					rela_write_addend(rel, *(uint64_t *)ptr);
+				ptr += long_size;
+			}
+		}
+	}
+	free(vals);
+	return NULL;
+}
+
 /* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
 static void *sort_mcount_loc(void *arg)
 {
@@ -517,6 +678,9 @@ static void *sort_mcount_loc(void *arg)
 	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 
+	if (sort_reloc)
+		return sort_relocs(emloc->ehdr, emloc->start_mcount_loc, count);
+
 	qsort(start_loc, count/long_size, long_size, compare_extable);
 	return NULL;
 }
@@ -866,12 +1030,14 @@ static int do_file(char const *const fname, void *addr)
 		r2	= r2le;
 		r8	= r8le;
 		w	= wle;
+		w8	= w8le;
 		break;
 	case ELFDATA2MSB:
 		r	= rbe;
 		r2	= r2be;
 		r8	= r8be;
 		w	= wbe;
+		w8	= w8be;
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
@@ -887,8 +1053,13 @@ static int do_file(char const *const fname, void *addr)
 	}
 
 	switch (r2(&ehdr->e32.e_machine)) {
-	case EM_386:
 	case EM_AARCH64:
+#ifdef MCOUNT_SORT_ENABLED
+		sort_reloc = true;
+		rela_type = 0x403;
+#endif
+		/* fallthrough */
+	case EM_386:
 	case EM_LOONGARCH:
 	case EM_RISCV:
 	case EM_S390:
@@ -932,6 +1103,10 @@ static int do_file(char const *const fname, void *addr)
 			.sym_name		= sym32_name,
 			.sym_value		= sym32_value,
 			.sym_shndx		= sym32_shndx,
+			.rela_offset		= rela32_offset,
+			.rela_info		= rela32_info,
+			.rela_addend		= rela32_addend,
+			.rela_write_addend	= rela32_write_addend,
 		};
 
 		e = efuncs;
@@ -965,6 +1140,10 @@ static int do_file(char const *const fname, void *addr)
 			.sym_name		= sym64_name,
 			.sym_value		= sym64_value,
 			.sym_shndx		= sym64_shndx,
+			.rela_offset		= rela64_offset,
+			.rela_info		= rela64_info,
+			.rela_addend		= rela64_addend,
+			.rela_write_addend	= rela64_write_addend,
 		};
 
 		e = efuncs;
-- 
2.34.1

