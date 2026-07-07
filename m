Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20778F39;
	Tue,  7 Jul 2026 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402833; cv=none; b=u7/4GirG/pXcQiBFoXNAFOebs05bo9jXfR+b19RyfSpgeFoh1uK7cLsjsKxU//LZIoG1uO7k1WB7VAap0WsZB730F0FMA0/42R/rgo9FbfGMQV6ufKV6nH6Z1uQ9TKNb7HVejIB7nzN6gcIIsrPiIv+A+uyJwF5v4ycjKLGP5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402833; c=relaxed/simple;
	bh=uubafVnUIfwSUXbsQG5Xy1vrRdrghwYnk8PvsPPHpg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyGYZvTwyK0v5HGkCAfIywGrzpMywYNAk6l0KM7hX1dc1Dgzy/5L9P3QihEFv0Lsa+M0jAynynuVv+fivB+k3a5IpI6VYGIcmoI1YYjcbYjGr36QpstAexysE/I/hOU/8cygm3leWHMRE0yTouqUkjw2WaIjF9f8WfFZbrGLBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFC0juX1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFC0juX1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 49DF31F000E9;
	Tue,  7 Jul 2026 05:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783402832;
	bh=xP+xYI1ctWvYVNjrW0wq1G2Ka2f+jdpaaUgD9EtHysI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lFC0juX17kd/Il+GWfVvFIlbok0okzgPDT/Mm76by/fs9HdnQmLNfSLXcshiI5cJA
	 B7B4Arf1UU260X2ne25fXSVsRm+Nesh7mCm9pzi5k0dYyx6oBeMllv4S5y9DezlzI4
	 Gzf2OWoiZTalTVQks4WjeyhOuBFWjvds0UwigJaC5ONDWVi/EWMMMV3w9ju2h8Zj1o
	 SR20TOC12lojNSr+0nMDbPO23kAasB1OWlQfjZNsMRwgAJiSeJE9IYVV4aHQHhhL2q
	 +I83SfQle+0m76aBLUwjZNGnvu/DTNkxq0SL+6ItydFIxp3YQ2vBBzhWaOVWo6pe7e
	 mYQbycrq/YKeA==
Date: Mon, 6 Jul 2026 22:40:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Xiang Mei <xmei5@asu.edu>, Bernd Schubert <bernd@bsbernd.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Luis Henriques <luis@igalia.com>, Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fuse: copy request headers via a stack buffer for
 io-uring
Message-ID: <20260707054031.GF9381@frogsfrogsfrogs>
References: <20260706191309.2887515-1-xmei5@asu.edu>
 <CAJnrk1Z-6ezCKAEicOEoFVJfhg6Es6R+E=iH4HepmwrpBiETdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z-6ezCKAEicOEoFVJfhg6Es6R+E=iH4HepmwrpBiETdw@mail.gmail.com>

On Mon, Jul 06, 2026 at 02:17:12PM -0700, Joanne Koong wrote:
> On Mon, Jul 6, 2026 at 12:13 PM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > The fuse-io-uring transport copies req->in.h out to the ring in
> > fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> > Both headers live inside the fuse_request slab object, whose cache
> > (fuse_req_cachep) is created without a usercopy whitelist, so copying
> > them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> > panics:
> >
> >   usercopy: Kernel memory exposure attempt detected from SLUB object
> >   'fuse_request' (offset 56, size 40)!
> >   kernel BUG at mm/usercopy.c:102!
> >   RIP: 0010:usercopy_abort+0x6c/0x80
> >   Call Trace:
> >    __check_heap_object
> >    __check_object_size
> >    copy_header_to_ring          fs/fuse/dev_uring.c:618
> >    fuse_uring_prepare_send
> >    fuse_uring_send_in_task
> >    ...
> >    __do_sys_io_uring_enter
> >    entry_SYSCALL_64_after_hwframe
> >
> > Bounce both headers through an on-stack copy so the usercopy touches
> > stack memory, not the slab object.
> >
> > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> 
> I think the cc stable@vger.kernel.org tag is missing here. I added
> stable@ to the cc list on this email, but I'm not sure if they require
> the tag being explicitly in the commit message to get it backported.

I used to like it for XFS once upon a time when we did manual reviews
and QA of LTS branches, because it was a headsup for something that I
should actually watch to make sure it actually showed up in stable-rc.

--D
