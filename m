Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795365023;
	b=kbpN56ulByTmBlnZ4ghzifYlaMVBOwy7KxR0yHnLfwt6WqjOXwtbV2vxCd5DGn2TVbf6
	 pGnc8w97LnEPvKcMzI65qh4drJINrERSh1F2NI0RVbsfzqS/4v1IT1VdpMDNzezI6fzc9
	 rkqiBDpA2JGKoAgunuxjUk6FyIVB5vXz/uh2wg6L34GvSfi1kOw+NIFdVmgmo4S23b3nU
	 A9qjn3hA3Se/13U4Uxl3clygwvGK4sHQkfbL/2zhq9MovTdXyCVLzUMpCXrGSE+hlVgor
	 /wtUsLJpKPXO8gss4RPowKoBz84Km8wUeRh8zvvu6oJDlR4L7OpR483RfB7u7Gbdssg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795365023;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KzrVEQ03EK5eu+7tSDtmCyEtJgI25e3+3defglUPBK0=;
	b=Q2NZOBPxn0AWNn+Rw43JwWH5QVdTirDptuD4N4ztWoZY30iMjwS/kxcrYaR5XNKIzO7g
	 AjIrlWBpSHMuIISyPExSMlsXG6AjFmqxUyb8+BI9+fk2knxBykSeJVJwXb2uIGcYTDH2K
	 6F1c1fiREiBU0d32ePaMolbDeBl1s4reKde+kzTGVD+wlBbeVUWbQcNUzhLE5VF+5oqRF
	 5QzitcJ7B0vMovIhH0lE59qsNBhtah9SpXSJASGB7FV2L3TLCZX212u/uF7BYnx11agv4
	 LUNIKdThO13LwcmHr8eeTrNfE1RrqiCzVgCtIKpczdNGVv9U9F1tV3O8wKfo3X1TRJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghF7CWUM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38329606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghF7CWUM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7601F000C6;
	Sun, 22 Nov 2026 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795365022;
	bh=KzrVEQ03EK5eu+7tSDtmCyEtJgI25e3+3defglUPBK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ghF7CWUMVugPxg90sHHKYEuZ3yfSWM233Kz7XPmsYFNoH8ePGcEbFvq+3tjJvwARM
	 C31VtR89lcPiYAdWjzKHdq0uDAHG0vykVegt4OhFNQAnrE9uc50dm2/ucEFtc5H307
	 z9ipHD7izlqUI7oLV3OzY3TPmA/V3FAinMcG70EnZV5PW+Nz27ECsoIn64+Qm3lyw9
	 amEOLkCTcLr+6CNiqBmmK1pi+RiViiPRpGmeCK4JtyQb1BwsjhkhXR9GQzDryKfCTA
	 74r2U3LJpqelptWe/c0EjDwCDfzMsxk2zPAFgvuXvS4X18hw1f6OC+2XCKwWbk4SkB
	 aiusnbaFYdUvg==
Date: Sun, 22 Nov 2026 18:30:15 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: fparola@amazon.de, akpm@linux-foundation.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, baoquan.he@linux.dev,
	kexec@lists.infradead.org, linux-riscv@lists.infradead.org,
	nh-open-source@amazon.com, palmer@dabbelt.com,
	pasha.tatashin@soleen.com, pjw@kernel.org, pratyush@kernel.org,
	stable@vger.kernel.org, thunder.leizhen@huawei.com
Subject: Re: [PATCH] crash: Fix crash memory reserve dead loop when low and
 high limits match
Message-ID: <awMYl7QyfPtbM-PC@kernel.org>
References: <20261119093730.49471-1-fparola@amazon.de>
 <CAEBC780-5EA0-425E-84DA-F16817BE884C@linux.dev>
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
In-Reply-To: <CAEBC780-5EA0-425E-84DA-F16817BE884C@linux.dev>

Hi,

On Thu, Nov 19, 2026 at 04:07:41PM +0000, Bradley Morgan wrote:
> On 19 November 2026 09:37:27 GMT, Federico Parola <fparola@amazon.de>
> wrote:
> >On arm64 with neither CONFIG_ZONE_DMA nor CONFIG_ZONE_DMA32,
> >arm64_dma_phys_limit is PHYS_MASK + 1, so CRASH_ADDR_LOW_MAX equals
> >CRASH_ADDR_HIGH_MAX. If the first crashkernel=size[KMG] attempt fails,
> >reserve_crashkernel_generic() falls back to [CRASH_ADDR_LOW_MAX,
> >CRASH_ADDR_HIGH_MAX), which is empty. That attempt fails too, and since
> >search_end still equals CRASH_ADDR_LOW_MAX the fallback is taken again,
> >forever. Boot stalls after the "Initmem setup" messages.

This is really hard to read :/

> >
> >The first attempt can fail on a kexec handover (KHO) boot, where early
> >allocations are confined to the KHO scratch areas.
> >
> >Commit edb907a61333 ("crash: fix riscv64 crash memory reserve dead
> >loop") fixed the same loop for crashkernel=size[KMG],high. Skip the

How is this related?

> >fallback to high memory when there is none, so the reservation fails
> >with "cannot allocate crashkernel" and boot continues.
> >
> >Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
> >CC: stable@vger.kernel.org

Do you see this in field or it's what some sort of analysis shows?
 
> Oki.
> 
> >Signed-off-by: Federico Parola <fparola@amazon.de>
> >---
> > kernel/crash_reserve.c | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> >index eee37a11380ce..1417b429b45c6 100644
> >--- a/kernel/crash_reserve.c
> >+++ b/kernel/crash_reserve.c
> >@@ -421,9 +421,11 @@ void __init reserve_crashkernel_generic(unsigned long long crash_size,
> > 		/*
> > 		 * For crashkernel=size[KMG], if the first attempt was for
> > 		 * low memory, fall back to high memory, the minimum required
> >-		 * low memory will be reserved later.
> >+		 * low memory will be reserved later. There is no high memory to
> >+		 * fall back to if CRASH_ADDR_LOW_MAX equals CRASH_ADDR_HIGH_MAX.
> > 		 */
> >-		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
> >+		if (!high && search_end == CRASH_ADDR_LOW_MAX &&
> >+		    CRASH_ADDR_LOW_MAX < CRASH_ADDR_HIGH_MAX) {
> 
> Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>
> 
> 
> > 			search_end = CRASH_ADDR_HIGH_MAX;
> > 			search_base = CRASH_ADDR_LOW_MAX;
> > 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >
> 
> --- Thanks!

-- 
Sincerely yours,
Mike.
