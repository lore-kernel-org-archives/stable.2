Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157394E3EF6
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774142; cv=none; b=gGlFU2m3aszj6jbH2hGi+d0qotQJyZvL3Y600JNX2lNb6gP+HLuqyF+vp/Dw0AKiBVzNChxoa0UT0vmjFR4bW8OhvWCQl8IrY3C5SmUJ+UrDtDK3stRLjKCYJ3P/9HUJYMH7M92gI9S0UXxxfCiZsYzUR9VTX21TNfTWWXJcI1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774142; c=relaxed/simple;
	bh=HnVGbpo+3kMEeA6JVeKhfJhNQpM8+hvu72gG5fxEHbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUzuJ0A6YvNPncUhGd3e9C2zIu9mhoYqVxdG+kdfSJXsiMYyzRgiZ2BzdA4tIqBXmPG/wX7UXDULw8y2dlgHhlpKHZ10yisf4dT9RStl/ilh77dUqJBZ45fvG6Eeh8f31iOreD5SgUwWYWwNK9IxPOqXImzUrLJuwkxfBgND50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=CiuUoYDv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UdwmvvTF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="CiuUoYDv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UdwmvvTF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7265A1D00670;
	Wed, 30 Sep 2026 09:15:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 30 Sep 2026 09:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790774129; x=1790860529; bh=hkPK3m7pXC
	DkMYqjfxE1l/+oAJ9bbsdmHRk12Z7gXeA=; b=CiuUoYDv/IXuwPcutpc7llPUpR
	aG9/0JAdixWQbtPYVLRP20Jp8p74RVeDgHk0AeBZDUYTN04F6n8hqnIhDGskzZzK
	9eHtfAyTlAaggaNlQJGk1oLTA6hg/w4ArPpsT80VCBwBI2gisraEQmad5hebZJUh
	Du6pymnRdc+W8fS5Jq+K9VMBQoW7dmIvfi1x6aWio2Ki767SVKVe42gG2bc7x0r1
	fIjZDB8nSWpvjS5jPil0CxMhTI5iJA7AxKu2DxNyzTr75WGkdzVr0doLmBGqUq9J
	LbTQDD44FIPq9yGwOUgOK2bUWL7Q5NklhAA3CNCdl0pKk4HR18esu+LK0Tfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790774129; x=1790860529; bh=hkPK3m7pXCDkMYqjfxE1l/+oAJ9bbsdmHRk
	12Z7gXeA=; b=UdwmvvTFJ56EbS6jCq+ZTNHNp/iz7TTTKEOSPXVIZElt5Q8fEq/
	cI+0MTY1JFUvLNTiS6h6hK25egppe2coQCTMxUJ4ZbTUpM7Qm0njorkYiDHcZoF5
	oimwWy6nIyI9xe+S83u+Lk5b+KZY6j56nQAzgeO1UVEDlG+l8lcmLGVzEGtZjCAw
	2cMQeaBdGcalctkPpkjq8GdF6Zlvc6Q0r9Cn7ve9amNj3Icv6ba6XJltcDvBQy9J
	0hvpgx0jbEDdh0Z8Z8rX0ThDUSYVYM/EhuT9h/t7JiE5l8L6c1WR2M7n1yWKhFsg
	lMk0WXHzAabYxgov9vVe+lelk9nIilVrHOg==
X-ME-Sender: <xms:cQu9apkZFWPApcQJyWKNG24mSXfpkU_KPIglVUwC8O_Q1ph-ReMK4A>
    <xme:cQu9an5dfJzqlvM6sOAX71SEsGgY9Hqrx1oQa6HEkjdMjfNmbiXkHF57qiqiNp25F
    f-TzHRESPOEWqv_BkS9-JOIU5L32xzU_ax5uL-Syu7ENga4xBU>
X-ME-Received: <xmr:cQu9aqTaOC2H7BAgN-Gzw7Yo8a2Q0hcGYPe_sodUPhQG1uWaz0QSGDEK1dfMSP6N961lHWSkok7vMPsF7GIpUcClNlH4wRk-KBd0u8DjMcQ>
X-ME-Proxy-Cause: dmFkZTGlO2KoPATaGOIK6QemKSBISYyVBONLLF6dBuqfhG7hu83Z2GA7kcljZrnAWaRngQ
    cAanCJ8ghl/S9chzLmeBly7mrdd1U1EWuQlHiSul3+yk1HN6UCaMx7zhVHRVx7txQbflci
    o5A/334LJPC6XApnNyX7vEyTFSQvUyKq3igObVTWJ1LCo8ZiCAJuR8dSQDI3UGeObFBaCL
    jRGBDfvDFV49vNb8mSDdDzl7HIMhx5CVOkry+PeJUHAIoPO5JxjmVPya4tPeUEAM5ju3tc
    IwuN6sU0cL8E3a2vjPzDmr9Z4HHtSPugTikA0QIbsLA3V+D4wNTuf0uGFaEypuP2JHviMD
    dDkW3EFBlDQQMdmKxLDHY5O2MORFdNblS/tmkYWy1kDpyB5WaydOYHTfKJrf2wTpbbg4P5
    5y3whHunZuEwNX9USthw34Cs7YgVnqlj0OMjmCpEqV62rA4hyfQK/XkRwvc06t19RbwUrZ
    BtAp0JHcbTTyy07/kkDhQqE4PHx5oUTPHEF1y3oyyZH4LDnU8xPSBQR9QCkD+gNePW0CZE
    4SY5nyDgp7zvU27KFI3KiNTJx+Sf6n03Zykb8/c2P44alPot/l77wdKum7EcCQXQhYI9Se
    o1Cut5w0ZKlmtMcIg3hMM1CGw0Byu9uoYOeQD0vcZV9QHu0KpGcNjuhVvgdw
X-ME-Proxy: <xmx:cQu9alzn1vWBEXnbS8UVe-ieRqyEkFXsm49Jm70EDHLcqyDNtM9nMQ>
    <xmx:cQu9aiqT7WSo8ERM1v61QVBhonxe9eIBSjclTmRIY6hybS5U6ZdfXg>
    <xmx:cQu9ao11iUQi0_nWFYfLKQzeRQSieeIGDpanJDwZwsNeF48N-oaOaQ>
    <xmx:cQu9aix9mttWYlt7HfjOTqlTV4un0iMdL0h69_z1YTYIenvqdeoWbg>
    <xmx:cQu9ajqWbDIaYed7J9XIIvIMrQEI0LLPVtFVOMgWemRPAioQFaGi0nEG>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:15:28 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:15:23 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y 3/3] mm/damon/core: fix unconditionally skip last
 region
Message-ID: <2026093017-epileptic-egging-dc83@gregkh>
References: <2026092948-agency-overhand-3fd1@gregkh>
 <20260930023401.3420697-1-sashal@kernel.org>
 <20260930023401.3420697-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930023401.3420697-3-sashal@kernel.org>

On Tue, Sep 29, 2026 at 10:34:01PM -0400, Sasha Levin wrote:
> From: Liew Rui Yan <aethernet65535@gmail.com>
> 
> [ Upstream commit b3723b596b548c837a766aae3553c14a7b15af2b ]
> 
> Once quota set, the charge_{target,addr}_from unconditionally skips and
> resets at the last region of the tracked target, so the last region can be
> skipped even when it has not been processed.
> 
> Example:
> 
>     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
>     2. Quota is configured to process only 100 bytes per window.
>     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
>        addr}_from is saved at (Target, 100).
>     4. Window 2: The loop reaches R2.  Because R2 is
>        damon_last_region(t), the old code unconditionally returns true,
>        skipping R2 entirely and resetting the charge_{target,addr}_from.
> 
>     Result: R2 is permanently skipped even though it has never been
>     processed.
> 
> However, it is important to note that this is a very minor issue.  This is
> because it is triggered only when the previous window saved/kept
> charge_{target,addr}_from, and in the next window, all regions except the
> last region were skipped by damos_skip_charged_region().
> 
> Fix this by only resetting the charge_{target,addr}_from when last region
> is reached, only skipping when it is applied or cannot split.
> 
> Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
> Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org> # v5.16.x
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/damon/core.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 53d479da2007e..2a24e817e5360 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1325,36 +1325,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
>  {
>  	struct damos_quota *quota = &s->quota;
>  	unsigned long sz_to_skip;
> +	bool skip = false;
>  
>  	/* Skip previously charged regions */
>  	if (quota->charge_target_from) {
>  		if (t != quota->charge_target_from)
>  			return true;
> -		if (r == damon_last_region(t)) {
> -			quota->charge_target_from = NULL;
> -			quota->charge_addr_from = 0;
> -			return true;
> -		}
>  		if (quota->charge_addr_from &&
> -				r->ar.end <= quota->charge_addr_from)
> -			return true;
> +				r->ar.end <= quota->charge_addr_from) {
> +			skip = true;
> +			goto out;
> +		}
>  
>  		if (quota->charge_addr_from && r->ar.start <
>  				quota->charge_addr_from) {
>  			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
>  					r->ar.start, min_region_sz);
>  			if (!sz_to_skip) {
> -				if (damon_sz_region(r) <= min_region_sz)
> -					return true;
> +				if (damon_sz_region(r) <= min_region_sz) {
> +					skip = true;
> +					goto out;
> +				}
>  				sz_to_skip = min_region_sz;
>  			}
>  			damon_split_region_at(t, r, sz_to_skip);
> -			return true;
> +			skip = true;
>  		}
> +	}
> +out:
> +	if (r == damon_last_region(t)) {
>  		quota->charge_target_from = NULL;
>  		quota->charge_addr_from = 0;
>  	}
> -	return false;
> +	return skip;
>  }
>  
>  static void damos_update_stat(struct damos *s,
> -- 
> 2.53.0
> 
> 

Did not apply :(
