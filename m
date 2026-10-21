Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792607385;
	b=Jf4hlNbOWQx56a4DBMZ0qM4ug8Wi4+/8n534qdYU0Jo5fEoRjatJDjWPy+45rrRdgW05
	 R92B3p0Ix7dnK43S3RiuzBw0VVgacyuzlsb9aRmbHL4OTlQVJlVkgG+Sh9lFjBKdB192D
	 twCTyhecuI+mro35vZoYcz0ABTL/1nnmCaH4FLjLFqOp4bYrDi3NkdcgI0RqSZP24PsDk
	 Ioe7GVT4BsTsEX4htWMRvc5A7OCgQE9quis6dbJ2+DWyy6I204QonE/FLX9P0qAXD7lES
	 CXcaElCNMxgY66lropZo8bEbIBHQPbfTBCK//A/D6Z8oPSXpLH7dHebiiAf+uI/vd6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zNzj/nwpT7sp/+0FKjS9bH1e9IBQXTtxz8PSLmwa0TQ=;
	b=JLUR0rsGrH5bAESC3C2nrD+fCmhtYYiZa9x10cNyhRxvVwnymSBf9hDtQ4Icfaijya2E
	 y31WfuV10460inQjIYasJXP6CzzMeg4pEVhZXAJE9dCP9MN2x7p5nAHLh25rH7vQKuH4c
	 +SnjeeHF+Qvm5he/M/YGY6xUSMRwUBCY1O+GnmbV+R5d7VPx9wN4t312Nj+IfnMCC4FVT
	 /WO/z537J0lPPM6eHZR+Bw+iTzF4FUbUXEgUN9rdQRV3beRnmIKri7ECuNlgEwT3Kh7xA
	 cq2grNPKGRNtm+NM0Zph7xeBxjKgAo7WxjgGtSCHga2Ox0T6p8RH2SxryGL9yrePe7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uhEr+jKk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2526606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2526606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uhEr+jKk
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4be28b82so954606f8f.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 11:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792607383; cv=none;
        d=google.com; s=arc-20260327;
        b=lnXvMfw+U7kM6LmzqmiwlRZNFS48KYGlY5ZElZS/Oa5AkvmWSCvVN5DdNNShqvF90Q
         xFR4KiXHGw0GEn6+0RgMNUkUlMWum/IgUs/dPJxnTh8nCZ7z3pxyEAoVX0XWL2JRnIqb
         /9B8qbtzMIbsNH3Qkos16relegBNt8N/DbobMMVOYrGfHww8FhJG+A6vJe2nvMc3BPQ8
         lwoK4WM/Tb3tJFRywd3V8OPUwQBOZzPYbOcWVzRsZLSt/FF3yIdSmCIgJXzL6Rx0mq+U
         UiepZgtuw8GAoTe4YTIsxt/yxA9V8Uoa+mB3z8yMrbX3T2jAW1vBVNch4Og+Dwf9VK/5
         qeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zNzj/nwpT7sp/+0FKjS9bH1e9IBQXTtxz8PSLmwa0TQ=;
        fh=WlZfHtPL40E/5Z17rdx4ItbWfLtRWH4WTXR4P/msyEc=;
        b=TpakIOfKCzTrZOPo6cMpKOly0UfYdUSoUhF4BXsr/DZLR9AXO6SljmHIGZ81erig6x
         gox/I2EPTXoiuDy61Cci9CX9euEh/pVDTm0cJfD4bhZcFJmVjoJDuEoYhbKztVnMhbtb
         R+HjPlsN77fHWvwCxN4eA5veAWTRuHRcf9ICbAagdee/N4frQ65MyIh1kZFUuAqZNUzq
         rPRuf3xRp9odM7SmaI4q9P6IPBQk1xZ6j0f9aPV28cqn4NGSYuKYfIymFs3Um4ArYv1B
         woBYolQqvydMzo1MnnKBRO1esyn0enf6SuzCZpIBO9wjy/hz542zlgfS6q9p/qGs83ma
         +f4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792607383; x=1793212183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zNzj/nwpT7sp/+0FKjS9bH1e9IBQXTtxz8PSLmwa0TQ=;
        b=uhEr+jKk96hzkTwObdC8c+APl616ShEbFaMN/hljBiXVKAJapK7ag+qgMNv4vZOI/j
         s7S2Gv4mSQUzIdIGq9RSvJ2ltqCVM1nt/AOOB2IIuPZ/lOoWyCaXC6PbISKgNMK855Uu
         ZYHCEGK0cCxtto+AsiZeVpKr9xeYkTv1VaveQvwKZtNWSSdY/yzBHRdGYBUGxXlPy1l9
         dgkKSxm2HRnVtnT8mc285pX6F4GMae5XJCOXAMekfbhcH5HvOF4Xv0vBGhnh/MFvOraN
         B6gcldVhTm4Z9gDsvKE0InacApMUWDiNofzJVql6pzqtXPsLnjrxAXSA/MfUbB1Kw7b9
         1xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607383; x=1793212183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNzj/nwpT7sp/+0FKjS9bH1e9IBQXTtxz8PSLmwa0TQ=;
        b=ekFhKqHsiQh1h/PNtvgIu3wpOh/AESnMZ5QMJgyDr2ayyI5Cgs8qzFkAx6hC1KTfnx
         nHvWjk2GQG+zrVMsgv0zZVr0hC5wlqGXc0NlNRGpGKgU+vDtnVTQDIWYB/XFtJgUzB69
         J/lvwINDbM51iCbVNG8aF6prqoLKAp2ZGTSjnp8K8sIH/OneUTo2P9tgAERNr1Qv+ytn
         De9q+ZPhUvwf2ytzFX5FcJcJg0kz3+677cefb13k6cK8nHsLQ/fTEBL4vmIrJWaDkd/V
         VFTJ4RXpJXCTozuVF4dTVa3yR1uUdMH31YC5u8t+E3LHl6ptTLjvUBVHAScQ+wDo+wZ0
         SXTw==
X-Forwarded-Encrypted: i=1; AKwUvBxNTr+OHq7vI3h8GSCmPAk0PkgvuyilBz8OpTimmjG4+QYDk3iR7UR2LZvDQIiSxDfaTT3dhSc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJT/Gvt/tX8QDmXluE8LWRNh7knwPZVaznp2FJvlqi0skBJ8Wg
	IXawyGte7WkDvg1Y6l5WkqC2B/lc6hAzYSxYnoANwfBNaNMB8Fl+E4vQ32wSyGAodIHxXEb5o4X
	pp2oqDHpaivYW0DAViKBVJ/IzkuFOEzFK52+ClfM=
X-Gm-Gg: AYBFou03R83X6PY+gGLbtyFsAEcnZlEwgQLxbvCJfJ619hRDsBld6aUkbZSdmm5RzYd
	qGt3SwXIpxXoXFcQkePn3MbLCUj0HncT11gamwwu4dFufG2tIIFg8FAEzeLtW6ioQj5UHqgUYRT
	h02Gr0z5/ZDFWJ+08KaMkcqnmZ73ArmKHzOo7V/hN1wtEC0pZQjKNKLle6yQ1gcsTKMpADyAnHI
	7I7w65NPMD+pqMZLlhXYwr/vJpE+D0oTGFjiSWQMUcQNU9KyT+IMGou5XOfiM+sHuOPRtgZCh+g
	iLE0KAQGSw56tuGuPTaOWPvRzsTvDN6DLiTKvUy1ZPet+W4DPvdJf0/ydEATR9n72NTbaxX/WBO
	dUthrD3oZwypbpiDXVyrHMpmw6F5IIHc5CEymxqG7cy1BfjoBIo24vdC3dZanMwt5aOZvKl1y89
	H3HY1gOzBF3Swr+xjeSyAvOSoAGFATsXhV/539I0Ab5mwZeSd+7lO2WVAncAYkdaatd9Fsy5PfI
	nuEDTqMhG3kS+WYWcXN5iq8EFTeC4s+ySl+kaclK7grVNCkoD8U3mVzpTY8JdFeE3KppgIlK8Q=
X-Received: by 2002:a05:6000:230b:b0:48e:d88:55e5 with SMTP id
 ffacd0b85a97d-48e26450055mr6466370f8f.6.1792607382625; Wed, 21 Oct 2026
 11:29:42 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019080324.4147815-1-4ncienth@gmail.com>
In-Reply-To: <20261019080324.4147815-1-4ncienth@gmail.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 21 Oct 2026 11:29:30 -0700
X-Gm-Features: AclHuK-WQNEEmHu8rKLAOcS4kdd24XhGHp0io995JGj81OD21sSnuH8TiknMehA
Message-ID: <CANDhNCrZbw-JnmC6DLWp6FHe6Vait=q_0uwRE1HqdbDYjL0Zwg@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Require permission to set auxiliary clocks
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 1:03=E2=80=AFAM Daehyeon Ko <4ncienth@gmail.com> wr=
ote:
>
> The generic clock_settime() entry point delegates permission checks to
> each clock-specific callback. aux_clock_set() does not perform one. Once
> an administrator enables an auxiliary clock, any local process can
> therefore change the global clock offset.
>
> A test process running as UID and GID 65534 with no effective, permitted,
> inheritable, or ambient capabilities set CLOCK_AUX0 successfully, and a
> separate process observed the new value. The same process was denied by
> clock_adjtime(). An AppArmor profile denying sys_time also blocked
> CLOCK_REALTIME changes but did not see the auxiliary clock operation.
>
> Call security_settime64() before mutating the auxiliary timekeeper. This
> matches CLOCK_REALTIME's permission model, enforces initial-user-namespac=
e
> CAP_SYS_TIME, and gives LSMs the settime hook while preserving authorized
> clock changes.
>
> Fixes: 60ecc26ec5af ("timekeeping: Provide time setter for auxiliary cloc=
ks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> AI assistance was used for source analysis, reproducer development, and
> validation. The submitter reviewed the resulting change before signing it=
.
>
>  kernel/time/timekeeping.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index ea2e6e55f37bf..1b342825bd8f1 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -14,6 +14,7 @@
>  #include <linux/random.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/loadavg.h>
> +#include <linux/security.h>
>  #include <linux/static_key.h>
>  #include <linux/stop_machine.h>
>  #include <linux/syscore_ops.h>
> @@ -3215,11 +3216,15 @@ static int aux_clock_set(const clockid_t id, cons=
t struct timespec64 *tnew)
>         struct tk_data *aux_tkd =3D aux_get_tk_data(id);
>         struct timekeeper *aux_tks;
>         ktime_t tnow, nsecs;
> +       int ret;
>
>         if (!timespec64_valid_settod(tnew))
>                 return -EINVAL;
>         if (!aux_tkd)
>                 return -ENODEV;
> +       ret =3D security_settime64(tnew, NULL);
> +       if (ret)
> +               return ret;
>
>         aux_tks =3D &aux_tkd->shadow_timekeeper;

This looked a little odd adding the security_settime64() check in the
core timekeeping.c where as is usually called closer to the syscall in
time.c, but given the clock_aux k_clock is defined in timekeeping.c, I
guess this makes it the best place to add the check.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
