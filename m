Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617503EDAA3
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474883; cv=none; b=p4duiQlU2DgdRcIvwcBEmTCx+HfYHwJsicm3468WNH80MvcD2yFgeTF5ikDw+b2ptz0lkwGuDCtkmSZWaeOru8nDw02eKYUzJkomcHW8Gxe9vDNk/HGNknfG1n89cSoJcRTtDjbEyXmt63YJcgl1UCbJlt++/8R9ZoVn88xB2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474883; c=relaxed/simple;
	bh=x+TmX7w1PT7vRBJkNR5h2wtF+y+QM/D0BxBTQByurWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9b6ujp7aFHXPzguNKAowwzZjzGG7lz/exdYAIWUZ4mBwwtt52pqE9N7flOfF9zjDAPDmFgWweq6D+6g9oV5SqCL0V3BY3nndbYubepY2xIoox3si1NoUu0EDpnQDz+61SHqgw85F6r04HGMfDe2U0uhOIExA16C7AuiqWtC7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XnUtm3cY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XnUtm3cY"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso1611520a12.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782474876; x=1783079676; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x+TmX7w1PT7vRBJkNR5h2wtF+y+QM/D0BxBTQByurWE=;
        b=XnUtm3cYlDjz9TKg17qhZHTD8PXN9BpRauJNQ7KAIIaQA/dw2eJyJu0BLcI3sLaXvq
         rKd+a/B7NFsxrUBw0UQsXkfO+RgbbX1dkvmC/LZIhppYQIP2PqDvYrIJ8Q4kLUF+cqB+
         h4HAn0I70mK69+1DZEr7Jmoweod3fdusX/uJ57iNT6OTjTilgXVgwH1Z+ckg7GRwwDeA
         +AVWGMxWCqadIm68FYkIzXzPB6oEcqmHJmqyU1NdYmnDQQQQ0dZBG3M8dl+bET6qfeGu
         hTLu0/t3vMfCA2r6Y9cRunouZQWqGHcO0I3p72lHrNVzcrskkPzZ8GaIpLmB58Q1wWGy
         O9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782474876; x=1783079676;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+TmX7w1PT7vRBJkNR5h2wtF+y+QM/D0BxBTQByurWE=;
        b=Y+I9trpG3D9EZIf59LVUpqZVvZJbsIgVT9hYXrSetxPJP01BQT7ZG7g2cCLO62s9ri
         zgDVlrr7RV61xYlztjPtvzCx6W3+aiWZd6X1abkL6+Uj27DyDDeWH2Sg4GA1cP7qz3g1
         fwM1n8mUqU8n8mWwgtQDY2t8gOmtyPphC6gIc6rGS1Qmpg8XkID2jmhVI0unu/UPruXp
         s7c9kuBXCr9bYEJDpzRDLHETO+7bfQIk4iRVZuD/1wBjLfJLdTzSTXY8jwcg1edizAny
         kvOlH5MYwCBa+O9+/yriGPy6t7GTyHUIyQlure+NvsP97pA7RUVYN3HezOE7uVcAFUHW
         RqYw==
X-Forwarded-Encrypted: i=1; AHgh+RpiNiPB3GaGxzhG80AsbIAj8NpL0aOkg1A6cfn0a8RoI+BG+hG8HS3Y8y1DXwsqo72B6MBZHWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMfjiJRbaInkumvBxVR7euuBWQrWVrqeGzNLKjNVPyqqPIl2rJ
	Eogz7sIaOnkq+CxKsdlQULVc54nwqOEHx3gjN7+Ne2OVmnvALVaNC7Bo0VNZSGzNS4w=
X-Gm-Gg: AfdE7cntXItG6v5Zzgpkn2S5fuOYgVD5E2mpoWAUbEEomjVNY6Xk24wSu7+xRybjImf
	f5sdo1Iq1S76hwrcjAFhuJ9zGe0JZmz7VA6EWlVChwEu+7C/q8ZdqJVIm4dSJFS7EKTrHbz6KtY
	xAGRBiHhkojPi390Dns9YNj48uinsa9rUjgqWt4tU8JUltO3K7Ruqw/tj5QsvA/NT9wK+tlEDHI
	COUaenPUuC5lVO5upYY6fjZj1M1NheSHNb7vYMhBla/kaVmV8/5gYOm5dlbU+/6GNn96pK9db2u
	tMcFHYasT9pE7ApMNTG6Qtt6uwuORTzQ4KDtX19r4f/fHgUh25ctyZ1nY32t39quNkc7WKoLmdm
	aP8tz63f1iwM/3jwaDW3cqubNTuKVpdz15G1IUFIhmThsrhxXSt7vUTNLz5fTMnkz7elAnGnRc1
	X5nqYy3M8xRnjkl7qQxoWqsLlVi3KaInpilh8QT1KpgZV+Ya6jqmSUrXV2d2In5ndnEEWAYCDKJ
	BPIp+A+mvA3aawYHAKZPPIlWBYzRdQrDSRwZEUtY34=
X-Received: by 2002:a05:6402:35cc:b0:697:8341:9e40 with SMTP id 4fb4d7f45d1cf-69810a5c974mr1962877a12.5.1782474876237;
        Fri, 26 Jun 2026 04:54:36 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6980afa5051sm1467048a12.9.2026.06.26.04.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 04:54:35 -0700 (PDT)
Message-ID: <7088227e-f9d7-4f7e-89d4-3f867e41e17e@suse.com>
Date: Fri, 26 Jun 2026 13:54:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xen/gntdev: fix error handling in ioctl
To: Wentao Liang <vulab@iscas.ac.cn>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260622112541.38194-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20260622112541.38194-1-vulab@iscas.ac.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ikMPtP8pqTe7gsOWzBPSZl5g"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ikMPtP8pqTe7gsOWzBPSZl5g
Content-Type: multipart/mixed; boundary="------------AbOhyCuRAqPHWB6rPr7RMyXb";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Wentao Liang <vulab@iscas.ac.cn>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <7088227e-f9d7-4f7e-89d4-3f867e41e17e@suse.com>
Subject: Re: [PATCH v2] xen/gntdev: fix error handling in ioctl
References: <20260622112541.38194-1-vulab@iscas.ac.cn>
In-Reply-To: <20260622112541.38194-1-vulab@iscas.ac.cn>

--------------AbOhyCuRAqPHWB6rPr7RMyXb
Content-Type: multipart/mixed; boundary="------------LYTs8NATEmO7mUClhECJ0Njj"

--------------LYTs8NATEmO7mUClhECJ0Njj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDYuMjYgMTM6MjUsIFdlbnRhbyBMaWFuZyB3cm90ZToNCj4gV2hlbiBnbnRkZXZf
aW9jdGxfbWFwX2dyYW50X3JlZigpIGZhaWxzIHRvIGNvcHkgdGhlIG9wZXJhdGlvbiByZXN1
bHQNCj4gYmFjayB0byB1c2Vyc3BhY2UgYWZ0ZXIgc3VjY2Vzc2Z1bGx5IGFkZGluZyB0aGUg
bWFwcGluZyB0byB0aGUgbGlzdCwNCj4gdGhlIGVycm9yIHBhdGggcmV0dXJucyAtRUZBVUxU
IHdpdGhvdXQgcmVsZWFzaW5nIHRoZSByZWZlcmVuY2UNCj4gYWNxdWlyZWQgYnkgZ250ZGV2
X2FsbG9jX21hcCgpLiBUaGUgbWFwcGluZyByZW1haW5zIGluIHByaXYtPm1hcHMNCj4gd2l0
aCBhIHJlZmNvdW50IG9mIDEsIGNhdXNpbmcgYSBtZW1vcnkgbGVhayBhbmQgYSBkYW5nbGlu
ZyBsaXN0DQo+IGVudHJ5Lg0KPiANCj4gQWRkaXRpb25hbGx5LCBnbnRkZXZfYWRkX21hcCgp
IG1heSBtb2RpZnkgbWFwLT5pbmRleCB0byBhdm9pZCBvdmVybGFwDQo+IHdpdGggZXhpc3Rp
bmcgbWFwcGluZ3MuIFRoZXJlZm9yZSwgdGhlIGluZGV4IHJldHVybmVkIHRvIHVzZXJzcGFj
ZQ0KPiBtdXN0IGJlIG9idGFpbmVkIGFmdGVyIGdudGRldl9hZGRfbWFwKCkgY29tcGxldGVz
Lg0KPiANCj4gRml4IHRoaXMgYnkgaG9sZGluZyB0aGUgbXV0ZXggYWNyb3NzIGdudGRldl9h
ZGRfbWFwKCksIHJldHJpZXZpbmcNCj4gdGhlIGNvcnJlY3QgaW5kZXgsIGFuZCBjb3B5X3Rv
X3VzZXIoKS4gSWYgY29weV90b191c2VyKCkgZmFpbHMsDQo+IHJlbW92ZSB0aGUgbWFwcGlu
ZyBmcm9tIHRoZSBsaXN0IGFuZCByZWxlYXNlIHRoZSByZWZlcmVuY2Ugd2hpbGUNCj4gc3Rp
bGwgaG9sZGluZyB0aGUgbG9jay4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+IA0KPiBGaXggdGhlc2UgaXNzdWVzIGJ5IHByb3Blcmx5IGhhbmRsaW5nIGFsbCBlcnJv
ciBjYXNlcy4NCj4gDQo+IEZpeGVzOiAxNDAxYzAwZTU5ZWEgKCJ4ZW4vZ250ZGV2OiBjb252
ZXJ0IHByaXYtPmxvY2sgdG8gYSBtdXRleCIpDQo+IEZpeGVzOiA2OGIwMjVjODEzYzIgKCJ4
ZW4tZ250ZGV2OiBBZGQgcmVmZXJlbmNlIGNvdW50aW5nIHRvIG1hcHMiKQ0KPiANCj4gU2ln
bmVkLW9mZi1ieTogV2VudGFvIExpYW5nIDx2dWxhYkBpc2Nhcy5hYy5jbj4NCg0KUmV2aWV3
ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQo=

--------------LYTs8NATEmO7mUClhECJ0Njj
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------LYTs8NATEmO7mUClhECJ0Njj--

--------------AbOhyCuRAqPHWB6rPr7RMyXb--

--------------ikMPtP8pqTe7gsOWzBPSZl5g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmo+aHoFAwAAAAAACgkQsN6d1ii/Ey/o
4wf/ZQZ7RIw0FtWPZ37MjXZ2h92+r+v1EGz3o/z1P8cYfQpS6d5uDR77zw3DO2dSVWlLfakoB/8m
Me/mhHJrk51E2ooZWuuxCYU5l8GjnGh6IUIhvPBrE0k6WilEZJadLWn8ZBs73vZRb8PMG9qO3qXk
3jugNgK0kZIiYd+XQLRFbCYmcLjA8DmgOqELPdeAfFOeJRmMJWoSOoG0oRjWNh+xTd5FEWPcqIIv
W4UYQtM3XwqEjDh1Y6gLBno8XylRkZMsgK8xJUzRxoybbmRdkGEHcKUsrcXxSW6SQ0dOPbXszoAo
x5LsflKqGCvbBRC9QMKwTsOMqozPDpoe1x0gGYMhzQ==
=kSOp
-----END PGP SIGNATURE-----

--------------ikMPtP8pqTe7gsOWzBPSZl5g--
