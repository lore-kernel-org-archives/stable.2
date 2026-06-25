Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947F329367;
	Thu, 25 Jun 2026 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349875; cv=none; b=pl3COeXXyiW8IVlQhFPQYxUFvsG2r/to27eeXDR9Pb3LRPhRHl4NjIoM4ovWn0r51dCIRCv+vVvTABu7jiQ6g9JKWjt8Rbstv6qLoTp+P7xB3OeFdNe+56W/ij1j5Bt82RrJ1RpqHJqpZ/Yl6O59t1dNZo3rF5H1P4dRo8Na2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349875; c=relaxed/simple;
	bh=FpQVkDBv3U8NH319tq/72rHdKEBHTz4w1YkFJsJ4dIA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fx+RUfbzhYbsjDMUnf/xsAbWuYB4zzPYC72yAl1kVJ1jSDxs+FKERo1D95tuV6rnhmyT0FNpkCxU/N+SuCB/gS6IBTla10kmg2GY6LD+fiEa8HKYZoUPtsDjQu9mpqCPE38ps6qn/C7Su4ohNdXqikaHsylafm9htPb1tAsOFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lLYN/qmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lLYN/qmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70371F000E9;
	Thu, 25 Jun 2026 01:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782349874;
	bh=c32tUa5bWarmPzpY6WY+ve3gFalT24aBAWOhjAMBHrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lLYN/qmg2GiBbKcEKeOJcfmRlGTspNtZBFztz+qXgtETQihjuoJhTRahsgMDBnOOn
	 Z6B845m8o5BxM79XKe0ZT1MKzNGSg4k1fXhVBPD1pPdYZ6tkrZDQGoBkAFZztgkmeD
	 rWcK1wMzAGgaptlUHwJfY+QS93gvZSJW00lYAXeY=
Date: Wed, 24 Jun 2026 18:11:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Ingo Molnar
 <mingo@elte.hu>, Dave Hansen <dave@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Tristan Madani
 <tristan@talencesecurity.com>
Subject: Re: [PATCH v2] profiling: don't free prof_cpu_mask on init failure
Message-Id: <20260624181113.8b2aacf9b1466205c8f2cf05@linux-foundation.org>
In-Reply-To: <20260622000022.3375262-1-tristmd@gmail.com>
References: <20260621192324.2062795-1-tristmd@gmail.com>
	<20260622000022.3375262-1-tristmd@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 00:00:22 +0000 Tristan Madani <tristmd@gmail.com> wrote:

> From: Tristan Madani <tristan@talencesecurity.com>
> 
> When profiling is enabled at runtime via /sys/kernel/profiling,
> profile_setup() sets prof_on and profile_init() allocates prof_cpu_mask
> then attempts to allocate prof_buffer. If all prof_buffer allocations
> fail, the error path frees prof_cpu_mask but leaves prof_on set.
> 
> Since profile_tick() runs from timer interrupt context and checks
> cpumask_available(prof_cpu_mask), it can access the freed cpumask
> between the free and the next reboot.
> 
> Remove the free_cpumask_var() call from the error path. The cpumask
> allocation already succeeded and is small; keeping it on this rare
> failure path is harmless.
> 
> ...
>
> --- a/kernel/profile.c
> +++ b/kernel/profile.c
> @@ -123,7 +123,6 @@ int __ref profile_init(void)
>  	if (prof_buffer)
>  		return 0;
>  
> -	free_cpumask_var(prof_cpu_mask);
>  	return -ENOMEM;
>  }

Confused.  Current mainline has no free_cpumask_var() here?

If we're to deliberately leak the mask here then let's have a little
comment explaining the reasoning, so we don't later receive "profiling:
fix memory leak" patches.

