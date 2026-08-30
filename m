Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D061318BB8
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788129857; cv=none; b=QcMyd0hE7BdaOeM3dkdlWANRyV4R4sXDa0urIHSYCArHJ3UROqz7/+gIoy5TSFFerDLNAOWMs2CLyaGbGYgRBUGBeUC8m2Y0ev7jL3TzBmcFztVaK6k61yJV8ts82eecFWhhUJJFGFNZ0zlQslW5SC2jFVesPF+ZxnRLRIheT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788129857; c=relaxed/simple;
	bh=3O1H5I23kZ2dqpk/N7dvTwxt3a2ChdqzD+jYb3vHEEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRvru3+jhSH6mt+apz22tM5TJBvoM8w5hTq28ds8RPcqxso1hUjHtc5dM2Yq9Pnvp93InaRbXEETSPWK7E+ujG8+nFp8YC+fbCPC6zCCsHBRNJs6vdjCWpBPKlRWUAZhmymyeaJkzEV38zQFHE83Etl1VGSq/AxCC3zJmavqnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V83mcKKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V83mcKKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E8B1F000E9;
	Sun, 30 Aug 2026 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788129856;
	bh=qjvVrfpvEq6xQiZwfw476AT3IS9YPvQCsONoxq5pBks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V83mcKKLEss1XYIymJxfnO9Rqy02IwbYCOdLuwBj6hmXfRWMOKB7Z7TRa9N++7lPU
	 VDEf4k/dnZSJaCMaRNP0F+gb50LuTdilviyyPa5wN32/76TFTa4aSQS7RWyRSQIRyg
	 vXHZd/h+atdk6JnV2o4zE89Gp2NciojsopHrU6XXAIdYr3SyHMQvUU2pMYNAbn5c/b
	 0aM0vQo/RDwxDMO/xxkGHCRyaV48usq/kCWao2dwrLc0y6+zMZQgkDaKjR7B5hUMkW
	 BlI1Le9qMlCBU8bJX7pFV/6goaIi5V0Agt/CLS6VNLVnha2aBUfk201SAltGzASCeT
	 XdkZq7cOS2uhw==
Date: Mon, 31 Aug 2026 00:44:13 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, 
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Fix request use-after-free in heartbeat()
Message-ID: <apSwfmDiwsuyQT6I@zenone.zhora.eu>
References: <20260808184302.1509585-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808184302.1509585-1-shuangpeng.kernel@gmail.com>

Hi Shuangpeng,

On Sat, Aug 08, 2026 at 02:43:02PM -0400, Shuangpeng Bai wrote:
> heartbeat() detaches engine->heartbeat.systole with xchg() before
> checking whether the request has completed. If the request is complete,
> dropping the detached systole reference may free it. Concurrently,
> idle_pulse() can observe the empty slot and publish a newer request.
> 
> The worker then sees a non-NULL engine->heartbeat.systole, but continues
> to dereference its stale local rq. The newer request can therefore make
> the shared-slot check succeed after the old request has been freed,
> causing use-after-free accesses to emitted_jiffies, submit, and sched.
> 
> If the detached request is incomplete, heartbeat() can also overwrite a
> newer request published by idle_pulse() when it unconditionally restores
> the old pointer.
> 
> Use cmpxchg() both when idle_pulse() publishes a request and when
> heartbeat() restores the detached request. Drop the detached reference
> when restoration loses the race, and reload rq from the shared slot
> before dereferencing it.
> 
> A KASAN-enabled i915 mock selftest reproduces the use-after-free before
> this change and completes without a report after the fix.
> 
> Fixes: bf9bd6a5128a ("drm/i915/gt: Track the most recent pulse for the heartbeat")
> Cc: stable@vger.kernel.org # v5.11+

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Your patch looks correct, although I don't think the Fixes tag
is.  I believe the actual fix is:

Fixes: 4c71fd099513 ("drm/i915/gt: fix refcount underflow in intel_engine_park_heartbeat")
Cc: <stable@vger.kernel.org> # v7.0+

That commit introduced the early xchg() which hides the old
request from idle_pulse() and replaces it with a new one.

I'm going to resend the patch so that it can be picked up by our
CI.

Thanks,
Andi
