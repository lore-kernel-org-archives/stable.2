Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE252BE55;
	Wed, 14 Oct 2026 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992281; cv=none; b=euAFn3nqXwlWZSHUltkyIODIwYMGbHQyXo6Utb5Z+7570NjIEqirDOYGywKcoin4iU4O43MCx6rN39x8hCcHF+0LmU9xNr73X5tZ4XxbnT1PdrizwaQo4uiA6dkiwQV0cAWQEOs6kzWdyHwOpKNkwSCq/LvRXfo83HWMgfgHKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992281; c=relaxed/simple;
	bh=0+ynqpjxtD/hDbviiAdSNFOM7IaT2ekxQsZZddvJRtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHLCGl/sd49DWXqklMM6xLUrLpBVyeTiBP/iOiNfe8kR5obz+Eo4pOq4w+PBBQZE9BNb0bhdD6OnW0SPwA8HJlypOuwASV/fNcuC9fJXYJyBIJKxote8RbhsezgKXyxLWKFKwsOe3/diyHUsZNWxQY2rH4YSNI86SN0Gtx8mWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZucv9Hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZucv9Hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95061F000C4;
	Wed, 14 Oct 2026 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791992280;
	bh=0+ynqpjxtD/hDbviiAdSNFOM7IaT2ekxQsZZddvJRtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OZucv9HnWYVI7qGigI9iUWmzdV4hiI61mdEf3b/eiwvQ1VyuVNFrSBIgQythy/kuN
	 bwGQbnZG2eakofXbqR8BCb+l2vP/n1AGiV6K0CL66aZwy0HKPMvvcUqB1P4AnhZCg8
	 SvCH4Ta8fxJhKqB/njOfP/UB/Kio0E+5cfAJzZkTP03f2qSazL36y5YpFIdkG9tGjd
	 pvt+/5Y5hY9rn/WxARX9Rlbt9e4d81Q36HyfAO/S+6AaSNWZfj/4YdyrQI+AvLbNvR
	 vw4bIN0zdp1qDFWccRsIPywCMnAmHYBcIRn7G4u3/mQwfctLSViRRiShNxh+EqVZiv
	 Xi3Kwpsp4phag==
Date: Wed, 14 Oct 2026 16:37:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: thangaraj.s@microchip.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] spi: spi-pci1xxxx: quiesce DMA engines on transfer
 timeout
Message-ID: <a02880a9-f20f-45ad-b22b-c405fb7e74d0@sirena.org.uk>
References: <20260929081156.42124-1-liuwb@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7cpi9NjjqQPY6LAX"
Content-Disposition: inline
In-Reply-To: <20260929081156.42124-1-liuwb@xiaopeng.com>
X-Cookie: Live free or die.


--7cpi9NjjqQPY6LAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2026 at 04:11:56PM +0800, Weibin Liu wrote:

> Stop both DMA engines, drain the pending done/abort interrupt status
> and synchronize the DMA IRQs before dropping the in-progress state and
> the transfer pointers, and re-enable the engines afterwards so that
> subsequent transfers keep working. Also make the DMA ISRs ignore
> interrupts while no transfer is in progress so that a stray MSI after
> the cleanup can no longer act on the cleared state.

Why is the sensible thing to reset both channels immediately rather than
try to let the other one complete (or time out) if it's active?

--7cpi9NjjqQPY6LAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrPodMACgkQJNaLcl1U
h9DjZwf/fYmyR2iz3+WGmY3EZHeq8XdzPDyFm6m8Iclz2MWr8kInS5LNNkHiJSZX
dEyYA7CQPGKqtH0i015AVW79+mCjPJX1PpvNx5xocZcGkMPE+5e2rxn10A47jQAH
GCMP372sWelRTa2G1vwsdzR+CEjNbfE1yTRaAF9cdUKRdHEv9kPbdGZTfZEWseL8
q3u0oKY79+uLT/oRTgVanKTU5LR7DTKT02WO86bXx1dpR0Trcs77+Zz4ONRaD5C0
pprkp3Om1hAtxvM7lXHpFlDNPB0RdCvGRoipxhwhDkF0/36QI/yE/TJnwyNzPed9
qT2cT2k7kNmah6+WiSiaMP4wqVqI8A==
=yeHE
-----END PGP SIGNATURE-----

--7cpi9NjjqQPY6LAX--
