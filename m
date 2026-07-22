Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D533AD9C;
	Wed, 22 Jul 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700673; cv=none; b=d2uwHmaTqpFs4BVbY11l47ryr85DZSZdGI9CQljg0vljtuFYzdLiEXRlDLHD+dQoqnCGoqWVS+nHWkoSLGvQB1OStBTdJUoUuDMR4Mgr2XSyy3spR3jHShR+McCHhOhxiq9FvSBHAaXaeyU1hCrGl1ewWzNLX+ZlLGe+IK9lz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700673; c=relaxed/simple;
	bh=CFoa86Uz74036+ICkody/I2OxfctQjO/9BLPIQ5LRAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3s0QZ5aeilK+/CgSjWASHIMBmIi0GIGUiTU0D6g1kZ016I9H9abw1g4ShlrPyQQI9UCeoGJ/nolTMyse6Nq/S0Iv+A5v24bnSScKbI+R9C7cUF06mTbCorLcv8Rd4SqvchaKgeOqqtbQ3ZB8srf2HKM8cpQy9l8tjdLkoLwM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1e608648859411f1aa26b74ffac11d73-20260722
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ecca982b-22f2-402a-b663-c839365519de,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:ecca982b-22f2-402a-b663-c839365519de,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:2820e7ca4246b2fd5fbd1793db7675a5,BulkI
	D:260722141104DLVJ7E1R,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1e608648859411f1aa26b74ffac11d73-20260722
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1606383993; Wed, 22 Jul 2026 14:11:03 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] tracing/inject: Prevent overflow growing string fields
Date: Wed, 22 Jul 2026 14:10:40 +0800
Message-ID: <20260722061040.112747-5-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722061040.112747-1-liqiang01@kylinos.cn>
References: <20260722061040.112747-1-liqiang01@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_entry() appends dynamic string data by adding its length to the
current entry size. An oversized input can overflow this signed addition,
cause krealloc() to receive too small a length, and then write beyond it.

Reject a string length that cannot be added to entry_size before growing
the allocation.

Fixes: 6c3edaf9fd6a ("tracing: Introduce trace event injection")
Cc: stable@vger.kernel.org
Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 kernel/trace/trace_events_inject.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index b8b141c00d5c..5c551def44f6 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -243,6 +243,9 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 				int str_loc = entry_size & 0xffff;
 				u32 *str_item;
 
+				if (str_len > INT_MAX - entry_size)
+					return -E2BIG;
+
 				entry_size += str_len;
 				*pentry = krealloc(entry, entry_size, GFP_KERNEL);
 				if (!*pentry) {
-- 
2.43.0

