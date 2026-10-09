Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553053BB134;
	Fri,  9 Oct 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533750; cv=none; b=UDXvTW0h/bzbZ0VxQZ5L1HOReQyUDcfm+EshH6uCt1OPTcUuHcCloDPVCE8mskylaXNFhNT+nqVwFpyMVu7zFzOj9cUwatrNY8IKrRrC1UEYCiioUq9ipn8jmxlGTFHHEz1sWyUMqjas0ZYWylOBjIRCkoVq/Gvm4+Z7OJBLWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533750; c=relaxed/simple;
	bh=fwhjDRhQYUnsMM4tQfaTafENvxUzunf/We8G83mgylA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqRIIjxT5poLW2TGfUZVRgcz7t/rsl+pLBiAz9+P84eVwGYR3C4FjD6KwfwIlmq4Z9pMJHzjWz9tA/8mq4nH0YUYX0zX+Bifvb5PDN+PljIXmgLAijPT7TR7RlF2CgaMzjyeAzfswMCoOYBumEVc4jnjyKrzxByke6UWalu7poI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC3CB21BCB;
	Fri,  9 Oct 2026 08:15:41 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9337C1368B;
	Fri,  9 Oct 2026 08:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FAvRGq2iyGpKDQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 09 Oct 2026 08:15:41 +0000
Message-ID: <8054e545-149d-48cc-9e2d-5a3cd3bd662d@suse.com>
Date: Fri, 9 Oct 2026 10:15:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/gntdev: Fix gntdev_dmabuf ref leak in
 dmabuf_exp_wait_released()
To: Wentao Liang <vulab@iscas.ac.cn>, boris.ostrovsky@oracle.com
Cc: linux-kernel@vger.kernel.org, oleksandr_andrushchenko@epam.com,
 oleksandr_tyshchenko@epam.com, sstabellini@kernel.org,
 xen-devel@lists.xenproject.org, stable@vger.kernel.org
References: <20260916170956.2086505-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20260916170956.2086505-1-vulab@iscas.ac.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5XtmSpn2jOOlI7yHrMJeTWOH"
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Bar: /
X-Rspamd-Queue-Id: EC3CB21BCB
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.00 / 50.00]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5XtmSpn2jOOlI7yHrMJeTWOH
Content-Type: multipart/mixed; boundary="------------5DJvWL8YxTJ1TDGiVkey8XYO";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Wentao Liang <vulab@iscas.ac.cn>, boris.ostrovsky@oracle.com
Cc: linux-kernel@vger.kernel.org, oleksandr_andrushchenko@epam.com,
 oleksandr_tyshchenko@epam.com, sstabellini@kernel.org,
 xen-devel@lists.xenproject.org, stable@vger.kernel.org
Message-ID: <8054e545-149d-48cc-9e2d-5a3cd3bd662d@suse.com>
Subject: Re: [PATCH] xen/gntdev: Fix gntdev_dmabuf ref leak in
 dmabuf_exp_wait_released()
References: <20260916170956.2086505-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916170956.2086505-1-vulab@iscas.ac.cn>

--------------5DJvWL8YxTJ1TDGiVkey8XYO
Content-Type: multipart/mixed; boundary="------------507C04RoOaZQOEvNpTLFrDSZ"

--------------507C04RoOaZQOEvNpTLFrDSZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDkuMjYgMTk6MDksIFdlbnRhbyBMaWFuZyB3cm90ZToNCj4gZG1hYnVmX2V4cF93
YWl0X3JlbGVhc2VkKCkgdGFrZXMgYSByZWZlcmVuY2Ugb24gdGhlIGV4cG9ydGVkDQo+IGdu
dGRldl9kbWFidWYgd2l0aCBkbWFidWZfZXhwX3dhaXRfb2JqX2dldF9kbWFidWYoKSBhbmQg
cGFzc2VzIGl0IHRvDQo+IGRtYWJ1Zl9leHBfd2FpdF9vYmpfbmV3KCksIHdoaWNoIGRyb3Bz
IHRoYXQgcmVmZXJlbmNlIGFmdGVyIGFkZGluZyB0aGUNCj4gd2FpdCBvYmplY3QgdG8gdGhl
IHdhaXQgbGlzdC4gIFdoZW4gdGhlIHdhaXQgb2JqZWN0IGFsbG9jYXRpb24gZmFpbHMsDQo+
IGRtYWJ1Zl9leHBfd2FpdF9vYmpfbmV3KCkgcmV0dXJucyBFUlJfUFRSKC1FTk9NRU0pIGVh
cmx5IGFuZCB0aGUNCj4gcmVmZXJlbmNlIGlzIG5ldmVyIGRyb3BwZWQsIGxlYWtpbmcgYSBy
ZWZlcmVuY2UgdG8gdGhlIGV4cG9ydGVkDQo+IGdudGRldl9kbWFidWYuDQo+IA0KPiBEcm9w
IHRoZSByZWZlcmVuY2Ugb24gdGhlIGFsbG9jYXRpb24gZmFpbHVyZSBwYXRoIHNvIHRoZSBy
ZWZlcmVuY2UgaXMNCj4gY29uc3VtZWQgd2hldGhlciB0aGUgd2FpdCBvYmplY3QgaXMgY3Jl
YXRlZCBvciBub3QuDQo+IA0KPiBGaXhlczogOTMyZDY1NjIxNzllICgieGVuL2dudGRldjog
QWRkIGluaXRpYWwgc3VwcG9ydCBmb3IgZG1hLWJ1ZiBVQVBJIikNCj4gQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogV2VudGFvIExpYW5nIDx2dWxhYkBp
c2Nhcy5hYy5jbj4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNl
LmNvbT4NCg0KDQpKdWVyZ2VuDQo=
--------------507C04RoOaZQOEvNpTLFrDSZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------507C04RoOaZQOEvNpTLFrDSZ--

--------------5DJvWL8YxTJ1TDGiVkey8XYO--

--------------5XtmSpn2jOOlI7yHrMJeTWOH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmrIoq0FAwAAAAAACgkQsN6d1ii/Ey+q
igf9G0if6s4i2ivYNbf5VuMGEvy4KfsBLLasJmNuKmY1TLEJoSWrQyqnsJ9zu5RLQgJM1QQK2U6B
ATXzaYtr5VoStTT+RNEEI/q1p5yjNLMJAXRfmDNZaOI4E9XG8LCL6m6ssSzdbgjRkvxClpk7I4hi
BK8XyGxw3t00NWkmbKsSt/ZBsPSlZbdg8/8pLUgLp6TT32JtJlpNZI18scIa3X9DUZ2wzAAGnu7v
6LeRyvAYWbl0xRw8LAenftphL4FbHeLC9AtIHXHZ0qc/7ww8kBeB0VWo0veYP8dH7SUIWw0PabFk
aEeypY4E6F+9KGQ4XSZIImrvSu9PfBLNTAKBahsQmA==
=xLsP
-----END PGP SIGNATURE-----

--------------5XtmSpn2jOOlI7yHrMJeTWOH--
