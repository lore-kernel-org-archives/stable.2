Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7902367B8;
	Fri, 16 Oct 2026 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150606; cv=pass; b=DLEGwXDplJjjRNmiSg3QHJAic/nPehgZ4XeK2pJHKqJWWfumAtGn5RlYK6hHHbmurUSfEZnZ81ti8LbUVOK9pAxId0b+iZJBEi07dsEmWg350DZzabTACt3LmiSVyp4J11VPIUBKKYI6Zd3JfdMwQ+BTlxc3KkK2rq9gVlzhOYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150606; c=relaxed/simple;
	bh=tzY5QEGMldMFMWYFhCZmKsYBcURHIaWOsxBUwfoQiuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4C1377yU88tOwBJQIkiNmq3H39f4RiqIZGL9P+YNCPrk3KjOvBw2dCr53ZJqfwd2s/bFC6QB6arsfreWc2qgeJMGLzECsbJdzmTGKTw9plBuZR4NwfgC0xp8921jZgrOwnsaHk2dNRJrKwqge1iBxe01yiGQIOWEkvmw5P6X+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=HynWDrcF; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="HynWDrcF"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8B5C9201CE0;
	Fri, 16 Oct 2026 13:36:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792150601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEJst/GXmKkYt8SQhNaPHoR8evOoFIc/cAPHzDWYlLk=;
	b=HynWDrcFNGfC9YFOmCUhdZJIs2EVNJ+syoVGAZou2VzGCl8AEFKd0AbE/32l8FMM9fzmMW
	uwAXKFBMWdWH/WZblm+TB53gkt13ls9RhM+4oMd1m1FjwupCaHwEsaAHNaZaB6isTpxlJq
	3mFeVut5l4mKGSLiEb498aHaid15wlM3g+cWODRLViZr4ZaNma4kqo/owy7zgOnyTV5Rlr
	t398wyAfNc8dIdN9l9JfTUyMP8GwQalTsIcbs1cwPUkozokvrKb9c9S2zOfUt+6h+2KYfw
	Wu9LNF/NWC3eWFxnFOl/PcgOvbi1O1+wuVSnTk19qFvs6oFl3WDUzJW+6Vt+sQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792150601; a=rsa-sha256;
	cv=none;
	b=aamHjhexQOoB9J+f069zV8vWtxuqSwbUYoq7G/5CtVCNcishqZ7L+IdpoeECIhRrlz7Kin
	KTS9s/vKXA1HHS2mWKTENdptqiXj2GoEWGrFWGBrwLxpWTpBB2yKHp5FZB3JtdUNXWUaOY
	GHlA2iCJF8HuBUjl08+e1+Q9I32PGn6gZTbRAPr7i5K1T2z06IssmvnPWeAKrjXz763cJP
	FGXsN4ZJaWeqIQ7XqFfujSTDLbv8SEGN3VM0crA1IgLx2W8gV3pT/pwpnvDVp/PdVqiUwT
	uQQeDga1ulH5dUdayPvjly2oAZiS5S70IgGvJvuuIDeQJUnLOvWNjLLAwWEUVg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792150601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEJst/GXmKkYt8SQhNaPHoR8evOoFIc/cAPHzDWYlLk=;
	b=YRepB3i0fnKeBU+kC/IXyBl0sdC4WvUfAnt5GR0SkqJrSnNOdcm9ILHB6877dhKNhiYo29
	cSUoMLdotHgBEGQuty2bHSiyLmLc6L9OuQ3RFx3rtIt1zJp5KfkjdFZ1f5eHL5PPjqmr4g
	fPfCLjMbLvJ+uOALz9VwYMPs6vQfrQuruShx9oc1Irq1+pr3TGz9tpJmYI3rnlRpHsrCsl
	afrNM2eKUBcSf5bBAYw9Pdwcgnrh24y3V4svuvnP2+VnHf3agar3cRgbcM2BCg1BVDYJEx
	ef5hfdYH19EyZiiIP9APxVsRyJIjgrsH7QbPi9dJt3ceohrazTqdJINmfhQs6Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHgEr-006B4K-1Q;
	Fri, 16 Oct 2026 13:36:41 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2DB015C6103;
	Fri, 16 Oct 2026 11:36:41 +0000 (UTC)
Date: Fri, 16 Oct 2026 13:36:40 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Runyu Xiao <runyu.xiao@seu.edu.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH can-next v2] can: proc: reset pkg_stats atomics
 individually
Message-ID: <20261016-precious-industrious-muskrat-0c77e8-mkl@pengutronix.de>
References: <20261016110905.422684-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vylyqlbjgeczczd"
Content-Disposition: inline
In-Reply-To: <20261016110905.422684-1-socketcan@hartkopp.net>


--5vylyqlbjgeczczd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2] can: proc: reset pkg_stats atomics
 individually
MIME-Version: 1.0

On 16.10.2026 13:09:05, Oliver Hartkopp wrote:
> From: Runyu Xiao <runyu.xiao@seu.edu.cn>
>
> Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
> converted several members of struct can_pkg_stats to atomic_long_t and
> updated the hot TX/RX and procfs read paths to use atomic_long_*()
> helpers. However, can_init_stats() still clears the whole struct with
> memset().
>
> can_init_stats() is reached from can_stat_update() in timer context and
> also from the procfs reset path. Those paths can run while the TX/RX hot
> paths are concurrently updating rx_frames, tx_frames, matches and their
> *_delta counters. Hitting the whole-struct memset() in that window
> performs plain writes to fields that otherwise follow an atomic_long_t
> access contract, which can lose or mix live statistics updates.
>
> This issue was found by source-level API-misuse analysis looking for
> whole-object resets left behind after atomic_long_t conversions, then
> manually audited on Linux v6.18.21.
>
> Replace the whole-struct memset() with a helper that resets the
> atomic_long_t counters via atomic_long_set() and clears the derived
> scalar statistics explicitly. This preserves the existing reset
> semantics for scalar fields while restoring atomic access discipline for
> the live counters.
>
> Build-tested by compiling net/can/proc.o on x86_64 netdev/main.
> Runtime-tested with a QEMU + vcan setup on Linux v6.18.21 by driving
> concurrent traffic and reset_stats reads, which reproduced inconsistent
> exported statistics before the fix.
>
> [Hartkopp] can_stat_update() also read the *_delta counters at the
  ^^^^^^^^^^

As this is a regular vN+1 patch posted by you to the mailing list,
please don't add your [tag] here.

If you want, you can add a change log entry after the "---"

Marc

> beginning and cleared them with atomic_long_set() at the end. Increments
> from the hot path in between were lost for both the current and the next
> interval. Use atomic_long_xchg() to fetch and clear the *_delta counters
> in one atomic step instead.
>
> Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---

Change log goes here.

FYI: you can use b4 to pick up patches from the ML:

| b4 prep -n proc-pkg_stats-atomics -F 20260512133937.21957-1-runyu.xiao@se=
u.edu.cn -f net-next/main

Add the change log to the cover letter as usual, b4 will merge cover
letter and patch for a "series" consisting of a single patch only.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5vylyqlbjgeczczd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIMRgAKCRDMOmT6rpmt
0m+SAP0dOK4Yg4tt/8ytEHNzCnVqsm5KWy5uXpk9j28UWYsNvAEAuQIBhFjPBtgC
2pzca3fWvDtDNeViMBWYklhhUBB9BQg=
=lxSP
-----END PGP SIGNATURE-----

--5vylyqlbjgeczczd--
