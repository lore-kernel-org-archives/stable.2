Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0917A30A
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815186; cv=none; b=ClNbbiT1G5WXJ3MgWy8eT80ku4UNblh/8iSE5Pt5BhlBZ2JPNAzRDo9XZfLZ6IgNtVGDUTEuZStvUcxLDqaRLDeBxNgbkEUZ0Bd31u91rZyY+3GEV56vF7QVWWqn/OOHsKViA139JhqQS9qzxrGNjbqWt1HOtCfIeeb8H+Fd0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815186; c=relaxed/simple;
	bh=kfnqe/Q3n5Ao6z/QZ0jgr+jJyQOiivIWFH4FIdLoY6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwFE1QYlJotinaMmqCWo9BrLuZA7e1rh3ca0guvliobdu+iENF+FZxrA320iqlrLRXneM88F/wbCHp3tgZW+nRA868/5di7wIfqNXI9ikD0sHvLOhgf6N+mz+indQv1yjO10cCTQg094zxDtzgR73YRCjNh3IqlhrLoCgiICYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=cF6NCUaC; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="cF6NCUaC"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsfnx3939470;
	Thu, 18 Jun 2026 20:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=WSNXWlACFA4qdSGtwx0yCKg9+/GfhpAcD7LSpktqnLE=; b=cF6N
	CUaCr4uodAPZ8eo6iDvGomG80WBrDopNFd03ULYyISWFNeSGNjhayRFSQ2zVv3uH
	vJTL5yuKLtxTh2iR9kJEX7CPzhskYBVp9L8VOK2/3l5fjn45piOVdL220CUQ5PMa
	mh6Y2hQUp77hgsCCR660psLj5pRbYUgYOKev6KPWW0/OovhlFpToH76ZvORM+mfu
	IRWsloZ1eJsYQVeYoBWlNxgzUZgx5Keuqn/GksyOwNI1XJ+aybSHiof4+QWC86Vr
	xW8DLSugh5f+7dfewsZNwBLK7UMuTXwYd26NZ39Z8Ux1kgWUDTQuwwUySlrl1mHq
	fFe02lpwzEuC4bql3Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev5c6v1ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:39 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:38 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 25/27] scripts/sorttable: Use normal sort if theres no relocs in the mcount section
Date: Thu, 18 Jun 2026 16:39:03 -0400
Message-ID: <5daea8fc47fe65aa9f94a6e7934be6b635df9c6a.1781814162.git.andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=Eez4hvmC c=1 sm=1 tr=0 ts=6a34578b cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=ZLGELXoPAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8
 a=Z4Rwk6OoAAAA:8 a=pl6vuDidAAAA:8 a=QEzrOnKiztfUOB_tiXIA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=CFiPc5v16LZhaT-MVE1c:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=jhqOcbufqs7Y1TYCrUUU:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: 7mHXtDj8TO42e80eOBiKCwuT0IsWo2Yl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX8aslkm91tiRh
 RbVroKjHlV8+WhfSpbaVRekkFoB2Yqh9OSLx1I3cWf9WgR5tCi3wJbMjP7c+dy2j0JBHUkpZiy0
 ldwPwpNKJjWH1oYMio/c9G5TcvrX2EwE26I/1zcZY6tb52bQrbsO
X-Proofpoint-ORIG-GUID: 7mHXtDj8TO42e80eOBiKCwuT0IsWo2Yl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX18H60jb5fCu5
 p9VF++0VwXAGtY+7fmVzc9Dd+woUpbozO6zHGL/Oc59X8Gnch7YKVuvdqTMQxuhpvUpJT7Snq1N
 jY5ezrxKkJUOin77TaSOWuuH0E1pipdpVXex9Rk3Hg1I1Wj5RUnw83YgRqgnbAXr13oH1oZmLVz
 UDJmsDyiDVjz3nRP/wIvvd7GmyEmZDuFzM16lHe9i8yAUku7mJH8eGGss31q9lA5OQZFJhKHlbZ
 I3R82hQ5RhmbgZrFcSwfHyAX8l2V9fxDTp0JIS2EHM5z44Q+dEe19l5XOwApFNEuVEdVofqmft4
 nk2qjqzHOM5xUfpSAII6L7s/592+fIHsJ8FX6gBjOBwyFiLz+LEnUJLzZYmM0eJL5t+hF6hWyF9
 wNrM4q6ciphNUwZ/vvWoz1uRuskNNxKn2oEapHqaDrXAHGckT4FhJEeDZJUp/xzuYDv7c/10Gut
 DMRyXNLQhaun6UzaHzg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180189

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 46514b3c2c17c67cefe84b0c1a59e0aaf6093131 ]

When ARM 64 is compiled with gcc, the mcount_loc section will be filled
with zeros and the addresses will be located in the Elf_Rela sections. To
sort the mcount_loc section, the addresses from the Elf_Rela need to be
placed into an array and that is sorted.

But when ARM 64 is compiled with clang, it does it the same way as other
architectures and leaves the addresses as is in the mcount_loc section.

To handle both cases, ARM 64 will first try to sort the Elf_Rela section,
and if it doesn't find any functions, it will then fall back to the
sorting of the addresses in the mcount_loc section itself.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/20250225182054.648398403@goodmis.org
Fixes: b3d09d06e052 ("arm64: scripts/sorttable: Implement sorting mcount_loc at boot for arm64")
Reported-by: "Arnd Bergmann" <arnd@arndb.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/893cd8f1-8585-4d25-bf0f-4197bf872465@app.fastmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 23c7e0e6c..07ad8116b 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -827,9 +827,14 @@ static void *sort_mcount_loc(void *arg)
 		pthread_exit(m_err);
 	}
 
-	if (sort_reloc)
+	if (sort_reloc) {
 		count = fill_relocs(vals, size, ehdr, emloc->start_mcount_loc);
-	else
+		/* gcc may use relocs to save the addresses, but clang does not. */
+		if (!count) {
+			count = fill_addrs(vals, size, start_loc);
+			sort_reloc = 0;
+		}
+	} else
 		count = fill_addrs(vals, size, start_loc);
 
 	if (count < 0) {
-- 
2.34.1

