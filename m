Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A86740D59B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550061; cv=none; b=eiH6nHnHFFWNgSRkCo1hVQyA5Dmx3kCfY+RSEHajSKb7fpIX/MscW7UwS887rQkr12MD+Bj2F2jcoD7VW1NU/epuBUEwmQcsOzYQnQUg81fyhwvxWgizPj0GBylzRspBv7PNY9irXJRGeLWKPHMZySqKiCtYk+rPUP7QYVOeSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550061; c=relaxed/simple;
	bh=uh4wVjhYol5MdQOlaooA7P4Rgr+0IYaa2NZxw8eHQ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3zhAoTJ7caeflIB5BGzjHTC1rwUJXsVrZRP/CD7VVCDBqg8KdgVY5kQFrbIq6ossKUbHCQO3+KFz72cVB6wqMT4aSnjmlzGheQ7g0IBavJPtO2X6e1BkuJmYQxe+6h4vjt2ZkZjqDhTl3YJmUadl9Voba9TnTyz5bTfpZKt/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rVZ7iIL4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rVZ7iIL4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KBD1V02032944
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NW+04iM5PpRCJkifP
	cTwNo6eibc+8MoiByAbzwRq9gM=; b=rVZ7iIL4BmbmMhtDhAcjJQBeYhs0jlbZ6
	lpRmQjuTuENMTtppdR7oiMxXcSAlJop5v+Sgmej7gAFT5oiZia5CXJ9ixRT0BpGF
	Ajix34WQjfjpEDMeEKGT5CYMLWWyr7mVPlsulUijGb9IqXTdjkHXA4T+qx3d2eWB
	kxOY2w1eLg7UxxxxvQqUualsTVm9BYSCTc8HwcOzJ8P9s2XE0Hpix5UgnUyEsvme
	HxyzKVDgkDrQPu4sS6G2krssypC5tQ8xQTTlsEWDLvREUTI6nwEhtFifwNboxAcZ
	rSXw+WuSMnHiyEhM4F56AXmFrk4EOXo3iqONQG5F4U8ScSw3nyODw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab7cyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:20:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KCJqbR005762
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:20:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjnh7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:20:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KCKque43843878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 12:20:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41BC42004B;
	Mon, 20 Jul 2026 12:20:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AA7220040;
	Mon, 20 Jul 2026 12:20:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 12:20:52 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 6.12.y] s390: Revert support for DCACHE_WORD_ACCESS
Date: Mon, 20 Jul 2026 14:20:44 +0200
Message-ID: <20260720122044.2318775-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071418-catsup-creasing-f440@gregkh>
References: <2026071418-catsup-creasing-f440@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEzNiBTYWx0ZWRfX0jIWO0DfHjVh
 0xr+UVb1NDx3XIK2ztg6puyGTsgvfSUEFY4L91rnKwE1VOJYhM8iT1Ma2vCImjztHh+OHpGZjyZ
 H/XcEkJ5LZCEBd3+3x17o1bQCQftu3ypZApLZuvHg5H6kjrqt+ygg+JU/CxxKNgfbEt26wYX6Zh
 3lUYTEcu5J09RKtHKgG2EZqnlygDSVv7p2417j+GdVG9qOg9ElfgKUc7jnvXRURbgLg2eOpTKZF
 718MSzkOml6zJ2p1vhu4bz6KL9oHZIUAza6X61c+5S/0ToSPZFAbeY9ptU03BDmeg8kdlqbQyLz
 g9gkYzRW8Di5zIBaAaqFeOT0zang9G6cEnEF33vyvS1t/vQwMzqEyiwcxqGJ2+uwjlWrCS0+A8x
 Ci/kAqtk/NQ0inl3JIMVcsbg+4u+8fV7/lAR32P6dbT21COsJUh3vXFndZp7WsUVv2TVt0nWlN6
 gq7OtWgnZ7n4VwQsMEA==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5e12a9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=k1Q9LRuquVP52GNwYeEA:9
X-Proofpoint-ORIG-GUID: NQDhwgwE0nXMj4gfpqlTvVAtR5SuxcT0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEzNiBTYWx0ZWRfX1aUbwrcnDAmR
 RCZpbSf3NuVtwvJ/im02aM8GcwFpLcTxxL1Zhmo94FRJ11xcyNn6d5TgoAyrXn2AlB53spqR0KD
 7tDhysfxDF9OzqSEU1xZPjFi8XDYAsU=
X-Proofpoint-GUID: NQDhwgwE0nXMj4gfpqlTvVAtR5SuxcT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200136

load_unaligned_zeropad() reads eight bytes from unaligned addresses and may
cross page boundaries. It handles exceptions which may happen if reading
from the second page results in an exception.

For pages which are donated to the Ultravisor for secure execution purposes
the do_secure_storage_access() exception handler however does not handle
such exceptions correctly. Such an exception may result in an endless
exception loop which will never be resolved.

An attempt to fix this [1] turned out to be not sufficient. For now revert
load_unaligned_zeropad() until this problem has been resolved in a proper
way.

Note that the implementation of load_unaligned_zeropad() itself is
correct. The revert is just a temporary workaround until there is complete
fix for secure storage access exceptions.

[1] commit b00be77302d7 ("s390/mm: Add missing secure storage access fixups for donated memory")

Fixes: 802ba53eefc5 ("s390: add support for DCACHE_WORD_ACCESS")
Cc: stable@vger.kernel.org
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
(cherry picked from commit 37540b8c287fc817bdbd0c62bb75ad6eab0e5d03)
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                      |  1 -
 arch/s390/include/asm/asm-extable.h    |  4 ----
 arch/s390/include/asm/word-at-a-time.h | 22 ----------------------
 arch/s390/mm/extable.c                 | 18 ------------------
 4 files changed, 45 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 5e6aebf1b739..28e900e5212c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -137,7 +137,6 @@ config S390
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
-	select DCACHE_WORD_ACCESS if !KMSAN
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
 	select FUNCTION_ALIGNMENT_8B if CC_IS_GCC
 	select FUNCTION_ALIGNMENT_16B if !CC_IS_GCC
diff --git a/arch/s390/include/asm/asm-extable.h b/arch/s390/include/asm/asm-extable.h
index 00a67464c445..f87e06ec86ac 100644
--- a/arch/s390/include/asm/asm-extable.h
+++ b/arch/s390/include/asm/asm-extable.h
@@ -13,7 +13,6 @@
 #define EX_TYPE_UA_LOAD_MEM	4
 #define EX_TYPE_UA_LOAD_REG	5
 #define EX_TYPE_UA_LOAD_REGPAIR	6
-#define EX_TYPE_ZEROPAD		7
 #define EX_TYPE_FPC		8
 
 #define EX_DATA_REG_ERR_SHIFT	0
@@ -82,9 +81,6 @@
 #define EX_TABLE_UA_LOAD_REGPAIR(_fault, _target, _regerr, _regzero)	\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_LOAD_REGPAIR, _regerr, _regzero, 0)
 
-#define EX_TABLE_ZEROPAD(_fault, _target, _regdata, _regaddr)		\
-	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_ZEROPAD, _regdata, _regaddr, 0)
-
 #define EX_TABLE_FPC(_fault, _target)					\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_FPC, __stringify(%%r0), __stringify(%%r0), 0)
 
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index 203acd6e431b..e9287036392d 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -4,7 +4,6 @@
 
 #include <linux/bitops.h>
 #include <linux/wordpart.h>
-#include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
 
 struct word_at_a_time {
@@ -41,25 +40,4 @@ static inline unsigned long zero_bytemask(unsigned long data)
 	return ~1UL << data;
 }
 
-/*
- * Load an unaligned word from kernel space.
- *
- * In the (very unlikely) case of the word being a page-crosser
- * and the next page not being mapped, take the exception and
- * return zeroes in the non-existing part.
- */
-static inline unsigned long load_unaligned_zeropad(const void *addr)
-{
-	unsigned long data;
-
-	asm volatile(
-		"0:	lg	%[data],0(%[addr])\n"
-		"1:	nopr	%%r7\n"
-		EX_TABLE_ZEROPAD(0b, 1b, %[data], %[addr])
-		EX_TABLE_ZEROPAD(1b, 1b, %[data], %[addr])
-		: [data] "=d" (data)
-		: [addr] "a" (addr), "m" (*(unsigned long *)addr));
-	return data;
-}
-
 #endif /* _ASM_WORD_AT_A_TIME_H */
diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index 812ec5be1291..30e4b96be207 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -61,22 +61,6 @@ static bool ex_handler_ua_load_reg(const struct exception_table_entry *ex,
 	return true;
 }
 
-static bool ex_handler_zeropad(const struct exception_table_entry *ex, struct pt_regs *regs)
-{
-	unsigned int reg_addr = FIELD_GET(EX_DATA_REG_ADDR, ex->data);
-	unsigned int reg_data = FIELD_GET(EX_DATA_REG_ERR, ex->data);
-	unsigned long data, addr, offset;
-
-	addr = regs->gprs[reg_addr];
-	offset = addr & (sizeof(unsigned long) - 1);
-	addr &= ~(sizeof(unsigned long) - 1);
-	data = *(unsigned long *)addr;
-	data <<= BITS_PER_BYTE * offset;
-	regs->gprs[reg_data] = data;
-	regs->psw.addr = extable_fixup(ex);
-	return true;
-}
-
 static bool ex_handler_fpc(const struct exception_table_entry *ex, struct pt_regs *regs)
 {
 	asm volatile("sfpc	%[val]\n" : : [val] "d" (0));
@@ -104,8 +88,6 @@ bool fixup_exception(struct pt_regs *regs)
 		return ex_handler_ua_load_reg(ex, false, regs);
 	case EX_TYPE_UA_LOAD_REGPAIR:
 		return ex_handler_ua_load_reg(ex, true, regs);
-	case EX_TYPE_ZEROPAD:
-		return ex_handler_zeropad(ex, regs);
 	case EX_TYPE_FPC:
 		return ex_handler_fpc(ex, regs);
 	}
-- 
2.53.0

