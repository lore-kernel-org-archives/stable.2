Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA334CFC2
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815167; cv=none; b=cBKPWzrez6184p3rRtsWBpr3Dsom/lW4s9aXnu56/z3d0LVabqBq6soad6n9LF0AzuXLFFFYcQGXd976eCyIe2BZS8TsJYqT608Zx81PhVgm+IteAvohl+IiPBL0IeVl0pxR5XjKc6DP4qk8OjHJ+y75gEUR2dJxM6ZjZFNglpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815167; c=relaxed/simple;
	bh=9YRaZPg/RT0KJ/umPJEyKcWwN4z3l4MX9DpuDNQcp0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkWKAyEcPxMl0olaiekO3CATVmKjDNOpHElkELm/GwetYM1uJBqA63fwH9R1rPexsxJZzGLFx2mhXIXTMGPU2W6FAGD+1GaHlsppsYEerA8Xgf/+fD1BjGoCb2yr6tGmMDzdDDki2LPmoVsnguyqp2NT95NMuAv1ZY6VeISfJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=iKWEQmYb; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="iKWEQmYb"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIss923951797;
	Thu, 18 Jun 2026 20:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=kHynh8esAMosiuI7pTOVvcVMH6dMo7xaRNPvfeVj9Qk=; b=iKWE
	QmYbtD9pY1VZIBjEKWfP2GlKbtY3VWsCrNktqloJHs7Ju1jcT7vtGHAW109Dpb8P
	0Jin/pv58pZiYP1oCq1/wgji4/Brd0Hb6ovGsIYhv2zQunBSutbj6S5mse91awX0
	nF32sw3Mc1MMkaUZLhxV/uftUR5aiRcndJHz3oWKo8mzULMXrms0jft3uYETG2CV
	m6j3ws/Z/WF0W6kgYidpm16pb84JLoH3ATD3Bf9Je1BvgicnwhPmLTT6hoDERLwy
	tLzCBc3LcuHE4ubUCmnicuQ5hFTP55jibibORXG6UeVVmgSORi73KdktyI33YWI3
	X81do4U2z7ZCj99FWw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4evd10atyx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:19 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:18 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 09/27] scripts/sorttable: Add helper functions for Elf_Ehdr
Date: Thu, 18 Jun 2026 16:38:47 -0400
Message-ID: <629ff1458625033b72bdb9e4e976c91da8b23f92.1781814113.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX4Wz19nC2jcGA
 p/wwvfXS4VfAKyPdPgXomM2d511pyEeFvMi4uFW8HiMNbJ54FY5v5RMnRh9pVVTic4uCsLrvej+
 7tXe9DQmr8x7wLLqpY+9o7N9USqd3kROffK6zkCg6E75we22/2wnLKcf0nNFLjgkIlOa2QZ2NVm
 iZoVY23DNj2WhlBj07BxkdvwnRw/jHTZEe42RsOqSsddH+rCkBzUsuze42lpa8XfD9AZRPPVM7h
 LRamFE3Ri9t7dkU/QDtuo+fm1Ht1GA5cup99teTBwayB1bvAuxQ9EljCfz5ZurwPdWlMeqqlFH+
 2CcfQg/MFFE62ImCFgR5LYdLR5WTKC7YFf2LM7ko73Us53NRhoxQsIcD2LdKuXHBefFyA+skX0P
 E1vuX8qiw+wZNuMvCm7/YNLQBvVIPEFycCSaF/GGx1ZxPkrUxwam15Av3b+sCMVrvLm9I5n28zc
 cdPgUlUbPTpJw25yDGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfXyWLS1/Xqo/CS
 sVZ7WdcoRJ3QO4YAx94GqLrWIp86D4uxHVztJ4E9ut+1vHjbp1qyvVPUOMNkScFx/dH4+NjIryP
 R/N4zm76KpKOOif9g5BOYpBNZPgWtdO3MldAApR+f5F1Ci0MYDx9
X-Proofpoint-ORIG-GUID: TBRhRwD-XBmZrIXp0o4Qsl_SHxe6rjDe
X-Proofpoint-GUID: TBRhRwD-XBmZrIXp0o4Qsl_SHxe6rjDe
X-Authority-Analysis: v=2.4 cv=L7UtheT8 c=1 sm=1 tr=0 ts=6a345777 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=9MykWdAsJqosYfMT8vUA:9
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

