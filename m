Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96F221F20
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815158; cv=none; b=T6b3/jHExuz4c/RjbbxryKUf8GvHgmQQb0U+3+2XhTEYZB0XNj6SwTzDoTuOm/9+9cnvx85Nj3VP85NUc8Dxxpr/dwEI2Ex/YC9SgeJjw6iHh+KrdMaZuyflh6H0WN4Ft11mBLNMnHKXih4W46Ud8I9Q3XrDAsfesmeZZYacS4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815158; c=relaxed/simple;
	bh=hElwnz7lrZdtWymnpSIX3nQIXwfTG2UpZWkoBqSetEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyvGIlvJua41r/FQ8I2K2zo5bQyeDruQq8n4tugSNuIdA4TjXTZYaeP+m1xWEmL0t5poUcCmpNcLP0BuJEylGrsKu2pj2KUaf4SCflm3VQFwXy0yZQX5QHoEck/G39ZjmzRoQVXseBBEzYq3LVKc7PNNUq2RGDU+Om0ePRRUkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=m6upuPbL; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="m6upuPbL"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsbNb3922548;
	Thu, 18 Jun 2026 20:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=WpFtY/SEeE/IDAcsB87kMt5Fa/BJpedsd1tNJiXTXe4=; b=m6up
	uPbLB+Xb6RuO4w2rS2viUFZBe2FOEGEoY4iiJMohdF1rkwe1FCbX2Ef9RmOFtoYX
	omkhdjMx1uJOKZ8Ik+xzNAgxQhSTUJ2KUsDHKD1JP/877o0w0KZiUVpYbXqQc6Ca
	BLwIocpmhFp08ikOiY75xDEMfZI4BDk0iCrqRQwZHnA+ZIMOdeovcQrX/cTXxHXd
	Bvn9A9wXmBL7i/H7QY5kdS3DPLDkb3kPoJnIEm/4gNhSHjU745D7tGO0u+4iZ43e
	VrbUsZJIHncmKh9RM0uFS69pr12GBJTyKnqbnuHRUwxBQOFBb8UWzHp2wZveUTEs
	io6aZCGdkcclzmvZdA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ev4y0vfnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:11 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:10 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 02/27] scripts/sorttable: Remove unused write functions
Date: Thu, 18 Jun 2026 16:38:40 -0400
Message-ID: <5c94be5c724fa489a859761ff8adb42f5d9dec4d.1781814092.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX07wZVFEYt7EL
 69klF1caNpB99jAfeaoqTDfPrkIfyihM06qPYkCoQPtzWj4Md/IqnzcBuA2hzLm2ng08Dpopu70
 UYK7/H+uvDHujZf6tsrTfzsb5rawSdxbUD+OUlkm84M1kGjLiSresK1M4iYPg0NVJOW6QObz6wF
 QvKwMG3q//VZZNfHK4PKhPClli71eRHQKX5WE/b5fZ9AfoZLTVlgADByA+wGtu66EBGMS9eL/BM
 H0Jg8f4XS4VgVIeNVKnaiYVh8DFJQFTmH9HcFH+lBa4X9TAuJ7AtTeuKcgCv9LeTsfeHPYwtdHy
 iqMaKK8e5G4qrKoaIG6OH1URniGQsEpGD+VYLOpp2tULJ5C5kxgmqlr18TkJzlCHICjn0RzZt83
 b5+aAxwU52UIYzhg/nBQk/PTxIJdOn0u5O2mzLBpibiJwombUHXqCWb2ngZ4kdZdb2H7ar4TPuk
 CzLKDT6vTQkjIi9Ljbg==
X-Proofpoint-ORIG-GUID: VUelRW9gWNC0zrUhdvEUt4AE1b21rvDw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX++qixdAxcThR
 C5aQy65LosWnUyI148d9eVx45d2sinI2ffgzu6QKdue5xhZni7PPTigBtNKrSqgZWG7orgglHh4
 eUfxY1KAOVq6EpSC/u1jYamUmhHdjZ67eeRzR9VYEBJpIWFPYUWm
X-Authority-Analysis: v=2.4 cv=Ood/DS/t c=1 sm=1 tr=0 ts=6a34576f cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=j0sIkgseXk1JgBeDF2wA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: VUelRW9gWNC0zrUhdvEUt4AE1b21rvDw
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 4f48a28b37d594dab38092514a42ae9f4b781553 ]

The code of sorttable.h was copied from the recordmcount.h  which defined
various write functions for different sizes (2, 4, 8 byte lengths). But
sorttable only uses the 4 byte writes. Remove the extra versions as they
are not used.

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
Link: https://lore.kernel.org/20250105162344.314385504@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 83cdb843d..4dcdbf7a5 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -68,8 +68,6 @@ static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
 static void (*w)(uint32_t, uint32_t *);
-static void (*w2)(uint16_t, uint16_t *);
-static void (*w8)(uint64_t, uint64_t *);
 typedef void (*table_sort_t)(char *, int);
 
 /*
@@ -146,31 +144,11 @@ static void wbe(uint32_t val, uint32_t *x)
 	put_unaligned_be32(val, x);
 }
 
-static void w2be(uint16_t val, uint16_t *x)
-{
-	put_unaligned_be16(val, x);
-}
-
-static void w8be(uint64_t val, uint64_t *x)
-{
-	put_unaligned_be64(val, x);
-}
-
 static void wle(uint32_t val, uint32_t *x)
 {
 	put_unaligned_le32(val, x);
 }
 
-static void w2le(uint16_t val, uint16_t *x)
-{
-	put_unaligned_le16(val, x);
-}
-
-static void w8le(uint64_t val, uint64_t *x)
-{
-	put_unaligned_le64(val, x);
-}
-
 /*
  * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
  * the way to -256..-1, to avoid conflicting with real section
@@ -277,16 +255,12 @@ static int do_file(char const *const fname, void *addr)
 		r2	= r2le;
 		r8	= r8le;
 		w	= wle;
-		w2	= w2le;
-		w8	= w8le;
 		break;
 	case ELFDATA2MSB:
 		r	= rbe;
 		r2	= r2be;
 		r8	= r8be;
 		w	= wbe;
-		w2	= w2be;
-		w8	= w8be;
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
-- 
2.34.1

