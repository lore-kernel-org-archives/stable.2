Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82A2E2EEE
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539522; cv=none; b=ePOlhgmPxEUJ+6Wkh92NAWMLqz00uBdhQyeSreEZwNpDaUHwG+yinPQbHdjr1DjySTKL7tCb7R6HHgnKtxx/TNHfAcy1JxMKN9LE6HUdV4NZ89jOdn2DNY7a+no1OVq7+11l/KEAY924JzIPwXXmL3dRp8BrveeocLC++eola5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539522; c=relaxed/simple;
	bh=ODVpY1t/Lvspb3t4vlIg3/vW4pKI02Q+9aD106P0bck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ClnxVVWgOFdDwA7HTMRR2ZwgyU/IdRmfXr7XuomA3Efoj0WNra4pOqbQ3PQ/15yLmve91MsFAxz7MT++s5DLUTTwjtNj7oDUqlenKQ5F9Wa3kiU9Ghut1K2ImOIwRikBllY+40Mwg+3tI0BuZyGU5QoQKs74UGrGy8h3Nr8+Z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cfecb18a9f6511f19a56ed5b684f684d-20260824
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
X-CID-O-INFO: VERSION:1.3.19,REQID:b93f6ac7-aa5a-45f4-87c0-86c0109549c4,IP:15,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:15
X-CID-INFO: VERSION:1.3.19,REQID:b93f6ac7-aa5a-45f4-87c0-86c0109549c4,IP:15,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-META: VersionHash:7db8b62,CLOUDID:f5bd406d410999da1b62f7bc36574f93,BulkI
	D:260824104510Y6P6L3CK,BulkQuantity:0,SF:17|19|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cfecb18a9f6511f19a56ed5b684f684d-20260824
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1132937884; Mon, 24 Aug 2026 10:45:05 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: 1085273969@qq.com
Cc: Wang Yan <wangyan01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] perf powerpc-vpadtl: Fix off-by-one in auxtrace_info minimum size check
Date: Mon, 24 Aug 2026 10:44:41 +0800
Message-Id: <20260824024441.327873-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

min_sz is set to sizeof(u64) * POWERPC_VPADTL_TYPE, but the code reads
auxtrace_info->priv[POWERPC_VPADTL_TYPE], which needs at least
POWERPC_VPADTL_TYPE + 1 elements.  POWERPC_VPADTL_TYPE is the first
enumerator of the priv index enum (0), so min_sz evaluates to 0 and the
check validates only the perf_record_auxtrace_info header itself.  A
PERF_RECORD_AUXTRACE_INFO event carrying a zero-length priv array then
passes the size check, and the subsequent priv[POWERPC_VPADTL_TYPE]
read runs one u64 past the validated region.

This is the same off-by-one fixed for Intel PT by commit c4362d5e1a5e
("perf intel-pt: Fix off-by-one in auxtrace_info minimum size check")
and for Intel BTS by commit b9fb8225951c ("perf intel-bts: Fix off-by-one
in auxtrace_info minimum size check").

Use sizeof(u64) * (POWERPC_VPADTL_TYPE + 1) so the highest accessed
priv index is covered by the minimum-size validation.

Fixes: c4bbd4ec2e50 ("perf powerpc: Process auxtrace events and display in 'perf report -D'")
Cc: stable@vger.kernel.org
Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/perf/util/powerpc-vpadtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
index 710f3093f3f9..c15636eef34b 100644
--- a/tools/perf/util/powerpc-vpadtl.c
+++ b/tools/perf/util/powerpc-vpadtl.c
@@ -683,7 +683,7 @@ int powerpc_vpadtl_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
-	size_t min_sz = sizeof(u64) * POWERPC_VPADTL_TYPE;
+	size_t min_sz = sizeof(u64) * (POWERPC_VPADTL_TYPE + 1);
 	struct powerpc_vpadtl *vpa;
 	int err;
 
-- 
2.25.1

