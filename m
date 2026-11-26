Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661120;
	b=l2lT6tjecElP8LcTDftrgcMiDDko0y4rroTMoaqkD5iiF96QLytmCF6Jxa7MFTWhAlHA
	 xo5xdk8GU16UmBdkBeQ9aKFA2SI/IRqToA0xjsN+ZHuUFAr6ddEDPVV1nAfzKTGvjPo8i
	 sPIbzt3h55g4S7f/MGBGS6XAzfnq+OS3s6tevUMjQBklhaW7VC4Wj3CZ96FHw4kKWJgDC
	 kJuRuX7V/G/mV50UQ/PpM4hzondoJ/v3cJZOd6zrZLi+cpV776pbqG+k5AKurg/etucPL
	 o/WJV92/bH9gK1yGHjyOMrnxfW/AZztcbeXl9qqtP22/0zFXbRaMPlt6A+CU6w4VYYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=gkZgmOXe8E8lJdEQKBCDcbGRoKNnBZ93I+C3olx35lE=;
	b=YbYytlrSVGFoeYMkUSPd7cFtaBVOe4wTgUVnFh7OcRT2kbaAq2GMebkJZ2rjlZ6HqYEc
	 4taGnBd+nd0bMSrL+9oZnNlf5l4pxq+jMAn51Z4iZzhu/1ndA8pPYrFBVJL2cPbQMIcAD
	 dCBjgwn3V+nOyheBgeTJ8AAnVz4JjWJQS36TWQXGxC9NU/WCItMiQCxhZyXMrbuX/y2qy
	 0YBuy33NH/5C6SqmODwmeXtC4RzkWzJFMGjPMR4IRHAjpng6WnS7hLX011aNOqgTdsD8I
	 kRahWxREYBYrZCZVudF050GfQPwgwCQwkelHCJWM/wESDtypfaFhQ4uLxE5N0LzTDWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=LcNtLRG8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6587606A69D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6587606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=LcNtLRG8
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b10d24345dso60097177b3.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661119; cv=none;
        d=google.com; s=arc-20260327;
        b=FCOghldUnUiExW4MNGlnXPRK7TCArUF+xST9DJKvanmjyJx0OhRWr9HFfcfjGsa+FK
         3x4SALsnAqyGjV75DkrcW1oD1190XLGETY2TnBa5KxtAMmRO2kfwdUwwsLAgvrWTeakM
         II0RrZhkmSXkhxffwAz1h0deKwKLGBgTESbRIBUEB/IQss62cZNxgw7IvuTZ7O/p8kgn
         pxX1t4+ij2TSXkeOKeyFbV9fz9y45IFBUqa+VSEdEmnkARS3p+y+Y0nc7l6NcQI+Ty0T
         w4Ff/ebP2Oun5ND0bmxh2dDR0KclOnHAdW0NBo6mz4DcGuBF7+AFC3y5uHFTZpDUtHVY
         ZIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gkZgmOXe8E8lJdEQKBCDcbGRoKNnBZ93I+C3olx35lE=;
        fh=AIrBuAclZrkW2rl1AKI6uFjmcQF/pUVlMaxQw55Yq2o=;
        b=orlUaz0r56NHuCRjPXTtrLbc9FazvAHo35dMj4vYwX05AawSLBJ/MVkMR0L+9wWU6R
         tSWe+c0G99btmAmVYRa+/RvG1niRhL3w45XyG8Q660ShEXw0GAiY+Gar+vM3Bdr6e6sw
         C7ywtvrlHgA4auyc+lYpQtDOxeR56rC+GXV0N3fYKJHT0Rtk0OMs4m1e6tIMQqr0KtKz
         MBJO1lBjAT82oeM+oPeGBcj4mgbVMMbQX1fEahtSVJ9y9caz9SGsPA/ArMbws7u8Tfdm
         mSSFbhQYDkrhlZU4iicXKX9u1AYBvMqprlo/8zxVHDkRiH3Orc5tOdKKmjVGxQm/RcYk
         d8kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661119; x=1796265919; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gkZgmOXe8E8lJdEQKBCDcbGRoKNnBZ93I+C3olx35lE=;
        b=LcNtLRG8erXdCwZnbSnOIVksVMcJdh6PI96GV+GvDCbr0oojSxSoeQQi512IFQi5iE
         qklzsgSPgczps7Eth6YMF3FbN1HYi08adXCUc6k8tGy07zvxSYTiHIdaAs5XUz88WtZT
         UX654o1evIqrUyhAD1iuX7QnpaXcMZnJQPMA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661119; x=1796265919;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gkZgmOXe8E8lJdEQKBCDcbGRoKNnBZ93I+C3olx35lE=;
        b=eaK9sFmSfbZ70u5CbmIjZnejY1vhyvAIaNN1QIk4cjUi65Xze3KpPBv1I2fOUcVVz+
         l/ZeftUApxhMfMprMK4gnOFk/jWkS1U9eD4DNUo+ZkHW8WRKfKNCxhDMenmVY2o6myKh
         kpx6nSpoF4yMikLv0wDSFPhViSOxkd9eatUFdCiP3fJfQQLKIrB7TlM2lSWB+JDREwFc
         JOU0SiQ574rLpFKYLmeKQy6BcWFBs4FCQZU2tvBJjJDbuaHR35puCnm4CTxPqcM8Hma1
         pMvi2Ml8sPOolbnPkgLjzdn7lIMfLdkP/szsquRJEcxMFLSMDi5PbYoRdxVorbcqVEDV
         P4Ow==
X-Gm-Message-State: APuU4Z/isi2Gx9vLVgK64MUAsha1kV9xbOVE0NKBdPoSA9jAfZaQcX8C
	he8ClXPVHwNSvDI1DmwM3Tjoa0cvcSJrjM87Ws30RA0Q5+BW3WS0OZC4OZXh9Rk7BSiryDfze4F
	3AjRwD/d3Z+AhrGO5Mp/NXokGQwL9EKfM8usn2X5H0et1oiyHxm66JCk=
X-Gm-Gg: AZFdTZe/8wodwFTs3X0FKwJBPkXLt7/PdPGXG6Bxlv4QNNa1BNH7NZOznC/cpHdWGbO
	Ns+nvXLg0bIyNoOQ3V3nfvH3odSV7PgsVvG5C5Ln/yDRyRTnaZHFMzNVDK5iu7UB28c9AL03xW+
	5DGfRcppfqDPlh5oeXqC2hYns//vOvUulXZw0NGXRdPuByahihTAizlbvNmv2f94r4EXLfK1Jwn
	yD+EXbKJ/tsT5Eu3IwpPEb6NjhUOYCaGXP+lgEjb9aID5R4iKo0t9Byqo1j0AZZKgAA2B19bZbO
	PfF9cTBCBaLJU/haJPc69grvhWulMiyogPLi6Ex5Y3li2CRHi0aPHTFKRZuMnXyel4I6sZT7rNp
	EPmehN49YeHF1S4+YA5w6PUmwdr/6LFhEN2c88lqA3kutiBql8piwrwg+Pg9x2+aehAO4Ufzfji
	W80WrVFfpTffIslIO9518Y3ILFWhpd778KsDlf87DZuxGCZJ+0+xWGV+QNyEl7qFN8zdbVd5ur7
	84Nf5y1c0/Agu4jupeU+9tEdAI2q1Dtu9NNLc74QezMq/MhkICgsjJp2w==
X-Received: by 2002:a05:690c:6a0a:b0:8b4:e12c:2f50 with SMTP id
 00721157ae682-8b52050359bmr80461867b3.54.1795661118784; Wed, 25 Nov 2026
 18:45:18 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 18:45:18 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 18:45:18 -0800
X-Gm-Features: Aa3M54rYGng247e5y8utKg1O4hSM46vZpPVS3jQbU2tGTPrp3PfXTQnh2WI-eqM
Message-ID: <CAFaZ9ep26fhdkKcXZHOPSndkE9UV9x7k6GaX1Himi_+c28XLyA@mail.gmail.com>
Subject: [PATCH 5.15.y 1/2] signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Christian Brauner <brauner@kernel.org>

commit 22b7f491be8f93ff72de0a3fe02b8ee9e64d3f21 upstream.

TIF_NOTIFY_SIGNAL is used to kick a task in uninterruptible sleep to
return to userspace and run task work and then go back to sleep. This
mechanism works well but breaks e.g., coredumps. dump_interrupted() only
allows fatal signals to interrupt a coredump and the whole regular write
path going to actual filesystems is impervious to TIF_NOTIFY_SIGNAL as
well.

Add PF_NO_NOTIFY_SIGNAL and helpers to raise and restore it. This is the
same approach as memalloc_nofs_save(). signal_pending() will not report
a fake pending signal via TIF_NOTIFY_SIGNAL if inside a
PF_NO_NOTIFY_SIGNAL section.

No functional changes.

Link: https://patch.msgid.link/20260824-work-tif_notify_signal-v2-1-6609e42b3157@kernel.org
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ adapted to 5.15: use PF bit 0x01000000, 0x00800000 is still
PF_SWAPWRITE here ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 561fb81675fa..523d727d27a7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1703,6 +1703,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_NO_NOTIFY_SIGNAL	0x01000000	/* see no_notify_signal_save() */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to
meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained
to zones which allow long term pinning. */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 6f105308ab5f..c271fe5c2548 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_SIGNAL_H
 #define _LINUX_SCHED_SIGNAL_H

+#include <linux/cleanup.h>
 #include <linux/rculist.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -365,14 +366,36 @@ static inline int task_sigpending(struct task_struct *p)
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }

+/* Prevent TIF_NOTIFY_SIGNAL from interrupting this task. */
+static inline unsigned int no_notify_signal_save(void)
+{
+	unsigned int flags = current->flags;
+
+	current->flags |= PF_NO_NOTIFY_SIGNAL;
+	return flags;
+}
+
+/* Restore the previous PF_NO_NOTIFY_SIGNAL state. */
+static inline void no_notify_signal_restore(unsigned int flags)
+{
+	current_restore_flags(flags, PF_NO_NOTIFY_SIGNAL);
+}
+
+DEFINE_LOCK_GUARD_0(no_notify_signal,
+		    _T->flags = no_notify_signal_save(),
+		    no_notify_signal_restore(_T->flags),
+		    unsigned int flags)
+
 static inline int signal_pending(struct task_struct *p)
 {
 	/*
 	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
 	 * behavior in terms of ensuring that we break out of wait loops
-	 * so that notify signal callbacks can be processed.
+	 * so that notify signal callbacks can be processed. Not for a task
+	 * that asked not to be interrupted by it, see no_notify_signal_save().
 	 */
-	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
+	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)) &&
+	    likely(!(READ_ONCE(p->flags) & PF_NO_NOTIFY_SIGNAL)))
 		return 1;
 	return task_sigpending(p);
 }
-- 
2.43.0
