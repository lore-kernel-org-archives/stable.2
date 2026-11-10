Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336559;
	b=ZgQ7hXSoU84Qeese9oWd2jhwfKuuSP+7wDDGuZx+txM0e2H/TgdND8Q4RVWnE8eKApcJ
	 krnEl1abKp1LTaZ+B12RypKSgrOjPOCvkpSVw4EbWF1C2Rjoy/t6I2bcw+OGhyqHeKdpX
	 PXMRadvDHwuSityJOKXe4rQRL69K02Kbj5nKORxcdoEppeZaojuomkGKIbVnYKL3UeBaU
	 zMJHUNIe5egQ0pyfACWcV4ND14KnRDzsX/Mmq/GBTXUgt61pOnOGodQWWXtthtO0eS4zf
	 fJx8aXABNRKONMrJh6bglAf3Ik/LLQD/9aFdQwrOciUdkdg58MNC+4eTQYJMpGK+IYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336559;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eXsqdmWxj1gHlE8U8SoJOOCt30k5jBeBbq1ay/3uBk4=;
	b=v7sqEjRBZvys+51SbjLzsrHiLiA5Yc1FWeOOLqNbmpuZCB1EMY99rWNG2yzkRJdocD8v
	 Oq4394Dibmw/NsxIX3zJY5pdztI48dSdHEstqbttPDP+5fcRESJRMlzpPABqFTSbuiTDR
	 /6gD/KaCp8C7HmCzNeq8PcIsj5IVSg7yz2WYvYs/hRGN6Dc1XjgjXzfBV3PmxoaaKPN9M
	 7pmDn8tzDLcPkxYtiW0MnaziO7jJyKts3e+R7QdG7Gxpn6flSOYNw6Bp39jnDo8245o2x
	 kIkfzv//BcY3jClemkzPUcvWlZnm6kU4oB6FV0E5TI/d+oxPc8rmcMNiouGXx8DaNOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=mSzQzzts;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E4EFE606A33B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4EFE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=mSzQzzts
Received: by dvalin.narfation.org (Postfix) id BFE3B216C6;
	Tue, 10 Nov 2026 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794336556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXsqdmWxj1gHlE8U8SoJOOCt30k5jBeBbq1ay/3uBk4=;
	b=mSzQzzts9BLxh62XwaxycibftFNTJ616i2jw9wbYRgicHOTUwNzzd74NmBX1tjbt76pY9j
	WFB6uBPxiz/Dd7qaQ4RF/Yfit8EMVCxPnnI7EfQSzDHvX7DNGwNoqNaPire0KpwG8juCku
	qA02J1vAi9zQuk6NrzWTGQ9SEevh1Nc=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.18.y] batman-adv: tpmeter: fix u32 truncation of reported bytes
Date: Tue, 10 Nov 2026 19:49:13 +0100
Message-ID: <20261110184913.70492-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200220-failed-6.18-1025b76d1328@kernel.org>
References: <20261109200220-failed-6.18-1025b76d1328@kernel.org>
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
index 02af19aaaff29..aa297e551cd07 100644
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

