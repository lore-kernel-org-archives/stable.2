Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C433CE88;
	Wed, 22 Jul 2026 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700685; cv=none; b=pqrkN/e+SEZhwENJY2T/98Us+vLF5pWjgwttYgyjeCIoDwQVTbg48psnM1R5TpSDcpogV7/0QyuUcgdNNhKKLEhYnFFhhngv9TQD811SpV69xpIRECu1Rz5uOu7CuzsNiTUmVF2IGBzaslranxxDaWmA9AFMcSJ+aBKMobpvQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700685; c=relaxed/simple;
	bh=+zn/5rUSOI5tYr8quJd5cp90NOxeBxcuK0kJejW29TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uShxsI0dWktuik0UNFiB5C20bTreBYPejWRBtqpxbbushLVt+WuchHQ5oJDkry5zwAEDzNQCPep7KlqSTYs97Kvg8EJdfjtSRKGGF8yl9oHIKsqlL/rW76SQU/+HJNJ2hUxjPbfKifixQHVFHAiH9aUxNi0X2d1tv78yXl1Lnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1db3728c859411f1aa26b74ffac11d73-20260722
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
X-CID-O-INFO: VERSION:1.3.12,REQID:2b55ebc4-2908-492b-a6e7-256b568d63c8,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:2b55ebc4-2908-492b-a6e7-256b568d63c8,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:85ad491d20fb8871bef74b04f5fd984d,BulkI
	D:260722141104YKRMTDY1,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1db3728c859411f1aa26b74ffac11d73-20260722
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1371682131; Wed, 22 Jul 2026 14:11:02 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] tracing/user_events: Validate explicit struct field sizes
Date: Wed, 22 Jul 2026 14:10:38 +0800
Message-ID: <20260722061040.112747-3-liqiang01@kylinos.cn>
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

User event declarations permit an explicit size for a struct field. The
parser accumulated that size in an unsigned offset, then assigned the
parsed unsigned value directly to signed field metadata. Oversized
declarations or cumulative offsets could wrap or become invalid signed
values.

Validate an explicit size is representable as int before storing it. Keep
the running offset signed and reject additions exceeding INT_MAX, so
invalid field layouts are rejected during declaration parsing.

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Cc: stable@vger.kernel.org
Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 kernel/trace/trace_events_user.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 8c82ecb735f4..fd5b3946921c 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1197,10 +1197,12 @@ static int user_event_add_field(struct user_event *user, const char *type,
  * Format: type name [size]
  */
 static int user_event_parse_field(char *field, struct user_event *user,
-				  u32 *offset)
+				  int *offset)
 {
 	char *part, *type, *name;
-	u32 depth = 0, saved_offset = *offset;
+	u32 depth = 0;
+	unsigned int field_size;
+	int saved_offset = *offset;
 	int len, size = -EINVAL;
 	bool is_struct = false;
 
@@ -1261,8 +1263,11 @@ static int user_event_parse_field(char *field, struct user_event *user,
 			if (!is_struct)
 				return -EINVAL;
 
-			if (kstrtou32(part, 10, &size))
+			if (kstrtouint(part, 10, &field_size))
 				return -EINVAL;
+			if (field_size > INT_MAX)
+				return -E2BIG;
+			size = field_size;
 			break;
 		default:
 			return -EINVAL;
@@ -1281,6 +1286,9 @@ static int user_event_parse_field(char *field, struct user_event *user,
 	if (size < 0)
 		return size;
 
+	if (size > INT_MAX - saved_offset)
+		return -E2BIG;
+
 	*offset = saved_offset + size;
 
 	return user_event_add_field(user, type, name, saved_offset, size,
@@ -1290,7 +1298,7 @@ static int user_event_parse_field(char *field, struct user_event *user,
 static int user_event_parse_fields(struct user_event *user, char *args)
 {
 	char *field;
-	u32 offset = sizeof(struct trace_entry);
+	int offset = sizeof(struct trace_entry);
 	int ret = -EINVAL;
 
 	if (args == NULL)
-- 
2.43.0

