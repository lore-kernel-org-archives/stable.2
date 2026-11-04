Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836112;
	b=oFysri2e3OAaFa7VkxKw/AA8vfpcBpFIAvGarHaplCw7udmv5mUbE1UgKd4z4eFSN4ek
	 oaJ/E4MMhZR2Juuguz71Xe61c+0fS/HycLFPKyLlaPyVovVtMSaaEpvKLjwOAoxsPa+A3
	 MA1SJOo9/tcCxuP+p4ZXvWLkJ5pWJcP2HcvXanQUts+OnC2bDQTcY66xv84c6KEB1m7r2
	 I/pBuxqgHW8FsHLYeEpXfaxzI5k6d6mlhxsZ3CXgZ9bTV9q2Xub7cYPQyAHD+ysYJE2M6
	 1BVdiPwcLGbk5A1ZCLL/nN5Sy1BByycjTVthZC0fZtOXMndqKzJhnBot+YEtBAPxCGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836112;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jLVIRJ1oNydBd8biicts5vct+iiNk9BFRv+VtPv5AgI=;
	b=wt1iUw3m4ML1ldz7lJnUQa2Dis13h/WJy302VOZ+YQG6tRDDBvj0hgbgyImJU2Sov82/
	 lC1EooS+gj2ZUIicZlM/TVygMtbIJcc82M+i3aema72Y+FzePLbGlZJQPIgAxcIcLYrFw
	 wlufFFL10QorrkwRSgObi2pPuEd1bcCsvBHWSIfgIOOJIb9ZgY0WUHz/y2cQ/o8QHJXx6
	 4sovWHFuJkstrtg/R8c7Tl68OQFortOmrCUhb7NnDltXx7YIYgJIVI2XcX8Ry8kUPQ7F6
	 qoDEZhvaTDn4l6jabeXOr+Mg9msSQmyvzw81tcCErAQxxcMWftizV4v4JlKYG9WCuMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oac7osK6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 44226606A31B;
	Wed,  4 Nov 2026 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oac7osK6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9646B1F000C1;
	Wed,  4 Nov 2026 23:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836112;
	bh=jLVIRJ1oNydBd8biicts5vct+iiNk9BFRv+VtPv5AgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Oac7osK6wKEvSA9uXr9NkmREaRoznEJucas6/qO91klzhIbVtSWzY3hcojw79o7Ah
	 67h9zLk6K1AYpIlvyyYM0ohbwQNicvpbw+qgWvmbneWzAEirKbSQ7WiAfeUGBoaHdf
	 61aS0HEYOzLOUx9HpcpDorRj/32SLJb9elvwRaCSuuc+TpuS10GCIjl036Hx6O8QB5
	 0/xddQibsa2PoSMRQTBlNQTbRcpSy1hQNu7C7zh84xQKPOSFY4BgyymjV5Ffjftwcj
	 he7ChfHGXWXUuhJe6clS8RK8jl+R2hPs/NaTefGO/XZBVgZTAIbTSPE19n744Ono/K
	 SVWDgEuODyblg==
Date: Thu, 5 Nov 2026 01:48:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call
 to nvme_tls_key_lookup()
Message-ID: <auvETMCZNpqJOX8L@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <20261103053303.GA1382@lst.de>
 <aunTlxXbRJ6ZP63h@kernel.org>
 <20261104090440.GA30968@lst.de>
 <autEfTlEWj_OrtB5@kernel.org>
 <autU4LYsgtOy-Ywj@kbusch-mbp>
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
In-Reply-To: <autU4LYsgtOy-Ywj@kbusch-mbp>

On Wed, Nov 04, 2026 at 08:53:04AM -0700, Keith Busch wrote:
> On Wed, Nov 04, 2026 at 04:43:09PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Nov 04, 2026 at 10:04:40AM +0100, Christoph Hellwig wrote:
> > > On Tue, Nov 03, 2026 at 02:29:11PM +0200, Jarkko Sakkinen wrote:
> > > > And essentially what I would want is key_type_dead not to exist.
> > > > 
> > > > This version is based on module pinning, and  thus not having that
> > > > key_put() would keep key type module alive in that case. However, it
> > > > turned out this approach will not fly as AF_RXRPC and DNS resolver will
> > > > hit the wall given e.g., the remote pinnings.
> > > > 
> > > > The approach I'm going for next is to have a type registry instead,
> > > > which is independent of the module system (to put story really short).
> > > > I think I'm doing this with right process as this really needs a few
> > > > trials in order to find patterns that stick.
> > > 
> > > So what's the plan here.  Should we merge this standalone as a fix,
> > > or are you trying to get an entire series in?
> > > 
> > > If it's useful as a standalone fix, please resend it standalone.
> > 
> > I'll send this as a standalone patch.
> 
> I can just apply it as-is unless you plan to make any change from what
> was submitted. Just future reference that the intention wasn't clear
> when a series' recipients are split up this way.

Yeah, I 100% agree with this.

Br, Jarkko
