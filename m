Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311D4A4829
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365219; cv=none; b=HrFKYW/f6ADJJCoTDSyCbnlHNRPkdaegDAQxzxLduuQ/1X2zVfGB2FU8BbouBO8i5ZS8Aah1GyDiacbWvHO/vaJPLKNrkvnwaYy7XZ2WhmNldj0anRCY7ZQCl9OwTxaGAqdd4zaEUPy/FCys7w4zRFgOng+6IlQUkYbx/tKSf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365219; c=relaxed/simple;
	bh=tjcWcq1vsbmjnN1l4BNYazR6Ln+crXs0S/cszeTzk1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzxepvPhsaZ46YWn3xCXZLyXZPhIa0jasz5RVMcelWHoL9I3ZFceb5UTprrPJyNJfrbBx7fNeMz1Pq7vNQc7Wn3rpNvhzCrXmgTP/nfyUA6WqUl0gId3zbI31kTdoGK/JSsk7Q7zVicTWzDNzr0/NLss65hUzwCFQledISXaFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UGX/lM2n; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UGX/lM2n"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48431648f33so26439f8f.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788365215; x=1788970015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Bbo3ndqYQwPgRKA7QTntetVj75xMQY39h5W8p/1ZdI=;
        b=UGX/lM2nWcXSrh+oxSAzxieuhgb3i9l6ETejHb5vzDfuOjYTxMOaAkDUPOefNNv+4f
         nuLSNZMDF+6pAHwgURCv0HNngGmwGxN8kFPeUi6VFBFNQdGcmkdos6qQGSe6M9VBN9B1
         dWm79eH6sZ3lXbz3xxhdSaVTtT9JE0woia5pC5G1tbSjK+S1YaSAcE990F3Ro1EklqRP
         yWOF1YaoEJtpyul4GhpSca6bdA9iXFnx1GmbYjumcjAOx2+X2PNvOnrPW9SIYMnK9i5O
         7bIOPb6z/6HoslBJszDxkYMvv82AISS3Ucqselu7+95NJ7oQ4kKW76WtK6cW86gok/Q0
         Kxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365215; x=1788970015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Bbo3ndqYQwPgRKA7QTntetVj75xMQY39h5W8p/1ZdI=;
        b=F3wY0SYpdZdEMFwgwBaG7O0IzV7OZ5xRUdEBFPj7dBsbhSSbsn50nKhWmmm6EQpfg2
         dIpG/moC+9WVgItkDQrsVDiwyiobg/hi0lNyoQXJZq8UckjWN5Z1AANq11+sSSh8AoTU
         R5NxWTe2OJ7eu6SST0Ip/cmPkt8b1DynaJfd0VW1m+Vk/aX82rHwROoG3MqOALfaQUK0
         UsJ94c2uF7VLbggMd2lAgD1r+pwIUslC3oZ1eu3MZfw0NpDpFtcKz9pIX2ct7Nh8NU4r
         gIcjIxKc2hLWImrz4FuiKgR722q82QQm1qX9NzctGaflqMwjH5XfWa3mScPgc0wVINGs
         XXxg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2gPiIJ7j/M7D/qiMEUcCL+Z6jbS5csjIlsRPEwbXIelScVrk+NtxHZGxCegqb1lq0zmBqpUc=@vger.kernel.org
X-Gm-Message-State: AFuF++kbfZe84ouVKHBRIsC59I+Ubo9sGPErL30RUwPIeeBNlioIOv2v
	L1lvnM3p3VcJkZDR/3OHVZZSR2b984IlDiq1PQc5oGyAyVwm1Oi/FOFO5rds/irt/PY=
X-Gm-Gg: AR+sD12DoW36l3070hVViGPJE2iAM4u9Bkrev269cpxKvLXRYVZf0k9u1eamKqHEuzg
	ybI80YhxGeMMMZwNLqnVmo28XjeYHBSIJUcL75JsVc5j1/9lFB8Cw6stmbi82u8jP/LIkOYfgLQ
	4/q+pLlR6Ct0Uu3y2AB5MafP1vmqwmZp0vLTUSk5kMIpEI8RwpSmnejHz+fG4h1QLYx/oQBivRV
	CMNXgRDJIviRZpkh9vlee75d4SE4y89ZJwIYxBEkK5s78au/XW6GDaw7dtAXXfincnqzwJCuefr
	pr1Q3TP3c+4RNvQDoIRZBpH/yG9IHaZhUBoblLdXd6JflbGbSsMWfBAzgDTrv10AFiShMmGco5R
	OLxJrD02bBYfXs9Bd9InSSa8ESAzV0EBzvOApV5pOw4z5BTYcj1ceWC1t7ooCMuS9dJS7dj265n
	9mt3H+GYr+XcXrW3kiu5i0RkM8tQkhnzzSkG8cRk0t8V44rWf5Vs/lzA8Fnpm/DVM4Vl0v2EI3n
	T4Wge/oFHm+QxIrxRqhH7g9AmsJCyZBM/d0jQ7ygPXOJe0ulpZi
X-Received: by 2002:a05:600c:19c8:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49cee5e8fe7mr4442745e9.6.1788365214792;
        Wed, 02 Sep 2026 09:06:54 -0700 (PDT)
Received: from localhost (p200300de37172700e7f885d729fa4be7.dip0.t-ipconnect.de. [2003:de:3717:2700:e7f8:85d7:29fa:4be7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5f914bsm1738445e9.3.2026.09.02.09.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 09:06:54 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Yu Kuai <yukuai@kernel.org>,
	Song Liu <song@kernel.org>
Cc: Xiao Ni <xiao@kernel.org>,
	Li Nan <magiclinan@didiglobal.com>,
	linux-raid@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	Martin Wilck <mwilck@suse.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH] md/raid5: validate payload size before calculating payload_len
Date: Wed,  2 Sep 2026 18:06:03 +0200
Message-ID: <20260902160603.218621-1-mwilck@suse.com>
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
size, it has to access the member payload->size, the offset of which may
already be past the end of the metadata block, because the loop condition
only checks that the first byte of the payload is inside, and the payload
entries have variable sizes.

Add another check to make sure that payload->size can be safely
accessed.

This issue has been found by AI (gemma4, Gemini) during a backport
review.

Cc: Junrui Luo <moonafterrain@outlook.com>
Cc: stable@vger.kernel.org
Fixes: b0cc3ae97e89 ("md/raid5: validate payload size before accessing journal metadata")
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/md/raid5-cache.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 7b7546bfa21f..accf8b472082 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -2008,6 +2008,9 @@ r5l_recovery_verify_data_checksum_for_mb(struct r5l_log *log,
 		payload_flush = (void *)mb + mb_offset;
 
 		if (le16_to_cpu(payload->header.type) == R5LOG_PAYLOAD_DATA) {
+			if (mb_offset + sizeof(struct r5l_payload_data_parity)
+			    > le32_to_cpu(mb->meta_size))
+				goto mismatch;
 			payload_len = sizeof(struct r5l_payload_data_parity) +
 				(sector_t)sizeof(__le32) *
 				(le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9));
@@ -2018,6 +2021,9 @@ r5l_recovery_verify_data_checksum_for_mb(struct r5l_log *log,
 				    payload->checksum[0]) < 0)
 				goto mismatch;
 		} else if (le16_to_cpu(payload->header.type) == R5LOG_PAYLOAD_PARITY) {
+			if (mb_offset + sizeof(struct r5l_payload_data_parity)
+			    > le32_to_cpu(mb->meta_size))
+				goto mismatch;
 			payload_len = sizeof(struct r5l_payload_data_parity) +
 				(sector_t)sizeof(__le32) *
 				(le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9));
@@ -2035,6 +2041,9 @@ r5l_recovery_verify_data_checksum_for_mb(struct r5l_log *log,
 				    payload->checksum[1]) < 0)
 				goto mismatch;
 		} else if (le16_to_cpu(payload->header.type) == R5LOG_PAYLOAD_FLUSH) {
+			if (mb_offset + sizeof(struct r5l_payload_flush)
+			    > le32_to_cpu(mb->meta_size))
+				goto mismatch;
 			payload_len = sizeof(struct r5l_payload_flush) +
 				(sector_t)le32_to_cpu(payload_flush->size);
 			if (mb_offset + payload_len > le32_to_cpu(mb->meta_size))
@@ -2106,6 +2115,9 @@ r5c_recovery_analyze_meta_block(struct r5l_log *log,
 		if (le16_to_cpu(payload->header.type) == R5LOG_PAYLOAD_FLUSH) {
 			int i, count;
 
+			if (payload_len + sizeof(struct r5l_payload_flush) >
+			    le32_to_cpu(mb->meta_size))
+				return -EINVAL;
 			payload_len = sizeof(struct r5l_payload_flush) +
 				(sector_t)le32_to_cpu(payload_flush->size);
 			if (mb_offset + payload_len >
@@ -2130,6 +2142,9 @@ r5c_recovery_analyze_meta_block(struct r5l_log *log,
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

