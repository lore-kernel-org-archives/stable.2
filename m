Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5433976A0;
	Tue,  8 Sep 2026 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851559; cv=none; b=j96jDICV+vk2M9vpwMSOfP3bl4mS0wacUh8BkvvVZiarp6loNO0CQI2fh9H9K9VtLPvjhGto/xXCgx0XUsBmQ2766x2LcQooYTyd83jQKHzQLLZU/cijY7ZhV45dItR6KgDe6L2XsdcMl3Jya4H2u7JGarFCWMKqr7XbMmCTJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851559; c=relaxed/simple;
	bh=ojfz3BK3cNv9WyccRjmIJwIzaZLN1JEefzj2ybT4g2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gReDQvXyo5o8YRx7kEl6pG2w8W2DQ865SLVmlyNRY6KaBCNmj7/udJ7sY85kQujJSAfzWdsg9Q/SiUFrMsfHriwHgYOpgjwmreoKI23vkms2vRUMNpF/YvpBwhS8wi9GFyOJYOiuLta7aoDSdXq1BBNCTRHRwbewDBXZa8ZGClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtAVcMiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtAVcMiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730BF1F00A3A;
	Tue,  8 Sep 2026 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851558;
	bh=5p31lc4Tvv+4APqA53+22S0thee+C1JMA0AUVb8nGPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NtAVcMiQH+lDPgQbi/TsBORUbxXF5mRQDKZAWt4VIuYo0eCni2nqpamj6OxYAJVUY
	 N9ER8mVu1wRUkx8hI0+OeY4IAdVF2NaSFafwBRryiezJLM5BYrc5/Mx0uIWs2eoc3o
	 D1oVcUo2tWTToFuiuC5/b47wLBC6WfA1XWbOYyDFaizdms1dOtd3T3A/RUQH+/FnI2
	 xtt430Z72Q2Xu7m6U8TvEL1E01bqd8P8ylAnR6bBlAH4/AW/K/O1Fub1yDfrX6q4ho
	 C57I69HCKiELXHtbo7TBGIPVcgLV1KbDceKvegKVWMZ+//pWGqxB3knLKc7VbBKMHe
	 JgOlWIf/YMSCQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3q0R-00000000sZE-423a;
	Tue, 08 Sep 2026 09:12:35 +0200
Date: Tue, 8 Sep 2026 09:12:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
Message-ID: <ap-1YzIoyYsH_3V-@hovoldconsulting.com>
References: <20260907065501.101013-1-johan@kernel.org>
 <e231a7e9-7aa9-40ea-8ac6-57855b4ac811@suse.com>
 <ap56NTVMq8GlbjmR@hovoldconsulting.com>
 <72615ee3-46eb-4639-a408-ba29c1235d08@suse.com>
 <ap6LcHWDvIWF3oNK@hovoldconsulting.com>
 <bc055887-3029-4740-bec5-7e2fe4205992@suse.com>
 <ap6iJ6vkVIaxXFwn@hovoldconsulting.com>
 <f642f815-df4f-473b-aaa2-89153c08bc05@suse.com>
 <ap62IbbQti28M_SA@hovoldconsulting.com>
 <a9db0fce-2a2d-4896-a3c3-2afff4080168@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9db0fce-2a2d-4896-a3c3-2afff4080168@suse.com>

On Tue, Sep 08, 2026 at 08:54:36AM +0200, Oliver Neukum wrote:
> 
> 
> On 07.09.26 15:03, Johan Hovold wrote:
> > On Mon, Sep 07, 2026 at 02:46:16PM +0200, Oliver Neukum wrote:
> >>
> 
> >> We could do that and it would indeed be simpler.
> >>
> >> But it would change the semantics so that past status changes
> >> no longer show up in TIOCMIWAIT. Is that really a good idea?
> > 
> > Yes, as the current behaviour is both non-standard and inconsistent.
> > 
> > If you have multiple tasks waiting waiting on status change, then only
> > one of them will detect it, for example.
> > 
> > And if there are multiple changes (before or during TIOCMIWAIT) events
> > may be lost too.
> 
> Very well. Ample reasons. Do you have a patch or do you want me to fix it?

I sent a v2 yesterday that should take care of it all:

	https://lore.kernel.org/all/20260907095130.130636-1-johan@kernel.org/

Johan
