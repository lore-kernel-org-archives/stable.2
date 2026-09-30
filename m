Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9092F8E91
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779634; cv=pass; b=OptANllYAy52EyaDFIQrGiVvlwJ9WzlXbHvPJl3SP7EfYmY+AsRtSawm0snE3pbG1KMOhsjUCDWUhkp955iWF37rw4by8qBAXcpiEW7kTndY9VitT6EB0yf3HPyDF1i9/PJEJ+evQqsVKzR7FLi24Cjf/uDnKn0ZbmNdEg77fjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779634; c=relaxed/simple;
	bh=Af1gMjVGt/dxyHCD/nU2bpayi/xIJE+6EgfSAbMf97s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gnjf5sWhThP8zDhYRYOC7qOJitW2fntqIhY4l2ZmQSNM9s7W61kCioNW4wcKQBBNCVJXBwb8kYPb44pJCK1o0XEkvrnJr/vAz8APtctnpEimPZe778cxpsWuA36ruN/yZy/VcMTYfCLTRseEkgMHXjRNXsymNMkZ1K9WxPK9Woo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffH2iReo; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffH2iReo"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so4974157c88.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790779621; cv=none;
        d=google.com; s=arc-20260327;
        b=Uao6yjZF889SnPTjhEY7/VzhjQvVC8e0on84rXpw5EvhvkuzQj4Bm8zcXD0dTMb2qM
         1s0kLqIvOWPvNMFRvE+QjXXGsrU0v1l5udWIybprX2WCTElZUDrq9/bG2KU+jURvZpFS
         LG0tLuIm0Neco/6W788Kk3dgZ+5k2xO2MtrBBWr2LnkO3i584jztGppmAO09TEpmLbSj
         kdqGEGbvSjqSXFWvzZf+OXxOQVIFIvueS31iyXDhpk5k3pcDkgp1PCO/advQrGczS7zQ
         Iuc1K1qQ8NFlM7u7Q4GVULE0GeQRdOGXkngRPvzKDlJsPHOwWlRDq4xU7+Tz4fVrDb7F
         sgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oFcCfJCZQlTKSnrIaPIorXjBPyF35HfV9C/IYTWbqSU=;
        fh=izRjTCFa2T5wAZ+S2JHzubN1uwa5W6lWUGNIdL+KIlM=;
        b=ITSH1zM2jK4Lrn7dOjaaQGe8EONzsqiwE4mclAbKxOZJR+M6L78xr8MzitOw5Qs8r3
         eenYLmmPrS4XfAK87v3LweoU64oUHHbNtaza5yvkF0LkgI9/Xb7mgf+ILQPPolJnxyvy
         5k8t2ef+97xSHqmb+JWovdmmNF9XK2fpU6hds2PWN4rkv6c1u6KW5SdKrOHdFAvoQ+0b
         +fw41qKA99oyqbunQP90wragTdcuO2GETOzS8y9bpIFxPxvUmHL+D9Z3dWX6Fouo43ZN
         Q9Ah5nLJZBebGiW6VQ46HfB7zWZNdZWdY8m9maElI6ebTTJ/HfohyfthmbG2AnokJvbz
         io5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790779621; x=1791384421; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oFcCfJCZQlTKSnrIaPIorXjBPyF35HfV9C/IYTWbqSU=;
        b=ffH2iReo1l0ws0FU03j+T6mSlq1lmzLqjkFathg4R9bZuq4d/Dbm/tF6f4Z4/dr2Iu
         kV/S+Fa02bORbP6fgax4HJONJJK9APtePIhHaggf5rAV3G7HpxhlmDKAte1wnoa+dc0G
         Pf3WwvSwt2402Xel22Nmam9rDKxOtp7WrItfvMAGgU8LV8biFoCMzb5eh/kAhb9dMiFj
         LMEp63nJOFe/5R+GMQowzYnALsCQAFCwskKnhrlmhcksCdHfJMp/Zb38vAwdoeMtyl26
         e5aWeZy1/XR4eA35Z4k1GmEanL9zQmNcXi5kd1Bg75uI6EFJwGjipF+6Pmd/ok6enEg8
         nKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779621; x=1791384421;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oFcCfJCZQlTKSnrIaPIorXjBPyF35HfV9C/IYTWbqSU=;
        b=QG6n4iCGcprD0iEhudMx8/gD8L9eiVvcmAJqJlUx+GSNIPoTsCNF0UQF7qduQUPPtM
         iyN2pE99CeymDYUCchooV98m5z8FAAM9e4+tkfJzIHcp/nT84fdlLni34l/LKeUZ/MEf
         qotD+VCJ61w/qdCLqVBKmS4hyZhD2kHzI5DqhMIgGujix0/Q8m5YTZN5NVKUrd4IY2Ol
         JcqMrKn8978GzKUrPBEJ3UeudSsyw2PHZxO8/b89y+UPi9vvT1KRPD1Am7dTYl4GSVQH
         1FO30qf5Of39DMtVdp0hML4KEdOUXOSL2llJsDOPv2q7fx8ZhFxbrC60dIIU3SwOpzY0
         QXlA==
X-Forwarded-Encrypted: i=1; AKwUvBwSvFJoz59qhXtRv8AmdWoCAc8Bjtysscrgxj6HH/Ont/7ZLHdK5cGGkGjtrGfZq+2m7S/dR/U=@vger.kernel.org
X-Gm-Message-State: AFuF++m7Dl7vtgJbDeaGrDccraF9QN6IkwjppNOhgeLc5Z5UGa06JZ9x
	hcIyLwfP00PlPLojxF+QNpRo8nA5it+366M3bYTzKBJeY1plMdc8rGIjZB5fMYJNWi2DPf7atAz
	YsmzQKNO2z2xABgo2gYb2Uu/9UXEiadN1PJPoQxZa
X-Gm-Gg: AYBFou0m2y2/nDfaKifDwK9uk+Z3IWgmD8Hk96FPk8jUx5/GKm4SMSeKwXZ5SHe7s51
	JEOVLhmVTuhJhaCJXu81CBpbtGfHbHwEHvFmLajJytSBgLkLo5WiLB4Ynk2peXX3rf8sjvGweOl
	+Cvt2P/YKAnflIH3j2PRc0foAfTSYOQuutxSxQF7eqTxbBm05pSCg92EfDbxTsjGjaTBTqu94xw
	3MnJiO5AL/JaqtRlZKRFWyippgj352UOAJFewou2vh/u3D7oEn8Cno0zC4yEgxl6BgXkrFYZMD/
	MYMZWRBhr2TNilqqJ86PH4mPEpTUUc3MtZH4dnV2RmTyniqgelNZfTNcEk/+PYxthfWbDvHBJOu
	IAuL6rr5JnP22F63FDhmDOA==
X-Received: by 2002:a05:701b:2505:b0:146:606e:2117 with SMTP id
 a92af1059eb24-14d2f7e6e77mr2008666c88.5.1790779619334; Wed, 30 Sep 2026
 07:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930133831.1411-1-parri.andrea@gmail.com>
In-Reply-To: <20260930133831.1411-1-parri.andrea@gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 30 Sep 2026 16:46:22 +0200
X-Gm-Features: AclHuK-ei6ZBXhhMZCie6v-LALx8ayLwHQO-HoMTB5k7bp20LKwXygcSHNE1KAA
Message-ID: <CANpmjNMon+ZW+kUvAykEKON2rDFzsJ5aG_gKYt2wr_GnmY5mQg@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Avoid division by zero in kcsan_prandom_u32_max()
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Sept 2026 at 15:38, Andrea Parri <parri.andrea@gmail.com> wrote:
>
> KCSAN's skip_watch, udelay_task and udelay_interrupt parameters can be
> changed at runtime through /sys/module/kcsan/parameters/, where 0 means
> watching every access or not delaying at all. With the default
> CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE=y and CONFIG_KCSAN_DELAY_RANDOMIZE=y,
> writing 0 to any of them makes the next watchpoint setup divide by zero:
>
>   # echo 0 > /sys/module/kcsan/parameters/udelay_task
>   Oops: divide error: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 93 Comm: sh Not tainted 7.3.0-rc5 #3 PREEMPT(lazy)
>   RIP: 0010:kcsan_setup_watchpoint+0x1b5/0x410
>   Code: ... 65 89 05 ad 8d 98 02 d3 ee <f7> f6 29 d7 e8 22 0e 0f 01 ...
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>   ...
>    __show_trace_log_lvl+0x1bd/0x315
>    __die_body.cold+0x19/0x2b
>    die+0x34/0x50
>   ...
>   BUG: TASK stack guard page was hit at ffffd3ab001fbfe8 (...)
>
> reset_kcsan_skip() and delay_access() pass these values unchecked to
> kcsan_prandom_u32_max(), which returns "state % ep_ro". delay_access()
> halves the delay for compound and assert accesses, so
> udelay_interrupt=1 is enough there.
>
> The oops path runs instrumented code, which faults again until the stack
> overflows. With skip_watch=0 the guest hangs without printing anything.
>
> The division came in with commit 71a076f4a61a ("kcsan: Rewrite
> kcsan_prandom_u32_max() without prandom_u32_state()"). Before it, the
> helper scaled the random value with a multiply-shift, which yields 0 for
> ep_ro == 0. Go back to that via reciprocal_scale().
>
> Tested in an x86-64 KCSAN guest with virtme-ng: after this patch,
> writing 0 to each parameter, or 1 to udelay_interrupt, no longer
> oopses. skip_watch=0 now watches every access, which is very slow with
> the default delays but completes when they are set to 0.
>
> Fixes: 71a076f4a61a ("kcsan: Rewrite kcsan_prandom_u32_max() without prandom_u32_state()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks.

> ---
>  kernel/kcsan/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 2db82661cd60a..a3aa5e5b039dc 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -290,8 +290,9 @@ should_watch(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size, int t
>  }
>
>  /*
> - * Returns a pseudo-random number in interval [0, ep_ro). Simple linear
> - * congruential generator, using constants from "Numerical Recipes".
> + * Returns a pseudo-random number in interval [0, ep_ro), or 0 if ep_ro is 0,
> + * which the runtime-tunable callers may pass. Simple linear congruential
> + * generator, using constants from "Numerical Recipes".
>   */
>  static u32 kcsan_prandom_u32_max(u32 ep_ro)
>  {
> @@ -300,7 +301,7 @@ static u32 kcsan_prandom_u32_max(u32 ep_ro)
>         state = 1664525 * state + 1013904223;
>         this_cpu_write(kcsan_rand_state, state);
>
> -       return state % ep_ro;
> +       return reciprocal_scale(state, ep_ro);
>  }
>
>  static inline void reset_kcsan_skip(void)
> --
> 2.53.0
>
