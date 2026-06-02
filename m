Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44579495E5
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390625; cv=none; b=U711WBWcVOaRZ066wZoXhfv9Qs2aDAx+KH0YWMXpes8BjQOROuE6ZXeuwIdJkRpFCA8968JZDLebO7p5iWX/RiI1A4EbD1CuMwCHN5rtLI5e3n2iojX2SMLzPeqrj8GZLV+YYjuFLSBlEKfnS3OvWTcYndcpp5UAWMSAalSSsy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390625; c=relaxed/simple;
	bh=FkM34+achgYf2sQVgLFGgvcU05tTYh64BLEkcfxuspQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SELThwQoY5I9D1CjyMx/jqPgzcxz3T0TSUpM2AZLJN2ZEUvUag0B/MLyNVWboAbp4G8wrFq7BjRJm45B1WMiGk4hiDDcQiwxUjHgV6wCKex0XSXUaAdaKB4Io8F+pdzYQNUiDbnUgQDBwzfq4TMvnAb+AxaG+S8Oqh1BdSQb80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmxNfAfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmxNfAfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED1F1F00893;
	Tue,  2 Jun 2026 08:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390624;
	bh=A5bGGCKK0SAG7oNONyGiKu3RuVwA8SILABzID+g2CFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OmxNfAfA00B6RVFNvLgpFOqPKzP6U+GtC+yXcVjuPtix7FcJPA94F9L4W6PtmM8C7
	 ocZT6q9BPqkDwNquiCPvtxvHzzrVf+DvnflPPERBMULLWV6ZKXHmoowq7N6DdtisoC
	 F8M4oVYrq/RXtQux+gao72ic7+4SyMvXs5b+CsggptZqXtxVbKLrbtrugYwWmYP+Mb
	 VMa/eA30uTyEc1Tl4VKTRHSZSbCbYxpWoY2azOxXCl2prNZVdY9BMpkWFwlDbdNUtz
	 U189FYwq2/X26IrZJJ5skYiDj2jyGa21AUDDPVA+B3x+msffNqaBTB9Poam9wFFGWX
	 25MYhuJva4z7Q==
Date: Tue, 2 Jun 2026 09:56:58 +0100
From: Keith Busch <kbusch@kernel.org>
To: Jeremy Erazo <mendozayt13@gmail.com>
Cc: security@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: nvmet: pre-auth heap OOB read in DH-HMAC-CHAP authentication
 (data->hl unchecked in nvmet_auth_reply)
Message-ID: <ah6a2mdIfZ-aId8r@kbusch-mbp>
References: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
 <ah6ZXmX1anVLrr76@kbusch-mbp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6ZXmX1anVLrr76@kbusch-mbp>

On Tue, Jun 02, 2026 at 09:50:38AM +0100, Keith Busch wrote:
> On Mon, Jun 01, 2026 at 08:32:37PM -0700, Jeremy Erazo wrote:
> >   @@ -119,6 +120,16 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
> >                     __func__, ctrl->cntlid, req->sq->qid,
> >                     data->hl, data->cvalid, dhvlen);
> > 
> >   +        /* Confirm the transferred length actually contains the
> >   +         * rval payload the message body advertises. The host
> >   +         * response is hl bytes; with cvalid set, hl more bytes
> >   +         * of challenge follow; with dhvlen set, dhvlen more
> >   +         * bytes of DH value follow.
> >   +         */
> >   +        if (tl < sizeof(*data) + data->hl +
> >   +                 (data->cvalid ? data->hl : 0) + dhvlen)
> >   +                return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> >   +
> 
> I think the fix should change the ternary condition from data->cvalid to
> (data->cvalid || dhvlen):
> 
>   if (tl < sizeof(*data) + data->hl +
>            ((data->cvalid || dhvlen) ? data->hl : 0) + dhvlen)
>           return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> 
> But this is a bit of an eye-sore, so let's make this easier to read by
> lifting the ternary computation outside the 'if' section and store the
> result in a temporary variable.

Oh wait, this is also a duplicate report:

https://lore.kernel.org/linux-nvme/f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev/
