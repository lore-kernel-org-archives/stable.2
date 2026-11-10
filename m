Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794310627;
	b=PPhOiuoodkirpGsGEDnax1k/ou+vnzxIKfO5uIoyMYfOQbaWmLgq2SYE6ND91WNSmDGV
	 aglzBccgcYeli+Oyaa0d/hYygK2/mo/svKV0RoVoz/2bBDQ98UhnPb+w4Pug9FzMwN2kn
	 SkAnBqfSQeJH5bxw3jt04efLYhgTQthzWCfUfddpypJMbKMTj+J/7VqmPqg4jSKxmheo1
	 bKlKZi2C2Nmbp3xBBzJ5vKIztX7dvRSnhrCeWrUsD/j0vkpLoNDwzDG/PAC/nXy9M2259
	 735ycpUfTEXtZs7BupzPijecUMh3Dp0Xy90UGkUDOkmllPtP7u2f82k1TQ6Hi41Un+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qt/neJcxZ9xZ75W+JO0+hRLDr4yabM2iU7/BXS4KDeE=;
	b=txkh+GhHSgkjs2dST/h0iU2Zo88nvMrFklgqNUfhNWTRgiGbZhOMKuX/IqT8yTL5/AYk
	 pCtzZd823qiFY4HGGefqd9vK7cEhk8/PpsNx/0FH3v4jNTSy/zyeUhTlvUZTSiNy2dQ5b
	 9hx3R4PB5Styw0Fub34EDk+ViTEjLGmLk33t5JiyTvRmNAorKWXS/PFnJXdg5NdL40qFA
	 zVDbrF8BZMvlVCPVJzd6bjH2p/pDcgJEEPX98urUBHKCaGZuiakZQ80rDSY1gBMsHMkBc
	 GTZZcfkwxQibe3VMvy+16MckSZp8/u/hJkCnJmR4V1hNO522ZqkrAD4B7lZ+nF1Yx8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JTHyTB6n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B269606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B269606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JTHyTB6n
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c05273c38so2263197d50.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:37:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794310626; cv=none;
        d=google.com; s=arc-20260327;
        b=Je5dyYHLMb+6HGtP80Vs1rGPXlXtTci0rXpPXUHmjDLInnOSPk+RC3HSzXPtoEPciT
         IxWWFQeLYBE3ex/o2JwnMarmeCHlrErCk4KPVRK+lbCOUtWUlRZ2xPHoyNtTzpLRcpLt
         6hEMGQ2ftSuHFL2fpj0U5M3Oa5ilYV606KWbA8HiBF+m8rPqcLW4n9Ybbn4Wj7wDrXpW
         2dAMKzya97Wyu/Pyp8HvBDiYmmw/SFghpDQiX4P0AV8OP1CFaBLIrV9vLGUlyyDZmhez
         TyLNFFSjpOjCk3r5VFWud9tNI9O6i77suI3uXGmc3RZ/tbSBupoLSb/NaVXMH7m4ftOd
         sv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qt/neJcxZ9xZ75W+JO0+hRLDr4yabM2iU7/BXS4KDeE=;
        fh=+RgtVU2ovOiTNEOg2BoGq5Vs62kDe8yDsgav6zUhibc=;
        b=MVxZ+hmZLGrql8crzrZgvF6Lcje+e+qXH8CfX8qw7C7bq/nwPQ0N0ykHqSeHFGBGJB
         Fm4QXZday0vDCs6pwzdbeVWSs3lq5kWsGYvmoANmOGnIUMZVFwgTpk4iVO0V0jtvVkP1
         2NYP3U+MdH8zyNLMaPQjmvCb9mVYch7MY6VuJ9ccIMbUatmMhO7JfmZg3uZRyh6aAXm4
         IknZJgpw2PzeA5uMLZQmx1/2A1yG+5ir7uneYPNeQH3S8vQVTrNM6idyp+S7fdmMXWX2
         yJIzyiugQ8dvvuxanZ6htubvOLz5YehpRNK3d17P/67q9zZRUY68jFPGpnRIEDZqw+p8
         amKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794310626; x=1794915426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qt/neJcxZ9xZ75W+JO0+hRLDr4yabM2iU7/BXS4KDeE=;
        b=JTHyTB6nbZ8JaA/jdut3kJtMd66vKZ67uO8vZqznGa2kOEFm+X/fcfaMMWSuW7O1by
         ldOQw4FC/6+3QYvmrdG9gUV2ERIfRnrNjo9543Z4NaaSie5iw/e9wNBcLksOxhjnmUWp
         D3X4c3nfy69aLw6Q9L1mVRSjkWd/VMSP3gzGVKCpukMIJPcKRiSeytXqE8f2bB5EhpMM
         alKLIfcFv6SxTZlX5DUbBlQj9wC/Nn8SOqxyKfb4UeRERyXWwGOaLDDtQKu5S+1nCrS+
         Cuy8aDkbQinmx2QGZcxW/XGzyrjoUVjSj3anNguDFH3AGuoxxk2hE2fQhyR5J6v3ip59
         yiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794310626; x=1794915426;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qt/neJcxZ9xZ75W+JO0+hRLDr4yabM2iU7/BXS4KDeE=;
        b=wmBqXAPd1QcHP9ev4I2w+OyEwCCU6amYh7tK5oSwRZii4/1MFFZMGyRt7yPdDNRO9G
         BO0unJj404zM3NUKU2LMP8Jmfu9cuZy8+fgVSthzC9BFljxxymjf48FIr1icBR7IoXUH
         dtcpRHb7jB03eV5LebXMq0n7TTeSVp+glb3UFIfdH7HqXCLtu0sSSSNmK4F9pz8WLml0
         JrORF9RYt0o/QqePxeKtge2Gfw/g54hayMeXsrSX5dnyqRZRhmW2riRHLiASdX+2R7mq
         ncVV8Ue0h30tsv1fOfIXmEWZf+CQCU0rM7rystT0bjpbgmJpkV0zHi8vJlVvWhvnfmTJ
         umig==
X-Forwarded-Encrypted: i=1; AL+hErHhOYJVPamDvP54k4JRMjCEP1Unq7XbhcXgdkAHLtSxTAy1cJCv/YyHLhmk/wxBRIZCeKljALg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iblIzuNd6eZNrW+cZoSdxdmPcwDQWEsjJOEdFejZGllDKJ2Pd
	GAmVoYRwqrLctbY4pta15D8fmHlGO61oKtOtIJTimJG47X2AjOryr51283nPCnYlhCPgqI0mOtc
	eWjkBHnLm76OwvPBxLJODj4Exglz9EpNHYq4m
X-Gm-Gg: AYBFou12XQ/ha6x8DLSn3rh0MWoM8ga3XdOQDmtrWKvqnhrBgF8+shFinW0qMBMNlvr
	+/hOL9VbLqPQ+L2FOCvtoCSX6O3TQO7nNo1eXMsML7zAv1APAIefuuEroqEOjVDJjcMrPYTpPJL
	OFOSp/teKGinAv7JkZeRZtxxYee64nBE7j7CfB9A9/3MrDVkG5Zb7KBploEdST7M0xM5pTdxut9
	9fM5gGoArsCwTwJYHp7STZIiDzC28eyZeBSqcrryyjuLPeibMqL0WNB+MIwDyqiQfU8ttzl0qZ7
	4EHJKtY+X2s35SqKBOQ6iPq73oxgHnzmiv/9Q7snuvN0o256QTIAANz49B4L5vLs6y/Duh+S2AN
	mkxalTGlLEs51CCydxf53/Q/sTJWBeZU30jJ31+k3yrmq7s/n7I/Rk7e5BcsIsYrj6A==
X-Received: by 2002:a53:edc5:0:b0:679:887f:a2bf with SMTP id
 956f58d0204a3-67c567cfd59mr955013d50.36.1794310626310; Tue, 10 Nov 2026
 03:37:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105160209.1504867-1-ekffu200098@gmail.com> <20261109213346.634e83b158ee7086e64f9cd5@linux-foundation.org>
In-Reply-To: <20261109213346.634e83b158ee7086e64f9cd5@linux-foundation.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 10 Nov 2026 20:36:54 +0900
X-Gm-Features: AclHuK_2rdVIzXDvlS0k-IPNS1HMB51W2pzMFbgaNitdqk4GrOOh4YW5AtmS_js
Message-ID: <CABFDxMGtYLFSiCLHsXn_ihG3cv-oCgo01FW6e+9aYN2gvM+W_A@mail.gmail.com>
Subject: Re: [PATCH] fault-inject: fix boot failure with fault injection boot parameters
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andrew

2026=EB=85=84 11=EC=9B=94 10=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 2:33, =
Andrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Fri,  6 Nov 2026 01:01:58 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Since commit e9bc360b105c ("fault-inject: use prandom where
> > cryptographically secure randomness is not needed"), setup_fault_attr()
> > calls prandom_init_once(), which calls kmalloc() and schedule_work().
> >
> > But setup_fault_attr() can be called from __setup handlers before slab
> > and workqueues are initialized, so any fault injection boot parameter
> > leads to boot failure.
> >
> > So use DO_ONCE_LITE() instead.
>
> thanks.  I'm surprised that command-line fault-injection options (or at
> least failslab) have been broken for 1.5 years.
>
> And what's going on in that code?  Why does it need to call
> prandom_init_once() from three different sites?
>
> I discussed it with LLM for a while and it proposed the below.  But I
> ran out of time to think about this.  The code seems to need a
> signficant rethink so I suppose a quick bandaid as you suggest is good
> enough for now :(

Thanks for looking into this. I checked the proposal from LLM.

>
>
>
> Could we use a shared initialization helper instead?
>
> There are three prandom_init_once() expansions in fault-inject.c.
> Each has its own guard, so configuring another interface can reseed
> the same state after fault injection has started.
>
> DO_ONCE_LITE() avoids the allocation and workqueue dependency, but
> doesn't serialize concurrent initialization or wait for another caller
> to finish seeding.

In theory, right. But IMHO, do we really need serialization in
setup_fault_attr()?

> The patch below keeps prandom_seed_full_state() and gives all three
> configuration paths one lock and one completion flag. The three calls
> remain because each interface can independently enable injection.
> Moving initialization to an initcall would leave boot-parameter users
> able to inject faults before the initcall runs.
>
> An ordinary spinlock is sufficient: these are configuration paths, not
> the interrupt-time random-number generation path. It also preserves
> the lock type used by DO_ONCE(), allowing the RNG's ordinary locks on
> PREEMPT_RT. No raw spinlock or explicit interrupt disabling is needed.

Right.

> From: Andrew Morton <akpm@linux-foundation.org>
> Date: Thu, 5 Nov 2026 10:01:33 -0800
> Subject: [PATCH] fault-inject: initialize random state once without workq=
ueues
>
> Fault-injection boot parameters call setup_fault_attr() before slab
> and workqueues are initialized. Its prandom_init_once() call expands
> to DO_ONCE(), whose static-key disabling path allocates memory and
> schedules work. A valid boot parameter can therefore crash the kernel
> before boot completes, even when its probability is zero.

Right, and that's what we are trying to fix.

> The debugfs and configfs setup paths have separate prandom_init_once()
> expansions. Their independent guards also allow the shared random
> state to be seeded again after another interface has enabled fault
> injection.

Reseeding could be useless work, but it does not break the system.

> Replace the three expansions with calls to a shared helper. Serialize
> initialization with an ordinary spinlock and set the completion flag
> only after prandom_seed_full_state() has finished. This retains the
> existing seeding algorithm without allocating memory or scheduling
> work to disable a static key.

Code description is correct. But we can easily find how the code works
without this description..

> The lock protects configuration-time initialization, which is not
> called from interrupt handlers. Use an ordinary spinlock rather than
> a raw spinlock because the RNG acquires ordinary locks that can sleep
> on PREEMPT_RT.

Again, right, but no need to describe this in the commit message.

> Fixes: e9bc360b105c ("fault-inject: use prandom where cryptographically s=
ecure randomness is not needed")
> Reported-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Prepared against c2366a2edc886a5a02d2a43de8b1c6ec09bab840.
> Source inspection only; this replacement has not been built or
> boot-tested.
>
>  lib/fault-inject.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -12,6 +12,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/stacktrace.h>
>  #include <linux/fault-inject.h>
> +#include <linux/spinlock.h>
>
>  /*
>   * The should_fail() functions use prandom instead of the normal Linux R=
NG
> @@ -19,6 +20,24 @@
>   */
>  static DEFINE_PER_CPU(struct rnd_state, fault_rnd_state);
>
> +static void fault_random_init(void)
> +{
> +       static DEFINE_SPINLOCK(lock);
> +       static bool initialized;

declare below fault_rnd_state looks better.

> +
> +       /*
> +        * Configuration paths must finish seeding before enabling inject=
ion,
> +        * and must not reseed state already in use by another interface.
> +        * These callers are not interrupt handlers. An ordinary lock all=
ows
> +        * the RNG's sleeping locks on PREEMPT_RT.
> +        */
> +       spin_lock(&lock);
> +       if (!initialized) {
> +               prandom_seed_full_state(&fault_rnd_state);
> +               initialized =3D true;
> +       }
> +       spin_unlock(&lock);
> +}
> +
>  static u32 fault_prandom_u32_below_100(void)
>  {
>         struct rnd_state *state;
> @@ -50,7 +69,7 @@
>                 return 0;
>         }
>
> -       prandom_init_once(&fault_rnd_state);
> +       fault_random_init();
>
>         attr->probability =3D probability;
>         attr->interval =3D interval;
> @@ -240,7 +259,7 @@
>         if (IS_ERR(dir))
>                 return dir;
>
> -       prandom_init_once(&fault_rnd_state);
> +       fault_random_init();
>
>         debugfs_create_ul("probability", mode, dir, &attr->probability);
>         debugfs_create_ul("interval", mode, dir, &attr->interval);
> @@ -456,7 +475,7 @@
>
>  void fault_config_init(struct fault_config *config, const char *name)
>  {
> -       prandom_init_once(&fault_rnd_state);
> +       fault_random_init();
>
>         config_group_init_type_name(&config->group, name, &fault_config_t=
ype);
>  }

In general, the shared initialization helper looks okay. But I think
this should be applied as a separate patch. Also, the commit message
is a bit verbose.

Andrew, is it okay to send an extra patch based on your suggestion
with your co-developed-by tag?

Best regards,
Sang-Heon Jeon
