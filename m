Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686731;
	b=Q+KI8yeJPp8tMHV3wxgNX5T7xK68wPbkUebq1dAvnH3voZycJlHHQ7i1RynuBWg4zGEP
	 dlD0eOX5DhbYIpiqUPwTPoFtByx7tgbb5y4EVERaT2tcr/4NoePKTicGfvNoqy59cjhdM
	 ayctOR2DxjarhvUf2r2xE4muQkKHviIwvwbuqmN1n3ajMgPVlxWsPPx+hSWUbSrSYwwuI
	 RSQBy6x/FBhqiSM0hmdD0XBLanZ5cJLO5cGFwyOAJ5hBhs/tZKVdslRKaLjoeJ346ZNSk
	 O9bvuSWDwH8UkjULcLCVEAjUTDlaHIntJoqaPEmcnNrctH43y45yyw9/oNgYxps+shw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686731;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=W3r6ORuiSiovUqR8HJr5KNqxWwOORUIitHy4BYhce6g=;
	b=OAsGVu0LtVJDY7cuOqqdWSZa5wTqNPVgK6efMvDlgTDyI88dzZVDYZ1aafzguSAWNL2m
	 3EEXWtlbq/OE4xdjgiAIpaWHvr5ElkdwD8+OhT/n8PVuaXmMkvEXszwdLUSIFH2jQwRdI
	 7DDoUaVfsD/AQT5tAw36j4hGbjpXaM4v7opjNlYQiychoOwv5BIqnTqZLD0h4X4h4jy1T
	 gEM76bL2mp/RjQj/wUnqOHmxnulnQ0SIhP8IbfVHiIqhJXwV0TCCOcZr0SQ/I96staNHJ
	 nGiedK9ivplQQQEwMVGWCDO1O2ec6eUzy5seC1Sz+ScNHcpV8fy20pCP1WCTbbRuKMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bZu0Tcdu;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE8606A31E;
	Thu, 26 Nov 2026 09:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EAE8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bZu0Tcdu
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5987C108B73;
	Thu, 26 Nov 2026 10:52:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795686725;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=W3r6ORuiSiovUqR8HJr5KNqxWwOORUIitHy4BYhce6g=;
	b=bZu0Tcdu6mIQYM8pV/3z9Hb5u72qO77TBWW3DKVvtTnW/QBXsmvXpl8aQDNn9LitmHcsGW
	r0FG31tpfsupf5z7dyn0z+N4zssCbboNoqrJOpZl+KRlF1VHojtkZNgK2leJcLl547Ib6x
	3iJvk4DDRtidPJXfMxuWcD3fbT6zAQBLPExT+DTt7wl8cy+C7SrdS1nMFk0r94RcIeR4CZ
	SMm/i4LT1oe11bnbd9ikeaBPpdFxUgeEb3wcyLJP3puJWRzh33LzZ3tGI8ifccokJs/iZN
	DRtfJqDRt8veqLbIQh0LGa9dqPTTH27waj0lkabg4l0IoSumcq/86rtxSczZ/A==
Date: Thu, 26 Nov 2026 10:52:01 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/990] 6.18.66-rc1 review
Message-ID: <awgBQVprao4I1Z-W@duo.ucw.cz>
References: <20261125143822.072087159@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W0wYcu09P7p7HWI/"
Content-Disposition: inline
In-Reply-To: <20261125143822.072087159@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--W0wYcu09P7p7HWI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.66 release.
> There are 990 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We see build failures here:

fs/nfs/nfs4proc.c: In function 'nfs4_proc_unlck':
2654
15:42:27
fs/nfs/nfs4proc.c:7331:24: error: variable 'cbnl' has initializer but incomplete type
2655
15:42:27
 7331 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
2656
15:42:27
      |                        ^~~~~~~~~~~~~~~~~~~
2657
15:42:27
fs/nfs/nfs4proc.c:7331:54: error: 'struct cb_notify_lock_args' has no member named 'cbnl_valid'
2658
15:42:27
 7331 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
2659
15:42:27
      |                                                      ^~~~~~~~~~
2660
15:42:27

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/3114405638

Best regards,
										Pavel

--W0wYcu09P7p7HWI/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawgBQQAKCRAw5/Bqldv6
8sM1AKClW2BoWl9YjbGroubo0HJVV3DcuwCcDQUYngeCtiH2+hhHyFnB1YmHIEQ=
=JNt9
-----END PGP SIGNATURE-----

--W0wYcu09P7p7HWI/--
