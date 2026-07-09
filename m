Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5622727FD
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603157; cv=none; b=KfnRBPRvqMbocfTYlioKAelLXYKMYOI31rFS2Zb18l72YJCkG5p8kY9MZF1lRJJjVc7n5VpNgET2lRbyIlVlIWz+ii5sWHpr0kpLBN20wrvjEQIMCLcjLWlm5mHiH9J/zTku1U0PPwveBBSD7VfryQ0Ntdl4uEPv7A1Y5SgpvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603157; c=relaxed/simple;
	bh=T2u541qQ+z0RnOgRw7bMFV+eieAFDFj+xTZQdyN6NUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvH0kPej4bd0WBm2im5X2trg2/mpqEkJ49chpY/4vJ6k4gXTG1KQfs86GEH9L2dWOV8JQytjreBzjQvVGau1uCBtSJg5xmYAsknWHHL638XvjP+/fDqYXHX4j73nU4/s47+yvCiYaZWGGr3qqKLhmvzB70Gnx7BebR2USY0UemU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6/Mznt+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6/Mznt+"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c96cb024ee0so570084a12.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783603155; x=1784207955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m7teN60MU+Gp3txyOBv3fyoxyVU/6erlMzYso9Y2plQ=;
        b=l6/Mznt+FGL/bWtEUKO3r2NizjJJevQ9Gq1H+lIT6FNmQnaeu2CWVEkqlBjNwuvtRR
         WLR177Hmquwc/TxwcEPyetBSK0LW6CECzJns0Esh6bKEKmjXYOFjAzG8IQ9PDASO/vrE
         TScS64zKMi7ulSP3SKjQ2AddN1vkvFvQzJwbSZwPsvN4HaBVl4KxubwaVeiBCSd+hgKM
         SFYKssapZldO4tXcsvNaUl6UTb/phZwv147+ZtfvGGsPtgYttBR46uB/yBleqs48gwl2
         haPdH2SdVbly/aFPdvHW7Boojp2itGJwpFb+dZb5QaPsy4jLqOUnb6RU8OKzrXN3YQ/B
         k4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603155; x=1784207955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m7teN60MU+Gp3txyOBv3fyoxyVU/6erlMzYso9Y2plQ=;
        b=eZEY9VNdlwykNew/PYAKGOt7CcG9gCMcKDRXKmgrN1HKEP16kpOgXCNutIYEJxmItQ
         hlRvb2GqvVHVepVGEvf9mcz8aVCI4qGmUOE1DTu420LfazyR3WPYsSjsz3bOZdDKo/h8
         O0H2OCEw1FRn0aG2E7ehMM6g6rletYbMIP8QX9Di9L0J6zE5DkMNuo0anjgb7Xh/nhgx
         MRKj5hTWGA9IpEf6Z6z9BVjR247pPAVCbtegHPgBJ5DZZmtVD1ZIHykyAbnAuWnOWZVf
         0QI2ydYhLhpEnP/Vk1r5ZxYKhrS7P0WtEWuO8ySV0ARMe+yuuSuZiHML4c3Zd3r2ehY6
         lTPA==
X-Forwarded-Encrypted: i=1; AHgh+RqZlnokCNSDghUjQb7zB2lcYpY5GOUFbR62p0bgUxRcU0SAof2TAukTy642g99QZ7/WC0f0sZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UPjWX0sQIflcmeDFYe8zG6GfjIpuu5to9heUusyeptWJpnAy
	KnDcRoSZR92oAs+8JrOfUCreX/oYzqmuXmcDUKzghcZAbjrSCLlxX9ixZ3/4qpr/hQ==
X-Gm-Gg: AfdE7cmSE4ewtvRioIaf0Bnjl80mXdXEQ8FOh8f4uOUTKkzuJ1Q1P0ApdM9Pz5/1/Jc
	EQrIsTvx62MuF8Aeg5kiD2mAOrbiBCSJbmM17XcPywCYLnxHj9lEMDskWVs5p/+5c8p57fre1av
	3aihcleSn2iTtDJbu0bIe4eZ51SztXLqyGasUZSS+WhGy1ZerYa8QJCQR8ggkfREPCypDIeVWMT
	nk3MFcP8725At/T6ggTnKOQmmna5x/1QIC3aNZywpjtMZjueQicvn6ENEvluclqpAv6jW0j5fpI
	2kdI69TNRaSSW0vhit7i8AEOSW/wBExvOb3AvtatrXwdPjmbwhX9cljGyH/pb9SXbrHfTIgq1zi
	bTTzBP9NqCgGeOWjG3Vl+Xy89oFJCBhKr6VqFnY/n+A53Cci7F3/VzC9EwcwVxe16mOaq+6SLH0
	imqaYx1iUCgUd5rqqeC7Z85NgoSST/HeC5//se577Ykbzjn8mWb23xrlvXMbCDCbJo
X-Received: by 2002:a05:6a21:3a85:b0:3c0:9c18:d5ae with SMTP id adf61e73a8af0-3c0bd23f657mr8729454637.75.1783603155192;
        Thu, 09 Jul 2026 06:19:15 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([58.146.106.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm33960852eec.31.2026.07.09.06.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:19:14 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: colyli@fygo.io,
	axboe@kernel.dk
Cc: gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v6 2/2] badblocks: validate sector range and shift before rounding
Date: Thu,  9 Jul 2026 18:49:04 +0530
Message-ID: <20260709131904.596684-3-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709131904.596684-1-adhikari.resume@gmail.com>
References: <ak9CC591ivuQ4BP1@studio.local>
 <20260709131904.596684-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_badblocks_set(), _badblocks_clear() and badblocks_check() round
the caller-supplied [s, s+sectors) range to the current bb->shift
block size before touching the bad block table. That rounding
was not defensive against a few cases:

- s + sectors can overflow sector_t (u64), wrapping the range
  end before it is ever compared against s.

- bb->shift is a plain 'int' field, populated in one case
  (drivers/md/md.c, from the on-disk superblock's bblog_shift)
  straight from an unvalidated byte with no upper bound. Shifting
  by an amount >= the width of the shifted type is undefined
  behaviour in C; "1 << bb->shift" was shifting an int literal,
  so this was already undefined for bb->shift >= 32, let alone
  the full 0-255 range bblog_shift allows.

- round_up()/round_down() rounding a value near ULLONG_MAX can
  itself wrap back to a small value, so even with a valid shift
  the rounded end of the range could end up smaller than the
  rounded start, silently turning a small range into a huge one
  (in _badblocks_clear()/badblocks_check(), which round the end
  up) or losing the range entirely.

Add an explicit s+sectors overflow check, reject any bb->shift
that is too large to shift a sector_t by, cast the shift operand
to sector_t so the shift itself is never performed on a 32-bit
int, and detect post-rounding wrap by comparing the rounded
result back against the pre-rounding value.

Suggested-by: Coly Li <colyli@fygo.io>
Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 block/badblocks.c | 52 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 1f786b193fb..00a59729600 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -853,12 +853,23 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* Invalid sectors number */
 		return false;
 
+	if (s > ULLONG_MAX - sectors)
+		/* Range wraps past the end of sector_t */
+		return false;
+
 	if (bb->shift) {
 		/* round the start down, and the end up */
 		sector_t next = s + sectors;
 
-		s = round_down(s, 1 << bb->shift);
-		next = round_up(next, 1 << bb->shift);
+		if (bb->shift >= BITS_PER_LONG_LONG)
+			/* Corrupt/unsanitised shift value */
+			return false;
+
+		s = round_down(s, (sector_t)1 << bb->shift);
+		next = round_up(next, (sector_t)1 << bb->shift);
+		if (next <= s)
+			/* Rounding wrapped past the end of sector_t */
+			return false;
 		sectors = next - s;
 	}
 
@@ -1061,7 +1072,12 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		/* Invalid sectors number */
 		return false;
 
+	if (s > ULLONG_MAX - sectors)
+		/* Range wraps past the end of sector_t */
+		return false;
+
 	if (bb->shift) {
+		sector_t orig_s = s;
 		sector_t target;
 
 		/* When clearing we round the start up and the end down.
@@ -1070,10 +1086,21 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * However it is better the think a block is bad when it
 		 * isn't than to think a block is not bad when it is.
 		 */
+		if (bb->shift >= BITS_PER_LONG_LONG)
+			/* Corrupt/unsanitised shift value */
+			return false;
+
 		target = s + sectors;
-		s = round_up(s, 1 << bb->shift);
-		target = round_down(target, 1 << bb->shift);
-		sectors = target - s;
+		s = round_up(s, (sector_t)1 << bb->shift);
+		target = round_down(target, (sector_t)1 << bb->shift);
+		if (s < orig_s || target < s)
+			/* Rounding wrapped, or range collapsed */
+			sectors = 0;
+		else
+			sectors = target - s;
+
+		if (sectors == 0)
+			return false;
 	}
 
 	write_seqlock_irq(&bb->lock);
@@ -1303,12 +1330,23 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 
 	WARN_ON(bb->shift < 0 || sectors == 0);
 
+	if (s > ULLONG_MAX - sectors)
+		/* Range wraps past the end of sector_t */
+		return -EINVAL;
+
 	if (bb->shift > 0) {
 		/* round the start down, and the end up */
 		sector_t target = s + sectors;
 
-		s = round_down(s, 1 << bb->shift);
-		target = round_up(target, 1 << bb->shift);
+		if (bb->shift >= BITS_PER_LONG_LONG)
+			/* Corrupt/unsanitised shift value */
+			return -EINVAL;
+
+		s = round_down(s, (sector_t)1 << bb->shift);
+		target = round_up(target, (sector_t)1 << bb->shift);
+		if (target <= s)
+			/* Rounding wrapped past the end of sector_t */
+			return 0;
 		sectors = target - s;
 	}
 
-- 
2.43.0

