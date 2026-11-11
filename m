Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424749;
	b=BK3QP/H5UB+0vwEH9jssFhWOXJW+xyLHNRGaiaHj4R+3OSYFbdg4Bh4lyHjtj8qRIpyJ
	 3dfFUwL7B9HytRqmZ5re+Xeb7AEuj5mOCkicXr46z0HN8lnQCVfk50PhzVxkqxQJAD/TU
	 7s0mpicpe6jRefKeM8T7RcB9jCEIJ7Ykbm4o7JxLfKf04VuVjiaQJ4ZSEtSA2hfPFuDEc
	 fHW3dXxEjMnaOyq6CkiOSTpEJaP9Jdq0cDxTn5RWPWbAJqZ8RG0bWPNeT6EPSwcrAZHx+
	 WZ/7G29IkUIL4Al83A3tj/OPg3VXpD3KdYr24r4ksXTf6M1Pe9S0dls13zFr0JViNoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424749;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qAPPZVTkRlTwW1+3PqzGIZjGZrGorIqtZwoux0Jo1t8=;
	b=zfbnwGFYkht28CO4QVqwRKw+YOGI0B0kd1fasA0jco//IRXfenZwrLfPg/kldBdNL/1L
	 VVCG07SB8NzoYH5PqYhUs51k9yTG+0RZfyTsbcWLOPUbw3IBh/ZcHN4I8T0vNp6goXbGI
	 /Q5lPTGhNRPtW+6U8uSU6//w2mBb3iFyBUi0uc0Zsx+53iSU0CKgSMrVuJm6mJal2fmRF
	 RnVx7VuZAmcuV8sWLAPTpZ2LnnGZgBl+rDTc8NZkSRMBAlE76OTlcEeJkXOx2P1bcU0fn
	 pnq4bzGzS8FEW7aOPavUeD3fRJEPXOBoHV5G+ikPqZf7Ee9pdrz9bWl5hEyCL6GadUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDDO4vWy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A5606A334;
	Wed, 11 Nov 2026 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDDO4vWy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9A51F00A05;
	Wed, 11 Nov 2026 19:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424748;
	bh=qAPPZVTkRlTwW1+3PqzGIZjGZrGorIqtZwoux0Jo1t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TDDO4vWyt2A9yv+0p0q/FA45O0rd06kdgQKObSVxLFxHyenMzI02gn6sP+gDkcrUZ
	 qo55JCTgqKyPSNRQcg9Ja5Pt8x0nn9Nat7EWGgERyPLQ4IwerQeXgshj+6dkkihAWC
	 PrJKETiUpBW3F9j9DHkKsQTsjCKxaaVnlXpACNlSJofkotFprXYZbxqSM878SyppZZ
	 3K+2xrDwmLLa4CJZ0F7KAHAjgj0AR2H3b0djolb0/r99Ao2bnFPDPXBehPW+kP/Bv5
	 HoQ6Voiiw0/kZwYv2T1MvHcB+UWZc9PAzLo3nurtuuM7vDU8gxjlgQpgVvPVjNplHA
	 MsW10zis9Xmeg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 29859198003A;
	Wed, 11 Nov 2026 14:19:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 14:19:05 -0500
X-ME-Sender: <xms:pb_0anxl5grZleYVCEAHUdoMH_SIdXgNi3YSamqe-e5ICnkz1tGVgw>
    <xme:pb_0anj4-ow4J-Se1P-HX4G-18PohrUySEMfY_cCS7lwhGvvhDfrubhKQv0XyM6vC
    PENWpNMYUejKoGDTcfI4npDv7t9ZqBXQy1cNES9UyrELkCHzVW2KG4>
X-ME-Received: <xmr:pb_0avL9ISgP6BHP6GeBHZCV9oJpcCy0y8t1mPqxNIyK1fbV2GJABeZC8i0>
X-ME-Proxy-Cause: dmFkZTEN7KIAjWcjeVWSiqg1tb1AV3/0ocRjzhPZnrhv3Y9U5nJDiFMvHQfgcNVbET2IHS
    V4PgnXLV9GMRFgEU71pzcq6gDDgB+miAQQzBL2ylvgYsAvj0QwsytTmr4w0cUsyke60eOy
    uJ6Hvpqb7Yanyi8J+98etPY14DsAqvHzmY5dXKhYnySsPS3S7QJZ/cGuW3BHs8xDfim0NH
    MUNL9Qj6r+CWWTM1Cj+OeR2EF3jO1lP67NDR8ZmuFyjEXx8bdLK1a9V7dJK+wa1ehM6+lI
    pj6EITLBXH0M9k7DH7EEEU3dSIOSx0j0jWAnqHk/C2/g4M6eZpEQa7nxOkec3pGqah7MS8
    eerAnsVmA/fyaJ7yTNv6jfnGcFrsI2GHWkfZXfUCLJpXT2qURk1xU83UgPK+e+gvCXUz4z
    nuMl5ejEY1zX8zCH9Q6C7PlXbAgwKNDJ8VDGKcAZvL6VHUw9t+lWjBJpRGJ8Za1Lb+P6vM
    49kWRACh9Tdxm2S4cXwNPUtrTngDa7lskaOikaGR4VI+Y9r4nFTlvEklE/yCMmbGpk0R7A
    9qhI9mAw/GZWRLLTTQdklNUxuAFU3ccIPHnjNF0BINrY4KEHMNMh+9EVJNv1DG12kcYOPl
    zamrk15mS2yRIKoeTbObYg6PttDCkx6vUt9yHNXH+OLLP5esTe3qIo1MqZiA
X-ME-Proxy: <xmx:pb_0amfQkex2AYXXuqLj5bosFxgke5x06wC7JqYEKkSx_dz-wO57fQ>
    <xmx:pb_0ajg02CKYIzWlBSgSCGDx37QItlV9TVwSxDOJWHWiO0zyd9xSuw>
    <xmx:pb_0ark10NYuWkVCt-oUoafq6WDDt67eV93dfUXX1vf-hCtqLpjPIw>
    <xmx:pb_0aqVfRrB4FhOwkLuDgt4nXNI86V05WUNmvz2UCGKQ4OzjjMmvfQ>
    <xmx:pb_0aoo61dkYFNf3bBx8bvoZ1ywawEbkp1leS6v-OghpHYIw8xqMxwFP>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 14:19:00 -0500 (EST)
Date: Wed, 11 Nov 2026 19:19:00 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs/proc/task_mmu: fix make_uffd_wp_huge_pte()
 prot-update race
Message-ID: <avS_WaLHYxvwoZXM@thinkstation>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-2-kas@kernel.org>
 <avNEgmvYdoukt6MS@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avNEgmvYdoukt6MS@gmail.com>

On Tue, Nov 10, 2026 at 08:23:11AM -0800, Breno Leitao wrote:
> Hello Kiryl,
> 
> On Fri, May 29, 2026 at 06:23:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> > The non-hugetlb sibling make_uffd_wp_pte() does this correctly via
> > ptep_modify_prot_start() / ptep_modify_prot_commit(). Mirror that
> > pattern for the present-PTE branch. The migration case stays as-is --
> > migration entries are non-present, so there's no hardware update to
> > race against.
> 
> I am  seeing this on next-20261109 (arm64, PAGE_TABLE_CHECK) while the
> pagemap_ioctl kselftest runs next to a workload that migrates pages:
> 
>     WARNING: mm/page_table_check.c:206 at __page_table_check_ptes_set+0x168/0x178, CPU#21: pagemap_ioctl/894691
>     Call trace:
>      __page_table_check_ptes_set+0x168/0x178 (P)
>      __set_ptes_anysz+0x50/0x240
>      make_uffd_wp_pte+0x104/0x1c8
>      pagemap_scan_pmd_entry+0x1b98/0x1df8
>      walk_pgd_range+0x7b4/0xd00
>      __walk_page_range+0x108/0x510
>      walk_page_range_mm_unsafe+0x150/0x3e8
>      do_pagemap_cmd+0x418/0x7d0
>      __arm64_sys_ioctl+0xc08/0x1338
> 
> given you've touched this recently, I am wondering if you've seen it.

I have not. But I think this patch should help:

https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-3-00713d368976@columbia.edu

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
