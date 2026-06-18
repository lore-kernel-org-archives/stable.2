Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE1279907
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813780; cv=none; b=pjZ/nB2DWfVs9WjT0tbeLZwV/EZshhF6QKT16tVXh1TF2vZzFD0N9ZddaAcLfVT0I27OA+tdJvWiCGE75jKx0xdtCNKW6XNbx+5THMC2u6yck72is3zDs915vtg9FR2y79plLMvPCLf6vqSkuprZUhI4AKjqNNEaqpDqz/l/vR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813780; c=relaxed/simple;
	bh=rWgWHV2P1yJJ+07BZZ4WNYUPVg4uFLq/Z7KKq4+beOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErWiKFL+bS0/rzyZZ/b3mo/CzJQjFIoz8XTTL8YeC/EEg9hj5hAzX0tKrw6esSvlE6dlvS79gzzw/aLlZmLd1oU9b9Kpn5uAHGLkd410lRqB4dw55SEbrFv+UTafPvSPodJVCw687/dkHNeQ2VvnAgeIQq6/5noarFPsV+Gxw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=tQv7YDZv; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="tQv7YDZv"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiCAU4006048;
	Thu, 18 Jun 2026 20:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ab/Dy0Bz3NC6jIImwndvoa2P40Kh4O4B10CkC0fu1K4=; b=tQv7
	YDZvMOv2Zwcc508KwnqZbyerOtQ0bwvV3jBh1zoRp/Uk6r7yXsDRaHqpQ3WeYLd/
	+eGTqMbhXmfrvJLPLikWrTmByhlyNwspLiinIRbpafD7/mhS0BOGb6TOVijCoow2
	TEuCwwn44MhsqdBNmdNEErJWrgWebUwY2Nh3s8esWhpWBHOM7GQ02/0BlB7B1RBk
	6P4AbiS+OJEO4Vd/+/ISKz7h9BfoujGNi3qqp8/QCslbzFO/ZFvv6vjQWlQQYZPe
	wAV7wluaOIc9pEw7kDwPgtAK0hnPPCf/OgTMwT0qSCcx+nG9KJ2TrZzHvrTLGVsq
	E/jlEMdKF72qlNUo3g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3jg4k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:11 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:09 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 19/27] scripts/sorttable: Zero out weak functions in mcount_loc table
Date: Thu, 18 Jun 2026 16:15:33 -0400
Message-ID: <ec4eda957478678f39fc5cfe27a29ab345e1bb51.1781809966.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX/s/vsVbKWsd3
 ekv9lZrNYQOrCoi0UfX/bb2pRLKc2dmpx32ukalUQxyByFjuGmRnNfDsQ4M9o5swDmW8FqgeQmJ
 Dp7GBBOgOkFC5QT9A5maYSpCSduuHSju5AEbrFhGlpAROplcXy1V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX1U3shv61yEFF
 9pGmagwOem7TQe8SW9GRR5Ce8zcn8zbWqzHAWuMYzd6y9F42108Nym+sSTCv8chi9BtuHsfs/6D
 y5UIk8hVf+d0lXMuICzw+zdCxBCTyDq8iq6JuthVGk55KGFh26AhU8EZWCkCqLbRtfRahlQMS6t
 zmLaOPgkzNxp4+A0ZEpi8V7+eU3kFRqkNNukPTQyHXtK8W81I1EZ/02wHm6cZR/8B+Ct9onKVpy
 SZGrAVODItB2o2kqhehxuUmekxhCdAy6T0EYkhruMd+E77H7qbv+NUygG7RPt7R+Y6XQOyUYS6a
 ecIQxFZNDgXMC0t1n1Jdj4MR0FCQETkPns7UjPLzQfZsUUargv+AicPHxn8vtmESGhI7LgLjlfG
 kdJWu7Qv7LX2o2VgZEg2rPPzCFv2VYz/q6iJvQsP5BTE9aDGGHkFFQsXxfoyZCgLmojNiGcIptg
 e76fFvovB8y6UrjPJ5A==
X-Proofpoint-ORIG-GUID: kZAvTI3kkmq8mVilnJ8_sJtK-w8AxOt_
X-Proofpoint-GUID: kZAvTI3kkmq8mVilnJ8_sJtK-w8AxOt_
X-Authority-Analysis: v=2.4 cv=AvLeGu9P c=1 sm=1 tr=0 ts=6a34520b cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=vVLE5V-PJzaAi0G2y4QA:9
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

[ Upstream commit ef378c3b8233855497a414b9d67bf22592c928a4 ]

When a function is annotated as "weak" and is overridden, the code is not
removed. If it is traced, the fentry/mcount location in the weak function
will be referenced by the "__mcount_loc" section. This will then be added
to the available_filter_functions list. Since only the address of the
functions are listed, to find the name to show, a search of kallsyms is
used.

Since kallsyms will return the function by simply finding the function
that the address is after but before the next function, an address of a
weak function will show up as the function before it. This is because
kallsyms does not save names of weak functions. This has caused issues in
the past, as now the traced weak function will be listed in
available_filter_functions with the name of the function before it.

At best, this will cause the previous function's name to be listed twice.
At worse, if the previous function was marked notrace, it will now show up
as a function that can be traced. Note that it only shows up that it can
be traced but will not be if enabled, which causes confusion.

 https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/

The commit b39181f7c6907 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
adding weak function") was a workaround to this by checking the function
address before printing its name. If the address was too far from the
function given by the name then instead of printing the name it would
print: __ftrace_invalid_address___<invalid-offset>

The real issue is that these invalid addresses are listed in the ftrace
table look up which available_filter_functions is derived from. A place
holder must be listed in that file because set_ftrace_filter may take a
series of indexes into that file instead of names to be able to do O(1)
lookups to enable filtering (many tools use this method).

Even if kallsyms saved the size of the function, it does not remove the
need of having these place holders. The real solution is to not add a weak
function into the ftrace table in the first place.

To solve this, the sorttable.c code that sorts the mcount regions during
the build is modified to take a "nm -S vmlinux" input, sort it, and any
function listed in the mcount_loc section that is not within a boundary of
the function list given by nm is considered a weak function and is zeroed
out.

Note, this does not mean they will remain zero when booting as KASLR
will still shift those addresses. To handle this, the entries in the
mcount_loc section will be ignored if they are zero or match the
kaslr_offset() value.

Before:

 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 551

After:

 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 0

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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250218200022.883095980@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/ftrace.c   |   6 +-
 scripts/link-vmlinux.sh |   4 +-
 scripts/sorttable.c     | 128 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c8a6c0bb9..40620e3e7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7048,6 +7048,7 @@ static int ftrace_process_locs(struct module *mod,
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
+	unsigned long kaslr;
 	unsigned long flags = 0; /* Shut up gcc */
 	int ret = -ENOMEM;
 
@@ -7096,6 +7097,9 @@ static int ftrace_process_locs(struct module *mod,
 		ftrace_pages->next = start_pg;
 	}
 
+	/* For zeroed locations that were shifted for core kernel */
+	kaslr = !mod ? kaslr_offset() : 0;
+
 	p = start;
 	pg = start_pg;
 	while (p < end) {
@@ -7107,7 +7111,7 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr) {
+		if (!addr || addr == kaslr) {
 			skipped++;
 			continue;
 		}
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a9b3f34a7..94f794ca1 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -173,12 +173,14 @@ mksysmap()
 
 sorttable()
 {
-	${objtree}/scripts/sorttable ${1}
+	${NM} -S ${1} > .tmp_vmlinux.nm-sort
+	${objtree}/scripts/sorttable -s .tmp_vmlinux.nm-sort ${1}
 }
 
 cleanup()
 {
 	rm -f .btf.*
+	rm -f .tmp_vmlinux.nm-sort
 	rm -f System.map
 	rm -f vmlinux
 	rm -f vmlinux.map
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index ec02a2852..23c7e0e6c 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -580,6 +580,98 @@ static void rela_write_addend(Elf_Rela *rela, uint64_t val)
 	e.rela_write_addend(rela, val);
 }
 
+struct func_info {
+	uint64_t	addr;
+	uint64_t	size;
+};
+
+/* List of functions created by: nm -S vmlinux */
+static struct func_info *function_list;
+static int function_list_size;
+
+/* Allocate functions in 1k blocks */
+#define FUNC_BLK_SIZE	1024
+#define FUNC_BLK_MASK	(FUNC_BLK_SIZE - 1)
+
+static int add_field(uint64_t addr, uint64_t size)
+{
+	struct func_info *fi;
+	int fsize = function_list_size;
+
+	if (!(fsize & FUNC_BLK_MASK)) {
+		fsize += FUNC_BLK_SIZE;
+		fi = realloc(function_list, fsize * sizeof(struct func_info));
+		if (!fi)
+			return -1;
+		function_list = fi;
+	}
+	fi = &function_list[function_list_size++];
+	fi->addr = addr;
+	fi->size = size;
+	return 0;
+}
+
+/* Only return match if the address lies inside the function size */
+static int cmp_func_addr(const void *K, const void *A)
+{
+	uint64_t key = *(const uint64_t *)K;
+	const struct func_info *a = A;
+
+	if (key < a->addr)
+		return -1;
+	return key >= a->addr + a->size;
+}
+
+/* Find the function in function list that is bounded by the function size */
+static int find_func(uint64_t key)
+{
+	return bsearch(&key, function_list, function_list_size,
+		       sizeof(struct func_info), cmp_func_addr) != NULL;
+}
+
+static int cmp_funcs(const void *A, const void *B)
+{
+	const struct func_info *a = A;
+	const struct func_info *b = B;
+
+	if (a->addr < b->addr)
+		return -1;
+	return a->addr > b->addr;
+}
+
+static int parse_symbols(const char *fname)
+{
+	FILE *fp;
+	char addr_str[20]; /* Only need 17, but round up to next int size */
+	char size_str[20];
+	char type;
+
+	fp = fopen(fname, "r");
+	if (!fp) {
+		perror(fname);
+		return -1;
+	}
+
+	while (fscanf(fp, "%16s %16s %c %*s\n", addr_str, size_str, &type) == 3) {
+		uint64_t addr;
+		uint64_t size;
+
+		/* Only care about functions */
+		if (type != 't' && type != 'T' && type != 'W')
+			continue;
+
+		addr = strtoull(addr_str, NULL, 16);
+		size = strtoull(size_str, NULL, 16);
+		if (add_field(addr, size) < 0)
+			return -1;
+	}
+	fclose(fp);
+
+	qsort(function_list, function_list_size, sizeof(struct func_info), cmp_funcs);
+
+	return 0;
+}
+
 static pthread_t mcount_sort_thread;
 static bool sort_reloc;
 
@@ -752,6 +844,21 @@ static void *sort_mcount_loc(void *arg)
 		goto out;
 	}
 
+	/* zero out any locations not found by function list */
+	if (function_list_size) {
+		for (void *ptr = vals; ptr < vals + size; ptr += long_size) {
+			uint64_t key;
+
+			key = long_size == 4 ? r((uint32_t *)ptr) : r8((uint64_t *)ptr);
+			if (!find_func(key)) {
+				if (long_size == 4)
+					*(uint32_t *)ptr = 0;
+				else
+					*(uint64_t *)ptr = 0;
+			}
+		}
+	}
+
 	compare_values = long_size == 4 ? compare_values_32 : compare_values_64;
 
 	qsort(vals, count, long_size, compare_values);
@@ -801,6 +908,8 @@ static void get_mcount_loc(struct elf_mcount_loc *emloc, Elf_Shdr *symtab_sec,
 		return;
 	}
 }
+#else /* MCOUNT_SORT_ENABLED */
+static inline int parse_symbols(const char *fname) { return 0; }
 #endif
 
 static int do_sort(Elf_Ehdr *ehdr,
@@ -1256,14 +1365,29 @@ int main(int argc, char *argv[])
 	int i, n_error = 0;  /* gcc-4.3.0 false positive complaint */
 	size_t size = 0;
 	void *addr = NULL;
+	int c;
+
+	while ((c = getopt(argc, argv, "s:")) >= 0) {
+		switch (c) {
+		case 's':
+			if (parse_symbols(optarg) < 0) {
+				fprintf(stderr, "Could not parse %s\n", optarg);
+				return -1;
+			}
+			break;
+		default:
+			fprintf(stderr, "usage: sorttable [-s nm-file] vmlinux...\n");
+			return 0;
+		}
+	}
 
-	if (argc < 2) {
+	if ((argc - optind) < 1) {
 		fprintf(stderr, "usage: sorttable vmlinux...\n");
 		return 0;
 	}
 
 	/* Process each file in turn, allowing deep failure. */
-	for (i = 1; i < argc; i++) {
+	for (i = optind; i < argc; i++) {
 		addr = mmap_file(argv[i], &size);
 		if (!addr) {
 			++n_error;
-- 
2.34.1

