Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3277C3491E1
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815189; cv=none; b=Y3gBMPEUl24Suiu7omEDfWjRnVsVD9BIB4fvKsL7HRHz1x+n4e03FAUvXuhALIUKbOFriP6ctOcoDqt43/cj/RZg+MzYN1+VRky7W/zJ14YQBQhCJZhMaZuPeFipQiaEfQ18TLB2RvKguqmmUCd60X4tdireS60dFpmLU2mmDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815189; c=relaxed/simple;
	bh=+ELlO/zDo09CCAc+8RqE/3jj6RRPlKAIpdazWmZKLMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUPSZ+OlmYz47vx8mt3kxjrqwIgLLsGIgJEWQOhRn+EimSE7MPqQf1FjhJ1pYhAdyxtZRal84rSBiXBXpqDU5TC8TUYJFqgrocRog7UowsZ+ZvbHyoUsX5EVDGMyKB3rCjOi/Sdd3xo6Gt4nmmfKAMdoeqFLRLxjycPB8QXICtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ZDTlip6f; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ZDTlip6f"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIshbn3939656;
	Thu, 18 Jun 2026 20:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=2ifpJ0sfw1yhLXuaFXAdGM1j3w3q2Cg12ziuwXOzWWE=; b=ZDTl
	ip6fH6WTDSnfbeS8I3g12qfewZSvrflo7PnyvgnuZLjC8rPHfUiQ1UKkrfl+mqIF
	AmO/6IIBfTR23IZNQT2udvstCTB8iasyImPEylUyvX2OAtzPYQP9PRpVy20CXxsJ
	HoKHjUXKaJcjbvMN9/P0E5YNFQI6S+6cV84BX6URRQlmG5bvWyarJrzXXqLvEoWv
	nLtXNPT2tk25bnNNEYYRhRftiaW64L5/s9zIQJVMFooVg14qr/wR4N8DoCNAMtdR
	DpebZnqncrHVZvNufPREIeZ0vlhxNlWoV+8Cgso2j0qhwL+cb9eqp9VY1aRgGdul
	qaWl1ZvjJMMatjw2xQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev5c6v1cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:43 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:40 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 27/27] scripts/sorttable: Fix endianness handling in build-time mcount sort
Date: Thu, 18 Jun 2026 16:39:05 -0400
Message-ID: <40e18ce8560e09cbc617451d9bc70586a8e013e2.1781814167.git.andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=Eez4hvmC c=1 sm=1 tr=0 ts=6a34578f cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=sCAmtXjBCdk1NZRw0HUA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: v8cxUKHWanZdWtQfB8zkENpnjB5cZ1sL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX39lAGhOXb28A
 wY2fAYAPmaPpJh0OZnyyC17aMgKuFrjZsIByMK+bHt7LFV4l6H5fDqfFwoH2o1y4JAbj/912fXk
 Eaf7zAabJh8ewLkPbreX7e6YHlGaqsZatWyc2q4wQMjXkXkCfJx1
X-Proofpoint-ORIG-GUID: v8cxUKHWanZdWtQfB8zkENpnjB5cZ1sL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfXz9zr21RbW5LF
 u6zlw8f+ODTb95JkqxRmN/Iu/JU9BPjMUuUm7TrfvuABEfgPGdC9Y3y19DIDSf3MhYrnpj8Mo2C
 LHoJahW8Y+oqji+dVeegSiuJHFLL03KHlNqgIZ/fyQ4CrnyPEUAP2DyeUDIL2Ein4J+Z0WO8Zxj
 vjYm8qSS++/MUDWebeN+ogddjY3cmegxWf2C8+K93tdn5x6Ib7z4EaREbrqMIv1BstpE0UtoCn8
 H87PLzvyeGJpfAKW50xj6HoaevlQn3NPuCUR4BPGlQMak7+cYy2imeeyqSs/f9nt3lSJFcdrL94
 kDe7FtPUQAxc+kwMBZc7MFIhW2sSlEokmLntVeHz9tAm88x02fHgIYx7Wdc9kGD5mkLa+8AdZiV
 d6yvFhcO5KS2MnjF1iqsczJAR1+iy8Wzl9ui0Nm3PldIBiJeqc+r1n3apdpMYBtFE9p+ihDzsKS
 EYpMxyVGJmJ2VPnrlkA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180189

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 023f124a64174c47e18340ded7e2a39b96eb9523 ]

Kernel cross-compilation with BUILDTIME_MCOUNT_SORT produces zeroed
mcount values if the build-host endianness does not match the ELF
file endianness.

The mcount values array is converted from ELF file
endianness to build-host endianness during initialization in
fill_relocs()/fill_addrs(). Avoid extra conversion of these values during
weak-function zeroing; otherwise, they do not match nm-parsed addresses
and all mcount values are zeroed out.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/patch.git-dca31444b0f1.your-ad-here.call-01743554658-ext-8692@work.hours
Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Closes: https://lore.kernel.org/all/your-ad-here.call-01743522822-ext-4975@work.hours/
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 7b4b3714b..deed676bf 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -857,7 +857,7 @@ static void *sort_mcount_loc(void *arg)
 		for (void *ptr = vals; ptr < vals + size; ptr += long_size) {
 			uint64_t key;
 
-			key = long_size == 4 ? r((uint32_t *)ptr) : r8((uint64_t *)ptr);
+			key = long_size == 4 ? *(uint32_t *)ptr : *(uint64_t *)ptr;
 			if (!find_func(key)) {
 				if (long_size == 4)
 					*(uint32_t *)ptr = 0;
-- 
2.34.1

