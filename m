Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCFE28C037
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813775; cv=none; b=MFfvHMCl+xvEhp2PGRDS6EnMxaIEWklOYPO+omFSZnPSmx2AStKyxyjQKjuwmlZMj8F9/sId9sWEPamegiv5N9ofNMzmqBFxK6yjNFjnDyrKWYj1A2udJlksgrcIgBhNudD+cxsbmSnRo1T5tnqtrGloY0DmFu5wdzc+UqByysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813775; c=relaxed/simple;
	bh=E6BeMurtrzKA27t6UVf4wK4vphIqoWMGrwvbGO9Lj1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wjxm1o1/CyQTmuCHpvRoKGzPCnk0ZtPJhGxhnM4ODMDGdlIlefC1kfNmykcQsUjcKN9IaZTiG5BQ37OXbASGiOcmUKxGrY76KOLdTcAQ2/d+ULPU7I8juxntZjldEPhSOXsaJq58N45PMN39kMhM0nFDW5cp9u4qzIYjZXCYTrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Yejv6+Tu; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Yejv6+Tu"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiSI93008093;
	Thu, 18 Jun 2026 20:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=aOqpmm9Bqw5tTRw8fA0kgErhnonC8Nk6pBWYTNjt2JY=; b=Yejv
	6+TuRgNdlWh+uYm1U+12wXDtFfHHF7GNUCbRzPV/fNh/feupsUnSslHK1Iu3o9LV
	4oDYz749eDxJZr2Sgrt9ggO84vOmWSocm1HOtFd0NdWOPTFP1twO/N9VZl0c56In
	yp2lrneXnCWXZQQ8Ac/ck/iz3xounWltRIAfN2jB7KzMCn4GaSurF4IQT6ExIvTH
	QF/7lCErWmKmrYxr6QMmBHr4uDsX4J/xNS0vz7FEwBtlqNjfIoN5ZX3vF+/T4s6V
	vIdYfMqz3DBLdSIUBYkDP9ClhSwoH3zh28RU6I45wZojmM74VXX8HImm2Z/8Tmed
	OunZgH4iSJndoXEE2Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3k84ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:09 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:07 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 17/27] scripts/sorttable: Have mcount rela sort use direct values
Date: Thu, 18 Jun 2026 16:15:31 -0400
Message-ID: <08a39ed51d7a5c5b62f0ddf7e54f99e955ec0b15.1781809961.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: CitSsGWP_oSaCLDrr7kUMqs1UbvmBsQ9
X-Proofpoint-GUID: CitSsGWP_oSaCLDrr7kUMqs1UbvmBsQ9
X-Authority-Analysis: v=2.4 cv=QrVuG1yd c=1 sm=1 tr=0 ts=6a345209 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=UWjLTQXr3SkU-CwT73AA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX9fd2yiRn2vR+
 7Pd4d/qX1zQW6wYydgPvUmo/FvbmzyZJJWKGr5MZmqmTFVgRI7x/K2v+UY5EmY35gdciaD3+A0r
 XQvugUCct9xdOoUDsHfv3MHsJsX64fR/T5Ep/7+BJdsexJj3pBx0qvb7fvIocNuuL7keCxXRQ9H
 y1MgYM2Havmn9g1ILusA1yTFvK/NEX4N5ohiMCH0Lq4Gro2c7k7a0naaDrpgoNB6gO8JdtgURMT
 Pb++YqhRKYcb3TPnnYeoEImH7DGqwxzg3uAVlyqZ/iZOaPaozfYcIUNssqwKuKPH7VFJW6qIup5
 tkC/rqNGKH29kPK7G19eSuxIA88ceD9x5DiHBG0T3kjJBtl4NNq8LlPx/XFiuDQc3CROcHjo6GT
 qUqka9VMFpR5+/p2Av6EUUDmiP8zgMpbQlopyceh/ExVSPI0O5QEz0/iLCXIdzlIcE0VOdS5dk1
 FNOAOo79029KganKC2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX5npqJcRcvqAI
 obDniz4bV7UST1a43oMtCu9VqqYIPuV6sHixA3Yc/S4TCeDDcfiv7WFym9gfWZJ/zootGh8BAsh
 KwmVs3kVPKGCA14HLjlO8bv74sxf3JPrLP45K/XkkD2YQnt5XrQd
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit a0265659322540d656727b9e132edfb6f06b6c1a ]

The mcount_loc sorting for when the values are stored in the Elf_Rela
entries uses the compare_extable() function to do the compares in the
qsort(). That function does handle byte swapping if the machine being
compiled for is a different endian than the host machine. But the
sort_relocs() function sorts an array that pulled in the values from the
Elf_Rela section and has already done the swapping.

Create two new compare functions that will sort the direct values. One
will sort 32 bit values and the other will sort the 64 bit value. One of
these will be assigned to a compare_values function pointer and that will
be used for sorting the Elf_Rela mcount values.

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
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250218200022.538888594@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 4a34c2751..f62a91d8a 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -552,6 +552,28 @@ static void *sort_orctable(void *arg)
 
 #ifdef MCOUNT_SORT_ENABLED
 
+static int compare_values_64(const void *a, const void *b)
+{
+	uint64_t av = *(uint64_t *)a;
+	uint64_t bv = *(uint64_t *)b;
+
+	if (av < bv)
+		return -1;
+	return av > bv;
+}
+
+static int compare_values_32(const void *a, const void *b)
+{
+	uint32_t av = *(uint32_t *)a;
+	uint32_t bv = *(uint32_t *)b;
+
+	if (av < bv)
+		return -1;
+	return av > bv;
+}
+
+static int (*compare_values)(const void *a, const void *b);
+
 /* Only used for sorting mcount table */
 static void rela_write_addend(Elf_Rela *rela, uint64_t val)
 {
@@ -583,6 +605,8 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 	void *vals;
 	void *ptr;
 
+	compare_values = long_size == 4 ? compare_values_32 : compare_values_64;
+
 	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
 	shentsize = ehdr_shentsize(ehdr);
 
@@ -640,7 +664,7 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 		}
 	}
 	count = ptr - vals;
-	qsort(vals, count / long_size, long_size, compare_extable);
+	qsort(vals, count / long_size, long_size, compare_values);
 
 	ptr = vals;
 	for (int i = 0; i < shnum; i++) {
-- 
2.34.1

