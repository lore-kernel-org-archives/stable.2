Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A51331EDE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652203; cv=none; b=Pfmyjn1uEZbXolXbZkdKa1GedoVehvOK9dSsu8pILJgHhUQxmSbZK4Jv5Ee3EcqMvbo+RrIcuAVLn7IjEg1wkthZ4axkVoIDaFQeIE2n0ymqZT5Kv4zKQUDl+J2xxbXbloEehv2Qucd/gLGLQ5iyZsSNZ+qUiOpkch2kF4nm1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652203; c=relaxed/simple;
	bh=19IcGc/7CN6FJaWvzPDso+RUb7gKc7Q9cSuKvJGU2UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmVeb/UvzCzyIPtlVYQSXPotz/6/dw4Yh5Kc3Idc9m8D4m2/UQEJiVfoOPo7Y83xv8x8EC6hmw76Kecy/lnTv+Sb6uwhzTsx5udQyhtseQZP0Xm5hty0oXhRSzuJXAQFD4QcIGzYyeOi8/+eR8GzUk1Fy5pLc4QFQkKg6hTVr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdqpjufC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdqpjufC"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e0a4334b6so683569b3a.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784652201; x=1785257001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0YEU1On5Z9QygyW7afm3G5c7ueZM2Z9hLMwsovoUjpM=;
        b=VdqpjufCCkyvdUI7RFBpMfumeM7N33uOLXZShg36bm5xGavnt2Ida3uYY4D8wpTsN9
         mT9TwG+8Gm6CLDsVvrZCJfBUIPgVYn46+9U7xURwfVEPfVj/97GUZD7A7IOOu0LZkzRN
         Q/R43aZ+2xvOye/0CAIheBJFhOR3kQL/21ttSsPvly4vCkX3URbFf5v37X0NPM8yrjAk
         jSA4oUGh1EH1B7GSo9k9koL5Zwa5IxRqb7KhNnLGHXXAsiOnLdlaM4XiI2RrjxVQSZHx
         klvSL4ewMbfHUb/nJes+S7z56qqdZOYkiZxPttoabNq1D+qsC9jSCVhPCivAvWMX9MQ7
         6Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784652201; x=1785257001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0YEU1On5Z9QygyW7afm3G5c7ueZM2Z9hLMwsovoUjpM=;
        b=js+cP6l7oLqhGkWYw5v3B8gbjuCGUHz3EZA+jmHtAiZwYIfatWeOb6kiZMF8iZE6sR
         c6OUh6HtE0l0Bbc9Io5S57KQTGSkxtbB4HVryWLjo7fw3R5NbQ3jWHVT5i9DJc0xupRh
         F42WMIXtISgub8It5I/Tyh2JQabGlfgCdYw6Vt7NzYud2aaXT8oBIhQGg+MLdza4yIZ9
         BUa2T4aXr0yR5R5QIZFVm5/67HAKI0D1T9GNA5g4RjULuUyzvmcUE1pUiv84QhtYmHwb
         K3X+1OqhcsRg+54AsZ+RRpDUWBLu0EW0PHD0/AkbLEi0vfWsKrNiR0ewWg+YxZk6CEs0
         LkMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrhd+LKPfpQlhgL/T02iMgxmDIJNkCPpWHHZ5lFnvl1lt0YqM1VGjE0tiuIfDtzgQVxBQWKsB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNiGu7vLDrHCOMt6f+qFpvVi0Fjra0KGg/xcTFgcIoSPWwrbBb
	tRUq3XPoVBFT9rWRaOjjbKnZ0ituvPaU7eZ+TocMmXx/vvsQH4BT71o=
X-Gm-Gg: AfdE7cn1HAfvVZim8BfoaUCGekcxo554wQRY4TIZONVCmP0utSSbPq7DlcrNpmA3hh3
	eQ887YQwxC0/xT+tK02H7JQqn8JfmC/DqetjhwulEtnw4KqWAve6vNI0kg9IfDPUsbS0oZK3qgG
	7VX99FRtOclUmlEmSB2waqjRiT44HLGejwga6OLRG1ocH4qsOueKy9EXBCTJo0zKaFvd02nFxBa
	pKiV22cynGuDwiJ3yk28tDxcLKrab07qXaCzXgzMauFKSfF3PzkDZ0NgUCJV0d9CETQoV4Ppkqn
	PD9a1638TOz7PsUm8QpfC1wjmecOqGotxYW484Y3dY1NcSy2j0lrY5OTkquv1HwUdHU/2uqCE9D
	4456SD7VtdXiXasiNAGJUF8N6tXuWGwQaq1wZccw8vwU6WjWPHXRtC6ptQ2tktahAxQcbK5EiDK
	hubQi5xPY1Eo4MI1mOado5XOmcNQLEkwW5XPLIHcb5VNvBvMSgLC1PhA==
X-Received: by 2002:a05:6a20:9397:b0:3bf:6c08:fb94 with SMTP id adf61e73a8af0-3c3ada37416mr20565979637.54.1784652201182;
        Tue, 21 Jul 2026 09:43:21 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1c7ff4sm447487eec.27.2026.07.21.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:43:20 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: colyli@fygo.io
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v7 2/2] badblocks: validate sector range and shift before rounding
Date: Tue, 21 Jul 2026 22:10:24 +0530
Message-ID: <20260721164027.637078-3-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721164027.637078-1-adhikari.resume@gmail.com>
References: <20260709131904.596684-3-adhikari.resume@gmail.com>
 <20260721164027.637078-1-adhikari.resume@gmail.com>
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

Add an explicit s+sectors overflow check and cast the shift
operand to sector_t so the shift itself is never performed on a
32-bit int, and detect post-rounding wrap by comparing the
rounded result back against the pre-rounding value.

badblocks.c does not itself bound bb->shift: every caller except
drivers/md/md.c always leaves it at 0, so the one caller that
populates it from untrusted on-disk data is responsible for
bounding it before assigning it, per struct badblocks's shift
field documentation in include/linux/badblocks.h. That md.c-side
bound is being sent as a separate patch.

badblocks_check() returns 0 rather than -EINVAL on the wrap case,
matching its existing "0: no known bad blocks in the range"
return convention instead of introducing a new error path callers
don't expect.

Suggested-by: Coly Li <colyli@fygo.io>
Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
Changes in v7 (per Coly Li's review of v6):
 - Simplify the overflow check in all three call sites from
   "s > ULLONG_MAX - sectors" to "(s + sectors) < s".
 - Drop the "bb->shift >= BITS_PER_LONG_LONG" guards in badblocks.c.
   Only drivers/md/md.c ever sets a nonzero bb->shift, so the bound
   belongs where bblog_shift is read off the on-disk superblock, not
   scattered through the badblocks API. Documented the caller
   requirement on struct badblocks.shift in badblocks.h instead; the
   md.c-side bound follows as a separate patch.
 - badblocks_check() now returns 0 instead of -EINVAL on the wrap
   case, consistent with its existing return convention.

 block/badblocks.c         | 40 ++++++++++++++++++++++++++++++++-------
 include/linux/badblocks.h |  6 +++++-
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 1f786b193fb..728b59a1a5d 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -853,12 +853,19 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* Invalid sectors number */
 		return false;
 
+	if ((s + sectors) < s)
+		/* Range wraps past the end of sector_t */
+		return false;
+
 	if (bb->shift) {
 		/* round the start down, and the end up */
 		sector_t next = s + sectors;
 
-		s = round_down(s, 1 << bb->shift);
-		next = round_up(next, 1 << bb->shift);
+		s = round_down(s, (sector_t)1 << bb->shift);
+		next = round_up(next, (sector_t)1 << bb->shift);
+		if (next <= s)
+			/* Rounding wrapped past the end of sector_t */
+			return false;
 		sectors = next - s;
 	}
 
@@ -1061,7 +1068,12 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		/* Invalid sectors number */
 		return false;
 
+	if ((s + sectors) < s)
+		/* Range wraps past the end of sector_t */
+		return false;
+
 	if (bb->shift) {
+		sector_t orig_s = s;
 		sector_t target;
 
 		/* When clearing we round the start up and the end down.
@@ -1071,9 +1083,16 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * isn't than to think a block is not bad when it is.
 		 */
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
@@ -1303,12 +1322,19 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 
 	WARN_ON(bb->shift < 0 || sectors == 0);
 
+	if ((s + sectors) < s)
+		/* Range wraps past the end of sector_t */
+		return 0;
+
 	if (bb->shift > 0) {
 		/* round the start down, and the end up */
 		sector_t target = s + sectors;
 
-		s = round_down(s, 1 << bb->shift);
-		target = round_up(target, 1 << bb->shift);
+		s = round_down(s, (sector_t)1 << bb->shift);
+		target = round_up(target, (sector_t)1 << bb->shift);
+		if (target <= s)
+			/* Rounding wrapped past the end of sector_t */
+			return 0;
 		sectors = target - s;
 	}
 
diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
index 996493917f3..5d88992b55a 100644
--- a/include/linux/badblocks.h
+++ b/include/linux/badblocks.h
@@ -34,7 +34,11 @@ struct badblocks {
 				 */
 	int shift;		/* shift from sectors to block size
 				 * a -ve shift means badblocks are
-				 * disabled.*/
+				 * disabled. Callers that set this from
+				 * untrusted/on-disk data are responsible
+				 * for bounding it so 1 << shift does not
+				 * overflow a sector_t.
+				 */
 	u64 *page;		/* badblock list */
 	int changed;
 	seqlock_t lock;
-- 
2.43.0

