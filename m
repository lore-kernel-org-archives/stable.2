Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324052AE8D;
	Sun, 16 Aug 2026 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786870997; cv=none; b=aiZU+kTrLrMG0U94ku7YNYMuwxE85a6AfPsjkQCJx5mw0pCBGfeexv3nMF1w+SM19ElGPvZkqv/gzFf4jEi+zXw+hnVCxdI4dycuqO09ZbqvINIiixmEth6CcioDxPVgK6FSw6xQTsoQIFVaIXcdySSGVont12GgHVOnkZY6V2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786870997; c=relaxed/simple;
	bh=Y8aTInq3Ue5B+m7Ojgga8oeXyWhKzUe6+oTa5ZoZ32o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFfVMdltLo8XyepSvuNT0vJyeLChlX2YOjxc85/Qikw/NmsqR2L7smPXb/vae9UwwOTmfpn+WPCePXkJI6H6ciDMzrwTSEBEzBw9dCmKoR9nQGYlwJEkMci2srywgrJXQ0mZn1rAiRLHpmFom/vD++suUjQZzWKP8xnMseos/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhlJuTsS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhlJuTsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC681F00A3A;
	Sun, 16 Aug 2026 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786870995;
	bh=8dRSSX2JAQZgwWhR5q7ZovzbG0pw2Sc7JhH34Ynua1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HhlJuTsS9etJriQhma1EQG8iRFbEildqNTcjp8UrZmjCy1Y5uyZVhxDqZ2UN7jX45
	 /UmEPju6KkW9SBS0sH5Ao29HbZ3Z10Qj2m51ct1m2ZQdSxr52E1SOmc/9PSmIZ5wDb
	 yRgDcOXTgeBylHjxFIR/piJvlU9UmKKSX6aYLaeKITrReJxEZvEgDvnzqphs8kRwS0
	 J7NCjjOaJ6NbSIM4WTO4+qJMk8FkR0qvpthCeYfRt3PDxuOPZj/PgdnKVEsnwEj/7z
	 pMUB8xnDnnAlObV5tuwZEQrEkq71yXpl+HpnF+51DEptXpjFV4NruVV3/cD2WR1Cbl
	 43c1uP2lb/vHg==
Date: Sun, 16 Aug 2026 12:03:08 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Maxi Saparov <maxi.saparov@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sdimitropoulos@coreweave.com,
	Maxi Saparov <masaparov@coreweave.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] kho: do not reserve scratch memory in the kdump kernel
Message-ID: <aoF8zPXiKpjt2Nsv@kernel.org>
References: <20260803193938.8778-1-maxi.saparov@gmail.com>
 <20260811161857.3096-1-maxi.saparov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811161857.3096-1-maxi.saparov@gmail.com>

Hi,

Please don't send vN+1 as a reply to vN next time.

On Tue, Aug 11, 2026 at 12:18:57PM -0400, Maxi Saparov wrote:
> From: Maxi Saparov <masaparov@coreweave.com>
> 
> If a kernel with CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y (or kho=on)
> does not receive a handover FDT, it reserves KHO scratch memory in
> kho_reserve_scratch().
> 
> The kdump kernel always takes this path. Since commit a6715d7ec472
> ("kho: skip KHO for crash kernel"), the kernel does not add KHO
> metadata to the crash kimage. As a result, the kdump kernel never
> receives a handover FDT and always reserves scratch memory.
> 
> The kdump kernel boots in the small crashkernel= memory reservation.
> On our x86 hosts, the kernel and initramfs make approximately 176 MB
> of early reservations. The scratch areas then use approximately
> 650 MB more of the crashkernel memory. When a large early allocation
> fails, the kdump kernel panics:
> 
>   bio: can't create integrity buf pool
> 
> A kdump kernel has nothing to hand over: its only task is to dump the
> memory of the old kernel and reboot. Fix is to disable KHO at the top of
> kho_memory_init() so that the kdump kernel does not reserve scratch
> memory.
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxi Saparov <masaparov@coreweave.com>

I queued this patch for v7.4, it'll appear in the liveupdate tree after the
merge window.

> ---
> v2: Move the kdump check to the top of kho_memory_init() as an early return.
> v1: https://lore.kernel.org/all/20260803193938.8778-1-maxi.saparov@gmail.com/
> 
>  kernel/liveupdate/kexec_handover.c | 7 +++++++
>  1 file changed, 7 insertions(+)

-- 
Sincerely yours,
Mike.
