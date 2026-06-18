Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F9A279907
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813777; cv=none; b=NQgEHOXjLbm3enxVrzd3XHx3/8ptwtnY9EHu++o2+Hc1EszuxI9/FBAxCAoiG47ZCuFHSInjV5nbwET36NPzLwvWgFPOj5lxRY41fs1tdoeYZMcZykVg7R+wPxfTPbflXnJ67tvR5GepSA2HRroSetbtkdMmFR7HkVAferKek1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813777; c=relaxed/simple;
	bh=po84oh9DxSuXOzB9LiUSAYI8h0rgBSSqgbYgT6JpET0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8TM7LOCk/M9HWG3yy/b6TeXwN1rUe48WHpOxksWe19L4Ff2snKkdR9+0ylmVARpRxv3sKVo5rGP8nPkAkbFMf3JmmPBbEktmZgtn41URCI38AC2ZfNbaCHZ6Me3bbLFS1DgIqWyhNez9o21A2TgsrxGDgCH8UnmDOakdi+WRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=XLI7dza1; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="XLI7dza1"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIss333951797;
	Thu, 18 Jun 2026 20:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=I2lMorUm1fmMtbDG7qxA/PBwQ+9DmKPe9l77LkgWlvQ=; b=XLI7
	dza1uH+t350G+GQ0m+EYgHGb250falGJAfRhRE3RNaZZ5d9xG89wasDkWzfew6yl
	8pxaMPyLHtWSeXyuDhuM/f5hlsgzmozBV/LLIzA/yE4NtETjyCf5yajDO/E1Adzs
	+9pd3w7XHgN4jS3GCoNy4DYebc1r3U6eu4+icrS4twWKEOHl5SnjBH5HB9qj+4Mn
	T6JEwOWBa9bZ8bYDyGYq3vASngtmDsaoAlNqHEyY6yPLSWotee++kJJ75/vZUGp2
	UbsTgn5F0MyRLIgU7BAzoY1rZH8yLPAGMYcqbOW6dKT2X1RL6hSEmvqxfjEAfzbZ
	qnhzvnCx4BrVFhtA6g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4evd10aqk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:10 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:08 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 18/27] scripts/sorttable: Always use an array for the mcount_loc sorting
Date: Thu, 18 Jun 2026 16:15:32 -0400
Message-ID: <64aae6881f5521a50e49dd5bf896da200f28a8d4.1781809963.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfXy/IvLd7MFSHQ
 Kd0S/igJydUBNDMTnperMLOEALQA3TZpw9Vf7z/DIRo0oMC6NxTyYph19yn12bs4AypPWmeQMaH
 41y6w/I+LLURX4d44JhdGQhMbRJnXdo9mwS7P1ZywZUM3iN7Zr/kfFnBWgOeJI3Ng5nL1EeUKnD
 oCSLT4kPFaMlo7Ob7/eefP+fVmxWwfyMor5nSugp4/aLFUcnZ16Z81i3FbvYrl+32VAGkMgrqL4
 wmm2MZV6LtzRnva2wDRcBDRHukBOPSt2m8Kto+nHmiMyUbi2dNNn8G3s0b8wHUcPKW3RisBPeLH
 CsinMzGlt+UYaBAuHm/jKdGpfwkTdiWPnHoh2kUkPEyCl/4EewMqslf5/kr4SvLzSvB0u9xCrXS
 m9DLMYB/BxIROHcjbQt3e+N8rrBDAlD2ccDk3rwa26lhArJ4KqHbPG30SgGDDE9l/dtVNTTfRsF
 m+VBLErqn/J5d7JYCow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX903dyb/lntX/
 6VcDX9m1ycN+MIG1rT7e0rOgTz0nZIZEU0geVh05csnlMuPdyavdF7dXeDdnDP88v6Pmxb2RPiL
 AG60mmNqZZGpL1P+wmevEk2eimwEiymvWxq0TcpEUwhsimOoiWUJ
X-Proofpoint-ORIG-GUID: DDL5f0RYIHsT9jTnd1R2AxfGdqThkEQg
X-Proofpoint-GUID: DDL5f0RYIHsT9jTnd1R2AxfGdqThkEQg
X-Authority-Analysis: v=2.4 cv=L7UtheT8 c=1 sm=1 tr=0 ts=6a34520a cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=Sx-ZMR9Jp1t19hWfpL8A:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 5fb964f5ba53afda0e2b6dbc00b8205461ffe04a ]

The sorting of the mcount_loc section is done directly to the section for
x86 and arm32 but it uses a separate array for arm64 as arm64 has the
values for the mcount_loc stored in the rela sections of the vmlinux ELF
file.

In order to use the same code to remove weak functions, always use a
separate array to do the sorting. This requires splitting up the filling
of the array into one function and the placing the contents of the array
back into the rela sections or into the mcount_loc section into a separate
file.

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
Link: https://lore.kernel.org/20250218200022.710676551@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 122 ++++++++++++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 32 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index f62a91d8a..ec02a2852 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -594,31 +594,19 @@ struct elf_mcount_loc {
 	uint64_t stop_mcount_loc;
 };
 
-/* Sort the relocations not the address itself */
-static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
+/* Fill the array with the content of the relocs */
+static int fill_relocs(void *ptr, uint64_t size, Elf_Ehdr *ehdr, uint64_t start_loc)
 {
 	Elf_Shdr *shdr_start;
 	Elf_Rela *rel;
 	unsigned int shnum;
-	unsigned int count;
+	unsigned int count = 0;
 	int shentsize;
-	void *vals;
-	void *ptr;
-
-	compare_values = long_size == 4 ? compare_values_32 : compare_values_64;
+	void *array_end = ptr + size;
 
 	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
 	shentsize = ehdr_shentsize(ehdr);
 
-	vals = malloc(long_size * size);
-	if (!vals) {
-		snprintf(m_err, ERRSTR_MAXSZ, "Failed to allocate sort array");
-		pthread_exit(m_err);
-		return NULL;
-	}
-
-	ptr = vals;
-
 	shnum = ehdr_shnum(ehdr);
 	if (shnum == SHN_UNDEF)
 		shnum = shdr_size(shdr_start);
@@ -637,22 +625,18 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 			uint64_t offset = rela_offset(rel);
 
 			if (offset >= start_loc && offset < start_loc + size) {
-				if (ptr + long_size > vals + size) {
-					free(vals);
+				if (ptr + long_size > array_end) {
 					snprintf(m_err, ERRSTR_MAXSZ,
 						 "Too many relocations");
-					pthread_exit(m_err);
-					return NULL;
+					return -1;
 				}
 
 				/* Make sure this has the correct type */
 				if (rela_info(rel) != rela_type) {
-					free(vals);
 					snprintf(m_err, ERRSTR_MAXSZ,
 						"rela has type %lx but expected %lx\n",
 						(long)rela_info(rel), rela_type);
-					pthread_exit(m_err);
-					return NULL;
+					return -1;
 				}
 
 				if (long_size == 4)
@@ -660,13 +644,28 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 				else
 					*(uint64_t *)ptr = rela_addend(rel);
 				ptr += long_size;
+				count++;
 			}
 		}
 	}
-	count = ptr - vals;
-	qsort(vals, count / long_size, long_size, compare_values);
+	return count;
+}
+
+/* Put the sorted vals back into the relocation elements */
+static void replace_relocs(void *ptr, uint64_t size, Elf_Ehdr *ehdr, uint64_t start_loc)
+{
+	Elf_Shdr *shdr_start;
+	Elf_Rela *rel;
+	unsigned int shnum;
+	int shentsize;
+
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
+
+	shnum = ehdr_shnum(ehdr);
+	if (shnum == SHN_UNDEF)
+		shnum = shdr_size(shdr_start);
 
-	ptr = vals;
 	for (int i = 0; i < shnum; i++) {
 		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
 		void *end;
@@ -689,8 +688,32 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 			}
 		}
 	}
-	free(vals);
-	return NULL;
+}
+
+static int fill_addrs(void *ptr, uint64_t size, void *addrs)
+{
+	void *end = ptr + size;
+	int count = 0;
+
+	for (; ptr < end; ptr += long_size, addrs += long_size, count++) {
+		if (long_size == 4)
+			*(uint32_t *)ptr = r(addrs);
+		else
+			*(uint64_t *)ptr = r8(addrs);
+	}
+	return count;
+}
+
+static void replace_addrs(void *ptr, uint64_t size, void *addrs)
+{
+	void *end = ptr + size;
+
+	for (; ptr < end; ptr += long_size, addrs += long_size) {
+		if (long_size == 4)
+			w(*(uint32_t *)ptr, addrs);
+		else
+			w8(*(uint64_t *)ptr, addrs);
+	}
 }
 
 /* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
@@ -699,14 +722,49 @@ static void *sort_mcount_loc(void *arg)
 	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
 	uint64_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
 					+ shdr_offset(emloc->init_data_sec);
-	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
+	uint64_t size = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
+	Elf_Ehdr *ehdr = emloc->ehdr;
+	void *e_msg = NULL;
+	void *vals;
+	int count;
+
+	vals = malloc(long_size * size);
+	if (!vals) {
+		snprintf(m_err, ERRSTR_MAXSZ, "Failed to allocate sort array");
+		pthread_exit(m_err);
+	}
 
 	if (sort_reloc)
-		return sort_relocs(emloc->ehdr, emloc->start_mcount_loc, count);
+		count = fill_relocs(vals, size, ehdr, emloc->start_mcount_loc);
+	else
+		count = fill_addrs(vals, size, start_loc);
+
+	if (count < 0) {
+		e_msg = m_err;
+		goto out;
+	}
+
+	if (count != size / long_size) {
+		snprintf(m_err, ERRSTR_MAXSZ, "Expected %u mcount elements but found %u\n",
+			(int)(size / long_size), count);
+		e_msg = m_err;
+		goto out;
+	}
+
+	compare_values = long_size == 4 ? compare_values_32 : compare_values_64;
+
+	qsort(vals, count, long_size, compare_values);
+
+	if (sort_reloc)
+		replace_relocs(vals, size, ehdr, emloc->start_mcount_loc);
+	else
+		replace_addrs(vals, size, start_loc);
+
+out:
+	free(vals);
 
-	qsort(start_loc, count/long_size, long_size, compare_extable);
-	return NULL;
+	pthread_exit(e_msg);
 }
 
 /* Get the address of __start_mcount_loc and __stop_mcount_loc in System.map */
-- 
2.34.1

