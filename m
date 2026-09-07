Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7664250C293
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796274; cv=none; b=GYwVPWVRs2qyQ4ND6YkkxQhTtNMMdi6/rlvfKIn4W4hc3haUuVHC9mQcV8rRng2joKP1qmDNdH6TgkE0zDH64nVhTRgF2JsgTTFP5HS0X9VhNbUw8fDIzd+DWz4ZjmGhFg0kVu5BxmkaKa8x3giDtuwHN/zbhWCnRNq6IniBi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796274; c=relaxed/simple;
	bh=GZZ+PFo8aCtzMFTmQRkWIMmPaxv/YGtch38omVz8Idg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GI33nifWfboA2kHlMLQbgb3lI+y8FW9cSUvcCsRXLtsaIMvocuobz/d7GSfrcxvZGJKkWuK+ePQy6F5y95bcC+VroffSe/uMzoaUQCm1KGMU2N6BAvmG5DJUGXTDhLLLAdwxV+V4OxkQQxo/Tt4Fw9e4iE1z8g5OPKTnr0FyR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TvY5RzPH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TvY5RzPH"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso35234915e9.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788796269; x=1789401069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8S1ac/047CJsCUEKe+BeswICQ0mkd/I25P8f5m3rYA=;
        b=TvY5RzPH1SeNm0x6lZOX0j5vaLm87yP3DvJePL/vDjbyA0gHZGJQTLope41/0lKmIm
         jHeJm/VndMT0t9bbVpf8LP6KwpFXDU3FWbfYbo1R24uC9bkITEqDGmfAIbwKt5qrDZfU
         52vJCnFjZFPFWQPZGd0tTq8G61g7cQJEnJ7//gRxi/YPoe2Urbmqk8OrJKLZ/WOHtMxk
         wxJ0bWNRgoIMb5DjBH4N7C/4Q7kreOKAvE2v+v456R9jFF2YzwyCEKRFl2ce5WATGNPw
         7rEeyjCtesuzcElB8E/OUllll2UpfVXNZqUCi3U2LSYq/3iDCmHnhc4/+sQ/4IdPSwvD
         iH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796269; x=1789401069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8S1ac/047CJsCUEKe+BeswICQ0mkd/I25P8f5m3rYA=;
        b=VJrwQGYecBODiTbJwG+H9PXobfEsC/qZLBrPMxIs2yDzwrVz9Q3+SvpYhki4v/YrLI
         nTKHljE4XD1dwkanFxPPjb35DDZXdZjoQtKePy5uoc1tXz8EM1MXHT/xInXybBJrt9di
         XxVKVHgEFUZytkX2Ua+JzZW1uPdkIiPnOsga4eVC1dBJKiR+qJ72JJUkZQ52NyG8Ru9H
         NAQOzsiOti1xI4Dj7vxJQ7KQ+H27ct2K/Q8B78PYLV142x4AYynfxK4O2ybmxPUf1KRF
         3ML6Dki7lBTCnVheE9Qx73x0wscySR6GS6URIfdyASES6StUxda3vsbKCLkdQgMpi2Ai
         9+bw==
X-Forwarded-Encrypted: i=1; AKwUvBwwQfNgWiNgRvKmflNZwyObm1WynyI1a0f+oQfTs4xU7CpOCnBDJue2i2QdzLEW9rzmpcOcfM8=@vger.kernel.org
X-Gm-Message-State: AFuF++kMzj5pSflm7RmutK1Suo5BO+oAPRvNgiUxc5NdbyDa4L9km5Vz
	jLKmXvxOnFkdQwR0+FIBl2Moh/Du10E9yNV/j0eXaYN3bK4+04uFAPyz741duolM8C0=
X-Gm-Gg: AYBFou0Q72iWuayzsTuzK2THDLDeAQ1zzsWoMMF1O76D+65m+R25jWeroJ0874uyare
	S8GxzGPFyHZ7epMKbrGfqAt2gMa9lfFp4F4xWOF6MzHSCOKUbGEtXghwBQMkdY27YSMbbUYy+to
	pK1ew/0t8ycP6f6WhjVx2ZhqZ8NqGNxiSdohc0ee1oaaBrbr0XweeliVpgydFvd/TMwLqHHDKUB
	MaCBUdcoXAAvlEn0IT93blswhpnleZNZTfhUfjtBU9biyAZGATql0m88Oi/ypzH2eV1gn887Xvn
	pkNF4JQXR5UeTM4uZwmFbkN3TP1lD5ld+IPgAGxFVXxd3PJRV8APdQ9iTjv4LvtIv4JF+giKEe5
	3BV+MM4MkAp3B6+88MTqlkl46Thvyz4jQyM7yfRwBB4ZNnJFS1rYvjJ0dGS2Es0ouysIXUOMGtG
	pw3xqmz48YqMXsGmML2NofQQ1/XlaG3HcG6xGwyTOUJ5vmASGa219ZL/4vELKrbzo4BkISrwbvu
	Yq1Nk3Z/f0WMCzvdPXIXVj2xy3xRsntxVSboCOc5A82fJ/lJfCY
X-Received: by 2002:a05:600c:348a:b0:49c:fa20:cc03 with SMTP id 5b1f17b1804b1-49cfa20ccedmr181044405e9.26.1788796269188;
        Mon, 07 Sep 2026 08:51:09 -0700 (PDT)
Received: from localhost (p200300de37172700e7f885d729fa4be7.dip0.t-ipconnect.de. [2003:de:3717:2700:e7f8:85d7:29fa:4be7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49ce5952560sm375505825e9.3.2026.09.07.08.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 08:51:08 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Yu Kuai <yukuai@kernel.org>,
	Song Liu <song@kernel.org>
Cc: Xiao Ni <xiao@kernel.org>,
	Li Nan <magiclinan@didiglobal.com>,
	linux-raid@vger.kernel.org,
	Martin Wilck <mwilck@suse.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] md/raid5: validate payload size before calculating payload_len
Date: Mon,  7 Sep 2026 17:51:03 +0200
Message-ID: <20260907155103.2325511-1-mwilck@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b0cc3ae97e89 ("md/raid5: validate payload size before accessing
journal metadata") introduced a bounds check to verify that a given payload
fits into the current metadata block. In order to calculate the payload
size, it has to access the members payload->header.type and payload->size,
the offset of which may already be past the end of the metadata block,
because the loop condition only checks that the first byte of the payload
is inside, and the payload entries have variable sizes. Later on,
payload->checksum[0] and payload->checksum[1] are accessed without
verifying that payload->size is large enough.

Add another check to make sure that payload->size can be safely
accessed, and make sure that the checksum fields are accessible.

This issue has been found by AI (gemma4, Gemini) during a backport
review.

Cc: Junrui Luo <moonafterrain@outlook.com>
Cc: stable@vger.kernel.org
Fixes: b0cc3ae97e89 ("md/raid5: validate payload size before accessing journal metadata")
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
Changes v3 -> v4 (Yu Kuai)

* use u32 instead of uint32_t
* use <= in loop condition

Changes v2 -> v3: Fixed another issue reported by Sashiko

* Modify loop condition to make sure the payload->header.type can be accessed

Changes v1 -> v2: Fixed issues reported by Sashiko

* fix use of wrong variable name payload_len instead of mb_offset
* add checks to ensure payload->size is large enough to hold the checksum values
---
 drivers/md/raid5-cache.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 7b7546bfa21f..62460e231f02 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -2001,27 +2001,36 @@ r5l_recovery_verify_data_checksum_for_mb(struct r5l_log *log,
 	if (!page)
 		return -ENOMEM;
 
-	while (mb_offset < le32_to_cpu(mb->meta_size)) {
+	while (mb_offset + sizeof(struct r5l_payload_header) <= le32_to_cpu(mb->meta_size)) {
+		u32 payload_size;
 		sector_t payload_len;
 
 		payload = (void *)mb + mb_offset;
 		payload_flush = (void *)mb + mb_offset;
 
 		if (le16_to_cpu(payload->header.type) == R5LOG_PAYLOAD_DATA) {
+			if (mb_offset + sizeof(struct r5l_payload_data_parity)
+			    > le32_to_cpu(mb->meta_size))
+				goto mismatch;
+			payload_size = le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9);
 			payload_len = sizeof(struct r5l_payload_data_parity) +
-				(sector_t)sizeof(__le32) *
-				(le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9));
-			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size))
+					(sector_t)sizeof(__le32) * payload_size;
+			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size) ||
+			    payload_size < 1)
 				goto mismatch;
 			if (r5l_recovery_verify_data_checksum(
 				    log, ctx, page, log_offset,
 				    payload->checksum[0]) < 0)
 				goto mismatch;
 		} else if (le16_to_cpu(payload->header.type) == R5LOG_PAYLOAD_PARITY) {
+			if (mb_offset + sizeof(struct r5l_payload_data_parity)
+			    > le32_to_cpu(mb->meta_size))
+				goto mismatch;
+			payload_size = le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9);
 			payload_len = sizeof(struct r5l_payload_data_parity) +
-				(sector_t)sizeof(__le32) *
-				(le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9));
-			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size))
+					(sector_t)sizeof(__le32) * payload_size;
+			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size) ||
+			    payload_size < conf->max_degraded)
 				goto mismatch;
 			if (r5l_recovery_verify_data_checksum(
 				    log, ctx, page, log_offset,
@@ -2035,6 +2044,9 @@ r5l_recovery_verify_data_checksum_for_mb(struct r5l_log *log,
 				    payload->checksum[1]) < 0)
 				goto mismatch;
 		} else if (le16_to_cpu(payload->header.type) == R5LOG_PAYLOAD_FLUSH) {
+			if (mb_offset + sizeof(struct r5l_payload_flush)
+			    > le32_to_cpu(mb->meta_size))
+				goto mismatch;
 			payload_len = sizeof(struct r5l_payload_flush) +
 				(sector_t)le32_to_cpu(payload_flush->size);
 			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size))
@@ -2096,7 +2108,7 @@ r5c_recovery_analyze_meta_block(struct r5l_log *log,
 	mb_offset = sizeof(struct r5l_meta_block);
 	log_offset = r5l_ring_add(log, ctx->pos, BLOCK_SECTORS);
 
-	while (mb_offset < le32_to_cpu(mb->meta_size)) {
+	while (mb_offset + sizeof(struct r5l_payload_header) < le32_to_cpu(mb->meta_size)) {
 		sector_t payload_len;
 		int dd;
 
@@ -2106,6 +2118,9 @@ r5c_recovery_analyze_meta_block(struct r5l_log *log,
 		if (le16_to_cpu(payload->header.type) == R5LOG_PAYLOAD_FLUSH) {
 			int i, count;
 
+			if (mb_offset + sizeof(struct r5l_payload_flush) >
+			    le32_to_cpu(mb->meta_size))
+				return -EINVAL;
 			payload_len = sizeof(struct r5l_payload_flush) +
 				(sector_t)le32_to_cpu(payload_flush->size);
 			if (mb_offset + payload_len >
@@ -2130,6 +2145,9 @@ r5c_recovery_analyze_meta_block(struct r5l_log *log,
 		}
 
 		/* DATA or PARITY payload */
+		if (mb_offset + sizeof(struct r5l_payload_data_parity) >
+		    le32_to_cpu(mb->meta_size))
+			return -EINVAL;
 		payload_len = sizeof(struct r5l_payload_data_parity) +
 			(sector_t)sizeof(__le32) *
 			(le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9));
-- 
2.51.0

