Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76C34C9AD
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815165; cv=none; b=qGGrB5PPWhOrBAoPWUlDSMzDi4Pgk8VzfltYDHMS3C+p4gKpQgp/qs3Ck5I2KLn0akBSZjZqnt+ApyhzL+uo94KWQK1ysc0pnZnTvUDv02Ph9SAxj90Dcd030kkUr5jaVE2Kgg0frly2Nb3hwLLq5W8xb+ABWz/JZGtpDAehJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815165; c=relaxed/simple;
	bh=axVc0jiqPckFMngZPsBmf8aL3i3YMCuPFnS3E6nVoic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLY7yNziuBzKRzQboDcdFnAZFIEmyhmlFu6oJeeT3TnZGi9IH/gGALCA5z7ATP/b+5jZGEouHtwOGlcXI9WclOlUTclaYJXIt5hsiGp+DeXDaQqbJsO1rlnhDZnb2MWFr3PR7XA05qYHNwZ2SNHDCr3wS2+3HuwIAr533yHkybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=eULqt9eq; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="eULqt9eq"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIss913951797;
	Thu, 18 Jun 2026 20:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ZgJP9c6BrC3AQUFRXiYdUgUz1C/PU9FhlLYQ8GMDs4k=; b=eULq
	t9eqQW07UlpfW9DGo4W1XIajQWwfArzWoudp1zisntQamW4g4iHgpIdVxv3bP+xx
	bnTmy7GuenD/PNQpV/qY3vgjFIj1WFbS2BGNzES0aVaSyEEdcwD7fF3HJK1FOjJp
	AVMtRurJY9OR7Z91IISaxEOe1cFrzec7whA+NcMOPDra2yRp7zNpT6+onFKwj6Sl
	aQre0drw3d2Em1X1TExLtYvhp/hBTioKX6Gj+xMkJZQXD5R/GDFqnuucQ2DGc3bZ
	qIIC9yeXOKoC1AbWqStGobxfrVvxYt1ElMFJEhPb+qzF2RYP1AVEu2GVpe+AKjBT
	/lRF8A8YOG2Fwpl8bw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4evd10atyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:19 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:17 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 08/27] scripts/sorttable: Convert Elf_Sym MACRO over to a union
Date: Thu, 18 Jun 2026 16:38:46 -0400
Message-ID: <022a39638970364f156f71d69a7d77d8557fcd11.1781814109.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX/SV9PJE+Lbno
 dH4fu+6AkLk9Cwes62PO8Y90AFpsZzytYmosF0P5FbbDukwRaO6nb8TMLRwhgAd9O8I9hxyuzbA
 T8Mxvfs+L3RQtLL1vLh3IkROTzPkNojNyX0SZeSJLfxn40YktNDdwzbbtHxVXWd5CQtyrrxYkMN
 R8SW6jkEKyQZTwVtWQI11NSL5sUTGVF76wwFWrPcbpR9Bz1H1vzHltvXdU9btnSvlhkjfkSiM8D
 EjFqwnqXc97xD5rViR3VHneAT2dgWIIKqBjksTykHjziO04Gtbqs9plkZ1HtcBAZFGhRhEtA6MK
 IB54RYJEuJWyyEZhZKFbBaXSov6gOS2Nr9TrmMZNEUznaevojkaKe6YxJWgtE9l9Ny5SHjXGupP
 iD4P0vpNeofa5kLcPk5qi3VuDl5cX/yAK4wUWJ+RXcJ7wFEPfBIi58FnLxu89Ez4qH8UHIsI73Q
 JuIhohFLnDCoJiisqvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfXyEpnVgjl1EXx
 0cv6RWcfPlyB0u0cv4aZoH1kSKPNFwqSB7LkPoCfm8Pa1zv/G+xJH22AH7+lqfXXHdMQYfDxWkj
 gaacJZWy9+c0Ler1PcTQnhimuXvkbZTFKyBQydQpH/enDOIuDgl6
X-Proofpoint-ORIG-GUID: _KngMc_Wmf_9z2Ed4_DZIXa7Arxz2F7l
X-Proofpoint-GUID: _KngMc_Wmf_9z2Ed4_DZIXa7Arxz2F7l
X-Authority-Analysis: v=2.4 cv=L7UtheT8 c=1 sm=1 tr=0 ts=6a345777 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=d3ijJvobaJ5IDOUjZe0A:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 200d015e73b4da69bcd8212a7c58695452b12bad ]

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions for both, replace the Elf_Sym macro with a
union that defines both Elf64_Sym and Elf32_Sym, with field e64 for the
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
Link: https://lore.kernel.org/20250105162345.528626969@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c |  5 +++++
 scripts/sorttable.h | 25 ++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 94497b8ab..57792cf2a 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -74,6 +74,11 @@ typedef union {
 	Elf64_Shdr	e64;
 } Elf_Shdr;
 
+typedef union {
+	Elf32_Sym	e32;
+	Elf64_Sym	e64;
+} Elf_Sym;
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 3daf37bb6..cd4429c8a 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,7 +23,6 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef Elf_Sym
 #undef ELF_ST_TYPE
 #undef uint_t
 #undef _r
@@ -36,7 +35,6 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define Elf_Sym		Elf64_Sym
 # define ELF_ST_TYPE		ELF64_ST_TYPE
 # define uint_t			uint64_t
 # define _r			r8
@@ -48,7 +46,6 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define Elf_Sym		Elf32_Sym
 # define ELF_ST_TYPE		ELF32_ST_TYPE
 # define uint_t			uint32_t
 # define _r			r
@@ -230,10 +227,13 @@ static int do_sort(Elf_Ehdr *ehdr,
 	Elf_Sym *sort_needed_sym = NULL;
 	Elf_Shdr *sort_needed_sec;
 	uint32_t *sort_needed_loc;
+	void *sym_start;
+	void *sym_end;
 	const char *secstrings;
 	const char *strtab;
 	char *extab_image;
 	int sort_need_index;
+	int symentsize;
 	int shentsize;
 	int idx;
 	int i;
@@ -376,12 +376,15 @@ static int do_sort(Elf_Ehdr *ehdr,
 	}
 
 	/* find the flag main_extable_sort_needed */
-	for (sym = (void *)ehdr + _r(&symtab_sec->etype.sh_offset);
-	     sym < sym + _r(&symtab_sec->etype.sh_size) / sizeof(Elf_Sym);
-	     sym++) {
-		if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
+	sym_start = (void *)ehdr + _r(&symtab_sec->etype.sh_offset);
+	sym_end = sym_start + _r(&symtab_sec->etype.sh_size);
+	symentsize = _r(&symtab_sec->etype.sh_entsize);
+
+	for (sym = sym_start; (void *)sym + symentsize < sym_end;
+	     sym = (void *)sym + symentsize) {
+		if (ELF_ST_TYPE(sym->etype.st_info) != STT_OBJECT)
 			continue;
-		if (!strcmp(strtab + r(&sym->st_name),
+		if (!strcmp(strtab + r(&sym->etype.st_name),
 			    "main_extable_sort_needed")) {
 			sort_needed_sym = sym;
 			break;
@@ -395,13 +398,13 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 
-	sort_need_index = get_secindex(r2(&sym->st_shndx),
-				       sort_needed_sym - symtab,
+	sort_need_index = get_secindex(r2(&sym->etype.st_shndx),
+				       ((void *)sort_needed_sym - (void *)symtab) / symentsize,
 				       symtab_shndx);
 	sort_needed_sec = get_index(shdr_start, shentsize, sort_need_index);
 	sort_needed_loc = (void *)ehdr +
 		_r(&sort_needed_sec->etype.sh_offset) +
-		_r(&sort_needed_sym->st_value) -
+		_r(&sort_needed_sym->etype.st_value) -
 		_r(&sort_needed_sec->etype.sh_addr);
 
 	/* extable has been sorted, clear the flag */
-- 
2.34.1

