Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CBA33ADB9
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815271; cv=none; b=tKnScuen0+4ubn3rxX+nYGIN4Za25p1yt5ZjmhIqpu/zzMFawD9iokJIxppdLF3gUKcn+MfF+oosYBYN8HS2CrIrw3aTwxZb5jzZQxRI7NjYj3HHg4LQ3MLZ3U/kwtI+uHjD8wYJAOJS0tjWRV90xPIPzT8v1IPCe6PI4EWwWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815271; c=relaxed/simple;
	bh=AbVVgwnoaqlHfqGr8gaQznbWNiyDPk/UcPonmgfyG8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtFVLm8dM15v3NzuQjky8nV9W4Ld8fJtAChd48qB50Mxa/dkZK7NiJCKk2Jk1zwqzUxJsGFzr9Mjz116UPn/Li7sXReXfuAvpB9hjggfNdJHw0uJ5eBHAbRRkfdJoZ3WEthBcI2JS5VCT+XBQrgR1ICQRgi5GvUvOz73WqX39f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=HdLgDfXO; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="HdLgDfXO"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsc313987653;
	Thu, 18 Jun 2026 20:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=P+rUnVS7i4alaqm6Sddr1Omeo2AG/XLny9qzOYeErNw=; b=HdLg
	DfXOEIIRCu3gcM/i0bmxapRbk1Ivtp/FaTO3tGMy9l2PfSQ7f9u30oSLGbjWkVCu
	4fXLSUD3YoVXSdjIgct7/V2tELXkfS4XMfyEMOweoZW1FByzja1RkkQu2wy8OU3q
	n0DyYpW+SLKtIKXZ/An4blQg07n/NEP2HJKvVjUYcYYM94IcVREFfgeRn/F/7RA+
	KSjr7Rp2bL+fEYYBOHfZTyPRnIoyUfHNE4QUKcQhQ1ZoYwgp9FoKliRpofK9UGv+
	r7Pldx7m2fs158gqMfFuOulPIM/+UcRsTl+NLwUco/55kbGHp8lvHuNNqk4C4OA8
	NkDarp0uOKTcUX1dXA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev4w5uysr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:15:50 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:15:48 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 03/27] scripts/sorttable: Remove unneeded Elf_Rel
Date: Thu, 18 Jun 2026 16:15:17 -0400
Message-ID: <984bf8d32a9080de6819dede14055b154f6d619d.1781809917.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfXzhDJs15/531J
 FjqizBN80m7O7zFxLF414UXrStmfMoXSPSZMA44zgmFjI5JJ4tvjZ01ONHTwBgXcunJ7pEdXysN
 ZLInCkcmjnmN+TNrH/vl/gBe9ro8TRoiixvA7KqQcPYuxku69hjnym6gctv7m0uhGOGitIyTaAf
 bIhvz+oB+FZGYMGb1bA69htoq8AMG5kS5mDI/PnPRMqUFR7Mzt8lrOPA+eTvorB/Imar4lbRUf7
 t5BtnLOpFeUSo900xHZ7joVau5eQaaPVkFFTEksbkULwCk9VG73SLIPNUyUupbfl9FpbAck2jFB
 qwwmDR/9zUAZg7G1v17kAfQr7UggKY5w0INRgc/KBU0IY8X7pDDFYPQ3KpEX+BQ0HxUhaTXBA94
 dFKv9hbnG+yf7mOEDNlyY1N0USGJZfGLw+B7yrQp0FztZp6N3q/Lr5rWKu//IZuyV86W2Gi2wvt
 rmz1L/rhTvI2dIHX0oA==
X-Authority-Analysis: v=2.4 cv=JtDBas4C c=1 sm=1 tr=0 ts=6a3451f7 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=_YqY1u4RUxZ9fqoOkI0A:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: UNlaXCcIZGfrfnNoVleh5zzYPQ2eBo0u
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX/QMkl4QTyFKo
 79JWFv0AL/obJpM9ZqgNknRUXxXUOzB+MRHdHL6iCKrHVUn6h75WWSc2wdwgIJ1u6A4agIbwuhF
 1mmteXvLl2o8sDIc6QwxRuRfKBGQlr1+xc7BQmR58MwOb9hkT/u2
X-Proofpoint-GUID: UNlaXCcIZGfrfnNoVleh5zzYPQ2eBo0u
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 6f2c2f93a190467cebd6ebd03feb49514fead5ca ]

The code had references to initialize the Elf_Rel relocation tables, but
it was never used. Remove it.

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
Link: https://lore.kernel.org/20250105162344.515342233@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.h | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 14d0c4d84..18d07fdb2 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -26,7 +26,6 @@
 #undef Elf_Addr
 #undef Elf_Ehdr
 #undef Elf_Shdr
-#undef Elf_Rel
 #undef Elf_Sym
 #undef ELF_ST_TYPE
 #undef uint_t
@@ -42,7 +41,6 @@
 # define Elf_Addr		Elf64_Addr
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
-# define Elf_Rel		Elf64_Rel
 # define Elf_Sym		Elf64_Sym
 # define ELF_ST_TYPE		ELF64_ST_TYPE
 # define uint_t			uint64_t
@@ -57,7 +55,6 @@
 # define Elf_Addr		Elf32_Addr
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
-# define Elf_Rel		Elf32_Rel
 # define Elf_Sym		Elf32_Sym
 # define ELF_ST_TYPE		ELF32_ST_TYPE
 # define uint_t			uint32_t
@@ -248,14 +245,10 @@ static int do_sort(Elf_Ehdr *ehdr,
 	Elf32_Word *symtab_shndx = NULL;
 	Elf_Sym *sort_needed_sym = NULL;
 	Elf_Shdr *sort_needed_sec;
-	Elf_Rel *relocs = NULL;
-	int relocs_size = 0;
 	uint32_t *sort_needed_loc;
 	const char *secstrings;
 	const char *strtab;
 	char *extab_image;
-	int extab_index = 0;
-	int i;
 	int idx;
 	unsigned int shnum;
 	unsigned int shstrndx;
@@ -279,23 +272,15 @@ static int do_sort(Elf_Ehdr *ehdr,
 	if (shnum == SHN_UNDEF)
 		shnum = _r(&shdr[0].sh_size);
 
-	for (i = 0, s = shdr; s < shdr + shnum; i++, s++) {
+	for (s = shdr; s < shdr + shnum; s++) {
 		idx = r(&s->sh_name);
-		if (!strcmp(secstrings + idx, "__ex_table")) {
+		if (!strcmp(secstrings + idx, "__ex_table"))
 			extab_sec = s;
-			extab_index = i;
-		}
 		if (!strcmp(secstrings + idx, ".symtab"))
 			symtab_sec = s;
 		if (!strcmp(secstrings + idx, ".strtab"))
 			strtab_sec = s;
 
-		if ((r(&s->sh_type) == SHT_REL ||
-		     r(&s->sh_type) == SHT_RELA) &&
-		    r(&s->sh_info) == extab_index) {
-			relocs = (void *)ehdr + _r(&s->sh_offset);
-			relocs_size = _r(&s->sh_size);
-		}
 		if (r(&s->sh_type) == SHT_SYMTAB_SHNDX)
 			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
 						      _r(&s->sh_offset));
@@ -397,10 +382,6 @@ static int do_sort(Elf_Ehdr *ehdr,
 		      extable_ent_size, compare_extable);
 	}
 
-	/* If there were relocations, we no longer need them. */
-	if (relocs)
-		memset(relocs, 0, relocs_size);
-
 	/* find the flag main_extable_sort_needed */
 	for (sym = (void *)ehdr + _r(&symtab_sec->sh_offset);
 	     sym < sym + _r(&symtab_sec->sh_size) / sizeof(Elf_Sym);
-- 
2.34.1

