Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3823D7F0
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516783; cv=none; b=j24N/Ft0ayHND/HKol20tPCVGF/VaWSlUghRZuECcQ7l5No7pjDAcAOTWB7zCW/9DIf41SQCrzi0VNj/3uAs44LAcetrJx9oJY9/aLK1iDGU4/DxggJtQrRz1Uk8O+AQZ6kGg2eO6RQIRV7VCzsMP9GE7noZd2mWFDz7RtBIiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516783; c=relaxed/simple;
	bh=fLWDbsNTZMdxVcHTCqdVdGr2gSHbWMZtMd5WxH/z+N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSGDYkTlBJPpMmn0ZBReV8PXflOThjFF8jqWjHk1nCW784tVBnGRBYfIFau7IpmzYT7qZzB9HSv0gICrlTjMVzozdxeA63hmJwEdQJcEhug7l7zKx3S2vYt6tx3LGjIK0Z8MvRZiLGPntozw/GXHY9VsyIvHXGzU8ybXRXREJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8KBnJsw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8KBnJsw"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccdce28edeso1264775ad.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785516781; x=1786121581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LonlxyNI/UROq/7FsvfLYFpLarTm2H6nAAjtd6tWp9A=;
        b=A8KBnJswMfCCsCiKaMl9LP0kHw9C/Hg9MgZwxiHbk3v1r7t4WcL2bYAgSmm6+uWJwz
         NLr2IuCOX3wfl7Ey/HwEfs/YMJiP4z4/5V+lYFrvevkimlbT1qJhqGxrQm76o2fxjmsJ
         xXNSp7uTY2y4AkjNvJW2sF0SHFcN75jPs9qstJqedSBaHmKXBdHR1L/HAfOYMTgUDVlp
         jkniZGYhOlWH7VIOuMkSTaMOS45m6TBYzJCv6LJxi4F287GqtX11nsi69Zs8D5cBXYIN
         d0flwYm6Wsk2yQUEC3t96hPxlZUhVGpls6VKrBHOb/6m+aeNVvpJlTEsrF7Z5+34fJsO
         e+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516781; x=1786121581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LonlxyNI/UROq/7FsvfLYFpLarTm2H6nAAjtd6tWp9A=;
        b=pbWuLYUIG5Cc2MhTAs/eM4NQLPr7HlAJhnC/75tJdBFSEN3Bs+9M9wyl+DLejpQCfH
         wjp/WM/v8au8pPUm6PweRblaV9kdi5Q2fk2s3EMC3DjvL6TKowuJf0g3THCPi7aV35Nw
         oZyJKfqKnDjwk9lkg5YjAVH8IrRt/BhLivn8DIGbBqFR4R1J89/lEM6ZN1w3CqL/9vv6
         GgbCof3xGTBQpzJjUmWhKqvHtSB6ZwcCPZQ7rR209Gfu3/JA5r4Smya8DDkDA6zpOKKG
         o4wcjQQ3QHf6SWzv62ETyLfJeKrK/OpnzAs4cYWkz1KO11yeCgrC4rcHhfBIRg6yujiz
         k5uA==
X-Forwarded-Encrypted: i=1; AHgh+RoQzH5QM17g+IVutvM14QAPBLcxHTDjF0Hb6DlAtucqlKdmd31LwI3lg5A2ME/TiN2zXpeUKXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykc7V3TNd3ot9ExsrtcTLYBdJ+/WNaIgJ7Uagrb1ZOs9Dk7Gzd
	CfEAUC9xjmdYmZS8FOQtHFl/CH9/y93Zwm/07nEEiKDPwt7CdoRBQ+FK
X-Gm-Gg: AR+sD1280zI78ecQ9BiVqeN9prw5Sat7aBMdLBGRKIX9bu42fgHCL7uCoXDk8l8WT9N
	wY/Y23H+XzSX4nzgOJOcZLkYLMF3e7gZvbFPckjvB1UcObQtLTZjoJyxMHY6z/Yy1gS9Sfp9tBM
	xwMdYf9lTVkuKRtLph7iIPoDVVbNxThQIGWDB0dkE0Xk65aLiUe7G0ZlR7cJUJzyVSLIgVOaNQg
	DxKHM510FMkM3mwwQpbLNqvccCZ1/R2+b8PLHLojAIkCqAA7sExs6UvrGr5gyq8VpYC+06L3IuA
	UqHOMPeSc45BFuxT0N0z9H57wbwh7KLdxBA4eLyG6t6eoZg3vCvzf7xU6csjswHET3y+VJG/IjD
	sMnQVcu9FmGnj/oYEVGnWApEgcHDMSvYtwwyLCwy6oaTwm3FaFHs3RngVucPr8w4Xe4hxscDCAQ
	rlk0GUynTVu+q1aPNjYROwco9tjM1dMzA91QFjfd//YLxEi06HAGHI3A==
X-Received: by 2002:a17:902:ced1:b0:2c9:fbde:ab68 with SMTP id d9443c01a7336-2d0523c0f5emr9691545ad.3.1785516781082;
        Fri, 31 Jul 2026 09:53:01 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddda5d9sm10399096eec.13.2026.07.31.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:53:00 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] soc: apple: rtkit: fix OOB reads in crashlog parser
Date: Fri, 31 Jul 2026 12:52:10 -0400
Message-ID: <20260731165210.113227-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apple_rtkit_crashlog_dump() parses a binary blob copied from a shared
memory region populated by the RTKit coprocessor after a crash. The
blob is treated as trusted structured data, but four distinct bugs
allow a malicious or compromised coprocessor to trigger out-of-bounds
reads against the kernel heap:

1. Section header read without tail-space guard
   The main loop is guarded by (offset < size), but the section header
   occupies bytes [offset, offset+16). A section starting within the
   last 15 bytes of the buffer causes the memcpy at offset+12 to read
   past the end of the allocation.

2. section_size not validated against remaining buffer space
   section_size is a u32 read verbatim from the coprocessor blob.
   It is passed directly to each handler as the 'size' argument without
   checking offset + section_size <= size. Every handler therefore
   operates on memory past the end of the shadow buffer. Additionally,
   section_size == 0 causes an infinite loop because offset never
   advances.

3. dump_mailbox: size_t underflow when section_size < 28
   n_messages = (size - 28) / sizeof(entry) performs size_t arithmetic.
   If the coprocessor reports section_size < 28, the subtraction wraps
   to ~0UL, n_messages becomes enormous, and the subsequent memcpy loop
   reads and dev_warn-logs arbitrary adjacent slab memory, constituting
   a kernel heap info-leak.

KASAN confirmed (kernel 7.1.0, QEMU/x86_64, kasan_multi_shot):

  BUG: KASAN: slab-out-of-bounds in apple_rtkit_crashlog_dump.cold
  Read of size 24 at addr ffff88800469f08c by task insmod/60

  Call Trace:
    kasan_check_range
    __asan_memcpy
    apple_rtkit_crashlog_dump.cold
    rtkit_poc_init

4. dump_version and dump_str: bare %s with no NUL guarantee
   dump_version() ignores its size argument entirely and passes bfr+16
   directly to dev_warn() as a %s argument. If section_size places the
   section end before a NUL byte, dev_warn walks arbitrarily past the
   allocation. dump_str() has the same issue in its else branch: memchr
   correctly bounds the search, but the resulting pointer is then passed
   to dev_warn() as %s without a NUL guarantee within the real buffer.

Fix:
- Check offset + 16 <= size before reading each section header.
- Reject section_size < 16 or offset + section_size > size before
  dispatching, ensuring every handler receives a size bounded by the
  real buffer. This also eliminates the infinite-loop case.
- Add an explicit size < 28 guard in dump_mailbox() to prevent the
  size_t underflow regardless of the outer check.
- Replace bare %s with %.*s in dump_version() and the else branch of
  dump_str(), using the (now validated) size argument as the bound.

Attacker model: any entity able to influence RTKit coprocessor firmware
or crash-log shared memory (coprocessor compromise, DMA-capable
peripheral on the same interconnect) can trigger these bugs against any
Linux system running Asahi Linux on Apple Silicon hardware.

Fixes: 9bd1d9a0d8bb ("soc: apple: Add RTKit IPC library")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/soc/apple/rtkit-crashlog.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/apple/rtkit-crashlog.c b/drivers/soc/apple/rtkit-crashlog.c
index 8319e3651..3af17c31d 100644
--- a/drivers/soc/apple/rtkit-crashlog.c
+++ b/drivers/soc/apple/rtkit-crashlog.c
@@ -81,8 +81,8 @@ static void apple_rtkit_crashlog_dump_str(struct apple_rtkit *rtk, u8 *bfr,
 			*newline = tmp;
 			ptr = newline + 1;
 		} else {
-			dev_warn(rtk->dev, "RTKit: Message (id=%x): %s", idx,
-				 ptr);
+			dev_warn(rtk->dev, "RTKit: Message (id=%x): %.*s", idx,
+				 (int)(end - ptr), ptr);
 			break;
 		}
 	}
@@ -91,7 +91,12 @@ static void apple_rtkit_crashlog_dump_str(struct apple_rtkit *rtk, u8 *bfr,
 static void apple_rtkit_crashlog_dump_version(struct apple_rtkit *rtk, u8 *bfr,
 					      size_t size)
 {
-	dev_warn(rtk->dev, "RTKit: Version: %s", bfr + 16);
+	if (size < 17) {
+		dev_warn(rtk->dev, "RTKit: Version section too small: 0x%zx",
+			 size);
+		return;
+	}
+	dev_warn(rtk->dev, "RTKit: Version: %.*s", (int)(size - 16), bfr + 16);
 }
 
 static void apple_rtkit_crashlog_dump_time(struct apple_rtkit *rtk, u8 *bfr,
@@ -112,6 +117,11 @@ static void apple_rtkit_crashlog_dump_mailbox(struct apple_rtkit *rtk, u8 *bfr,
 
 	memcpy(&type, bfr + 16, 4);
 	memcpy(&index, bfr + 24, 4);
+	if (size < 28) {
+		dev_warn(rtk->dev, "RTKit: Mailbox section too small: 0x%zx",
+			 size);
+		return;
+	}
 	n_messages = (size - 28) / sizeof(entry);
 
 	dev_warn(rtk->dev, "RTKit: Mailbox history (type = %d, index = %d)",
@@ -206,8 +216,20 @@ void apple_rtkit_crashlog_dump(struct apple_rtkit *rtk, u8 *bfr, size_t size)
 	offset = sizeof(header);
 
 	while (offset < size) {
+		if (offset + 16 > size) {
+			dev_warn(rtk->dev,
+				 "RTKit: Crashlog section header out of bounds at 0x%zx",
+				 offset);
+			break;
+		}
 		memcpy(&section_fourcc, bfr + offset, 4);
 		memcpy(&section_size, bfr + offset + 12, 4);
+		if (section_size < 16 || offset + section_size > size) {
+			dev_warn(rtk->dev,
+				 "RTKit: Crashlog section size out of bounds: %u at 0x%zx",
+				 section_size, offset);
+			break;
+		}
 
 		switch (section_fourcc) {
 		case APPLE_RTKIT_CRASHLOG_HEADER:
-- 
2.53.0

