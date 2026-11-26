Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661118;
	b=pMLZNSF6dKSmbrXKXvhBiPSSWrW3mnXJaY/HWOWVKpP3XtoTb4tWAMPGyxwqBXRYusex
	 o4yq/GkUrp7RXUqcYvI5hAuX1/iOEy4OkpReY8RzuBFUsg590yUlRp5EUd7T1F9Ot1xgx
	 3jzT5aGHWlVPAcAvHY7jqtdVZr5yH7miJhTxDADusdeNalaOHkDpzFatXBz2k5JjKCb0h
	 I7HT5FO8PgdjVVrn5xB41GFKuhEc8pM7eLzno2EtP9SkNBrNQixCzH1aGUAHKtivbck/Y
	 9T4nMe/rCCgKUJ3CWpJdmu2hS0BEBpM2QwwSY2IDgLOPsTMHxMY7tvfQ4+UHcPGxBSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=GGVu2LAHkDf3iJCcJXqnrLKgzUFBeUsFgEKNp1vIP10=;
	b=1uwOxCUimAf5dFpZbf0f5QDnZ4CjehQxUsbC9TqW8Jt067g870/E5p78XqYdfK2RE8IH
	 XG7KY8ggrJ3lMpTA6XLVNx555tqyKIQyvOog9ca2+iHJ4l6kk5oP2mBsAQZnnjup+jksT
	 +PQ2pezSyiRtsAv1f1qwQV4gkg7P9W37nSIEqsJh+CQMBDDvvGgS+sqYkiMAJQk17cB7J
	 KfxpJuMmG0XKiALSN7hvMpjd8vuABonM3S1mIBenToOHQmcfJnvEUexTQdxjPkvjHOCex
	 MaC96X5Lqu5vX0tZCy/eHvIkTIzU+dmWgp9PMWLVX4MRwz3ezFRD/ShgE/umMGkXzGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Huo9dShm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3F606A33A
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E3F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Huo9dShm
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67da62357acso8812513d50.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661117; cv=none;
        d=google.com; s=arc-20260327;
        b=HVKgE2OVaAx005WCwXTj1u6+zeYeFJy5OsuSsNXXqQwvbxVYxz0T/hMgSvVdyPhDNo
         T4/6lfH/71xjGu+sDL9di8A4OlqvgdLVhTXdA9NLO0QE9E5S9C8lv3BXUtD4u8SBDTJZ
         wA3FLtfKPXsNtgClRbGcFvM86HhmQN3WDAGkMm2RHxWZBDbkGiT5ov/KlsvKGBG435AD
         yQHQCTghgKFUFY8d+uZXY1i9fzHfheqxNjCsiu38qqnvhnQKTOdWt4kHcuiyAP0H6aGn
         zGXiS5GF+qxQry2qeedEDdRL5AkMDorOiwrboeWVjCXClTjmsOkgbTI/Sek1u42X+N6I
         SjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GGVu2LAHkDf3iJCcJXqnrLKgzUFBeUsFgEKNp1vIP10=;
        fh=AIrBuAclZrkW2rl1AKI6uFjmcQF/pUVlMaxQw55Yq2o=;
        b=iZ31Kf5yR6VyT+8t81Up0U0RN63uezNqT4itO5fn42Oh+tPc1jWWhghxwYsN+udhIq
         iNNVrmeP4nyJ6fanNcCA0thhEuQZhSrunIXzY59YebMiO+fqekEYXI0MmZPBtUSf51rf
         KK3XZBHWaHs+HFC+TRhXyZZGFnYSiW3q/m6b0N35uRe3VClNIM8SgUZbRaD1SMiYM7Aa
         Bo9x7/gn+4FvFK66exVU87ehN3pD4+kOU85JVVAu01c8esWolt0ehQaViJnEn3s4J7Bg
         Uqs248SeL1F0yVuUG7pNWsYBg3NRGDyocIbM9gvLkBWhxG3DnJNCG8wIGmR9gCLe8iKa
         TQ8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661117; x=1796265917; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GGVu2LAHkDf3iJCcJXqnrLKgzUFBeUsFgEKNp1vIP10=;
        b=Huo9dShmB4eTHar9RyfY+1EEiktCh0weT6eOp7AK+RJ8puODlNzkjqnk/gkCAghpgp
         QGc/aAifzloiK3KKt50fcwGS0ZR3rEGqRiqez/8X+ESst+cEinR2d7WE//p0/JXwnV18
         bwR2fBwE4oB0Y+yGEPjq3wuSmXjWVRZjLjDAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661117; x=1796265917;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GGVu2LAHkDf3iJCcJXqnrLKgzUFBeUsFgEKNp1vIP10=;
        b=G/Mpb5GzVMYEn8o+mcFkAFG71+FkzTU9UEYTAipQyO1rj/V8xiMS+/naTduSMgBwDA
         9HhtdcwbK2GTzn+MFQBmuUf9sDSltotWKl5wvfSOyrchu4qFHLnbCazVmcfDtAiayl3S
         xc3z8s9Coo3H1gvS8ZE4xY7j7Lq3YjgRyumjtmRhbhdHRJn2MtyUkibL7UaC5P7Veh/b
         qO9xkC4cKhXpgkkZhzn4gfXAI/pt2/8lGm2FeAAqXTKWqbJhXU/FTkAsLQEO0GMvwyW8
         D8qVDDQkPHnrH0eMQeWmn0r1o9kWYeyXFNy0AKZoGVBKjgqT97lvNz9mqw6hnaiJMC0F
         oDPA==
X-Gm-Message-State: APuU4Z8OHVQUNs+hLj8le96KVamj/3bW2brxmp5z1d7/F7v6d85K88wG
	qbm6YUDE2aU9PKiqHxH6dd5GquGhE9mBSmhIdBUXQty1ZjyLGUPpS/qctTOV3unFLA/A2UYdaWJ
	MOJjl4vehbLpsFjaAKBfBNPRqQCqZkmIGS4U8oNkNnzJIKFmykkyHng8=
X-Gm-Gg: AZFdTZeWY8rAyJWBbo5J3l3UQJCxHZ93FSP3qMYlt4V5oC3Wa88U7WN9bLGupLNE2Iu
	Ibu0aLMxDlcz3fA5ixdqMAvp15lyIwwZHr9Dljf2rhMni1fEnyLgxtlh/fTEKeHLzQtGcQDJkxp
	LtSuYCOZMssqxnUnp9xlDDECPiRKwAlCGu3dbOK377e4cN0w/w+LVij7N9QygeSO89XuQAzTUia
	mMexr102QZhy9XgCfULQIk4Cn8BfydgRvl5vkoOG6wWvVb+WVsAtWYzBLlG0oGwzdiYG/ykA/yh
	VA65I5+A43ABXf8XGwNrZjxxcTOwOcL6jGOSrNUn5jhupKPurAzoui2rTdcN2db8Y5I+rUl/SfT
	SG79fFesKEGYDKTlx5kcJkcli+DiWO6uOkxNhTOsrJwZ/LnCw5U5xtcpHDxNEVBKPZ4RVT85Q0V
	eghfJeP5CUsOhcH4yFUxKhV8o6EOh3ac1t8HwoCzNQGnVKYbtCl75RE+6G9hWqwC2hzONPRMO7O
	66AiRYlBbmBOTRbZmxXeuLyPgbxAuYKZzohjQ==
X-Received: by 2002:a05:690e:4505:10b0:67d:be72:879b with SMTP id
 956f58d0204a3-67df44c230emr6133951d50.81.1795661116641; Wed, 25 Nov 2026
 18:45:16 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 18:45:16 -0800
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
Date: Wed, 25 Nov 2026 18:45:16 -0800
X-Gm-Features: Aa3M54q8QrbiHxph-P-I586S9RXcVG2RoodKKg3v3nkECQJtpo61OGNzcer7D2M
Message-ID: <CAFaZ9eoNqw+mFPg2RXkP=gd=VPkHy3xxOFkj3Vc5iCpqSxwawg@mail.gmail.com>
Subject: [PATCH 5.10.y 1/2] signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
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
[ adapted to 5.10: use PF bit 0x01000000, 0x00800000 is still
PF_SWAPWRITE here ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c5bd595f560..52624ff4a1f5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1564,6 +1564,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_NO_NOTIFY_SIGNAL	0x01000000	/* see no_notify_signal_save() */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to
meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will
have _GFP_MOVABLE cleared */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3a1b4c5118cd..dd468059ce71 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_SIGNAL_H
 #define _LINUX_SCHED_SIGNAL_H

+#include <linux/cleanup.h>
 #include <linux/rculist.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -366,14 +367,36 @@ static inline int task_sigpending(struct task_struct *p)
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
