Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A013F789C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481688; cv=none; b=NkHkSrK5/D3nt4Jo2rI6oe2tuYm0bSUzW+jb39gdynoVD8LWU9uq68Z81oEKCrP2YUYtxOxyyIv1xcr04UHbbkW1mHp+OJol0wKvbhq6RHMKyGg7McuRXLSJcQu9Zd0wWZpF77NASk4rb3uns/gLtJ9WyH/OP8anRYDG6j3Hvzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481688; c=relaxed/simple;
	bh=+yp65ZMJ1cytb45g8rsqMYMiCYNglTQbBWFgdPsXs8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YT2qxrXhXFg6gSVDH3lKIVGj9nPueoaXR8GbFaTjklztlZFn3tMpNmGcBJGr1YLfSju3Obl1KtZGDPf8ZVSWcJbxpwhVyg07SEL3awQF+wTP1v6QR1jL2+UCJcavP+vNY1Uajrv+R0DUjJKrh+MHb1/NlvAZBaGuFocstvECN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4FBK0qq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4FBK0qq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so9804415e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481686; x=1783086486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M+4tAlkQOkrOABWP7WLdmPAG77uMonsQWWyHYvgdTM=;
        b=d4FBK0qqZDYad7wWeca3xHRI8PeqwkCmlub93fhQCsenAGFA1D5nP7zW3UTkBwkhkA
         cVTu7ToZUtEG4zC+2PMuN2TZab3TAeE2kefK7tcYi4y5Eo/K1Pvg5DT4TtZZYIrKH6/G
         UxVatWhlhI2TLmk7+zM70/jHjxFrm6P3EyfQkxlRjYSSgxE2tZR95X8Xy6rrQf31UYfD
         uTFD2kO7jzlJcRWULQlqYHZKBsEQyUiawOoSvrwPi8/JoZQADU/Rc7dJ73RW0SgYeCC6
         I9XsF3DDCraO/ZCKPG0qspQbdsIHHoIYebEzviIOsbahotvgJhCFdJurlWBOkq4jNqJ0
         U2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481686; x=1783086486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7M+4tAlkQOkrOABWP7WLdmPAG77uMonsQWWyHYvgdTM=;
        b=RkocnW7KSMsuMeHCCPiRbsM8k0cUFatPS5ZdL1m3s62oZTpDtVEnwWJBb5WuHFUJNO
         fL5zZVGxs3xbbiq8xOMPH8ZiMWAlRQvz5LekQ1o4kiqUSC47Ss02aAMiI2Iv3+7zkACS
         /n8By9bA6pUREOVtpoLYFM7HR0lCS/Gs9Hd/y9QEp8JPQlh5C0S9259+cpnu8fp4F2/F
         XaE/Ng5Kk5d3t/VlvHBcX9s3w4kYUojojU9UzZjt4Ay5F8kLqxg/Vm8S/bk+ksjVX8Do
         FfsVEUY+ebBpnGTF29/bxMRBAZgeV4v4LHYJtZng8pn8JGKCSM/AM8OI3K11l2HRUia4
         u2TQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RD7BNr2I7CuXlF5qwWaRgp0Ni4z7ZmzSuXIJYZBd10n7a3sKA43xkaFtYyQYH4+Rc6sCRmWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+7vPL/2LJtZh6kteA4sg60NY4KHWnBJbCaW9jqzkz1jES60F
	8Nd4kMCc/iy0J+h7C+UGoVcgulHC9TxpS2JVuYXqFwSLaXILfl07BpNb
X-Gm-Gg: AfdE7cn6SA2LbDNPBEZZf761CZOYtsXeCv2KUX+CDEE78aJl19vEzmmaMpIIwOc7jYZ
	P/hgoPtriiKh6NbjouT8GJQIcimUoKzkHeJ6ePdA3CkvH7l4Rq+XQyd5qSfyRhMxjcBRtqn4Ni2
	cT/AGziAzQSrfJDWQI2+BxH0geZSqRfg9b8OjDOC5prWV9xBRF43M3XdyI2Tqlp3FJA4mQIDopz
	WxItMDeDqlkLbuARE5TESFswxoQVrMBozAIdvk2Wy+CUCVv2z+NYN2+jlP+cqi13IKwIsrIu5CM
	TS+MaAqinCblzueshuhrfSXUaQqGaLgi2/TGO51ye4bpPALtmMV0uXyg8NfelrUIymQAKxVX9si
	pncZsLRJXSh9TrJJ7aycW650/xHgae2L2paxCuYM1PDIRygpENWqpeja3tybIV4kTgyfqssmB3n
	qNjXiBi9wODyW7RYTnjVJWQT1NpzQSqW9JlGFwTJ9Sqycq2pARelX4kAGlndXP2wU9
X-Received: by 2002:a05:600c:6215:b0:490:4b89:535f with SMTP id 5b1f17b1804b1-4926685fcc2mr94668595e9.8.1782481685852;
        Fri, 26 Jun 2026 06:48:05 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il. [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:05 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/6] ALSA: timer: copy queue entries to local buffer before copy_to_user
Date: Fri, 26 Jun 2026 16:47:07 +0300
Message-Id: <20260626134709.27883-5-nevergfx1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626134709.27883-1-nevergfx1@gmail.com>
References: <20260626134709.27883-1-nevergfx1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_timer_user_read() dequeues an entry from the timer event queue
under qlock, then drops the spinlock and calls copy_to_user() directly
from the queue slot (tread = &tu->tqueue[qhead]).

While the lock is dropped, timer interrupt callbacks
(snd_timer_user_tinterrupt) can write new entries to the queue.  If
enough events arrive to wrap qtail back to the dequeued slot, the
callback overwrites data that copy_to_user() is still reading.

This is the same class of bug fixed for the non-tread queue path in
CVE-2017-1000380, but the tread queue (tu->tqueue) and the NONE
format queue (tu->queue) were left with the same pattern.

Copy dequeued entries to local stack variables under the spinlock
before dropping it, then use the local copies for copy_to_user().

Fixes: d11662f4f798 ("ALSA: timer: Fix race between read and ioctl")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/timer.c | 19 +++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 51c6ac4df9f4..XXXXXXXXXXXX 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2390,6 +2390,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
-	struct snd_timer_tread64 *tread;
+	struct snd_timer_tread64 tread_local;
 	struct snd_timer_tread32 tread32;
+	struct snd_timer_read read_local;
 	struct snd_timer_user *tu;
 	long result = 0, unit;
 	int tread_format;
 	int qhead;
@@ -2452,23 +2454,23 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 		qhead = tu->qhead++;
 		tu->qhead %= tu->queue_size;
 		tu->qused--;
+		tread_local = tu->tqueue[qhead];
+		read_local = tu->queue[qhead];
 		spin_unlock_irq(&tu->qlock);

-		tread = &tu->tqueue[qhead];
-
 		switch (tread_format) {
 		case TREAD_FORMAT_TIME64:
-			if (copy_to_user(buffer, tread,
+			if (copy_to_user(buffer, &tread_local,
 					 sizeof(struct snd_timer_tread64)))
 				err = -EFAULT;
 			break;
 		case TREAD_FORMAT_TIME32:
 			memset(&tread32, 0, sizeof(tread32));
 			tread32 = (struct snd_timer_tread32) {
-				.event = tread->event,
-				.tstamp_sec = tread->tstamp_sec,
-				.tstamp_nsec = tread->tstamp_nsec,
-				.val = tread->val,
+				.event = tread_local.event,
+				.tstamp_sec = tread_local.tstamp_sec,
+				.tstamp_nsec = tread_local.tstamp_nsec,
+				.val = tread_local.val,
 			};

 			if (copy_to_user(buffer, &tread32, sizeof(tread32)))
@@ -2470,6 +2474,6 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 			break;
 		case TREAD_FORMAT_NONE:
-			if (copy_to_user(buffer, &tu->queue[qhead],
+			if (copy_to_user(buffer, &read_local,
 					 sizeof(struct snd_timer_read)))
 				err = -EFAULT;
 			break;
--
2.43.0
