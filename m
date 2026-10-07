Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890523ACF15
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388970; cv=none; b=o6xDnaoE/NKkOVj2bPThul15Ruk+44XNxVByz1GTmVfH9Iz4IJPJBS+NNVBeVmY1pQz//6UnOv5vYQeiNAHN1Xcm77PAIoGvsovBtXa/ZxtoKspQ9Tr4xCNwkgKfOFmGldumedTcH6oymidgkKy4W1Gx0qEbXbreTQgA1pFLWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388970; c=relaxed/simple;
	bh=ZTmnE2TiuCZml3oZMFKoldvrfd4U99JUwRhxdULhEKs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZu6RiwKQZts7wpfEkWSi3U8GVcmFgAGmoTn5Gzkhrb+SqaaELre1IdVNVSbcLj9WpvoIRgp68LZQu7J5wUZfgODS3re+uaBjZUwU33XBO+xSLJXhwdFNWxSkQz+cwv5QIv8+X7ffHR20a6yYRwnmDuUy3gv+TgdH7ugXFhyahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=IO3dzYhB; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="IO3dzYhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1791388957; x=1791648157;
	bh=urW68hd20FxHsNaRIcpOnMH3kut5s3/b1BiIl10UWtA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IO3dzYhBMcg3c69ZjVr1n5gCvnj++waAHkwVca0oz2ZCBrLqPqVrGOamRuTs0xI6c
	 aRfZKf+uUgzh9WbZdX3Bfy2xKkROBrgF82xa04CQZCWowSD3oCALosWHPhHUxv5I8P
	 5FiTCvNRsC74FEzdmJU107UJyOR2jQWxeCJK7e/rN7PiLjin+4ySbPGV1hHwgXXnNR
	 lfBNKd+wHTYJVN3hwdqdd4hxBkVplvfEXJV2Fo5/isrRIHEeFEbrae0V2bYYnrgO0x
	 dyd6TNXfSvKO/ra6njPtZ3dVfnuBR+HQ/E4Yn7X8DpO9kt3FCbfxGDU5jEOBra7Bng
	 xOv/PcfBvx0lg==
Date: Wed, 07 Oct 2026 16:02:31 +0000
To: netdev-bot+sashiko@kernel.org
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org, florian.bezdeka@siemens.com, meng.ding@siemens.com, tkusters@aweta.nl, jiayuan.chen@linux.dev, pulehui@huawei.com, dima.ruinskiy@intel.com, raanan.avargil@intel.com, gil.fine@intel.com, stable@vger.kernel.org, javier.herrera@afronta.com, aleksandr.loktionov@intel.com
Subject: Re: [PATCH net 2/6] igc: only strip RX timestamp header from first buffer
Message-ID: <e0YiBuBa9mPzPPrczQvdI6HOwd6LLJ5FLqGBu-HI0aAlvQZcwwZYLsBWHp7sHWLxCJQeHvv2tJqtTK5r7VkaGR9p7E0izm9AlsZy-nm0Sbo=@1g4.org>
In-Reply-To: <179124136251.434549.964852326814446468@kernel.org>
References: <20261001222443.3500206-3-anthony.l.nguyen@intel.com> <179124136251.434549.964852326814446468@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 5d5d2086892415af51e47137a522a39ae6ee9531
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Monday, October 5th, 2026 at 6:02 PM, netdev-bot+sashiko@kernel.org <net=
dev-bot+sashiko@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [High] In igc_clean_rx_irq()
>   (drivers/net/ethernet/intel/igc/igc_main.c), the new `!skb && TSIP`=
=E2=80=A6
>=20
> --
>=20
> igc: only strip RX timestamp header from first buffer
>=20
> This commit changes igc_clean_rx_irq() so that the inline RX timestamp
> header is consumed only when skb is NULL. The commit treats skb =3D=3D NU=
LL as
> the marker for the first buffer of a packet. As a result, continuation
> descriptors that still report TSIP no longer have IGC_TS_HDR_LEN
> subtracted from their size.
>=20
> Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dc=
a@aweta.nl/
>=20
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 95f7747b347b1..b94a08791102c 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -2658,7 +2658,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
> >
> >  =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offse=
t;
> >
> > -=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > +=09=09if (!skb &&
> > +=09=09    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> >  =09=09=09ctx.rx_ts =3D pktbuf;
> >  =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
> >  =09=09=09size -=3D IGC_TS_HDR_LEN;
>=20
> [Severity: High]
> Is skb =3D=3D NULL a reliable first-buffer test when an XDP program is
> attached?
>=20
> Suppose the XDP program returns a non-PASS verdict (DROP/ABORTED, TX or
> REDIRECT) for the first buffer of a frame that spans several descriptors.
> In that case igc_clean_rx_irq() never builds an skb:
>=20
> =09if (xdp_res) {
> =09=09switch (xdp_res) {
> =09=09case IGC_XDP_CONSUMED:
> =09=09=09rx_buffer->pagecnt_bias++;
> =09=09=09break;
> =09=09...
> =09}
> =09...
> =09/* fetch next buffer in frame if non-eop */
> =09if (igc_is_non_eop(rx_ring, rx_desc))
> =09=09continue;
>=20
> skb stays NULL, so the next descriptor is handled as if it started a new
> frame. The commit message says continuation descriptors keep TSIP, so
> that descriptor passes the new !skb && TSIP check as well. Then:
>=20
>   - ctx.rx_ts points at payload data
>   - 16 bytes of payload are skipped
>   - the XDP program runs again on data from the middle of the frame
>=20
> The igc_fpe_handle_mpacket() continue path can also leave skb NULL across
> a non-EOP descriptor.
>=20
> What happens if the last fragment holds fewer than IGC_TS_HDR_LEN bytes?
> Can size -=3D IGC_TS_HDR_LEN wrap there?
>=20
> xdp_prepare_buff() takes data_len as an int, so data_end would end up
> before data. On XDP_PASS, igc_build_skb() then does:
>=20
> =09unsigned int size =3D xdp->data_end - xdp->data;
> =09unsigned int truesize =3D igc_get_rx_frame_truesize(rx_ring, size);
> =09...
> =09__skb_put(skb, size);
> =09...
> =09igc_rx_buffer_flip(rx_buffer, truesize);
>=20
> This would produce an skb with len around 4G and tail past end. The rx
> page would also be flipped by a wrong truesize, so the hardware could DMA
> into memory that the skb still owns.
>=20
> Even without the wrap, wouldn't the mid-frame payload reach the stack as
> its own frame after the real frame was dropped?
>=20
> These multi-descriptor frames look reachable with XDP attached when
> PAGE_SIZE >=3D 8192. igc_set_rx_mode() caps RLPML only for small pages:
>=20
> #if (PAGE_SIZE < 8192)
> =09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
> =09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
> #endif
> =09wr32(IGC_RLPML, rlpml);
>=20
> So RLPML stays at MAX_JUMBO_FRAME_SIZE on those systems. At the same time=
:
>=20
>   - igc_configure_rx_ring() uses IGC_RXBUFFER_3072 buffers when XDP is
>     enabled
>   - igc_xdp_set_prog() checks only dev->mtu > ETH_DATA_LEN, not the frame
>     size the hardware accepts
>=20
> With RX timestamping enabled, a remote peer sending a frame larger than
> 3056 bytes would take this path.
>=20
> Could the frame-start state be tracked separately from skb? One option is
> to discard descriptors through EOP after a non-PASS verdict. Another is t=
o
> cap RLPML whenever XDP is enabled.
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261001222443.3500206-1-anthony.l.nguyen%40intel.com
>=20

This seems maybe legit, but considering the fixes would be entirely indepen=
dent=20
of one another and that this is a theoretical scenario affecting exotic sys=
tem=20
configurations, I'd rather not entangle it with a real user facing issue.

I have some idea and maybe hardware to try to reproduce, but nothing setup=
=20
currently.

More appropriate to be a followup patch.=20

Thanks
Paul

