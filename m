Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339613;
	b=KBYsORHVbdGvJHyReLz3ZV98hZpModJkAsrvdaD7NihA430/ok+Em68GoQkADicsVCHK
	 ayMLxEdKXblblGFLl/3qf2SyD8RS1D4Q/3XIGNO9nmGj9f2XjXrB+rBklN6aCKh/fCZ3Z
	 LUuRwlHDLLqNqsiHlk93oM43TfihoE4vHzSRoOH/PoLLhXc9bdyKH0SANYqOpmalOipo0
	 6yS4SLIoYDwm/g+uIjcVmm6/bAHcnyxPxFfiP0QcfsK8xgP9RF1bYJSA3FFItEicubiDJ
	 VZsXaqFh93DvMMYLUSDq0pyTnmum1EKk4wD5wRke0DD1seadt6oHTb1cZZgx/TCxKGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339613;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kzFnsRRUDNlAE2+m41DsMO85QJ//N64+gMcBAOh8hWg=;
	b=BRtmfukBh6BKDQxO6U0ujLJcKOc9x+9clR1V1p/QwnpuARBfrKm9uukQ/2ZmAWGVvQpB
	 ZUYOF8s2Nw3TZ0I09hs7mpiEpJAuprSAaw2Hh6Cz6UMxcv3CvlgMyNptMeixViebr+TEz
	 8bSAb39ES4QzFPGXE4kDwoO58lGI0E1/Q4mKR9TThVBTPZI3cBSSIZgL2NH1GIhylvApL
	 Y3hFKhPy4DSSzffg3vVSWu6YgPRyXpEXwP2QkZMm/eixb4FojByaNEf++Coxovd6Ic4Sm
	 6RPEbsSmgkgOEjzmcUmn+KhwaRfsYG4PazuObrieyFAIbyYwu6Y29myLjxHpNynIl5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=EQv8jbqj;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AD678606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD678606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=EQv8jbqj
Received: by dvalin.narfation.org (Postfix) id 73F6A20FF9;
	Tue, 10 Nov 2026 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794339610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzFnsRRUDNlAE2+m41DsMO85QJ//N64+gMcBAOh8hWg=;
	b=EQv8jbqjqn1cK8WqazdC+jZfJlqSyoApYcDnbl0dDkUtN5NjgJ2kJvZrcNubBHBgmHh9bd
	/XYzx3tk+Fo7I/xp2NClDsl3ibgS40344N646ZQLafXaisUpy/tIlaADL3G9jx45ALQRZ1
	W8VM3sNKs6CNSxcw3IbhPEpIS3Pw/iY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5.15.y] batman-adv: tpmeter: fix u32 truncation of reported bytes
Date: Tue, 10 Nov 2026 20:40:06 +0100
Message-ID: <20261110194006.317325-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202017-failed-5.15-10f24f058417@kernel.org>
References: <20261109202017-failed-5.15-10f24f058417@kernel.org>
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

commit 1025b76d13288a311e8259a0eefde0854fa63c41 upstream.

When more than 4 GB are transferred by the throughput meter,
batadv_tp_batctl_notify() will cut of the upper 32 bit of the u64 counter
and thus under-report the actual transferred bytes.

The data type of the temporary storage variable must therefore still
continue to use u64.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-08bb3be4-6c6a-452d-b4e4-606940c6cfa5
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 5514fef54b0a9..1c19da01fa2d0 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -226,9 +226,9 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
 				    unsigned long start_time, u64 total_sent,
 				    u32 cookie)
 {
+	u64 total_bytes;
 	u32 test_time;
 	u8 result;
-	u32 total_bytes;
 
 	if (!batadv_tp_is_error(reason)) {
 		result = BATADV_TP_REASON_COMPLETE;
-- 
2.47.3

