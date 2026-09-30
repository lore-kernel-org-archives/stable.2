Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91A4F7991
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775536; cv=none; b=ZzQpkskJRDM8UvJi0GWVZ5kn6+FDKBCaPLf8XF0TqBByFmBy4Ihsch8y/APxFA73tnu+Zn9woN/BR+I1tK3uPqoR2rv9pmx0PBMCtHPhjMgVGkZOe7dcy3MmkoczAwUS1k++N5elUGvElRZFF/wudDhqs+ovJUULtwn76eyNUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775536; c=relaxed/simple;
	bh=a9QvTTHqM+xuamYQZduAKyKn3RCx+8Lv1W1lDW2EHLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kF0VgNQ7DTZMgF4dLyJy0ScGzMq6XmPFOtyq9jJtFWnlQQsc/cbe7XjIXdQ/vvVxJCmhI1Jnya8jpBBIvvppu/J2/C7dZIYL7oLinFOJ9JpHABxTk2g4dxb5Lo2n4hQ0qy/ZqFNzSEJbl5/3TwqkXynxNgCGm3+h+4/XLsV/Mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCrOD4H3; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCrOD4H3"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so33522845e9.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790775522; x=1791380322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=474a+Uh8NKQhYQs6hSaizzlwYrrMkmuNuzwQ8vb7KOU=;
        b=VCrOD4H3lmCeReo3MOS9EmDHBkMeF4nnSi0wzmlNNvcLmKDn7hAJOxVcyyq1Cw0FQH
         9yyhI77w0XMhXSvfdpb3McgAvjqHHk8rGWwRXwWtG+IZuGge5IjhdHsUsHwxijuQAv41
         VF967IA4eqvKGVuBz87yv8C2xKlNpj4Q5AzzMFrwoY1Yl2/V5kwnNfqKKCzPKWkZBAgc
         +2yp+mwSKlNOol3tp3PHJXTMs1XVVGBInSwGrCau/Rb3CmH4fbDaeHEJY3o52xvEBGBn
         5bL384NUTMygWilEopH4P80a5wwLnJwHybMW46sfhn2Fo2gcUPOAMht10lUTwmlR56DZ
         lJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790775522; x=1791380322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=474a+Uh8NKQhYQs6hSaizzlwYrrMkmuNuzwQ8vb7KOU=;
        b=e1uNOwmZ4TojC65fKZFcRTiBylYSlfJ2dC1Q5nn79e/D6uuEbF5VzcV64m/00qQMZV
         oC5DuXgvarxJ40EVNGqnMyh9wNKSQ3kse1UZV4i2HnKDHO4R/Kv4QZAFYJL/e8A7Edcu
         hwzIiOLeiHFILvV3OTbu66AlojN4EEmFym1t+UPm124hl3w62+cIahXXQvwr3As9LqzA
         +rYtcUM5BHYZbKRfVp4UzSKeOKoGmdnqFY1cePU8tnWVC5Et++xDH2YRtbbZlyO4AGmo
         rlvufwv+uBdZIQtcZm3mdEOZOR6s25yoTh0PrxB/OfvFIgpEiqKbUYiKRAMLlhpYb3wi
         zO/w==
X-Forwarded-Encrypted: i=1; AKwUvBwinYfxUGmmz2tV8zKenpbJ27GYv37WvPxQukkQ4qv4m2MLLip/WLywZS13OqbXapOyEXHMbA0=@vger.kernel.org
X-Gm-Message-State: AFuF++n0Y9AXhZ5697anKh8QXNpCTyTMkT+w8WobSBlyobhQMnBahmGd
	WOtGCN8+ZR3T74NLvP1Slq6IOpIhVaxWJeE062GXcKG+IFi+QLjSquLfiubnzA==
X-Gm-Gg: AYBFou1moK/iW1S/xmTCAtjhokcPDzIw+ZyxhtybYkvLMIw7Ua5E73RD8pEQaNb/Wn3
	i3BPs12EkeabDauW7z3EaIUg/AodVEMTEb1JtcBgwdT7vq6I87CK5RiRnb/zuntkXtCSK5PiiHs
	LqbyuG+hvmzCAHnYDo4fGuZP1F5RZCuv2fP8L6BbwOjBI2wpLTSK8O7A53rc00KP9r/7A8pU0CM
	JjVdgC4tyvkNyqzoyOdlleIYFykeH9ZCtZbVCr/IR4hnBi0gZ9Ei/6/V7dtFH62oVYtD3ahGEEs
	vhJ29qacFwMH/80TYcUlNdl/Et18s72RBX4sO3hGF/nbG8MeDhT9q+ITC0VODiB9gkg2epmv8tK
	6HSEAyNMe5ikhZAUDdd3F6jpwOr/CUvixITNkBk/hJkxSM04NAPD/M7BS0R0qaGV4QtNcqQw8zF
	z83b0w5go2ZTnsIvK8UT7qLtqbqxAz5FKzWJp88FYhqihJDb6816r+NmEh9GHJnmZursRAhLVm2
	4mCe4+DyTVQt+wM7zZY3sdwgF87g+uU+GraSYbUeTWm
X-Received: by 2002:a05:600c:4687:b0:49f:bd3c:bc25 with SMTP id 5b1f17b1804b1-4a01b131ea9mr24463995e9.32.1790775521561;
        Wed, 30 Sep 2026 06:38:41 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01cd43e66sm7658475e9.2.2026.09.30.06.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:38:40 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kcsan: Avoid division by zero in kcsan_prandom_u32_max()
Date: Wed, 30 Sep 2026 15:38:30 +0200
Message-ID: <20260930133831.1411-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN's skip_watch, udelay_task and udelay_interrupt parameters can be
changed at runtime through /sys/module/kcsan/parameters/, where 0 means
watching every access or not delaying at all. With the default
CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE=y and CONFIG_KCSAN_DELAY_RANDOMIZE=y,
writing 0 to any of them makes the next watchpoint setup divide by zero:

  # echo 0 > /sys/module/kcsan/parameters/udelay_task
  Oops: divide error: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 93 Comm: sh Not tainted 7.3.0-rc5 #3 PREEMPT(lazy)
  RIP: 0010:kcsan_setup_watchpoint+0x1b5/0x410
  Code: ... 65 89 05 ad 8d 98 02 d3 ee <f7> f6 29 d7 e8 22 0e 0f 01 ...
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  ...
   __show_trace_log_lvl+0x1bd/0x315
   __die_body.cold+0x19/0x2b
   die+0x34/0x50
  ...
  BUG: TASK stack guard page was hit at ffffd3ab001fbfe8 (...)

reset_kcsan_skip() and delay_access() pass these values unchecked to
kcsan_prandom_u32_max(), which returns "state % ep_ro". delay_access()
halves the delay for compound and assert accesses, so
udelay_interrupt=1 is enough there.

The oops path runs instrumented code, which faults again until the stack
overflows. With skip_watch=0 the guest hangs without printing anything.

The division came in with commit 71a076f4a61a ("kcsan: Rewrite
kcsan_prandom_u32_max() without prandom_u32_state()"). Before it, the
helper scaled the random value with a multiply-shift, which yields 0 for
ep_ro == 0. Go back to that via reciprocal_scale().

Tested in an x86-64 KCSAN guest with virtme-ng: after this patch,
writing 0 to each parameter, or 1 to udelay_interrupt, no longer
oopses. skip_watch=0 now watches every access, which is very slow with
the default delays but completes when they are set to 0.

Fixes: 71a076f4a61a ("kcsan: Rewrite kcsan_prandom_u32_max() without prandom_u32_state()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 kernel/kcsan/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 2db82661cd60a..a3aa5e5b039dc 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -290,8 +290,9 @@ should_watch(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size, int t
 }
 
 /*
- * Returns a pseudo-random number in interval [0, ep_ro). Simple linear
- * congruential generator, using constants from "Numerical Recipes".
+ * Returns a pseudo-random number in interval [0, ep_ro), or 0 if ep_ro is 0,
+ * which the runtime-tunable callers may pass. Simple linear congruential
+ * generator, using constants from "Numerical Recipes".
  */
 static u32 kcsan_prandom_u32_max(u32 ep_ro)
 {
@@ -300,7 +301,7 @@ static u32 kcsan_prandom_u32_max(u32 ep_ro)
 	state = 1664525 * state + 1013904223;
 	this_cpu_write(kcsan_rand_state, state);
 
-	return state % ep_ro;
+	return reciprocal_scale(state, ep_ro);
 }
 
 static inline void reset_kcsan_skip(void)
-- 
2.53.0

