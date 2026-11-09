Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234862;
	b=tGU/lF/8Gi088FuTxDEaOcXzYHqqkZsXA97DIDWPyx7YjzWfk419pxw7kBKUf97WU8eR
	 K1woL0X5FLmrdF6UzZ6W+u/rGGe08ErsbZ2efAYqMJM8L0brkhMgTOpwdCm8jyBtiyr1g
	 CtRJ4Ccy6Ang5WvaVTZcaQjfU9S/AlqrMAdS4HSl6NV7ef6xVAGB80abH13DfnGqTPko3
	 jKmeSCuBi60JXK8SPQQnHPmWFCPNSfhBXs1qKrhwkNribTKjqQ0Igf2FzkR76Y0r0TjVq
	 svSI2UmASg+puziPmn8qg2bl/rGehdveDkzjOnPYbMNUT0YbL5Tr1PW7bzI7PRI4OIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234862;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=sbQeRA9CyuaW6m9In+TZM2sSG7ONA1E5yT6bD+DtiWs=;
	b=pAwBm6Wuxq5e1OuBAPEGqncQ+Hc5H4N7uRREbqz1IFUVDGddP3nBfunjX/po3C1VF+pV
	 CjCl7IIZBrGtclcQQ9Q0U1NyF97cuk5GugPgOsFE4n+fKoyZTjj5Gvow60HCSgIb/1pTZ
	 ikXeWYvLdMLG/HeJs/X2sPI9+hc4e4XW994zoEMNX5kIj7zO39jMmaRLeaYgPg/PDAvB8
	 8hKYQRVqv2w2onZFflcH0/jm/5jmRy5qLOWS438KcIhs0i0qqCfThFms4zLmmTY9rOSWW
	 cvVlUF56kg6wGZ0T1rM38f23V/hP8Dk5xWgxIBvOsCemNQkevg+gv2YZn1lofj4Qrew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=k+Pct609;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=k+Pct609;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A87606A323;
	Mon,  9 Nov 2026 14:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83A87606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=k+Pct609;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=k+Pct609
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A23FF1F7D3;
	Mon,  9 Nov 2026 14:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794234859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sbQeRA9CyuaW6m9In+TZM2sSG7ONA1E5yT6bD+DtiWs=;
	b=k+Pct609C3thKWd/TrGv4fpsQaihxAd1Cij5SQgzB7EEs73bvNTuCSXFQub6S/mYLNIaRS
	xm9NkjKcjgvmYCHIMdbL+wSh5X6mNBXdQf03IC303CPD+VaoyXQ14+zn5uCFvJkb1nJd4i
	d+blGkSZ8VeV01T0P6iFKhtLLxrYcF8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794234859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sbQeRA9CyuaW6m9In+TZM2sSG7ONA1E5yT6bD+DtiWs=;
	b=k+Pct609C3thKWd/TrGv4fpsQaihxAd1Cij5SQgzB7EEs73bvNTuCSXFQub6S/mYLNIaRS
	xm9NkjKcjgvmYCHIMdbL+wSh5X6mNBXdQf03IC303CPD+VaoyXQ14+zn5uCFvJkb1nJd4i
	d+blGkSZ8VeV01T0P6iFKhtLLxrYcF8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51F6B13302;
	Mon,  9 Nov 2026 14:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yZQpCuvZ8WpVbwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 09 Nov 2026 14:34:19 +0000
Message-ID: <70378f23-69f3-4bb0-885e-54c29daa6ddf@suse.com>
Date: Mon, 9 Nov 2026 15:34:18 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/privcmd: fix double free when an irqfd is shut down
 twice
To: Qihang <q.h.hack.winter@gmail.com>, xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261101163251.55099-1-q.h.hack.winter@gmail.com>
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
In-Reply-To: <20261101163251.55099-1-q.h.hack.winter@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------irHP4tZJaDGSfvWack0JzJWj"
X-Spamd-Result: default: False [-8.33 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	NEURAL_SPAM_LONG(3.46)[0.989];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.xenproject.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -8.33
X-Spam-Level: 
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------irHP4tZJaDGSfvWack0JzJWj
Content-Type: multipart/mixed; boundary="------------LJdOSRNSFiDYYnLxyVj8lk7L";
 protected-headers="v1"; hp="clear"
Message-ID: <70378f23-69f3-4bb0-885e-54c29daa6ddf@suse.com>
Date: Mon, 9 Nov 2026 15:34:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/privcmd: fix double free when an irqfd is shut down
 twice
To: Qihang <q.h.hack.winter@gmail.com>, xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261101163251.55099-1-q.h.hack.winter@gmail.com>
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
In-Reply-To: <20261101163251.55099-1-q.h.hack.winter@gmail.com>

--------------LJdOSRNSFiDYYnLxyVj8lk7L
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMTEuMjYgMTc6MzIsIFFpaGFuZyB3cm90ZToNCj4gaXJxZmRfZGVhY3RpdmF0ZSgp
IHRha2VzIHRoZSBpcnFmZCBvZmYgaXJxZmRzX2xpc3QgYW5kIHF1ZXVlcw0KPiBpcnFmZF9z
aHV0ZG93bigpLiAgcXVldWVfd29yaygpIGlzIG5vdCBhIG9uY2Utb25seSBnYXRlOiBpdCBy
ZWZ1c2VzIHRvDQo+IGVucXVldWUgYSB3b3JrIGl0ZW0gb25seSB3aGlsZSBXT1JLX1NUUlVD
VF9QRU5ESU5HIGlzIHNldCwgYW5kDQo+IHByb2Nlc3Nfb25lX3dvcmsoKSBjbGVhcnMgdGhh
dCBiaXQgYmVmb3JlIGl0IGNhbGxzIHRoZSB3b3JrIGZ1bmN0aW9uLiAgU28NCj4gbm90aGlu
ZyByZWNvcmRzIHRoYXQgdGhlIHNodXRkb3duIHdvcmsgaGFzIGFscmVhZHkgYmVlbiBxdWV1
ZWQsIGFuZA0KPiBub3RoaW5nIHByb3RlY3RzIHRoZSB3aW5kb3cgYmV0d2VlbiB0aGUgc3Rh
cnQgb2YgaXJxZmRfc2h1dGRvd24oKSBhbmQgdGhlDQo+IGtmcmVlKCkgYXQgaXRzIGVuZC4N
Cj4gDQo+IFR3byBwYXRocyBjYWxsIGlycWZkX2RlYWN0aXZhdGUoKSBmb3IgdGhlIHNhbWUg
aXJxZmQ6DQo+IA0KPiAgICAtIHByaXZjbWRfaXJxZmRfZGVhc3NpZ24oKSwgZnJvbSB0aGUg
UFJJVkNNRF9JUlFGRF9GTEFHX0RFQVNTSUdOIGlvY3RsOw0KPiANCj4gICAgLSBpcnFmZF93
YWtldXAoKSwgd2l0aCBFUE9MTEhVUCBzZXQsIHdoZW4gdGhlIGxhc3QgcmVmZXJlbmNlIHRv
IHRoZQ0KPiAgICAgIGV2ZW50ZmQgZmlsZSBnb2VzIGF3YXksIHdoaWNoIHJ1bnMgd2FrZV91
cF9wb2xsKCZjdHgtPndxaCwgRVBPTExIVVApDQo+ICAgICAgZnJvbSBldmVudGZkX3JlbGVh
c2UoKS4NCj4gDQo+IGlycWZkc19sb2NrIHNlcmlhbGlzZXMgdGhlIHR3byBjYWxscywgYnV0
IGl0IGRvZXMgbm90IG1ha2UgdGhlIHNlY29uZCBvbmUNCj4gYSBuby1vcCwgYW5kIGV2ZW50
ZmRfY3R4X2ZkZ2V0KCkgdGFrZXMgYSByZWZlcmVuY2UgdG8gdGhlIGV2ZW50ZmRfY3R4LA0K
PiBub3QgdG8gdGhlIHN0cnVjdCBmaWxlLCBzbyB0aGUgbGFzdCBmZCBjYW4gc3RpbGwgYmUg
Y2xvc2VkIHdoaWxlIHRoZQ0KPiBpb2N0bCBpcyBydW5uaW5nOg0KPiANCj4gICAgQ1BVMCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVTENCj4gDQo+ICAgIGV2ZW50ZmRf
Y3R4X2ZkZ2V0KCkNCj4gICAgc3Bpbl9sb2NrKGlycWZkc19sb2NrKQ0KPiAgICBsaXN0X2Rl
bF9pbml0KCZraXJxZmQtPmxpc3QpDQo+ICAgIHF1ZXVlX3dvcmsoJmtpcnFmZC0+c2h1dGRv
d24pICAgICAgICBjbG9zZShmZCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZXZlbnRmZF9yZWxlYXNlKCkNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB3YWtlX3VwX3BvbGwoRVBPTExIVVApDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlycWZkX3dha2V1cCgpDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jayhp
cnFmZHNfbG9jaykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaXJxZmRfZGVhY3RpdmF0ZSgpIGFnYWluDQo+IA0KPiBJZiB0aGUgd29yayBpdGVtIGhh
cyBhbHJlYWR5IHN0YXJ0ZWQgYnkgdGhlbiwgaXRzIHBlbmRpbmcgYml0IGhhcyBiZWVuDQo+
IGNsZWFyZWQgYW5kIHRoZSBzZWNvbmQgcXVldWVfd29yaygpIHN1Y2NlZWRzLiAgaXJxZmRf
c2h1dGRvd24oKSB0aGVuIHJ1bnMNCj4gdHdpY2UsIHNvIGV2ZW50ZmRfY3R4X3JlbW92ZV93
YWl0X3F1ZXVlKCksIGV2ZW50ZmRfY3R4X3B1dCgpIGFuZCBrZnJlZSgpDQo+IGVhY2ggaGl0
IHRoZSBzYW1lIG9iamVjdCBhIHNlY29uZCB0aW1lOyBhbmQgd2hlbiB0aGUgc2Vjb25kIHF1
ZXVlX3dvcmsoKQ0KPiBsYW5kcyBhZnRlciB0aGUgaXJxZmQgaGFzIGJlZW4gZnJlZWQsIHRo
ZSB3b3JrcXVldWUgbGlzdCBvcGVyYXRpb25zIHdyaXRlDQo+IHRvIGZyZWVkIG1lbW9yeS4N
Cj4gDQo+IHZpcnQva3ZtL2V2ZW50ZmQuYyBoYXMgdGhlIHNhbWUgdHdvIGNhbGxlcnMgYW5k
IGhhcyBoYWQgdGhpcyBndWFyZCBzaW5jZQ0KPiB0aGUgb3JpZ2luYWwgaXJxZmQgc3VwcG9y
dCAoNzIxZWVjYmY0ZmU5OSk6IGlycWZkX3dha2V1cCgpIGNhbGxzDQo+IGlycWZkX2RlYWN0
aXZhdGUoKSBvbmx5IGlmIGlycWZkX2lzX2FjdGl2ZSgpLiAgVGhlIGNvbW1lbnQgdGhlcmUg
ZXhwbGFpbnMNCj4gd2h5IHRoYXQgaXMgZW5vdWdoOiB0aGUgb3RoZXIgc2lkZSBkZWFjdGl2
YXRlcyB0aGUgaXJxZmQgYmVmb3JlIGl0IHRha2VzDQo+IGl0IG9mZiB0aGUgd2FpdHF1ZXVl
LCBhbmQgaXJxZmRfc2h1dGRvd24oKSBuZWVkcyB0aGUgd2FpdHF1ZXVlIGxvY2ssDQo+IHdo
aWNoIHRoaXMgY2FsbGJhY2sgaG9sZHMsIHNvIHRoZSBpcnFmZCBjYW5ub3QgYmUgZnJlZWQg
dW5kZXIgaXQuDQo+IA0KPiBEbyB0aGUgc2FtZSBoZXJlLiAgbGlzdF9kZWxfaW5pdCgpIGxl
YXZlcyB0aGUgbGlzdCBoZWFkIGVtcHR5IGFuZCB0aGUNCj4gaXJxZmQgc3RheXMgb2ZmIHRo
ZSBsaXN0IHVudGlsIGtmcmVlKCksIHNvIGl0IHNlcnZlcyBhcyBhIG9uZS13YXkNCj4gImFj
dGl2ZSIgZmxhZy4gIFRoZSB0ZXN0IGlzIGluIGlycWZkX2RlYWN0aXZhdGUoKSByYXRoZXIg
dGhhbiBpbg0KPiBpcnFmZF93YWtldXAoKSBiZWNhdXNlIHByaXZjbWRfaXJxZmRfZGVhc3Np
Z24oKSB3YWxrcyBpcnFmZHNfbGlzdCBhbmQgY2FuDQo+IHRoZXJlZm9yZSBuZXZlciByZWFj
aCBhbiBpbmFjdGl2ZSBpcnFmZDsgb25seSB0aGUgd2FrZXVwIHBhdGggY2FuLCBhbmQgYQ0K
PiBzaW5nbGUgdGVzdCBjb3ZlcnMgYm90aCBjYWxsZXJzLg0KPiANCj4gRml4ZXM6IGY4OTQx
ZTZjNGM3MTIgKCJ4ZW46IHByaXZjbWQ6IEFkZCBzdXBwb3J0IGZvciBpcnFmZCIpDQo+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFFpaGFuZyA8cS5o
LmhhY2sud2ludGVyQGdtYWlsLmNvbT4NClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxq
Z3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K

--------------LJdOSRNSFiDYYnLxyVj8lk7L--

--------------irHP4tZJaDGSfvWack0JzJWj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmrx2eoFAwAAAAAACgkQsN6d1ii/Ey9l
Owf9FQNftOSZW39cuV9bYiEP5AmoSV//5Nkl6+r6jVT3XLCjqeoWLU156ftxZf/byLZ14sw3Spvc
n/wFPPXrVNoJ/a/W/Mr5X7POz7T51t4hbVQkeoXNwuYVO7Gz0s58WMpMvTUadhl5lDMEX+8ZaWst
icXUYy/yVUNwpJbwdT42c3Wxfli2S3NDT2XwJMTTxPoaBxh/7C0cLt691QohbzHwYMsu2HEhJdWa
oLoyb13btCEoORLJLaZNK4ZP/4YwIaYZ+Ede4eAquCGzPELJiBfMCUJSA27loSwS+3AWL+huF2O3
PEEmw47nxrfvYrsRG43UVEoXoaPMKxwllJcMrVv6Kw==
=mh3Z
-----END PGP SIGNATURE-----

--------------irHP4tZJaDGSfvWack0JzJWj--
