Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716EF30E827
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815184; cv=none; b=UiB17sbn/HlJTkDu2kp37Qhen4cX3hfZx9o206atoruhndJOTy49YpgY+zUbnrH91GSokElpqkAeDFgt8P4DqM5KJGdcUlnmjBLLoNFhaKH7qmltSLocJC5TGhKZN++zt1rbAYEfR8c/DWgcpz02fesb0PJOOKzokFO0EpDPcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815184; c=relaxed/simple;
	bh=p2VDrN5sMrN1Dwga47Swfs3Xdy8fHJeQ0NPtZ2TAFAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amFuLIY08gQtry5JqaFc1FaGXqOrUNZLaTQrzHmE+klnFTX/BWjmeyZVFOCFAVY/TprPUyy8Oo5xCUnlCZYftJJ79d8dM6mfhF08K2qPVNSHnHcodnS4JbIkin2DoAA3jSyKv+iMo34BQEpSL9h5Rbi36Z3vN87e66+ptk4pb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=x+4VQQyV; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="x+4VQQyV"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiE444006057;
	Thu, 18 Jun 2026 20:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=NWmzQvHaFiXU5W+I5/m9huYaLV38KKUIbr7gKKaVMUk=; b=x+4V
	QQyVBi8z7F+R+ATMB36ueyUlJ++j/qu/BibxA6tNkI7knlihj/LSfl7OJANwl5WI
	B+5i6wAGhbAkCQr60/J+RVyRte36wLDxLap7SPe6jLHXtX5zjlGEbzuWJD0mHceo
	FwyiRnmfZpwgsvyEUrD2uJPPpnkuzKBbEnNJ21vLdbSbFrsDasYUclJUPVopvazi
	okdciU9mRYv+PIo558gl4zq9MvuBn7SLEandWEAJlbNOf3LfijCnVgIoYipLu7n+
	eBppgfmfKETEzW5GOx9Nk28mKSivIvcR/8q3ItxgpRcoV3VwJ32+zXkcgF9tewYa
	Pj/454YoQgeLscve5g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3jg806-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:37 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:35 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 23/27] ftrace: Test mcount_loc addr before calling ftrace_call_addr()
Date: Thu, 18 Jun 2026 16:39:01 -0400
Message-ID: <d47269631ff8a80528dff03b2e80583e8cf10e19.1781814157.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX+3n6GqRRyf0C
 4HPKhDHOkiBz7ZYz7SKsJ4TbI9K1caD3KXKKog+OfQalgr9qyiAA0cRYCGtVhbTMMVmFkqy2cfi
 ZovS6e5IsfePicX96rBrlPSG0Z99c3GGuCBVVz8I+h/B9LPRzWxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX6dr5WfnHTlhT
 wTyGmSuKHQuZYmMrhmqDucLSgKv9LCyUS5FJ88aBAiE5ln/hxRRQzaXF3quqdTpwh3Jt0AModmL
 xkMBHTnwcChgqMMAqytTUOS1X+pJ6MZ0azErB92sA/lM3UWI9ZQgy/h/GL3hbziWKHa3zimfoxg
 +q30a2RptndFvnhvXcSr3iS6+HTjQi1T7Y3xu2xeDxnpbsvNpLEDu+fKnZCC4VPYgHEN0Qz7dTG
 5zFcjEyQpOU+PEAGpT10kDgpK0T5M/yj/wbU9QDVGvzToQiPUUFnhC3AY1L2x93CH7PNUcndq3u
 eIwtMF5t9MQqBlJBMPrB731Bt4GGkTWwW5g0lI/Olr37lpsPLJYTY/MaGp9JfqDcEBob9hpzm0j
 AyAUaRghtxeY7WAuwClzBTs5P0KVrCHusDKcCBZqcQLKOg9/+zsIoumltnke172AJ5Akbq2Ps3r
 c16XetZhu0wF5BF606Q==
X-Proofpoint-ORIG-GUID: FC0-lQPA0xN4CHws4EtXEIiJCRagTRe_
X-Proofpoint-GUID: FC0-lQPA0xN4CHws4EtXEIiJCRagTRe_
X-Authority-Analysis: v=2.4 cv=AvLeGu9P c=1 sm=1 tr=0 ts=6a34578a cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=ZLGELXoPAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8
 a=Z4Rwk6OoAAAA:8 a=pl6vuDidAAAA:8 a=kwWuUCD-8qkKE_sjJmEA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=CFiPc5v16LZhaT-MVE1c:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=jhqOcbufqs7Y1TYCrUUU:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 6eeca746fa5f1dd03c6ee05cb03f5eb1ddda1c81 ]

The addresses in the mcount_loc can be zeroed and then moved by KASLR
making them invalid addresses. ftrace_call_addr() for ARM 64 expects a
valid address to kernel text. If the addr read from the mcount_loc section
is invalid, it must not call ftrace_call_addr(). Move the addr check
before calling ftrace_call_addr() in ftrace_process_locs().

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/20250225182054.290128736@goodmis.org
Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: "Arnd Bergmann" <arnd@arndb.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20250225025631.GA271248@ax162/
Closes: https://lore.kernel.org/all/91523154-072b-437b-bbdc-0b70e9783fd0@app.fastmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/ftrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c8ae58c41..6635455cd 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6585,7 +6585,9 @@ static int ftrace_process_locs(struct module *mod,
 	pg = start_pg;
 	while (p < end) {
 		unsigned long end_offset;
-		addr = ftrace_call_adjust(*p++);
+
+		addr = *p++;
+
 		/*
 		 * Some architecture linkers will pad between
 		 * the different mcount_loc sections of different
@@ -6597,6 +6599,8 @@ static int ftrace_process_locs(struct module *mod,
 			continue;
 		}
 
+		addr = ftrace_call_adjust(addr);
+
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
 			/* We should have allocated enough */
-- 
2.34.1

