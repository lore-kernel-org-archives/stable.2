Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442405;
	b=d7xw9BUCpIQwJJVc28WwebtK0H4hdsU1gdbJzWScd4qnFbganhmUI79BklUSY7FgFDNo
	 iuCe8GV7YEeQ31zmnR0gZ9K46C4+RVTEEQJC0t0zunBaaXHdLnnCzYk9vu0Q4/fPnJym5
	 jOZesxbWlurR5+Cqbm9xjU9UlY9avudBFaVl91Gqqw0SeKI0uV5haQiRG8gk2Q2nj+tI7
	 CtWT7ZDfuhH55nkkB9yfr+TkXGvOO3q0bYD2IV41bxtHdbjzbodNX8FQo/TaPiPeQPcUX
	 r76m1rnjhbYetCfZVnwv0WsFFgy1FcFsTWSb2zcaFqK0Qc7WjM4vsOqw9mGQZNJu3Sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3IpLvh4knGxdnTnNg11otR5B3EwtnVVM6LJJNpQ7l8c=;
	b=5AWdq1rSWiXdorZ4WkRkLiMVAc+2tRaUYlPjDpaGF0yrrdik+QADTiofL6lKL0DIaBg4
	 c4PfhrgRLh+bqixmWXYWWiRmGlVof+Ps+t0jo9c5BQTGGasnk2m6jzaS+g2LHkMVdmgg4
	 5MXGWtfUI0OoIDHmkD2hm1icRAS80Qws8m1ksN4S21GphPNGXvGhMfEO1gDDkDoHm7i1n
	 vwW6N8aDCOyiCeDVrGan3yLAJc/unN1GbFWnJNfQQU5fbPorRutQ77yLAJ49sW4y6xnjE
	 agnzrN4fqTQMm9VzIXf6TEtoRlGReybLoPTG/e2TRGHdImgzl8jGxioA988/P+CyDiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wf63b0a8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19E606A332
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C19E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wf63b0a8
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b87a92c17eso4621259a12.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:00:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795442403; cv=none;
        d=google.com; s=arc-20260327;
        b=IVYCwrUqTppyDvFDey97Lj74YzAgR3tI2ay1kX08AzdEVBq/lm+CecPz9uNm+6AeDH
         eI2y4FmsgqzRjx25opNkJwCBseFEhRlG/LBRYXDRIMK/TmsXFG+FKWse2neoYgnd8bvx
         cUfRnSn3iWU4w2Sw0UspDuRci31rgWXy1bmASL6sexKfIDY1fQKSiPyD9x1/MGaYYLGk
         vfH8OGiOxZNubaudOUAey98DaRnoYKH5V2xyhd/VftwfsaauTeGuy5Tj4PaADHI/rC6o
         zeolQqzD2lh3MAfnfWUlvMr/5rsQONHc8jL/o7yv5AqD1YKzmvBsCSlIxiRdF0dR7TPn
         +3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3IpLvh4knGxdnTnNg11otR5B3EwtnVVM6LJJNpQ7l8c=;
        fh=DWYRjXJh/IUDKJ/NQaWJHfS3mX5wmUDs5YwxaWydh9s=;
        b=Nk+VjyutSYFwMWMeQQHdeHIcmBCBStQ4oYMVVDWpdS9HpSlHzmKXVmAFYZjAo2O8BT
         j7bmd1G5j+g9YCOoW3TiDa3AbYlBW6lFCZ0qS5Z/0t8AaMqU/wSN6K86Bd+QUSqlrErS
         zoA2j3WYoMHeN+kYqLWwGufgJhRmvXIMRaC2RUIgC2nuoX5GORPaIcfK8L5Tha+7K36u
         Y0pVQJvPcG3sJlCqklQlYLkf1ebjCzE54/dkfkRQeLmL/9v1IeN231BTZCWgDvjRmAnc
         jvNkWWJDXw/1jxHqihJrrQuILh0TP3OOx8pK5zlv+zjPn6l3hLXpHn83S+GnUc5ZvgRK
         KONA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795442403; x=1796047203; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IpLvh4knGxdnTnNg11otR5B3EwtnVVM6LJJNpQ7l8c=;
        b=wf63b0a8GVLvvuQKkSgnPHGDrXY493PPEWNsx+UBUG/zrKff5ciz+jAsCALpqS6dHq
         CVwd98uoKLQKBOwgmG5xxN8ml/h1NIN9JT7l692om9S5tUv2dfeQOnUkKmdy65G3K/I2
         ZZlkR5cAiHVsWGrB5PVBqDArCrkMmKa08uZ2OfxdTFhBU4cOrL8O6yf5VFza8IOuMBGC
         zLjfUIjVJ/8HkpcuKVrylEkqCf5kO7cXPXvQAGNifIyla7GJ5VFA+Dy0d1as0kCt2AL1
         SyOjGcsgaM3T6tYzN3uzb8YBucZ9cyA4guFUcO4G1uR9O9EHb4QnB3S61RWh+UuUXQjP
         9tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442403; x=1796047203;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3IpLvh4knGxdnTnNg11otR5B3EwtnVVM6LJJNpQ7l8c=;
        b=2o2U3ikj0C1oSclsx42AcUSdmfEJDB6sxzeU1b768zb5xPqnVpja7F4gk7prN5EYhY
         WocqGWBYu2io7FjSLSm8DsSnUMrvFBp+Gu22wk5jcQ/Yh8fUnisEnQWjfWlYX169l3md
         3MI8bfouMGj/cgDBD2sJRHoj+H0HDiAFvXccr0F7Dh//2928/C92p3mzIzLubZJpe+tM
         YG+NETVjpBh01GSI2inYWbmFpk7CMP1tMawkx813GSySc+qpRjxrNw4XeNyRVb0xYrd5
         yhrl6PQltP0H8qdGb/JY/mD28gHsvWVfpeCEoGXgiUuiNgNM43JOqiSA8ZebdbP+yUVp
         kaCg==
X-Forwarded-Encrypted: i=1; AL+hErF7K9BjptvHbTXAAOqRFhKjsvZ1GnBABLo0KMV68zEgtUoaeL6Qoe8vLtUqYommSlNOy8jzSL4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w0uAzLBDONiNy18ScTjqhKZGM4/f2hBrSlopSxA3cAIF06b8l
	JuQFsg3euBn+A4SLOY3ksmY5Enah/b+tPMbsnC1zsM4vUEzyRWyAwhN1kSU9923/jc5gq0uuWqy
	BaoDtK1q1TziGJ2YB+Caknc8aH9TM41f7r0DGlRFGZ7UzeKAtJWsxpj0=
X-Gm-Gg: AZFdTZdxU8x+27Y8eFXaA6balSdRf6QiRFNF4hvHAk7eJ3aBh6Ljl1vDLfC/gfPCGh8
	j0H9AcMJXEQgA7s5w841dzZ3EhACsjrU8yF6pA9kkei8gDz080q8zTPE8+oOfOlOhIkrfol26S/
	4sOjdxda7C+Gjqklf9ZaE1HVkEDZzRE8uiZlyuQRSEhKCvMGTu8RA3IoFbI30bwxekKfkpmj/1Z
	m+5D0oBElji9yI34X703T8hcE1ZgW35KZj6a1L6XUMYqUqeRPkrLHhfB/ht4hSiVydHFtk6J0TQ
	iMRbct/YeLoDV7YwFAOz7egN2b8dl5K/8anyJCezCo6ZSoX/5OeByzy+aYYNKec2mV0Ydvqqtis
	GgYmyf2+yhtTsqa7kNZLcK+65DozmbNuFhoS6laFU24rM7Q784mGOBWG7cMAhLwQHZY99Xg==
X-Received: by 2002:a05:6402:23d0:b0:6b1:b97b:744 with SMTP id
 4fb4d7f45d1cf-6ba37ec18e4mr6897993a12.32.1795442403354; Mon, 23 Nov 2026
 06:00:03 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOhmvYXVox0HKyvf4ypMXnojfSbMmiD43meSvVrhTpDqRjzfGg@mail.gmail.com>
In-Reply-To: <CAOhmvYXVox0HKyvf4ypMXnojfSbMmiD43meSvVrhTpDqRjzfGg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 23 Nov 2026 14:59:51 +0100
X-Gm-Features: Aa3M54rulPBFjNk7d7jfr43FoAu_vY3FFS1QCD_7Uqbba4dRH8AU-GilPmwPFiU
Message-ID: <CAKfTPtCgYYV0vopSHbWWsW1EJKDAjnuiivoVPxJWagM24RggaQ@mail.gmail.com>
Subject: Re: [REGRESSION] 6.12.117: soft lockup in sched_balance_softirq /
 _nohz_idle_balance on KVM guest without NUMA
To: Topaz Tatiana <topaz.tatiana@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sched@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 12:22, Topaz Tatiana <topaz.tatiana@gmail.com> wrote:
>
> Hi all, after upgrading to kernel 6.12.117+deb12-amd64 (Debian), we
> are observing
> massive soft lockups in the scheduler on a KVM guest. The previous kernel
> version worked without any issues.

What do you mean by previous version?

6.11 ? 6.12.116 ? 6.12.115+deb12-amd64 ?

a quick check between 6.12.116 and 6.12.116 shows 3 commits in
kernel/sched which are unrelated to your desciption
2bd4d21066ef cpufreq: schedutil: Serialize sugov_start() against rate
limit updates
521afd30851c sched/fair: Reset NUMA fault locality after scan period update
48d34dc062eb sched_ext: Fix exit_task leak on fork failure during enable

>
> Environment:
> - Virtualization: kvm (QEMU Standard PC)
> - NUMA: No NUMA configuration found (Faking a node)
> - CPU: 200 vCPUs, 4 sockets, 1 thread per core (see lscpu below)
> - uname: Linux dev-kulet2 6.12.117+deb12-amd64 #1 SMP PREEMPT_DYNAMIC
> Debian 6.12.117-1~deb12u1 (2026-11-14) x86_64 GNU/Linux
> - Cmdline: BOOT_IMAGE=/vmlinuz-6.12.117+deb12-amd64
> root=/dev/mapper/vg1-lv--root ro ipv6.disable=1 quiet
> - watchdog_thresh: 10
> - nohz_full: (null) (NOHZ_FULL is not used)
>
> Symptoms:
> CPUs are 99% idle, memory is free (419 GiB free), and load average is low.
> However, the kernel watchdog triggers on swapper/N and kworker/N with delays
> of 60-97 seconds. The stack traces point directly to the scheduler functions:
> sched_balance_softirq, sched_balance_update_blocked_averages, and
> _nohz_idle_balance.
>
> Trace 1 (_nohz_idle_balance):
> [Mon Nov 23 11:48:17 2026]  _nohz_idle_balance.isra.0+0x31a/0x3c0
> [Mon Nov 23 11:48:17 2026]  do_idle+0x31/0x2a0
> [Mon Nov 23 11:48:17 2026]  cpu_startup_entry+0x29/0x30
> [Mon Nov 23 11:48:17 2026]  start_secondary+0x11e/0x140
> [Mon Nov 23 11:48:17 2026]  common_startup_64+0x13e/0x141
> [Mon Nov 23 11:48:17 2026]  </TASK>
> [Mon Nov 23 11:48:17 2026] watchdog: BUG: soft lockup - CPU#6 stuck
> for 50s! [swapper/6:0]
> [Mon Nov 23 11:48:17 2026] CPU: 6 UID: 0 PID: 0 Comm: swapper/6
> Tainted: G             L     6.12.117+deb12-amd64 #1  Debian
> 6.12.117-1~deb12u1
> [Mon Nov 23 11:48:17 2026] Tainted: [L]=SOFTLOCKUP
> [Mon Nov 23 11:48:17 2026] Hardware name: QEMU Standard PC (i440FX +
> PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org
> 04/01/2014
> [Mon Nov 23 11:48:17 2026] RIP:
> 0010:sched_balance_update_blocked_averages+0x62b/0x7b0
> [Mon Nov 23 11:48:17 2026] Code: 74 07 c7 41 20 00 00 00 00 45 84 f6
> 0f 85 b9 00 00 00 48 89 cf e8 65 3b ff ff 48 f7 04 24 00 02 00 00 74
> 06 fb 0f 1f 44 00 00 <48> 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d e9 7d
> 28 de 00 80 3d 6d
> [Mon Nov 23 11:48:17 2026] RSP: 0018:ff7601b9c00f3df8 EFLAGS: 00000206
> [Mon Nov 23 11:48:17 2026] RAX: 0000000000000001 RBX: 0000000000000000
> RCX: ff26d7d979bb6040
> [Mon Nov 23 11:48:17 2026] RDX: 0000000000000007 RSI: 0000000000000000
> RDI: ff26d7d979bb6040
> [Mon Nov 23 11:48:17 2026] RBP: ff7601b9c00f3e68 R08: 0000000000000434
> R09: 0000000000000003
> [Mon Nov 23 11:48:17 2026] R10: 000000000000000a R11: 0000000000000000
> R12: 0000000000000000
> [Mon Nov 23 11:48:17 2026] R13: ff26d7d979bb6950 R14: 0000000000000001
> R15: ff26d7d979bb6a98
> [Mon Nov 23 11:48:17 2026] FS:  0000000000000000(0000)
> GS:ff26d7d979b00000(0000) knlGS:0000000000000000
> [Mon Nov 23 11:48:17 2026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Mon Nov 23 11:48:17 2026] CR2: 00007f32c305ce00 CR3: 0000000106884004
> CR4: 0000000000771ef0
> [Mon Nov 23 11:48:17 2026] PKRU: 55555554
> [Mon Nov 23 11:48:17 2026] Call Trace:
> [Mon Nov 23 11:48:17 2026]  <TASK>
>
> Trace 2 (sched_balance_update_blocked_averages):
> [Mon Nov 23 11:48:17 2026] RIP:
> 0010:sched_balance_update_blocked_averages+0x62b/0x7b0
> [Mon Nov 23 11:48:17 2026] Code: 74 07 c7 41 20 00 00 00 00 45 84 f6
> 0f 85 b9 00 00 00 48 89 cf e8 65 3b ff ff 48 f7 04 24 00 02 00 00 74
> 06 fb 0f 1f 44 00 00 <48> 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d e9 7d
> 28 de 00 80 3d 6d
> [Mon Nov 23 11:48:17 2026] RSP: 0018:ff7601b9c0663df8 EFLAGS: 00000206
> [Mon Nov 23 11:48:17 2026] RAX: 0000000000000001 RBX: 0000000000000000
> RCX: ff26d7d97f2b6040
> [Mon Nov 23 11:48:17 2026] RDX: 00000000000000b5 RSI: 0000000000000000
> RDI: ff26d7d97f2b6040
> [Mon Nov 23 11:48:17 2026] RBP: ff7601b9c0663e68 R08: 0000000000000015
> R09: 0000000000000001
> [Mon Nov 23 11:48:17 2026] R10: 000000000000b944 R11: 000000000000cef5
> R12: 0000000000000000
> [Mon Nov 23 11:48:17 2026] R13: ff26d7d97f2b6950 R14: 0000000000000001
> R15: ff26d7d97f2b6a98
> [Mon Nov 23 11:48:17 2026] FS:  0000000000000000(0000)
> GS:ff26d7d97f200000(0000) knlGS:0000000000000000
> [Mon Nov 23 11:48:17 2026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Mon Nov 23 11:48:17 2026] CR2: 00007f2fca0ccccc CR3: 00000001a8058002
> CR4: 0000000000771ef0
> [Mon Nov 23 11:48:17 2026] PKRU: 55555554
> [Mon Nov 23 11:48:17 2026] Call Trace:
> [Mon Nov 23 11:48:17 2026]  <TASK>
> [Mon Nov 23 11:48:17 2026]  ? srso_alias_return_thunk+0x5/0xfbef5
> [Mon Nov 23 11:48:17 2026]  ? srso_alias_return_thunk+0x5/0xfbef5
> [Mon Nov 23 11:48:17 2026]  ? finish_task_switch.isra.0+0x97/0x2f0
> [Mon Nov 23 11:48:17 2026]  _nohz_idle_balance.isra.0+0x31a/0x3c0
> [Mon Nov 23 11:48:17 2026]  do_idle+0x31/0x2a0
> [Mon Nov 23 11:48:17 2026]  cpu_startup_entry+0x29/0x30
> [Mon Nov 23 11:48:17 2026]  start_secondary+0x11e/0x140
> [Mon Nov 23 11:48:17 2026]  common_startup_64+0x13e/0x141
> [Mon Nov 23 11:48:17 2026]  </TASK>
> [Mon Nov 23 11:48:17 2026] watchdog: BUG: soft lockup - CPU#6 stuck
> for 50s! [swapper/6:0]
>
> CPU Topology (lscpu -e, first 30 lines out of 200):
> CPU NODE SOCKET CORE L1d:L1i:L2:L3   ONLINE
>   0    0      0    0 0:0:0:0            yes
>   1    0      0    1 1:1:1:0            yes
>   2    0      0    2 2:2:2:0            yes
>   3    0      0    3 3:3:3:0            yes
>   4    0      0    4 4:4:4:0            yes
>   5    0      0    5 5:5:5:0            yes
>   6    0      0    6 6:6:6:0            yes
>   7    0      0    7 7:7:7:0            yes
>   8    0      0    8 8:8:8:0            yes
>   9    0      0    9 9:9:9:0            yes
>  10    0      0   10 10:10:10:0         yes
> ...
> 149    0      2  149 177:177:177:128    yes
> 150    0      3  150 192:192:192:192    yes
> ...
> 199    0      3  199 241:241:241:192    yes
>
> This looks like a regression in NOHZ idle balancing for large KVM systems
> without NUMA. Are there any known fixes for this in the 6.12 stable branch
> or mainline?
>
> Best regards, Tatiana Topaz
