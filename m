Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1864279F9
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749451; cv=none; b=gIYXzGyP3kuAxVLQnDCxr2MnZYgNmNoOAWa1VActI2u/zWWOHpvVPQbNYi8rqHMjdVMvlusMuVF4xlpqbhxpz3t4Lc6jLT/qlYQXDD4OFhBfxXVYz8WelnQ05w8GXDOt6n/qHfBMvYzwRdqn6wiV8DjCKOPdI78iVGgS5fJBN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749451; c=relaxed/simple;
	bh=6iNb5FJiYjdtrdUakNCxleJ2LEBsBrP/NPhLAnivthM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvD5S0jUu6UnYI3h+rK2lig5gmxN6KODBv5DnrOSppzOU68tOZdCdejArefWLACRki3pRRSEFI9YoxUkDq47426+SCcBqTlN1A2xUwZxYTlOGz5J2vd74qTnON3eMV2Nj1429VV7JkrZUP1O2ghmtAWNQ9sk379dmXRcl/7OPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W684OQto; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W684OQto"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-473ba028d46so1142956f8f.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782749448; x=1783354248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4Lw4PGiYDdh1RfxS/dRr3Tq/IcLb65rqdyEv2Rp27Y=;
        b=W684OQtouemHqgiu0JbGFVvKCaxmqS5xdUUyFHuijzEJ645gzzO2oWkhS9xN7mKFk6
         auTVAPfoXWE1vmMjkdY6yliL771p757HVbmnRwJZfR/j1CK27BX3P0YcjDPYZSgmvZRR
         sEkjseukczd3wguTCRso04zqqto+jqCdk8CSs72FX+e9vR2oFlluzhTZKa4SAcr1zfzX
         WL08LnjiqHK/itMu7q4l6AofXuPjfVAdFytHbg70Fm5437q6Mmlk8ioEdp09zG6mVYkQ
         YP4r4TzuF5pDSw0PO0Bdqjj4ZU5cFE8xt3bWSMm1wkTD3wVNkbpZIFRtozPvqvQG0DRH
         qvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782749448; x=1783354248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4Lw4PGiYDdh1RfxS/dRr3Tq/IcLb65rqdyEv2Rp27Y=;
        b=X/CP5GOkBouaOgdNvDnWqNh+yg7B2PjQBCvHYTjK9ydQ9EAAhOsP8Zl8a/EdWLLkqE
         DqPEjWB3FRZVgTJmweN/4VwwlNH0Vd910KCwlLRqKsjzuUWhk2HCcJ0FrqG2hBPfWtxi
         f4h3gilICOPHhHWb2uSvJO2ndGBZ5QWrctbQIgSKDjgWuC+xfiBTN3MKIsGAPfmLzOsQ
         aGHLqVRuJFCtO+qIO7OJ+SGVVKnZe8v6PWCU4iaGITQGGfh64KsjXj6e8W0jk4ufZI7E
         Pn4EISpkxgER3O8RjWb00ASl54YCqndyK9XiF5pSFh/Qw8KKyPe7N5UBXwqe82OX5LPa
         edSg==
X-Forwarded-Encrypted: i=1; AHgh+RqHvQiy25dJrd5t53LjmTPcOY+3w1s5CEEDK08TTCVCtf832fYkfCKxqLZFpdevuRWhxN5Wy/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBl8fmiLhcR4MrS4EWxz39gULdyfrMLZ2udsLIAYKQBodIYpF
	eqmmY08Z9cZwTWic+Aml5aUJJTmAZhdnsF2syx3JF/VK+UwAXujxn860vrpIsA==
X-Gm-Gg: AfdE7cnxoUV+Cay+bfcEMDX0U5kz9vGcmykgkHxawGAT2gwDgdgPxe5XfTlG9Z47q/u
	BG0FRt5ewR6Jp3kvw7uPmQfZLAP9d1INUyFlM3xYZf4c0ceVBAm6nY7oXG6VARbM3AH0fP8ri/v
	hyATpjbGMe5Y7wd/yWtQbHI8k3zettLbxOuoMcfX8IgnYlfK0QcJ8Apb9hUJqCsu3aLQSXkinp+
	2mZWLroQl8SGQXqWh7A9rN8TZ78wcDZCqIHSVHYOfREJLNUolKxPIP9FLz3wTbFkuhMhWfwxwcD
	jgHlK0xYFlpVpcv37jQdcNq+PsOoGaeyZMUCK0RL4io9MZRYZ9pbH4L0mzGG7h6LlTRfJclTPXq
	VulsmmZ49RhoLhENQ+7ODFXxcExzjCOV9Svp49YWiuLMsqC5fEbQ66VAEqS7db0YHAVb3k29+um
	5ALqOGKNfyTQd6ITSXDh27TcPgd+d9
X-Received: by 2002:a05:6000:2089:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47413acab8dmr5307956f8f.32.1782749448041;
        Mon, 29 Jun 2026 09:10:48 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-472c7bec9c2sm16075253f8f.12.2026.06.29.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:10:47 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:10:46 +0200
From: Dave Penkler <dpenkler@gmail.com>
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpib: fix use-after-free in iboffline() detach path
Message-ID: <akKZBpW135YW2Def@egonzo>
References: <20260622111437.852082-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622111437.852082-1-jhapavitra98@gmail.com>

On Mon, Jun 22, 2026 at 07:14:37AM -0400, Pavitra Jha wrote:
> iboffline() calls board->interface->detach() without holding
> board->big_gpib_mutex. Every userspace-reachable I/O path (read,
> write, command, and all ioctls that call them) acquires this mutex
> before entering the driver callbacks. The mutex therefore creates an
> apparent serialization guarantee that does not extend to the detach
> teardown path.
> 
> The race window is wide and practically exploitable. Board driver
> read callbacks (cb7210, ines_gpib, tnt4882) all delegate to
> nec7210_read() -> pio_read(), which blocks in
> wait_event_interruptible() for up to board->usec_timeout microseconds
> (default 3,000,000 us = 3 seconds) while holding a cached pointer to
> board->private_data on the stack:
> 
>   Thread A (I/O path, holds big_gpib_mutex):
>     cb7210_read()
>       priv = board->private_data        <- cached on stack
>       nec7210_read(board, priv, ...)
>         pio_read()
>           wait_event_interruptible(board->wait, ..., usec_timeout)
>           /* BLOCKS HERE UP TO 3 SECONDS */
>           priv->state ...               <- UAF if detach fires
> 
>   Thread B (detach path, no mutex):
>     gpib_unregister_driver()
>       iboffline()
>         board->interface->detach()
>           kfree(board->private_data)    <- frees what A still holds
> 
> The bug is in the core framework (iboffline() in iblib.c), not in any
> individual board driver. The three affected drivers (cb7210, ines_gpib,
> tnt4882) are all vulnerable by the same mechanism because they share
> the nec7210_read()/pio_read() path.
> 
> The iboffline() comment already flagged this gap:
> 
> 'XXX need to make sure board is generally not in use (grab board lock?)'
> 
> Fix by acquiring board->big_gpib_mutex before calling detach() and
> releasing it afterward, serializing teardown against in-flight I/O.
> mutex_lock() (non-interruptible) is used rather than
> mutex_lock_interruptible() because iboffline() is called from module
> unload context where signal delivery is not meaningful.
> 
> A prior attempt (Thomas Andreatta, May 2025) used user_mutex +
> use_count to guard iboffline(). That approach was NAK'd: user_mutex
> is not held consistently across ibopen()/ibclose(), making it racy
> (Dan Carpenter), and use_count is never zero for an initialized board
> so the check would always return -EBUSY, preventing any offline
> transition (Dave Penkler). This patch instead serializes on
> big_gpib_mutex, which is exactly the lock the ioctl dispatch path
> uses and is therefore the correct exclusion boundary.
> 
> KASAN report (kernel 7.1.0+, QEMU/x86_64, KASLR disabled,
> reproducer: kprobe on read callback + concurrent kfree from detach
> kthread):
> 
>   gpib_common: GPIB core driver
>   gpib_race_harness: loading out-of-tree module taints kernel.
>   gpib_race: attach priv=ffff88800331e7e8 canary=0xdeadbeef
>   gpib_race: kprobe on dummy_read installed
>   gpib_race: detach_fn waiting for read_entered
>   gpib_race: reader_fn calling dummy_read
>   gpib_race: kprobe fired -- dummy_read entered
>   gpib_race: dummy_read priv=ffff88800331e7e8 canary=0xdeadbeef
>   gpib_race: detach_fn firing detach on fake_board
>   gpib_race: detach kfree priv=ffff88800331e7e8
>   gpib_race: detach_fn done -- priv is now freed
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in dummy_read+0xb0/0x120 [gpib_race_harness]
>   Read of size 4 at addr ffff88800331e7e8 by task gpib_reader/25
> 
>   CPU: 0 UID: 0 PID: 25 Comm: gpib_reader Tainted: G           O        7.1.0+ #26 PREEMPTLAZY
>   Tainted: [O]=OOT_MODULE
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x2b/0x40
>    print_report+0x14f/0x4d0
>    ? timer_delete_sync+0x68/0x90
>    ? dummy_disable_eos+0x10/0x10 [gpib_race_harness]
>    kasan_report+0xd4/0x100
>    ? dummy_read+0xb0/0x120 [gpib_race_harness]
>    ? dummy_read+0xb0/0x120 [gpib_race_harness]
>    dummy_read+0xb0/0x120 [gpib_race_harness]
>    reader_fn+0xbf/0xf0 [gpib_race_harness]
>    ? dummy_disable_eos+0x10/0x10 [gpib_race_harness]
>    ? __kthread_parkme+0x56/0x1a0
>    kthread+0x32a/0x470
>    ? kthread_affine_node+0x280/0x280
>    ret_from_fork+0x32d/0x5a0
>    ? exit_thread+0x70/0x70
>    ? __switch_to+0x83f/0xc30
>    ? kthread_affine_node+0x280/0x280
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
> 
>   Allocated by task 23:
>    kasan_save_stack+0x2c/0x50
>    kasan_save_track+0x10/0x30
>    __kasan_kmalloc+0x77/0x90
>    dummy_attach+0x39/0x90 [gpib_race_harness]
>    0xffffffffa000d073
>    do_one_initcall+0xb0/0x230
>    do_init_module+0x263/0x810
>    load_module+0x3e12/0x51e0
>    init_module_from_file+0x136/0x150
>    __x64_sys_finit_module+0x39f/0x7a0
>    do_syscall_64+0x56/0x3f0
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
>   Freed by task 24:
>    kasan_save_stack+0x2c/0x50
>    kasan_save_track+0x10/0x30
>    kasan_save_free_info+0x37/0x50
>    __kasan_slab_free+0x3f/0x60
>    kfree+0xf1/0x390
>    detach_fn+0x105/0x130 [gpib_race_harness]
>    kthread+0x32a/0x470
>    ret_from_fork+0x32d/0x5a0
>    ret_from_fork_asm+0x11/0x20
> 
>   The buggy address belongs to the object at ffff88800331e7e8
>    which belongs to the cache kmalloc-8 of size 8
>   The buggy address is located 0 bytes inside of
>    freed 8-byte region [ffff88800331e7e8, ffff88800331e7f0)
> 
>   Memory state around the buggy address:
>    ffff88800331e680: fc fc fc fc fc fc fc fc fc 00 fc fc fc fc fc fc
>    ffff88800331e700: fc fc fc fc fc fc fc fc fc fc fc 00 fc fc fc fc
>   >ffff88800331e780: fc fc fc fc fc fc fc fc fc fc fc fc fc fa fc fc
>                                                             ^
>    ffff88800331e800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffff88800331e880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ==================================================================
>   gpib_race: UAF dereference priv=ffff88800331e7e8 canary=0xdeadbeef
>   gpib_race: reader_fn returned
> 
> Note: CVE-2026-31769 (Adam Crosser) fixed a separate UAF between
> IBRD/IBWRT/IBCMD/IBWAIT ioctl handlers and concurrent IBCLOSEDEV
> via descriptor refcounting. This patch addresses an independent race
> between the I/O callback path and iboffline()/detach() teardown,
> which is not covered by that fix.
> 
> Fixes: e6ab504633e4 ("staging: gpib: Destage gpib")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
>  drivers/gpib/common/iblib.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpib/common/iblib.c b/drivers/gpib/common/iblib.c
> index b672dd6aa..07a30d520 100644
> --- a/drivers/gpib/common/iblib.c
> +++ b/drivers/gpib/common/iblib.c
> @@ -256,9 +256,23 @@ int iboffline(struct gpib_board *board)
>  		board->autospoll_task = NULL;
>  	}
>  
> +	/*
> +	 * Acquire big_gpib_mutex before calling detach() to prevent a
> +	 * use-after-free race. I/O callbacks (read/write/command) hold
> +	 * big_gpib_mutex while caching board->private_data on their stack.
> +	 * Without this lock, iboffline() can kfree(board->private_data)
> +	 * inside detach() while an I/O callback is still running and holds
> +	 * a stale pointer to the freed memory.
> +	 *
> +	 * Affected board drivers: cb7210, ines_gpib, tnt4882 (all delegate
> +	 * to nec7210_read/pio_read which blocks in wait_event_interruptible
> +	 * for up to board->usec_timeout microseconds while holding priv).
> +	 */
> +	mutex_lock(&board->big_gpib_mutex);

Unfortunately this will not work. The read/write and command ioctls
release this lock before calling the drivers because these ioctls can
take a long time. Also the IBONL ioctl for moving the board offline
would hang on the lock as it has already been taken before the call to
online_ioctl(). The board lock is a separate lock that is controllable
from user space with the IBMUTEX ioctl.

>  	board->interface->detach(board);
>  	gpib_deallocate_board(board);
>  	board->online = 0;
> +	mutex_unlock(&board->big_gpib_mutex);
>  	dev_dbg(board->gpib_dev, "board offline\n");
>  
>  	return 0;
> -- 
> 2.53.0
> 
