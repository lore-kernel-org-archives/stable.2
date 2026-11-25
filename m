Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=60.244.123.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593884;
	b=TQ9UHvDQsVyRApdCpcOqxGrOKais05BjgFmhxpkHJgKt14FfXtqxnySy1PCADINdV95E
	 K+DKWcUVmjfZU0nwR8D700WJHslMcuo5Bp/ekexYjYzk1Yd7blYtO66cUreZu/Rqvdllh
	 m8k8IeUMl+ssEGl+e9vAFZZGNHpwThjhQK++7fep6dvOn92I3UoEPUY4yVGeAMrvrpJlt
	 djkocCuOYLZrdbOsRNrH5tmU2Otv7SWGeGnrgMTYQzn/5y3ExW+tH5EibV+JSFmCNTJZw
	 Z81h+klKsv+bEz/RmihX7JmMTKsASUqnMjJcPzLYB9AXttAACywpqLeoaHRN1msyu8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593884;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-MTK;
	bh=RZiARSrN+96IvgyLqqkIF8nWXtL4K1TCt2GqvlBqfE0=;
	b=NZ6/SbfPwlJML319UQS5nfzLQi9afLbFo5C1kU9dZFaVIadO1/U/jpqxF1Brh6X1nUVl
	 g/on3wa+bSUCVetQEv6QqyevZMe3U2HVpx4q8XdThnVoBrBjBP98YlWKbrY/PkXs6CxkB
	 4iX6bf9dZng+9iv/1AvOO9zUheDuI9HuhHZ7oG30fTHgf4AFbHeSU4hL2TmvTEZoLrSkY
	 u5RQXhOopWpAxUrb3SgTHhnqXYfYmkimDXUVsmGpKsA1N3Dag8NLEXLqt3bhw/yT4ORWD
	 hF2t2KUncsZbgL9Zbx7gCtYhIhIyZPJDyIaJGDmYOLtpHaJxTn81IQsnXVelV2Oi0pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=ELcExiDL;
	arc=none smtp.remote-ip=60.244.123.138
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85E606A321;
	Wed, 25 Nov 2026 08:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C85E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=ELcExiDL
X-UUID: dd283236e8a611f1b1788b6acf885367-20261125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RZiARSrN+96IvgyLqqkIF8nWXtL4K1TCt2GqvlBqfE0=;
	b=ELcExiDL0Ne3E53F2RevlQd77pggl5lTtOASPG18QJ450ZiO7xRlyhmowtdjVx8MUDvqMRUqa5eNnG4mNmolN5s8AlWO4z6u5+6Lj7qSwvJkg7PM3FfOR4USO9qlgfkuYpLAEM0792NvW+jqfpn1RHEHF8uB3B6lFmZPWiyak6w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:d39729d0-b93d-429b-9696-540a267e39aa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0318ac,CLOUDID:97bc091a-ae4c-4a2b-b1c4-72e411efd0c9,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dd283236e8a611f1b1788b6acf885367-20261125
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <kuyo.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 893746225; Wed, 25 Nov 2026 16:04:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 16:04:38 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Wed, 25 Nov 2026 16:04:38 +0800
From: Kuyo Chang <kuyo.chang@mediatek.com>
To: Kuyo Chang <kuyo.chang@mediatek.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Martin Kaiser <martin@kaiser.cx>,
	Vinod Koul <vkoul@kernel.org>
CC: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] tracing: Fix UBSAN shift-out-of-bounds in test_event_printk()
Date: Wed, 25 Nov 2026 16:03:56 +0800
Message-ID: <20261125080431.1612026-1-kuyo.chang@mediatek.com>
X-Mailer: git-send-email 2.45.2
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Commit b5cc230af5e5 ("tracing: Warn when an event dereferences a pointer
in TP_printk()") removed the early return when dereference_flags is zero
so that test_double_dereference() can check all event arguments.

As a result, trace events with more than 64 arguments in TP_printk() now
always reach the argument-parsing loop and evaluate (1ULL << arg) when
arg >= 64, triggering a UBSAN shift-out-of-bounds trap.

Additionally, in the format string parsing loop, the bounds check only
tested 'arg == 63'. If the first 64 specifiers are non-pointer and
non-string formats (e.g., %d) and a subsequent specifier (arg >= 64) is
%s or %p*, 'arg == 63' evaluates to false and '1ULL << arg' also shifts
out of bounds.

Fix both issues by changing the upper bound check to 'arg >= 63' and
guarding the '(1ULL << arg)' checks in the argument loop with
'arg < 64'.

Fixes: b5cc230af5e5 ("tracing: Warn when an event dereferences a pointer in TP_printk()")
Cc: stable@vger.kernel.org
Signed-off-by: Kuyo Chang <kuyo.chang@mediatek.com>
---
 kernel/trace/trace_events.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7f89160aeff3..5933fc92f786 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -526,7 +526,7 @@ static void test_event_printk(struct trace_event_call *call)
 				case 'a': case 'd': case 'D':
 				case 'g': case 't': case 'C':
 				case 'O': case 'f':
-					if (WARN_ONCE(arg == 63,
+					if (WARN_ONCE(arg >= 63,
 						      "Too many args for event: %s",
 						      trace_event_name(call)))
 						return;
@@ -556,7 +556,7 @@ static void test_event_printk(struct trace_event_call *call)
 					if ((fmt[i + j] == 's')) {
 						if (star)
 							arg++;
-						if (WARN_ONCE(arg == 63,
+						if (WARN_ONCE(arg >= 63,
 							      "Too many args for event: %s",
 							      trace_event_name(call)))
 							return;
@@ -610,7 +610,7 @@ static void test_event_printk(struct trace_event_call *call)
 
 			test_double_dereference(fmt + start_arg, e - start_arg, call);
 
-			if (dereference_flags & (1ULL << arg)) {
+			if (arg < 64 && (dereference_flags & (1ULL << arg))) {
 				handle_dereference_arg(fmt + start_arg, string_flags,
 						       e - start_arg,
 						       &dereference_flags, arg, call);
@@ -625,7 +625,7 @@ static void test_event_printk(struct trace_event_call *call)
 
 	test_double_dereference(fmt + start_arg, i - start_arg, call);
 
-	if (dereference_flags & (1ULL << arg)) {
+	if (arg < 64 && (dereference_flags & (1ULL << arg))) {
 		handle_dereference_arg(fmt + start_arg, string_flags,
 				       i - start_arg,
 				       &dereference_flags, arg, call);
-- 
2.45.2

