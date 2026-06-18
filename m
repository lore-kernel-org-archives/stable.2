Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D35279907
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813792; cv=none; b=qZniIuLIw1SbKY1uTrlCQq0JOnHEoOOnrYGiHukkXaibFvRKwC6kUKyZndwM1ANLSPsxtwx20dKjhK5NsYUFJSFkxCMXsEzD2T37IBt0dVDxxAvSi1oZZDk1UL3vZpLTxjNjYdgdBEwIOdi0sD1mPvNryqgiBysjMw2YFalp5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813792; c=relaxed/simple;
	bh=RrGkX0Q/IOJ+Ddyx2U9LLKPZWZ6c+tZ4TMSSl3A51h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWOU48QWmQ80PGMo1XKr37e88jy0T+hGwzfqrXKHXkWu4WVdr09FoG+BnVc+t5FGKj0wsNfGN7C2H0+CXRoyrp2EaWmR3wAdYz+zMIeUMsEiJ324+jDJue+f7QPrl2EeFW8/2wEMK6hzwvyCk3DlSlAcSbAuh19grG5HU4W0VJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Bceh3c75; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Bceh3c75"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIscCj3950445;
	Thu, 18 Jun 2026 20:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=BYZ4EfNF5JWLxQpfhioImF8/Am0n2Avt9qYr/jWGoDk=; b=Bceh
	3c75xI3p2Nqg1BM+K3R5/pDj24zebP2gaOTkFDCBNCTNi4tj2mu+L5nWD+1hoVBJ
	gACFhfMQuxuZirAzpILH6PKVVbKYF5NzrzO2RkfIAaDCH3v+6X1m95lMAHszTgRW
	/JbwZwJo2xv2w8p8/tDNUtaLBJabMAdJ673REAYr2D/Zxtl8r5K77D5XFcB+Rijb
	eTw+dhuOY8rk4i6QrvmcMOyplXd/e0HMdAFBy4pw7MTJp4uKbZS89L+SKCimRdlj
	K6VTDdCjBIdRrmrk6cZppAdZI3jlJATvIFKzzKgErR6Xrrwg2p+g40i5SREbYtP5
	TjSYzxHp6KUm1EXn3A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4evd10aqmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:25 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:19 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 26/27] scripts/sorttable: Allow matches to functions before function entry
Date: Thu, 18 Jun 2026 16:15:40 -0400
Message-ID: <7b17ef2d6c2be58e80c028343547c67c81de3d56.1781809987.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX1NLM6C1TPTb7
 fkrQLyyYZ60ohxCEunuYRqJeHiqu4+tpXXWFbOy0hxiwVCSaBoSS9SUWi0OIayC9Skq1ZzfSKOK
 y7v1xEOj0Zhe6R2e3oH0iCbY4o66hETMZezuCKYmOLvkeTcQwJefJC/PZfOpF7W63Ky6Tq93081
 JPPVLlUi71PzpLbBFk+y7JKVKX9lPfX73VFzV4tY29llFFsgkQUzJbUch8yoydYEWQF5S/EyiVS
 3ROBqM2rmxuKrHWBgF4BIXowSw2VXt84TOEIOxbO68Y6S3XNsOzDX1f4wRXpjEdDV4osD6vpsDk
 B7L0tRJdrTbnM8xko5/zBYCmI9wvC6Xiy9ISX9RbPu8kVjSDdD9CXAPcnGCLsl8tLff3vqUaqLT
 dZHfi9O5LBXz65+/qx20cp42RknByuW2fRtA9sEpFJvHUtfJf7TBiNaPnCCtJnO0+ZfHaEZrCNg
 K/wgI7ViG3APA8+EdJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX+JMNUZaaqchk
 7KnwRsjUXpeyYn75t0hkcW6T6ctASrtrE7/CxRauZ+f6R3jT7Jl/NRTFURsSkzB2IGfGWjQB0/G
 UygVevylHk0I3WrDp4uV8RnVYvedI9PQdERXRieY0mt90OqIdRxS
X-Proofpoint-ORIG-GUID: oVlGkvmxMjq5I1ZaHhmCBI23lo8RRFRt
X-Proofpoint-GUID: oVlGkvmxMjq5I1ZaHhmCBI23lo8RRFRt
X-Authority-Analysis: v=2.4 cv=L7UtheT8 c=1 sm=1 tr=0 ts=6a345219 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=pl6vuDidAAAA:8 a=4WZL3LEvc1D0hVjtaDEA:9 a=2JgSa4NbpEOStq-L5dxp:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180186

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit dc208c69c033d3caba0509da1ae065d2b5ff165f ]

ARM 64 uses -fpatchable-function-entry=4,2 which adds padding before the
function and the addresses in the mcount_loc point there instead of the
function entry that is returned by nm. In order to find a function from nm
to make sure it's not an unused weak function, the entries in the
mcount_loc section needs to match the entries from nm. Since it can be an
instruction before the entry, add a before_func variable that ARM 64 can
set to 8, and if the mcount_loc entry is within 8 bytes of the nm function
entry, then it will be considered a match.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: "Arnd Bergmann" <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/20250225182054.815536219@goodmis.org
Fixes: ef378c3b82338 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 07ad8116b..7b4b3714b 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -611,13 +611,16 @@ static int add_field(uint64_t addr, uint64_t size)
 	return 0;
 }
 
+/* Used for when mcount/fentry is before the function entry */
+static int before_func;
+
 /* Only return match if the address lies inside the function size */
 static int cmp_func_addr(const void *K, const void *A)
 {
 	uint64_t key = *(const uint64_t *)K;
 	const struct func_info *a = A;
 
-	if (key < a->addr)
+	if (key + before_func < a->addr)
 		return -1;
 	return key >= a->addr + a->size;
 }
@@ -1253,6 +1256,8 @@ static int do_file(char const *const fname, void *addr)
 #ifdef MCOUNT_SORT_ENABLED
 		sort_reloc = true;
 		rela_type = 0x403;
+		/* arm64 uses patchable function entry placing before function */
+		before_func = 8;
 #endif
 		/* fallthrough */
 	case EM_386:
-- 
2.34.1

