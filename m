Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140A2FB969
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813769; cv=none; b=uqbTWn0N7MxvzsLadvbyHSc84NHHO36/3tSQY/RRX4LFkYEAI8HFr8lal7RqMS6/dF+jUBnviH9+XU9SUtQ1fzffVpfIVD+ThxFT12zPDWc0lWBm8HQIX8HCbqTotIe0NHNRV7XUc5lvgvV8cJzA+Ia3SMP6edHFiwWdCojwS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813769; c=relaxed/simple;
	bh=RMQjqkexcsPtO3+Tf/mbkil+EzLtwjG9y0yxjQc8/l0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jn4P4i8w3M3nOQ6rD0rf6gs4oTVJOCQO/YVmSP4FvVXzTBNJaV4NvM6fdIaSg+9TOivTQcsyDLTLb4MlXFjypnXmFmBrY+6iH7Wtuf/yCjperjKccoSpXclkgbWHcd3mNgioju1s6pUaOfqNLoLL7DYHMOJlCnVUizoqteM2WzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=I5DibsdU; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="I5DibsdU"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsdOM3922608;
	Thu, 18 Jun 2026 20:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=8BdIY2HwYIHd71YOYAr6/pXNZkvCjl+uaUybxClJYl8=; b=I5Di
	bsdUy49LXrU98/IY0iyRfEtfo8/K9o9TY3wZgS89FTwM+aY7Di1AzbTnFr6jEmWA
	un4ZrE3LA5gxCoyqLVrLaGy4DojL3DMEeMrb15ejvRgK3Kaf5IhCdavv6zOViJ30
	xpIHhzdE2bJYOm+6CBmZE/uDqtXFKChcZtKRQmYsn2zJwjHbzKvvWhdrK8kFFNUg
	zAYiWXGa+99KMvC1qG684NBhrV2FmipqZKMYJMF+Az4cwOS8rxYx61FGjc4DDQ16
	gGDDl2Cb/BKVfH/KOc6xbhxl8+PPwsFMIOw2/seIUIIpoZltHZJb9uhkz6ilzY91
	RPYJ8AEO3RhcvnI+gg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ev4y0vc47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:01 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:00 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 12/27] scripts/sorttable: Use uint64_t for mcount sorting
Date: Thu, 18 Jun 2026 16:15:26 -0400
Message-ID: <e6b5f67222359383911a6f5e6b28cd192cb6a18a.1781809947.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX6WOhECiTul4n
 Mzi2YQoYWzebR94HsVKmGt9yces+fuLuuyynEl0XALPq2gqMcd4I5lROgGO1X+mRIuVcnk6ZjuK
 saaHcQkwVNZVZGGojC8JrvACMiRzzP6mxljpDADX20NhzWB6Qhi3WBlcKT9cdeEgtWCXDmf7hmh
 AsnXu4qafloWfh24uQhQ2VnuISA44ff/4nIlVzD0Ls63x88UHUXMZAhu49ZB+GSaiN/6s40eWL6
 q42swFAJZyyaoblp0I5qP160KDBAgG3i/zTnnyXSBcpSt1QBTlYnotv+NYw/KgEQV/905XUPsdw
 L4gUoweb1wnxL3HFuiM/mh+hEhomase3wezM2r+IZRxPtkmk8GuG7KURYTEFjIq33Mf2M212MAK
 BhVBQseUapAl3//tQOPwl0661cB13f4qkqQJJNqjUBr6E+QTVq9lbWB1xjy/ZEq8kGbTi/Wuhly
 LrIS9q9THnwE9+KhtZg==
X-Proofpoint-ORIG-GUID: of7SBnRoZCsjWvHOVpyPGzrBFCRAn8oD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX/RJIDuZDAtA6
 4vipUx+WgLsgMkCitYtgiMyXB2faf3Atpi0Zb83fPWDey8dnAAA2szXdol8cRlhOZU2p8IbAJXs
 r65iBMmeLK4t4zQNlZSWCA9rXfQtqWT3DQXudOtKsYBsIg51eXIe
X-Authority-Analysis: v=2.4 cv=Ood/DS/t c=1 sm=1 tr=0 ts=6a345201 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=XszpiVr7ZFtOaaUMZQsA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: of7SBnRoZCsjWvHOVpyPGzrBFCRAn8oD
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180185

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

