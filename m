Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE917A30A
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815170; cv=none; b=dat339FuopvL3wgUwXmB2e2gU86LiC0o0Fp6Vy6VzfCTw1Xu41YB8dWrOw7+m75eL1OrTbfLhyNnwzp7NOFzUrDhh49UecxB39NsI2X8qpzRHKdaGOGVzbm32iShvhrJg2mzGumy8IzasY0M87Ecoin/aWJYGj2BHGanjNfWUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815170; c=relaxed/simple;
	bh=RMQjqkexcsPtO3+Tf/mbkil+EzLtwjG9y0yxjQc8/l0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cr3g+Cjm3uao7F8O6NbmHu0JLQQNMzYonv7rH4zj52zed44G0FmvEwjith/Plc/5J+me37U/ZjxjBTuazzlOZuWN0zxGLameACNvQLOpZX67UHEjzHo1zNA81X2/+aIdBtrOo0x5PlCuVoOKIrhRsVgwrbcAoa1C3XHIG4xzVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=tsb1Tf22; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="tsb1Tf22"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsrQI3988528;
	Thu, 18 Jun 2026 20:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=8BdIY2HwYIHd71YOYAr6/pXNZkvCjl+uaUybxClJYl8=; b=tsb1
	Tf22UCpWSip9c5ldK3SOgMJZLFqaC2v+OjV3JUoo6FJShoGAAlMMSn5jidTWnzAe
	Tjxbo5sNIiN9ewdQluAaLFf3YK//TbZC2hZ0KIyeFdfQQIFBLrPq2ZjpBQICug/l
	rBLs9YudaOdOeGCOevKthbxffIYvfoBXOIupkCopPZ6hhlEdh9Aw80FeYvD+gwYb
	zKn/oOGkeoWN/UxFdpvX1YvK0BrYGZBVwsq9xxKYVQxPzxu6a55Oqc5yNys5e799
	kEUH5fcopQm9hK+agg0IsJ/EpNsjXQdPr6R5aXMqBGEKcGbnvIjO/bEXpUrWuRLh
	9HnUTRt1BSfX2aqYew==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev4w5v34f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:23 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:22 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 12/27] scripts/sorttable: Use uint64_t for mcount sorting
Date: Thu, 18 Jun 2026 16:38:50 -0400
Message-ID: <2cf3a7cb8035a129abaa492eb4b7c88cedf05cf5.1781814124.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX/OyHCzPwT3t6
 mT+hUOAkULhjzwEGQM1Ra+JKRihn9UPEu1FpoCDi4x7AMYg8UUImEKCzy6XHp9E3Bhq4Z6v9DCR
 R6zB9XByq2DwDVMi24EQGluWvWwNZSB4FDDpYUK09TMqLQgekxdS/ABf9qvXxQHNYPEG4hUSHVt
 XJ8tOLy6QL4buPKGZuJcDN3+FqRar23nx3njUNijQq/2QeYIMFzeM6jaybFvg46SkZirNCLQ1NX
 SdrmTat7Oz7IIthFHrC/VpctPdY72Paj4OMVkrMnyUkuTutHkndpCss73w5zeWI0GRMIbIV/CEl
 K1jKoY5iqA8MMCUH8Hp6agIQR4W4iJX9WfKQ6jyOPWnsxhOGnJ2AyW4NfDRHzSbcqgJNaE4di6C
 ENzM9FcfgD8slKzcpAZG929pVbqjP7iCp3DK+6OtWGlLHcK85nOWfOV7fnpE7F92z/8gH9CzgLH
 HaiOgrHh8MoJM+qZPBA==
X-Authority-Analysis: v=2.4 cv=JtDBas4C c=1 sm=1 tr=0 ts=6a34577b cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=XszpiVr7ZFtOaaUMZQsA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: -KO0vZaYimvq3HVjRcCP488E2EZHIasC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX/wv8RE6mQEzP
 F6s0KXpmmQMpvaiNpjJDKfI4Ckzfb6Qbk66MdWuo+IvKGD8161dukhsFsoeksWZPZiMkykaQb+n
 G/qh+vE/FJgSJ+tAc1GaZBEIwl1NxIcizJoWrZJVxJBwBVo4nDqr
X-Proofpoint-GUID: -KO0vZaYimvq3HVjRcCP488E2EZHIasC
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 1b649e6ab8dc9188d82c64069493afe66ca0edad ]

The mcount sorting defines uint_t to uint64_t on 64bit architectures and
uint32_t on 32bit architectures. It can work with just using uint64_t as
that will hold the values of both, and they are not used to point into the
ELF file.

sizeof(uint_t) is used for defining the size of the mcount_loc section.
Instead of using a type, define long_size and use that instead. This will
allow the header code to be moved into the C file as generic functions and
not need to include sorttable.h twice, once for 64bit and once for 32bit.

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
Link: https://lore.kernel.org/20250105162346.373528925@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index ef7e5161d..17a8541a1 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,7 +23,6 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef uint_t
 #undef ehdr_shoff
 #undef ehdr_shentsize
 #undef ehdr_shstrndx
@@ -39,6 +38,7 @@
 #undef sym_name
 #undef sym_value
 #undef sym_shndx
+#undef long_size
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -47,7 +47,6 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define uint_t			uint64_t
 # define ehdr_shoff		ehdr64_shoff
 # define ehdr_shentsize		ehdr64_shentsize
 # define ehdr_shstrndx		ehdr64_shstrndx
@@ -63,6 +62,7 @@
 # define sym_name		sym64_name
 # define sym_value		sym64_value
 # define sym_shndx		sym64_shndx
+# define long_size		8
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -70,7 +70,6 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define uint_t			uint32_t
 # define ehdr_shoff		ehdr32_shoff
 # define ehdr_shentsize		ehdr32_shentsize
 # define ehdr_shstrndx		ehdr32_shstrndx
@@ -86,6 +85,7 @@
 # define sym_name		sym32_name
 # define sym_value		sym32_value
 # define sym_shndx		sym32_shndx
+# define long_size		4
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -193,25 +193,25 @@ pthread_t mcount_sort_thread;
 struct elf_mcount_loc {
 	Elf_Ehdr *ehdr;
 	Elf_Shdr *init_data_sec;
-	uint_t start_mcount_loc;
-	uint_t stop_mcount_loc;
+	uint64_t start_mcount_loc;
+	uint64_t stop_mcount_loc;
 };
 
 /* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
 static void *sort_mcount_loc(void *arg)
 {
 	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
-	uint_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
+	uint64_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
 					+ shdr_offset(emloc->init_data_sec);
-	uint_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
+	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 
-	qsort(start_loc, count/sizeof(uint_t), sizeof(uint_t), compare_extable);
+	qsort(start_loc, count/long_size, long_size, compare_extable);
 	return NULL;
 }
 
 /* Get the address of __start_mcount_loc and __stop_mcount_loc in System.map */
-static void get_mcount_loc(uint_t *_start, uint_t *_stop)
+static void get_mcount_loc(uint64_t *_start, uint64_t *_stop)
 {
 	FILE *file_start, *file_stop;
 	char start_buff[20];
@@ -277,8 +277,8 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int shstrndx;
 #ifdef MCOUNT_SORT_ENABLED
 	struct elf_mcount_loc mstruct = {0};
-	uint_t _start_mcount_loc = 0;
-	uint_t _stop_mcount_loc = 0;
+	uint64_t _start_mcount_loc = 0;
+	uint64_t _stop_mcount_loc = 0;
 #endif
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 	unsigned int orc_ip_size = 0;
-- 
2.34.1

