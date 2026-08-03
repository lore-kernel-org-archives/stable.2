Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853193B42CD;
	Mon,  3 Aug 2026 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746524; cv=none; b=HgsnMVXPx3ixMzCHVWO78ac5stRApn9M+QbGWfjlLQtLubD6LJb5rlsD0Loas7L9FVVm/IHQchogEPdHN8YoWUoDkUdohWeVyTTyKHo+rTnf8W9u3u+ALfHBQzbZyyzl0qgQfIIqrkr8A1QQtdz6GHOTl8vMT0kuLlO4/dkAGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746524; c=relaxed/simple;
	bh=AAmPH4AFTnSwsOZoxTqdCqduB2kcebf3tQWBS4gCNMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reduDe64+D3AEoNkO1hFmbpQ/Davi1gDSlXwLFdcE8bHFYel59JJdi96IAgCFLHLm+oKqQZup9XeRXqRX9V171XyylcZ0RVjbt0qaECSn54wSf0gVDIWgQkbHEyVeP/pF9hephjZaPOlswOOOM+GY92/mAGE3xNZUsuwT28Q0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUXJtip9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUXJtip9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC181F00A3A;
	Mon,  3 Aug 2026 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785746523;
	bh=keLCU7WQK3zBMIhP1foWN89TjNNLSy9Gap6tFdyl+AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cUXJtip9YBUW764F+VRZxrDxJVSnguZ6ciIRUm9T9fWAmH32vG1RANmQt2AvNfcNW
	 1npUkf+cYb9NTaycdr5xE+9JgNfJ28gutrmZnoHy4crZeCZi3Qzail6hfMsJHzginD
	 hpT3zYoJKYPAi5A6YWvUKte5BwRO1XFJf2+nVmYRUTqqB+75c3wiBC+LCWSAck6a0a
	 1r1hrvtmSxFyAg0WtDuMmwhiKB6aHOilg5OR6REnK5swZP1spdDTWfD8y7GhndixMi
	 zPwdnginWDnMU3whZXJsfw6C+w+P6NcXD4ZWqK+8gAPBmuH490pJ/GpNzvgAezgZHi
	 RmDI31BDKW5jw==
Date: Mon, 3 Aug 2026 10:42:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	maciej.fijalkowski@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] veth: fix skb length accounting after XDP
 frag adjustment
Message-ID: <anBUWIxmURvbr04i@lore-desk>
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-3-sun.jian.kdev@gmail.com>
 <80687d9c-9c27-494c-b3f2-efd0230b1895@gmail.com>
 <CABFUUZGTJptpOKKAeU3ThibmPpXize4Eud2=EBX-vqaX3YH4pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YM0lzDBH++kuull8"
Content-Disposition: inline
In-Reply-To: <CABFUUZGTJptpOKKAeU3ThibmPpXize4Eud2=EBX-vqaX3YH4pg@mail.gmail.com>

--YM0lzDBH++kuull8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Aug 1, 2026 at 12:14=E2=80=AFAM Mohsin Bashir <mohsin.bashr@gmail=
=2Ecom> wrote:
> >
> >
> >
> > On 7/30/26 8:23 PM, Sun Jian wrote:
> > > veth exposes non-linear skb fragments through an xdp_buff. If an XDP
> > > program adjusts the fragment area, veth_xdp_rcv_skb() copies
> > > xdp_frags_size back to skb->data_len but leaves skb->len containing t=
he
> > > old fragment contribution.
> > >
> > > After a fragment shrink, this makes skb_headlen() larger than the act=
ual
> > > linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> > > copied 1024 bytes past the actual linear tail to userspace, starting =
at
> > > struct skb_shared_info. The copied bytes included the affected skb's
> > > nr_frags, xdp_frags_size and a kernel pointer from
> > > skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> > > amount and truncated at the end.
> > >
> > > Subtract the old data_len before replacing it and add the new data_len
> > > afterwards, keeping skb->len and skb->data_len synchronized.
> > >
> > > The fragment accounting must run before the linear tail adjustment:
> > > when bpf_xdp_adjust_tail() shrinks the packet into the linear area it
> > > releases all fragments, and __skb_put() requires skb->data_len =3D=3D=
 0
> > > by that point.
> > >
> > > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened=
 by
> > > 1024 bytes from its fragment area. Before the fix, all 10 runs produc=
ed
> > > corrupted payloads. After the fix, all 10 runs matched the expected
> > > payload exactly.
> > >
> > > Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accep=
t non-linear skb")
> > > Cc: stable@vger.kernel.org
> > > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > > ---
> > >   drivers/net/veth.c | 23 +++++++++++++++--------
> > >   1 file changed, 15 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > index 00e34afd858e..348391e87e14 100644
> > > --- a/drivers/net/veth.c
> > > +++ b/drivers/net/veth.c
> > > @@ -865,18 +865,25 @@ static struct sk_buff *veth_xdp_rcv_skb(struct =
veth_rq *rq,
> > >
> > >       skb_reset_mac_header(skb);
> > >
> > > -     /* check if bpf_xdp_adjust_tail was used */
> > > -     off =3D xdp->data_end - orig_data_end;
> > > -     if (off !=3D 0)
> > > -             __skb_put(skb, off); /* positive on grow, negative on s=
hrink */
> > > -
> > >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > > +      * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribu=
tion
> > > +      * from skb->len before updating data_len, then add the new one=
 back.
> > > +      * This must precede the linear tail adjustment below: a changed
> > > +      * data_end implies that no fragments remain, and __skb_put() r=
equires
> > > +      * a linear skb.
> > >        */
> > > -     if (xdp_buff_has_frags(xdp))
> > > +     skb->len -=3D skb->data_len;
> > > +     if (xdp_buff_has_frags(xdp)) {
> > >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> > > -     else
> > > +             skb->len +=3D skb->data_len;
> > > +     } else {
> > >               skb->data_len =3D 0;
> > > +     }
> > > +
> > > +     /* check if bpf_xdp_adjust_tail was used */
> > > +     off =3D xdp->data_end - orig_data_end;
> > > +     if (off !=3D 0)
> > > +             __skb_put(skb, off); /* positive on grow, negative on s=
hrink */
> > >
> > >       skb->protocol =3D eth_type_trans(skb, rq->dev);
> > >
> >
> > I am most likely missing something here but what happens if we have
> > frags and we attempt to advance data_end while leaving some frags
> > present (e.g., bpf_xdp_pull_data())? Looks like, in that case we would
> > issue __skb_put(skb, off) with off > 0 and we would hit
> > SKB_LINEAR_ASSERT() because skb is still non-linear?
>=20
> Hi Mohsin,
>=20
> Thanks for catching this. You're right that bpf_xdp_pull_data() can advan=
ce
> data_end while leaving frags present. I'll investigate this path and foll=
ow up.
>=20
> Thanks,
> Sun Jian

I guess we should implement the same approach used in
bpf_prog_run_generic_xdp(), something like:

	if (off) {
		skb_set_tail_pointer();
		skb->len +=3D off;
	}

Regards,
Lorenzo

--YM0lzDBH++kuull8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCanBUWAAKCRA6cBh0uS2t
rKJxAQCQx9l9vI+JhD4aLxY3M5M93S1Mnk8c49lxrJ0nHzQm+wEA0lEj4L5etXeB
pV6N1BBBrN4bVsy29Mv9eV621WyLwQk=
=seow
-----END PGP SIGNATURE-----

--YM0lzDBH++kuull8--
