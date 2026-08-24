Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611A394462
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612206; cv=none; b=Ne6YsR7g8E5qZUEhBZMn71OayY+rWeb8KROWoR/J2cB8a0ulrNC0RHXKIguFr7GXNzYkRIJ2Hq5THpy7ijX5djLigjGwhKD5t1C0dovP9B2NAW3JKemucCVRj8BwRDD/DVKi5ZHMw4Bu6YktMXyNgyjzoZfeVNU4JAyJKEYuS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612206; c=relaxed/simple;
	bh=bZ4mr1I+U3yQOcHz6Hb3G8cgJFdB2crR9bfGO93EcxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1M6gZissVMOOhzksK6NeT/XGWxWg+dsJLJAFoFmDOexiahEa+UCAMnaurnZ4FbUsxyCe7bZUgGTuq29czcyffnUUaynaJ9VqDFp884V0HvNJq4nJfzjaP2V9M/QouCpMX00ZynxzVWhfzsxMV8eL6zjxQBE5zkVig8MdpfqnnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTD6BGVV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTD6BGVV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caed617615so40778905ad.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787612204; x=1788217004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/9Tw605kJhO/LEd8BNi1zuUQuVwSe01S9ZMwxtVDwiw=;
        b=DTD6BGVVBaztfIxvOtHQiNN6sf6RmZxqmXpCGTSejrbPhEBYrRQaeTMdRg3cYndJLY
         2DwThrpbCYCgDlHXvODNrHhLvFgSseTVTeYGwzK4MQwpHmggHg9wauY8SIlpU2OaPmr4
         gou72JIPt3RsOfGrgYZ5qLOfYckuftaigV/ciipdR+mFl8qZd6UoEBakNj8IfEF3v5nh
         WFtnIG8qFAJrK1KLB5yUQbiogLLRhKLpgdyc4vpMyRITtC3RspFAuNz5YTY2LZesGK7E
         ZvRrz0WLXBuINsqcfMWz7/yYxjYEETiIMt2flMLeTKDv5O0PB08Cs1WfCUn3EMb16jz/
         XyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787612204; x=1788217004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/9Tw605kJhO/LEd8BNi1zuUQuVwSe01S9ZMwxtVDwiw=;
        b=kHobzve0a1lOdoPMjFJhMb6ajhunJjOVLScAUiJCqK60qSSkj3asCZusroXragfqPD
         idf4KnGlUIdO90VUtThe3E1qW0kRZtG6YhG06z7YACzD2z/y5hMcyJgVBrJP7rq0NTrM
         Np//VZ89Y7L/S7XDTDh5aFs7V94hlUfkv6IGbRgOVxUY4sMpb43Efa6cK5RIuejUEhff
         1DZnZCD22VjAkLtCzcnb0DclxRpyj0QSpVyNLg4v3C8c2LNKP79/XnleOQDYckPnhn3L
         e8teXdgY51yrRtFGnriuY1aqoT5wm4bRW8/ifXAvuQEqviojHl7aIW4SfNHg84Aun/AQ
         Jp6w==
X-Forwarded-Encrypted: i=1; AHgh+RotIanR7YgjpvNXs/qTbH1kZDGS3/1Y6E3rq1pNhIzaR1ppGvc8haKtmtIWjM9pK1lO+Yig7Go=@vger.kernel.org
X-Gm-Message-State: AFuF++mo5CZg7mI+xHer24N7gR8yk5a0JM3WHE5TCd+kDCyUf3+laeWo
	xjxJv9hiLAClXsDAWTkI+l7sYjkwvoVRYnFqGMiZm1cvcGmWCSOE17bn
X-Gm-Gg: AR+sD13NIszbRpsOyBYWmIsHqgynTVbIA7yQDwuJtS3lsZ5mp6b7uw3Xn9uTstLOn7l
	CQhcCdgeTDCqVRIsEPF+c6jv3EkziqxIUcDzXI61oLHuXaVlLVVigIXhKjjEujTLHAwPcaweHXG
	3UJOhEgU6lAlHlyZA5ZWZyLUfzFVjBXvvc7lnrDlSwZisM4rC2Uq0yAbO562m6t0D3oWXlvOpow
	XVMQfaPuxxUYoS+e4vv3G6gzCJeOEE1486i9IzgtSckloj+NurFps/z19JAR3sv7tSLtQAo6U6a
	PH3KkmtfCU2HHRpUfKI1RcE3EUePS/+LPvaI2W7Z7ehEi6ERY8adEuEo8fZtD6i+5NTEMdHskJU
	5Aku+jdGJvndjwlrqLFBKNemIuKnwdLJSmvhvz8/qrgQoWddut7PjAHRbsfH3zCO8WZqSjQLrEB
	tm+TFeVre2nqrAoquZuFMXoxyJVxokZ7YQriIzGPXZzU5nk+z5L8YL8B0sxnRQSkSk/dAYJgUnS
	bLto2UHNwfSl1ZoGrvijzFRN2gk7JM3Kniv9LjEbyc+WnmS0GzH
X-Received: by 2002:a17:90b:39ab:b0:393:19a3:4e5 with SMTP id 98e67ed59e1d1-395df686f1dmr38241564a91.16.1787612204546;
        Mon, 24 Aug 2026 15:56:44 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328272232besm1527287eec.21.2026.08.24.15.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:56:44 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 1/2] platform/x86: hp-bioscfg: fix OOB read in hp_get_integer_from_buffer() on unaligned input
Date: Tue, 25 Aug 2026 03:56:09 +0500
Message-ID: <20260824225610.18471-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824225610.18471-1-meatuni001@gmail.com>
References: <20260824225610.18471-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hp_get_integer_from_buffer() aligns the read pointer before dereferencing
it:

  int *ptr = PTR_ALIGN((int *)*buffer, sizeof(int));

When *buffer is not 4-byte aligned, PTR_ALIGN() advances ptr forward by
1-3 bytes to reach the next aligned address. The bounds check that
follows does not account for that advance:

  if (*buffer_size < sizeof(int))
          return -EINVAL;

This only confirms 4 bytes remain from the original *buffer, not from
the aligned ptr. If *buffer is unaligned and *buffer_size is between 4
and (pad + 3) bytes, *(ptr++) reads up to 3 bytes past the end of the
buffer.

*buffer_size is also under-decremented on every call, aligned or not:

  *buffer_size -= sizeof(int);

*buffer is advanced to the aligned, post-read position, but
*buffer_size only accounts for the 4 bytes of the integer itself, not
the alignment padding skipped to reach it. Each unaligned read leaves
*buffer_size overstating the true remaining space by the pad amount,
an error that compounds across repeated calls against the same buffer
(hp_get_common_data_from_buffer() calls this in a sequence), making
later bounds checks against *buffer_size progressively less reliable.

Compute the padding explicitly, check for it, and account for it when
advancing *buffer_size, so the pointer and the remaining-length count
stay consistent with each other.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 0edc6e7cfa9a..32b99a862082 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -39,14 +39,18 @@ struct kobj_attribute common_display_langcode =
 int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *integer)
 {
 	int *ptr = PTR_ALIGN((int *)*buffer, sizeof(int));
+	u32 pad = (u8 *)ptr - *buffer;
 
-	/* Ensure there is enough space remaining to read the integer */
-	if (*buffer_size < sizeof(int))
+	/*
+	 * Ensure there is enough space remaining to read the integer,
+	 * including any padding PTR_ALIGN() introduced to reach it.
+	 */
+	if (*buffer_size < pad + sizeof(int))
 		return -EINVAL;
 
 	*integer = *(ptr++);
 	*buffer = (u8 *)ptr;
-	*buffer_size -= sizeof(int);
+	*buffer_size -= pad + sizeof(int);
 
 	return 0;
 }
-- 
2.55.0

