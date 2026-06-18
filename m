Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20434F27F
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815187; cv=none; b=aNe0+4zzjP9Zr88zZVf//Ydv21IGOdYcNjanI9ofJCzk2GK06nN68T4GWtf++EA/tJ7rzN1jPVzmF5gH7Erd7eZrNDDnA+TBQZaFOjS8pfaHck9Jl60rUWV26zF4ypZ2ibyL7msTR2uFxSyhs9IMXcdAJNafXMCX+la5AQM6RHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815187; c=relaxed/simple;
	bh=RrGkX0Q/IOJ+Ddyx2U9LLKPZWZ6c+tZ4TMSSl3A51h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+gLMYl5FZ80rzGsUNropHOSJXsSxkXqg3b4ejAelmB44mJhzEZbdXYhHPdKw/6GYaF9V5ublZH/3Aqi//V2JTUopZYYgNkGS01vTuvK5rTABf3max2dDUt1MuiDhia8Cf3DbECk20upy2m2T3IfmdZpIeIXNQSLo7p8ZJAEUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=BGPgik81; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="BGPgik81"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiJcP4006116;
	Thu, 18 Jun 2026 20:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=BYZ4EfNF5JWLxQpfhioImF8/Am0n2Avt9qYr/jWGoDk=; b=BGPg
	ik81qYe6/+Y29V54k4IvTNX97fD//ih3qTK1saW4MHoJnjMD+w+5IdERD39DjWPX
	BnkZMbHNVzQ+p/pBYWiS3fkO/Rr/nWjeW3I/p6WnYLVBXe745Z6oRSW8lDaEN2qA
	f0DbwLicAXhITcIwv9caa2ryzXnBXzoIBCCjqqH3sRQ06jJz1P8fGMJWrgTuSn6A
	cFEhMH/w4nG6uvoK0UJKuq/4ISoIoQIf2/J7Bu79edrCKqcmhdDJhAzChe5e5KhO
	DEa6F3/q5CmXoH79xRVEL6S9L+mbSdQzMML6sMjGUw3fjniyL8a8hlIzMEpPEPUJ
	iTdqarweQhpsz4n2tQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3jg80k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:40 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:39 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 26/27] scripts/sorttable: Allow matches to functions before function entry
Date: Thu, 18 Jun 2026 16:39:04 -0400
Message-ID: <34a497333bb2c39b88c4b6e2dbf4ed63f28e846f.1781814165.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX+436YqAUt+u2
 m+zvktbFEn4RAX7FNpxQy+uUCEzX6pJKm90DZ2mmxvCRA5UcSGw0vsAOIDCjTfWh527+rbNF2vf
 dQC1551mF8J6+CKiclbj6aodOKLI5ERygD3drClrfpws0eAU7ZUT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfXzjz2Bphm6eBw
 QZoAwyZcew7liTGfrhNIxbDrWZkKGS52JXyv+aIRvD7fkYSYVcri6Csw+iB4WGg3AtLgQZCsm2I
 fp5CW42P4aHK2dKODirEi/tc6UketWlkPbtbRVijD7T3NEN0u5Xia9yYFxfRwN97g23gZ47du1/
 +3cYdyk7ljU213BGLDppc9wJd6bQXLtVzXpM4JGkSKmmFQwXrcdGQa0+MSi7JWwejeP/al88oU/
 f+5eLv0Kirc04C3RHOs7DWCGjJpiXzcL369KS16jEZ4tIalb0/ZLLcezoVI5XtvNl6dpB+ffacn
 eFrq8T2gN1oXtvcdbTmYO064kwR4HuW+nLHsYGTvmCxxN9W4QGxbDrzORPfm60a+ZcEecqp2DEN
 kfm3J9ZkoBe6HadhVQP0WLQ41iv4bfAfD6FTMuIn9RImi0iCuDNwPMxs/CjhGOFRCFZ3AsLLN1f
 8L3+3fl8UyRg00bAKHg==
X-Proofpoint-ORIG-GUID: 1kd1oA9_fq6TFAWtC7BQoOx4pXkwypst
X-Proofpoint-GUID: 1kd1oA9_fq6TFAWtC7BQoOx4pXkwypst
X-Authority-Analysis: v=2.4 cv=AvLeGu9P c=1 sm=1 tr=0 ts=6a34578d cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=pl6vuDidAAAA:8 a=4WZL3LEvc1D0hVjtaDEA:9 a=2JgSa4NbpEOStq-L5dxp:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189

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

