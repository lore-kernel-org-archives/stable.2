Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB22FB969
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815450; cv=none; b=BfWFgjhHgdxtseXGfq7mGOk08zkNvfMJ3zuuQbVB3FbtVFGohqrYOqlWJGj2z02H5usBR0wHIk8TRgRUsMAzqH5KZYZvblJeOp8maFQS0xuwVWAYEGzGKF/UznPb0+p+0T8J2M3SIUeJYQsm9uhPpmVbOvwxJDxu0LOXTSlyAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815450; c=relaxed/simple;
	bh=OaptE1/gtm9u+e09m8G9kP/lKwda4A+s3AUca3DbC5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKRaXPHpe1rkYU6kKKAj9ZSdi2whpFQKI91+EpWW7SPrh/hrsWAQQf76e55R3ozM0jTksMvYQygMkXVbV6V7wF8MJUFeycXOmQRDZyFyIGsNUTNDKB3uLV40vbZlg1o7XzvUsPPZy35xJaDFA7HTv1sIkAKSJ1scgL9cnGqKbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=l32F/tUK; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="l32F/tUK"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsrKO3988528;
	Thu, 18 Jun 2026 20:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=NNpQ667LkrO398pV4xoIsO5z3sKp4xshONvEXwtcKH0=; b=l32F
	/tUKgxxJD+CHPNywcS1sRhEpAdmLjB3rXmxziGPpsQgjw/eJcqePE6ZiE2cOH52i
	k36OmCZWT8DHVd+qFqrsxvU3iSS5k7LXeKnOQysDuuHPawjy39Z3f8sbhb3FCcx6
	D2+aEiFPipjuOdYdenmqFqkvQx6mhastmlZC6kZs3XPeC5XOyStz220d9DlLSCjx
	5IOvsUkJ+qo3CzW60rK1YIA7/ef5F10UTgHqOJi80P7w8we2YogWUvYTNAERDwaR
	giwsQhXS/WQozSVyi0R/icstPWq/QgAm3d8Gyc230XfSKzjQFF01w7NsH17ZH+tp
	helFhaGNJKEplPoQKQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev4w5uyse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:15:47 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:15:45 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 01/27] scripts/sorttable: Remove unused macro defines
Date: Thu, 18 Jun 2026 16:15:15 -0400
Message-ID: <f1cd060da6cd86ab48f12660a85f7059f3aa016c.1781809913.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfXzUazJDfAWGPC
 vJh7uYOuPlUFIZd5aOMabtM/0+tnTpKMuH3twMKxgimLQ1MYdcUkp1j665zuC5IEns4ZqAI91HJ
 AefuG0I1Xp0iqN645nQN7eqDvi81/HwcPrce8R0xzKsuNPSRpKDIKYbvUnoawlNZM9paNKWwRR0
 ZkrUPSPGpu4iSfxaCX8WJGrbpWz4CS1m9KCXnseh3GvDQMrugdj/MZ7BSV0iL/3V0BHBJB7s7le
 8iFKeS6ReR9uqIPxl1v8ibPa/nce9xmo4wIT9r6FVjv+Zw2W/wkpEpBM/hitSAA++qrbsNLAwlw
 E3tYdxBJLpr8YWE3ff+MlzYdCqoTMbqE+MdAx8bjm05A7CkuPGxl7cwHmdp1h491nUH6gXENnC1
 I401QZ8esn+7p+NNQ3LLczBCcQxqHOAXSUdSCOXsg72fOf1WTjmRAm5xRlthBCl1KjwIk3GBHsg
 QQ3jZUMymd+gAjnWodQ==
X-Authority-Analysis: v=2.4 cv=JtDBas4C c=1 sm=1 tr=0 ts=6a3451f3 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=0YzJpPVHDIj9ECx9jcYA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: IolkH_q6zg1nJb9vBTwntSeBK7vZuUFj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX/QnlFTgpto6L
 i1sCJl7H+vCuf5EPUJR7sFLhffaVAn1qn5OLCd3J2oID5uHGwdbO2+JMMDk2VjkBSTQzswple44
 oUJrIBP33n9mb0zIFrVeNQCDS0ANt2crWbzkPJ1sK0vB7GjlRPy/
X-Proofpoint-GUID: IolkH_q6zg1nJb9vBTwntSeBK7vZuUFj
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 28b24394c6e9a3166fcb4480cba054562526657c ]

The code of sorttable.h was copied from the recordmcount.h  which defined
a bunch of Elf MACROs so that they could be used between 32bit and 64bit
functions. But there's several MACROs that sorttable.h does not use but
was copied over. Remove them to clean up the code.

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
Link: https://lore.kernel.org/20250105162344.128870118@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a7c5445ba..14d0c4d84 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -27,19 +27,10 @@
 #undef Elf_Ehdr
 #undef Elf_Shdr
 #undef Elf_Rel
-#undef Elf_Rela
 #undef Elf_Sym
-#undef ELF_R_SYM
-#undef Elf_r_sym
-#undef ELF_R_INFO
-#undef Elf_r_info
-#undef ELF_ST_BIND
 #undef ELF_ST_TYPE
-#undef fn_ELF_R_SYM
-#undef fn_ELF_R_INFO
 #undef uint_t
 #undef _r
-#undef _w
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -52,19 +43,10 @@
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
 # define Elf_Rel		Elf64_Rel
-# define Elf_Rela		Elf64_Rela
 # define Elf_Sym		Elf64_Sym
-# define ELF_R_SYM		ELF64_R_SYM
-# define Elf_r_sym		Elf64_r_sym
-# define ELF_R_INFO		ELF64_R_INFO
-# define Elf_r_info		Elf64_r_info
-# define ELF_ST_BIND		ELF64_ST_BIND
 # define ELF_ST_TYPE		ELF64_ST_TYPE
-# define fn_ELF_R_SYM		fn_ELF64_R_SYM
-# define fn_ELF_R_INFO		fn_ELF64_R_INFO
 # define uint_t			uint64_t
 # define _r			r8
-# define _w			w8
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -76,19 +58,10 @@
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
 # define Elf_Rel		Elf32_Rel
-# define Elf_Rela		Elf32_Rela
 # define Elf_Sym		Elf32_Sym
-# define ELF_R_SYM		ELF32_R_SYM
-# define Elf_r_sym		Elf32_r_sym
-# define ELF_R_INFO		ELF32_R_INFO
-# define Elf_r_info		Elf32_r_info
-# define ELF_ST_BIND		ELF32_ST_BIND
 # define ELF_ST_TYPE		ELF32_ST_TYPE
-# define fn_ELF_R_SYM		fn_ELF32_R_SYM
-# define fn_ELF_R_INFO		fn_ELF32_R_INFO
 # define uint_t			uint32_t
 # define _r			r
-# define _w			w
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
-- 
2.34.1

