Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166835F8B9
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931486; cv=none; b=r358NM9s847G/3PXJo1fU+UXvWTtmlrrPgyKv3RZ49YbkJP4GQCeztDC74pMKtKs5E3wj4p9u7YbHx4RrlBO9hJMA5KvHBAaylsR6fKxFYYk/7dTC6RfROrKCk4Xoxqb7puBihu4W0oi2jjNYOipFVqY3QYIsNrc1fbKfeIeNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931486; c=relaxed/simple;
	bh=5j/I7AVi0xll2QqyeskKm0Pq/Bxqw77h9LnRP5nnM64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oi3UNxvNOeBJIsAKvu5YgTepnebewfBmjBR+2Z9ngIBMPG98xT/VTmJPuwhuV66KUQBBVkFmBCcQ+iEUB82zR1LSgcXal0vN0EW7nnIrFmggJH7XanWVEJGuuGJRE0OOS1jgaa36DLbDkWu087mu25HfiVmSVIeYgRHO3Wd5jfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mp4j86rH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mp4j86rH"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a17c04563fso572247a12.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785931483; x=1786536283; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5j/I7AVi0xll2QqyeskKm0Pq/Bxqw77h9LnRP5nnM64=;
        b=Mp4j86rHnDjLhNYPS17wqLSbNzEqMbd54db2UM7Zu3XWTNiLSzdu9b4bmOMNaJezmQ
         lbOgDjwrUyNEvBcdghxLgwP4edxsy+lhf+FR+7AYvrT5IE314xCh4bDnCzOy7NUaOa22
         a5CGXxuB5syDsAymnABSGi4RDUkNMZneJXE8juZHqrt1uuXmXMDg1Q5YMPnBlfRCNna5
         /nNcCpR//g4VGD0E1+Wco4o61DSYoJQxXz2/3ltcgZQjFZw6IeF4pAKpST3zPlEXGW3g
         ojYZgJBWOsZPgF/7DRZpuNakJhVPrDRCg6mrejXhSOuP6hzw+zx9ps4WHR3jxG6lCioH
         HMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785931483; x=1786536283;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5j/I7AVi0xll2QqyeskKm0Pq/Bxqw77h9LnRP5nnM64=;
        b=kdYtdQ4aHg+OBnkQad12o7atAJtRqm3qODiM8nXZDJPqO1jyiS/oQT9B3hbopVNCHD
         MTbcYX3oEg+fp3rIoBcXtnqVmeWtwqwRiSZEPbX/NTDyXOXRouOZcOiUv9plxJnRt1W5
         X5Gw/As6Q2SypGxWoWu8gUBj6sotfbeqrrgTR/E23MNV088VVFj0CMMWpEuGPZc04CGh
         fLoksnMq7t9ldN/fL23DPTUbZIchWDsTmI0n0i0boNzjMwebYrfc2/ArZZuUrrahEQdf
         mPc4X1xPCv7hAfNo9zIahFpP+dyjLwt6O1BzkuYww4J1TJmHeZyCp7ukl1MmNbc/bM8N
         P+SQ==
X-Gm-Message-State: AOJu0Yx/NQEbZShw3cO56lppl8VTVBYuIN0RrlJnDYLbmF7czTKEmebB
	DT1aL70Vrw+Q9qaw0VHf/iC/i4gzWlF8ozL5A7dRztk9JCFvW6hph7B/R5OXkLTzLl4=
X-Gm-Gg: AR+sD11VgOYglTQTnQ4clrR7xycRImSwklP0kC37thLQhv0/tE4RXBhfGg9F5367nSt
	U4MNxH07SHBEcJJsJxxnCcbs74CdgUruLwrAOC9y20CSqdxmNk8/AaTsSYpaQHIJfvg0g3z6c5k
	tZIWsrrPza7r3dG2oG8iGkeRGjs5NDXVh4YCZuQvdQsuV71joqdus1mhc6fLzcJgxj4uW2B+mAe
	j2CDMwfWzj7s+o58ItW3Bf0geGuruC5WFkPowAzf1NWm3Q3MtWtOVM6xDMjtdt2Ug5H5yGIu3nP
	Lx5C8zaDiX/lJL4i/AkEhZDoxTXyAFV59UjGO8LwROr2VKW+NheFX7xsBzGNBTVz77QY3V+1Y+o
	J+ByXRTiDmK2E1LBP3MjJr7JMtYbmM2UMut6PBJJClhZFjxCQjToM0iBKlh3JQkBtK1SsHLm/0X
	zTHN7d3isd0+L1eYNk0rXj1xkKW7arN/x1h+UQoUQQGktFwy2fYbY0sLZXyGslhp7iDJmQRP6it
	6hctWZe0cD2b3wXqjMpJ7AKcU3rrfiZhczAkx4ZlaAhZpM+HML+BXkzNYRL7zZ3SEdMZP+W16cR
	sSRwrgfOX5aaxHk=
X-Received: by 2002:a05:6402:e0d:b0:69e:2d56:690a with SMTP id 4fb4d7f45d1cf-6a14f0bbe0cmr3187654a12.8.1785931483058;
        Wed, 05 Aug 2026 05:04:43 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1453d3825sm1959506a12.0.2026.08.05.05.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 05:04:42 -0700 (PDT)
Message-ID: <bed904b1-792e-4233-86a1-6c38678c9689@suse.com>
Date: Wed, 5 Aug 2026 14:04:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/xen: fix init of balloon stats again
To: Roger Pau Monne <roger@xenproject.org>,
 Roger Pau Monne <roger.pau@citrix.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Yannick Martin <yannick.martin@okazoo.eu>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Matthias Goergens <matthias.goergens@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20260805094008.95778-1-roger@xenproject.org>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20260805094008.95778-1-roger@xenproject.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nrg9apKmLaIB11gz9qpYEwWd"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nrg9apKmLaIB11gz9qpYEwWd
Content-Type: multipart/mixed; boundary="------------D3cUtnDAbK80qUskmqQx0yJU";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Roger Pau Monne <roger@xenproject.org>,
 Roger Pau Monne <roger.pau@citrix.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Yannick Martin <yannick.martin@okazoo.eu>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Matthias Goergens <matthias.goergens@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-ID: <bed904b1-792e-4233-86a1-6c38678c9689@suse.com>
Subject: Re: [PATCH v2] x86/xen: fix init of balloon stats again
References: <20260805094008.95778-1-roger@xenproject.org>
In-Reply-To: <20260805094008.95778-1-roger@xenproject.org>

--------------D3cUtnDAbK80qUskmqQx0yJU
Content-Type: multipart/mixed; boundary="------------OE5OoLbEmJF7vthcfOs1YCtK"

--------------OE5OoLbEmJF7vthcfOs1YCtK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDguMjYgMTE6NDAsIFJvZ2VyIFBhdSBNb25uZSB3cm90ZToNCj4gVGhlIGhhbmRs
aW5nIG9mIGV4dHJhIG1lbW9yeSByZWdpb25zIGRvbmUgaW4gYmFsbG9vbl9hZGRfcmVnaW9u
cygpIGlzIG5vdA0KPiBjb3JyZWN0IGZvciBQViBndWVzdHMsIHNpbmNlIHRoZSBpbml0aWFs
IHRhcmdldCBpcyBzZXQgdG8gcmVmbGVjdCB0aGUgcmVhbA0KPiBtZW1vcnkgdGhlIHN5c3Rl
bSBoYXMsIG5vdCB3aGF0J3MgZGVzY3JpYmVkIG9uIHRoZSBtZW1vcnkgbWFwLCB3aGljaCBj
YW4gYmUNCj4gaGlnaGVyIGlmIG1lbW9yeSAhPSBtYXhtZW0uDQo+IA0KPiBJbnRyb2R1Y2Ug
c2VwYXJhdGUgbG9naWMgZm9yIGFkZGl0aW9uIHZzIHN1YnRyYWN0aW9uIGluDQo+IGJhbGxv
b25fYWRkX3JlZ2lvbnMoKSBhbmQgaGFuZGxlIGV4dHJhIHJlZ2lvbnMgY29ycmVjdGx5IGJ5
IGFkZGluZyB0aGVtIHRvDQo+IHRoZSB0b3RhbCBhbW91bnQgb2YgcGFnZXMsIGluc3RlYWQg
b2Ygc3VidHJhY3RpbmcgZnJvbSB0aGUgY3VycmVudCBhbmQNCj4gdGFyZ2V0IHBhZ2VzIGFt
b3VudHMuDQo+IA0KPiBJbiB0aGUgY29tbW9uIGNhc2UgUFYgZG9tVS9kb20wIGFuZCBQVkgg
ZG9tMCB3aWxsIHVzZSB0aGUgYWRkaXRpb24gcGF0aCwNCj4gc2luY2UgdGhlIGluaXRpYWwg
dGFyZ2V0IHJlZmxlY3RzIHRoZSByZWFsIGFzc2lnbmVkIG1lbW9yeS4gIEhWTSBhbmQgUFZI
DQo+IGRvbVVzIHVzZSB0aGUgc3VidHJhY3Rpb24gcGF0aCwgc2luY2UgdGhlIHRhcmdldCBp
cyBzZXQgYmFzZWQgb24gdGhlIGFtb3VudA0KPiBvZiBtZW1vcnkgcmVwb3J0ZWQgaW4gdGhl
IG1lbW9yeSBtYXAsIHdpdGhvdXQgYWNjb3VudGluZyBmb3IgcmVsZWFzZWQNCj4gcmVnaW9u
cy4NCj4gDQo+IEZpeGVzOiA4N2FmNjMzNjg5Y2UgKCJ4ODYveGVuOiBmaXggYmFsbG9vbiB0
YXJnZXQgaW5pdGlhbGl6YXRpb24gZm9yIFBWSCBkb20wIikNCj4gRml4ZXM6IDA5NDljNjQ2
ZDY0NiAoIlBhcnRpYWwgcmV2ZXJ0ICJ4ODYveGVuOiBmaXggYmFsbG9vbiB0YXJnZXQgaW5p
dGlhbGl6YXRpb24gZm9yIFBWSCBkb20wIiIpDQo+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFBh
dSBNb25uw6kgPHJvZ2VyQHhlbnByb2plY3Qub3JnPg0KDQpSZXZpZXdlZC1ieTogSnVlcmdl
biBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==
--------------OE5OoLbEmJF7vthcfOs1YCtK
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------OE5OoLbEmJF7vthcfOs1YCtK--

--------------D3cUtnDAbK80qUskmqQx0yJU--

--------------nrg9apKmLaIB11gz9qpYEwWd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpzJtoFAwAAAAAACgkQsN6d1ii/Ey/j
bwf/fx2QwqDkGGCIigcGoZhn8yP3B7uDWZ+sZc7Bm1NfMoo/yOxkhdwtrt2Tz6AXVZNRcRiSNMil
aI/cHFD+uTmUapvrFEk8BYKvrg6lJut7jSOIrlGxQgW1ymY3PNRidN3mYLiZMT4jBNIJLfm0a4Kr
yxYxKgZrdc4Je8rqiak1mFCfsbvQZUzcaasimPbr78cfa+ssRXV9Cvhmsdk0fNKcsEyXvO3ugdBY
ewD1FKFt5C60Sv3V9hg6q9BGlwzeDjQimm7z942/kx9xhxsK+8sv3W/wFhxSpRaQwSSsiO20gzlA
OtZTMDPJCc0COKJi+cp1ZQk1MFbCIF+gH2ArpKtlXg==
=TvOA
-----END PGP SIGNATURE-----

--------------nrg9apKmLaIB11gz9qpYEwWd--
