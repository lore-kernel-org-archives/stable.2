Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED683DB640
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914016; cv=none; b=lvCaC43IS/oNTPViy74pzc3pbkolG8f1GwM2v/+jVcnBP+cXViUHx3IlFsNNPwzI9nMcGSfBRt0E7PC0HNRnYNb78403aPILgz9FWv9mzARt4xCq1N68Ib5phXSkFmIdJAA2+ZMpS4RYVT5P3MZ6R7KhwHpiD877doR7UIIr1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914016; c=relaxed/simple;
	bh=drHrC+qdqsi+PR/0lRsf/Ub+SUFkFlPx++QVFcFYlko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mj2RtX2W2p/TnrW9jXSeOxmRtTXcC9Bk38eKxsn/xrDhBpcyuFnSyPz0eIi/xHm3FcaxMyLK45+exP4Hlbg6lPV+RBagu2jYVQeH4K8PRPuRBaclLkZUjeiLzTAbUeXxd3AJIICkjyyJbwXVEDio2rA8fC5CHLZgxBOKlnajbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ye98eu2e; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ye98eu2e"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso765115a12.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785914013; x=1786518813; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=drHrC+qdqsi+PR/0lRsf/Ub+SUFkFlPx++QVFcFYlko=;
        b=Ye98eu2eSuTsH+pbTTSMZHNSNgwQOt8GTkGVTCVLOXtC1Xdv7q6r1NCEWST0EYZ1rq
         nUii7xZ1SJW+tKiCdEV0JQq7HSSTqD4yPb30QJfRD4A/7P38OzS5IdZXsh6iuepr+AYi
         0gbIOlScmZd3/FvXOo4Ug68CwgQHeye+nnRC7UKA9dkxResQcCjJF5crDOVuxmeuCfcR
         S2PezYWDzzhCfMcSy0dMUm4jsfnh820aslEkpAcbISjgoWfLd4R0rT5ZHzuueYO31gq8
         rd7rGhC+w8tAXq7NxRPXq4lIx036afCTqjmoT2Lt8lcDVfQumjsrr4DFXOBh+TZipC6w
         pl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914013; x=1786518813;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drHrC+qdqsi+PR/0lRsf/Ub+SUFkFlPx++QVFcFYlko=;
        b=D5MkY3/H4OMLYDva2DRMf741NqJF+77UhDIclM620XA6fuupLSNyJUiWsbdTTDxaP+
         YM6a3wK08dSXR+cvMfOsA1GiRJjP+BgXdUII19y1TRpONdaITWMYOPNAWQgi8kugDYKQ
         6C9VxU1qmy6VJNcOqY2+q6TbQ75EDtK+KIkGaoNGaIEUOXFPzOBE+Q75H1aTrgpDCMxP
         mX0EcJVoi/XbVVnqUX9SGnv3AZLQKyQ9gW5Wm9kuVTsbw0F1ZM9KsKdGujkOhtf7U32G
         K3u6nBwpxAyEdMeIiwX87UJLwJOhPzeCmdgew0+fOd0ep8+iUy4oBv4sxIIu49nOZ3jC
         GqZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/Dw+j6vZWX0TMac9uj0zm14fmxIdvzPYlWP92WqY3TZt45sNurT6chk8bUwwfIZL5Y1AhQ50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67QpCksUv7SvTS5dj+Fqr5MFs1v7sSRdcYZJ4nfapiFBxtFxL
	WOrhJJpgxW2iXal9swaSsV30H9SliWBEvWi5Bp22xIbVyEFJsrDHcxMp2lOhQjQii8g=
X-Gm-Gg: AR+sD1033bx3xeKW5wVtuWgSR0IEmD0vwbI4cgP4//RyD8BfMNC86hHGDgLo0imDjEY
	m+xjg/hZ+cFnKqwiv6GP4yTgZcgunkpMPfGsgg2Q/sx5Dy4d6W7yMNSbyZMAbQDOjaB5zusZlmG
	1/HIv3tfu8GoKmUzDusZIx5mdz5xTa2V1pEv+XpNdOws/rky8HKj6rgcF7gbmNrBTsH3vhQ/Myt
	p7HiNr8iHpCWd5Sb6EpYYcGdh/YDK+zTTINsPRmXCNJoJPnPl0G9M8i4WTPFnebITKpAtOeQXX5
	mr+COcQM7uIjb+ysi+Ouhv/k7nz82tEmG1sMR4USoO73pHG6R2BsA0oZMA0pahokQCqdjNltsn8
	TRjIn8v1+Y335lwTUcswG9cxPtBRB1DTeMq7u0zxt6r9dRjk9QmwwxHhnX0zvCRfC164FLVf7tO
	d9+9GrcL44nydRTEumvcQug73DZT2Kqnr6rRKA1n/dv364+nqliKjWFpfXbSwRchRzn7ggAySrl
	J+fN1NB+XpmQ30Vy/WYrC66ct/zAIBMp/uPKvdpNmkc4lOvNd3WTLmiLE7O8qaBzEeDsg6vDtmU
	QZvmkTvnO4kAzd3wSgMCWyXDTw==
X-Received: by 2002:a05:6402:1586:b0:6a0:a4be:6ed0 with SMTP id 4fb4d7f45d1cf-6a14f14c601mr2107256a12.17.1785914012808;
        Wed, 05 Aug 2026 00:13:32 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a145c49044sm1419460a12.9.2026.08.05.00.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 00:13:32 -0700 (PDT)
Message-ID: <931b763d-2ee6-4fbf-9222-c5b75f35ec47@suse.com>
Date: Wed, 5 Aug 2026 09:13:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: fix refcount leak in p9_xen_response() on wrong
 tag
To: Stefano Stabellini <sstabellini@kernel.org>,
 Yifei Gao <gyf161023@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260804213550.3409638-1-gyf161023@gmail.com>
 <ebcebd30-68e2-1650-f0e6-b69e4239619c@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
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
In-Reply-To: <ebcebd30-68e2-1650-f0e6-b69e4239619c@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8si6pc96wSFhwkSY5O2H0kme"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8si6pc96wSFhwkSY5O2H0kme
Content-Type: multipart/mixed; boundary="------------VvTq5HqiTdsegQZQBXC4lBJZ";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 Yifei Gao <gyf161023@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <931b763d-2ee6-4fbf-9222-c5b75f35ec47@suse.com>
Subject: Re: [PATCH] 9p/xen: fix refcount leak in p9_xen_response() on wrong
 tag
References: <20260804213550.3409638-1-gyf161023@gmail.com>
 <ebcebd30-68e2-1650-f0e6-b69e4239619c@kernel.org>
In-Reply-To: <ebcebd30-68e2-1650-f0e6-b69e4239619c@kernel.org>

--------------VvTq5HqiTdsegQZQBXC4lBJZ
Content-Type: multipart/mixed; boundary="------------292XJsm8x0UioVDewQdpX8cO"

--------------292XJsm8x0UioVDewQdpX8cO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDguMjYgMDI6MDYsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gVHVl
LCA0IEF1ZyAyMDI2LCBZaWZlaSBHYW8gd3JvdGU6DQo+PiBwOV94ZW5fcmVzcG9uc2UoKSBs
b29rcyB1cCB0aGUgcmVxdWVzdCBmb3IgYW4gaW5jb21pbmcgcmVwbHkgd2l0aA0KPj4gcDlf
dGFnX2xvb2t1cCgpLCB3aGljaCB0YWtlcyBhIHJlZmVyZW5jZSBvbiB0aGUgcmV0dXJuZWQg
cDlfcmVxX3QuIFdoZW4NCj4+IHRoZSB0YWcgZG9lcyBub3QgcmVzb2x2ZSB0byBhIHJlcXVl
c3QgaW4gUkVRX1NUQVRVU19TRU5ULCB0aGUgZnVuY3Rpb24NCj4+IHdhcm5zIGFuZCBjb250
aW51ZXMgdGhlIGxvb3Agd2l0aG91dCBkcm9wcGluZyB0aGF0IHJlZmVyZW5jZSwgcGVybWFu
ZW50bHkNCj4+IGxlYWtpbmcgdGhlIHA5X3JlcV90IGFuZCBpdHMgbXNpemUgYnVmZmVycy4g
VGhlIHJlcGx5IGhlYWRlciwgaW5jbHVkaW5nDQo+PiB0aGUgdGFnLCBpcyBzdXBwbGllZCBi
eSB0aGUgYmFja2VuZCwgc28gYSBtYWxpY2lvdXMgb3IgYnVnZ3kgOVAgYmFja2VuZA0KPj4g
Y2FuIGxlYWsga2VybmVsIG1lbW9yeSBvbiBldmVyeSBjcmFmdGVkIHJlc3BvbnNlLg0KPiAN
Cj4gTW9zdCBiYWNrZW5kIGFyZSB0cnVzdGVkLCBpbmNsdWRpbmcgdGhpcy4gU28gSSB3b3Vs
ZCBhdm9pZCAibWFsaWNpb3VzIi4NCg0KTm8sIEkgdGhpbmsgdGhpcyBpcyBmaW5lLg0KDQpF
c3BlY2lhbGx5IHdpdGggZHJpdmVyIGRvbWFpbnMgbWFsaWNpb3VzIGJhY2tlbmRzIGFyZSBh
IHRoaW5nLiBUaGV5IHNob3VsZA0Kb25seSBiZSBjYXBhYmxlIHRvIGRlbGl2ZXIgd3Jvbmcg
b3Igbm8gZGF0YSB0byB0aGUgZnJvbnRlbmQsIGJ1dCBpZGVhbGx5DQp0aGUgZnJvbnRlbmQg
c2hvdWxkIG5vdCB0cnVzdCB0aGUgYmFja2VuZC4NCg0KQW55IHdvcmsgdG93YXJkcyB0aGF0
IGdvYWwgaXMgdG8gYmUgc3VwcG9ydGVkIElNSE8sIGFuZCB0aGVyZSBhcmUgYWxyZWFkeQ0K
ZnJvbnRlbmRzIGxpc3RlZCBpbiBYZW4ncyBzdXBwb3J0IHN0YXRlbWVudCBmb2xsb3dpbmcg
dGhpcyBydWxlLCBzbyBhbnkNCnZpb2xhdGlvbiBvZiB0aGF0IHByaW5jaXBsZSBpbiB0aG9z
ZSBmcm9udGVuZHMgd2lsbCBiZSByZWdhcmRlZCB0byBiZSBhDQpzZWN1cml0eSBpc3N1ZSB3
b3J0aCBhbiBYU0EuDQoNCg0KSnVlcmdlbg0K
--------------292XJsm8x0UioVDewQdpX8cO
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------292XJsm8x0UioVDewQdpX8cO--

--------------VvTq5HqiTdsegQZQBXC4lBJZ--

--------------8si6pc96wSFhwkSY5O2H0kme
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpy4pwFAwAAAAAACgkQsN6d1ii/Ey+H
KggAg6nytSOOYq8z0ItP8CPzGV2WeFi552GEXsho0t5VEJrJrI24Ujyyy954xFTbzaXtOHsU8fTJ
+URN3WaLFrA8LEz0IzTnDjNdR4sXwJT0QVuBlCzSo/XOKzQXR1xnZVk6rfS2rTy6v0caigYk2MlX
yYU3nUCUsR3IQJYAIY7E6PEM9MGAr9Xk6Vhv8iJHk2twCq5cXqfwSTQowOtgCI9T0HQufnz1wy7Q
cbxZfpclY4ahGtES2b/+saK8J54DPMFr2cwKJ5svBREmlL6o9YO7LWASnFdo9d7MEcP+mWXRq0hl
ZXBWLiXuEZW643jzUprYwwrrojFXqrubr9OIRM+3wA==
=DfBT
-----END PGP SIGNATURE-----

--------------8si6pc96wSFhwkSY5O2H0kme--
