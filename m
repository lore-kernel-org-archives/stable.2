Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E979CD;
	Sat,  1 Aug 2026 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785543987; cv=none; b=m8ks7FYhMSKP1nfHBYGT2hi3zawHreWFSc0cX34hY6+dKFJzriQwYqiibUFUgVT5HCJAA2Gi4Rb3xCicR99bLjCJNYHnfNMNzmhM+AOrpARIZbTqvWHi7Z+TQAcpIMBjgIkC1WesfqZ3m1admnADqBzedivngB2dBkrLRneV968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785543987; c=relaxed/simple;
	bh=wrApbr1e4QczmWxTSZFhnuOCyhkxF+jzdVeRL/PG9CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVMpZm/0WcWK0JyDYavBKinXcEnu7LawsEseRxLDKqnQQMk1ipt7Gqxr/cB4QgSiWYtwMzNoOztzW1kWeyNdJgSt/9ISEM8fNNzAACscIupXx7W6FPAT0N91BuYztBJ0kQRIxj5150h/JPuO/CbT0o1Sp+qvuYAhEYwSnCUzkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn/dJd1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn/dJd1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934C81F00AC4;
	Sat,  1 Aug 2026 00:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785543986;
	bh=/qw3w6HY3lnpT8b+EEz0mj5w9iMLAiQmXAzkOGNvjAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rn/dJd1l68eiwld7EKXuCeBbt9gzk6YWRVf4/2S1VwC5yE0Au47UtqVYTY1stZrHB
	 IeT1RdrZ/G480IZysTI9y4Ncw1rdEuD18tSqB31yC65WHxaJi1Q0XcQQckdxARYd+d
	 7MztU1jJP6SSwylq6Ch2y1zRsISBgU4Tc+2hz+5lf7rmHwtLnWxtx0bp5V+PrzFuMw
	 zEwI7Jjh5gSwczX3X65nVvYgLrJP8r6+IVjZL8VjeaXJCwiT3q93oi2dN2bQplrrSs
	 UqAc0nfhw+P0kKEdZLEuYts8xZDUvefFbIsIOEbAR7QM3RRyo+6wDmXAdHBa2xX6iO
	 Xwk3bSBJVG0Aw==
Date: Fri, 31 Jul 2026 17:26:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vaibhav Nagare <nagarevaibhav@gmail.com>, <horms@kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <matvey.kovalev@ispras.ru>,
 <Pavel.Zhigulin@kaspersky.com>, <aelior@marvell.com>,
 <manishc@marvell.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Vaibhav Nagare
 <vnagare@redhat.com>
Subject: Re: [PATCH net v3] qede: Fix NULL pointer dereference in TPA
 fragment processing
Message-ID: <20260731172625.12aa4227@kernel.org>
In-Reply-To: <40acfd87-23c5-40d2-8153-e94e1108c269@intel.com>
References: <20260727093322.1119035-1-vnagare@redhat.com>
	<40acfd87-23c5-40d2-8153-e94e1108c269@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jul 2026 14:57:54 -0700 Jacob Keller wrote:
> Sashiko complains here with the following:
> > Will this check always evaluate to false? Looking at qede_tpa_start(),
> > it appears tpa_info->buffer.data is never assigned:
> > qede_tpa_start() {
> >     ...
> >     tpa_info->buffer.page_offset =3D sw_rx_data_cons->page_offset;
> >     tpa_info->buffer.mapping =3D sw_rx_data_cons->mapping;
> >     /* buffer.data is not set here */
> > }
> > If buffer.data is never initialized, will this bypass the error recovery
> > logic for TPA start failures? This could result in a permanent memory l=
eak
> > for the page and DMA mapping, and permanently exhaust the physical ring=
 slots
> > since rxq->filled_buffers is never decremented here to account for the =
lost
> > slot. Could the original NULL pointer dereference be fixed by adding the
> > missing assignment in qede_tpa_start() instead? =20
>=20
>=20
> It doesn't seem to realize that buffer.data is assigned by
> qede_realloc_rx_buffer or qede_alloc_rx_buffer, so I do not think this
> is legitimate.
>=20
> In particular, I think the AI fails to track that tpa_info->buffer
> points to the same memory:
>=20
> struct sw_rx_data *current_bd =3D &rxq->sw_rx_ring[rxq->sw_rx_cons &
> NUM_RX_BDS_MAX]
>=20
> vs
> struct qede_agg_info *tpa_info =3D &rxq->tpa_info[cqe->tpa_agg_index];
>=20
> As a result, it thinks the buffer.data is never initialized and relies
> on this conclusion for both this and its next complaint.

I fed this back into AI and it still disagrees (slop at the end).
Could y'all triple check? I'd also look at bnxt for inspiration
Naming of things are suspiciously similar between these drivers.


  current_bd and tpa_info->buffer are distinct objects:

  - current_bd resides in dynamically allocated rxq->sw_rx_ring.
  - tpa_info->buffer is embedded in rxq->tpa_info[] (drivers/net/ethernet/
    qlogic/qede/qede.h:305).

  qede_alloc_rx_buffer() assigns only a ring entry (drivers/net/ethernet/
  qlogic/qede/qede_fp.c:58). Neither it nor qede_realloc_rx_buffer() assigns
  tpa_info->buffer.data.

  At TPA start, only page_offset and mapping are copied (drivers/net/ethern=
et/
  qlogic/qede/qede_fp.c:865). Because the RX queue is zero-allocated,
  tpa_info->buffer.data remains NULL.

  Consequently, after a TPA-start failure:

  1. The valid ring descriptor is consumed.
  2. buffer.data remains NULL.
  3. The new check at line 1077 skips qede_reuse_page().
  4. The page/mapping are lost and filled_buffers remains overstated,
     preventing normal refill.

  The history confirms this: before commit 8a8633978b84 added build_skb()
  support, the driver used:

  tpa_info->buffer =3D *sw_rx_data_cons;

  That commit replaced it with copies of only mapping and page_offset,
  apparently dropping data accidentally.

  The proper correction is to preserve data for the failed-start recovery a=
nd
  retain tpa_start_fail as the ownership condition. Merely switching to
  buffer.data is also unsafe: after a successful full-page start, a non-NULL
  pointer does not mean the page may be recycled; it belongs to the skb. The
  reviewer=E2=80=99s concern is legitimate and likely identifies the actual=
 root cause
  of the NULL descriptor.
