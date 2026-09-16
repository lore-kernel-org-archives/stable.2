Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08D3BCD20
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580743; cv=pass; b=OiKsKs2UQcb29rEKi1qrWO4SHVMQzNzm6qKCQRcE+Vy9sN2uRAvgm4Z/ijN7BlYc8nA3YDCAev3ONc5mHsoiGiu2OT9h3BljVdGHKtNN4uMy8btYl0JXoyH9nBhg2TOWGXCIB4XikjLQwxpYEqRCf1E1CRySa18Z1xhUk5gQoO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580743; c=relaxed/simple;
	bh=SKN0JL7GkBBUQJS84eZq1re1jMJyNZPMoGLiDdoauHY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVGaoKkjdd+xn3hKA6atXWRJ1JshjVgASwWgwBvT+Wtpgglcz/x/tmOMWGcYt+fZ7ROgmckEaiBx5glpfAiea1r4E58+FmXNbRHFEEkOru1zXv/5za9m07pdpeRIEyy9oraxSlpvZT4oBuNvwHwjfZa8LiotD5GFN5gwpou1j5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StjrCAR8; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StjrCAR8"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66d20c35ffbso232859d50.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789580725; cv=none;
        d=google.com; s=arc-20260327;
        b=BdBtcHQBFmLUyQPqiwaNrsw+/Y6Xv40StT7Cv0otoy+6d7f72g9mpqIMplR3vIKRNK
         DWIg2VOpH287UWzxTk3iWbFLBVAT0DZK+XpA3QEdWiasfdytTVPjfOMzHculSdGGdqPx
         lCyB6r6fakNZdYqgMfyKokgTrYd4rglVQ3edf7gWyuQBlLew2uloyXuasgt7k0OIjsuO
         wRq1GjJgNdigEbZGjHFUBUwpPZDdGodKROOEpEKqkfK+9z+FaqAgVU2iP2VkZo6Oc8D3
         mphNflYDHr5XlLUxKarpSrhLg2yLv5NFm856olIX+dGsDwZXh7dgP39qxHQ4r4sEklGJ
         qmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=IOYv3QgMRUMifmGGTF2BeO7ylrbnq7wWgArM3pERBA8=;
        fh=08gedX+0RJD4erXA2U5yPgJS8OSGZV+WJK6DwpHsjs4=;
        b=MuBRTGcCZdYg3mlDo4QzFYk5bqFY8Nja1CFIwAOOW3hDFKF9iYv2LFVRizWIC84yo3
         c53CQiRW4taOqhFsVYJa6kVSHFVscKU1dhdfXzicJHLyiJRBVstkjS9B1GwmHa6QqQTy
         QiYahMbHGpkMQcxh/Sax7QPZbMaWDhl2RvybMBhzlytvtGN1SCsTHf+H3oBOpXc7Cfy+
         ARTrxFvRhtdEYFm/tMxDR8S1ilQHNSxSJOLibVMY2EqwhCJqiRKydRbHOh0eyVupwOin
         qhu96a8g2qr5hn4Vpj0WepEcRp6x9qtEPfyZ6g2nn8J/LbQox7W4nezEZ6qJtdGub1kX
         9Tag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789580725; x=1790185525; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IOYv3QgMRUMifmGGTF2BeO7ylrbnq7wWgArM3pERBA8=;
        b=StjrCAR8Jl5RSTFyh4QuL5amrtJkTOzgd33RzpB1w+STDKpB3iczSykGpXYumB9aeC
         xD1vmSgRnCFr5RYxOMTuKqHRMLI09IburwSEAcrwgyyCwlZQ3KdJvvNQmHtXAy9mrYSN
         9Ans5DSo3i0ZIVso01xarLR/6alZgaldnHQQ7wz9bo4IIT42x8BVC0Sh/EvryuRvgBeM
         IR5IZT/QqKtWbhM4dfrZ5ada7rUSULNjRYIq+LgLulCfpMRLGrKFigqWL1pH4Bvk0Q2M
         1Vx3cFigBUpLDXqKaJTjaX5I4aBjFhmNmrC9IygLwKHIxp2JpKsfeXbXjEeGWA8keKI5
         UlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789580725; x=1790185525;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IOYv3QgMRUMifmGGTF2BeO7ylrbnq7wWgArM3pERBA8=;
        b=JvPO0p3ki+u70T3SXRemG8ZSpGum7ChuoOIxikHsfxq3NdlWqGBULkSx7VaEvMZ+oF
         3ZgQJqFHg2ugN8IvhS4MljzFN4WodXVGNMFY4qGwI4t6uiderAsnmlyDUnF8unVu+yYK
         AFRvqhB+sJVBsRvwYHchkQdb8EQmCbxykdyXBTbui9eIoDQMWMpkgSXBo/1Kr8ERwEqO
         /3VRAUWHLGUxFBQOCZ3la+jGVgV1iLrb0FkSi/m+j0gRtEsRVmCe2i3Uv9SGO7ZO4h5s
         QLF/eQt1Q51SAA4p+HS7Dd7jgc66OVJl1Cf/v5li8wV4GiPmonPigoR5TwRuWi0s8C3q
         gGTA==
X-Forwarded-Encrypted: i=1; AKwUvBwb0wdAD3736D11kTM1iSpTmXJ9J3wLKJixBDxIqg/n6lblcscJNMBeY62Ovam51BEDmlY52uI=@vger.kernel.org
X-Gm-Message-State: AFuF++kRxkYEHv0nYjsEM8V+MDDNzFWxT+l7pzStmXabCYf9VESBWk+j
	xSYFb46sI6tKJZmna+XiaDzdX9EcO8FTufT3uuI0oZrxjZugTrBpDhtdiP9lg9HKIY/SI7vtadc
	EmjZxR77N5PVe9qYPrEYRDXLSdZZQUPQ=
X-Gm-Gg: AYBFou3ea72al23nBtKXHh5A9YX+bxoZhrYX6VePJdg1vZNEwQoPBWzD2SZIdmp18SB
	23QpJbGTcxA8doCyhsU6w8ZImnjhxJCQXBvWQpVY6aEpysXvtK7sSdLWJ/qYr4D5ot2lDTqU0n0
	sdMaPZGDv5D7GicfOy0GA50QWsQV/e1ea1HyTAMBZpKxnCSsEHjUDTqkS9OjNOVftPC3GgKMyoy
	sBiC4LkIPs2tQaT+MdQ2+wCekf6rg9rr10A6moyybdfkyx+r+kcZUpZOYgAH/yhUKJ8Xw/0iYM1
	jO17N0L8f8PS0NV1vi6MvPhD5cD5o9o0aTgfB95qEJjeD1EMFU+b5A==
X-Received: by 2002:a05:690e:174d:b0:671:335c:d6b with SMTP id
 956f58d0204a3-6716344be02mr1247899d50.5.1789580724461; Wed, 16 Sep 2026
 10:45:24 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 16 Sep 2026 13:45:23 -0400
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 16 Sep 2026 13:45:23 -0400
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20260914093300.100495-1-huangshaobo3@xiaomi.com>
References: <20260806123020.90869-1-huangshaobo3@xiaomi.com> <20260914093300.100495-1-huangshaobo3@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Sep 2026 13:45:23 -0400
X-Gm-Features: AcwNN1UbSz9j_YK2TyroR0WvWmqVkz_Hz7gqfmErLvR7rOVGTQ8tgDgYEplJIPk
Message-ID: <CAPAsAGzVsmj4xRsJeBBBt5FvgUqWa7eyb4w=EBkm8GGeLF1EhA@mail.gmail.com>
Subject: Re: [PATCH v2] fork: reset pointer tag of vmapped thread stack before vfree
To: Shaobo Huang <huangshaobo3@xiaomi.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	david@kernel.org, kees@kernel.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Shaobo Huang <huangshaobo3@xiaomi.com> writes:

> thread_stack_free_rcu() frees the vmalloc'd thread stack via
> vfree(vm_area->addr).  In RCU callback context, vfree() routes to
> vfree_atomic(), which calls llist_add((struct llist_node *)addr, ...)
> and writes 8 bytes to the base of the region being freed.
>
> With KASAN_SW_TAGS, vm_area->addr carries a random tag.  If
> kasan_unpoison_task_stack_below() has rewritten the shadow covering
> [base, sp] to KASAN_TAG_KERNEL (0xff) -- which it does on every CPU
> resume for the current task's stack -- the llist_add store checks
> shadow[base] (0xff) against the pointer tag (random) and reports an
> invalid-access, although writing to the base of a stack queued for
> deferred free is legitimate.
>
> Reset the pointer tag to KASAN_TAG_KERNEL before vfree() so that
> kasan_check_range() short-circuits the check, the same way the task
> accesses its own stack at runtime via sp.  The vmalloc lookup is safe:
> __find_vmap_area() resets the tag before comparing against va_start.
>
> Fixes: 9f7d416c3612 ("kprobes: Unpoison stack in jprobe_return() for KASAN")

This commit merely renamed the resume helper without changing what it
unpoisons. Only generic KASAN existed back then, so it cannot have
introduced a tagged-mode problem.

The problem became visible with

  449e0b4ed5a1 ("fork: clean-up naming of vm_stack/vm_struct variables
in vmap stacks code")

which changed thread_stack_free_rcu() from vfree(vm_stack) to
vfree(vm_area->addr). vm_stack is derived from tsk->stack, whose tag
alloc_thread_stack_node() resets to 0xff. Since that commit, vfree_atomic()
gets the tagged vm_area->addr instead.

> Cc: stable@vger.kernel.org
> Assisted-by: zhipuai:glm-5.2
> Signed-off-by: Shaobo Huang <huangshaobo3@xiaomi.com>
> ---
> Changes since v1:
> - Drop the 12-line comment; keep just the one-line fix.
> - Fix the Fixes: tag to point to the commit that introduced
>   kasan_unpoison_task_stack_below (9f7d416c3612), which added
>   both the function definition and the _cpu_resume call site, not
>   the 2016 vfree_atomic commit.
> - Add Assisted-by tag per Documentation/process/coding-assistants.rst.
> - Use real name (Shaobo Huang) instead of "sparkhuang".
> - Trim the commit message; remove the full KASAN dump.
> v1:
>   https://lore.kernel.org/all/20260806123020.90869-1-huangshaobo3@xiaomi.com/
> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 45300f59cf2c..9a66b10749de 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -238,7 +238,7 @@ static void thread_stack_free_rcu(struct rcu_head *rh)
>  	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
>  		return;
>
> -	vfree(vm_area->addr);
> +	vfree(kasan_reset_tag(vm_area->addr));

Thanks for report the problem and the patch. NAK on the fix though.
It addresses the symptom rather than the cause.

The problem is not that vfree() is called with a tagged pointer. The
problem is the 0xff written into the shadow by
kasan_unpoison_task_stack_below().

That helper is only needed in generic mode. There the compiler expects
the stack shadow to be zero, so the redzones left behind by discarded
frames must be cleared before the stack is reused.

The tagged mode has no such requirement. The compiler fully initializes
the shadow of stack variables on function entry, so stale tags left
below the watermark are harmless.

kasan_unpoison_task_stack_below() should simply be a no-op in tagged
mode. I'll send a patch.
