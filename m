Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452699;
	b=SzOzIXm3MV2iPe7Z+oX8eOv7eqLS2mz4IC1L53e0Po+vaOGqP1Ql8Q7xoyBH1t7dD/hK
	 9zBC0ySsk7yHVdQXLTW2SufDxjtB8dKtioywYq8oiJ99qK5PrVivfIGvploNTNbrsayuG
	 WJDganpCakP5nqGX58a0S0302d3zGU6sXRiSC3JWsflDfI4+/T7yibQEJp0CiZcLqBGZk
	 wCGs2ICXRH30qGNASOOTDkhrj/wExVmymhJ1ZG8D07BiTX5h11G4nnLOej+T9E9CqGEs8
	 llF07Gc9zE3A7z7P43W8t09TXSntoZ3KuvPdVvh4TIWw7t0vvw9ZZFA8aHcutV4Jcwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452699;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Organization:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Debian-User;
	bh=za8IpMaNBKctWkn/1MNH8UMo7sEqPrOViJQMh4D+tfg=;
	b=j4SNyMQ+FXIWUQT03hT069GwMtgfjm56Q99MhQuK/LHFS7zPE9u4PJIykTQq6cGrwC0Z
	 a+R7MASP50TQBhoKp59IS146ChqY0ocd5pqkyWOHWqMjkwkBbMOQLOKswgrlNN0q/Qw4N
	 sVRU/bViilBdDzgXsaunD86QdDQpbcP3hJwvbpTHDui5wD9C2732+FMehdOCArnIuBykb
	 1bepCgA9s57PGAd3F3fITpSS+e13baBDKhte5SANqi8t0jm+91wwtZBIfxJE3xbDx4Yvs
	 g/fDaJx6tQ9EaU3afhqNkPv2Qb9puIKoiGslkup44RZV4mLwjsH4+iOTVtsBzUo2gEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=df3CChAw;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66AC606A31D;
	Mon, 19 Oct 2026 23:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B66AC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=df3CChAw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=za8IpMaNBKctWkn/1MNH8UMo7sEqPrOViJQMh4D+tfg=; b=df3CChAw+Jp4sH/dTH/gYDyqbh
	kxNc6PGp85FAYWstzWn31yoLIjogW0p6e8synxmoxr4YKThAPgo6LZmiz1jmQCZnu5JpUof3lU86w
	ll7XDuBeH/+MS098zqwnnIMBYG07tBASzJgEYNuFSIb9rMWVGGSnVbeMIUMXxnLYCZdpZDbs80z7w
	ZTvrTMQ8PYyWE7NE+c0JL21JUfsZevDgmj9Sk6xLTRzQ35kNIhz5y33WLpDX/PrHctQMVC7hNcrJj
	eRDtnoCd4pE8H3AYuenJ+AqZK5PpgJdGmTDQdqUAKpU09V57kaMuJDIjrlb+I3qzlrnKvpiu9wASN
	Hw4JCcHw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <kibi@debian.org>)
	id 1xIwox-000OSO-24;
	Mon, 19 Oct 2026 23:31:13 +0000
Date: Tue, 20 Oct 2026 01:31:09 +0200
From: Cyril Brulebois <kibi@debian.org>
To: daan@amutable.com
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, nbd@other.debian.org,
	Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] loop, nbd: drop partitions left behind by the
 GD_NEED_PART_SCAN removal
Message-ID: <20261019233109.55q3cd266dfmkpa2@mraw.org>
Organization: Debian
References: <20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com>
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
	protocol="application/pgp-signature"; boundary="elh327wlbr6cddnv"
Content-Disposition: inline
In-Reply-To: <20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com>
X-Debian-User: kibi


--elh327wlbr6cddnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org> (2026-08-=
24):
> Commit 267ec4d7223a ("loop: fix partition scan race between udev and
> loop_reread_partitions()") stopped disk_force_media_change() from setting
> GD_NEED_PART_SCAN. The caller audit in that commit only considered the bit
> as a request to rescan partitions, but it did more than that:
> bdev_disk_changed() drops every entry in disk->part_tbl before it consults
> disk_has_partscan(), and only the re-adding half is gated on partition
> scanning being enabled. The lazy scan on the next open was therefore also
> the only thing removing partitions from a device that has partitions but
> no partition scanning.
>=20
> Loop devices without LO_FLAGS_PARTSCAN are exactly such devices, and they
> are not unusual. bdev_add_partition() only rejects GENHD_FL_NO_PART disks,
> so BLKPG_ADD_PARTITION works while GD_SUPPRESS_PART_SCAN is set, and
> parted, libfdisk and systemd all fall back to BLKPG when BLKRRPART fails
> with -EINVAL, which is what a loop device without LO_FLAGS_PARTSCAN
> returns.
>=20
> Commit c4f4c0fc551c ("loop: remove manually added partitions on detach")
> fixed the detach path after this was reported as loop devices picking up
> partition devices from a previously built image:
>=20
>   https://bugs.debian.org/1141434
>=20
> These two patches fix the two remaining places that relied on the same
> lazy cleanup, LOOP_CHANGE_FD and NBD_CLEAR_SOCK.
>=20
> Regression tests for both paths have been submitted to blktests:
>=20
>   https://github.com/linux-blktests/blktests/pull/259
>   https://github.com/linux-blktests/blktests/pull/260
>=20
> Signed-off-by: Daan De Meyer <daan@amutable.com>
> ---
> Changes in v2:
> - Rewrap the comments added by both patches so they fit in 80 columns
>   (Christoph Hellwig).
> - No functional change, so the review and test tags from v1 were carried
>   over.
> - Link to v1: https://patch.msgid.link/20260806-b4-loop-nbd-stale-partiti=
ons-v1-0-67bb75a8d7be@amutable.com

It would be nice if those fixes could get picked up eventually. They
received a few Reviewed-by and Tested-by already, and that v2 is only
about line wrapping anyway.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--elh327wlbr6cddnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmrWqDcACgkQ/5FK8MKz
VSCvkhAAhqVLbGz5HjwVZGJjkdHeLa6hXYQhAeqVuLTX+UQQLX0Tk60h3FYnG26v
e9tp/JM9YZZhH4Aom/3FjFehLF3S41wmTLxp0sdoZXwPndkJhjApgHkzR641fHfl
tJogKcj/uRrsBKkZD/tjXBKM7NVec49ji2Z6oLjszff5ZWFq/voILzDmIRfLP1iv
k48pzEzvpcu4DJC+Wrjhog5C2sV+X2riMGtnRPNo+5w8zfOfVjQPiq1qMJtWNYzx
GJjq7zL8D4baq2tf/CmXjC3IKFnwm02Ybq/Od+3d519s85eKzOUC9WWFT5GSpQ+u
VuoujYPtzcRRLxjkWivZJSl5c3XMlDg+9oSMCyZBqJ6XO70UdMCo7tS7gbg9MA7x
w/Jb2E+kMAU9ErX40CYy8aEP+EvjPPSs5O0gD648abhpG9Bu+i1V/8IH44rZcCBG
8PRlu+C9YEN0SDePHryjCrwpqOFXHbEldTLFWWCNVlqQPHVSGKCBBQutNOUlGtkb
2U54cbHV8xIQjsziJxq09w2WltX1dAZxGv11McnS/0qpLgynfbzpCMeGxkKZSYnN
UxAvMhxlpRs5WmhYJtpzIpvyDPwjUbKtDWNuMqvFKpfMS2z1cuIO5tVpZtEaPoJ5
bVN/5lKSuvOeoAX3iUiju4lYlMHvOoJKPX5bpFzWwo+qhD4EfLs=
=vHGk
-----END PGP SIGNATURE-----

--elh327wlbr6cddnv--
