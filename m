Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801413F6C24
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965271; cv=none; b=sGEOZs5NOhpq105eKM476JQwRPx3tO59+pwai3eqXO+QEzP54DZEanglBDVdGxjGDQDvJLeR5LGzjZCdmzvkwZ25KHNuEbhDW5T0nXe6ZUTpWbrVG/BsiW7deoYECsbLsdpkQLTijLyyBonslZTls0P5YAXt5SPrih8vpZrS4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965271; c=relaxed/simple;
	bh=nD9K8bVy07EjGGY331f7/Uic+6qfFXJYbJJyzqaxl6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts57FLFv2ESRUj3JOHQY8ZhEufDR43lZpIKcmdjKB5gYAQJh1+cD8ypSSaVF0qgOU8i7Ghx0ovks61lSypPriL7Atnz241nlNtEQVvsiqNzKwPIsbaV2Ql24zL3b4YUa5jVi62s85KD1j7Nwsduzg+ZiPZ6O5bpxA2d6kJyDdJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Czcymrhk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czcymrhk"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso2515249b3a.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786965269; x=1787570069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZtE9GmPaJOtv3fYvjG7nEhEW830I8ZYTz/3kxXtVCzo=;
        b=Czcymrhk39e2Uefazu9aCzgC7u/FgcxeV9otYLCKAVPGCVEM/xWXjPLABcMo4SXDPP
         PL1o3EsNwZx97qjDMdFLRo6eMimEu1zfeYwDt05FWvfQ2RkLOYwJdeRvjbAOg/ODNS+g
         l4UBmdjenvOE1MGqKIG7BBuvoXanyqEYxxLoYtmfhmCzTVRHQe8y7+lxexgGOcNHfX8E
         OBeUgWX1vQO/Ff/IgWapAcyMwbnm0oEAteJ6Wh5GTSj4wzNhdhmBvt2XtefvNwDiE9qF
         EiG6/tg3lyuohG7Ke60qmX2/BUC050IO1wIn8q7wQa93ylu8bOsXxv7bhyvgQB5/tk65
         NMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786965269; x=1787570069;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZtE9GmPaJOtv3fYvjG7nEhEW830I8ZYTz/3kxXtVCzo=;
        b=oTzuq4PhvsO4DxIAtXlApSOQkT8oZEipWZsMlLLrYhVD5aWDnkWdlkHjqYkZaCX3/Y
         hDOh9qkwQc6AS/6N86aRk6t+ajBY+0vVbjEbQdrH06O8SpvVnfERuZ377YFvTEzJPjCP
         qyzq3+V2xiNmRKPKUPLEqyXE5p27DTk1DhCmYRYOmEmFv/t2B4FhenVmKWBe5gXfxrho
         q7/ufyF6sCcbVNnZHxLizFfyCBHhfmnbwW4JotmpzooFlf2O+Zq2aIHNgiO9uDAHDFff
         ARIqUcKwarChnsai7a37tEYhCa4kKb57iR12XlJ1OUyKHyf0YWZG+1zgsqS0QFY+NKYK
         oX3A==
X-Forwarded-Encrypted: i=1; AHgh+RrmKrtwpWXvz/1F5uH+p5GnII60OhuYevvLKku6+PeuNJldTcKt7SbSFQcLgi93G2Z3Eom8X/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8Aiqbq0yhNDFbL2Jo/cVTem3/GCi932DoAu+KRRrTKEkcfdg
	G1KaK3K8+wbI6isQb9uYPRgFc9dMuut8IXcwjlRhQQGtY6Icd92fSE1e
X-Gm-Gg: AR+sD10kXbF0pz+Ti71NaPW+pE14a/Tgk0jfyRkIM6tHD4VwAZuZC5zuuE0tgZ/3Qel
	SPrXLRt6FfivZ8L3T2xbdnZTLidzIncUgoqVx/yO2v3RXDqQtpEXMZtASg2QCAbEaK2kI3w/lH5
	c0uZcPG3lyuP1VM2PdTPQ6IujgOlbcgdzaFvQXBbL/0ul+wH8QDdqC2IscR5DJMrzGtYqqxaSV9
	nPAYqXBRJQkFB9ZLWXmGQ4C3Fgvm5YlUWyIMARApy4jwkiwLEyzj/Ta8aCYe5gALJ0UB/MR2GkL
	j4gId6IRmVAgeMxqGoeTAYBjc6Q/sI13AQ8WFF6qvstbETO1Ttx2hQa9fKKroYBp65CHiOLK9GX
	B8O69mGITpKIInpI2TUQuIbW1kSwF9PbXzlfC+wtsI+xJFB+xP+JGaRq3zIPrFQk3ojrz4cQzT6
	UGpvjFMlnYUfg7GUSmrd3g8SUbCj80OItKLHDM9DJ+djDYdIDn1R+TrF47NjMkiUXiXjlaDwAjl
	A==
X-Received: by 2002:a05:6a00:2a0e:b0:845:bda6:574b with SMTP id d2e1a72fcca58-84fddf88400mr24048053b3a.5.1786965268626;
        Mon, 17 Aug 2026 04:14:28 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13bdf715csm567703a12.0.2026.08.17.04.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:14:28 -0700 (PDT)
Date: Mon, 17 Aug 2026 16:44:26 +0530
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
Message-ID: <aoLtEu5e1xi-UFy2@acer-nitro-anv15-41>
References: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
 <8cef03f0-ab19-42b7-ad04-a1e98e2270ec@amd.com>
 <anyYev89TB1jHAXe@acer-nitro-anv15-41>
 <e0f20e5c-91af-4f9d-b1fb-b00eaef76f58@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0f20e5c-91af-4f9d-b1fb-b00eaef76f58@amd.com>

On Wed, Aug 12, 2026 at 11:19:40AM -0500, Cheatham, Benjamin wrote:
> On 8/12/2026 10:59 AM, shaikh kamaluddin wrote:
> > [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Mon, Aug 10, 2026 at 02:00:18PM -0500, Cheatham, Benjamin wrote:
> >> On 8/10/2026 1:30 PM, Shaikh Kamaluddin wrote:
> >>> [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> cxl_handle_mce() offlines the aliased page of an ELC region on any
> >>> record with a usable address; it does not check MCI_STATUS_UC or
> >>> filter non-memory errors. uc_decode_notifier(), the equivalent
> >>> handler for plain memory on the same chain at the same priority,
> >>> filters on mce->severity and leaves corrected errors untouched.
> >>> cxl_handle_mce() has no such gate, so a corrected error - which
> >>> the generic handler ignores - still causes the alias to be
> >>> permanently retired via memory_failure().
> >>>
> >>> Corrected errors do reach the chain: machine_check_poll() logs
> >>> them via the same mce_gen_pool_process() path that feeds
> >>> x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
> >>> extends p->res to cover the DRAM half of the ELC pair, so a
> >>> routine DRAM CE carries an address inside the region resource.
> >>>
> >>> Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
> >>> ("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
> >>> commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
> >>> machine checks") established this filter for an equivalent handler
> >>> on the same notifier chain; the consequence here is more severe, as
> >>> the CXL handler calls memory_failure() rather than recording a bad
> >>> block.
> >>>
> >>> mce_is_correctable() is used instead of copying
> >>> uc_decode_notifier()'s AO/DEFERRED test because the alias must
> >>> still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
> >>> the reported page but nothing owns the alias.
> >>>
> >>> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> >>>
> >>> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> >>> ---
> >>
> >> This looks good to me, so:
> >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> >>
> > Thanks for review!
> >> If you have the time, could you also share a script that does the below testing on the list? It may
> >> be possible to integrate into the CXL testing suite (see https://github.com/pmem/ndctl.git), though
> >> the QEMU usage may throw a wrench in that. Even if it's not possible, having the tests out there
> >> for people to run would help with any future breakage.
> > Happy to share it. One question on where it'd fit best: ndctl
> > (github.com/pmem/ndctl.git) as you mentioned, or drivers/cxl's own
> > tools/testing/cxl/ in-tree? I'm open to either, or proposing it in
> > both if that's useful - happy to follow your lead on which is the
> > better home for it.
> > 
> 
> If looks like there's already some mock functions for extended linear cache in tools/testing/cxl, so
> I'd recommending trying to put it there to begin with. It may require updates to ndctl after the fact
> to run the test(s) as well. If that looks too involved then sending the script out to the list standalone
> should be fine. I don't know if anyone will pick it up, but it'll be searchable on lore if anyone wants
> to test this.
> 
> Thanks,
> Ben

Thanks Ben.

I took a closer look at the existing tools/testing/cxl ELC support. It already provides the mock ELC topology and uses the real CXL MCE notifier path, so based on Alison's testing it looks like no additional CE/UC-specific mock support should be required there.

I had initially tried the same cxl_test + mce-inject approach, but hit the current tools/testing/cxl build/wrap issue. With the proposed build fix applied, it builds for me now, although I am still debugging a crash when running the ELC setup. I am comparing my setup with Alison's working configuration before making any test changes.

Once that is resolved, my current plan is to extend the existing ndctl/test/cxl-elc.sh test to:

derive the SPA and expected alias dynamically from the ELC region,
inject a CE and verify the alias-offlining path is not reached, and
inject a UC and verify the expected alias-offlining path is still reached.

So I will first confirm that the existing tools/testing/cxl infrastructure is sufficient as-is, then share the cxl-elc.sh changes here for review before sending a separate ndctl patch.

Thanks,
Shaikh
