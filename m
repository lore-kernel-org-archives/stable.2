Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE428C037
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813771; cv=none; b=gQo6hgJ3uRhVkv7CImT75wJ0UhbZnFFFpaxcirZkn/srp7koam21OvMRBQTXgm5KCZB+OXtBSjW+AqtO7OhYu65eCmnDRLV/ZcFC/ZPVqDcgCNF2CiFZkHWqO4aQ8/3a+buunH1t42QFtRlvhhQREjKNKANg6eGPmi9t13sjaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813771; c=relaxed/simple;
	bh=tYH++70qcyqhoLLUau+i8peKOboAvibeyJCodxSPh2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfCTQFIlMao5GllfDj2LaYn2J+RcgkI1oQ6SFv0PiGkK6HVL6mlPX5KyzjC0r+xlRZZUXW59SMd1yAZn5H8DQIJNQ5IvYJiKEXrguX3EfqrAOr1TQgj9JtjtitmEDFE3da8ChO2aTZLI6XzwL1++fN9EwcK6mRkESdZRdat6fy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=VMUK6TVT; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="VMUK6TVT"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIscBo3987654;
	Thu, 18 Jun 2026 20:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=8uskbgdyTG8OI8p+JKIlnqPfN0N3sPtp/vMJUzwDulU=; b=VMUK
	6TVTao8S4T9GJGz02XjlpQe1Qgde4V9+3h6xJ8kbgAwfhi/3R0+3bm3eAGVGDE7M
	5DRfedZMsfWSDyGS8EgNgEFxqCBN3xCyBsCgoCX/DuOVWykYOnVbKqy5/Bb9+Iph
	P3bXK6DiEp1y7i9ToKpwzX+1ZcPkdCjU8eeqfDzucutnmY7xH9vGLOiowuYt7XNz
	y2hQxUw8gUNtCxUDexAhJyRU2GJ87xsZbfbqDbrFSU6IDeibXmJPv+aYZszQkoPG
	FdiVMWnjeGTEl81o88LlsdRpDA/Z5GEmfwtxSbX4ttMoIUYQkDjSAWqxiTlwkR0H
	GGNfyRe5IWhhjd+waw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev4w5uyue-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:04 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:03 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 14/27] scripts/sorttable: Get start/stop_mcount_loc from ELF file directly
Date: Thu, 18 Jun 2026 16:15:28 -0400
Message-ID: <1f651dfe741838b94ed8088cc3429b65768893ea.1781809952.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX6hB232LeUsdw
 xnCQza+idbIJnbnBCfgcIWDIbd140Quo4Sa0wZHAXHR390GTHb4wj0Ih9R/6ScpNoVAjk9Tvrt7
 +NkP89MWihTr8HEhfRdlE7J8VVllTA+vkvV9oXgGFEefq4aRq9V2OP8X7HViQguaSvGxHY2y3A+
 C9bP50tady+fXuEQwjGYNRzo7C/SGWl9k/wP2EwHLiICKfsktQleldlqHlYOGXAlu1ZUKSaLzcW
 00aXd3m5AuL/GMfRz9LJJ5pD+eH4TL+M19mi1oiWc2N9oWi9iVp/h+3ZM6JMqVWeloxVIlzoy4C
 DWw1iC7e5Wjp4pKp0+Qye6m8PWq6eUz35a1AOx9v3VkrmWHBBWUFxjzHsy9ORYbLK4kZMBpx0lO
 1foN/JwcZSgr/gFk5hbK5bUgn0q4iu3Qzd94RAU0qYcgHnHEGLhDWAIJUpx5JhDvkrQAZIxHZfW
 aUsdtbOBJXLgByvqm5A==
X-Authority-Analysis: v=2.4 cv=JtDBas4C c=1 sm=1 tr=0 ts=6a345204 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=ciD_ITnBGLx9hDmgngwA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: JvGlpd4oTN8i6wLFPM1AjsKiaM5MyFCL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX8pDqxL3ssCBy
 yEw1Xjl57rwa4pJGQOPALGfREXWgHAk0hX/apb8oUxOuylmaxSzq7z5pHJCxs0z3GnBtvieoFg9
 olsOwoA/iKB2tah/FNnMTK6QG2Nkk6DE5SDXRif0JyzzjLFZV8Lr
X-Proofpoint-GUID: JvGlpd4oTN8i6wLFPM1AjsKiaM5MyFCL
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 4acda8edefa1ce66d3de845f1c12745721cd14c3 ]

The get_mcount_loc() does a cheesy trick to find the start_mcount_loc and
stop_mcount_loc values. That trick is:

 file_start = popen(" grep start_mcount System.map | awk '{print $1}' ", "r");

and

 file_stop = popen(" grep stop_mcount System.map | awk '{print $1}' ", "r");

Those values are stored in the Elf symbol table. Use that to capture those
values. Using the symbol table is more efficient and more robust. The
above could fail if another variable had "start_mcount" or "stop_mcount"
as part of its name.

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
Link: https://lore.kernel.org/20250105162346.817157047@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 95 +++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 50 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index ff9b60fc0..656c1e9b5 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -472,42 +472,41 @@ static void *sort_mcount_loc(void *arg)
 }
 
 /* Get the address of __start_mcount_loc and __stop_mcount_loc in System.map */
-static void get_mcount_loc(uint64_t *_start, uint64_t *_stop)
+static void get_mcount_loc(struct elf_mcount_loc *emloc, Elf_Shdr *symtab_sec,
+			   const char *strtab)
 {
-	FILE *file_start, *file_stop;
-	char start_buff[20];
-	char stop_buff[20];
-	int len = 0;
+	Elf_Sym *sym, *end_sym;
+	int symentsize = shdr_entsize(symtab_sec);
+	int found = 0;
+
+	sym = (void *)emloc->ehdr + shdr_offset(symtab_sec);
+	end_sym = (void *)sym + shdr_size(symtab_sec);
+
+	while (sym < end_sym) {
+		if (!strcmp(strtab + sym_name(sym), "__start_mcount_loc")) {
+			emloc->start_mcount_loc = sym_value(sym);
+			if (++found == 2)
+				break;
+		} else if (!strcmp(strtab + sym_name(sym), "__stop_mcount_loc")) {
+			emloc->stop_mcount_loc = sym_value(sym);
+			if (++found == 2)
+				break;
+		}
+		sym = (void *)sym + symentsize;
+	}
 
-	file_start = popen(" grep start_mcount System.map | awk '{print $1}' ", "r");
-	if (!file_start) {
+	if (!emloc->start_mcount_loc) {
 		fprintf(stderr, "get start_mcount_loc error!");
 		return;
 	}
 
-	file_stop = popen(" grep stop_mcount System.map | awk '{print $1}' ", "r");
-	if (!file_stop) {
+	if (!emloc->stop_mcount_loc) {
 		fprintf(stderr, "get stop_mcount_loc error!");
-		pclose(file_start);
 		return;
 	}
-
-	while (fgets(start_buff, sizeof(start_buff), file_start) != NULL) {
-		len = strlen(start_buff);
-		start_buff[len - 1] = '\0';
-	}
-	*_start = strtoul(start_buff, NULL, 16);
-
-	while (fgets(stop_buff, sizeof(stop_buff), file_stop) != NULL) {
-		len = strlen(stop_buff);
-		stop_buff[len - 1] = '\0';
-	}
-	*_stop = strtoul(stop_buff, NULL, 16);
-
-	pclose(file_start);
-	pclose(file_stop);
 }
 #endif
+
 static int do_sort(Elf_Ehdr *ehdr,
 		   char const *const fname,
 		   table_sort_t custom_sort)
@@ -538,8 +537,6 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int shstrndx;
 #ifdef MCOUNT_SORT_ENABLED
 	struct elf_mcount_loc mstruct = {0};
-	uint64_t _start_mcount_loc = 0;
-	uint64_t _stop_mcount_loc = 0;
 #endif
 #ifdef UNWINDER_ORC_ENABLED
 	unsigned int orc_ip_size = 0;
@@ -577,13 +574,8 @@ static int do_sort(Elf_Ehdr *ehdr,
 
 #ifdef MCOUNT_SORT_ENABLED
 		/* locate the .init.data section in vmlinux */
-		if (!strcmp(secstrings + idx, ".init.data")) {
-			get_mcount_loc(&_start_mcount_loc, &_stop_mcount_loc);
-			mstruct.ehdr = ehdr;
+		if (!strcmp(secstrings + idx, ".init.data"))
 			mstruct.init_data_sec = shdr;
-			mstruct.start_mcount_loc = _start_mcount_loc;
-			mstruct.stop_mcount_loc = _stop_mcount_loc;
-		}
 #endif
 
 #ifdef UNWINDER_ORC_ENABLED
@@ -627,23 +619,6 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 #endif
-
-#ifdef MCOUNT_SORT_ENABLED
-	if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
-		fprintf(stderr,
-			"incomplete mcount's sort in file: %s\n",
-			fname);
-		goto out;
-	}
-
-	/* create thread to sort mcount_loc concurrently */
-	if (pthread_create(&mcount_sort_thread, NULL, &sort_mcount_loc, &mstruct)) {
-		fprintf(stderr,
-			"pthread_create mcount_sort_thread failed '%s': %s\n",
-			strerror(errno), fname);
-		goto out;
-	}
-#endif
 	if (!extab_sec) {
 		fprintf(stderr,	"no __ex_table in file: %s\n", fname);
 		goto out;
@@ -663,6 +638,26 @@ static int do_sort(Elf_Ehdr *ehdr,
 	strtab = (const char *)ehdr + shdr_offset(strtab_sec);
 	symtab = (const Elf_Sym *)((const char *)ehdr + shdr_offset(symtab_sec));
 
+#ifdef MCOUNT_SORT_ENABLED
+	mstruct.ehdr = ehdr;
+	get_mcount_loc(&mstruct, symtab_sec, strtab);
+
+	if (!mstruct.init_data_sec || !mstruct.start_mcount_loc || !mstruct.stop_mcount_loc) {
+		fprintf(stderr,
+			"incomplete mcount's sort in file: %s\n",
+			fname);
+		goto out;
+	}
+
+	/* create thread to sort mcount_loc concurrently */
+	if (pthread_create(&mcount_sort_thread, NULL, &sort_mcount_loc, &mstruct)) {
+		fprintf(stderr,
+			"pthread_create mcount_sort_thread failed '%s': %s\n",
+			strerror(errno), fname);
+		goto out;
+	}
+#endif
+
 	if (custom_sort) {
 		custom_sort(extab_image, shdr_size(extab_sec));
 	} else {
-- 
2.34.1

