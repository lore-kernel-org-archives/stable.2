Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C1E47424F
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844871; cv=none; b=uBSydCJnY7qPcJR60F0jGO3kcVh/n8h1SXxpa/3QRSHSX/ew4q8tYjFaUXJOhNkJ4oJ3uP60TV2H4Putt3EEesQslVhfYui7SSrjice57HBxrn1fQ+1px10iwTFqqt6ZURaJGLiosF86L/glcFYe+Qe9IciSNF5qLNJa5f5CRgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844871; c=relaxed/simple;
	bh=jV7YfjtR5vuz3xwUkGuWY9QmXFSXzTf61ddkIHae+co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGO5as1GZFDCrcuopsQ6GZid38fbtFiQVcVl7QXiXKhgrx8gfEy+BZIe55AczVwe7xfKShva7YB0SYtg7IT4Ba9dutZV6kxjw6+P6/IPpdtyQ+lqpoWwHfcbz1Sn8B3ddn6LkZC7MEgjFuTdlWcR15XA67HdtaOljuua4JtlaXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFtsHlHW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFtsHlHW"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso81791b3a.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787844869; x=1788449669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNq6VeIFxDSj0mXnHsP4h/BFQtemuwKfV85FP0OU9iA=;
        b=tFtsHlHWtv5o2DchVb9iknfbIYOhPMwWIJ1e2D1TwRNmPJOjBGoAWYPgGYsAkuiJoV
         VXeaXY5l4qayXTpF00USVnt06DR47dK0F1Q3JrkxJU1ke37PPjgjj3wc2SMTsWmRzgRQ
         0uMGq3LY0s6E4n1HW8jQTVZ3uMh9oQ+wQKUi4HeMhHWsbIeFs8Fdltzo0o+p5Y5zwjW2
         ENrbYgTsTx/mLvORxHnzD+RAxXV7AKgDNfygaac19Oa4dLxsAhx7nrW8IDIaXmPCyWQ1
         y3l+EwKGOedGIgCkoR73ezB82j7BHiIwS3IWw9q3Xyx8zOu+zKUCFzMiGxxYStUzzhHU
         s6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787844869; x=1788449669;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNq6VeIFxDSj0mXnHsP4h/BFQtemuwKfV85FP0OU9iA=;
        b=UCYhgLgwxOD5bnvT2gEDa0T3ROzbHgeOdWokX8pclGwTnaBv67Z2iIblNLBWqt1rCr
         YVJNRQuhfM9uqOmu/GSYNCudOHLMNoQma61SsgCG3J9C0nlo0JVwWT8ztEcz1KjH+SQV
         5V+Tb7FQySFaewuB1f3zf4L8DkBXSl38uyvOX/OQazYqpNLZ5mG0A6KfrGnd/7W6oSGI
         nr8jAwF9kn81amp4snMTlbBKDWlwyWICYCczEgFAG9wiis0I88q6LiNW5vgnRZsvmclx
         +lD/kTvpPxkLi0rCY4HNE2EZdMRrYC40t/Np/+dL9XsNClo5tl8nKSIPXNHDyjEqqp3B
         mRWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5fnQp89JyOpxSddE9vIm8Huz2b/GnVL31XfWBlknJMumkJ++VSaFrRKbc3NJYh+XHhDK7VNM=@vger.kernel.org
X-Gm-Message-State: AFuF++nhb8WYFEmTcNN4ctYuon3hEUD83g3kONhaAMI+Kb9YEwz7qb0t
	ySN78+vzP5WGP9+PPEVhMhHU0OfEQavWOKiXYHN/Mg6Jqur4ys8h/+hh
X-Gm-Gg: AR+sD12MgOpFFtCljFfMz6EXVVGlfVjtaIFi7p9APKdW1GlMapCwZg0dKBojemdZ4RP
	uzFHK3/TdvLADAoqrk4P0wdSczmSGVpcAHFWcRJtDvnGo8PrBnbIiGVlSH03mMG90fz/YFCVxW8
	5XdClTQpm6UcsmcyqQN8o4/+Fi5iba/9cG8lQUimaOlF5qT5LG6EGdVAg9YRnJ+L67Da9AjSHh0
	rIzNCNT5YjAUD6NkTZ4BfvZbzK2oClGsE7P8nA1sGQv1Xaf7Z8MdsWUP1Bk3j5ol32LOXiyVLbC
	y3vgEvlnQvH4Iomu+tDE7QWb2yqqf2t+Grd5rweW0YVsvlp4kT+dz7BlG2dYLzpjJz7bWrFTMxS
	hBO36tYJ02eVdLThSY2VLmZa7CLZhtXByAZWjL7Ddc6iA0fisbpsO9mGeqzRdbfF3SIj5/HPuGt
	sCHEl3aKbxfzDhTBbA/vfBNZa5nzcmBFC8yJDyKzYy2ww6EKMcbvqHlYK5f1Jzk2RxNs+h1WJ99
	w==
X-Received: by 2002:a05:6a00:8d86:b0:848:2eac:bfb2 with SMTP id d2e1a72fcca58-853748a0551mr33529913b3a.13.1787844868375;
        Thu, 27 Aug 2026 08:34:28 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cdc03b0sm2180286b3a.30.2026.08.27.08.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:34:27 -0700 (PDT)
Date: Thu, 27 Aug 2026 21:04:25 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>, tony.luck@intel.com,
	bp@alien8.de, linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3] cxl/mce: Avoid alias page retirement for corrected
 errors
Message-ID: <apBZAZWZLvJXWcUL@acer-nitro-anv15-41>
References: <20260824134957.11085-1-shaikhkamal2012@gmail.com>
 <3dea64d2-7a81-4ab4-8d25-c673c58b3169@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3dea64d2-7a81-4ab4-8d25-c673c58b3169@intel.com>

On Tue, Aug 25, 2026 at 08:39:05AM -0700, Dave Jiang wrote:
> 
> 
> On 8/24/26 6:49 AM, Shaikh Kamaluddin wrote:
> > cxl_handle_mce() offlines the aliased page of an Extended Linear Cache
> > (ELC) region for any MCE with a usable address in the region. This
> > includes corrected errors, needlessly reducing usable memory.
> > 
> > Skip ELC alias retirement when mce_is_correctable() identifies the
> > reported error as corrected. Uncorrected errors with a usable address
> > in the ELC region continue to retire the aliased page as before.
> > 
> > mce_usable_address() already implements the per-vendor checks that
> > determine whether the reported address is usable, so no separate
> > memory-error classification is needed.
> > 
> > On AMD, a corrected legacy bank 4 DRAM ECC error (XEC 8) reports a
> > usable address and retired the aliased page before this change.
> > Tested under QEMU with Intel Skylake-Server and AMD EPYC-Milan models.
> > 
> > Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

 Thank you Dave for reviewing.

 Regards,
 Shaikh Kamaluddin

> > ---
> > Changelog:
> > 
> > v2 -> v3:
> >  - Drop the mce_is_memory_error() gate added in v2. On AMD it rejects
> >    every non-UMC bank type, so poison-consumption records reported from
> >    Load/Store or Data Fabric banks never reached mce_usable_address(),
> >    which would have accepted them via MCA_STATUS[Poison]. (Sashiko)
> >  - mce_usable_address() already implements the complete per-vendor
> >    address-usability logic, so no separate memory-error classification
> >    is needed.
> >  - Add AMD test coverage (QEMU/TCG, EPYC-Milan) alongside the existing
> >    Intel results.
> > 
> > Link to v2: https://lore.kernel.org/linux-cxl/20260812151759.14390-1-shaikhkamal2012@gmail.com/
> > 
> > v1 -> v2:
> >   - Reworked commit message per review feedback
> >   - Dropped redundant comment from the code
> > 
> > Link to v1: https://lore.kernel.org/linux-cxl/20260810183013.47085-1-shaikhkamal2012@gmail.com/ 
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
> >     different mce_usable_address() path, covered in the section below):
> > 
> > vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu Skylake-Server-v4,+mce,+mca -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> > 
> > 2. modprobe mce-inject
> > $ cxl list -M
> > $ cxl list -D
> > $ cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> > $ dmesg | grep "DEBUG: forced cache_size"
> > $ modprobe device_dax
> > $ modprobe kmem
> > $ ls /sys/bus/dax/devices/
> > $ daxctl reconfigure-device dax0.0 --mode=system-ram
> > $ lsmem
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
> >    # modprobe mce-inject
> > 
> >     MCi_STATUS bit layout used here (arch/x86/include/asm/mce.h):
> >       bit 63  VAL     - record valid
> >       bit 61  UC      - uncorrected (0 = corrected error under test)
> >       bit 60  EN      - error reporting enabled
> >       bit 59  MISCV   - MCi_MISC valid
> >       bit 58  ADDRV   - MCi_ADDR valid
> >       bits[15:0] MCACOD - retained from the v2 test setup so the Intel
> >                           and AMD runs differ only in CPU model; not
> >                           consulted by this path.
> > 
> >     python3 -c "
> >     VAL, UC, EN, MISCV, ADDRV = 1<<63, 1<<61, 1<<60, 1<<59, 1<<58
> >     MCACOD_MEM = 1<<7                
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
> > 4.  # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0x9C00000000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190010000 > addr
> > # echo 9 > bank
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190010000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> > Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> > mce: [Hardware Error]: TSC a605ccda40 ADDR 190010000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786375908 SOCKET 0 APIC 0 microcode 1
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     4 kB
> > ---------------------------------------
> > 
> > CE without this patch:
> >   cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> >   Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> >   HardwareCorrupted: 4 kB
> > ------------------------------------- 
> > 
> > CE with this patch:
> >   (no "Offlining aliased SPA" message logged)
> >   HardwareCorrupted: 0 kB
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0x9C00000000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190010000 > addr
> > # echo 9 > bank
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> > mce: [Hardware Error]: TSC 2eeae32fe0 ADDR 190010000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377156 SOCKET 0 APIC 0 microcode 1
> > clocksource: Watchdog remote CPU 11 read timed out
> > 
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > --------------------------------------
> > 
> > For UC, same steps only status bit information will change :
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0xbc00000000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190010000 > addr
> > # echo 9 > bank
> > # dmesg | grep cxl_mce_debug
> > #  grep HardwareCorrupted /proc/meminfo
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190010000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> > Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> > mce: [Hardware Error]: TSC e9dd2869e0 ADDR 190010000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377750 SOCKET 0 APIC 0 microcode 1
> > 
> > Patched, UC: alias still offlined, confirming uncorrected handling is unchanged by this patch.
> >     cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> >     Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> >     HardwareCorrupted: 4 kB
> > -----------------------------------------------------------------------
> > 
> > AMD Platform Testing:
> > ---------------------
> > 
> > Note the vendor difference: on Intel, MISCV with MCi_MISC[8:6]=2 makes
> > any ADDRV record usable, so a plain CE is address-usable. On AMD an
> > address is usable only via poison, legacy bank-4 DRAM ECC, or PADDRV --
> > hence the differing usable= values for the same status word below.
> > 
> > 
> > vendor_id	: AuthenticAMD
> > model name	: AMD EPYC-Milan Processor
> > 
> > -------------------------------------
> > Mainline Kernel Without this patch:
> > -------------------------------------
> > 
> > vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu EPYC-Milan -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> > 
> > # cxl list -M
> > # cxl list -D
> > # cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> > # dmesg | grep "DEBUG: forced cache_size"
> > # modprobe device_dax
> > # modprobe kmem
> > # daxctl reconfigure-device dax0.0 --mode=system-ram
> > 
> > # lsmem
> > RANGE                                  SIZE  STATE REMOVABLE BLOCK
> > 0x0000000000000000-0x000000007fffffff    2G online       yes  0-15
> > 0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
> > 0x0000000190000000-0x00000001afffffff  512M online       yes 50-53
> > 
> > Memory block size:       128M
> > Total online memory:     4.5G
> > Total offline memory:      0B
> > Load Injector
> > # modprobe mce-inject
> > --------------------------------------------------------------------------------
> > 
> > case1:
> > 
> > label              status           addr         bank   note
> > 
> > [LEGACY_B4_CE]  0x9c00000000080000  0x190070000   4     "case 3: bank4 XEC8 corrected+usable "[Before Patch]
> > ---------------------------------------------------------------------------------------------------------------------
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0x9c00000000080000 > status
> > # echo 0x80 > misc
> > # echo 0x190070000 > addr
> > # echo 4 > bank
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00000000080000 addr=0x190070000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190070000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0070000 pfn=0x1a0070 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0070000
> > Memory failure: 0x1a0070: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00000000080000
> > mce: [Hardware Error]: TSC cbdf882d20 ADDR 190070000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787479138 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     4 kB
> > --------------------------------------------------------------------------------------------
> > 
> > case2:
> > label        status              addr         bank   note
> > 
> > [POISON]  0x9c00080000000080    0x190040000    9     "case 2: poison only (UC=0) - divergence to note"[Before Patch]
> > -----------------------------------------------------------------------------------------------------------------------
> > 
> > # echo sw > flags
> > # echo 0x9c00080000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190040000 > addr
> > # echo 9 > bank
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190040000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190040000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0040000 pfn=0x1a0040 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0040000
> > Memory failure: 0x1a0040: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00080000000080
> > mce: [Hardware Error]: TSC 17153949200 ADDR 190040000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787479277 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     8 kB (cumulative added previous 4kb + 4kb this test)
> > -----------------------------------------------
> > 
> > AMD Platform Testing with applied patch:
> > ------------------------------------------
> > 
> > # cxl list -D
> > # cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> > # dmesg | grep "DEBUG: forced cache_size"
> > # modprobe device_dax
> > # modprobe kmem
> > # daxctl reconfigure-device dax0.0 --mode=system-ram
> > # lsmem
> > # modprobe mce-inject
> > ----------------------------------------------------
> > 
> > case1:
> > label              status           addr         bank   note
> > 
> > [ CE]          0x9c00000000000080    0x190010000   9     "case 1: corrected, no usable addr"
> > ----------------------------------------------------------------------------------------
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0x9c00000000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190010000 > addr
> > # echo 9 > bank
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> > mce: [Hardware Error]: TSC 8e59f2f3bc0 ADDR 190010000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454918 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > -------------------------------------------------------------------------
> > 
> > case2:
> > label              status           addr         bank   note
> > [ UC ]        0xbc00000000000080    0x190020000   9      "case 1: uncorrected, no poison -> unusable"
> > -------------------------------------------------------------------------------------------------
> > 
> > cd /sys/kernel/debug/mce-inject
> > echo sw > flags
> > echo 0xbc00000000000080 > status
> > echo 0x80 > misc
> > echo 0x190020000 > addr
> > echo 9 > bank
> > Result:
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190020000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> > mce: [Hardware Error]: TSC 134d6de13240 ADDR 190020000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787460569 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > -------------------------------------------------------------------
> > 
> > case3:
> > label              status           addr         bank   note
> > 
> > [ POISON ]   0x9c00080000000080    0x190040000   9      "case 2: poison only (UC=0) - divergence to note"
> > ------------------------------------------------------------------------------------------------------------
> > 
> > # cd /sys/kernel/debug/mce-inject
> > # echo sw > flags
> > # echo 0x9c00080000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190040000 > addr
> > # echo 9 > bank
> > Result:
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190040000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00080000000080
> > mce: [Hardware Error]: TSC 14e29da617c0 ADDR 190040000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787463321 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > ------------------------------------------
> > 
> > case4:
> > label              status           addr         bank   note
> > 
> > [ DEFERRED ]  0x9c00100000000080    0x190020000   9     "case 1: deferred, no poison -> unusable"
> > ------------------------------------------------------------------------------------------------
> > 
> > # echo sw > flags
> > # echo 0x9c00100000000080 > status
> > # echo 0x80 > misc
> > #echo 0x190020000 > addr
> > #echo 9 > bank
> > Result:
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00100000000080 addr=0x190020000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00100000000080
> > mce: [Hardware Error]: TSC 9a2d801ff40 ADDR 190020000 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787456818 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > -----------------------------------------------
> > 
> > case5:
> > label              status            addr         bank    note
> > 
> > [ DEF_POISON ]  0x9c00180000000080    0x190060000   9      "case 2: deferred+poison - MUST be handled"
> > --------------------------------------------------------------------------------------------------------
> > 
> > # echo sw > flags
> > # echo 0x9c00180000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190060000 > addr
> > # echo 9 > bank
> > Result:
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00180000000080 addr=0x190060000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190060000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0060000 pfn=0x1a0060 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0060000
> > Memory failure: 0x1a0060: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00180000000080
> > mce: [Hardware Error]: TSC a60fd45ae60 ADDR 190060000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787457072 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     4 kB
> > -----------------------------------
> > 
> > case6:
> > label              status           addr         bank   note
> > 
> > [UC_POISON]  0xbc00080000000080    0x190050000   9       "case 2: poison consumption - MUST be handled"
> > --------------------------------------------------------------------------------------------------------
> > 
> > # echo sw > flags
> > # echo 0xbc00080000000080 > status
> > # echo 0x80 > misc
> > # echo 0x190050000 > addr
> > # echo 9 > bank
> > 
> > Resul:
> > 
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0xbc00080000000080 addr=0x190050000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > cxl_mce_debug: spa=0x190050000 contains=1
> > cxl_mce_debug: spa_alias=0x1a0050000 pfn=0x1a0050 pfn_valid=1
> > cxl_region region0: Offlining aliased SPA address0: 0x1a0050000
> > Memory failure: 0x1a0050: recovery action for free buddy page: Recovered
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00080000000080
> > mce: [Hardware Error]: TSC f03abeed540 ADDR 190050000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787457328 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     4 kB
> > -------------------------------------------------------------------------------------
> > 
> > case7:
> > label              status                   addr         bank    note
> > 
> > [B4_NONMEM_POISON]   0x9c00080000000080    0x190080000   4       "case 3 override: bank4 non-mem, poison ignored"
> > -------------------------------------------------------------------------------------------------------------------
> > 
> > # echo sw > flags
> > # echo 0x9c00080000000080  > status
> > # echo 0x80 > misc
> > # echo 0x190080000 > addr
> > # echo 4 > bank
> > 
> > Result:
> > 
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00080000000080 addr=0x190080000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=0
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00080000000080
> > mce: [Hardware Error]: TSC 21c66cecf80 ADDR 190080000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454082 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > --------------------------------------------------------------------------------------------
> > 
> > case8:
> > label              status               addr         bank     note
> > 
> > [LEGACY_B4_CE]   0x9c00000000080000    0x190070000   4        "case 3: bank4 XEC8 corrected+usable - THE FIX"
> > -------------------------------------------------------------------------------------------------------------------
> > 
> > echo sw > flags
> > echo 0x9c00000000080000 > status
> > echo 0x80 > misc
> > echo 0x190070000 > addr
> > echo 4 > bank
> > 
> > result:
> > -------
> > 
> > mce: [Hardware Error]: Machine check events logged
> > cxl_mce_debug: entered status=0x9c00000000080000 addr=0x190070000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c00000000080000
> > mce: [Hardware Error]: TSC 3610305ed80 ADDR 190070000 MISC 80 
> > mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1787454482 SOCKET 0 APIC 0 microcode 1000065
> > # grep HardwareCorrupted /proc/meminfo
> > HardwareCorrupted:     0 kB
> > -------------------------------------------
> > 
> > Note: an AMD record with MCI_STATUS_POISON set but UC and Deferred
> > clear is filtered by this patch where it previously was not. Per AMD64
> > APM 24593 Rev 3.45, when UC is clear the error class is determined
> > solely by the Deferred bit, and Poison qualifies an uncorrected error
> > rather than establishing one. Real poison is therefore always reported
> > with Deferred set (not yet consumed) or UC set (consumed via #MC), and
> > both of those cases still retire the alias. Poison with UC and Deferred
> > both clear is not a valid encoding and appears only under software
> > injection.
> > 
> >  drivers/cxl/core/mce.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> > index 65fed913b221..3ac6802e750d 100644
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
> > +	if (mce_is_correctable(mce))
> > +		return NOTIFY_DONE;
> > +
> > +	if (!mce_usable_address(mce))
> >  		return NOTIFY_DONE;
> >  
> >  	spa = mce->addr & MCI_ADDR_PHYSADDR;
> > 
> > base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> 
