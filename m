Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCDD34E745
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815169; cv=none; b=oDW1Yb7F66aLDepgPy3ESlwrJ5V0qPAM2t9ZSM/WpT8zwBW0/MYU/bmoCUhR1uZebCN+KS0veP8ZBDiRH5Yt9o0PcfsldJlN7TDP8lMTKZBXTVeJrENuQZtIGU4fx/q4AKlKzST0s7q6htAIEIVfqZkqPW3vFXokTTvjVmE11KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815169; c=relaxed/simple;
	bh=sE4cQo5swnqtN38My9Vqbzx0dNIJxkvyN2Ke7MNpXz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3emQoqNL8pPra+YThK5lkq8gAKa86OaPjNBrQXpivCdrpMq8F2YdV7t6fDuvJPiWP+UVFcZOP8iyFLj+DQeZo9zUyTF/WVg9BBWZa1UlzTfv6q3h3DsHOQmi+xOmn6B9SOKWbJus0eTDqT9OM8LfkFKXG2EjQ1FSgVZ1hH50Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=GldwoVBe; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="GldwoVBe"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsrQH3988528;
	Thu, 18 Jun 2026 20:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=DKZimCIAa93jdHcwVHm7t60HP6d6GjOyd6y92L0IfSw=; b=Gldw
	oVBe6AFGWZbKpRlyE/KMQ8Ew5LcPbuvJ28JWIGVblzalzNtSi5aV/On45ADpphnt
	8H7HQWr1c4C409VRpMIxE/6Lk6VGQts4/adky1iGBWBb+PZT8r5YtLeoftfcY7Vo
	sTVD44WG5U2dQHDWittVOy+gQhUD1R+J7rmQlXrOeIpOLUZRfJa9hYBcox/hBmjc
	x4A2xtgAY4AafwR5X2E0W0p0B0pyU7OHkuSZ3m5eHJYf7/PxFrCzTZ9q2q5AjIfy
	8lCTLwPShvhCHWjnhYNZ8ZgDtJU09hX4KPuEvwQUnZh0FikFvtiVUen9jftGAgdi
	uosMA3ForkC+Y/yI5A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev4w5v34f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:22 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:20 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 11/27] scripts/sorttable: Add helper functions for Elf_Sym
Date: Thu, 18 Jun 2026 16:38:49 -0400
Message-ID: <c479484bbac0e188200565bcaeb84d4bf9deff69.1781814120.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfXzJmQjh/Tgp6Y
 EqdoPiTaH7mJ195pqBm9AwB9pnq2koaT1/HbWwT6ZrJfl27JmrPEYSmlSBuInznsuhA+pPvu0TU
 Hrxq0tIG6pdpRKjxR8xgwmVaJqIItP4vNUQxGXRWYpTamdcYPQX4tsFn71sjreUfi+Ip7c2glKr
 XCZ5NhQRwQhVXZ8u6mViT2YLhzRBvhxlmExQvnEECiWjTDkkh3IEWJJOMP6GaiV2mFv89vTWEJ+
 AOayx/vVJdfsfCwZwXOh3xOPm16Y6Tr4VfEB4ZbtPbt5kzX4awXWz15ZwbpBFfAwrIm/TWyVuZ3
 VpWP6KMy8NojKyP6AUS+DuCZkgU8MNYGHm4wS4QiNvAvVQMP93RhS+cvNrKjsBkePrkJbX5udaM
 dcG370JzPNUQjgOWnE6ufeBxmSnGfzDZw40TZLSjNutSzn9TNnp9Xd6bJrSL0hM45G9NTpbqPmY
 VkxYgLTeUJRIPmIECBQ==
X-Authority-Analysis: v=2.4 cv=JtDBas4C c=1 sm=1 tr=0 ts=6a34577a cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=9_3gDxrwwGRkqDZ_ojQA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: SYvmK0OI41prJgepPYiKI9XzQf4Rzp5g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfXzeTW4fcMzQOK
 +traHLPT40PaDzS8xq9Lq3jWQ1x9r730DLcTq29ZvsmuaCqtA80Nwv/yYfN2tFJrBPps8fhZRgS
 wBKS7hyCDbdudHNLDgJpBfTQDHrrFjQygODcE99vnUiCWEtXxGAn
X-Proofpoint-GUID: SYvmK0OI41prJgepPYiKI9XzQf4Rzp5g
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 17bed33ac12f011f4695059960e1b1d6457229a7 ]

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions, add helper functions for Elf_Sym.  This
will create a function pointer for each helper that will get assigned to
the appropriate function to handle either the 64bit or 32bit version.

This also removes the last references of etype and _r() macros from the
sorttable.h file as their references are now just defined in the
appropriate architecture version of the helper functions. All read
functions now exist in the helper functions which makes it easier to
maintain, as the helper functions define the necessary architecture sizes.

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
Link: https://lore.kernel.org/20250105162346.185740651@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 scripts/sorttable.h | 30 +++++++++++++++--------------
 2 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index b2b96ff26..20615de18 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -152,6 +152,53 @@ SHDR_WORD(link)
 SHDR_WORD(name)
 SHDR_WORD(type)
 
+#define SYM_ADDR(fn_name)			\
+static uint64_t sym64_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r8(&sym->e64.st_##fn_name);	\
+}						\
+						\
+static uint64_t sym32_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r(&sym->e32.st_##fn_name);	\
+}
+
+#define SYM_WORD(fn_name)			\
+static uint32_t sym64_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r(&sym->e64.st_##fn_name);	\
+}						\
+						\
+static uint32_t sym32_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r(&sym->e32.st_##fn_name);	\
+}
+
+#define SYM_HALF(fn_name)			\
+static uint16_t sym64_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r2(&sym->e64.st_##fn_name);	\
+}						\
+						\
+static uint16_t sym32_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r2(&sym->e32.st_##fn_name);	\
+}
+
+static uint8_t sym64_type(Elf_Sym *sym)
+{
+	return ELF64_ST_TYPE(sym->e64.st_info);
+}
+
+static uint8_t sym32_type(Elf_Sym *sym)
+{
+	return ELF32_ST_TYPE(sym->e32.st_info);
+}
+
+SYM_ADDR(value)
+SYM_WORD(name)
+SYM_HALF(shndx)
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index af3a5f020..ef7e5161d 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,10 +23,7 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef ELF_ST_TYPE
 #undef uint_t
-#undef _r
-#undef etype
 #undef ehdr_shoff
 #undef ehdr_shentsize
 #undef ehdr_shstrndx
@@ -38,6 +35,10 @@
 #undef shdr_name
 #undef shdr_type
 #undef shdr_entsize
+#undef sym_type
+#undef sym_name
+#undef sym_value
+#undef sym_shndx
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -46,10 +47,7 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define ELF_ST_TYPE		ELF64_ST_TYPE
 # define uint_t			uint64_t
-# define _r			r8
-# define etype			e64
 # define ehdr_shoff		ehdr64_shoff
 # define ehdr_shentsize		ehdr64_shentsize
 # define ehdr_shstrndx		ehdr64_shstrndx
@@ -61,6 +59,10 @@
 # define shdr_name		shdr64_name
 # define shdr_type		shdr64_type
 # define shdr_entsize		shdr64_entsize
+# define sym_type		sym64_type
+# define sym_name		sym64_name
+# define sym_value		sym64_value
+# define sym_shndx		sym64_shndx
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -68,10 +70,7 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define ELF_ST_TYPE		ELF32_ST_TYPE
 # define uint_t			uint32_t
-# define _r			r
-# define etype			e32
 # define ehdr_shoff		ehdr32_shoff
 # define ehdr_shentsize		ehdr32_shentsize
 # define ehdr_shstrndx		ehdr32_shstrndx
@@ -83,6 +82,10 @@
 # define shdr_name		shdr32_name
 # define shdr_type		shdr32_type
 # define shdr_entsize		shdr32_entsize
+# define sym_type		sym32_type
+# define sym_name		sym32_name
+# define sym_value		sym32_value
+# define sym_shndx		sym32_shndx
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -414,9 +417,9 @@ static int do_sort(Elf_Ehdr *ehdr,
 
 	for (sym = sym_start; (void *)sym + symentsize < sym_end;
 	     sym = (void *)sym + symentsize) {
-		if (ELF_ST_TYPE(sym->etype.st_info) != STT_OBJECT)
+		if (sym_type(sym) != STT_OBJECT)
 			continue;
-		if (!strcmp(strtab + r(&sym->etype.st_name),
+		if (!strcmp(strtab + sym_name(sym),
 			    "main_extable_sort_needed")) {
 			sort_needed_sym = sym;
 			break;
@@ -430,14 +433,13 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 
-	sort_need_index = get_secindex(r2(&sym->etype.st_shndx),
+	sort_need_index = get_secindex(sym_shndx(sym),
 				       ((void *)sort_needed_sym - (void *)symtab) / symentsize,
 				       symtab_shndx);
 	sort_needed_sec = get_index(shdr_start, shentsize, sort_need_index);
 	sort_needed_loc = (void *)ehdr +
 		shdr_offset(sort_needed_sec) +
-		_r(&sort_needed_sym->etype.st_value) -
-		shdr_addr(sort_needed_sec);
+		sym_value(sort_needed_sym) - shdr_addr(sort_needed_sec);
 
 	/* extable has been sorted, clear the flag */
 	w(0, sort_needed_loc);
-- 
2.34.1

