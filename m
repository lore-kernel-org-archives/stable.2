Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015144;
	b=WaWn+xjJmdabTEm2EfdPaMGGLFutRhtzTlPPwRHI3r1/wIkXl9VtpBYQZ0c+0gnBR0Zw
	 NKXnnThWiLSFu0+wmrdWbgRXMBQ3MtPVvEOJLlLvht3CIfCiDi8MFPYoQIhjIVt4i1SB/
	 ABPGuvLh31SWFDx9fedDdfMOLB6b9GkgTkaZGTOzyGPR3NdOMbxaCiZAJFT2sAah6C+F7
	 +foe3iySNDhpFgOGJ32ibpun5tvNFyydDmhHAqtseoJun0NvqFGegDd9eWf0MFUTgSefZ
	 bfdEDsmbXTHAqgMv8QkngVDFtHlSNPSFFPPtAb7qy3t4Xtrd0mEOqFP4ALdnPM30HMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015144;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar;
	bh=OQT/CVWEEgkIk3CRsbx9nzXXUGlb/xzEL/k6rXvVHpo=;
	b=kND8ZDfVn7+dvcPCYqYJBQ0r0rJ/c2Koz4pwjsvVkD9bpiz8NcxRIV2sT4wKy/Yy5hXA
	 OG+0gjxr0gKzDRkiuKNp+wSg0n2L/Pmt8PPQ7SkekVQRkioHKMSiHKr+LolreNPjKVJ5p
	 SPmjzLLiHEES89olBgUgH40jdYQVuHNPqg166qUPEG5rV+ZbmcVMFqbErhucVHHqopUft
	 GUPRObQQEDFRYGqkubTrWuenZooSRA5hSbtRLigyZJdbQrYK0pBdFsuoiQop/OHYOVh93
	 kR1ExmsyqrhY2MnzHZRJ32pUwDgvzbqb+8dCUbaN7Qnm3Cl4c49QbQAPCs3pfHJgX0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b="RwprD9f/";
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DD606A333;
	Mon, 26 Oct 2026 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=RwprD9f/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OQT/CVWEEgkIk3CRsbx9nzXXUGlb/xzEL/k6rXvVHpo=;
	t=1793015143; x=1794224743; b=RwprD9f/GUIbU84xFhtTB0ZdefY1TMS5ndPCSCLTD4USW4g
	o8V2A60nt7J9vUGoAOBpqJQGDIV8xr301pTcVI7UpWLsMEZvwptvu3eMfysm+k12D07ZKQ68+9gY+
	IpuMJ/6NxnaaVrN34MQyf48zmr3lnRPD6vdGks3ExSE4am8QnlffoFCfKDN7oFNBkDO7q+rw7PSml
	zkfmp9dMAvr5AWTb+J5FHfv+Q6e2y1OtWBFlcP0S2FewemwGaa/KBDyzZrFnCw3JYzHMcOI3Z+zGm
	eJTFzn0vsSqEYVVk62d4bVtLtHMEPEAUT7qBIagYX+wOeJObfOTl93j+RlNVemSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xLJ8y-0000000BDEN-1DZ6;
	Mon, 26 Oct 2026 12:45:36 +0100
Message-ID: <9658b549be7c1c0f1637699b8b61960d2101dfca.camel@sipsolutions.net>
Subject: Re: [PATCH wireless 3/3] wifi: p54: fix IE parsing loop bounds check
From: Johannes Berg <johannes@sipsolutions.net>
To: Tristan Madani <tristmd@gmail.com>, Christian Lamparter
	 <chunkeey@googlemail.com>, Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, "John W . Linville"	
 <linville@tuxdriver.com>, Larry Finger <Larry.Finger@lwfinger.net>, Kees
 Cook	 <kees@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org, Tristan Madani
 <tristan@talencesecurity.com>
Date: Mon, 26 Oct 2026 12:45:35 +0100
In-Reply-To: <20261026112151.2515228-3-tristmd@gmail.com>
References: <20261026112151.2515228-1-tristmd@gmail.com>
	 <20261026112151.2515228-3-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2026-10-26 at 11:21 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> p54_find_ie() iterates over information elements using a loop condition
> of while (pos < end). When only one byte remains (pos =3D=3D end - 1),
> the loop body accesses pos[1] which reads one byte beyond the validated
> buffer boundary. The read happens in the bounds check expression
> pos + 2 + pos[1] > end before the result of that check can prevent
> the access.
>=20
> Fix by tightening the loop condition to while (pos + 2 <=3D end),
> which ensures that at least the IE id (pos[0]) and length (pos[1])
> bytes are within bounds before any access.
>=20
> Fixes: 0ac0d6cedf611 ("p54: Move mac80211 glue code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/net/wireless/intersil/p54/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wirel=
ess/intersil/p54/main.c
> index 57a62108cbc35..16614f65dfa5f 100644
> --- a/drivers/net/wireless/intersil/p54/main.c
> +++ b/drivers/net/wireless/intersil/p54/main.c
> @@ -81,7 +81,7 @@ u8 *p54_find_ie(struct sk_buff *skb, u8 ie)

We'd probably be better off just replacing that whole function with one
of the real search functions or iteration macros?

johannes
