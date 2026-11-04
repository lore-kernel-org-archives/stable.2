Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817883;
	b=as5WLgknL+euC2p27IahUGVVR/ebh/jyVUGubYQF5CWs1MLRxpeZIBe5Kbaf62sSOjaE
	 skVMtvGEBbvHz7H0k96RDbLnkwCyYhn+kUk6ZViVxTHD9kNlt2XxKxZ3/y4jnF7Pmp2OE
	 uSqpAfeVBRM9KGAIX0PNr72horYoW/+y4Lz2SHb0Q0FHMuISimbpShASt6+zd5LGa2EUk
	 RBdu6EOaEs3hvTexY6LUwVDu04Ju/m+3BF+5gfVOJciW1pzKz52qvLWIFvEzKyogUsTgj
	 bDgxbwjwJy5K3IcrFrQExsa6dHxBFOxqiahD+3v1b7IdSeyHQ7mU7MKH+AhN46UHhxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BKgadK2I/GgNvZDn4Xm20+I35igbD6d8qDSMaHto9bI=;
	b=XNaWZepf+lP3JGZlYtrxQVvifECUM7cOgXImMM3OJusfGjVzJCfONYi5Tx9dWdMj4m0i
	 xusoQ9hKWJ5U+buqPiXuk5F633s5gmMCA+ipOAcegF3yA/XJ8GJxvFo+H5QTvCsmsWhf3
	 6IfUoT76eJjalEHsHdXGwiOknJVWQ/1uycwr/6bAVCC3Gu2V5fU7HVffbdOO5fY7vgQ8t
	 q5yiPXo26AEInavA0e9yyk11VzqkSlUPAawsW6qDuwwzTI6/UGXdLqdBcc5mrdN1CotaC
	 r5z4O4EjgjdprMG3DqFCyS3lY/JQuw8Ju7s+syI1kEEE2iylW3O+Wlx8kPu+Ol1k0Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kmDd05dT;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97504606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97504606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kmDd05dT
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-833e671ee9fso1031548a34.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817881; x=1794422681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BKgadK2I/GgNvZDn4Xm20+I35igbD6d8qDSMaHto9bI=;
        b=kmDd05dTpZGJ9mPeu1Ip8CQhohdc8D9lZpGUQCDUjR710K9qXyfYQPx1gjiTra6mau
         QaqQmbcnk264FAKK/JuSWPvSA0ox/UunJ9d3B9ymqdMAV9TLr+Z6rFKj1Urnh6EzaeN1
         bc+yFwhxf3Qk2YbH5y+c+UqKqyi674oZGEO+LPvbGDSYLqehHRpeaYsmUiPf8miWRJ+h
         6dz73t1keVXxjp7obEIYbMJbYa43SQhmiBv+CS5C+/Pfw778wsoowxKdfA3V9SmQqqRT
         3mISobqiZweSO3wDk4SrQH7x5itv5j48JqeknW+u9BfsmgMWx4yFZwZKn2MqwqMPjm6J
         Qe7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817881; x=1794422681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BKgadK2I/GgNvZDn4Xm20+I35igbD6d8qDSMaHto9bI=;
        b=eJZ5RhDDJEQzItG8FLP14bA9OxnXUEOqIZi+cTzIDBMVqH4SnwCSV9njN3lHysmLvx
         8a/UvrVplSt3x7lPv+i2016ysGNYWW7pr9wje7G6JZzc0X4XRyrlFkTgMinWecQGeIui
         gmIAfGIyc2hifIvQKwEqDmiVmtM96axQak4xYrIOhGy4D9/FCKobQIeUobYshENRyUgW
         1+6Mzr0wdIwf9sLQSYFMUFYRUc8oB3+NoMqsbxSBdTC6Qf22Goe9nngwX1uKB96AltNP
         /s3it96ALAYYsmABXCoqYJm/9oSZNCU0GhLPGySXSLbiCdDrnzXCm2xjOcHkSwCLLihi
         XiSw==
X-Gm-Message-State: APuU4Z+wU5fVnwXLpIjCqwi9wwyYde3b8nPLLPyB7SLHaOTuF+mfjVB9
	79zUo9ld3fPtvPdNc4UaTj7f96/fB5KYJSecO0lWP8VcaISknKhRvxGA/lQA2TKZe0QlGKlaMTO
	At318Udk=
X-Gm-Gg: AYBFou2iIWzpHfZ9bg+GZfVkkF10X5/FA6s4sv3pEg+GF6SefYk16qm8zPAAWQbrAub
	SCyCf6lUXFTVtwqWnnO/LVE4gMaB51+w81r6zWjb6HbUaUW3ucc8N4llKUIjxrpRb6PQHE1ERMt
	D5ceVlQq8/ZPlWW5Gdm7x+YH9bc7U3vjDStcPmgiazSyr+LrZ3OaTjXwmwJK7XnklyQDQkkKXP/
	k1ogHLYwy3Q7wRe/uvnf/QnHDv42k91Vafo1F5PwBhbONJCKUVTZgMb4jOP2TC0HLWKicNhEJo1
	o5CzQXwoHD52Xjv0jzP/ol0EyBmM24NwIhWnuRZ8oIfJ6YttAgmPM3uGW9bnodh9K027VWJn5ca
	vJ4EaRDtr39VU7kXRJTS+h7Ljc0qxvQ18pxBtbdSTDy13vFl5d8bUY2U4lwdYQNIf2FwleNUy/A
	Xb/roIQCadNAmqRZjubPl/0T6OO+gz5Ec45qzSBxVd9pPZzJ3wX/oSWNxIcfXPV1ZEkO1HbJ+eP
	q4lf1fBfo825IkziUlwLvXMLEFPIk5TigiMygL4IcCOENRqFfOzXF8WSgO6Ht1e05oWtIaVUMop
	6yzKD1ldwdFOUWVn7yEJaW/q09HuqyAW27oXw5Cmt+swrX9jqpvrssZFS/KLqnOCwIGlUXmKLg=
	=
X-Received: by 2002:a05:6820:c2c2:10b0:6dd:e81a:5906 with SMTP id 006d021491bc7-714f2980cdfmr7072804eaf.50.1793817881307;
        Wed, 04 Nov 2026 10:44:41 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.39
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 11/11] io_uring/net: fix multishot recv length limit accounting
Date: Wed,  4 Nov 2026 11:44:12 -0700
Message-ID: <20261104184412.516558-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184412.516558-1-axboe@kernel.dk>
References: <20261104184412.516558-1-axboe@kernel.dk>
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

From: Cheng Yongkang <teel4res@gmail.com>

Commit 3e3aebb7570ccdde5cc49c9bfc8fd3a436b71b0c upstream.

io_recv_finish() debits sr->mshot_total_len with min_t(int, sel->val,
sr->mshot_total_len).  sel->val is the cumulative byte count of the
request: on a bundle retry the receive path adds sr->done_io back to the
return value, and the bundle branch in io_recv_finish() recovers the new
bytes with this_ret = sel->val - sr->done_io.  The debit therefore uses
the wrong value after a bundle retry, and the int cast truncates a limit
above INT_MAX.

For an IORING_OP_RECV multishot request with optlen above INT_MAX, the
limit becomes negative when cast to int, so the first completion debits
the entire limit and ends the multishot with IORING_RECV_MSHOT_DONE
while the socket still holds data that covers the limit.  With 120 bytes
queued, a 64-byte buffer and optlen 0x80000000, the first 64-byte CQE
lacks IORING_CQE_F_MORE and 56 bytes remain unread; the same setup with
optlen 0x7fffffff posts 64 and 56 bytes with F_MORE.

After a bundle retry, the bytes already debited for the previous
attempts are debited again, so the limit is exhausted early.  With 1400
bytes queued, optlen 1000 and buffers of 600, 100, 100, 50, 50 and 200
bytes, the first attempt delivers 700 bytes and retries; the second
delivers 200 more, but the debit accounts for 900 and finishes the
request with a terminal 900-byte CQE while 500 bytes remain unread.  The
limit could have been reached.

Debit only the bytes received by this invocation, sel->val -
sr->done_io, and compare as unsigned so a limit above INT_MAX is
accounted correctly. Non-bundle multishot requests keep sr->done_io at
zero, so their accounting is unchanged.

Fixes: 0ebc9a7ecf6a ("io_uring/net: Support multishot receive len cap")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
Link: https://patch.msgid.link/179328314078.648427.10086632105828535293@gmail.com
[axboe: fix-up near-by incorrect comment while in there]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index e78ec89ca5dd..e8d5d17fc754 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -879,12 +879,15 @@ static inline bool io_recv_finish(struct io_kiocb *req,
 		cflags |= IORING_CQE_F_SOCK_NONEMPTY;
 
 	if (sel->val > 0 && sr->flags & IORING_RECV_MSHOT_LIM) {
+		unsigned int this_len = sel->val - sr->done_io;
+
 		/*
-		 * If sr->len hits zero, the limit has been reached. Mark
-		 * mshot as finished, and flag MSHOT_DONE as well to prevent
-		 * a potential bundle from being retried.
+		 * If sr->mshot_total_len hits zero, the limit has been reached.
+		 * Mark mshot as finished, and flag MSHOT_DONE as well to
+		 * prevent a potential bundle from being retried.
 		 */
-		sr->mshot_total_len -= min_t(int, sel->val, sr->mshot_total_len);
+		sr->mshot_total_len -= min_t(unsigned int, this_len,
+					     sr->mshot_total_len);
 		if (!sr->mshot_total_len) {
 			sr->flags |= IORING_RECV_MSHOT_DONE;
 			mshot_finished = true;
-- 
2.56.0

