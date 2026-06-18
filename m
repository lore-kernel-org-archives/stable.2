Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD73279907
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813760; cv=none; b=DG5LIiS7UvSMGskVMleEaCNUdU3i1v3bGpU3UDhf8tz4APlkqSXM5tjBlMqmneWz42+VLkiUcBLyXYwtHkyJlrTaRFsDCdRxR3QYtGf64jzEqzeA+ejXow9s5xh64JjJ5oVBoNgowPzPbe3w9wR+4E3Un8I27f/B9gCJvAWDSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813760; c=relaxed/simple;
	bh=/eCs5PgOc6vglHwSEhYWBH1vyD6HWIvdmgKmt92Qdsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+ZuiVvLObGC5Sc10UaCuz8GKNkN9whDwcjEzsxX5NoNZmYCrTS3YAkJvvYd8dtVdSOW3SrrvmyuhHU3OrOtemWxT0nHDE05Lf1TsK04PYzLJ9+mz900hduV/OataOJy1s798+UVhVtR5tZTnmKgiUEJ86n7WIz64BvRjhG7fvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=cVSLHuAe; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="cVSLHuAe"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsaw73922544;
	Thu, 18 Jun 2026 20:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=x5dIxY0KI/s4CGjvzWtTNN1wNgcd9Z6bdhBuW0RF094=; b=cVSL
	HuAeJk4928kvPD1fZ07MngotwfDlqyL7InYy6YicG7mPWNdJyBy2vGeRTIZSU48v
	PX3JXJO3de07u8Ngap0vbo7Qk0CLc8dHLVT3jtIC2grceM4GxGJPgEFttkr0INX/
	9bsm0Z2cOVa5IY8EC4r3PwEVYYIFukwcMAKIqUeDqzuAc+SEWTeeH95bR/DuVvqe
	eu5f7VIcs3JBkQTrwS7gINd3VAJcUr+CLEodVbHnuiDw63Ai/XKN9wEnfz14ueL+
	87p6+4cg6OyvHTeUWz4+nOvoVLhoBAEQk6D/3AeKXbLrnZhvevONvxPjdqmRRZJe
	HAu7R8od0Wf8lTrJLA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ev4y0vc3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:15:52 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:15:51 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 05/27] scripts/sorttable: Make compare_extable() into two functions
Date: Thu, 18 Jun 2026 16:15:19 -0400
Message-ID: <355a7e43ce293504ed0abde5792b981a7c317d51.1781809922.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX0CzglgXqfFRh
 Xw8S3UffJFeRB9TaB1RqbywGToLZOmQs3ILdl+WWe5iWuFbIiuy/whqCc3O1eItCjWW2Ef9rmTr
 iExGq6e/UCY+0fH5/+RX8FF+KBmCc1F4sddXMwesqUCtJWuYjaxFK9PZXqklrO2XV/bdmyuKjgd
 0fu/3e0C51M4i+95duGxQnrg3Zusep3wZHyvSwN1bQmounHKMtpBOjvgcKKtdFGZbql/52kJQou
 ojekq2v9wzZVBXF25V9xcdxXXzw15q5dtoVfbcBI+jM5BHhhSTbgAl3tktxS3rcSAA+ytUvtSXQ
 LKuQGwe4TrVU4w+iFDJS4LPEABBa6lXekasl+ZOdcltLJiI6TIAiaqpc/1xTtaE6IlRMZJvEIra
 1QdV5WvOqPJTaKkbxw1e34TGpuRIpZFsDbc9WewCGuYqBNZykGqTNV7esAQARReOGeCwbsm+vlV
 NA+Qp5hD6nqMPKtcMkQ==
X-Proofpoint-ORIG-GUID: SmbIhQkGwCmdHHE0ariYAML4lt1u2nM0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX3Ye/hPSCEI07
 B6gTF2Tk4cbwsgIhxc+tNmYdf5p7R3f1E5w7uRDRME2aqJgNzY9dJAKiT6WYk0WNbe0vIbA1ws9
 f+A6ZvJtgzW3km8fZhkjA7af5INM8O0lP3VN4NAoBDnPJSFhDQXZ
X-Authority-Analysis: v=2.4 cv=Ood/DS/t c=1 sm=1 tr=0 ts=6a3451f8 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=IdAk5Fh7ePpybWqhdtEA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: SmbIhQkGwCmdHHE0ariYAML4lt1u2nM0
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 7ffc0d0819f438779ed592e2e2e3576f43ce14f0 ]

Instead of having the compare_extable() part of the sorttable.h header
where it get's defined twice, since it is a very simple function, just
define it twice in sorttable.c, and then it can use the proper read
functions for the word size and endianess and the Elf_Addr macro can be
removed from sorttable.h.

Also add a micro optimization. Instead of:

    if (a < b)
        return -1;
    if (a > b)
        return 1;
    return 0;

That can be shorten to:

   if (a < b)
      return -1;
   return a > b;

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
Link: https://lore.kernel.org/20250105162344.945299671@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 20 ++++++++++++++++++++
 scripts/sorttable.h | 14 --------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 4dcdbf7a5..3e2c17e91 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -173,6 +173,26 @@ static inline unsigned int get_secindex(unsigned int shndx,
 	return r(&symtab_shndx_start[sym_offs]);
 }
 
+static int compare_extable_32(const void *a, const void *b)
+{
+	Elf32_Addr av = r(a);
+	Elf32_Addr bv = r(b);
+
+	if (av < bv)
+		return -1;
+	return av > bv;
+}
+
+static int compare_extable_64(const void *a, const void *b)
+{
+	Elf64_Addr av = r8(a);
+	Elf64_Addr bv = r8(b);
+
+	if (av < bv)
+		return -1;
+	return av > bv;
+}
+
 /* 32 bit and 64 bit are very similar */
 #include "sorttable.h"
 #define SORTTABLE_64
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 58f7ab5f5..36655ff16 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,7 +23,6 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef Elf_Addr
 #undef Elf_Ehdr
 #undef Elf_Shdr
 #undef Elf_Sym
@@ -38,7 +37,6 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define Elf_Addr		Elf64_Addr
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
 # define Elf_Sym		Elf64_Sym
@@ -52,7 +50,6 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define Elf_Addr		Elf32_Addr
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
 # define Elf_Sym		Elf32_Sym
@@ -160,17 +157,6 @@ static void *sort_orctable(void *arg)
 }
 #endif
 
-static int compare_extable(const void *a, const void *b)
-{
-	Elf_Addr av = _r(a);
-	Elf_Addr bv = _r(b);
-
-	if (av < bv)
-		return -1;
-	if (av > bv)
-		return 1;
-	return 0;
-}
 #ifdef MCOUNT_SORT_ENABLED
 pthread_t mcount_sort_thread;
 
-- 
2.34.1

