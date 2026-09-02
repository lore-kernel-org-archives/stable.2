Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716B2C0F8C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373109; cv=none; b=ibS8WiYayYM/x6a2RGzx/voOAgmNzZmbql6nvRC+h/5Cw7rN8ik84mSEUAKH7/G4w+o0+xbQdgdrSfN8qcRY5qnSjJV6Y0fgjRrJMXqz4gNQk95MXP81Rw6EUTQbKeaXud5ehMoiDMm+SkE60njZyvrPArHaqWZ2GACBWMdMcns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373109; c=relaxed/simple;
	bh=A+/3DCqxpER5m41S+m0+gUcQfqSBoO/v6wPe8RjukhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ru2wb05IeFI2FhM5pH7eG559PhtIpkquL9BvX6nrMsUFnboFNNo0X3a1hHDfWrgH/V3WI6q3+uUNojFG7hn+TmPpviUb16Iwe0bbsLip2J2V8jLbaTKnlYF36os0XD/pXSQulsK9Tra0gYCxQQdTmEElsiDL+PiQs3eQNh4EObk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CZzvMjCb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CZzvMjCb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so15372965e9.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788373106; x=1788977906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o2vV/XrzECaW8bp6/ZI9Xkit31V7ZWz/8TVOHSUt+MM=;
        b=CZzvMjCbkS90l601IJgGW0mf0MofxtZCimpupXjZhOlQ+Mz8RIiR0tzslaprK3jPNp
         xS89HHMIsV2eJdBNlx/nq3AwUSmTUP0xkg4r8npsXcDlC1nDgEBoem6ShZQ8TIZGFSZ8
         B9Z004PJ13VM/spMIuYQ5y5mi5sy3mqEmIPjW8tYGArxGny/QqnVr9PQK6x8ic6ZUPbF
         X9gIZCSwnsBaCimM3+KG9Ybo6vVuTv1xFymhqb7Uw7N6OUkf0GyLPRA/TP5sXVzddVRq
         U14/5WqRT+uZIuVMwupl87B1X3n5yRWLh068ryn2L9KYhToA/5IiwVeEv3HTc1r/0N14
         00qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373106; x=1788977906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2vV/XrzECaW8bp6/ZI9Xkit31V7ZWz/8TVOHSUt+MM=;
        b=EyDl7RgOXXVmoEu6p3u64oKjtI2TX5bf3x4eCiq47Vf0fyW0u0blD2D6YEA1hM3TUG
         Q3vmZ9IVz9M+6bvSpKmfGI+pmhH0zB7Ruc0i0X4wU7OJZkGocyeWc1DZsR2ku22e0KOG
         tOpEAHhgIBw2ONXdsjQerY0SfMvBPY5DxLppVhTjO8W0O6t7ktdi1UKDzj7SL3KQss/G
         QEBge0s/nxiqrSRhh7lEIpwkJgz6mVAHajwq+agqx4YxtEfcs7Nz9Y2e6Ttj4heibZpH
         BRXteFBAJjbD69jG0rn6Ys7uftWineuH0NidTD3hPxb480HFiiRygMIadO30QFLDcvWv
         S9gg==
X-Forwarded-Encrypted: i=1; AKwUvBz1E5aNJi2TJ/cMFJCGI2mMpxC0wRTOoOhndEOs5sVJaP0nDT7tAIGY7gYhvcV69wlw4plZJ4E=@vger.kernel.org
X-Gm-Message-State: AFuF++kFvBH/trvrlTC0PP4WvZ98ry7W7ZTWyzvGNJ3UING9jOF+aCnY
	l+VNl4KwKh7ZVgsR06HlxQug7XdsTfEGw1VslCtspiNoIyxT3lkD76ZDQnNfYytWzHQ=
X-Gm-Gg: AYBFou1ZUouorZXDSD7KqziJoDDOAzoi68+Lwoh1WNjCzsgqTrsvIL+bOZLos1xK0nn
	DwBggzhTaE52QmA7NUfBCjhUMTf9Rj0UeFrz0A+cqHGfk/VEVPA0/g6zS0QAY8cikuANDWOsIrK
	pqhlaCIkJsBZ86qPUDdFqswTDYfm2P0Kwq2TCcQ/kLwKBwa4GmEJLAzL127x7dyqnTvoee1bJFC
	fNOoDEkJTZoVIqgxWQVsrOL4wVnACJeZBQ+eMmypwjfR6JnM8c4qipV9hGrjL+hKdROlzu0ThZP
	IcYN2JvmW3GVPb+6fXCOAq2tydxESS3VyqiU4aQ4JNlWtjxNIuaO2QAd5c+K471BI+hnNDi1ulG
	GjTfo0LrgD1atMEyV+IMquCFhLDRhv681L54pau6//8mh9SLfjC0Lw4/eIQMAJVs/m36DiN0NHK
	v0y+7sXyC0jfX+O5PYfhkcgLl3C0MWVxASVvcev9iOzHEDLIRoG9C4fpEVcK/nsXnzJoVcsQHj5
	T9vKassHHW3ef72gaxwB8wbTZVkjEXODVAKu47Wp75wgibB/xqC
X-Received: by 2002:a05:600c:3113:b0:49b:924e:9a28 with SMTP id 5b1f17b1804b1-49ce58163aemr109544035e9.1.1788373105683;
        Wed, 02 Sep 2026 11:18:25 -0700 (PDT)
Received: from localhost (p200300de37172700e7f885d729fa4be7.dip0.t-ipconnect.de. [2003:de:3717:2700:e7f8:85d7:29fa:4be7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5e589bsm8964865e9.13.2026.09.02.11.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 11:18:25 -0700 (PDT)
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
Subject: [PATCH v3] md/raid5: validate payload size before calculating payload_len
Date: Wed,  2 Sep 2026 20:18:19 +0200
Message-ID: <20260902181819.267431-1-mwilck@suse.com>
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
Changes v2 -> v3: Fixed another issue reported by Sashiko

* Modify loop condition to make sure the payload->header.type can be accessed

Changes v1 -> v2: Fixed issues reported by Sashiko

* fix use of wrong variable name payload_len instead of mb_offset
* add checks to ensure payload->size is large enough to hold the checksum values

---
 drivers/md/raid5-cache.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 7b7546bfa21f..031a89faddae 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -2001,27 +2001,36 @@ r5l_recovery_verify_data_checksum_for_mb(struct r5l_log *log,
 	if (!page)
 		return -ENOMEM;
 
-	while (mb_offset < le32_to_cpu(mb->meta_size)) {
+	while (mb_offset + sizeof(struct r5l_payload_header) < le32_to_cpu(mb->meta_size)) {
+		uint32_t payload_size;
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

