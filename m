Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AAD5013CF;
	Tue, 13 Oct 2026 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901755; cv=none; b=NkU+TQp0l7q5WFp8n738e6TTJhLSRNXMvu+jFUwQrYzc91LDruECa/JxbzB9W8FBaHlHrXYE9P5DzwXT0mk4Q31964an6n03pyHNSGnxSV97jCKCgXef9uinuX1lQ5bet+er55q0ISNyDKKHCgoFKQfQQTZX2ak49bR2Qjh5WYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901755; c=relaxed/simple;
	bh=P93fSh0QV+x7N2O+SUxX0JdIQZu0u771iYJI0nnvIRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOdL/wFHlnsOkE0Qpsv8KwW9jD06N3vexQ/MALHguxQQ9IzytX9UUUc5CFz8M5E4SjZxSxUid2yapnX/SHW/wMX0GXhXlG2lMqOyqCXSX6IC0YB34zmfG03mL5pSRS5XhpyZuOQNpWGol/kX83kmZa2Udt5WRSFk8SvYh3XJkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUxB4Wpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUxB4Wpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AE91F000FF;
	Tue, 13 Oct 2026 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901753;
	bh=7qKNMiH2w4gu5NE5Ep8GYbNYJWZz1S3YluBpBbHkntE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LUxB4Wpy4M0NA/auUkF3ugzHwzl9yI2Akd18tG6e7Wd+FVpo90FHoQkUmsjoQ/CZ2
	 47peU4JJ7n84TwVTZASc2hIZ/h6OQcE2VP1/G6MGlMPX7WOM5E4NhtGonekT2SkXTa
	 Qku9hWMU1SUQBG3UKn33NnZ6lMWsvhSV/SkGi++l/LCHLkmqGAev1nHip9ImhXkScT
	 ZnyBGlx5fLgOuTbOwAVTpLlpHSqlKtNv2DtqwnTw7PidO8LFLEJi4xvLhGK7AxH68x
	 9BI98yhjX34QdpVDlC012GsUwaPtRA2Y+Kp3PdC0Tm3amFXF+Q55wdEwtRGUVBNjSE
	 IPmaM1qdncb3Q==
Date: Tue, 13 Oct 2026 15:29:11 +0100
From: Harry Yoo <harry@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: sample slab_state once in kmem_cache_destroy()
Message-ID: <as4q2WlR7mLhMBpG@thinkstation>
References: <20260930195110.13296-1-kaloz@kernel.org>
 <ar5pESlkEMqNsgxv@thinkstation>
 <aef97b97-0bd7-d720-7f59-8c0078747370@kernel.org>
 <as4QhUscRVtBzYpm@thinkstation>
 <481e9a16-cd30-d463-14ee-b5602bcd5a21@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <481e9a16-cd30-d463-14ee-b5602bcd5a21@kernel.org>

On Tue, Oct 13, 2026 at 02:51:30PM +0200, Imre Kaloz wrote:
> Hi Harry,

Hi Imre,

> On Tue, 13 Oct 2026, Harry Yoo wrote:
> 
> > Uh, apologies for the late reply.
> > Catching up after trip at LPC...
> 
> No worries, hope LPC was good!

Thanks. It was good.

> > On Thu, Oct 01, 2026 at 05:42:36PM +0200, Imre Kaloz wrote:
> 
> <snip>
> 
> > > There is a related older window: after list_del() and before that
> > > single read, slab_sysfs_init() could set FULL, skip this cache, and
> > > the single read would then call both unlink and release on an
> > > uninitialized kobject.
> > 
> > No, with this patch slab_sysfs_init() cannot set the state to FULL
> > because the slab_caches list and slab_state are protected by slab_mutex.
> > 
> > > I have not hit that, and this patch does not close it.
> > 
> > I think the patch does close two bugs.
> > 
> > One introduced by 4ec10268ed98 (reading slab_state twice),
> > another (reading slab_state outside slab_mutex) introduced by, hmm,
> > not sure which commit introduced it :) should be very old.
> 
> You're right, I got that one wrong. Sampling under slab_mutex in the
> same section as the list_del() means slab_late_init() either sees the
> cache on the list or we see slab_state < FULL, so the older window is
> closed too.
> 
> As for where the outside-mutex read came from, as far as I can tell it's
> 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy()
> without holding slab_mutex/cpu_hotplug_lock"). Before that, the unlink
> and release and their slab_state checks ran in shutdown_cache() under
> slab_mutex.

0495e337b703 Probably yes. Not 100% sure.

It's quite messy, reading slab_state has been done inside, switched
to outside, and back to inside, and so on.

But should be fine as long as we can find the first commit that
affects -stable kernels (>= 5.10.y)

> SLAB_TYPESAFE_BY_RCU caches were already released from the
> workfn outside the mutex since 657dc2f97220.
> 
> Want me to send a v2 with a second Fixes: for 0495e337b703, or is it
> fine to add it when applying?

Could you please verify fixing which bugs resolves the issue on sparc64
described in the changelog? Reading it twice, or outside slab_mutex, or
both?

-- 
Cheers,
Harry / Hyeonggon
