Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0382DF701;
	Wed, 22 Jul 2026 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700674; cv=none; b=PDH5wlNQYH9vh2Fn1fUZLaREWnPmAAeqFA7Nv9C60PcG3ixscTLZaC1zahe47VJrCopXkBV5reD+SOXlz9fudgk7ilOrzeBpWjJ2SYXuJBSJa+nE1WEDjRqRyMt20ldhPQn/lq0HkPwbv5VEzTPwVgoI7rKFDc1AsGlx3mtmQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700674; c=relaxed/simple;
	bh=v42dRaKxj1LsLC3QU9XKtSklSxvImei3dJ0Hk/QeXXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzQ6+R2OdMblaA3KjkFe5BxshKRnCt18bEJW+PrHpHp29aZ8L3cI37Gel6wBN6khmsSjOWVPgL4TO6Wfqp3ryMIpTcLSakTMhuK9yd+00WY0ILWxKSYWtJSCCWJWLv1V+D4UnEN+82r+K9eCoVKDCrz82G+4xQHgts1tGgNmlv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1df87602859411f1aa26b74ffac11d73-20260722
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
X-CID-O-INFO: VERSION:1.3.12,REQID:b2333f70-c98a-4683-902e-70041ac3bce2,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:b2333f70-c98a-4683-902e-70041ac3bce2,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:123d66af32c07acc495e82e37f3d4d4b,BulkI
	D:260722141104NCY3GOCL,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1df87602859411f1aa26b74ffac11d73-20260722
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 639850921; Wed, 22 Jul 2026 14:11:02 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] tracing/inject: Validate entry allocation size
Date: Wed, 22 Jul 2026 14:10:39 +0800
Message-ID: <20260722061040.112747-4-liqiang01@kylinos.cn>
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

trace_get_entry_size() calculated the allocation from signed field offsets
and sizes without validating their sum. A malformed event could use a
negative range or overflow the calculation, allocate too little memory, and
then write past it while initializing or populating the entry. Events with
no fields also allocated less than a trace_entry.

Start at sizeof(struct trace_entry), validate each field range, and reserve
room for the trailing NUL. Propagate sizing errors to parse_entry() before
it initializes the allocation.

Fixes: 6c3edaf9fd6a ("tracing: Introduce trace event injection")
Cc: stable@vger.kernel.org
Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 kernel/trace/trace_events_inject.c | 31 ++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index a8f076809db4..b8b141c00d5c 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -135,27 +135,43 @@ parse_field(char *str, struct trace_event_call *call,
 	return -EINVAL;
 }
 
-static int trace_get_entry_size(struct trace_event_call *call)
+static int trace_get_entry_size(struct trace_event_call *call, int *entry_size)
 {
 	struct ftrace_event_field *field;
 	struct list_head *head;
-	int size = 0;
+	int field_size;
+	int size = sizeof(struct trace_entry);
 
 	head = trace_get_fields(call);
 	list_for_each_entry(field, head, link) {
-		if (field->size + field->offset > size)
-			size = field->size + field->offset;
+		if (field->offset < 0 || field->size < 0 ||
+		    field->size > INT_MAX - field->offset)
+			return -E2BIG;
+
+		field_size = field->size + field->offset;
+		if (field_size > size)
+			size = field_size;
 	}
 
-	return size;
+	/* trace_alloc_entry() reserves an extra NUL byte. */
+	if (size == INT_MAX)
+		return -E2BIG;
+
+	*entry_size = size;
+	return 0;
 }
 
 static void *trace_alloc_entry(struct trace_event_call *call, int *size)
 {
-	int entry_size = trace_get_entry_size(call);
+	int entry_size;
 	struct ftrace_event_field *field;
 	struct list_head *head;
 	void *entry = NULL;
+	int ret;
+
+	ret = trace_get_entry_size(call, &entry_size);
+	if (ret)
+		return ERR_PTR(ret);
 
 	/* We need an extra '\0' at the end. */
 	entry = kzalloc(entry_size + 1, GFP_KERNEL);
@@ -202,6 +218,9 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 	int len;
 
 	entry = trace_alloc_entry(call, &entry_size);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
 	*pentry = entry;
 	if (!entry)
 		return -ENOMEM;
-- 
2.43.0

