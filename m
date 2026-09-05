Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5FD453A5D;
	Sat,  5 Sep 2026 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597619; cv=none; b=Qli4ec2suHPT1tyd5Z7EyPsCaULal+5iGv5h+pDAAFgfr2qT+13lvhXOnx796zpS2Xepm9Zyz8vom9pIA9J4SmrGfDA/zyPpa01/RTkqRkJzTRgYx//gcievKrm+1AoNV73OqHZMXqVHT8+fqMLajXnvM33CwY+MT839bh/Tv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597619; c=relaxed/simple;
	bh=bk0Ouotjoxu1esIV6U1bVjhwYvT7zeApUPizjjGMCSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+PQ5uBi1Xg65uqeW5rr1c/SWQeKyeW6ek2a0dhTpIP48CD39+nuGWCwI/v6YjCiYxk5SFnm7oTSS/Cv1f32/PGVATJlVbVlBo1zRtSc9oz3yvvO4W+yGK8NR6FyqlyE8UhRQfANQxoBYGgKhNFMgySKHAnDRdpsdEFPd+up94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=QDHMnrMp; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="QDHMnrMp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=OAtLd3Ez46NTrxK5K3EUQO0fzQ/WT0nfCRvsp1/GzcE=; b=QDHMnrMpYnFG13HetmTJjIhNgR
	UxI8DmKjBJOfihDnDTzJB2ko48fUwLYIF3Y1t+2ho+eSWGBMgtnlS9w/+0DlrEi5o19wCMvGm4zBI
	owCMlbG9jTRE7wLlKysBzvS7romnk4qvTqPvhHi3nzxMl/3ikLkKviWWT5xWElMLhYZT/6wQ+6Eui
	cqSAciacn73tarFevWe39zT0xXreeHvpuRERL9NsSjGQ9Gv4WmC91dHoArU6P+ISBP+DIxNZKH6mG
	+r75pZPPYHKS7P4X5YUqo3f+4i+2sdd5Fw30QXsP+pg1VjP2VoH2NRBoXG2C8uZ+tWuSlitVO8nBi
	PZHqE+xg==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1x2lwO-00000000IbO-0dYX;
	Sat, 05 Sep 2026 10:40:00 +0200
Date: Sat, 5 Sep 2026 10:39:59 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	stable@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] clk: spacemit: k3: add CPU PLL rate tables
Message-ID: <apvVSlYm3ChVgErH@aurel32.net>
Mail-Followup-To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	stable@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260903-k3-pll5-pll8-1800mhz-v4-1-afafd9cb47d9@linux.spacemit.com>
 <apmuG46sBg2rGzCD@aurel32.net>
 <DL67LEVCXFA5.39M5FO7JGKWZS@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aPZdChsJ4jnX0xUn"
Content-Disposition: inline
In-Reply-To: <DL67LEVCXFA5.39M5FO7JGKWZS@linux.spacemit.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--aPZdChsJ4jnX0xUn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Troy,

On 2026-09-04 11:24, Troy Mitchell wrote:
> Hi Aurelien,
>=20
> On Fri Sep 4, 2026 at 1:27 AM +08, Aurelien Jarno wrote:
> > Hi Troy,
> >
> > On 2026-09-03 11:06, Troy Mitchell wrote:
> >> The K3 CPU PLL rate tables currently describe only one rate per PLL,
> >> although the hardware supports a wider range.
> >>=20
> >> PLL3 and PLL4 support rates from 1.05 to 2.4 GHz, while PLL5 and PLL8
> >> support rates from 1.05 to 2 GHz. Populate the tables with every
> >> supported rate in 50 MHz steps.
> >>=20
> >> Cc: stable@vger.kernel.org # 7.0+
> >> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> >> ---
> >> The corresponding U-Boot changes are available at:
> >>=20
> >> - Add the CPU PLL rate tables:
> >>   https://github.com/spacemit-com/uboot-2022.10/commit/787b5cf44c8dbc9=
9db886d5522c0c9cd5a96ffd6
> >> - Correct the 1.10 GHz and 2.15 GHz table entries:
> >>   https://github.com/spacemit-com/uboot-2022.10/commit/16a775c20e9efb5=
4ca55352215e76eb3f12e6cf0
> >> ---
> >> Changes in v4:
> >> - Expand the update to every supported PLL3, PLL4, PLL5 and PLL8 rate.
> >> - Drop Aurelien Jarno's Reviewed-by and Tested-by trailers because the
> >>   patch scope has expanded.
> >> - Add U-Boot references for the complete tables and corrected entries.
> >> - Link to v3: https://patch.msgid.link/20260831-k3-pll5-pll8-1800mhz-v=
3-1-530ed0978615@linux.spacemit.com
> >>=20
> >> Changes in v3:
> >> - Mark the change for stable kernels starting with v7.0.
> >> - Add Aurelien Jarno's Reviewed-by and Tested-by trailers.
> >> - Rebase onto v7.3-rc1.
> >> - Link to v2: https://patch.msgid.link/20260810-k3-pll5-pll8-1800mhz-v=
2-1-aabff510a797@linux.spacemit.com
> >>=20
> >> Changes in v2:
> >> - Drop "clk: spacemit: re-enable PLLs after init"; the PLL init issue
> >>   will be handled in a separate series.
> >> - Send the K3 PLL5 and PLL8 1.8 GHz rate-table update as a standalone
> >>   patch.
> >> - Clarify that 1.8 GHz is nominal and 2 GHz is an overclocking rate.
> >> - Link to v1: https://patch.msgid.link/20260804-k3-pll5-pll8-1800mhz-v=
1-0-a3a75866ce32@linux.spacemit.com
> >>=20
> >> To: Stephen Boyd <sboyd@kernel.org>
> >> To: Brian Masney <bmasney+clk@redhat.com>
> >> To: Jerome Brunet <jbrunet+clk@baylibre.com>
> >> To: Yixun Lan <dlan@kernel.org>
> >> To: Paul Walmsley <pjw@kernel.org>
> >> To: Palmer Dabbelt <palmer@dabbelt.com>
> >> To: Albert Ou <aou@eecs.berkeley.edu>
> >> To: Alexandre Ghiti <alex@ghiti.fr>
> >> Cc: linux-clk@vger.kernel.org
> >> Cc: linux-riscv@lists.infradead.org
> >> Cc: spacemit@lists.linux.dev
> >> Cc: linux-kernel@vger.kernel.org
> >> ---
> >>  drivers/clk/spacemit/ccu-k3.c | 96 ++++++++++++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 96 insertions(+)
> >
> > Thanks for the patch, it makes sense to add all the values, to support=
=20
> > future firmware changes. The values match the ones in the vendor kernel.
> I forgot that you had a similar patch as well..
>=20
> >
> >> diff --git a/drivers/clk/spacemit/ccu-k3.c b/drivers/clk/spacemit/ccu-=
k3.c
> >> index 92b930d5ff30..950bf531c734 100644
> >> --- a/drivers/clk/spacemit/ccu-k3.c
> >> +++ b/drivers/clk/spacemit/ccu-k3.c
> >> @@ -29,15 +29,91 @@ static const struct ccu_pll_rate_tbl pll2_rate_tbl=
[] =3D {
> >>  	CCU_PLLA_RATE(3000000000UL, 0x0b3e2000, 0x00000000, 0xa0558c8c),
> >>  };
> >> =20
> >> +/* Keep the firmware default as the first entry. */
> >>  static const struct ccu_pll_rate_tbl pll3_rate_tbl[] =3D {
> >> +	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
> >
> > Is it really necessary to put this entry first? I guess it's the curren=
t=20
> > default frequency, but we have seen it can evolve. From my tests, the=
=20
> > driver seems to just keep the value configured by the firmware=20
> > independently from the table order, so I am not sure it's necessary.
> I think keeping it first is necessary. If the current register settings do
> not match any entry in the table, ccu_plla_init() falls back to the first
> entry:
>=20
>=20
> 	ccu_plla_update_param(pll, &pll->config.rate_tbl[0]);
>=20
> [...]

For the A100 cores, that indeed makes sense. For the X100 cores this=20
line is never reached, as the line above just stops the PLL, basically=20
stopping the cores:

        if (ccu_plla_lookup_matched_entry(pll))
                return 0;

        ccu_plla_disable(hw);
        ccu_plla_update_param(pll, &pll->config.rate_tbl[0]);

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

--aPZdChsJ4jnX0xUn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUryGlb40+QrX1Ay4E4jA+JnoM2sFAmqb1VsACgkQE4jA+Jno
M2uixQ//RES8WuLUie3AuTbbVUU6IEn1sygwhNK59UGLSk29TXVz+3VON6s2OmTq
GMdxB1n29RGXgMA18bU7rOaRkfVLIcY+hoRz0TU2nx3zxxV6AUD6QT8b0155iSGh
KNG62S7LxgfbFX8/0PupM5otRdNLoSpDkR/cayfVo11BdnEI+yfpT0K0qEd79vYN
MjNzi3xZzyT/92goW1gZvK3m/ZM8ZgYje0tkD0iWANlb6GZEiaCT1Y4rqmCxnicd
G1zA2j0ifn+HdO5uAHLLU80I4nsN7cPxsBFYO5sHsAErWThO1PEFqRIxeVl52JwN
gzt8LEZyr/hOqqcR2u8Lylq5DBwMDg5efztqq7rzDoTQnubtZ8iMo+Eh5vtUKY8V
+2dcBryJInjLSYz2I0inkQVogwR49QEl3U5DBrufZg4NyLZqQHACXdTQQ3ruh9M3
ieZO5RrAWuAisTcqVpl92CNt/dskruNvkDbIONOpe2a2Jo11Qxf29X8tVIfQReO9
ba2YDQFkYOz48j3RJ2qJOcA4uKHP1ySiVBE7I8TY85NUAizgbFMLQodvctbA1JkC
RowF/E7qD1/EoGFiXBoYHdXFQzT9iZP2Dw5dPkDvzcMYkhQUKsMKNmg8xqqtPQha
p+Lnbcifd5eU/osmu6aIQW/wevYNJH9asZDcg43cL3i34s54Uf0=
=gEDa
-----END PGP SIGNATURE-----

--aPZdChsJ4jnX0xUn--
