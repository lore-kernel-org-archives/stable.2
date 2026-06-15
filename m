Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC193BFAE2;
	Mon, 15 Jun 2026 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510040; cv=none; b=IujQc1HugefzK+Tc4fmJ6cdaafA7ALd0sA05olkJOES7rTiqfeiv0aLc679JlLxvK6MWVwhPRtbd3mKapP/qulOmExMYlFCq9EyAq4VfbOru2eJn/75MqQZTYaXUk/HGIDb55OkVxDENxZBQspRWKdpwmkFGtK3jlgdxBxeKwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510040; c=relaxed/simple;
	bh=4XLkdt17a7BumTtZvZ/QKmAK5ZbQIHCPTQYDHiDXzdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oq9ccoXWx9fGHMTLVw0qKXWTldkWxuYHbnI43r8wq4Yw+22RDxY420ionoiBdkCkFjeMtYHpeiUmitpsjgU/HcU2glcMi6j0nurYIouhITtJL1OQWQeAxr35tduSNcJOJSYARpGv44b8HLWnVCzZneX8S0mhjwcbBJmuXjIbMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ODNxDDQO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/8pMZfjP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ODNxDDQO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/8pMZfjP"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781509428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OBrL6lgGQBMYLJZdswh2V1MoY8JuyilmLozsgGz4/8o=;
	b=ODNxDDQOCe9UfjLWIOph6jNPzGzUPcQ+xb+ydJN9M0i6CFMiDsHRgjKbJLr26Xs92UIUER
	lKk3TdIbh4npedW/uj/ukiC4XGVc+eObQqnG/f4MIP5kVqDZDM/CLqZ5YNUESHyzn+cLy2
	/yMm/xh19asWEgDKSKbe4u6Rg+QWSI2SfIM6JuIixgrz8fEimXRjEJxM2P4RyF60ZpOSK7
	Du6tM6kFrNhg64BegewC6SFUM7+veG/iZtTEBVDQ1OjGbkbULfgR9PhU7HX0X8gHyVY2Mt
	hV9T1J+MgpL1sefve2st+f6Ub7LERak9Nj+SzSHpQ5DlIoUYAxaXF4UOvWxOBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781509428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OBrL6lgGQBMYLJZdswh2V1MoY8JuyilmLozsgGz4/8o=;
	b=/8pMZfjPCT/NlvqtaxZ/j9kB+C0va9VKo3CGEL3R2t074ZTbNOt/mu7QDZ8BlQUZmbWcIa
	6osH4nK734IJz6CQ==
To: Tjerk Kusters <tkusters@aweta.nl>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "hawk@kernel.org" <hawk@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] igb: only strip Rx timestamp header on the first
 buffer of a frame
In-Reply-To: <PAWPR05MB1069106D52F4E17F1EDB99C67B9182@PAWPR05MB10691.eurprd05.prod.outlook.com>
References: <PAWPR05MB1069106D52F4E17F1EDB99C67B9182@PAWPR05MB10691.eurprd05.prod.outlook.com>
Date: Mon, 15 Jun 2026 09:43:48 +0200
Message-ID: <8733yojljf.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri Jun 12 2026, Tjerk Kusters wrote:
> Hi,
>
> The patch is attached (0001-igb-only-strip-Rx-timestamp-header-on-the-fir=
st-buff.patch)
> as my mail setup cannot send it inline via git send-email; apologies for =
the
> attachment.

b4 has a web submission endpoint. Maybe you can use that one:

https://b4.docs.kernel.org/en/latest/contributor/send.html

[snip]

> From fee3e3452dfcd7e109332369672a3e0090cadeb3 Mon Sep 17 00:00:00 2001
> From: T Kusters <tkusters@aweta.nl>
> Date: Tue, 9 Jun 2026 14:06:24 +0200
> Subject: [PATCH net] igb: only strip Rx timestamp header on the first buf=
fer
>  of a frame
>
> When Rx hardware timestamping is enabled (e.g. ptp4l, which configures
> HWTSTAMP_FILTER_ALL), the NIC prepends a 16-byte timestamp header to the
> first Rx buffer of every received frame. igb_clean_rx_irq() strips this
> header inside its per-buffer loop:
>
> 	if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> 		ts_hdr_len =3D igb_ptp_rx_pktstamp(rx_ring->q_vector,
> 						 pktbuf, &timestamp);
> 		pkt_offset +=3D ts_hdr_len;
> 		size -=3D ts_hdr_len;
> 	}
>
> For a frame that spans more than one Rx buffer (e.g. a jumbo frame), this
> block runs once per buffer. The timestamp header only exists at the start
> of the first buffer, but igb_ptp_rx_pktstamp() is called for every buffer.
>
> On a continuation buffer the data is packet payload, not a timestamp
> header. igb_ptp_rx_pktstamp() already has two guards against acting on a
> non-header buffer: it returns 0 if PTP is disabled, and returns 0 if the
> reserved dwords (the first 8 bytes) are non-zero. Neither is sufficient
> here: PTP is enabled, and a continuation buffer whose payload happens to
> begin with 8 zero bytes passes the reserved-dword check. In that case the
> payload is mistaken for a valid timestamp header and igb_ptp_rx_pktstamp()
> returns IGB_TS_HDR_LEN, so the caller strips 16 bytes of real data from
> that buffer. A frame spanning N buffers whose continuation buffers start
> with zero bytes therefore loses 16 * (N - 1) bytes from its tail.
>
> This is easily triggered by a GigE Vision camera streaming dark frames
> (mostly 0x00 pixel data) over jumbo UDP with PTP active on the receiver:
> the all-zero frames arrive truncated while frames with non-zero content
> are fine. There is no error indication.
>
> No content-based check can reliably tell a continuation buffer that begins
> with zero bytes from a real timestamp header, because both are all zero.
> Fix it structurally instead: only attempt the strip on the first buffer of
> a frame, which is the only buffer that can contain a timestamp header. In
> igb_clean_rx_irq() skb is NULL until the first buffer has been processed,
> so guarding the strip with !skb restricts it to the first buffer
> regardless of payload content.
>
> Fixes: 5379260852b0 ("igb: Fix XDP with PTP enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: T Kusters <tkusters@aweta.nl>

Great explanation! igb_clean_rx_irq_zc() does not need the same
treatment, correct?

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index ce91dda00ec0..abb55cd589a9 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9061,7 +9061,8 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_=
vector, const int budget)
>  		pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
>=20=20
>  		/* pull rx packet timestamp if available and valid */
> -		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> +		if (!skb &&
> +		    igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
>  			int ts_hdr_len;
>=20=20
>  			ts_hdr_len =3D igb_ptp_rx_pktstamp(rx_ring->q_vector,
> --=20
> 2.27.0
>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmovrTQTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgiv3D/0UL1rHA6YpGPl2jWtXbXCrHgwJJdw5
A7Gz5HXnRnXa9w1rEAJR5yTlDo6NGCctjf0ZQbauwUVEoZ24+mBdNWHZbRi+alOw
CiiLygla3wwCp6bwPdOfxoOWWw1RM9E+auZCv+8Gl9yFinuJkwY7ZgRmdzf99U//
FhM/mxLAcnheWAWmvPFeaQZY8jcBh7gy//sN5FaFnIamQXIVulKMmfLAuzqPtoUf
QMT/wL9nLi/yyp0cQUM9OXsb3WCFWfk1VyIHdOFtDKt8xZE3tgotUAH1JwYvUb5A
EBb7PwgbvPhlqBEjDgtCi7p+KL/Jk8AIxjReHNjG+nXxxc6FURTEkuvkHAu0Zfx9
O9hc9reE3zsvwDvtrL+wfcMst894XDrQfdlMhDGZDaDHkiOUHk5wpm2FTO3BhM43
cR1xUuXchLSmUufMYh4aW9iP+k6TqZqdRMK3x/v+4RGhkuHUvHbjEnyCKkfhsRAn
bqDgB2tnCHHHi3DUAPAu+fRf8yK/D5DYDWTrLT2EIsrDeTqU4DmTrA++NNsfkQU4
FqPIZssxIYXDDC9PtiG9CEscDL+EkMDeFVGzvYUIL5kLxAUl1UfmMCky9k7Qd4Mt
Paph8NOdC03rwrQQikqJ2SoH4hnakRiIeBu8YkWVhGKvzU/WTx9PtSKtrhVkzWeR
tnGF2+a/wNMIOQ==
=+94Q
-----END PGP SIGNATURE-----
--=-=-=--
