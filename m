Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2697483824;
	Thu, 24 Sep 2026 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286789; cv=none; b=KykQcPYB4LKGo6Czo24Ly8fFl82HevO/vX//ax5Vc4/hSq4vvl/HOVSKLtFMpTPOAGQhyq9kajXTVMY4KqD1XJCIyKZ1PNwidUfXos/dbh/Ws6mvFCnmjOXQCwSOkZW5ZYu1E9akzYnueGE358HaiR7jY6gZq1Av6hV2fzrJyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286789; c=relaxed/simple;
	bh=o7N9/sy+n4mdtJoyfMwH3mVPeLFpIHzo/3QWDE8P2Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxina4mbv+t/tqnaWRtojwAdbwjOJ/vgHzXO4cGO1JY1QnuBF22oNVov6lyH/8qp24eZiYIvNnPl4rBgFpcgMW6tTCcVdzi/mmjKoszOWYtquH168VG9LFRvlqjbjGo4Y1Jj0BQKCTWs2DJg3s8ETDmvCzTrEXzrtwsfpPW1H84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=MyX1/IF3; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="MyX1/IF3"
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 68OLqYCT3984666;
	Thu, 24 Sep 2026 23:52:34 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 68OLqYCT3984666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1790286754;
	bh=9DpsrgvtD3FUevNw9X7509GKZ3/E4JlqdpEeb9UrAIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyX1/IF3mRVCAidqq2jNotvvUy47FcO25EiOaCoPpUPn8phUj4BkDqO+N1ExiAI6F
	 mUnoFzGM6mCjs517y+UEgBZ6qqOBhnrmF073M3SvyTxS+S/kTvSzgHNG83GYJuZQlZ
	 Ylcf0Muz3V01NH9LhuGuJ57Z4MSjy0jhv9qh41XI=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 68OLqX093984665;
	Thu, 24 Sep 2026 23:52:33 +0200
Date: Thu, 24 Sep 2026 23:52:33 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Denis Benato <benato.denis96@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Petr Machata <petrm@nvidia.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net 2/3] net: fealnx: disable the PCI device on remove
 and probe failure
Message-ID: <20260924215233.GB3984640@electric-eye.fr.zoreil.com>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
 <20260924104231.110576-2-r.zhambakiev@prosoftsystems.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260924104231.110576-2-r.zhambakiev@prosoftsystems.ru>
X-Organisation: Land of Sunshine Inc.

=D0=96=D0=B0=D0=BC=D0=B1=D0=B0=D0=BA=D0=B8=D0=B5=D0=B2 =D0=A0=D0=B0=D0=B4=
=D0=B8=D0=B9 =D0=A0=D0=B8=D0=BA=D0=B0=D1=80=D0=B4=D0=B8=D0=BD=D0=BE=D0=B2=
=D0=B8=D1=87 <r.zhambakiev@prosoftsystems.ru> :
> From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
>=20
> pci_enable_device() is called in probe, but the device is never
> disabled on probe failure or remove. Device remains enabled and
> bus mastering stays active.
>=20
> Add pci_disable_device() to the probe error unwind and to
> fealnx_remove_one(), after all other resources have been released.
>=20
> Found by Linux Verification Center (linuxtesting.org)
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> ---
>  drivers/net/ethernet/fealnx.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
> index d7cd1644a375..46a40d00b59a 100644
> --- a/drivers/net/ethernet/fealnx.c
> +++ b/drivers/net/ethernet/fealnx.c
> @@ -494,20 +494,22 @@ static int fealnx_init_one(struct pci_dev *pdev,
> =20
>  	option =3D card_idx < MAX_UNITS ? options[card_idx] : 0;
> =20
> -	i =3D pci_enable_device(pdev);
> -	if (i) return i;
> +	err =3D pci_enable_device(pdev);
> +	if (err)
> +		return err;

Unrelated change.

--=20
Ueimor
