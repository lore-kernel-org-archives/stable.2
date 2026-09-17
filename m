Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583A54A1E05;
	Thu, 17 Sep 2026 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684441; cv=none; b=U81WjfOgXcz6fQSFSbrsqvDgC5Xtmss9o/3GI0JxIc8K/aneRm1eF01JFFqK4A0XlQT6hSD1ZhiqNFEHOXAdgqPxSvdoiaaBCoRH32EaozqxNkVZyINcb5l61JU/G9yr5z2DIyw5IyUeG8YFkmZBy+KFARnLnrRT0vW5AuZ4DlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684441; c=relaxed/simple;
	bh=tXkh16j/Thv+s9cP7UX0gqw0LlvCxf76Arv3zXbeDrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFPEGXz1/zlZrkmwJDt12sfuy9uH2VfWbB8GsnC6N3aGqXc1GC5KT6tW4OEZN3duYtvihKqCUOhScAP7AWVR3+IVMAUhzFMy0ngfICjGAFwDA/B50W8VnabXkHN7iS82sF3QrzuxuDIF9mYka8+lFD+c31ZCg5pPDbcgXVvl8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNdgG5DS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNdgG5DS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EE61F000FF;
	Thu, 17 Sep 2026 22:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684440;
	bh=tXkh16j/Thv+s9cP7UX0gqw0LlvCxf76Arv3zXbeDrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WNdgG5DS3KQnHaWNU+TDLlgSaj3d54kvjXav4ma5fjCLAES1Bl113qxoQgiY1TrOj
	 ZlqxNeiNKMsMqahjxk8FGzgsO30737PX2VT2GFlnoRCCvSqj92vT469DaDPG/Om2ah
	 IdB7ICbLYWpxYHUbPz8OEpfkay4B2wVB1caQskAy1McvHiwpmp4ZJiqTMF5fciQ77S
	 1ZG0i55cgy5rJd1ZiC20J0IlOfAewOjliScvCe21NmzCV382tiCh5/Zy+qmcrw02wL
	 ojG+6OmI/81SJ8L19Jkn+tAHoUJtBLvwBipUpKeDSsaFeYt4qrn0CUzP56I6ldCqgG
	 8pvulrTcU4XyA==
Date: Thu, 17 Sep 2026 23:33:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
	perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Fix ASRC device leak in
 fsl_asoc_card_probe()
Message-ID: <1d80b89f-7b33-4036-a450-bf32c603a238@sirena.org.uk>
References: <20260917165430.2163372-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P1ZmkZ7HWziaZSjA"
Content-Disposition: inline
In-Reply-To: <20260917165430.2163372-1-vulab@iscas.ac.cn>
X-Cookie: Whip it, whip it good!


--P1ZmkZ7HWziaZSjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 04:54:30PM +0000, Wentao Liang wrote:
> of_find_device_by_node() returns the ASRC platform device with a
> reference taken, but asrc_pdev is only used during probe to set up the
> DPCM DAI links and is never released. The shared exit path already drops
> the CPU device reference, so release the ASRC one there too, covering
> both the error paths and the successful registration path.

This doesn't apply against current code, please check and resend.

--P1ZmkZ7HWziaZSjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsatIACgkQJNaLcl1U
h9C0Ygf/RPsRzvwwH4gsQUTDa5a8UQsKSpt0ClJpUzd9B3N82yCZlVAtHxZBcgUj
tHCfZEKD+1B9Glr+QJGAN+8NesYn3HRKfbKiW4Jt5NESTK5QAIAjsMrWxhNrFN3x
KD3sph6e2rbMmYV0ghCw0/S5EZ/uEtePvuWKIZ+c2bgfx5XVFfG1TvUOOlj6kXP8
U8PLUZQeyUmnhexe09hMc5+i0SDW4IiM5p+vB4fHy6Aip6qz+zIX/NocqexZhrhd
j22M3Qgvz3klweIoHpxTZqR/MLYY6lxLcL7Wj9mVCG8qzL/8dZh5HcE83TCzc139
7+M0UMSahUdK1AC4hZiK15UGanLF7g==
=+L6c
-----END PGP SIGNATURE-----

--P1ZmkZ7HWziaZSjA--
