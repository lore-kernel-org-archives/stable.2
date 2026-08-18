Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018147ECC6
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071145; cv=none; b=XvUZ84LgcKhc/EAK3BgXqrYb49Vs9YJkF2ur7L/vWo/MQMtSNdntP6wsV7/d4RC4dqZ/z53B8wF6QS0nXwVoBBdMrMddyntIs+S5YL19JrnFlNjTG2g3N7+kLzF89xU3jBDoT2XOg15YgqA5R+rV2gEUKQFJ8kuxwkQHmvqHYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071145; c=relaxed/simple;
	bh=TsR46cSHQgz2Zgsma7mN06Ro1YbFr636P8/r8jpq84s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnxoguIXNAiv5rOJal94llHW+gR5+pbJ1ALEP06rAMCSF6k2wMCwZ8RRNqiOjI8hcFIw79ZqsczzjNjHCd/Vwv04YprXIBsGjZYidcaZx4a4S62k3RwUF9RPKpmPrfy9aZSsOZxw0+f/3wCTQF59TpwV0A8LiQ/uNIHolkz9AXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsVoklqF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsVoklqF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d049069377so512255ad.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787071143; x=1787675943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Xc9Fg91W0BzvZreR9FqH5KVpjDfvs/DVtIyV1caxdw=;
        b=SsVoklqFdx3+mToRXTVhTKlyHIZJ1UqA31DH1ZP1zq0qwHyM68rNJT0Sxibq7evIsJ
         zmD1W1OnNntR/6g3ZU62SLx5j1q/VQcrMYECk+dqodpQLDmoskM+5SvkFUzXulFC6AEs
         d66dFuLdC8FL3nAAxAv+qqfrs7zY7L65Am0lcylu0REQrMv/3F2RRW/Vmf8TSfECuZA0
         IHE9wkxiRVEvZYjOAlKyCS0OegCev9JIVMTE1ux8e7uiOz8J/OHVtPbl91rysuBx63HP
         vUTt3Zv8gJtfUXPeZccqe07Y/KmMJ0cxcTYXoGDp0Z1UBB6HWP1qTg42SDC1ZzRsRreg
         7/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787071143; x=1787675943;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Xc9Fg91W0BzvZreR9FqH5KVpjDfvs/DVtIyV1caxdw=;
        b=QTdz412OvJiOenfQIhD2gnifg1aV6w4WqvUnNW9tVNdLiDY2BqH5CRIjKzXPBlRGZk
         A+Aq0HrWnFdkjdND8UF6EZTd4EptvFZmg06NLI1W36fr+3iKIlmSrVI8HzBIOVB+ydEu
         HmQcQqKvrYT3NdYaGG8ooZ396E7lUQVJlrZl8NCHA6w0sKFPWsIg7maxBl1tU2lSr7Ri
         XqUlFaiZkeToOZpG3tIPpxZo6EQG811OEWDRsV9ijsx6y/f1Pg8kM0j0HJZgDFEIok80
         W2PZ7+eUWgoESVU+/Sz/Yd4UwLjOmtQL18aa7PPsgQkFyKMz00c2om0j0bhi7ISy9riN
         Kkhw==
X-Forwarded-Encrypted: i=1; AHgh+RobLBjHKBSHz7JGLf4hffzKTHGifS7KNoD7aY0CMF0xbTfvBI6ruQA1G9uGkngyxLYA4erP52U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZibVs/crCBUZqL4AWj8b5NENNSqvtEH78PDzvB9VcST9Pp7Sc
	i7B8MhZ2oFSRyxTA8ara2EengY/pMADK8YYAVje0l0i+caw21WMipocJ
X-Gm-Gg: AR+sD108Hvo/vFQTdZgjroOaBRHoDCs61/jWU9zBZ4zx/lIEW0OpbUsjiVhDiEm1mY/
	NXrOXkYwXw8mQfWui8MX/AlAXXj+cddaTKgfKyoiO9pKOHCEj0oFuRiZXtULnXCFMz7ObVNblhJ
	7GspWq+DCPVHs3lDtZ2S6hkrLM+95fldGUnZpksBszYLu9WJ9PIMPv+ZZhcPh4/Hnk65Gky6fp4
	Mal55/EM6nfTttlZcoKiay+EsbIAn5nu5mJ56oOMAsX6YH1smGR0QPITs/gmD0WiCd3wtd0WtiL
	xkon6OKN66H1C5AZqwtY6LgCPNzFr71bUx9mi0PoFhkCPF3iMe3EQHlvf4dPUg6SMFv92QFc8zy
	rYq2qwj+LmXu4Wlu1qkCx8JtYk+rnAcXwhWdY23MpRC5aQzNF3HUqhdWNq0HQmJJZRe2B+R0Iuv
	HJNtKGn0GddxbAs1fnuLs5xN5OmYhENfblyoFlogMCkgbHxM5hwFAgc5Xg5bj1OHc=
X-Received: by 2002:a05:6a20:6a1e:b0:3c3:7cd0:fc27 with SMTP id adf61e73a8af0-3cc719fe4a1mr42645756637.3.1787071142465;
        Tue, 18 Aug 2026 09:39:02 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c00d77fsm2350456a12.21.2026.08.18.09.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 09:39:01 -0700 (PDT)
Date: Tue, 18 Aug 2026 22:09:00 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, tony.luck@intel.com, bp@alien8.de,
	linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] cxl/mce: Only act on uncorrected memory errors
Message-ID: <aoSKpEQpbkrJmdD2@acer-nitro-anv15-41>
References: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
 <8cef03f0-ab19-42b7-ad04-a1e98e2270ec@amd.com>
 <anyYev89TB1jHAXe@acer-nitro-anv15-41>
 <e0f20e5c-91af-4f9d-b1fb-b00eaef76f58@amd.com>
 <anz2yiHLrDFhkxuv@aschofie-mobl2.lan>
 <aoL2QSTlDoAQhWhv@acer-nitro-anv15-41>
 <aoOVcQHklDi2_lhL@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoOVcQHklDi2_lhL@aschofie-mobl2.lan>

On Mon, Aug 17, 2026 at 04:12:49PM -0700, Alison Schofield wrote:
> On Mon, Aug 17, 2026 at 05:23:37PM +0530, shaikh kamaluddin wrote:
> > On Wed, Aug 12, 2026 at 03:42:18PM -0700, Alison Schofield wrote:
> > > On Wed, Aug 12, 2026 at 11:19:40AM -0500, Cheatham, Benjamin wrote:
> > > > On 8/12/2026 10:59 AM, shaikh kamaluddin wrote:
> > > > > [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > > 
> > > > > On Mon, Aug 10, 2026 at 02:00:18PM -0500, Cheatham, Benjamin wrote:
> > > > >> On 8/10/2026 1:30 PM, Shaikh Kamaluddin wrote:
> > > > >>> [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > >>>
> > > > >>> cxl_handle_mce() offlines the aliased page of an ELC region on any
> > > > >>> record with a usable address; it does not check MCI_STATUS_UC or
> > > > >>> filter non-memory errors. uc_decode_notifier(), the equivalent
> > > > >>> handler for plain memory on the same chain at the same priority,
> > > > >>> filters on mce->severity and leaves corrected errors untouched.
> > > > >>> cxl_handle_mce() has no such gate, so a corrected error - which
> > > > >>> the generic handler ignores - still causes the alias to be
> > > > >>> permanently retired via memory_failure().
> > > > >>>
> > > > >>> Corrected errors do reach the chain: machine_check_poll() logs
> > > > >>> them via the same mce_gen_pool_process() path that feeds
> > > > >>> x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
> > > > >>> extends p->res to cover the DRAM half of the ELC pair, so a
> > > > >>> routine DRAM CE carries an address inside the region resource.
> > > > >>>
> > > > >>> Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
> > > > >>> ("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
> > > > >>> commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
> > > > >>> machine checks") established this filter for an equivalent handler
> > > > >>> on the same notifier chain; the consequence here is more severe, as
> > > > >>> the CXL handler calls memory_failure() rather than recording a bad
> > > > >>> block.
> > > > >>>
> > > > >>> mce_is_correctable() is used instead of copying
> > > > >>> uc_decode_notifier()'s AO/DEFERRED test because the alias must
> > > > >>> still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
> > > > >>> the reported page but nothing owns the alias.
> > > > >>>
> > > > >>> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> > > > >>>
> > > > >>> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > > > >>> ---
> > > > >>
> > > > >> This looks good to me, so:
> > > > >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > > > >>
> > > > > Thanks for review!
> > > > >> If you have the time, could you also share a script that does the below testing on the list? It may
> > > > >> be possible to integrate into the CXL testing suite (see https://github.com/pmem/ndctl.git), though
> > > > >> the QEMU usage may throw a wrench in that. Even if it's not possible, having the tests out there
> > > > >> for people to run would help with any future breakage.
> > > > > Happy to share it. One question on where it'd fit best: ndctl
> > > > > (github.com/pmem/ndctl.git) as you mentioned, or drivers/cxl's own
> > > > > tools/testing/cxl/ in-tree? I'm open to either, or proposing it in
> > > > > both if that's useful - happy to follow your lead on which is the
> > > > > better home for it.
> > > > > 
> > > > 
> > > > If looks like there's already some mock functions for extended linear cache in tools/testing/cxl, so
> > > > I'd recommending trying to put it there to begin with. It may require updates to ndctl after the fact
> > > > to run the test(s) as well. If that looks too involved then sending the script out to the list standalone
> > > > should be fine. I don't know if anyone will pick it up, but it'll be searchable on lore if anyone wants
> > > > to test this.
> > > 
> > > 
> > > This sounded interesting! I gave it a try with cxl_test and mce-inject,
> > > and it looks like this can be tested without the QEMU CXL topology or the
> > > forced cache_size hack.
> > > 
> > > I built with CONFIG_X86_MCE_INJECT=m and loaded cxl_test with its
> > > existing ELC support:
> > > 
> > > # modprobe cxl_test extended_linear_cache=1
> > > # cxl list -R
> > > [
> > >   {
> > >     "region":"region0",
> > >     "resource":70300293136384,
> > >     "size":1073741824,
> > >     "extended_linear_cache_size":536870912,
> > >     "type":"ram",
> > >     "interleave_ways":2,
> > >     "interleave_granularity":4096,
> > >     "decode_state":"commit",
> > >     "locked":false
> > >   }
> > > ]
> > > 
> > > Using 0x3ff010010000 as the injected SPA, I first injected the
> > > corrected error from your example. On the patched kernel there was no
> > > CXL offlining message, as expected.
> > > 
> > > I then changed only the status to the uncorrectable case:
> > > 
> > > # cd /sys/kernel/debug/mce-inject
> > > # echo sw > flags
> > > # echo 0xbc00000000000080 > status
> > > # echo 0x80 > misc
> > > # echo 0x3ff010010000 > addr
> > > # echo 9 > bank
> > > 
> > > and got:
> > > 
> > > cxl_region region0: Offlining aliased SPA address0: 0x3ff030010000
> > > Memory failure: 0x3ff030010: memory outside kernel control
> > > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> > > mce: [Hardware Error]: TSC 23c5a5a9188 ADDR 3ff010010000 MISC 80
> > > mce: [Hardware Error]: PROCESSOR 0:50657 TIME 1786573477 SOCKET 0 APIC 0 microcode 5003302
> > > 
> > > So the cxl_test ELC plus mce-inject looks sufficient to exercise the
> > > path: the CE is ignored with the patch, while the UC reaches the alias
> > > offlining path and computes the expected alias.
> > > 
> > > The "memory outside kernel control" is because I did not put the
> > > aliased memory into system RAM for this quick test.
> > > 
> > > This would be a test case addition for the the cxl-elc.sh unit test.
> > > It seems like a tiny, close-the-barn-door-after-the-horse-got-out,
> > > kind of test case, but maybe not?  Maybe it opens the door to more
> > > things can do we mce-inject elsewhere?
> > > 
> > > I'll leave that to Shaikh if they want to add the new test case.
> > > 
> > > -- Alison
> > 
> > 
> > Hi Alison,
> > 
> > Thanks for trying this. This is very helpful.
> > 
> > I had initially started with the same cxl_test + mce-inject approach before moving to the vng/QEMU CXL Type-3 setup.
> > 
> > On the current cxl/next tree, I was first blocked while building tools/testing/cxl with LLVM/ld.lld. modpost was failing on wrapped CXL symbols, for example:
> > 
> > .export_symbol section references '__wrap_devm_cxl_add_rch_dport',
> > but it does not seem to be an export symbol
> > 
> > .export_symbol section references '__wrap_devm_cxl_add_dport_by_dev',
> > but it does not seem to be an export symbol
> > 
> > .export_symbol section references '__wrap_cxl_await_media_ready',
> > but it does not seem to be an export symbol
> > 
> > There were similar failures for some of the decoder/CDAT wrappers.
> > 
> > This appears to be the same issue addressed by the patch currently under review:
> > 
> > [PATCH] tools/testing/cxl: Don't wrap cxl_core's own exported symbols
> > 
> > https://lore.kernel.org/linux-cxl/20260721084009.38100-1-icheng@nvidia.com/
> > 
> > The patch avoids globally wrapping the CXL core symbols that are also defined/exported by cxl_core, and instead applies those wrappers only to the modules that need them.
> 
> Hi Shaikh,
> 
> I applied the patch to the base commit included in the patch:
> >> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> 
> I don't use LLVM toolchain, but I do see Richards patch you refer to.
> We'll need to get that queued for 7.4.
> 
> > 
> > With that patch applied, tools/testing/cxl builds successfully for me. However, I still hit a runtime crash when loading the ELC setup:
> > 
> > # modprobe cxl_test extended_linear_cache=1
> > 
> > BUG: unable to handle page fault for address: 0000000000003358
> > #PF: supervisor read access in kernel mode
> > RIP: __alloc_frozen_pages_noprof+0x12e/0x320
> > CR2: 0000000000003358
> > Workqueue: async async_run_entry_fn
> 
> 
> So there must be something different about your cxl-test address 
> space. I have 
> region resource: 0x3ff010000000
> region size:     0x40000000
> ELC size:        0x20000000
> 
> You cannot even load w elc = 1 !
> 
> Does "modprobe cxl_test" work for you?
> If yes, how far can you get? Does cxl-topology.sh work for you?
> I wouldn't have you try the whole suite since you are telling me
> cxl-elc.sh  already fails.
> 
> Maybe we need to look at where cxl test is loaded for you and why
> the ELC address shennanigans fail in your environment.
> 
> Let me know what you see. 
>

Hi Alison,

I found the cause of the `cxl_test` runtime crash.

My virtme-ng guest has only NUMA node 0 available and online:

# cat /sys/devices/system/node/possible
0

# cat /sys/devices/system/node/online
0


The crash I was seeing matches the issue fixed by Davidlohr's patch:
https://lore.kernel.org/linux-cxl/aoOmo-DZudbSOV3N@aschofie-mobl2.lan/T/#m60009c527f2017c031dad319366418578fcab1fd

`cxl/test: Map mock device nodes to an online node`

The test code has changed since that patch was posted. The original patch updates the three `set_dev_node()` 
sites in `cxl_mem_init()`, while in current cxl/next the corresponding paths are under `cxl_type3_mem_init()`.

I applied the equivalent change there:

set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2)); to all three Type-3 memdev paths.
With that applied, the repeated crash is gone and this now succeeds:

# modprobe cxl_test extended_linear_cache=1

I can also get a committed test region:

# cxl list -R
[
  {
    "region":"region1",
    "resource":1031060586496,
    "size":1073741824,
    "type":"ram",
    "interleave_ways":2,
    "interleave_granularity":4096,
    "decode_state":"commit"
  }
]


So the earlier failure was not related to the ELC address-space layout itself; it was the mock memdev 
being assigned to NUMA node 1 on my single-node guest.

I also noticed current cxl/next has a new `set_dev_node(&pdev->dev, i % 2)` in `cxl_type2_mem_init()`. 
`NR_CXL_TYPE2_ACCEL` is currently 1, so it does not hit this problem today, but I mentioned it on 
Davidlohr's patch thread as a possible consistency/future-proofing update.

I have not yet checked why my `cxl list -R` output does not show `extended_linear_cache_size` like yours. 
I will look at that separately now that `cxl_test` loads cleanly.

Thanks,
Shaikh

> Thanks,
> Alison
> 
> 
> 
> > 
> > So the build issue and this runtime crash appear to be separate problems. The runtime failure is what led me to use the vng/QEMU CXL Type-3 setup for validating the MCE change, where I was able to exercise both the CE and UC cases.
> > 
> > Since you were able to run:
> > 
> > modprobe cxl_test extended_linear_cache=1
> >         +
> > mce-inject
> > 
> > successfully, could you please share the kernel configuration and any patches you have on top of cxl/next? That would help me compare the working setup with mine and identify what I am still missing on the cxl_test side.
> > 
> > Your result also confirms that, once I get this setup stable, extending the existing cxl-elc.sh test looks like the right direction for regression coverage. My plan would be to derive the SPA and expected alias dynamically from the ELC region, inject a CE and verify that the alias-offlining path is not reached, then inject a UC and verify that the expected aliased SPA is still offlined.
> > 
> > This is a small regression test for the current issue, but exercising mce-inject through the CXL test infrastructure may also provide useful coverage for other CXL RAS/MCE paths in the future.
> > 
> > For the current patch validation, I still think the vng/QEMU Type-3 setup is useful as an end-to-end test since it can exercise the actual CXL region and system-RAM memory_failure() path, while cxl_test + mce-inject looks better suited for the lightweight automated regression test.
> > 
> > Thanks,
> > Shaikh
> > 
> > 
> > > 
> > > > 
> > > > Thanks,
> > > > Ben
