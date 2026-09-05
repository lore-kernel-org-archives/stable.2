Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE73B994A;
	Sat,  5 Sep 2026 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634943; cv=none; b=seROcBMFkBdMIYOsbxmt0AqL83NSHI+zmDznt/Hh+qTMmk1HiAFUDtt3znLhj3o07x++AlyoB8xc1CoOF833FqA6q+zXbx5vYhvwBX5D2+a6vusgtCAePJdMDkB0nA9dw7r+0ix8h9rjhjZGO8dQjfVxaBkrBsfnVRAh8g76bQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634943; c=relaxed/simple;
	bh=0Vt1CxIWa3xf7zF0GUYRtISlccsSkXlDxhyroxC/qZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpwGdP6D3NshLx3LfVjaDNXRUMFdFgioaG40Jj78q89MdsGXFt6S3u2gPmqy7N+mcjyv3T+rL/mA47D8XZRg/jULjQLduQsukfPAZNguqKTOzPumuCUHHRSKPyeC9Ce9Nmjv0o+e/MWxN6mgAaPkxEByEBhF4lRIB2EvXr0aryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP+AT1oq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP+AT1oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D2C1F00A3A;
	Sat,  5 Sep 2026 19:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788634941;
	bh=3IFWBkpwt0DglCJ3/MwQDW/O3Cn5kGPmagAF2kfRUj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GP+AT1oq7qVonqXJI/yx6FqzXulAvrqUmCCAoz/El9ASH3nQxk8XfFbcSo9fB8maz
	 p42HmiM6Mx8ZWHOoIKyeutET2LBSoMoQRoWL1oEkTktiwAQRWrE3LqKmFY0eCrSPR9
	 eUNtAkeGmEFMSHkwR3dcetmyO1Ropwwxzkt4wOIrluc4RR6gTwzEfFIVGU/4xaNKqg
	 wI0MzUTFxwuKiymuLdpkddcw0OkSPdCw1hVqGXyYwR2//KOc8Tel/E1/UY7tYEZvFa
	 grAjPRDkQYa+ikmm4Gx3/eF0MNgEJDpaB3Qc/fdQGmbHAp6efSzQm5L3qix1cdlUSE
	 c34XjApZFbg9w==
Date: Sat, 5 Sep 2026 20:02:17 +0100
From: Simon Horman <horms@kernel.org>
To: zihan xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xemul@parallels.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] udp: diag: bound bucket lock hold time
Message-ID: <20260905190217.GE40544@horms.kernel.org>
References: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
 <20260905151227.75099-1-horms@kernel.org>
 <CAANe3eRpVGnYpygfiQTsXd2VmBO43P-P1RfREkdDypgXBZB9Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAANe3eRpVGnYpygfiQTsXd2VmBO43P-P1RfREkdDypgXBZB9Uw@mail.gmail.com>

On Sat, Sep 05, 2026 at 11:49:05PM +0800, zihan xi wrote:
> On Sat, Sep 5, 2026 at 11:12 PM Simon Horman <horms@kernel.org> wrote:
> >
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev/#/patchset/133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai?part=1
> > ---
> > udp: diag: bound bucket lock hold time
> >
> > This patch limits the time the UDP hash bucket spinlock is held during
> > netlink socket dumps by collecting a bounded batch of matching sockets.
> > It takes a reference to each socket, releases the lock, processes the
> > batch, and resumes from a preserved cursor.
> >
> > > diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
> > > index f4b24e628cf8d..18cfe0df654dd 100644
> > > --- a/net/ipv4/udp_diag.c
> > > +++ b/net/ipv4/udp_diag.c
> > [ ... ]
> > > +static void udp_diag_dump_done(struct netlink_callback *cb)
> > > +{
> > > +     struct inet_diag_dump_data *cb_data = cb->data;
> > > +     struct sock *sk = (struct sock *)cb->args[2];
> > > +
> > > +     if (sk) {
> > > +             cb->args[2] = 0;
> > > +             sock_put(sk);
> > > +     }
> > > +     cb_data->dump_done = NULL;
> > > +     module_put(THIS_MODULE);
> > > +}
> >
> > [Severity: High]
> > Does this module_put() introduce a race condition with module unloading?
> >
> > When an active netlink dump for UDP sockets finishes, inet_diag_dump_done()
> > invokes udp_diag_dump_done(). This function drops its module reference using
> > module_put(THIS_MODULE) as its final step.
> >
> > If this was the last reference, a concurrent rmmod udp_diag operation can
> > proceed and unmap the module's text segment before the thread executing
> > udp_diag_dump_done() executes its return instruction to return to inet_diag.
> >
> > Could this result in a kernel panic due to the CPU attempting to execute
> > unmapped memory?
> 
> Yes.  If that module_put() drops the last reference, rmmod can unmap
> udp_diag while dump_done() is still returning to inet_diag.
> 
> I will keep the extra module_get() in udp_diag_dump(), and move the
> matching module_put() into inet_diag_dump_done() so it runs after the
> callback has returned.

I think that the fundamental problem here is that managing module lifecycle
from within the module itself tends to be unsafe. I'm not sure your
proposal addresses that problem.

I think one possible solution is to move the module_put into delayed work.
And another, is to move module lifecycle handling into the core.

Possibly the first option is cleaner as I think that only udp_diag
has the need for this.

