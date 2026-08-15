Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C33932E3
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786788913; cv=none; b=KPduP4SpRejLvKd5GEPhHlapePYK8TlLZ+OkHiqirm8klhF2ScV0HVt4e2lOwpaVh2vlL2w5Ke1lO3YO6CPFZ8nIqedZzBRCGQ6qgTNE1dKUgHePXCFGKKynuRh6OS1LZ9Yz9DbkzEJ+l6k0N3yxWybyXPGQWBK7lVJZJbvW7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786788913; c=relaxed/simple;
	bh=tPswWSrAOkxkyqOuZVSBKbZkkHr1llipJ9UJBudMQYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvY3VQoudNO4GNw7jD23Pev4x5slnNhD/ujv7mUhjDQ2bU+Mlvcp0ZDHZVnHX76dKXoqrnqefA0xWIigj7Ggih6E0PBl/5ORXk3XymQHk+XU5DvYydwXK75IctlFGacTHYH889rU2zEE6idVa4UUOu0irOf+VVuM8H4u/Cg5PeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM71W//Z; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM71W//Z"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3811f512167so2665155a91.3
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786788910; x=1787393710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X12N/744woeepub7iVFqwglkYXXLpbYa3Z08mQfxA8k=;
        b=QM71W//ZyDMtNuNtGj5XvCQMuCGbNu0dCTj8nL4UQeo1ofN2+LlgK70LVzGKrAMCfH
         YG3cAA2cyVKPsrPwD7sPmWHbp4aR5JSpiQevPF+JKbZj2w46czcdj6RrGkSnkRqSoxD+
         pRTppEW98/ef8DPJJTsVAUMymzKrhKOylek/zMrySExSEPcsOkpIKleQEddvMDgTFPhX
         E5n2V9MOI0s0Rv1v6d78shGnaBphsFJya8aKEGdwqF022cji6HEw2awQtusjphu/sa19
         M/Lw1aGEIMl9Dep0JQV7l5Hn5FDzXYQ5PJYi8Q9Te59N2uFOhoJPCvchYVTB72Q22iBE
         ogmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786788910; x=1787393710;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X12N/744woeepub7iVFqwglkYXXLpbYa3Z08mQfxA8k=;
        b=N6otcC5zPezgdsmvM1HHam/D8H4yzmJX7IOxbKYqbj9FQuEcZ/K75hqVG8I2ceiPth
         mPik22uJN7hEacKLhiIqVz40FK6lGOmKG0XWmcGlr0+qiMCAjov80E4E5Kjei4YQYfT/
         6TapsEbsbiCN6GnjGSJ2euJfKQqiBnt8cTJk2JRC4DRG9+1GsbqnO5XiUuLQe/BqrFHP
         OtxoWjqz+yGPNc91Lew3/Ip/7XOpy5ZO7wMTY3SQZRiWci28+9fI+IOwuEklr2lKcHhq
         jH0OBTzBFqnuB0KtSa5l6WKyQGsnVGpX15p7YWhJwSQWc6i7DMLxvTxRz/V9yR1+hJKX
         VNqg==
X-Forwarded-Encrypted: i=1; AHgh+RpWU4sO3rSrOcsxLLH3SEHS4rRMt2AuvfLR1zR2V6FfxLepN44UopIO6iBWvVOp4uEWEa6sKOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxyE93YDtGDdnRHGMqpNW9Zl9huJTazJNJVqIst3r9KIuMIyl
	OmZCjUr/XzkgR7C0L+fHrEG7voLeLbK4Dxhe1fbY67cFxXfBj7hjy7fH
X-Gm-Gg: AR+sD12eZtqI0O3kPZ4Z16+RkIOc/fws8d+NJkPCkg8huKMNce5eS9PUJMaiAT4fSss
	aFMGFhlePpnfAa3RaaDUEUXic3QxKYpVsphtGun2cZwfTKTKxiqIEoqgeWwONMoXdghFKRE6M9e
	om6EjguCvWsnWXFnwph5sYUIKos4RplfQiqfNnLSQyXbvubn3PePGOV7RdgrrI7w/x+k/k1uR+Y
	FH4XjbUjpN031rXilrTN1Yr6nTrNJ0qpfMnD6x3GMzapc0gQzK+4U1/14vne1HrbFvmk4khYR0F
	LkUMX0nUjnliAWJksTwRZhoajqQ/3d8VD19iYASSkN1VuGYomUx9xYH3PnXkLGuR+BHGNQTj8Qo
	cYP6345ULwCqdnPczSAtgY555Cjaxx7EqQ6FxpeMC/xCxjuk9TdZNXhgTIBCAf5PsJt9Xo2w5B8
	go+sWHPmBOogvZCy5phGTKN13vu4dXx3srEUVYOMUd/3rp6GvS1FuJAM6EU8MwTFo=
X-Received: by 2002:a17:90b:3d43:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-3933b811e2dmr13701386a91.7.1786788909916;
        Sat, 15 Aug 2026 03:15:09 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394f818030asm1684606a91.3.2026.08.15.03.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 03:15:09 -0700 (PDT)
Date: Sat, 15 Aug 2026 15:45:07 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>, tony.luck@intel.com,
	bp@alien8.de, linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2] cxl/mce: Avoid alias page retirement for corrected
 errors
Message-ID: <aoA8K-i5QpBaE0xn@acer-nitro-anv15-41>
References: <20260812151759.14390-1-shaikhkamal2012@gmail.com>
 <anz7iV2WrZfAnVib@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anz7iV2WrZfAnVib@aschofie-mobl2.lan>

On Wed, Aug 12, 2026 at 04:02:33PM -0700, Alison Schofield wrote:
> On Wed, Aug 12, 2026 at 08:47:59PM +0530, Shaikh Kamaluddin wrote:
> > cxl_handle_mce() offlines the aliased page of an Extended Linear Cache
> > (ELC) region for any MCE with a usable address in the region. This
> > includes corrected errors and non-memory errors, needlessly reducing
> > usable memory.
> > 
> > Restrict ELC MCE handling to uncorrected memory errors. Use
> > mce_is_correctable() so that MCE_AR_SEVERITY errors continue to retire
> > the alias when the reported page is handled elsewhere.
> 
> Hi Shaikh,
> 
> Thanks for revising this.
> 
> Sashiko had a complaint that needs to be considered about the AMD
> specific MCE classification and makes me wonder about using
> mce_is_memory_error() in the test at all.
> 
> Could the fix simply reject mce_is_correctable() and retain
> the existing mce_usable_address() behavior?  (And yeah, I'm thinking
> I may have missed something in that complex description I asked
> you to trim.)
> 
> Sashiko only replied to the linux-cxl mailing list so not all recipients
> of your patch will see it:
> https://sashiko.dev/#/patchset/20260812151759.14390-1-shaikhkamal2012%40gmail.com
> 
> BTW - it looks like Sashiko never looked at v1.
> 
> -- Alison
> 
>
Hi Alison,

Yes, exactly - dropping mce_is_memory_error() and keeping
mce_usable_address() + mce_is_correctable() is the fix. I dug into
this in detail with Sashiko (full trail is in that thread) and
confirmed it against amd_mce_usable_address()'s own comment block in
arch/x86/kernel/cpu/mce/amd.c: poison is defined for every bank
except legacy northbridge, so it explicitly covers the non-UMC banks
(Load/Store, Data Fabric) that CXL poison-consumption reports from -
but mce_is_memory_error() only accepts UMC banks, so it rejects those
records before mce_usable_address() (which would correctly recognize
them) is ever reached.


Setting up an AMD SMCA reproduction now before posting v3.

Thanks, 
Shaikh 
> > 
> > Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > ---
> > Changelog:
> > 
> > v1 -> v2:
> >   - Reworked commit message per review feedback
> >   - Dropped redundant comment from the code
> >  
> > Reproduced under QEMU/vng. QEMU's cxl-type3 does not emulate the HMAT
> > extended-linear address_mode bit, so ELC was forced locally for testing
> > via a one-line debug hack in cxl_region_probe() (not part of this patch):
> > 
> > 	if (!p->cache_size && p->res)
> > 		p->cache_size = resource_size(p->res) / 2;
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
> > addr  bank  cpu  flags	ipid  misc  README  status  synd
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
> >  drivers/cxl/core/mce.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> > index 65fed913b221..e3c561489a00 100644
> > --- a/drivers/cxl/core/mce.c
> > +++ b/drivers/cxl/core/mce.c
> > @@ -18,7 +18,13 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
> >  	u64 spa, spa_alias;
> >  	unsigned long pfn;
> >  
> > -	if (!mce || !mce_usable_address(mce))
> > +	if (!mce)
> > +		return NOTIFY_DONE;
> > +
> > +	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
> > +		return NOTIFY_DONE;
> > +
> > +	if (!mce_usable_address(mce))
> >  		return NOTIFY_DONE;
> >  
> >  	spa = mce->addr & MCI_ADDR_PHYSADDR;
> > 
> > base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> > -- 
> > 2.43.0
> > 
