Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766000;
	b=s84VTBgyjrcSTaR3tLDSH/QIoyFHa0X3gvzgGXuX9VdkT7IMno3nt6Tj4bMrlHg03qCS
	 ndyk8AgTkU0wwk4z4Nw54C+8Z0eHZ3EHUFcbYZxBRKItl8tOhsm+GEj9qx22/JCq22TPX
	 EhXEld/o1maFgCjk3crsw8XvuLPf4jehLJ2PCb1UF0bQieYzppP1qBCAB4MG+TIqQF0MK
	 Jldx/zCbell2uhpSCPP3Bf3hCUuHVrDY+kIdqMMk/PFL6cOIZXl15pbq+NLqFr/hXq1uh
	 vi+Zl5KJRbDEp7QSbswaD6STQlsq2HqIfqSM26iVQYWpKOMfsVqviXOd2nhnMq3rLbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766000;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=i1w9ba/K3YKpUFzRjrbjigLpN1x0pxKxnHmh33Tr1R0=;
	b=AqDEh6zWlgVk20qn5LGARNZn3LZLUzFmsVFJg5pTjD+DkPIx4r199jRM3NfXDsci8Fb1
	 NngZ68L07DyJ3MwqDTDQaOgcO6lh1yzMCKx7nDhoB1Bowt+6HznzuUreBr8ytEq5r045s
	 qu0Bd/jlYeUTtrwkc8OZqWorsCdq0AzHFtAonMKKJP2LojhnukbrWBkb7v6j3uUgfYcfx
	 5qgIpmMNwXxU3+mzN1m105JI6/T8D1wh6pZxM9OnsrxgZoeodKdT15i08uxpKIJca9eOf
	 2P46CXC3GYnwmmgMbGPaNuhqCHJwWm9+59rxDb9Eu7+eBlynT04FdGk+uO65C1gxByA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfDANCQp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7DE606A31E;
	Fri, 27 Nov 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfDANCQp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B08F1F00893;
	Fri, 27 Nov 2026 07:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795765999;
	bh=i1w9ba/K3YKpUFzRjrbjigLpN1x0pxKxnHmh33Tr1R0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=IfDANCQpDYZSOBt2sgq3p3WfsshQaxDiolGJUFZ7ZA1GnafdqsaTETc+0Xn64ops8
	 nqn4eqjUeA9K0Ipxy5L6hkC4SvXxL6TiYeO8EH2ion4+a692iXbe8vQM6mZIFu8dpi
	 ma9ztm1EjFWKCp6qF7CqocjzelhPbe8JViYDQLERb4LtETY6jFp4GGe8jOYZk+Lkkd
	 eggznptjOiBOjEVmv/q56IYizqW9LQdzlcd7dxbsDf3o/HZRfKYB/VPAx0DcyeTzgz
	 mrLYob6mcJIQTjYe26Og4FqBY2jHZMAcPQFJwmaXVnmt/oFTVWzdVAAHw+zEzE2gI2
	 Kv8yZAxD4AvSg==
Date: Fri, 27 Nov 2026 08:53:17 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, alhouseenyousef@gmail.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: hidraw: fix use-after-free and double free on
 disconnect
In-Reply-To: <20261010230108.107272-1-jinmo44.yang@gmail.com>
Message-ID: <n8066nr2-89s4-r290-539o-5p646n4567n5@xreary.bet>
References: <20261010230108.107272-1-jinmo44.yang@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 11 Oct 2026, Jinmo Yang wrote:

> BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0xf8/0x1c8
> Write of size 4 at addr ffff0000ce4ffb38 by task wacom_uaf/261
> 
> Call trace:
>  _raw_spin_lock_irqsave+0xf8/0x1c8
>  hidraw_report_event+0x64/0x2a8
>  hid_report_raw_event+0x488/0x1228
>  __hid_input_report+0x418/0x5b8
>  hid_safe_input_report+0x68/0x90
>  uhid_char_write+0xb04/0xfb8
>  vfs_write+0x2e4/0xac0
> 
> Allocated by task 131:
>  hidraw_connect+0x54/0x390
>  hid_connect+0xb80/0x13d8
>  hid_hw_start+0xc4/0x150
>  wacom_parse_and_register+0x2ae4/0x4d40
>  wacom_probe+0x724/0xb18
> 
> Freed by task 68:
>  kfree+0x264/0x4c8
>  drop_ref+0x268/0x340
>  hidraw_disconnect+0x60/0x88
>  hid_disconnect+0x17c/0x1c8
>  hid_hw_stop+0x70/0x100
>  wacom_mode_change_work+0x11c/0x6b0
> 
> The buggy address belongs to the object at ffff0000ce4ffb00
>  which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 56 bytes inside of
>  freed 96-byte region [ffff0000ce4ffb00, ffff0000ce4ffb60)
> 
> Reproduced on mainline 7.2.0-g66498c75b4f8 (arm64, KASAN) through
> /dev/uhid writes alone.  Offset 56 is struct hidraw::list_lock.
> 
> hidraw_report_event() dereferences hid->hidraw with nothing keeping the
> object alive, and hidraw_disconnect() frees it without clearing the
> pointer:
> 
> 	void hidraw_disconnect(struct hid_device *hid)
> 	{
> 		struct hidraw *hidraw = hid->hidraw;
> 
> 		down_write(&minors_rwsem);
> 		drop_ref(hidraw, 1);		/* kfree() when !open */
> 		up_write(&minors_rwsem);
> 	}			/* hid->hidraw left dangling */
> 
> hid_disconnect() also clears the HID_CLAIMED_HIDRAW bit that guards the
> call only after the free, so a report that passed the guard walks into
> freed memory and the first thing it does there is take a spinlock.
> 
> driver_input_lock normally keeps the two apart -- hid_device_remove()
> holds it across the callback and __hid_input_report() takes it -- but
> hid_hw_stop() carries no such requirement and drivers call it from
> workqueue context holding nothing, as wacom_mode_change_work() does.
> minors_rwsem cannot be used on the reader side: hidraw_report_event()
> also runs from softirq on real transports.
> 
> The same function also takes the pointer outside the lock that frees
> it.  hid_disconnect() tests hdev->claimed & HID_CLAIMED_HIDRAW with
> nothing excluding a second caller and clears claimed only at the end,
> so two overlapping teardowns can both reach drop_ref() with the same
> pointer.  I have one captured double free of this object with that
> shape:
> 
>   BUG kmalloc-96: Object already free
>    drop_ref+0x70/0x108
>    hidraw_disconnect+0x3c/0x60
>    hid_disconnect+0x88/0xb0
>    hid_hw_stop+0x30/0x70
>    wacom_remove+0x30/0x100
> 
> I could not isolate that branch to reproduce it on demand -- three
> other faults on the same wacom teardown path fire first -- so I am not
> claiming this trace proves that window.  Taking the pointer under
> minors_rwsem is correct regardless of how often it is hit.
> 
> Publish the object through RCU and claim it under the lock.
> hidraw_connect() stores the pointer with a release, so the
> initialisation is visible to a reader that picks it up without holding
> anything; readers take the RCU read side and load the pointer once;
> hidraw_disconnect() now reads it under minors_rwsem, returns if another
> teardown already took it, and detaches it before dropping the last
> reference; drop_ref() hands the object to kfree_rcu(), so a reader that
> already loaded the pointer is covered by the grace period.
> 
> Same victim object and same faulting function as the bot-reported window
> addressed by
> 
>   https://lore.kernel.org/linux-input/20260628005846.31248-1-alhouseenyousef@gmail.com/
>   ("HID: synchronize input before cleaning up a failed probe")
> 
> but a different window: that patch re-acquires driver_input_lock in
> __hid_device_probe()'s failure path and leaves hid_disconnect() alone.
> 
> Fixes: 86166b7bcda0 ("HID: add hidraw interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
> Validated at runtime with a test-only patch that widens the window
> between the pointer load and the spin_lock (mdelay(200) in
> hidraw_report_event), so the report race becomes deterministic instead
> of a few instructions wide.  arm64 QEMU/KVM guests, same reproducer,
> 4 vCPU each:
> 
>   kernel                            exposure        KASAN   signature
>   ----------------------------------------------------------------------
>   baseline + widening               4700 binds/180s   1     yes, t+9.07s
>   WRITE_ONCE + NULL guard only      4656 binds/180s   1     yes
>   RCU + widening                    5718 binds/600s   0     no
>   RCU, no widening                  7070 binds/180s   0     no
> 
> The second row is worth stating: clearing the pointer and adding a NULL
> check, without RCU, does not close this.  A reader that has already
> loaded the pointer still walks the object after kfree().  That is why
> this patch uses a grace period rather than just a NULL guard.
> 
> Those rounds cover the report race only.  I also tried to reproduce the
> disconnect-vs-disconnect window on its own, on the KASAN=n,
> CONFIG_SLUB_DEBUG=y tree the captured double free came from, with a
> reproducer that attaches wacom pen and touch as siblings and races
> their teardown: 24 boots, drop_ref() never reached.  In the four of
> those boots that also tracked the in-flight hid_device pointers, no two
> teardowns of the same device were ever inside hidraw_disconnect()
> together -- teardowns of the two sibling devices did overlap there, so
> the instrumentation was live.  The teardown race itself reproduces
> every boot, but three other faults on that path -- a wacom timer on a
> freed object, a NULL deref in hid_hw_stop() and a usercopy fault in
> uhid_char_read() -- end the guest before the hidraw branch is reached,
> and serialising the two hid_hw_stop() calls closes the path altogether.
> So that hunk rests on the captured trace plus the lock discipline, not
> on a round of its own, and I would rather say so than overstate it.
> 
> On the accessors: hid_device::hidraw is a void * with no __rcu
> annotation, and four drivers outside hidraw.c dereference it directly
> (hid-cp2112.c, hid-u2fzero.c, hid-led.c and hid-core.c), all from
> probe/connect paths where the pointer is stable.  Annotating the field
> would let this use rcu_dereference()/rcu_assign_pointer() but would
> cascade into those four, so the plain accessors are used with the same
> ordering rcu_assign_pointer() would give: smp_store_release() is what it
> expands to for a non-NULL store, and WRITE_ONCE() is what it expands to
> for a constant NULL.  I am happy to do the __rcu conversion as a
> separate patch if you would rather have the annotated form.
> 
> Not attempted here: clearing hdev->claimed before the *_disconnect()
> calls in hid_disconnect().  hid_report_raw_event() has
> 
> 	if (hid->claimed != HID_CLAIMED_HIDRAW && report->maxfield)
> 		hid_process_report(hid, report, cdata, interrupt);
> 
> so zeroing claimed makes that condition true and opens hid_process_report()
> during teardown instead.

Sorry for the delay, this took me quite some time to untangle and properly 
understanding, but I am now convinced that your fix is indeed correct.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

