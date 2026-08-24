Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A53EF649
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562229; cv=none; b=AekgycrM+0iE5/UDMRRNSwc8L/hkOg4yCiVbHUkhmu3zp+VPi55P9esCpMKsUIE6jSuipK0o/cdaJjI7ddb8Fr6cuDj017RXy5j31Icwu/kZ/7VAF+49gT6k1MMQmWiHpCkfke+mmvfwBrwJ1pPRYHVR1JQEEa1e9YpB1ELV6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562229; c=relaxed/simple;
	bh=MPoQp84nXC22s8TiMvn1SiJGBBw2acTM/YjZ8Yfnx74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DyvLG0V0/+F8/7XZ6MChsM3gP6d1028PTaqWUYTWSjzWNwgPW2hbhRJ6J+zguuRb8f3Jb3Bmwy/KxIa66JXRvpnKEk9vuOkOrZrzJwZGsn2jVe9widrwnZq9EUY9IDt0NrK6yZ6hK/tuqGZnIi97+kq2K1u16p2NLZpNOkAYFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b1716ebe9f9a11f19a56ed5b684f684d-20260824
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:fe853288-cc28-4332-8662-063225142fe6,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:fe853288-cc28-4332-8662-063225142fe6,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:1a0d1b027df4062cf9ff8020c3ccf467,BulkI
	D:260824170340422JT2AE,BulkQuantity:0,SF:17|19|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b1716ebe9f9a11f19a56ed5b684f684d-20260824
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 30365961; Mon, 24 Aug 2026 17:03:37 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: 1085273969@qq.com
Cc: Wang Yan <wangyan01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] perf powerpc-vpadtl: Validate dispatch/preempt reason indices before array access
Date: Mon, 24 Aug 2026 17:03:14 +0800
Message-Id: <20260824090314.1089307-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

powerpc_vpadtl_dump() indexes the dispatch_reasons[11] and
preempt_reasons[10] string arrays using the u8 fields
dtl->dispatch_reason and dtl->preempt_reason taken directly from the
untrusted auxtrace payload.  A crafted perf.data file can set either
field to a value that exceeds the array bounds, causing an
out-of-bounds read of a const char * pointer that is then passed to
printf("%s").

Bound the indices with ARRAY_SIZE() and fall back to "unknown" when
they are out of range, following the same defensive pattern used in
amd-sample-raw.c for data_src_str[].

Fixes: c4bbd4ec2e50 ("perf powerpc: Process auxtrace events and display in 'perf report -D'")
Cc: stable@vger.kernel.org
Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/perf/util/powerpc-vpadtl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
index 710f3093f3f9..6be04fbcd6b7 100644
--- a/tools/perf/util/powerpc-vpadtl.c
+++ b/tools/perf/util/powerpc-vpadtl.c
@@ -113,8 +113,10 @@ static void powerpc_vpadtl_dump(struct powerpc_vpadtl *vpa __maybe_unused,
 			printf("dispatch_reason:%s, preempt_reason:%s, "
 					"enqueue_to_dispatch_time:%d, ready_to_enqueue_time:%d, "
 					"waiting_to_ready_time:%d\n",
-					dispatch_reasons[dtl->dispatch_reason],
-					preempt_reasons[dtl->preempt_reason],
+					dtl->dispatch_reason < ARRAY_SIZE(dispatch_reasons)
+						? dispatch_reasons[dtl->dispatch_reason] : "unknown",
+					dtl->preempt_reason < ARRAY_SIZE(preempt_reasons)
+						? preempt_reasons[dtl->preempt_reason] : "unknown",
 					be32_to_cpu(dtl->enqueue_to_dispatch_time),
 					be32_to_cpu(dtl->ready_to_enqueue_time),
 					be32_to_cpu(dtl->waiting_to_ready_time));
-- 
2.25.1

