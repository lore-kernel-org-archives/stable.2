Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338215;
	b=PNkACa2ydw00dMwNSHDm/gy+FAr28GIn+9oGjW7FKj9xEhFcIpJbzT4b3FPvfWobjzLs
	 gNjpEBqJpQX6UubKiU6QfW3YBisfvw4LeYnsAZY3q8j8YiITqTeAXNyQO88FyN8ZMiUs6
	 79ifsIbCfZXcIZ6+SiOAt3/2gtcg6DqqPqbTnwdabk60zHnE0Y5Ggp93BBFeWT/I0+P6f
	 8leyEEzGioOwyW7u5rQLgERDJFR9bGaNdbKqs7cBtyravNhwxVJiOd8bfKaBiX0r4MlBC
	 El4TBEXIckWLK9H3ZX5RgOokUXWjq5Duy1R8rXuuqSfna2x2Tv/Cp3qwVcSqvhERE6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338215;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mUecI1XOzBm8QOld1KoZ7MHqri9j3YAdV8iAVTFqEh8=;
	b=NJS6MZ3gaSDC+GZ7jm0rr/7Z2J9Rep/Wzi47RIAca3TbbWXdZZLAu4eWofb0QzPDEfU/
	 TUTvl/1hzmiJzPyX34bGkFrPLzJqtlxUP3Nut3p0YCs9DrveEat1TNvVbiJqeKeNpbdKJ
	 BYQiHt2oJ99B7m2FoF0LaOtsSzf4SIkHyQbaiyoU+Ze/WWOZiTbRR9IfAMwSVZETNaQN+
	 Gaa5WCnHTDtgsraAK3/L9cOsyENu8hlnc1IKtjtQUgqwwXuRXSxvO9zsplWKyECgOApaV
	 0fnwq++cqpMiD7SHrYCnMdlo1tcx4T5A5PHjw8avvwXXdf2CE3JI7d/OB5a7LOu7hnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=rvJylLk2;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D30E7606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D30E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=rvJylLk2
Received: by dvalin.narfation.org (Postfix) id 0A77820317;
	Tue, 10 Nov 2026 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794338213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUecI1XOzBm8QOld1KoZ7MHqri9j3YAdV8iAVTFqEh8=;
	b=rvJylLk2fZCJtdkdmferhNwxk45nJ0NWpzfUEIa9Iiw1ikdzjokApVM0q3JZWe45EkpM5s
	ZXdj7qcVhTH2fSQeaY1DpiXpp/JUBHTTb0evgEzWzRdiT8vGAELBKzKhubwDCiHr4CXbVJ
	JyJgnG/gFmbzDOsw66CbcP0mMXG7Ezk=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6.6.y] batman-adv: tpmeter: fix u32 truncation of reported bytes
Date: Tue, 10 Nov 2026 20:16:44 +0100
Message-ID: <20261110191644.148302-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201032-failed-6.6-1025b76d1328@kernel.org>
References: <20261109201032-failed-6.6-1025b76d1328@kernel.org>
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
index 50b83e0438a07..e28c4923f52f2 100644
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

