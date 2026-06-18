Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494D2E8B81
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815571; cv=none; b=ltF7Icohe2+rQnMCmbChyAhtGy1ZqMoIEtkf3j9N4/nzvKGnSfBDrJs1KWQ6UOvw1ThHjI/JU1wgyIrxxjS53tNMGATCxCSedICONOZeebAvW4kw2sGFMmB0ysWJI6d8SkEcnnrVtrZdxGW/reV481BjAvmRlw/JO2FAqbNWK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815571; c=relaxed/simple;
	bh=9YRaZPg/RT0KJ/umPJEyKcWwN4z3l4MX9DpuDNQcp0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoLFJcAIaykx8eHUXoWXPPS6HvxhMAgdRk2Yq99roJM2POF1zwRz7u9H7lNrFZTrQXY68rptaJkX7otGw8BxWvUCsaiql4GH91SsLcDgcdv/7DLTjUDocgEooXcTnxrWT6La17pWxUCQJ8IwrjqTzdsbw2kHjf+3WwYBeoNSElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ZOPJ4tjJ; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ZOPJ4tjJ"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsg0w3939577;
	Thu, 18 Jun 2026 20:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=kHynh8esAMosiuI7pTOVvcVMH6dMo7xaRNPvfeVj9Qk=; b=ZOPJ
	4tjJcMSoTAutLd0UrsB8lrNos//50bMMujlUZOZwR52fOGeSP5Dj0oCglSwzy5Sl
	thCnb/LzvVw4jFrrXeTGKc4oip+KnVetRQ+jtdp1ouPKxZFRQOic3DR+6N7aJqCB
	fiYl3hnYoYTyDPy3+JkY5XEPmFnxLMIiQf/4yKYIdY4JKgmaNaLysNLPdIPtGp5A
	CEfbeRHaJsfl8A/CzLJr8PB4l6ksHNuSGe3RirvM7+dvGi6a4bXoiL0Ls2bzjn8/
	9kujdDQ9DSCj9dMPJgosoDCI2Q2kX1/3rhu1ot73nOqY9sU5suJFlkMjamYisyWv
	B0UqkFE4QeCl6W3l7A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev5c6uwxr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:15:57 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:15:56 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 09/27] scripts/sorttable: Add helper functions for Elf_Ehdr
Date: Thu, 18 Jun 2026 16:15:23 -0400
Message-ID: <0cc98e948927e588c76a9a6a8b695ceb74259c1f.1781809936.git.andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=Eez4hvmC c=1 sm=1 tr=0 ts=6a3451fd cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=9MykWdAsJqosYfMT8vUA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: eK7pSZME8vBVsUS8JniUpFafomGRP3BA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX/wMU1bVifus5
 QXx41jN191dF3zNVgGDxMz69fLbkmvo6HK2CLzfVxwDxCj8cA0khNcsVLLL5EcnqkF3dsmI65nd
 xYhhR9Z8xMRydhqTqdjazDI457GuzMEaNEuNEEqOOVhIDrlImnMY
X-Proofpoint-ORIG-GUID: eK7pSZME8vBVsUS8JniUpFafomGRP3BA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX234ipJhmvMiM
 Dd6y13PXXlzmaTtl+hzQQmUZGMVP8LtdyGLQOzC3GqQrXA7MMiiM67raE1uuGOa5NIczsdaWGI3
 gdTF/OlkKusqDtCTV090AS7CEeO1tQiHPsSR3w/s/V+qgWLoJfnXy6EenLFuGb3Gg9GPM6kIK83
 uuh2Bm0egIaIEm4EfEroobybcfCrRRK45udLTBcmboYYJioO1BRU5pPrRcUzQKHlcj36mmJsMqg
 Nw7oDttJlElFODdsIJdf4AmLlwU9eAVXaknF4jXdKgd1+N98QkmmDxN6eVa4pYwe8iTllmHrMly
 YFaURodwVttx9AUymgECdLZYYbIN7cb6FxYtWbFpMuqrBrQFPJWNph0bDfKbKdEKN/GgwnQfNLK
 APFEXqVlAZzHaNn9Y+0ViU+mKGCer7zbg+65yJoetNhQXEdaLo0rDhSy/V1HdX0IMiDlf/YkHbO
 pRY0fNwBT9sAFrCZ4mg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 1dfb59a228dde59ad7d99b2fa2104e90004995c7 ]

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions, add helper functions for Elf_Ehdr.  This
will create a function pointer for each helper that will get assigned to
the appropriate function to handle either the 64bit or 32bit version.

This also moves the _r()/r() wrappers for the Elf_Ehdr references that
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
Link: https://lore.kernel.org/20250105162345.736369526@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 25 +++++++++++++++++++++++++
 scripts/sorttable.h | 20 ++++++++++++++++----
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 57792cf2a..5dfa734ef 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -85,6 +85,31 @@ static uint64_t (*r8)(const uint64_t *);
 static void (*w)(uint32_t, uint32_t *);
 typedef void (*table_sort_t)(char *, int);
 
+static uint64_t ehdr64_shoff(Elf_Ehdr *ehdr)
+{
+	return r8(&ehdr->e64.e_shoff);
+}
+
+static uint64_t ehdr32_shoff(Elf_Ehdr *ehdr)
+{
+	return r(&ehdr->e32.e_shoff);
+}
+
+#define EHDR_HALF(fn_name)				\
+static uint16_t ehdr64_##fn_name(Elf_Ehdr *ehdr)	\
+{							\
+	return r2(&ehdr->e64.e_##fn_name);		\
+}							\
+							\
+static uint16_t ehdr32_##fn_name(Elf_Ehdr *ehdr)	\
+{							\
+	return r2(&ehdr->e32.e_##fn_name);		\
+}
+
+EHDR_HALF(shentsize)
+EHDR_HALF(shstrndx)
+EHDR_HALF(shnum)
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index cd4429c8a..97278c973 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -27,6 +27,10 @@
 #undef uint_t
 #undef _r
 #undef etype
+#undef ehdr_shoff
+#undef ehdr_shentsize
+#undef ehdr_shstrndx
+#undef ehdr_shnum
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -39,6 +43,10 @@
 # define uint_t			uint64_t
 # define _r			r8
 # define etype			e64
+# define ehdr_shoff		ehdr64_shoff
+# define ehdr_shentsize		ehdr64_shentsize
+# define ehdr_shstrndx		ehdr64_shstrndx
+# define ehdr_shnum		ehdr64_shnum
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -50,6 +58,10 @@
 # define uint_t			uint32_t
 # define _r			r
 # define etype			e32
+# define ehdr_shoff		ehdr32_shoff
+# define ehdr_shentsize		ehdr32_shentsize
+# define ehdr_shstrndx		ehdr32_shstrndx
+# define ehdr_shnum		ehdr32_shnum
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -250,16 +262,16 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int orc_num_entries = 0;
 #endif
 
-	shdr_start = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->etype.e_shoff));
-	shentsize = r2(&ehdr->etype.e_shentsize);
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
 
-	shstrndx = r2(&ehdr->etype.e_shstrndx);
+	shstrndx = ehdr_shstrndx(ehdr);
 	if (shstrndx == SHN_XINDEX)
 		shstrndx = r(&shdr_start->etype.sh_link);
 	string_sec = get_index(shdr_start, shentsize, shstrndx);
 	secstrings = (const char *)ehdr + _r(&string_sec->etype.sh_offset);
 
-	shnum = r2(&ehdr->etype.e_shnum);
+	shnum = ehdr_shnum(ehdr);
 	if (shnum == SHN_UNDEF)
 		shnum = _r(&shdr_start->etype.sh_size);
 
-- 
2.34.1

