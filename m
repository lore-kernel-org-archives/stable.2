Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793415173;
	b=pPOJ9/H4pc6w4vAWb5kkbliTqJm4HqLXhfScWVSHVrT5cSJVzQe61hkQYCFZSBvYDsZV
	 A2DMsGwY0QPe1z6wMduyrQCZVQn1fT4yHNEeeKAjN8y4yj+V7hkrqXhmm28b03GrsZBo5
	 3sXKVwimCvATjEl6B9gZzW0t9Cl1ECitu2DZqjQVgzKaso1M6JO6vWBIfhQ4pUSjUR+mF
	 iWKC5BZlT0LBTlA/65xEO/KvaRoPY3p/Tb65I2dZz5hSv14hHusGRrH85huRGqUwSI9SA
	 RexJ6my6qknu8aUPCIyblkqf/wGrH4g8j5tFuvNBs45DborFRdfva2rbdr5heev+mzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793415173;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fJwlSYa8ic1yZvBuc1IZUrcV8mKfxUm7bx6YEt/tS9g=;
	b=4WM8MIm1+QuOP2hkfi+lAQL7T2i70ck4LIT2bgiyTc4T+zsicK9ZGPi5MJXZy297UyGA
	 wGGWD3r2fpPNKZrAYa/qcXb4ZjuUyEReY6mMCmR2BrKugPHkprw4uEppVjp7S+hShPt3U
	 j0pcQxBot6Esl7uGc8647UUUrQX7Sob2bAK4kyxyeG+Jp6queri4aw69XAqmDLFKQDwAh
	 D7Zxd72mN5Bay/tC3yFq4oWOhjyrgyg9B133jGwQUOVQg+5aj99phbMFciejUkVWOwIqI
	 OyIOl4zNWdf4tj4APWvTS9UYloIzTQaILA3e5OHvCv9uWsYPHqxyPyB7Blb/HtvemQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Q0qWvPkE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F61E606A31A;
	Sat, 31 Oct 2026 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Q0qWvPkE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B12A1F00919;
	Sat, 31 Oct 2026 02:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793415172;
	bh=fJwlSYa8ic1yZvBuc1IZUrcV8mKfxUm7bx6YEt/tS9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q0qWvPkEBzqENtyImz31+tkLV6OiVbmUNvDBNPJBOd8FctCHPfJeL2srMd4goty61
	 NCqAvNmcb2vP/RhfOleYK6rO1qzz6K/T7e5UCijY5aP4wmp2ZYT5xq+GPoeJmdtbL6
	 IaPl5PWhSsuCagxwWjGxaHzLPFHCILB3v6Ve481o=
Date: Fri, 30 Oct 2026 19:52:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shyam Saini <shyamsaini@linux.microsoft.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] params: serialize lookup_or_create_module_kobject()
Message-Id: <20261030195252.d393e16f806dfe59f5c8197f@linux-foundation.org>
In-Reply-To: <20260918100712.3124994-1-xujiakai24@mails.ucas.ac.cn>
References: <20260918100712.3124994-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 10:07:12 +0000 Jiakai Xu <xujiakai24@mails.ucas.ac.cn> wrote:

> lookup_or_create_module_kobject() first looks up the module kobject with
> kset_find_obj() and, if not found, creates a new one with
> kobject_init_and_add().  The function is called at runtime from
> module_add_driver() since commit f95bbfe18512 ("drivers: base: handle
> module_kobject creation"), which means two concurrent driver
> registrations for the same built-in module name can both miss the
> lookup and race to create the same kobject.
> 
> The loser of the race gets -EEXIST from kobject_init_and_add() and its
> kobject is removed from module_kset by kobject_add_internal() before
> the failure is reported.  The error path then calls kobject_put(),
> which invokes module_kobj_release(), but that only completes
> ->kobj_completion and never frees the dynamically allocated
> module_kobject, leaking it (96 bytes) along with the object having been
> detached from the kset.
> 
> This is triggerable by unprivileged users, e.g. by concurrently issuing
> the RAW_IOCTL_INIT ioctl of the raw-gadget driver, which registers the
> "raw_gadget" driver on the gadget bus:
> 
>   sysfs: cannot create duplicate filename '/module/raw_gadget'
>   ...
>   Adding module 'raw_gadget' to sysfs failed (-17), the system may be
>   unstable.
>   ...
>   unreferenced object 0xffff8880188dacc0 (size 96):
>     backtrace:
>       lookup_or_create_module_kobject+0x47/0x100
>       module_add_driver+0x73/0x1b0
>       bus_add_driver+0x1d9/0x340
>       driver_register+0xde/0x170
> 
> Fix it by serializing the lookup and the creation with a mutex, so that
> the second caller finds the kobject created by the first one instead of
> racing with it.

Thanks.  AI-based review said a bunch of things (below), but this fix
is considered sound.  I'll make that Fixes: change and add a couple of
Petr's changes while applying.

> Crash report (raw_report0) of the syzkaller crash this patch fixes:
> ---
> BUG: memory leak
> unreferenced object 0xffff8880188dacc0 (size 96):
>   comm "syz.3.569", pid 12998, jiffies 4294992047
>   hex dump (first 32 bytes):
>     12 4e fe 86 ff ff ff ff c8 ac 8d 18 80 88 ff ff  .N..............
>     c8 ac 8d 18 80 88 ff ff 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 8dccd85e):
>     kmemleak_alloc_recursive home/zzzrrll/tmp/kf_src/linux-7.3-rc2/include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:4696 [inline]
>     slab_alloc_node home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:4996 [inline]
>     __kmalloc_cache_noprof+0x1bf/0x420 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:5559

It would be nice to have a Reported-by: and a Closes: for the syscaller
report, but I wasn't able to find the original.


: The mutex fixes the race between two callers of this helper, but the
: changelog needs Petr's corrections: USB_RAW_IOCTL_RUN does the
: registration, and the device node defaults to root-only access.
: 
: Petr is also right about the remaining leak. Other failures from
: kobject_init_and_add() or sysfs_create_file() still reach a release
: callback which never frees the allocated module_kobject. That needs
: a separate fix.
: 
: Please keep f95bbfe18512 as the Fixes commit and drop the redundant
: 7c76c813cfc4 tag. Also remove the v6.15+ restriction: the introducing
: change was backported, including to 6.12.28.
: 
: I don't think the module-removal answer is correct. mod_sysfs_init()
: does not take this mutex, and module_patient_check_exists() checks
: the loadable module list, not the built-in objects.
: 
: There is a conditional lifetime problem here. If a separately loaded
: module already owns the same name before the built-in driver's first
: registration, the lookup can return that module's embedded mkobj.
: module_add_driver() drops the lookup reference before using and
: caching the pointer, so unloading that module can leave a stale
: pointer. This requires privileged loading of a same-named module;
: it isn't an ordinary unprivileged raw-gadget operation.
: 
: That predates this patch, but deserves a separate follow-up. I checked
: the source and a bounded model, not a running-kernel reproducer.
: Successful kobject_get_unless_zero() protects the object while the
: reference is held; there isn't a generic kobject-core gap there.

