Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648228C037
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813783; cv=none; b=LejGgOznbULb4pae1f8Npm3NMRSTSQylP8YbNODTVv4OKufmbTxCsQKUOM4WmPG7c7QdvOUeO4nBkoArOjmef6615rFwF4wyCd6WykImBKRK4qsL1hF9taHlNpOz1ZOE5Z5aN+tzjrhqckd6oKE1EgN7awj/M6LkMZehLCE/iBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813783; c=relaxed/simple;
	bh=tAThrAZ+qbhYgy7uFxy9r9kkFEoBw53/anpk9h9Hqmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bae5jIrg6KqeC3pVnteX/ZTm9HrZ3fAyGt5Uam0Er6NIvIBg7LU8RitEUrT6EhXA37OZFBVK0wh4QxIMHXfSySdk8VaqK7JpZ/whvETeAk7ATFJH0UlPifMOGD4vs8N2O2Oclum8MVEAdFkEtq2HZnf2oEYtAisEajjuNilOcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ChLXBHqD; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ChLXBHqD"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsenJ3922713;
	Thu, 18 Jun 2026 20:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=klQnv0ruxI4P8WLEJAfWOvmM1hDP78jgx4l1LvSJ4F4=; b=ChLX
	BHqDec0I5nietMCnwgoguMgWoAHz0gcmtq2uKx1j1+p/60g5DzSRv1CS1RF6E0qT
	PUBpFOli/Ph27CCRi39+33I4WPi/xGUJA9pYzgR2NuEs0DkWspMOFaPVEZV6A3Eb
	6GFXfz3eOdTVnjGK8v6N2ErGbbiQCrQmEmZV2l0xxl2qt/585mpRDHq9/TiR2Olq
	SWg/waU33nLgedDebMUj/BGKX6uSsTU372T2FDxuAkRY2NDOcY7wCGdn0FFpmwZx
	SdNsrqg5EKvmNqqWnC3u9QHDV34T4dgC/NhdMgnXM6Cm1iA7/CmY7o1s6D2dubkg
	2P3LTKh9K9jpuonKsA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ev4y0vc6x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:16:17 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:16:15 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 23/27] ftrace: Test mcount_loc addr before calling ftrace_call_addr()
Date: Thu, 18 Jun 2026 16:15:37 -0400
Message-ID: <0e6f0c263a1c1b93f1fa6ae5310225e1e7300cde.1781809979.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX5nLqYl+MoklG
 KGNFbaCjehYn76x4amYHfJ6xjMS1Go37RutMZnzAakUI93Wk7Q+QjundEOX769P6XuU7Aer+v/0
 aDg2tvPPVKgAmed5TGbujBQdD/ExNlw+hG//TKzAmgaKeFyG18I3+fRIRvsyJALORVmKWgEcvKd
 k/xGlFdqd59+Y+/cp7Bla+cvJ/Z0mI5c/UxEJyLF8cTwVGM86nBHbeQQU6T6+lCEX6hqxAs9Nj/
 Ge8CBpw6QQdIJX7vD3KtrKBX8ry/xdHtbKxpXsNxn8e3Oll6ruO1H0K8IGidu/w8CRhXdxotnwh
 O7BpO1+BLK2CYHptyl87bP6fvEasNXF7cLacLoRRkjmsB4jNLkHMwroDMEUe7MXs3Kr9CGbRqjC
 6kSNFMdAilYfxw8/EG9JJb1r0VSriyWpknNd0uNVNIK1VPk62rNzTyKk0AU/CN5lctnMr3Du59E
 S+shvL0+Msp49jkKmsw==
X-Proofpoint-ORIG-GUID: H9j8cJi6McZ0DKBpwULy9OklMTnGVnzS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX7b2sGvNWYCWR
 2F0/jKb4HoSlqwanf3e/rXpKz32tpEwi/4u7BcgC8sZwFB2WRcrYwDaWUuF3Avb9kZBi8GDoWbw
 4zYMiYxU6pB7iN7KJH0iEVtcLTvW4dpntZOonkgwU3+CbsBrwi3f
X-Authority-Analysis: v=2.4 cv=Ood/DS/t c=1 sm=1 tr=0 ts=6a345211 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=ZLGELXoPAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8
 a=Z4Rwk6OoAAAA:8 a=pl6vuDidAAAA:8 a=kwWuUCD-8qkKE_sjJmEA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=CFiPc5v16LZhaT-MVE1c:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=jhqOcbufqs7Y1TYCrUUU:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: H9j8cJi6McZ0DKBpwULy9OklMTnGVnzS
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180186

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
index e9965665a..842e57498 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7108,7 +7108,9 @@ static int ftrace_process_locs(struct module *mod,
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
@@ -7120,6 +7122,8 @@ static int ftrace_process_locs(struct module *mod,
 			continue;
 		}
 
+		addr = ftrace_call_adjust(addr);
+
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
 			/* We should have allocated enough */
-- 
2.34.1

