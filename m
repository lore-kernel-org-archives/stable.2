Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDF14DA553;
	Mon,  7 Sep 2026 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786218; cv=none; b=dClDJ7QTwVPuXIotl5GzvYwbQ2w2xy3DsWvz6b+m8J5T01hIGBb8NG1Ezhb19NooeCHD7V5NZWNI70UG+fQkoih3Z766PLFjQj9vWSXb/ds0yQkVFhcfoLkdiz7jrOrErHm0du9pfCeNkGTvD0N66xIy/ydRv20cM+oOVX3cdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786218; c=relaxed/simple;
	bh=aZycB+q4lhkgLqpM/RVeDq4AezvDott2SR3rLVIXbKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+zwIl0z6YSgLvKCr7uO5a5YX1g6CoNgf4eECzFD+NcrpwWtAyBIWVLrbbPUj8CLpygEH6vyUq+cSL/GXqfuQtMD9ZPhIRnD0OrZktD9syp0+vsjHF++mrqJIu00qYI8fUNMqZ/1nIFl8w8KQ44dxYbaR3z7Ooa+9Fx70x0JXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChrAGRGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChrAGRGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CE21F00A3A;
	Mon,  7 Sep 2026 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788786212;
	bh=nujNm33sdIJkFZUBSCWeyk+HkoPECKJeitf/M9wPKAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ChrAGRGJX4qsZthP0t8Wm7ysO893ikg9bIajM1S2nkQTg1ZhhcfZ67C1DZA14HRA2
	 +EShC/SCYpWSAdGGvSz4Bwno1SL852IZnEYQluQwxBKQgFDN2soFxZKZMAim+NaBNS
	 YC4oUUsXJYXyI7Rrsc9DZA+unI8a9hZAJeFZiOaQLzJvTpZlI4PdY8FsyE3Ad5WiBg
	 9DX2JnEVdMi2DHauBsSlZCiEVKxO/VXQdai7oCfMtYgqBJ6W4ICUDFQR65fVuH91CA
	 6eJzqf/yVgdueB80d6zCwv+0b9gDwLYHpo0eTDXG0KWCp6i7bZtQcH7L2kaeYWMKQa
	 e/+n1NZxXR/5g==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3Z0T-00000000d9b-3CPz;
	Mon, 07 Sep 2026 15:03:29 +0200
Date: Mon, 7 Sep 2026 15:03:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
Message-ID: <ap62IbbQti28M_SA@hovoldconsulting.com>
References: <20260907065501.101013-1-johan@kernel.org>
 <e231a7e9-7aa9-40ea-8ac6-57855b4ac811@suse.com>
 <ap56NTVMq8GlbjmR@hovoldconsulting.com>
 <72615ee3-46eb-4639-a408-ba29c1235d08@suse.com>
 <ap6LcHWDvIWF3oNK@hovoldconsulting.com>
 <bc055887-3029-4740-bec5-7e2fe4205992@suse.com>
 <ap6iJ6vkVIaxXFwn@hovoldconsulting.com>
 <f642f815-df4f-473b-aaa2-89153c08bc05@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f642f815-df4f-473b-aaa2-89153c08bc05@suse.com>

On Mon, Sep 07, 2026 at 02:46:16PM +0200, Oliver Neukum wrote:
> 
> 
> On 07.09.26 13:38, Johan Hovold wrote:
> > On Mon, Sep 07, 2026 at 12:28:46PM +0200, Oliver Neukum wrote:
> >>
> >>
> >> On 07.09.26 12:01, Johan Hovold wrote:
> >>> On Mon, Sep 07, 2026 at 11:50:41AM +0200, Oliver Neukum wrote:
> 
> >> Yes, but user space can call TIOCGICOUNT multiple times in sequence
> >> _without_ calling TIOCMIWAIT in between.
> >> In that case the counters have to increase if a line changes, don't they?
> >> For that to happen you need to handle a status change in the completion
> >> handler.
> > 
> > Yes, the completion handler needs to handle the status change (i.e.
> > compare new and previous status and increment the counters), but it
> > shouldn't update any old *icount* structure.
> 
> We could do that and it would indeed be simpler.
> 
> But it would change the semantics so that past status changes
> no longer show up in TIOCMIWAIT. Is that really a good idea?

Yes, as the current behaviour is both non-standard and inconsistent.

If you have multiple tasks waiting waiting on status change, then only
one of them will detect it, for example.

And if there are multiple changes (before or during TIOCMIWAIT) events
may be lost too.

Johan
