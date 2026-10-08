Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF0412BF8;
	Thu,  8 Oct 2026 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459612; cv=none; b=ROUiiQWgOXP5T+be3E1BeaqzBH6OmPNERW9lulSN9yCu8VuW+/WQ00eXzP/vPs2lIvnMGJmPUT3rWrl74J2zJZkTPUlD4xjSnRcvHlvn76rn/hUoxzEQvLeqkwJhEL3CncvFVoyAzOqAYh1vuNNUbwcXCCUlWdw+mKkAtdXjBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459612; c=relaxed/simple;
	bh=+aXmEO1w3V4VZ55yTGF6zej6634uFQcGRm2czAc8pb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5QDn2jG8KTOjQD3izEa8q1ZHRhT8pDjQQaKcktx9w7aTiiUxxGJ6NLKjRRzO2wok/2kioKCnXteGb+DH0x0Dw3mxx3oqek7Kd4e9rvx91ZSHrzoFPpVL14QYwcXLEAGQNUwncFLvnSLL6/LJKYrQzQ3T4mXyD46mnWpuU3LE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9AA61F441;
	Thu,  8 Oct 2026 11:40:08 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5757213354;
	Thu,  8 Oct 2026 11:40:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uhdvCxiBx2opDwAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 08 Oct 2026 11:40:08 +0000
Message-ID: <bd207068-5674-4ffa-aa34-57b07b2bcffa@suse.com>
Date: Thu, 8 Oct 2026 13:40:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] 9p/xen: validate the response size from the backend
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261005125640.274054-1-yhlee@isslab.korea.ac.kr>
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
In-Reply-To: <20261005125640.274054-1-yhlee@isslab.korea.ac.kr>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NKrglBsC0aAZ6c1B0MVJWGg1"
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [0.00 / 50.00]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: B9AA61F441
X-Spam-Flag: NO
X-Spam-Score: 0.00
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NKrglBsC0aAZ6c1B0MVJWGg1
Content-Type: multipart/mixed; boundary="------------zqUPvcSS6vhyB85GtT2GhYD3";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Message-ID: <bd207068-5674-4ffa-aa34-57b07b2bcffa@suse.com>
Subject: Re: [PATCH v2] 9p/xen: validate the response size from the backend
References: <20261005125640.274054-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20261005125640.274054-1-yhlee@isslab.korea.ac.kr>

--------------zqUPvcSS6vhyB85GtT2GhYD3
Content-Type: multipart/mixed; boundary="------------hL1VfzHEAdLrx4MoPokcJqMG"

--------------hL1VfzHEAdLrx4MoPokcJqMG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMTAuMjYgMTQ6NTYsIFllaHllb25nIExlZSB3cm90ZToNCj4gcDlfeGVuX3Jlc3Bv
bnNlKCkgdGFrZXMgdGhlIGxlbmd0aCBvZiBhbiBpbmNvbWluZyByZXNwb25zZSBmcm9tIHRo
ZSByaW5nDQo+IC0tIHRoZSBmaXJzdCBmaWVsZCBvZiB0aGUgOXAgaGVhZGVyLCB3aGljaCB0
aGUgWGVuIHRyYW5zcG9ydCByZXVzZXMgYXMNCj4gaXRzIGZyYW1pbmcgaGVhZGVyIC0tIGFu
ZCB1c2VzIGl0IHRvIGFkdmFuY2UgdGhlIGNvbnN1bWVyIGluZGV4LCBidXQNCj4gbmV2ZXIg
Y2hlY2tzIHRoYXQgaXQgaXMgYXQgbGVhc3QgdGhlIGhlYWRlciBzaXplIG9yIG5vIGxhcmdl
ciB0aGFuIHRoZQ0KPiBudW1iZXIgb2YgYnl0ZXMgdGhlIGJhY2tlbmQgaGFzIGFjdHVhbGx5
IHByb2R1Y2VkLg0KPiANCj4gQSBtYWxpY2lvdXMgb3IgYnVnZ3kgYmFja2VuZCBjYW4gcG9z
dCBhIHJlc3BvbnNlIHdob3NlIHNpemUgaXMgc21hbGxlcg0KPiB0aGFuIHRoZSBoZWFkZXIg
KGZvciBleGFtcGxlIDApLiBUaGUgY29uc3VtZXIgaW5kZXggdGhlbiBuZXZlciBhZHZhbmNl
cywNCj4gc28gdGhlIHJlc3BvbnNlIHdvcmsgcmUtcmVhZHMgdGhlIHNhbWUgcmluZyBjb250
ZW50cyBpbnN0ZWFkIG9mIG1ha2luZw0KPiBwcm9ncmVzcy4gSW4gdGVzdGluZyB0aGlzIHJh
Y2VkIHdpdGggdGhlIHRlYXJkb3duIHRoYXQgdGhlIG1hbGZvcm1lZA0KPiByZXBseSB0cmln
Z2VycyBhbmQgZGVyZWZlcmVuY2VkIGEgZnJlZWQgcDlfY2xpZW50Og0KPiANCj4gICAgOXBm
cyA5cGZzLTA6IFdyb25nIHJlcSB0YWc9ZmZmZg0KPiAgICBCVUc6IGtlcm5lbCBOVUxMIHBv
aW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwNjANCj4gICAgI1BG
OiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQo+ICAgICNQRjogZXJy
b3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQ0KPiAgICBQR0QgMCBQNEQgMA0K
PiAgICBPb3BzOiBPb3BzOiAwMDAwIFsjMV0gU01QIE5PUFRJDQo+ICAgIENQVTogMCBVSUQ6
IDAgUElEOiAxMSBDb21tOiBrd29ya2VyLzA6MSBOb3QgdGFpbnRlZCA3LjIuMC1yYzUgIzYg
UFJFRU1QVChsYXp5KQ0KPiAgICBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChR
MzUgKyBJQ0g5LCAyMDA5KSwgQklPUyByZWwtMS4xNy4wLTAtZ2I1MmNhODZlMDk0ZC1wcmVi
dWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0DQo+ICAgIFdvcmtxdWV1ZTogZXZlbnRzIHA5X3hl
bl9yZXNwb25zZQ0KPiAgICBSSVA6IDAwMTA6aWRyX2ZpbmQrMHg0LzB4MTANCj4gICAgUlNQ
OiAwMDE4OmZmZmZiZjVkODAwNjNkZTggRUZMQUdTOiAwMDAxMDIwMg0KPiAgICBSQVg6IDAw
MDAwMDAwMDAwMDAwMDEgUkJYOiBmZmZmYTIyOWMyMTE5NWEwIFJDWDogZmZmZmEyMjljMjQw
MDAwMA0KPiAgICBSRFg6IGZmZmZhMjI5YzExYzIyMDAgUlNJOiAwMDAwMDAwMDAwMDBmZmZm
IFJESTogMDAwMDAwMDAwMDAwMDA1MA0KPiAgICBSQlA6IDAwMDAwMDAwMDAwMGZmZmYgUjA4
OiAzZmZmZmZmZmZmZmZkZmZmIFIwOTogZmZmZmZmZmZmZmZmZmZmZg0KPiAgICBSMTA6IDNm
ZmZmZmZmZmZmZmRmZmYgUjExOiBmZmZmZmZmZjg3YTYwZTgwIFIxMjogMDAwMDAwMDAwMDAw
MDA1MA0KPiAgICBSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiAwMDAwMDAwMDAwMDBmZmZm
IFIxNTogMDAwMDAwMDAwMDEwMDAwMA0KPiAgICBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAw
MCkgR1M6ZmZmZmEyMmE3NjYxYzAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+
ICAgIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMN
Cj4gICAgQ1IyOiAwMDAwMDAwMDAwMDAwMDYwIENSMzogMDAwMDAwMDAzYWMzNDAwMiBDUjQ6
IDAwMDAwMDAwMDA3NzBlZjANCj4gICAgUEtSVTogNTU1NTU1NTQNCj4gICAgQ2FsbCBUcmFj
ZToNCj4gICAgIDxUQVNLPg0KPiAgICAgcDlfdGFnX2xvb2t1cCsweDJiLzB4OTANCj4gICAg
IHA5X3hlbl9yZXNwb25zZSsweDE3Yy8weDJlMA0KPiAgICAgcHJvY2Vzc19vbmVfd29yaysw
eDE2YS8weDNhMA0KPiAgICAgd29ya2VyX3RocmVhZCsweDE3Mi8weDJlMA0KPiAgICAga3Ro
cmVhZCsweGRkLzB4MTEwDQo+ICAgICByZXRfZnJvbV9mb3JrKzB4MThiLzB4MjQwDQo+ICAg
ICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gICAgIDwvVEFTSz4NCj4gICAgTW9k
dWxlcyBsaW5rZWQgaW46DQo+ICAgIENSMjogMDAwMDAwMDAwMDAwMDA2MA0KPiAgICAtLS1b
IGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCj4gDQo+IFJlamVjdCBhIHJlc3Bv
bnNlIHdob3NlIHNpemUgaXMgb3V0c2lkZSBbc2l6ZW9mKGhlYWRlciksIHF1ZXVlZF0gYmVm
b3JlDQo+IHVzaW5nIGl0LCBtYXRjaGluZyB0aGUgdmFsaWRhdGlvbiB0aGUgYmFja2VuZCBh
bHJlYWR5IGFwcGxpZXMgdG8NCj4gaW5jb21pbmcgcmVxdWVzdHMuDQo+IA0KPiBGaXhlczog
ZjY2YzcyYmVhMTI5ICgieGVuLzlwZnM6IHJlY2VpdmUgcmVzcG9uc2VzIikNCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogWWVoeWVvbmcgTGVlIDx5
aGxlZUBpc3NsYWIua29yZWEuYWMua3I+DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3Nz
IDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------hL1VfzHEAdLrx4MoPokcJqMG
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------hL1VfzHEAdLrx4MoPokcJqMG--

--------------zqUPvcSS6vhyB85GtT2GhYD3--

--------------NKrglBsC0aAZ6c1B0MVJWGg1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmrHgRcFAwAAAAAACgkQsN6d1ii/Ey/t
EAf/XBgankpH8qdLe8DgGf39b5ab+6BzYx5OlXWAf8qxotpqE9e8mcqZ9+Q/kldR5v3DsXJZwIO8
JNT16WHOXpNnvHRulFkWQfNXoFXsN8HnkAy05C+11iddrrEOgiPvjcXKo0d/S+Xz4xvEB0084E3a
/1BamP/5Ql87UZfvZhDrn9+eOSYtj/LL9fbrb8qCxNOj25dLi3Fge1POkw8mT2odf4Qn/7Stcdrz
grlX0Mm6ZPlPu2FIOd8VjccFFa/vrxI01OG9bx5P7MhHOmbBHMjymDaGeay4V2/HoNC9oS/qLcI4
9sqv7vG4qFr189kLr7TRDzXeGqbjI3inIFz1DrzGsA==
=d1PV
-----END PGP SIGNATURE-----

--------------NKrglBsC0aAZ6c1B0MVJWGg1--
