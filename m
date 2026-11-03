Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720967;
	b=MOCjRRjn+oJ7E7cOCJhxyVcLvjfCikK1WoEHPFKGL9khFFe9tMwAUARif2cCei9AIMP/
	 bSyuVCqNMI1rTvAzW4a+gQhqG9WUUzTVJYJYTlgmvqVyYM97obcx9k5a6vRXDeM8JWYb5
	 ek8fdrhfpgAjmnnSAosi3LX5+RpmH9XAMowkK1O4i9913HplkxeQofP7pd6VIuDorBllR
	 I7Bm08eJ8LojyR8VXaBkBIIq8BQHKxPgqzAfgX9vTPiSokzJMc2aZqQATszJbH6d1PO4n
	 ICpRfzl8ENtj6US10wfatSUGGWeXaH8KfoNmPLiL4zf0NbTBG2V+j3pogna/cTQ+WNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720967;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yBVvkEycBHDzcqtk64wG1ZxAfNP7O82hXAvWkVI1BMY=;
	b=VLh/tkdjlj3wiK3LUpdVq4nQtkHumo/iCNNGHDGVCHGzQZIWK3rr+EQVPsUokLQ+UsgT
	 NyjKSFFdfxniBnPAzrunkUg+LZPMBuJCgvEM5nUE6lTwykEq7gEto5v4+vz8lyhFYAbDT
	 EvHffGjWmkjmK0U9m+/fqn0cIWMyjUN8fPx0BUqyvjpDNVRt7MMC3viLuGw3wjYHy5XU8
	 B+h86E/PVF32W4rlnr8ogI6vvlNuNtLB+kdHq7nFeE06YP7izXDaI9NgYTf0BWTrw2dU4
	 RnKmz0lsdOsKB7fYuXXuGVQdHtFEexIqWqhpsD3APVApFz+yM3ae7GrYcTDDPtG5cfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Flj/gEvw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815EB606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Flj/gEvw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C901F0093A
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720967;
	bh=yBVvkEycBHDzcqtk64wG1ZxAfNP7O82hXAvWkVI1BMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Flj/gEvwZypjbqAT2i1vuTfp5IOXUKYT8EjKGdi7LN3DHt4HYMnZORez80eHDd1Fm
	 HAyPvUudcDmOAEOo9lywAAV8ddmcz1jT9qfebWnZnDPgwpjEKXkNyZSxqPC9gj40zh
	 ZdDyehkiL6JMFReGiCTUCibEwt/fMH3pCkT2frvcduMWbugKOnbYI13lA3eAjRTTeK
	 mrMPfWC8MmjGJRisRPHKpgo6c82qjTS82+i0cs9eTro7PTaghgQBENLso0VI2RLrl9
	 LcDuANSHauUuJNLFMTtBPMAVC+tS9P7Tugi5gVupqkrWgPaoe/KfTqtSYYLwwU4OtH
	 o9fHOKWUt6XqQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4a76f63b243so686120fac.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 07:49:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBySguTOCy1ecvCwqkwTPZkMigQJZoZHD5WU7a12J6BfgfY7mYBbgOpmBgYpuPQejC/Qi0e3lGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C2+C+jzRF/wTO6LTH5JMel8BVs8RGYYbbmDHSQPVQRL9McWaI
	fj2GHw7KOeBUJeF3gC6rjnYTV0d8/ucm1XODIgTJYo0XB8BZjCpcro2fknKoaihz4Zb9CfM/nyu
	i/jbBafb4j/UyO81K7Rgq1RpeGJ7ootw=
X-Received: by 2002:a05:6871:81e:b0:490:d828:a7e5 with SMTP id
 586e51a60fabf-4a8e0a550bcmr7291633fac.30.1793720966471; Tue, 03 Nov 2026
 07:49:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <4c7f9772.192e1.1a17d5c2ed5.Coremail.xuhx@hust.edu.cn>
 <2026102727-data-sequel-ce41@gregkh> <42fe949f.1d67d.1a1a145bcf0.Coremail.xuhx@hust.edu.cn>
In-Reply-To: <42fe949f.1d67d.1a1a145bcf0.Coremail.xuhx@hust.edu.cn>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 16:49:14 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqeBmBZjmzXAqQB3rzBz_ew72euAs2uuvV2icnQ2RCc+w@mail.gmail.com>
X-Gm-Features: AclHuK9zoFVvLkrFhmzzNCmXBvvs2C3RSpC5VfgBv-CSUvJgAvXjLkZlmpxUO7k
Message-ID: <CAL4WiiqeBmBZjmzXAqQB3rzBz_ew72euAs2uuvV2icnQ2RCc+w@mail.gmail.com>
Subject: Re: net: rtnetlink: rtnl_link_unregister() vs in-flight RTM_GETLINK
 dump readers -- v7.3 lacks the synchronize_rcu() fix (Fixes: 6b57ff21a310
 family); A/B reproduction on stock 7.3
To: =?UTF-8?B?5b6Q5pmX57+U?= <xuhx@hust.edu.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 12:57, =E5=BE=90=E6=99=97=E7=BF=94 <xuhx@hust.ed=
u.cn> a =C3=A9crit :
>
> On v7.3, rtnl_link_unregister() removes the rtnl_link_ops from the
> global list and immediately destroys the embedded srcu_struct and
> frees the ops memory -- a concurrent RTM_GETLINK dump that already
> found the ops (rtnl_link_ops_get(), rtnetlink.c:599 hand-off inside
> an RCU read critical section at :595) but has not yet taken
> ops->srcu will, after the free, execute __srcu_read_lock() /
> __srcu_read_unlock() on freed memory: two reads of the destroyed
> object (ssp->srcu_ctrp, ssp->sda) whose subsequent percpu counter
> writes land wherever the freed percpu pointers point -- for a module
> rtnl_link_ops, the ops (and its srcu) live in module memory, so
> module_memfree() is the freeing side.  Upstream already fixed this
> with a synchronize_rcu() in rtnl_link_unregister() (the patch with
> Fixes: 6b57ff21a310; its own comment: "Wait for rtnl_link_ops_get()
> readers that found ops but have not yet taken ops->srcu").  v7.3
> does not contain it.  I verified both sides on a stock 7.3 KASAN
> kernel: parking a real dump reader (driven by an ordinary
> RTM_GETLINK + IFLA_LINKINFO dump request) exactly at the :599
> hand-off and unregistering+freeing underneath produces three KASAN
> slab-use-after-free reports (__srcu_read_lock+0xe, +0x25,
> __srcu_read_unlock+0x1a; bad address =3D ops+0x10 =3D ops->srcu); and
> rebuilding the SAME kernel with ONLY the upstream one-line fix
> flips the outcome to zero reports, with the kfree demonstrably
> delayed until the parked reader left its RCU section.  Natural
> hammering did not hit (the hand-off window is ~100 ns against a
> ~4 ms unregister -- it needs a preempted/preemptible-RCU reader),
> which matches the fix's own reasoning; the controlled run models
> exactly that preemption.  The purpose of this mail is to support
> the fix's propagation: trees still carrying the unfixed
> rtnl_link_unregister() keep a cross-CPU UAF (write) plus potential
> freed-module execution reachable by unprivileged netlink dumps
> racing a module unload.
>
>
> The detailed description:
>
> * The gap (v7.3, net/core/rtnetlink.c)
>   rtnl_dump_ifinfo() runs lockless for dumps
>   (RTNL_FLAG_DUMP_UNLOCKED), takes rcu_read_lock() at :595, calls
>   linkinfo_to_kind_ops() -> rtnl_link_ops_get() which returns the
>   ops pointer at :599, and only then takes ops->srcu
>   (srcu_read_lock) to call ops->dumpit.  rtnl_link_unregister()
>   holds rtnl_mutex, removes the ops from the list, calls
>   cleanup_srcu_struct(&ops->srcu) and returns to the module, whose
>   exit then frees the module memory.  Nothing between the :599
>   hand-off and the srcu_read_lock is waited for on the unregister
>   side in 7.3 -- hence the fix's synchronize_rcu().
>
> * Evidence (stock 7.3 KASAN, QEMU; A/B on the one-line fix;
>   reproducers attached)
>   rtnlrace.c registers a kzalloc'd rtnl_link_ops (kind "rtnlrace"),
>   parks a dump reader by kprobe at the exact hand-off (return
>   address rtnl_dump_ifinfo+0x374, ENDBR-adjusted), and unregisters
>   + kfrees from another thread (modeling module_exit ->
>   module_memfree).  nlr (userspace) sends the IFLA_LINKINFO dump
>   request that drives the reader path.
>   Defect kernel (stock 7.3):
>     park t=3D127041 (1004 ms) -> unregister+kfree at t=3D127249 (park
>     +208 ms, reader still parked 792 ms) -> park ends t=3D128045:
>     BUG: KASAN: slab-use-after-free in __srcu_read_lock+0xe
>     BUG: KASAN: slab-use-after-free in __srcu_read_lock+0x25
>     BUG: KASAN: slab-use-after-free in __srcu_read_unlock+0x1a
>       read stack: __srcu_read_lock <- rtnl_dump_ifinfo+0x374 <-
>         rtnl_dumpit <- netlink_dump <- rtnetlink_rcv_msg (task nlr)
>       bad address =3D object+0x10 =3D=3D ops->srcu (matches the
>       disassembly lea 0x10(%rbx))
>       alloc: insmod kzalloc;  free: unregister thread kfree
>   Fixed kernel (same sources, ONLY the upstream synchronize_rcu()
>   added to rtnl_link_unregister()):
>     park t=3D191305 -> park ENDS t=3D192306 -> unregister+kfree
>     t=3D192307 -- the order literally inverts -- zero KASAN reports,
>     dump completes with zero errors.  Same module, same parking.
>   Natural runs (three samplings, up to ~267k dumps/reader plus
>   6-CPU preemption spinners): zero hits; the window arithmetic
>   (~100 ns hand-off vs ~4 ms unregister) explains it, and the
>   controlled park models precisely the preemption the upstream
>   fix's comment describes.
>

What is the point of this email ? This looks like LLM slope to me.

I think we have far more serious bugs to fix.

3b70edea393d was tagged stable+noautosel on purpose: the race needs
a module unload (CAP_SYS_MODULE in init_user_ns) to line up with a
~100ns window, which your report also shows you could not hit
without a kprobe. It is not reachable by an unprivileged user alone.
