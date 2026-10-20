Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792455399;
	b=LGo9N7/wa6gOV+riDxqUS5qFW8RV9miX4QGCTtrH9DkBJz3e9WrQV8PzTzZOac4ri112
	 aVgDMnl4MTFhfea69pCp9iFoUO8K9BTLd4NLDa4D4MyPnxO+Cui8/tfQPf6HcxQRtW8uM
	 QedvxtZXXgIQWCYkFcXJh9guMUpaW5s9SphndYTkV/a4XefSEMVM69RbpOFkhfwzEx7zI
	 MNyfVFRtCBqdOjOeEvurOotwI4gLsDh6ih2mW6EC+GRDCD8kNME8CFdRxNwV9vnLbeXTl
	 UUnrJWE8Gm3y56YywbbuuPBthebUFHGq89gh24lKxFdPXYia93QBVUs5UbxT+p2yqHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oeN6lMsAWhAX3rKxSpB3MVxlEglVTKUqWIRPPdmiiXQ=;
	b=o/B48tiywj0OM+9CniWszXmsgMleCksn9bZkJv+/Au1p2mu6XcARgbaIikm+EV2B4Qil
	 eo2q9aO60gb2Metf2AJkrriPYAfPWLmC1VjGTkYer/Ss71KqmtfoWw/5KJDdkXfe5vlc7
	 RiskSYWZohhoBk+Q924jB3Kd01FZ+DlkIwRk4V+afTv6tIf/3RJWxld1OjYx91WqdW/nJ
	 8zZhPcjDQX0UVbYcFzelUedKY3Z83qjMetQgJp4fVRd81bSvyYPkjonA2u3Ks9ADEtk5X
	 38z3nLfOFfhyXeCG4abhV4ewCvoTe/SZGy79NKsDuC4t+YJb+fAxWgALJGF2Dcf+veQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtSaiqpa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8891606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8891606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtSaiqpa
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ab432273c5so21007027b3.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792455398; cv=none;
        d=google.com; s=arc-20260327;
        b=WWO10LUDo4cEX9g0qbMmxY9LGHHuRkAjLzYmivoTjlPfHXOd8ZGXd0DW/ffV5bdip/
         OMRSKk4iZIRRhtf0xjeRcQ86V9f7YNua8KzO0wQn6HROPA/rQ5Fs64RkEepsaLX+XQn7
         ThqL+4GcvcrXlDADv48b1dVhwSGYR3qveyNJmQ0ZZB0H9PwKNkwEOp3ICe5+Uel4WNB8
         m+rLxo+bXESoswaVe6sW0PhHyZv3fDCGSzRNujqIWP2dJadns3gaVAd4reARP7w1iQ7K
         D2Cn+KvsaA01OGCG2WvmTPDUEohN43cLXV6L6nE/KKJQ0bklbpeN2xGl62cxixpbdpuh
         ywzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oeN6lMsAWhAX3rKxSpB3MVxlEglVTKUqWIRPPdmiiXQ=;
        fh=V6lI6ucaB4moqJil1zwxuhpsRhpvmfHt+impjExPSOU=;
        b=WHCfKkH8/Ehz8sfDGUx6DyuSsVSuQYsmTbjlk0iOHXkaFskQj38PncYpvlFNENwMud
         DWcriVMNrUfNB4TC1qqcAX/e/ixguXpyUHyjx2hDVr1nKTx9qaTo0CBR9p7scmMF1Osy
         0xvXhN7I9IMxIns6KJeh4CEryBUMkDpY0sHXlqhQEn/eYwFzUmOSxS1MOwxNZ/7PGB3V
         LS3GjSS/w/H//2jDayGMFCk1VPf6O7WQNIy1aPBrg9BxROvptSuKhGQ8KHkWtKfv4fOL
         VsbO4BDCtoBJQZOvk04OmrIW2evd9pHJpfs5T/xZLsuAaGF0cQfeDAMoytcjfREK7G/B
         d4LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792455398; x=1793060198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oeN6lMsAWhAX3rKxSpB3MVxlEglVTKUqWIRPPdmiiXQ=;
        b=mtSaiqpaXPHOTOYZxrcYudF+/TTIssk3CHGyluy/NHZU2UHfPIW/kkkts3ygzRgiZM
         rgcWXcanDp5plSca1bT1nbkKqcNc45w7wHKtkEr+pKo/7wtW0uM16vdarUN3tPMtOsm/
         3P1TA5Y0CSOkAhJzXUamdiA1a8huenoB6taH1YlIjysj7e3VK++qfLcN7CgcYVIkYW+7
         +dn/1yn+Zl8BoQUH+EoaR3lS0j3K0uqE12VL+QDzvj4/mYTgwSByJfeVvKfRcl/iKMdt
         Bva66lFkCqm5lcp5xI9PVxNHzqf4oLSczUzdDMwU8Mbmzj+riuLGAgkRpdv6J5yGKQ9Q
         N09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455398; x=1793060198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oeN6lMsAWhAX3rKxSpB3MVxlEglVTKUqWIRPPdmiiXQ=;
        b=GiA7RbuSHp6QxlxHsF+greka926frQ7UM+RPF6Bv7SwiVbvQ8RP4BwW8q1tENdoUqE
         JhLNfrkJVGUxOByo/Ctzl13Z5Pt03rCr0VUi1tdTWRd7mPDxNFZtBDXqpn/cboHzLS0h
         3scZI7OHyYTLGy76xcazhyUvnsXplhF83R2TTnUJm8yxeXC3VOTOsYzTOUCia16sG2Da
         RhIdXx3hO9ZGQaSx+EfzB7NOyd+GW2GRbNtAuFuwZR/gEiCVxKpJ2uWE9zoOkOSVMnaM
         A+jLkqJ5PyK00Z8QgHt+YK1AYwekSspEpZSKeONfQA4NArioDzWiiX17eV+x+uGwRflc
         ZyYw==
X-Forwarded-Encrypted: i=1; AKwUvByy/hr+IbkkD+ydtz76pF97K4madVX1izKChDcVvoj+hd4zfNGfQen1TIv9uHv7Tw9AmX5SDDk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgTKsChsMtokrhk3JPL8w9b9YVtGVhozHRrfIxwAXXF3Jlo6Vq
	Gt8HfHi0miPNAuLsK8rPI3nbR/RuXYlh58ddnFlZdj6DOp2OWsqaRWehrjZ/QYVTLuhz1Vlapq3
	s957+xDpo5vw7qTuWYLIq8QiSJEE+igk=
X-Gm-Gg: AYBFou1CIXO4vLKgC8dpduSnLgFj6vfx3yAZ/svxVAlUMJrOWeLPyn/VhLrj9jaOzA2
	BcnJ12l2ab7SFE3f0xccWAD+VOqooALbBFeMT8E1Q3O75SKb+PnUKaINw2hJLU9DxOkPHaotzBJ
	yA+1eJ5wTkG3SNkjku/0w1eSgZxTNIbKsY44oPk1NFmeqv5XmWkwmqo3klJCXTCbW4jvKzizn0N
	lSqMtxIO1ikWYX3seIc4FMCl6EH+328zRUWNK1eiYlw8ft521VjU+gFHk3AuRgQJa3yk4ldUYK3
	+pQGFhp6V/yIWA1OAvzHllW05NfG4t3v/7E62r4FR0jvJHYVIMd3+QOFGV0TOQCxlCQV8fB/EZS
	xkofbuvpfRKEh4hF50UVcBB1qb/P3QIO6TZ2bDe76vvpetabPOwmYo/qkhuaBdDmKMRqA3f6P3m
	SVHdG/6ZDEM0I5MEC4e1xrzYeXAp8QILGthA==
X-Received: by 2002:a05:690c:f8c:b0:8b0:f116:122a with SMTP id
 00721157ae682-8b0f214020cmr42505667b3.14.1792455397879; Mon, 19 Oct 2026
 17:16:37 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017050928.128582-1-sidchintamaneni@gmail.com>
 <20261017050928.128582-2-sidchintamaneni@gmail.com> <CAGsJ_4wGq9oc05=-g4aWptLdCbTwUjMjXk4Rd6KjJ6x=tzMm+g@mail.gmail.com>
 <CAE5sdEhGFtGF6LC4xNkMwGj3vTxLOW=GNBXnk3-JmsgjntXx0Q@mail.gmail.com> <CAGsJ_4wmvBvEn_vXu8-c6BRAnRewYmTs8iUd8T7KRx7_svZrwg@mail.gmail.com>
In-Reply-To: <CAGsJ_4wmvBvEn_vXu8-c6BRAnRewYmTs8iUd8T7KRx7_svZrwg@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 19 Oct 2026 17:16:27 -0700
X-Gm-Features: AclHuK_duovmGh6MgK6NvBiqxnyMv5OCjdQqCPJY238RVK32rd2T9hHtvaZrtRM
Message-ID: <CAE5sdEiq3bY1kgMUQ6x7RRJCx0JH4sQ9Z_a9_YQSM5FKNwpk8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref in get_lruvec()
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	kasong@tencent.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	yuzhao@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, rlmenge@gmail.com, stable@vger.kernel.org, 
	Hardik Garg <hargar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2026 at 16:36, Barry Song <baohua@kernel.org> wrote:
>
> On Tue, Oct 20, 2026 at 4:33=E2=80=AFAM Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > On Sun, 18 Oct 2026 at 14:24, Barry Song <baohua@kernel.org> wrote:
> > >
> > > On Sat, Oct 17, 2026 at 1:09=E2=80=AFPM Siddharth Chintamaneni
> > > <sidchintamaneni@gmail.com> wrote:
> > > >
> > > > Andrew Morton reported that get_lruvec() has the same problem as
> > > > lru_gen_shrink_node(): when memcg is disabled on the command line
> > > > (cgroup_disable=3Dmemory), it returns &pgdat->__lruvec directly and=
 so
> > > > bypasses the initialization of lruvec->pgdat. The MGLRU debugfs
> > > > interface calls get_lruvec(), then dereferences the pgdat pointer i=
n
> > > > lru_gen_seq_show() and other paths, so these can hit the same NULL
> > > > dereference.
> > >
> > > So userspace must have booted, since otherwise we couldn't read
> > > debugfs. The reachable case is therefore a memory node with no
> > > LRU folios when debugfs is read? So this could happen on a multi-node
> > > system where folios are landed on other nodes but not on this node?
> > >
> >
> > That is my high level understanding. I'll let Andrew to comment if I
> > am missing something,
> >
>
> I made a silly toy setup by running two numa nodes with one of them has o=
nly 4KB
> memory, the other one has 1G-4K:
>
> qemu-system-aarch64 -M virt,gic-version=3D3,mte=3Doff -cpu cortex-a53 -no=
graphic \
> -smp 4 \
> -m 1G \
> -object memory-backend-ram,id=3Dram0,size=3D1048572K \
> -object memory-backend-ram,id=3Dram1,size=3D4K \
> -numa node,nodeid=3D0,memdev=3Dram0,cpus=3D0-1 \
> -numa node,nodeid=3D1,memdev=3Dram1,cpus=3D2-3 \
>   -kernel arch/arm64/boot/Image \
>  -nographic -append "cgroup_disable=3Dmemory
> ...
>
> Then I got a machine where node1 is very difficult to have a page in lru.
>
> then i ran the debugfs for mglru:
>
> / # cat /sys/kernel/debug/lru_gen
> memcg 0
>  node     0
>           0      14972          0         953
>           1      14972          0           1
>           2      14972         18        3308
>           3      14972          0           0
>  node     1
>           0      14972          0           0
>           1      14972          0           0
>           2      14972          0           0
>           3      14972          0           0
>
> now you see node 1 has no page in lru but yet i didn't have any crash.
>
> i think i will need more time to figure out what is the problem and how t=
o
> reproduce it.

I've asked AI to repro the issue with the similar setup

qemu-system-aarch64 -M virt,gic-version=3D3,mte=3Doff -cpu cortex-a53 -nogr=
aphic \
  -smp 4 -m 1G \
  -object memory-backend-ram,id=3Dram0,size=3D1048512K \
  -object memory-backend-ram,id=3Dram1,size=3D64K \
  -numa node,nodeid=3D0,memdev=3Dram0,cpus=3D0-1 \
  -numa node,nodeid=3D1,memdev=3Dram1,cpus=3D2-3 \
  -kernel "$KERNEL" \
  -initrd "$INITRD" \
  -no-reboot \
  -append "console=3DttyAMA0 cgroup_disable=3Dmemory
initcall_blacklist=3Dkswapd_init panic=3D-1"

and it was able to repo it. AI identified that kswapd is initializing
the pgdat during boot, so blacklisting kswap_init was able to repro
the crash when reading /sys/kernel/debug/lru_gen

[    1.347868] Unable to handle kernel access to user memory outside
uaccess routines at virtual address 0000000000005040
[    1.347920] Mem abort info:
[    1.347929]   ESR =3D 0x0000000096000005
[    1.347950]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    1.347964]   SET =3D 0, FnV =3D 0
[    1.347974]   EA =3D 0, S1PTW =3D 0
[    1.347986]   FSC =3D 0x05: level 1 translation fault
[    1.348249] Data abort info:
[    1.348277]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
[    1.348291]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[    1.348302]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0
[    1.348345] user pgtable: 64k pages, 48-bit VAs, pgdp=3D00000000485f6600
[    1.348369] [0000000000005040] pgd=3D0800000043640403,
p4d=3D0800000043640403, pud=3D0800000043640403, pmd=3D0800000043620403,
pte=3D0000000000000000
[    1.349148] Internal error: Oops: 0000000096000005 [#1]  SMP
[    1.350414] Modules linked in:
[    1.350896] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.3.0-rc7+
#9 PREEMPT(full)
[    1.351111] Hardware name: linux,dummy-virt (DT)
[    1.351411] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    1.351581] pc : lru_gen_seq_show+0x5c/0x460
[    1.351800] lr : lru_gen_seq_show+0x4c/0x460
[    1.351898] sp : ffff80008034f9a0
[    1.351975] x29: ffff80008034fa20 x28: ffff0000035e67e8 x27: 00000000004=
00cc0
[    1.352297] x26: 000000007fff0000 x25: ffff0000035e67d8 x24: 00000000000=
00000
[    1.352454] x23: ffff80008034fb00 x22: ffff80008034fb28 x21: 00000000000=
00000
[    1.352626] x20: ffff0000035e67b0 x19: ffff00003ffc2f20 x18: ffff8000803=
60060
[    1.352775] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000=
00000
[    1.352915] x14: 0000000000000000 x13: 0000000000000000 x12: 00000000000=
00000
[    1.353058] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa3468a0=
20c5c
[    1.353226] x8 : ffff000008b07000 x7 : 0000000000000000 x6 : 00000000000=
0003f
[    1.353367] x5 : 00000000ffffffff x4 : 0000000000000003 x3 : 00000000000=
01000
[    1.353511] x2 : ffff00003ffc2f20 x1 : 0000000000004000 x0 : 00000000000=
00000
[    1.353732] Call trace:
[    1.353925]  lru_gen_seq_show+0x5c/0x460 (P)
[    1.354110]  seq_read_iter+0xec/0x4c0
[    1.354213]  seq_read+0xfc/0x148
[    1.354290]  full_proxy_read+0x78/0xc0
[    1.354377]  vfs_read+0xd0/0x338
[    1.354453]  ksys_read+0x7c/0x120
[    1.354528]  __arm64_sys_read+0x24/0x40
[    1.354611]  invoke_syscall+0xa8/0x120
[    1.354695]  el0_svc_common.constprop.0+0x4c/0x100
[    1.354791]  do_el0_svc+0x28/0x40
[    1.354865]  el0_svc+0x48/0x2b0
[    1.354939]  el0t_64_sync_handler+0xa8/0xf0
[    1.355026]  el0t_64_sync+0x1b8/0x1c0
[    1.355250] Code: f9000fe0 f9432661 aa1303e2 91401021 (b9504033)
[    1.355647] ---[ end trace 0000000000000000 ]---
[    1.356555] Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x0000000b
[    1.356888] SMP: stopping secondary CPUs
[    1.357525] Kernel Offset: 0x234609c00000 from 0xffff800080000000
[    1.357675] PHYS_OFFSET: 0x40000000
[    1.357762] CPU features: 0x0,00000000,09000020,00100002,0800821b
[    1.357901] Memory Limit: none
