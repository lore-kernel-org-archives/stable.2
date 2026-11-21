Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.48.52.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795277300;
	b=UK3B5sWyjf2isu9xP2eNsOoJwOr1PECpu7rgiV8RNaYfL9FOXiBywetGdNTMJPOmFIIa
	 F2cBkCEaQHIGh2rJYA4oSEtGguQ9p06DJvE8pVpiMnah5dHaHRINJaA9t25crgb/9nqGn
	 6Ga0bwMiD4BpC4XQM29soqIx6ewG2TKyKkG1RD6G/ERgPFxx+J00YL3UvUHl3U+g2WBE8
	 H2x4g/WaqEzvMt+7IXFDWDB2fPy0wicH01a+e75TJuXpNmEDFAXK9wd3x3WuCRwug8l1/
	 HjMRDfz1/QbPR7yr4JSPTYDYid89rfEl12uYTA09Av1qZ8l4FZg9GW26hX1e9Ml4ySA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795277300;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Jabber-ID:X-GPG-Key:X-GPG-Fingerprint:X-GPG-URL:
	 User-Agent:BIMI-Selector;
	bh=T7QCWRyUzgCmXFFsU24+pNj6FeTn5AFMkdvpDZELwrU=;
	b=2iCiYfqBZiGvooD6JjgzwErJQkmGjxt1J6hF8+c8Y9BRKJw+3Jg3YxpU013nlf0NrAxK
	 i53yfeYpVPR0B91ETaOxzTW4AJPtpRfhRVcKsMV27ntCgg9VSksRUfoBpZugbD/FzhefP
	 wjvCvoVtJfrAtWq2ixs9A4JGikVfBQvjsrzZ6dRJMrChuTbv6Y1BEcBqkudw5+1SKIDgH
	 1OVm2a6LSXFrsvylx4tCFNjrdKjISP8fSMDJuE7bSD3dPWsyDohw7lJo6ZQCo2oUboOEW
	 LoNgxgCkYEpi2PrsTkCYNg2lmCQF7+1ff6r/ylfKVsBCOdjcrwL2rb6RbK/8f8C/peA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jacquin.bzh;
	spf=pass smtp.mailfrom=jacquin.bzh;
	dkim=pass header.d=jacquin.bzh header.i=@jacquin.bzh header.a=rsa-sha256 header.s=20240222.rsa header.b=FMF4jTAW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.48.52.25
Received: from mx.eu-west-1.pants-on.net (mx.eu-west-1.pants-on.net [52.48.52.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578A606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3578A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jacquin.bzh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacquin.bzh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacquin.bzh header.i=@jacquin.bzh header.a=rsa-sha256 header.s=20240222.rsa header.b=FMF4jTAW
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=mx.eu-west-1.pants-on.net; s=20240827.rsa; t=1795277298;
	 b=aeraqTG1hgmB2Altaterfl0m950IoV7V3k0Gtuk4w/KE2oAzhSKthjb4A/5GXQ5+WfPwUGRlqC
	  7rDdDaUn46EzyTIs91SuvwHg8wn8Y07N1krXkunyPE1H1m5jwn1PvAjAf3rAsF/7ZybIrvd6W4
	  5oHdrjGPvaBSYzf6Vuq3blFnyx41WKC5vgvlVA4EK/Hn+8iG9ObMs24jdEbkTFV60C2AHNzd82
	  iVeivVsxVyFzIjbQdRNi0wJ2q3hkfNecgWusJ4cxaHlIbi6pkLeoT3zhF0JNtFMdyXf5QstHuB
	  Klo2LdCPrIbhA4WcFqwS6WNQqQeBTwmyBTIjdOxCFDQ/Ow==;
ARC-Authentication-Results: i=1; mx.eu-west-1.pants-on.net; smtp.remote-ip=2001:470:1b3f:100:1d9b:8401:5f90:f557;
	iprev=fail smtp.remote-ip=2001:470:1b3f:100:1d9b:8401:5f90:f557;
	auth=pass (LOGIN) smtp.auth=bertrand@jacquin.bzh
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=mx.eu-west-1.pants-on.net; s=20240827.rsa; t=1795277298; x=1797955698;
	bh=58fm3CVXeRLG5UHErYGGTdUQJcERXxICyF2XTo1Ffts=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature;
	b=PKxceUVknpWr7ZEO8v27EpLcLvPrSFtaEMx46FnDRBkhoCR43mgL6NiyuWQzRjiP2L9Gg5LayH
	  XLd6+y3CtVnwVYbEwQt+yJgZulKSppLP5u6tiSWI9RymyNMfWZixPiSDsfcnjEdnk8Rl/ry7yw
	  yY3s+6Lp7jxaEUKkyL+Libw7gkVYbd6zjxxOZT8nCFSK6JVWolR9+YJdj+xghKGJmakT0yf2l6
	  qbcL+y5AGzvsDy2PXpQBxNHsLijBITBaSN+01LE7DQi18QTdQwbYrnQKsd3uJOuzRXxR+OO6Dy
	  v8PswCZnK6vVK8DFG8YINEx4g5sNkGUwxoN29UzvrbV5dg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jacquin.bzh
	; s=20240222.rsa; h=BIMI-Selector:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
	List-Owner:List-Archive:Author;
	bh=T7QCWRyUzgCmXFFsU24+pNj6FeTn5AFMkdvpDZELwrU=; i=@jacquin.bzh; t=1795277298
	; x=1797955698; b=FMF4jTAW0OYIr19KhDCpCX7iyPX4DwX5Xc2T5cGuwPdL1tnNB06PFSyo+Uf
	icnj005xez7v0pfRbpwgcorE3DtlLgIMrQ+poJTZfdP6Pmkz00Zi2lDpdo17zyU9717kDw2psYcdN
	FOmVZu/NtPUs49vS9Mwn34dv7K6iKhvsXZUxlCAdYtA1WLl/O/u2iKPzNrFkqIXbnZO9LGMovVhPY
	uFC223bwZHrNVUAuXfM9mGlVdqQTv0tS3cmxrfwR/jWD1IZHJxXmUw4ojx6saV0tV7HtVswa5P/KL
	iZ2choLEiqO3yjo5VOauonL9r5ZN3MEySBUjSg+YczgBgfvAtmKQ==;
Authentication-Results: mx.eu-west-1.pants-on.net;
	iprev=fail smtp.remote-ip=2001:470:1b3f:100:1d9b:8401:5f90:f557;
	auth=pass (LOGIN) smtp.auth=bertrand@jacquin.bzh
Received: from lady-voodoo.lan ([2001:470:1b3f:100:1d9b:8401:5f90:f557])
	by mx.eu-west-1.pants-on.net
	with ESMTPSA (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	id 1xUndR-00000000Wbi-0100
	(envelope-from <bertrand@jacquin.bzh>); Sat, 21 Nov 2026 16:08:17 +0000
Date: Sat, 21 Nov 2026 16:08:13 +0000
From: Bertrand Jacquin <bertrand@jacquin.bzh>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, venkat.jayaraman@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference in power
 level debugfs
Message-ID: <awHB7a-zLM3GpC9C@lady-voodoo.lan>
References: <20261010120357.4937-1-bertrand@jacquin.bzh>
 <2026112040-splashy-power-2d46@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GYTIzekBzJjw16ds"
Content-Disposition: inline
In-Reply-To: <2026112040-splashy-power-2d46@gregkh>
Jabber-ID: bertrand@jacquin.bzh
X-GPG-Key: 0xA3B5C016618D9AAA
X-GPG-Fingerprint: D71B FE62 F66F 3C8B 1A25 A461 A3B5 C016 618D 9AAA
X-GPG-URL: https://keys.openpgp.org/vks/v1/by-fingerprint/D71BFE62F66F3C8B1A25A461A3B5C016618D9AAA
User-Agent: All mail clients suck. This one just sucks less.
BIMI-Selector: v=BIMI1; s=default;


--GYTIzekBzJjw16ds
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Friday, November 20 2026 at 13:29:13 +0100, Greg KH wrote:
> On Sat, Oct 10, 2026 at 01:03:57PM +0100, Bertrand Jacquin wrote:
> > ucsi_register() creates the debugfs entries right away, but
> > ucsi->connector is only set by ucsi_init(), which runs later from
> > ucsi->work and only publishes the connectors once the PPM has been
> > reset and all ports are registered. Until then, or for good if init
> > fails, ucsi->connector is NULL, yet the peak_current, avg_current and
> > vbus_voltage show callbacks dereference it unconditionally.
> >
> > On an Intel NUC13ANKi5 whose PPM never answers when CONFIG_ACPI_EC=3Dn,
> > reading those files after the failed init oopses:
> >
> >   ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
> >   BUG: kernel NULL pointer dereference, address: 000000000000045c
> >   #PF: supervisor read access in kernel mode
> >   RIP: 0010:ucsi_debugfs_register+0x291/0x420 [typec_ucsi]
> >   Call Trace:
> >    <TASK>
> >    seq_read_iter+0x1e4/0x4c0
> >    seq_read+0x12b/0x160
> >    full_proxy_read+0x9a/0x1f0
> >    vfs_read+0xba/0x320
> >    ksys_read+0x74/0x110
> >    do_syscall_64+0x79/0x240
> >    entry_SYSCALL_64_after_hwframe+0x71/0x79
> >
> > Return -ENODEV from those callbacks while no connector is available.
> >
> > Fixes: c851b71fd6cd ("usb: typec: ucsi: Add support for READ_POWER_LEVE=
L command")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bertrand Jacquin <bertrand@jacquin.bzh>
> > ---
> >  drivers/usb/typec/ucsi/debugfs.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/=
debugfs.c
> > index 77a0dd75edd3..911a151ac16a 100644
> > --- a/drivers/usb/typec/ucsi/debugfs.c
> > +++ b/drivers/usb/typec/ucsi/debugfs.c
> > @@ -92,6 +92,9 @@ static int ucsi_peak_curr_show(struct seq_file *m, vo=
id *v)
> >  {
> >  	struct ucsi *ucsi =3D m->private;
> >
> > +	if (!ucsi->connector)
> > +		return -ENODEV;
>=20
> What keeps connector from changing to NULL right after you read from it?

ucsi->connector never transitions back to NULL. only ucsi_init() writes to =
it
through ucsi->work where it's assigned only once, after all ports are
registered. Every failure path before that assignment leaves it NULL and ne=
ver
cleared afterwards.

The only end of its lifetime is ucsi_unregister(), which calls
ucsi_debugfs_unregister() before kfree(ucsi->connector).
debugfs_remove_recursive() waits for in-flight readers to drain (the
full_proxy fops hold a debugfs_file_get() reference and
__debugfs_file_removed() waits on active_users_drained). Any read
after that fails with -EIO. So no show callback can run once the
array is freed.

A reader can therefore only see NULL (init still pending, or failed
for good, as in the reported oops) or a valid array, and the check
handles the NULL case.

Cheers,

--=20
Bertrand

--GYTIzekBzJjw16ds
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYIADkWIQSg5iBnnersLYwElb5VNIcfLi6T2gUCawHB7RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQVTSHHy4uk9qw+AEAvZ8B18m9//IL7NJkDi/w
pIafHYGz3lnNS0AO97123uQBALh65kt7IvInscJ3ksEIje2IoJiWyBmntSFLzBuw
TzkN
=KBWo
-----END PGP SIGNATURE-----

--GYTIzekBzJjw16ds--
