Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276850;
	b=rMM3ynUo4R1Ci80ZpCTaMNnxjDqv8HGwdV4909Csrdz+KY9csrBt93zaX7rVgRQb4vSK
	 4NOE7kqWPH+JSbSNQs1JaO2OkeB0K1Mffw9Zb5PIsPIWNO6zDzeHrE+axXn6A6xLVbf7G
	 UwxDvOkRLt20AfCbV4doPIZaB7uH8yHmemycDT2pQgHiKk1+XZpSSnw2xXiny/Z7t0HOd
	 7VspVPOUo5RulAoTRVS5qKPBc103n7R3Uc8JgZ/nwm9U13DySgDeS6wX3VAe6u1rSZV+s
	 kfQK1c2JaHe7aeU9Z2LPmoZloSHsQbjmhxzVNY6P/gM+67biLJopM8pHHVooOKDVMlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276850;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nAi38oDFP76CAkZTKfTnMRaPWxkhX57roj58CzJcb5w=;
	b=Z9C3Ak/wR5n+U18L8nUjicKR2HybChUmnPMIGLF6cIJHM/+i+POfcxLmejMA/WswQome
	 v+THJtGfcqtQ9MEvjYqdoJDBTAUcJD3pfDmikBa8ziai6InlZa6+9B2nT6kKwMYGPTeDa
	 i3y9bIHs0R+y0ru29QstPHQm2P3/IAdB+6xy3LA5pMB470CHWbm6dfDypZzsJMYI15XP9
	 bxYygCkXPLTxG2FcaRwlP6AeDh7mj2b4iGlcGyx2FepQshIXj98ybFwl1sAD8fN0B7Vey
	 zfHEQyVLwuGeLrj2RErqawbMSF0DXsr+E8/uA1jJMlabQt8g7KxB5r0JADgUeIYeA/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFIIHyzx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8309C606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFIIHyzx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823AA1F01829;
	Thu, 29 Oct 2026 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793276850;
	bh=nAi38oDFP76CAkZTKfTnMRaPWxkhX57roj58CzJcb5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SFIIHyzxcPwhs42rWmTPn4ykZNkWEkrCoddjCAjOFxs5zLHSidCZgvaP9L4ZngdpQ
	 GFu2Yd2ZZNq78VHkABoHyg2y7Mq5cQTqtPW1cD+1kubEQN5dHEP+RwWCUqe8Q9S7o3
	 sFNwaas2hXTCIzQ/3hmjVZGIK/Yh5P/veJ8q8nN3BcWoaveEu9D6M8qULInT3IE3p/
	 ZzMkdhx6AkLazxKGWBvNz1hWdAwHpspA69LZJeHIgTLWYUpBcxjEfLsPlh08/ic6mA
	 mDXMSZSmNwWtC2/ko+9JvPAhlA7yBfwpup2nXcHxxTN47KiBfcwTMIzpZEecSrcVfj
	 HUZWX5uXr50+w==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 13580198003A;
	Thu, 29 Oct 2026 08:27:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 29 Oct 2026 08:27:27 -0400
X-ME-Sender: <xms:rTvjarzwywjEjar7Mt_OyMWq6UW3-vjrV-PTwOnk-DHqc7KzFu_6Pg>
    <xme:rTvjajsv2wlC9eqWjv70wTcXnB743VNGDp9L2F6rQ04jOq6l1oe1uUoKqxAKvlbnb
    tCT4lZDnF-5dAX8TnsGCsutkPpXhc_aicyLdobpP4pJmEpm-2GproLI>
X-ME-Received: <xmr:rTvjaqxh5Kc1tu7o5vaw3wgfgB2JBtg5JTCiBU2E1bDWEMdzraQhf9JQgak>
X-ME-Proxy-Cause: dmFkZTE5B5/2wy/nW1OFB+CZ7Y+pP/zumq35zbaEYOek3IM3be5kjPml9FiEI9wEM1jNQn
    66RdhojvUW55Dx2BnSMHL3H4cTTa2ZgY3CMeKe9qVIUt96GpJ5DS39An2tyb5y1ezFCMWO
    C3cIeaP2mUrQT+dMOwdjAJqmarhyTJNtcAWXTZ8q1eZIzwkbX3axu2Dpi3dr+0vbzTJ4KN
    M9mNGSlVSWIpojb7gtvoOfwvQT/ZVd+omkWUadmGcD349l0GKA3Z8DA+TkTZ8FEuV7xbCO
    pCC7eJ5pF3UCYpWwrgGCFRh+RcwnRaLmeeWGla4wJozIhGeDLgbdlz5SBorQQr24uYSDa+
    B9Tm1/m/AT54fyJzVbw193d0xYAPrAsxjWVOuSnXmpvuwcChvrWFcWnIwqPzkyN5DkyWjv
    4ICYY9JeLOAM98WEMUESsP/OmGilWUW1bILaBYrFN3oBw7J/yopenCGgQLt+dlMK2AFU/E
    eVbamYEgO1eW62+yllod0lsPs1rKiLcqAZWaaflztHmzgT2TH1Kv5ogg7UCf722w4s2bzS
    ViAzt1ykhJivLBChtRX47gCkNjaJfEPR6phq2/k0gEI/tUv7k44L6gVKHoGEYYlrsD1eEQ
    +LCk3lIy1eaYj+nleQIYd+vUmdhJDLkLLgSPeoK+u09Rc9NGUPtiJzsfsENg
X-ME-Proxy: <xmx:rTvjajd1xvSaopur4XQIHDw42kxaMUcEZlm7-uOZGDSAle0uXEqMnw>
    <xmx:rTvjag3LOj5FGpB0XKfhVBrffrTwd_fVfU6T8njGy2xnGvdKe08gIQ>
    <xmx:rTvjasspO909yfCDAsKVYm9rvbGu0aBSJQUUjVsfD0Ub88u_TrWcYQ>
    <xmx:rTvjas8So1Fg21YsmrhpvnR9l2CfUsleJmX2kPUnNv5C-wZ2Df3XnA>
    <xmx:rTvjagSjOuRSqet80xz00EZT4UMabbgR1eKzwCGUonWupFdLj3QV6gPA>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 08:27:24 -0400 (EDT)
Date: Thu, 29 Oct 2026 12:27:23 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/cma: accept memory of CMA areas reserved with
 memblock_reserve()
Message-ID: <auM6lKGAeUI26jCj@thinkstation>
References: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
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
In-Reply-To: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>

On Thu, Oct 29, 2026 at 12:18:36PM +0200, Mike Rapoport (Microsoft) wrote:
> Pages of allocated CMA areas are released to the buddy allocator with
> __free_pages(), which does not check for unaccepted memory.
> 
> This usually works because memblock accepts the memory it allocates.
> 
> However, multi-range CMA areas, used by hugetlb_cma, and fixed CMA areas
> requested with cma=<size>@<base> are reserved with memblock_reserve() and
> their memory is never accepted.

It feels like memblock_reserve() abuse, no?

crashkernel=size@base already uses memblock_phys_alloc_range() for this.
Should the fixed and multi-range CMA paths go through the allocation API
as well.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
