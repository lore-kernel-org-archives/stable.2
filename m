Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2052D0605
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815329; cv=none; b=dlWILqE6vaDW0uHkTM8BL4Gz03KRY9riovsI29whW3QZl/Y/KHTEGCEOU+Kp9rjh23pUxkdhfrs5n2Lslwivg4MT389S+GR24D19UFCnNYe7NHpZpeQb92IqfYSkq6Y01vNQO51tl6EecjLzLl+hyRBw+EN8AizsFOebkDrWF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815329; c=relaxed/simple;
	bh=9rLYG1gJsinzpYSvBZuHOeFPMTgjam1YoY5VVfQFVGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQX7husMKlNBGva+DHSTMgPNYCyy7lxnfwkVIlSdHKGNInOtSFaNGbcSHijTIV/IEaFt7AdCHZshKl3POqx1MvJyb4t6ldgQFRu1N7FxObSEjnIAFSZ+fOj6AVzOqaSo4UK2QNDOOD9lgsuxiGkwSUMw3egDID2ZNG1GA4gPebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=FyrwXofd; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="FyrwXofd"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsc323987653;
	Thu, 18 Jun 2026 20:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ls9nTPmrQlx5Okf2YFflw7H2OCAams0lLg1U8EMSNTQ=; b=Fyrw
	XofdJ//DV4fBeBfAG8BfpQcNh6dme8+fYOmqZn7mzr4hExdUZtugotxqI6mX2eYs
	qv93c9BSXvExHZpgvk7CPoGSEGMY+p7Ulhimb049DswRlFc8qavSV7fYcMd6LLIo
	TEJennT1Xnonej+GPVSi5UZrFE4PNkZk8ibpEP95w3D4iMrEORZ/ut2IE4gjkrIL
	EO1ajIRalTbMqFKgRiiGFlNK1f0OrO9brJ0gwz5f8SVYC8OaYxQyra3fbcwHiUKP
	7M4NcCyObxhQmqF3g/KJeOaN65yb5pcXyERc+cJQobgZzr8IrWjoZZYA/XBZp8Uo
	Qses2teLk7f0A+sjZg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev4w5uysr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:15:51 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:15:49 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 04/27] scripts/sorttable: Have the ORC code use the _r() functions to read
Date: Thu, 18 Jun 2026 16:15:18 -0400
Message-ID: <8192a8bd228bb0d727a7c048b2ec034f9e9ccc8b.1781809920.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfXxQDAPadGwfnp
 UVx2RkR3Gao/QYu1yuqlRTaajQAyKc0LlEQIQieZn1fnsM3aB/tpTvLS/Io0wl9m7IFAq9mM8eW
 buk+EfvFGkkqt71HSiiYKduxEOWcqMucBX4P3ojGQcvxbvrum9RphZnm8QGGkkjSHguX0wuDgn0
 agynLJRvHXp7o4DovVC5ve5WNNoe42i2lcXso2yzw80xJzgideJlTxfjLvGP/S7wbSkMtyHr/jJ
 k2qPZLcEwKtT1/lZCC2lCvjw+OcmAvQOKC/8XJ3b8iIByGPHteM05h0Dc+NP8nUGPXFTbU6SPbn
 4FSm/fsfz3wCTYYQ7lpLt0gha5FKIwZyu+Dj8o/B9OLSPhkSecjIOpPt8DzniV1SXfRCH3hBBVq
 oP5CECu5GERJKssuxe8prT5XIR/SNhOemPC00g4jKAAncDhnSYkXDD3tCOH3ZjPOZpN8syBR7oR
 4z67vsx95xJu6FbzHiA==
X-Authority-Analysis: v=2.4 cv=JtDBas4C c=1 sm=1 tr=0 ts=6a3451f7 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=wzDLvsUvY-im7TRT:21 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22
 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8
 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8
 a=pl6vuDidAAAA:8 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=GGcVmEvbB2xf_gawNiMA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: FYPNC8j7lwsAU9SP1msvtRNJpLIhExaq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX/pgUbTLcsTtL
 Zi5+E0/eYw/Pkm/dZ7jPs0ppqliwcFXmpUHUjFL6z1u31o45zcLs3lFzkdqdfyGrmJxjznmspZl
 bb9yGvjFhcn1I3PnD9woK1R/kJlnYPvpK93E7D1kIjXmiADWK4gH
X-Proofpoint-GUID: FYPNC8j7lwsAU9SP1msvtRNJpLIhExaq
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180185

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 66990c003306c240d570b3ba274ec4f68cf18c91 ]

The ORC code reads the section information directly from the file. This
currently works because the default read function is for 64bit little
endian machines. But if for some reason that ever changes, this will
break. Instead of having a surprise breakage, use the _r() functions that
will read the values from the file properly.

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
Link: https://lore.kernel.org/20250105162344.721480386@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 18d07fdb2..58f7ab5f5 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -299,14 +299,14 @@ static int do_sort(Elf_Ehdr *ehdr,
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
-			orc_ip_size = s->sh_size;
+			orc_ip_size = _r(&s->sh_size);
 			g_orc_ip_table = (int *)((void *)ehdr +
-						   s->sh_offset);
+						   _r(&s->sh_offset));
 		}
 		if (!strcmp(secstrings + idx, ".orc_unwind")) {
-			orc_size = s->sh_size;
+			orc_size = _r(&s->sh_size);
 			g_orc_table = (struct orc_entry *)((void *)ehdr +
-							     s->sh_offset);
+							     _r(&s->sh_offset));
 		}
 #endif
 	} /* for loop */
-- 
2.34.1

