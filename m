Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D5380FD2
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045615; cv=pass; b=O+bBtLHRbUUc9654eZMsT1n4+2Z8yvkstG4Y96gFt8Jt+lV0y1Tf7DFsrFagGzOZLH3vcaC0fpYQHi/4Lc2uO+Ui6eDiILTXxN/sPgF9O+s/W3+DvScMZ1XPQqv168+RScDLYtwWvu2FXRoy3nnAVIWSLiXmwSM5sxKtAt7/Jc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045615; c=relaxed/simple;
	bh=0F0cvRTLZ6chzP4+4e6mJ/Zoejk+z7dv+f200NSHbAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cihY5rl2nmSH6uEs+hN9Vy2XTHGx5hjs3bAeA7eDBCO6Yk04dt7GbSs6n9wVIXMiC1sAtsJ7V4BMe1+GGodu4Qnuq0crMuQXfkPTAzCLi93AWHu8sqSqUKCOj1sqk+RQtk66AL3+scA1NWakz+AGDrJMT8jlWsvXuBAzaDnjyi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j99LXy5J; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j99LXy5J"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cede6375caso23315ad.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 12:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786045612; cv=none;
        d=google.com; s=arc-20260327;
        b=HSOlXXSLkvdNkBcdbohbTfcAJ1DajnLoCik5cI0KiP8gy/8XcDs0VofkSme64SD+tg
         vpt7GMgfY96RLqrUNcw6Hlc2W8qc2WXF3p6K+cyc82ZmVW3BzoO7S6jxkDFtsp5MHbqG
         Ug7qbUEDG/fdR7UoA0fQWsDAA78sQf9gqZBDd4HecCe8U2j163a1EONnSuP8DCrxUnjq
         gWnHO3xhDZRrAv21yanK0LNQ7iBaLptocC8tp3dJVxjbH2rhDXFVCA3tWWpMod4pMcHS
         DMLjh3DKvTkICOcCDZgz3Fr/lUAhvHAMdLLpBAFCLlWfGjXqy3pZaf/Uh4t2QGe/PaiQ
         BJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H7KOw//ZaSi5DcJG6Jgw/wwS2WSFyPNs66Dip2vS9n8=;
        fh=wc4AX/afqQFg2NtB1rdQUQ/sHTPjI4108RBkjoOyU8Y=;
        b=cZt5ElJ6NN862I2EFW82ZrP2yAgJjniTBoMfM1GQ6EuRDTSePkC04h0eWQWiylnXCf
         DSWAvrsY46VO/QT+lnfppI1RVlc9D8QkOejzKmYyFsHN09LaJLmJ1RdMN3h3Z2F7gg6B
         aOG0Y90d3kVbp0prQ8SujFOz/4/lbXkeZCaX+Yp/KwlgTvTRTolvQroRdixLqAUnvmoY
         WculGbZKq3NK5bSy61Ly+wxLArcTHe9LT14RVcrvVoqN8M96EddiQJmmznnf5mX/F4c+
         I8t2tQyVKcdVo8clP6hHsXPhpzkaWWtRRiFo7i1nm86bBI1svVLMply7a00bcPaq4cFc
         eBSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786045612; x=1786650412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H7KOw//ZaSi5DcJG6Jgw/wwS2WSFyPNs66Dip2vS9n8=;
        b=j99LXy5J8ZSuaiLNOvdJU0zf8NXsDPk0kAnKyZCS3sh1aKwwHN5jQKiDF0RTR5zC78
         oqTFA0uaKPJUuFgtMACBlUjt3prM5QskY3djZ9cV9VK5EXMa0tZwxDQVVMNRiEAeFzRf
         AD9G0oeTGFjaujLdHBptKupEqnffufQV+CcBOE82f+Ld+vD8Jhi4BUTzpAwQA50Oeush
         oAy3540nEnXEy7MGN9x3yLGgDfv50kVKNv9xgO5b780n/FKTPSFOyrlHC9xME5NABxiK
         ffdOqXYju0XXkGrKoqrCWn/JOR4bz4xjtIWJjnF9XUXnb32KO+dvAhzIM+XNLr9sDX11
         LWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045612; x=1786650412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7KOw//ZaSi5DcJG6Jgw/wwS2WSFyPNs66Dip2vS9n8=;
        b=iie4j1eRkM3MJjAMPCG5pHBMh/GhAvdRmlFg9n11hn9iROhOuxaEmPCVThTfhutXqd
         WjodYFORHoxo5FpnrjQxCodEyisEfdiNv9uqOxm9BjONUYzxHU4A+hDP+lM30CAmaT7m
         vQESB8xVZIThyvo3A4tGZi4QLflaDZms4j5U25osBheIk1CyC/8ltfzp0mL07Ys3CUKI
         RGcfmNQTchQKGeFAp9AVM2NTEe/wGJuxHPWNQ7ND56onRg/mXm1WQsIP2BJVkV42kYZ7
         ezCXNqdCLB+2Ufx08E9ex4EFm7iIZt7SXtvM3IPaDI+HcITHpVW0D2mwhwX0oXwub5D/
         sa0g==
X-Forwarded-Encrypted: i=1; AHgh+RpaHmqW7J4nl0Yji9NvZPltFxzkq2eejCNjQmWapJklMeypRx+a96XLOLESNwml1dS2/2dUE5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoL50glJqhTQY5VxjATyHdymABq5/zYePolsqV/lUDpw2F9xj
	AwtGQA3cyHTtNqK1t68ejiL8YG3jnXnMUErSwy9AYDurWwHWQkcA2txfNT/VxJPkZCEFFKyRnIF
	f/N6dZm2y2bJBnyR2yLjLYWCvGtsQZcyLrlIbT9Ds
X-Gm-Gg: AR+sD13N5Solna1pvld8PdN1/9uqRZGxC/X3KI+Otq2wy6HPzWd8ARBzoL0YHDuBa/2
	c+gzI5qqRnkjCceIbBJ3hyeKqWph5mdQN1psDi8UGd3lz7LpyHYvqz9jTVcnasKFEzaQnwX7MV8
	1tH/lZcxUkl/Y6ww6qbXnV+2myMORmzjzio8hmD7YU43WvzmMw/a6VBp1P+50BrVZIB5cWcjfAC
	q4f4dORtPk5d5D2bvI9KQT1pib9/N1d9WDVkFLKI4ldFVSzhalvydOQjN3IH5/UZdCxZ+X27xBM
	mhmV846s2BOSXsrFpWpt9edbNIldcXIJ2Sr2CUdtDwmkQgCAjpSXmT7SZz+O9de3D60137uo/0U
	eLuiVvLAutzAmWfYnfuHmbv6gEebqYcM=
X-Received: by 2002:a17:902:d4c1:b0:2c7:a13a:7fe6 with SMTP id
 d9443c01a7336-2d1204236a0mr1067325ad.10.1786045611504; Thu, 06 Aug 2026
 12:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-smack-uaf-fix-v1-1-26426d389a26@google.com>
In-Reply-To: <20260806-smack-uaf-fix-v1-1-26426d389a26@google.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 6 Aug 2026 21:46:14 +0200
X-Gm-Features: AUfX_mzTNx_NDejUrVMo2sZas9FYTvDb2RHzTOu7wVxRxZ8Wws3edAyUYmDNLr4
Message-ID: <CAG48ez2BoE_TJ39fzVN6JMMQjKd3WvFGV90wrdHJvLmDLtGokw@mail.gmail.com>
Subject: Re: [PATCH] smack: fix cred UAF in smack_file_send_sigiotask()
To: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 9:41=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> When inspecting the credentials of another task, objective credentials
> (->real_cred, accessed with __task_cred()) must always be used.
>
> Accessing ->cred on a non-current task is forbidden unless that task is
> being created or destroyed; a task is allowed to change its own ->cred
> pointer with no synchronization, and changing ->cred should only affect t=
he
> current syscall.
>
> smack_file_send_sigiotask() was accessing both sets of credentials: First
> tsk->cred, then __task_cred(tsk).
>
> Fix it, always access the objective credentials here.
>
> I have tested that this bug can lead to a KASAN-reported UAF of struct cr=
ed
> in smack_file_send_sigiotask(), and that this fix prevents the race.

This is the testcase that I used to trigger a KASAN splat, with a
custom harness that allows me to test specific orderings of a race
condition:
```
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static int pipefds[2];

/* runs in the same thread as test_thread1() */
void test_setup(void) {
  seteuid(1);
  signal(SIGIO, SIG_IGN);
  pipe(pipefds);
  fcntl(pipefds[0], F_SETFL, O_ASYNC);
  struct f_owner_ex owner =3D {
    .type =3D F_OWNER_TID,
    .pid =3D gettid()
  };
  fcntl(pipefds[0], F_SETOWN_EX, &owner);
}
void test_thread1(void) {
  access("/", R_OK);
}
void test_thread2(void) {
  write(pipefds[1], "A", 1);
}
void test_end(void) {}
```

Resulting in this splat:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in smack_file_send_sigiotask+0x48/0x170
Read of size 8 at addr ffff8881001ad858 by task kcov-vsock-clie/60

CPU: 1 UID: 1 PID: 60 Comm: kcov-vsock-clie Not tainted
7.2.0-rc3-00019-ga4fe47ae7d00 #4 PREEMPT(full)
Call Trace:
 <TASK>
 __dump_stack+0x21/0x30
 dump_stack_lvl+0x95/0xd0
 print_address_description+0x77/0x1f0
 print_report+0x5b/0x70
[...]
 kasan_report+0x144/0x180
[...]
 __asan_load8+0xbb/0xc0
 smack_file_send_sigiotask+0x48/0x170
 security_file_send_sigiotask+0x85/0xc0
 send_sigio_to_task+0x141/0x350
[...]
 send_sigio+0x95/0x190
 kill_fasync+0xfe/0x180
 anon_pipe_write+0xe24/0xf50
[...]
 vfs_write+0x520/0x950
[...]
 ksys_write+0x11c/0x1f0
[...]
 __x64_sys_write+0x47/0x60
 x64_sys_call+0x2762/0x3030
 do_syscall_64+0xcd/0x310
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
[...]
 </TASK>

Allocated by task 59:
 kasan_save_track+0x3e/0x80
 kasan_save_alloc_info+0x3a/0x50
 __kasan_slab_alloc+0x52/0x70
 kmem_cache_alloc_noprof+0x161/0x290
 prepare_creds+0x3b/0x2d0
 do_faccessat+0x1cd/0x7d0
 __x64_sys_access+0x3b/0x50
 x64_sys_call+0x297e/0x3030
 do_syscall_64+0xcd/0x310
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 59:
 kasan_save_track+0x3e/0x80
 kasan_save_free_info+0x44/0x50
 __kasan_slab_free+0x47/0x80
 kmem_cache_free+0x132/0x340
 put_cred_rcu+0x131/0x1b0
 __put_cred+0xb2/0x100
 do_faccessat+0x5cf/0x7d0
 __x64_sys_access+0x3b/0x50
 x64_sys_call+0x297e/0x3030
 do_syscall_64+0xcd/0x310
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff8881001ad800
 which belongs to the cache cred of size 144
The buggy address is located 88 bytes inside of
 freed 144-byte region [ffff8881001ad800, ffff8881001ad890)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1001ad
flags: 0x8000000000000000(zone=3D2)
page_type: f5(slab)
raw: 8000000000000000 ffff8881001ce280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881001ad700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881001ad780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8881001ad800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff8881001ad880: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881001ad900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
