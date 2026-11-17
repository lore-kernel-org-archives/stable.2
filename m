Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907413;
	b=QuxkZVnIUyHC7ZjIdSQBTrCnuO9ov71M/VU8KridX3b+6C3AVJXhtBwwyhg08JpTaWgC
	 WsmeJN8E0et8dvt1vFJPdH6jD8xOUzT38Of0oIX83sATL46zVDsA/PqmmGBImj/WWr90M
	 7+Yyx/MJndDeC1jxtwiApTmpDXkTmWjuz5jFzdt+rqph/Wbj6amoHCV72vIh8UmOAiVZ4
	 apl6H7Jz1KRgAMW8yszKJ4hxW6nGX9xyX39jSmc/Iz9vtWk27UTbHMWYg1bYEWKSMZMqJ
	 ss3r0Ig1+cFErdzjFHIlpE9++pvCDdxql8Xr5Bdbwq6QK5g+6fMOVEXiIvu/RkLxP9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907413;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y0Dxc4AUtnds+NirsV609zNbchLGxMc3AgfuhcVTQUs=;
	b=IzKFGa0pzvLOkcTwZLgaw0Zd0Y0GImRxUoKh4cZYUO2Q2dPslACP4yPe0CgFQ3HJalqB
	 ZP01QXEkBq+pntRSGXKqivmUmKTfQxmIKDpNN8G5F4djQzYYfvC6oJI6YWh/NvoC2NYUE
	 z0hrel72CnZDOqKs7RHXIoQz4vWhuEoJs0BAqYc9MsOXtTJChQ18SW3t2k5/nbNNft+m4
	 6j4R/pZO9eVYSnduKVnn2O9b5v8vo+4PGfJyqZUHQS6eFUMKePQtSyCdOXPsYtmQtiO1p
	 Faxzkb+hJVoK09cnZ0GcuHW6Z9FE1tR0qAPfJ8NTVrN1OZ5fQ3bDhfRUudE0VNf6t5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRSTQspS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008D606A31C;
	Tue, 17 Nov 2026 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRSTQspS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571371F000C7;
	Tue, 17 Nov 2026 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794907412;
	bh=y0Dxc4AUtnds+NirsV609zNbchLGxMc3AgfuhcVTQUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eRSTQspSxgaqoaoK60PFKexxHJe0ahOvWAZv8sFb02FsK7851Tdx9jqtFimAE+JSw
	 FVzgjicajcGYzSjx6YKbwyyxCzAO7iXon19D5mByJfrLyIjFnT7kkToPaR1Rb8MeFz
	 NgYy/7vY42oGvZyvEfwh26G8SO4X/XAcuWPU0kwL/Vfv6ZD3eucTVVvc56AlnIoloI
	 Ie/7B2shCxsgNnfSAnRCdaY7+oFhWmWqFsxkYWiloEZX+WsDXsW+AXoHxgjCOrWw7s
	 YvqurGf7Fl9VpIT9QtgrRHm1DiUVbi5BqQZAfzhWbh0eoIP6Q8xNe+ZWhujYEhvFod
	 HnJR10Ui3iGAg==
Date: Tue, 17 Nov 2026 10:23:30 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Florian Maurer <fmaurer@disroot.org>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH wireless 1/2] wifi: mt76: npu: return rx slots to the NPU
 only after refilling them
Message-ID: <avwdEgGBeZWWGvzq@lore-qca>
References: <cover.1793927986.git.fmaurer@disroot.org>
 <d6314f34e0965464207656d38a145490b6437aa5.1793927986.git.fmaurer@disroot.org>
 <au3igPTxdz3i64SO@lore-desk>
 <20261108205350.2956138-1-fmaurer@disroot.org>
 <avGnv8Jr7BAiQhG1@lore-desk>
 <avrdu8qr9L2sEuTz@lore-desk>
 <20261116162741.2438098-1-fmaurer@disroot.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s+XiL6GVKLQjZ58r"
Content-Disposition: inline
In-Reply-To: <20261116162741.2438098-1-fmaurer@disroot.org>

--s+XiL6GVKLQjZ58r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 16, Florian Maurer wrote:
> On Mon, Nov 09, 2026 at 12:00:15PM +0100, Lorenzo Bianconi wrote:
> > q->head and q->tail are not the same when we have refilled the queue
> > with new buffers. Moreover, I think if mt76_npu_fill_rx_queue() fails
> > [...] it is not correct to use q->head for dma_idx
>=20
> You're right, q->tail it is. In my tests I could not tell your version
> and mine apart, so nothing speaks for head + 1.
>=20
> > Can you please check the updated patch below?
>=20
> Sorry for the delay. I tested it on the W1700K (kernel 6.18.55, mt76
> 467ae2e3) and it works: no oops, no rx stall.
>=20
> What I ran: your diff as posted, plus read-only counters that write
> nothing to the descriptors. Load was 62 minutes of iperf3 from an
> ath11k mesh peer at 113-259 Mbit/s, with four busy loops at nice -20
> on the W1700K for 3 s every 18 s. In that time:
>=20
> - 61.9 M frames on MT_RXQ_NPU1, 1.88 M on MT_RXQ_NPU0, of which 227781
>   span two slots
> - no oops, no page_pool warning
> - no descriptor that changed between consume and refill
> - no refill failure, no skb failure, no tx-free parse error
>=20
> Tested-by: Florian Maurer <fmaurer@disroot.org>
>=20
> I found another issue of the NPU while testing, so this took me some
> time as well:
> In one minute, 226 multi-slot frames in a row did not end on the slot
> with LAST. Slots of the rx ring go missing under this kind of load (I
> suspect the NPU drops them), and counting slots by PKT_COUNT then
> assembles the following frames one slot off, in your version and in
> mine. I think tx-free events are lost the same way.
> I will post it as a separate [BUG] report in the next days.
>=20
> Optional: in my tree I made the poll report the budget as used when
> the skb allocation fails, so napi polls again instead of waiting for
> an interrupt. It never triggered here.
>=20
> Please post your patch with the Tested-by. My 2/2 can be dropped.
>=20
> Thanks,
> Florian

ack, I will do. Thanks for testing.

Regards,
Lorenzo

--s+XiL6GVKLQjZ58r
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavwdEgAKCRA6cBh0uS2t
rFKTAQDrf8StTOI65bgn5xeopIFbWqMbx61UDKD54phLvPS85AEArtbOPqgpGZ5M
4Q3sUXE6HqctYejU8r0x6vlcCI7NVAc=
=x/Dy
-----END PGP SIGNATURE-----

--s+XiL6GVKLQjZ58r--
