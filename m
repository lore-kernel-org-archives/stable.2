Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36047A87B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550399; cv=none; b=SGphvTAVz3jR5XGSJnNRxmlU4PdPUwhDTeoobhSRSwJNT2iVVz16j8J6gAXfOWRgl1SrllpSkyox2oa2eMA4exOeasuSIJks67fAqdVmyrHTWUIsJQwmk9+hLhmBo7K983SdcwDOMrMZgreOSFDRzvSxzpzTKWJnPFp3VXpQVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550399; c=relaxed/simple;
	bh=mocJtvpewPYHgX4D6FyvNufUE9O92uYJliG5Hx107IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki1En8U0FE1Q3f32qzbdNIBiGaDDDLpwJYDV++f76agJl+nqA958Y6c25VONo8Hj1fFng47B+Z0Dt02FQsNIcJpsOoO4+WhLX7MB4Pdjq7v7uMIi2TMZUWZNmIhy6/ASCYMn5meRKkvnn2q88JEfIVCmNP9jw0gCCLYfHnjNKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhsvFYFW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhsvFYFW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf27856f9cso11129355ad.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786550397; x=1787155197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CEGkpqtkJs2g8Lk9+SDFbXh29uhJCP80JkyDVDC/Bro=;
        b=JhsvFYFWLbBnd208HIwHpr5UrpmFRAxVPw6SFtGaCSot+JKoSuKJ0pmZhTi3j4rwi+
         zLj9wJktlQYWb69enOfqwWYpcznOLYS05Nd+EW7QTGTwsZD5WaNmthtsLXyWIec4u2Zr
         BylRM5PTELm1+8ivVc2WYV05vomE49vYMGnOyJx4QOeLUzu8M3PLbh7x6bkg62Wx/Sc/
         /Riv2Iw56B+FUB2hqb7yjJSlyNDi0QGxrk7v7Yu3AlTGYT94yVZAqfB40PzNOGabHXMF
         AgTcHn5swTGScqjmNoMcPpsuPqE8qmQLe2d/ExIJpfEx0kV/UaNLXofFgjsYgjmwASK7
         mKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550397; x=1787155197;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEGkpqtkJs2g8Lk9+SDFbXh29uhJCP80JkyDVDC/Bro=;
        b=eswMrinijp2rXBoKszLIv2GQXwgfIqj8TDG6t0ckKo8eIbxaxGcDG5aszhfT1bne8L
         8Fc8R2Lj0YDtanBgaCy9+TNOnJkUrC3dHyxI/6adeHbYf5hDbEVgiA+zNiokAcTyfEGD
         0A3rkcKvd5AGZ/0szULlnOvWdU7kr8+AaxZuRqc4Z7vtLe/HSyOEFq/pUmnWQTPct5F0
         9e4dhUB6G0+Srj4icZb+ZsBzchotw09qWnLlrwQSBakxMYI9ChMrTo1Lw3GlENwdBRU6
         oE+Ls/FmrHjewqA3vN96KhLD8fdyr14hinpZSxQRB04C5FGWF+1/QIQ9JpGPAR6gjjZ8
         k7kw==
X-Forwarded-Encrypted: i=1; AHgh+RpeezNN7yPSPRympns0C8moZ2FPCFZuxT3PziqwTrHC7FLVweAjx9AfsRAySqfdXURBUz6jwww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBCvVWVeq+TubxEhPb88i+sS3X5yA1yxgS5QsWB5xd0Lmrp74q
	oKXiKd18ByPpn3I5Gzp+EZuelv6qbPp5UQ8ra6zkXls1p6I5YrsQQDXo
X-Gm-Gg: AR+sD10k+txrh+lvysxEFU9uqz9f7jMCzS8EKJ0BWmBYC1tuzm1Ib9MGYvKFRUnbk2b
	ipW3Q8zlX+/HV/XHznQIjH2gxb38w/Axn51+Y8jPgy/YyD3ZUBrFKzGKuiuOj5f+gYb3Ce/cNlE
	WvnowFdI+dmj/vacpn6Q0qUtpjM2a8drJ0Kjtq3PEKjr/HSI3Cp6jP5A2UvxORtAUlbQ0LYI4rt
	pR5jb82B6+kOeT1G6gcw0DtPlvRPgEAmuzREtKHgtG/OQU6sNKfUakob3kFzooxuG7IZHKWYR9I
	gp7cLI2ROZT31+RNF074TFcQl5tTNShUw58hbi4d//FrgNJOD50EBGdAXiZf+jlAEWX6dFX3/T7
	Q9Ybb6JGR77lIQqb3OynC9iSkw4PlVcgl5hpRSqO5kQJa79xZ5n3pk6o47B8dv0UE4P0lJb+ude
	lEE335iseA19Xx9aiz+ewX78nbAaMA6qx6wQTVcSWsec2WSihqBEuNy54nNKWFKU0=
X-Received: by 2002:a17:903:2306:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d34565d781mr71920365ad.13.1786550396324;
        Wed, 12 Aug 2026 08:59:56 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d35219f226sm8733265ad.50.2026.08.12.08.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:59:55 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:29:54 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, tony.luck@intel.com, bp@alien8.de,
	linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] cxl/mce: Only act on uncorrected memory errors
Message-ID: <anyYev89TB1jHAXe@acer-nitro-anv15-41>
References: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
 <8cef03f0-ab19-42b7-ad04-a1e98e2270ec@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cef03f0-ab19-42b7-ad04-a1e98e2270ec@amd.com>

On Mon, Aug 10, 2026 at 02:00:18PM -0500, Cheatham, Benjamin wrote:
> On 8/10/2026 1:30 PM, Shaikh Kamaluddin wrote:
> > [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > cxl_handle_mce() offlines the aliased page of an ELC region on any
> > record with a usable address; it does not check MCI_STATUS_UC or
> > filter non-memory errors. uc_decode_notifier(), the equivalent
> > handler for plain memory on the same chain at the same priority,
> > filters on mce->severity and leaves corrected errors untouched.
> > cxl_handle_mce() has no such gate, so a corrected error - which
> > the generic handler ignores - still causes the alias to be
> > permanently retired via memory_failure().
> > 
> > Corrected errors do reach the chain: machine_check_poll() logs
> > them via the same mce_gen_pool_process() path that feeds
> > x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
> > extends p->res to cover the DRAM half of the ELC pair, so a
> > routine DRAM CE carries an address inside the region resource.
> > 
> > Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
> > ("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
> > commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
> > machine checks") established this filter for an equivalent handler
> > on the same notifier chain; the consequence here is more severe, as
> > the CXL handler calls memory_failure() rather than recording a bad
> > block.
> > 
> > mce_is_correctable() is used instead of copying
> > uc_decode_notifier()'s AO/DEFERRED test because the alias must
> > still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
> > the reported page but nothing owns the alias.
> > 
> > Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> > 
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > ---
> 
> This looks good to me, so:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
Thanks for review!
> If you have the time, could you also share a script that does the below testing on the list? It may
> be possible to integrate into the CXL testing suite (see https://github.com/pmem/ndctl.git), though
> the QEMU usage may throw a wrench in that. Even if it's not possible, having the tests out there
> for people to run would help with any future breakage.
Happy to share it. One question on where it'd fit best: ndctl
(github.com/pmem/ndctl.git) as you mentioned, or drivers/cxl's own
tools/testing/cxl/ in-tree? I'm open to either, or proposing it in
both if that's useful - happy to follow your lead on which is the
better home for it.

Thanks,
Shaikh 
> 
> Thanks,
> Ben
> > Reproduced under QEMU/vng. QEMU's cxl-type3 does not emulate the HMAT
> > extended-linear address_mode bit, so ELC was forced locally for testing
> > via a one-line debug hack in cxl_region_probe() (not part of this patch):
> > 
> >         if (!p->cache_size && p->res)
> >                 p->cache_size = resource_size(p->res) / 2;
> > 
> > Steps:
> > 1. Boot with an Intel CPU model under TCG (KVM host-passthrough will
> >     otherwise leak the host's real vendor ID, and AMD/SMCA takes a
> >     different mce_usable_address() path than the one under test):
> > vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu Skylake-Server-v4,+mce,+mca -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> > 
> > 2. modprobe mce-inject
> > $cxl list -M
> > $cxl list -D
> > $cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> > $dmesg | grep "DEBUG: forced cache_size"
> > $modprobe device_dax
> > $modprobe kmem
> > $ls /sys/bus/dax/devices/
> > $daxctl reconfigure-device dax0.0 --mode=system-ram
> > $lsmem
> > it will show as below:
> > dax0.0
> > [   42.857642] Fallback order for Node 0: 0
> > [   42.857828] Built 1 zonelists, mobility grouping on.  Total pages: 1010805
> > [   42.858446] Policy zone: Normal
> > [
> >   {
> >     "chardev":"dax0.0",
> >     "size":536870912,
> >     "target_node":0,
> >     "align":2097152,
> >     "mode":"system-ram",
> >     "online_memblocks":4,
> >     "total_memblocks":4,
> >     "movable":true
> >   }
> > ]
> > reconfigured 1 device
> > RANGE                                  SIZE  STATE REMOVABLE BLOCK
> > 0x0000000000000000-0x000000007fffffff    2G online       yes  0-15
> > 0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
> > 0x0000000190000000-0x00000001afffffff  512M online       yes 50-53
> > 
> > Memory block size:       128M
> > Total online memory:     4.5G
> > Total offline memory:      0B
> > 
> > 3. Load the injector if not loaded earlier and derive the two MCi_STATUS values.
> > 
> >     modprobe mce-inject
> > 
> >     MCi_STATUS bit layout used here (arch/x86/include/asm/mce.h):
> >       bit 63  VAL     - record valid
> >       bit 61  UC      - uncorrected (0 = corrected error under test)
> >       bit 60  EN      - error reporting enabled
> >       bit 59  MISCV   - MCi_MISC valid
> >       bit 58  ADDRV   - MCi_ADDR valid
> >       bits[15:0] MCACOD - bit 7 set = memory-error signature, per
> >                           mce_is_memory_error()'s Intel branch
> > 
> >     python3 -c "
> >     VAL, UC, EN, MISCV, ADDRV = 1<<63, 1<<61, 1<<60, 1<<59, 1<<58
> >     MCACOD_MEM = 1<<7                      # memory error signature
> >     ce = VAL | EN | MISCV | ADDRV | MCACOD_MEM
> >     uc = ce | UC
> >     print(f'CE status = {hex(ce)}')
> >     print(f'UC status = {hex(uc)}')"
> >     # CE status = 0x9c00000000000080
> >     # UC status = 0xbc00000000000080
> > 
> >     MCi_MISC: address-mode field, bits[8:6], must be 2 (physical):
> > 
> >     python3 -c "print(hex(2 << 6))"
> >     # misc = 0x80
> > 
> > 4.  $ cd /sys/kernel/debug/mce-inject
> > $echo sw > flags
> > $echo 0x9C00000000000080 > status
> > $echo 0x80 > misc
> > $echo 0x190010000 > addr
> > $echo 9 > bank
> > [  221.813395] mce: [Hardware Error]: Machine check events logged
> > [  221.814716] cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > [  221.816200] cxl_mce_debug: spa=0x190010000 contains=1
> > [  221.817089] cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> > [  221.817655] cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> > [  221.821504] Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> > [  221.823903] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> > [  221.824617] mce: [Hardware Error]: TSC a605ccda40 ADDR 190010000 MISC 80
> > [  221.824997] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786375908 SOCKET 0 APIC 0 microcode 1
> > root@virtme-ng:/sys/kernel/debug/mce-inject#
> > root@virtme-ng:/sys/kernel/debug/mce-inject# grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     4 kB
> > 
> > CE without this patch:
> >   cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> >   Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> >   HardwareCorrupted: 4 kB
> > -------------------------------------
> > CE with this patch:
> >   (no "Offlining aliased SPA" message logged)
> >   HardwareCorrupted: 0 kB
> > 
> > $cd /sys/kernel/debug/mce-inject
> > $echo sw > flags
> > $echo 0x9C00000000000080 > status
> > $echo 0x80 > misc
> > $echo 0x190010000 > addr
> > $echo 9 > bank
> > addr  bank  cpu  flags  ipid  misc  README  status  synd
> > [   61.681659] mce: [Hardware Error]: Machine check events logged
> > [   61.683442] cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > [   61.684528] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> > [   61.684974] mce: [Hardware Error]: TSC 2eeae32fe0 ADDR 190010000 MISC 80
> > [   61.688880] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377156 SOCKET 0 APIC 0 microcode 1
> > [   86.504456] clocksource: Watchdog remote CPU 11 read timed out
> > 
> > $grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > -------------------------
> > For UC, same steps only status bit information will change :
> > $cd /sys/kernel/debug/mce-inject
> > $echo sw > flags
> > $echo 0xbc00000000000080 > status
> > $echo 0x80 > misc
> > $echo 0x190010000 > addr
> > $echo 9 > bank
> > $dmesg | grep cxl_mce_debug
> > $grep HardwareCorrupted /proc/meminfo
> > [  313.398747] mce: [Hardware Error]: Machine check events logged
> > [  313.400518] cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > [  313.401727] cxl_mce_debug: spa=0x190010000 contains=1
> > [  313.402157] cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> > [  313.402663] cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> > [  313.405999] Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> > [  313.408375] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> > [  313.408999] mce: [Hardware Error]: TSC e9dd2869e0 ADDR 190010000 MISC 80
> > [  313.409367] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377750 SOCKET 0 APIC 0 microcode 1
> > 
> > Patched, UC: alias still offlined, confirming uncorrected handling is unchanged by this patch.
> >     cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> >     Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> >     HardwareCorrupted: 4 kB
> > 
> >  drivers/cxl/core/mce.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> > index 65fed913b221..ee70c1c9f9b9 100644
> > --- a/drivers/cxl/core/mce.c
> > +++ b/drivers/cxl/core/mce.c
> > @@ -18,7 +18,14 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
> >         u64 spa, spa_alias;
> >         unsigned long pfn;
> > 
> > -       if (!mce || !mce_usable_address(mce))
> > +       if (!mce)
> > +               return NOTIFY_DONE;
> > +
> > +       /* Only uncorrected memory errors warrant taking down the alias page */
> > +       if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
> > +               return NOTIFY_DONE;
> > +
> > +       if (!mce_usable_address(mce))
> >                 return NOTIFY_DONE;
> > 
> >         spa = mce->addr & MCI_ADDR_PHYSADDR;
> > 
> > base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> > --
> > 2.43.0
> > 
> 
