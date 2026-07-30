Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6B355057
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785431454; cv=none; b=Y3Ah9oCL+674lW3pAeSLzJfMbKZnO3msjWcfuTkPMgf4pLA5/iIKNDecLjAkmH2YlHZTmv+8wKFpeh9e6g8O9rZta37nQMUum7leSn6aV2Ea9bjvIw9OyVdqo4CWqML1l3ZBkIVO4sekzG5hdQt5LVal69ENgxM+Aevfke4ydwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785431454; c=relaxed/simple;
	bh=hXSYEF2t5MtMtkedXgSvQdfqXZRvQ3qRyWT5lJCVgFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keorEuZN0ryd0xfq2QD8c4AoFQvVX6E7izLhS8ZIR39yrctawkccbUy6MKbbU/wavvQFpBxS9VdwXFEl6PB/jDg/NMk970elaZHHIE1KLVJJLMpV1sz26cIYhz30AuBQEftogQWhaX/pbzhNVGvHI0hpF0TGd6SoeVZve3b1WkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUVn/Ca8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUVn/Ca8"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so13390a12.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785431452; x=1786036252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4c57/zO/kf970g7Oiqj/M78V+zOd+Wx8jivjWLKneoo=;
        b=HUVn/Ca8NpRU3P2/4IDKLt/+idYNeLjoZcp73ilSsoBGUwiK19voXlARbxde4iHYRB
         OQV9/ZMpJiiiWibNS+eKMKUC74JmoMA+aVNoVc50ev8H9rbfCrAYW9b6FuVgUA3ORoJ6
         0SEWs9FDmWWQ7BFMOKFpaWh0M1xsDCowM50HsVKcLNZdvpHX1Ke07V512fGMSX90zWpV
         3MsyEAuI2hpS0N7CqF3EDnKv046Kq+3m0BGD2/0M3ofsbILTHcuzRXxuZRt4V1qokvSo
         kVhlwR+43v8SfQ6C6RHT9wRBjHmshyJaHiXEs3K/t8wGFmbuPH6dR2fIfwEUyacHhiVp
         sKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785431452; x=1786036252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4c57/zO/kf970g7Oiqj/M78V+zOd+Wx8jivjWLKneoo=;
        b=p1MuGQtZul2CzC/8Cq96YtJm8t4e9qA1Wc3w8nfx4qVgiku2DfRjJW2FJh2/1M8/KA
         Vrvm6S+uxdbUyDS2AvlRItnZGJoyB4SqwkTDsMv3onn8OmpKTxdfLmbk0oeJAxyzSlri
         GBlAYgqHtVzBVo/EZ08dxtt+KxfHYxAe+EeFSvhah8NxjzxCeJnIj2C1tmz9hq7Zz3Hz
         6S5dEodXTEx2N3FduBbS6Zj54eWI9iba40EQE3vmJjt4S+gv4kuKBrahOKKkYvKsWO30
         XVOlfPm0sJi0ItWvKAGLmIs83UX7aoR7KK8VE38nPOrt4on3Q/CZFdbdsQ5gyfVJID0v
         f5eQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkJkA0/OV20s11tLIggVenhk15YEcUT4ed9LiCiiQKdzJFgtNgzB3C868HbNhza/gTmjR5zSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XqU2isjbQRtJx4x2BgzcTpDAKPMcoBzTPtCoQkca8TmLJDjc
	fOPZ5LXyLmGyJeTTzUYp6+eE+7yp1gbPI/TinG7ds+plP9VcPRB7rAKm
X-Gm-Gg: AR+sD10MjNeneeJmvaJZ5AfDowtHaEi3/E4sw99f5rFLq/4s2KJVB+bJZ/UuJSEYVu2
	sb34Kp++FwYzaPYdz1HZgz83n09ZJMtoaRgjmZlvV67tzYotXl7JPSJoRxVvW1J7YvoKqeTIkMS
	FFyQzDjKz8Fh/8KbI1zcCT2/pTATba3w76S7WJN79ssd/5B1Lm4Fm9ISneWHD57Ep8PWaveGxwZ
	cj17zsuf/d5fraa5xr++Jj6Q5lD3nXUJvUAn5HEEedurft8PnDG35Sdp25bw/XAtkh8zDyqIdWW
	TfZfhbAvmNTCyICffFdpEYAYyqTYg91KDpe/fy8hkLN5SpaeIF8wHerZYbiL4RwrsdLOCLFJYu9
	2KLy6hTTQuwW0pMEMBaWZMLLhzEgOp6eGph6AGqMBTial1uwat/6VLE7gpoF2uSndcdGZZue83f
	1uO8zzoRnIAqdgxA71AOperJBG+UUS2VkFarIoPoTVhVYk9pY2IzSMfwDOrPxVF2sVzabrRR4hc
	iXOEaVZy7tPN5GxJfKLJIia7ohkeVfNgk2oaFjfUfLN5D14VWKkKt6SiTuIfyRTC9QHd2Ypg4wT
	dddvRNIS
X-Received: by 2002:a05:6a21:3947:b0:3b7:807b:3cd3 with SMTP id adf61e73a8af0-3c9004d2542mr3497813637.23.1785431452407;
        Thu, 30 Jul 2026 10:10:52 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7262b8bbsm19354758c88.3.2026.07.30.10.10.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 10:10:51 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pstore/ram: bound ramoops kmsg header parsing
Date: Thu, 30 Jul 2026 22:55:46 +0545
Message-ID: <20260730171046.21412-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ramoops_read_kmsg_hdr() passes recovered persistent RAM contents to
sscanf(), but the buffer is length-delimited and is not NUL-terminated.

For a record truncated after "====1.2-C", the trailing whitespace
directive in the format string reads beyond the end of the buffer.
Malformed contents ending in whitespace can make the scan continue
farther.

Search for the header newline within the maximum valid header size, copy
the header into a NUL-terminated stack buffer, and parse that copy.
Records without a complete bounded header continue through the existing
invalid-header path and are cleared.

Fixes: 3f8f80f0cfeb ("pstore/ram: Read and write to the 'compressed' flag of pstore")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 fs/pstore/ram.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 2eb0d4fa2..ece5b90ae 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -26,6 +26,8 @@
 #include "ram_internal.h"
 
 #define RAMOOPS_KERNMSG_HDR "===="
+#define RAMOOPS_KERNMSG_HDR_MAX_SIZE \
+	sizeof(RAMOOPS_KERNMSG_HDR "-9223372036854775808.999999-D\n")
 #define MIN_MEM_SIZE 4096UL
 
 static ulong record_size = MIN_MEM_SIZE;
@@ -146,13 +148,25 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
 	return prz;
 }
 
-static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
-				  bool *compressed)
+static int ramoops_read_kmsg_hdr(const char *buffer, size_t size,
+				 struct timespec64 *time, bool *compressed)
 {
 	char data_type;
+	const char *newline;
+	char header[RAMOOPS_KERNMSG_HDR_MAX_SIZE];
+	size_t header_size;
 	int header_length = 0;
 
-	if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu-%c\n%n",
+	newline = memchr(buffer, '\n',
+			 min(size, sizeof(header) - 1));
+	if (!newline)
+		goto invalid;
+
+	header_size = newline - buffer + 1;
+	memcpy(header, buffer, header_size);
+	header[header_size] = '\0';
+
+	if (sscanf(header, RAMOOPS_KERNMSG_HDR "%lld.%lu-%c\n%n",
 		   (time64_t *)&time->tv_sec, &time->tv_nsec, &data_type,
 		   &header_length) == 3) {
 		time->tv_nsec *= 1000;
@@ -160,17 +174,21 @@ static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
 			*compressed = true;
 		else
 			*compressed = false;
-	} else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lld.%lu\n%n",
+	} else if (sscanf(header, RAMOOPS_KERNMSG_HDR "%lld.%lu\n%n",
 			  (time64_t *)&time->tv_sec, &time->tv_nsec,
 			  &header_length) == 2) {
 		time->tv_nsec *= 1000;
 		*compressed = false;
 	} else {
-		time->tv_sec = 0;
-		time->tv_nsec = 0;
-		*compressed = false;
+		goto invalid;
 	}
 	return header_length;
+
+invalid:
+	time->tv_sec = 0;
+	time->tv_nsec = 0;
+	*compressed = false;
+	return 0;
 }
 
 static bool prz_ok(struct persistent_ram_zone *prz)
@@ -203,8 +221,9 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 		if (!prz_ok(prz))
 			continue;
 		header_length = ramoops_read_kmsg_hdr(persistent_ram_old(prz),
-						      &record->time,
-						      &record->compressed);
+					persistent_ram_old_size(prz),
+					&record->time,
+					&record->compressed);
 		/* Clear and skip this DMESG record if it has no valid header */
 		if (!header_length) {
 			persistent_ram_free_old(prz);
@@ -296,7 +315,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz,
 				     struct pstore_record *record)
 {
-	char hdr[36]; /* "===="(4), %lld(20), "."(1), %06lu(6), "-%c\n"(3) */
+	char hdr[RAMOOPS_KERNMSG_HDR_MAX_SIZE];
 	size_t len;
 
 	len = scnprintf(hdr, sizeof(hdr),
-- 
2.51.2

