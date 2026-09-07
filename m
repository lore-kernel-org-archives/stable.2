Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B874908AE;
	Mon,  7 Sep 2026 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781098; cv=none; b=H/c76kOTsJIBBxORqsjAEH0AIucuKo3tSwDQr4izhNz3q945fJwZjKcqMRkQvHrDEgrEKN2yw37Oz/ZODmv1iklo3XrVRoIlByt9tt2iejgtwA/C8TbwtLb1QNHa0zRWsT5fuy8Vkw2ONipzBlWmcy4rip1jXtTT6OPhDtzhVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781098; c=relaxed/simple;
	bh=CnXwpHC1q5Dwl47V1e3waxTQIpO92ooFkZEOCO8u5Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdGVY+sXXRUUyPaqrIEfejzniTTezczRbgzYzsVbgHgu4ju+aympY5D5rVcH8aC3zIGVI4RiBabVZYaAp7Lba5F7mfFVVY1ldkw41ramK6wPzr2z9SWV6cecvwtyXh+UCR0ZHhIuhPCjZFB7wEFjHj7wH7PQs01mn++RqqHfvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btUUWxGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btUUWxGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360F71F00A3A;
	Mon,  7 Sep 2026 11:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781097;
	bh=P3564N+/UggRtIlRhhqQeOSkfsDttBnG7Wpq0GERNrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=btUUWxGRrKNJU5vvdVeTfFeOAxkXJPi86uNEx2ZqxCL/x9JQkZfMHF57CeZUCOgef
	 Gp6mlR0Vg92utRpHzVt1/WBMkeXB7hOkvZi53MWK1QwbY02hAkr1It2CVpDeYcpaiP
	 3XD9aaJheER5y8YrVlIp/2nEUlzq5fyKz729P4xOmNjgMXBIdSYXtsDayIoDeDGyEB
	 7ZDybqlKJ1LtvnjbRXAMwa5+PcxKTpaJFSnbbUKFY/F14drGDdzQyw5QDz4gHIEufJ
	 vLoJeO2UknvCFhgcfsd4viFI4gReM461DoRu+gnjc9e4bq/lFCuNuT2BYSUnb/r4sg
	 /HiWOh+S7zuEw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3Xfz-00000000ZPs-042h;
	Mon, 07 Sep 2026 13:38:15 +0200
Date: Mon, 7 Sep 2026 13:38:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
Message-ID: <ap6iJ6vkVIaxXFwn@hovoldconsulting.com>
References: <20260907065501.101013-1-johan@kernel.org>
 <e231a7e9-7aa9-40ea-8ac6-57855b4ac811@suse.com>
 <ap56NTVMq8GlbjmR@hovoldconsulting.com>
 <72615ee3-46eb-4639-a408-ba29c1235d08@suse.com>
 <ap6LcHWDvIWF3oNK@hovoldconsulting.com>
 <bc055887-3029-4740-bec5-7e2fe4205992@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc055887-3029-4740-bec5-7e2fe4205992@suse.com>

On Mon, Sep 07, 2026 at 12:28:46PM +0200, Oliver Neukum wrote:
> 
> 
> On 07.09.26 12:01, Johan Hovold wrote:
> > On Mon, Sep 07, 2026 at 11:50:41AM +0200, Oliver Neukum wrote:
> >> On 07.09.26 10:47, Johan Hovold wrote:
> >>> On Mon, Sep 07, 2026 at 10:17:38AM +0200, Oliver Neukum wrote:
> >>>> On 07.09.26 08:55, Johan Hovold wrote:
> 
> [..]
> >>> Looking at the implementation again now, it seems further changes are
> >>> needed to fix the implementation, though. The completion handler should
> >>> not be updating old_count. That's for each TIOCMIWAIT to do.
> >>
> >> I am sorry to be obnoxious about that, but I am afraid that would
> >> break TIOCGICOUNT
> > 
> > Why do you think so? TIOCGICOUNT just returns the current counters.
> 
> Yes, but user space can call TIOCGICOUNT multiple times in sequence
> _without_ calling TIOCMIWAIT in between.
> In that case the counters have to increase if a line changes, don't they?
> For that to happen you need to handle a status change in the completion
> handler.

Yes, the completion handler needs to handle the status change (i.e.
compare new and previous status and increment the counters), but it
shouldn't update any old *icount* structure.

Johan
