Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD333DB645
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775058; cv=none; b=c6ZKY9Y0SI2/frukS0vncrITgY3e6i3rNK/LlUm85E3hPcGN5G7eVbnhYbooFKiiz3Pgfk5pbsNZiGn66SLBEUMseysvN0FxVijgz2P7hl6PV+xqNrGnUM2m9mR90gIULdwS7jPsgDi5U1u19kgMlRQBr2DPoCIviE9v1xnS+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775058; c=relaxed/simple;
	bh=dB0Vq19/pojtzKMdhU+ZjSekw7vileLMRuihFiNJgbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qgp2DkYT8ESrYV1K23ToR6TWA9ojBS1XHAc/GWKE63y/C+LQY3oTLfjY8sViyJ4IKJqBWoMC5fIkywEwT56nVT+maEEPkFJPS0byPGfQMVhwqGnp6G+DaF/4v7AnKXl55plGXF3ZG7hg6aOXNmetX2iy2kObJObXjxQIY74R3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=QZkCmAOa; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="QZkCmAOa"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ggwSm30plzg4l;
	Thu, 18 Jun 2026 11:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
	s=20220412; t=1781775048;
	bh=dB0Vq19/pojtzKMdhU+ZjSekw7vileLMRuihFiNJgbY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QZkCmAOaWPmGsisoVV7yHqc53vNnggu3Bg6/wYzJCYSgrPjBlmb/6HqOCH9HtFeq1
	 /oRHdXW3gab/eEdvxtLK+1V8QVwnAgC9tYBywtlMGqYamMHLA6yboVopbf8tiJVjxQ
	 sL/zRJUCBVWwLL8fkWBN2vWfTWGK0oP4O6u9NTbE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ggwSk2kZbzmC6;
	Thu, 18 Jun 2026 11:30:46 +0200 (CEST)
Message-ID: <ecb210fddc9f0926c98d682e8ffbf99defa05991.camel@pschenker.ch>
Subject: Re: [PATCH net] net: ethernet: ti: icssg: guard PA stat lookups
From: Philippe Schenker <dev@pschenker.ch>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, danishanwar@ti.com, rogerq@kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Andrew Lunn	
 <andrew+netdev@lunn.ch>, David Carlier <devnexen@gmail.com>, "David S.
 Miller"	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jacob
 Keller	 <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Kevin
 Hao	 <haokexin@gmail.com>, Meghana Malladi <m-malladi@ti.com>, Paolo Abeni	
 <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2026 11:29:24 +0200
In-Reply-To: <20260618091004.GG827683@horms.kernel.org>
References: <20260616143642.1972071-1-dev@pschenker.ch>
	 <20260618091004.GG827683@horms.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-b4MkfBcVTcys+AbJZKR4"
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Infomaniak-Routing: alpha


--=-b4MkfBcVTcys+AbJZKR4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon

Thanks for the review and I'll send a v2 with that blank line removed.
Saw it right after sending the patch.

Philippe

On Thu, 2026-06-18 at 10:10 +0100, Simon Horman wrote:
> On Tue, Jun 16, 2026 at 04:35:34PM +0200, Philippe Schenker wrote:
> > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> > icssg_ndo_get_stats64() unconditionally calls
> > emac_get_stat_by_name()
> > with FW PA stat names regardless of whether the PA stats block is
> > present on the hardware.=C2=A0 emac_get_stat_by_name() already guards
> > the
> > PA stats lookup with `if (emac->prueth->pa_stats)`; when that
> > pointer
> > is NULL the lookup falls through to netdev_err() and returns -
> > EINVAL.
> > Because ndo_get_stats64 is polled regularly by the networking stack
> > this produces thousands of log entries of the form:
> >=20
> > =C2=A0 icssg-prueth icssg1-eth end0: Invalid stats FW_RX_ERROR
> >=20
> > A secondary consequence is that the int(-EINVAL) return value is
> > implicitly widened to a near-ULLONG_MAX unsigned value when
> > accumulated
> > into the __u64 fields of rtnl_link_stats64, silently corrupting the
> > rx_errors, rx_dropped and tx_dropped counters reported by `ip -s
> > link`.
> >=20
> > Every other PA-aware code path in the driver is already guarded
> > with
> > the same `if (emac->prueth->pa_stats)` check.=C2=A0 Apply the same guar=
d
> > here.
> >=20
> > Fixes: 0d15a26b247d ("net: ti: icssg-prueth: Add ICSSG FW Stats")
>=20
> nit: no blank line between tags
>=20
> >=20
> > Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> > Cc: danishanwar@ti.com
> > Cc: rogerq@kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: stable@vger.kernel.org
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

--=-b4MkfBcVTcys+AbJZKR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmozunUACgkQjRDjR2ho
XxorIgv+MdrlIU+2xGujhlcXTn+Dsq0kw33yjB3erdz6HBgq+DdEkIa0y70uv3T2
MqpKAYE3rPZQ3S8fZWhmzeJAFFXTgVF+G9XANpH9K3f0GClORwvNfjKfeS6sbbo3
9eg+iiQbKUSRBp6gYmAWySaaVXtu1rl4dWav4PBpHz+E8psyn7gsdBTePWozMhSe
g9LI+eN8dt9j3khhcaSNQYulCe3GGomP5akVXTDNgYZo3fksJtoYX1r5wgYk78Ni
UGBZHDol//C/rhpSGh7OF/HkBhz0ALZ6ceA+HzfCMwbJWy8IStRHtmMVBUEg+jZC
sgJM8IRw5KRzVtp2N48ZgjYH3nryykpheySI+Rp9c7ZnY0Jqf+vDjS3ucjPUEmSk
XherZhqhT0+nE4eaYJDNU+F/QudOvMHSYH+sk3mnCjpuGdOai8BDdhV+oq1Ql0LV
W17nyWFwwmtgSQKbR3NV537nWIzKGqz5PEcHye6GowHRoTeH1rbLPSFYaIbPEvbd
kgjvWlmW
=KfCZ
-----END PGP SIGNATURE-----

--=-b4MkfBcVTcys+AbJZKR4--
